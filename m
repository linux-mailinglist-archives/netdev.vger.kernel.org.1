Return-Path: <netdev+bounces-70765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AE28504C6
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 15:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8480283AC3
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45495B5D8;
	Sat, 10 Feb 2024 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIbWumZm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41987405D3
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707576082; cv=none; b=lbVMzBCjeBhynKeQhTuYkrIL6/vPcMSy1xBsr3ZDaTPKPtsKPsEkJEahyTGclF+YlNiP/i7xE/3OExPODxS8ZCGzzWC9xoxBKj0wgEBU00uwtlq1PO6ZlxAhJBk1rg70w+0vydODFQhr/nRPAOhF+THLfn5+qhSgYcaAHkVM6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707576082; c=relaxed/simple;
	bh=cddHuOaB9KcH6aVyY3u+DsCaGhqFQ4jkZChiLVC9IUY=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7J5ikOE1DCdKPS4TqB72yMAf7hKMHy7O7ckXJAEqznufrSM2/F7ZJXebNRHRZURcsG37ipYrLQyIaUb0pIyXuDzobBLCSYdUpRwKEhQdOCdhOx2UaAB/0EntCvBeiBrZb8vfM85nIhHTCuEMV5lmxyKGwwMc8WTXzffQavYahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIbWumZm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707576080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cddHuOaB9KcH6aVyY3u+DsCaGhqFQ4jkZChiLVC9IUY=;
	b=FIbWumZmxJJgUD1CzlAEluXlUxPUTw1RJ99EjQn6eRZaIzm0wIBqCmHxvQ/6Uo81yGzCTO
	Li/rGi0PVUs9xj7/egKn7f34/WE6Yf5n4OrDvtDdmc/xpu7YpKZenzx9t46bqHvO4G8tVs
	vQIebpivGrulVkL9cOMiJQM9P3GkFgA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-K6WH1hR8NAuTP9f3BP_vzQ-1; Sat, 10 Feb 2024 09:41:18 -0500
X-MC-Unique: K6WH1hR8NAuTP9f3BP_vzQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-560d6fb3b7aso1001435a12.2
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 06:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707576077; x=1708180877;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cddHuOaB9KcH6aVyY3u+DsCaGhqFQ4jkZChiLVC9IUY=;
        b=ARthgqjIPblr+ARfBDSCSPonPl9aGVYSjK0ZHvKqfKqkp4mAkd2lcnuP1SYrVBOlK5
         CeqHDUdD1EbdzNBM+BWAtD6AjHzcIOICMQKtPxlW95e96eFuuf0dwmsHGn5jlzFPJoZl
         Om2qDiRAU28oghx81JciDIwgv8rk/aITw9smmhdqIynidZ7IvvqXLVmZbYC9vzwsNWEQ
         yy0GVp5gyfmGSf/cpo/M14OwIBy4WZbQ9PChGmUQS4p77nsohtFTFPQ2oIS/V0F7kym3
         zggRHEaNCg+8RqDoidcAu+Z/YjMwZrh9MBnfhe4jknBGIPEX3aAlKtZul8mLii51ZEkd
         Mz1Q==
X-Gm-Message-State: AOJu0YyDPdrtWwji4Ja4oFZ7b+wQQDx6dzcnIelG6BgAVoMLS9rdgsLt
	Q/Qc7K1crd+DTtljHgjd3Q5K+WTtSgpTGNx/6t7dNlPhgxX5isxChXEQu/fwaWrC8Ud+k0xFWEc
	IWC+A6k1COdz1UQ3pkeKBfcB0nv0XRo7V8aghuMzTh148ycHj5eBpNEtwT87DSmOIzXh1x6dqE6
	uFYEQBzz1Gl1qEWecT2MSP5kwEarSU
X-Received: by 2002:a05:6402:2891:b0:561:8277:f09f with SMTP id eg17-20020a056402289100b005618277f09fmr324833edb.11.1707576077495;
        Sat, 10 Feb 2024 06:41:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPraHWH012KzvIo2RXcN1qL/nTaGVQSVNYfAt/J/789jtxHrSAH6ndcLsvIwBPXGJxANCesgLfp5NL+NE2gGg=
X-Received: by 2002:a05:6402:2891:b0:561:8277:f09f with SMTP id
 eg17-20020a056402289100b005618277f09fmr324807edb.11.1707576077218; Sat, 10
 Feb 2024 06:41:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Feb 2024 06:41:16 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-15-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-15-jhs@mojatatu.com>
Date: Sat, 10 Feb 2024 06:41:16 -0800
Message-ID: <CALnP8ZZhq8HhxmJc8wyj7=Xnab7UxVZm-MU7CX-4e+3nDVAUvQ@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 14/15] p4tc: add set of P4TC table kfuncs
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:48:00PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


