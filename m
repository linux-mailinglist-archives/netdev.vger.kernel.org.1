Return-Path: <netdev+bounces-70629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD9084FD88
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5557B2838BE
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE086126;
	Fri,  9 Feb 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EySJEldr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86454F86
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510321; cv=none; b=cb9EDCOppG3yHzT02VN7hKO3nC/Yzvb20bPFdBQvVlthKzbCAXBXaZRfkK3T2qvkRj7jkWfjBsm/+2wKJ+WfrXk+O8FGVxIwXe6BoPHacIR9AVR9v/ZcU/exN3m6vN3ip/vj6gZ7phRbbtuEx3SyARfR1fyDxNIyJVWWlyOSTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510321; c=relaxed/simple;
	bh=IcGgyIdQEelKLcXodFMWIwvGTqaHiaXh1N2bZxHZavo=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgkAMEcHJnUzISvnvrmT6vRIlaOUBfIi+8jBfgV9Gj/cz+UFfgqP+qPHzqr9FEp5v3j23LpA7jmlmqGVD9jL8dM8avD2Y2jIY/oRYoNen+ozOWfH3/73seiDx8nB7ht1ayQZx8fLiK8PvNmBdMx/TmusHhDaggypxP13c213l08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EySJEldr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707510318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcGgyIdQEelKLcXodFMWIwvGTqaHiaXh1N2bZxHZavo=;
	b=EySJEldrZRhXgYr8wvZnqxHCxiYhww/nu1imgTOXNgT/nj0+r8woNiWBesGK9kXp/eWh2o
	svDM5auLJH1+1W0AATm1MjxDC15F8EpaV7a8u43quk4P1lu+qJaibuTgSns9Iz99hQq6oX
	yWgJ4b4aaiLXyZzjrwhYNjn6Te9VrLY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-YuyW9c7ZMCK8g5yGKzP86A-1; Fri, 09 Feb 2024 15:25:15 -0500
X-MC-Unique: YuyW9c7ZMCK8g5yGKzP86A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5600db7aa23so861354a12.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510314; x=1708115114;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcGgyIdQEelKLcXodFMWIwvGTqaHiaXh1N2bZxHZavo=;
        b=D5nFu0LILxqK6eHftQnljLtWcnXbVlbwMyJcPOIBIyuvNQykmYxndrXTtqk+g3ifF9
         SYDZ33bs9lMtZybFz5SZQdKp1ml8omaWgcFTFwMAWTGZFHDiJqQisl5YbFnGIHs0g+rx
         ndT/Irg2bELDM/v16D9btcCuWNKoGkZez6BZUQRJziiRNVu5adgQYUumWXoAcsT+NBz4
         n8QYpk1W/fV7061cIQJyuTUhDIafhArKKtcSd5N1d8dNjjYgL6UuZaHo6EsgSU84a5Ot
         z3DVbyxNvZsoty7ANCyBmOsSQAZVTqFUDViFY741J+ty7mGLOOHhI3nWtCkxdHXl1xDu
         Y7yQ==
X-Gm-Message-State: AOJu0YyL2NkTVh9DyRDqHZYAFUFKE5jc95I0GpP5LSTW59WfKuRTJg+y
	4pNArxrkZC37Sc4ySup2Ybjj9N8HrVMvi2Y/Q9D5e8JfS+/BgUJxUA4PIhCwkr7EfE+ZsOfkVap
	9hJq2Snj0G9WfOU+KzbKWmsdZNDDYRHMrks2KOt6ixYJJ91KVOoYgu5nlb5+TYJMiSKrisfyUeA
	l8W4xMKKNMu46Bnks4k4+oDTs0xsAU
X-Received: by 2002:aa7:cf89:0:b0:560:7f1:9b26 with SMTP id z9-20020aa7cf89000000b0056007f19b26mr26211edx.10.1707510314750;
        Fri, 09 Feb 2024 12:25:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZvU8kZLkqDzPpSEbApy6DRu6ME5EkBs/zv2sq4MfTYlsaOvTztjes67sC3vTsO85STA7SKmx1xJTxwtP/KgQ=
X-Received: by 2002:aa7:cf89:0:b0:560:7f1:9b26 with SMTP id
 z9-20020aa7cf89000000b0056007f19b26mr26205edx.10.1707510314490; Fri, 09 Feb
 2024 12:25:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Feb 2024 12:25:13 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-8-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-8-jhs@mojatatu.com>
Date: Fri, 9 Feb 2024 12:25:13 -0800
Message-ID: <CALnP8ZaxqvV9nbWkMEjk8MhwauUBwBOWNo0jjKXLfv0S9A=4kw@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 07/15] p4tc: add template API
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:53PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


