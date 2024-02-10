Return-Path: <netdev+bounces-70764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F608504C5
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 15:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DE11F22222
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821545BAC4;
	Sat, 10 Feb 2024 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV6VPusQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAF55B67D
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575898; cv=none; b=k4gSV031aBBmD3e2NqliUmH6yK7KYID+7AFuaR+0791IU4FCg4Qhzr9urM7imsigW1s5LUjrfwBjNnViiygmvy3jrr35qcvm5H5JnMhXZLzeMLE7WRxhX3zRqeVhgSQlkFJ+xy05Dcztr6PStL3BlWojuBiRs0nhV7MZIKeJNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575898; c=relaxed/simple;
	bh=8KivXXELJEuxJ/VXJGLoFocpm/IMxD+P2YBpOFJi1/k=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LH55/qQrKE4IbV9jqFkQirZaF/SAckpWpwg2+0G/DQJpzsNO4vgsDn5EO8H+JXXDm5fo6DDN2mP7neC36TkkO5fEIyC2wRrTjM7KebD/T069YYCI3ZfLyuN+mFbnc8U+TEWyeWWp009fwQ+Ut0wSRrg/JSxQnskLyJj9QVlMb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV6VPusQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707575893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KivXXELJEuxJ/VXJGLoFocpm/IMxD+P2YBpOFJi1/k=;
	b=LV6VPusQWkXxFC8F0ZZwhPHsvKo5kZsql9CwqVkkzvpgmazhN/Vus8FTmRZZiB+4zVDFqe
	gLGdIeSan2610iNzWmkkHkcLN5TMfxuhoKxuQdsAj/VzC2afdWfGxfQyzkldO4pYKlfdBV
	JGsjtscooKuMZvbGAUcAY9zvlK7VMlw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-eebe5GMHMc6MbqPys0k77g-1; Sat, 10 Feb 2024 09:38:11 -0500
X-MC-Unique: eebe5GMHMc6MbqPys0k77g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5597d3e0aa3so1392504a12.0
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 06:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707575891; x=1708180691;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KivXXELJEuxJ/VXJGLoFocpm/IMxD+P2YBpOFJi1/k=;
        b=NqSuFfBwASlaKDdCjDhfn5ldOlbsOslDZvdbbPljJPNLCqMbrxX0pJyTe7I5z9o1Sl
         9mYN3tFX//xb2f86tFX/LczhG9s/N+vbgumeuKGShC7IQq+D3wimRslcximlxn9Ss0MY
         wMGX5gO0RXMKDmIQCo+cIqmGdYpO5pmbvPfyV7p5F5q3tl05vBmBwKTtZVTvevEEX7Yt
         CjbQ1cRP2auF/iWWtViMSmsKk7614cmKDdkA3Gngx2fp44ccnLyXVUglD3DsUPdmHv/J
         F/kJnUmdkPVDKAZjxytJDBXdk7mL4S5Rl6F5qZ910BPOzZBo1qeUcl7WXqgEUCaQYzu1
         nRnQ==
X-Gm-Message-State: AOJu0Yx2l1iNKRq5CUvcEKF8lBxUa3I4cOi7NqKh9ydfGiSffq1U7a3N
	OWVoHmRDf6Er+MTSEjHr5HxGROnnRl4x3amfsLSfp7I0PlN/v/N/pImTstAA9LkqnYjIGIesaeZ
	QI+mSn5g0aLXr9HZkWRVMZLkmoMjymOBYNcBr+CR9iatC2jFLP42rOGFXwVw1jWFTZRknlO13mr
	bymODvuu2Q3yDZZlb0qJldQznjmPqN
X-Received: by 2002:aa7:d306:0:b0:561:351b:7928 with SMTP id p6-20020aa7d306000000b00561351b7928mr1286500edq.35.1707575890917;
        Sat, 10 Feb 2024 06:38:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIWqZ8jDST5MmR1Itvs2kMllfaNtEHIqZtP4JvfGvSX3S3bZh+9rYDneOtN20pkc/KK2hURjox2D3kucPrc8Q=
X-Received: by 2002:aa7:d306:0:b0:561:351b:7928 with SMTP id
 p6-20020aa7d306000000b00561351b7928mr1286477edq.35.1707575890720; Sat, 10 Feb
 2024 06:38:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Feb 2024 06:38:09 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-14-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-14-jhs@mojatatu.com>
Date: Sat, 10 Feb 2024 06:38:09 -0800
Message-ID: <CALnP8ZZAh47_rTF-jiC4Hsd1dVSfJgsVAGJT_0b=DxHzqYucLQ@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 13/15] p4tc: add runtime table entry get,
 delete, flush and dump
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:59PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


