Return-Path: <netdev+bounces-250095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D5BD23EAC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C53953067F7F
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DDD3624C7;
	Thu, 15 Jan 2026 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfLfFBNN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzDb6dsy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4283624AC
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472586; cv=none; b=psetH1OT8hxHUdRuHmjE4zrgQxfUlsX3esKWU9n7QNNr9tLq68qIOk90EJB12p5pPOt53c3nLiKyTTrNRPze9x1R3PxSM21V6lOa8r1QtbU8IBcNxLdexMtSvuwy4MNhl39BsNf7BKJ+/bvnZgfhwSENYGK8rMRZsWbfDTiggiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472586; c=relaxed/simple;
	bh=KY40kM638NlIdHs/JAxVo5KCQ/kQSuzRNhfaex8x0KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gi3SBBgqmLOrlqI6dx0gpnDOr4EPd02iK1vNH+I9EA5G0G76C6Qe0Xje+dx7CHFvc4iAVK3M/732E23RVsmVOqbXei4TqepybEGxU/aG4amsCBEwACm+Gtwjh+qv2K1AaRIvb5p0CVkAQZKeEGVynFhu79PjtCHKAJz8qy31xdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfLfFBNN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzDb6dsy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768472584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KY40kM638NlIdHs/JAxVo5KCQ/kQSuzRNhfaex8x0KU=;
	b=GfLfFBNNhtErFvUEn04Atz/Qd+KrvloPtHvIqqxzNcAUFpujTqjjY5Iu6hhKmo9uDk8KfA
	7XVXZoH5NuEdOVT4iw++cBrVdmXM309cyNNGqVcnlQ/72ViHaU8211ddelrEhv37QfBrhC
	Vp3kVw4fnBrkQXeqUXBeVL8o9g0fus8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-C3gAiPm2O9COjFGFstfXVQ-1; Thu, 15 Jan 2026 05:23:02 -0500
X-MC-Unique: C3gAiPm2O9COjFGFstfXVQ-1
X-Mimecast-MFC-AGG-ID: C3gAiPm2O9COjFGFstfXVQ_1768472581
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-432db1a9589so493587f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 02:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768472581; x=1769077381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KY40kM638NlIdHs/JAxVo5KCQ/kQSuzRNhfaex8x0KU=;
        b=WzDb6dsyq9aQHb6wZj9KII0p3iq526bBqrAAJKyXqSTBDBaZDyuHA9t1Zg9egTxWO7
         Bagd9h3PNFr2BCpenz6UVYiRSd4z5Otxeh5VZrKNw7oo05tAGT6bbBtpW4Wjus2xQHxY
         omKBGyOasJX2B/CcltqTBGDKhldxThD29ee4i2Y9Oiu2FdRYtkNe9SEPdj86Phse4Gxw
         Y/jXYR+IaZ12+CTTMyR/cXCI4h+DdlODW0IyiAKEdvnnvdxUpRejDT9A3iT0dsWSxpEe
         sDzP7PqOd3mxSeCSlGsef/OUAV2eiD+LadYpKzprDvn1ER+zPNB9puFR0Ju02lwuTEex
         pv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472581; x=1769077381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KY40kM638NlIdHs/JAxVo5KCQ/kQSuzRNhfaex8x0KU=;
        b=Ybk7Enh7RuEJ+HkOU8R3voy4o9cGJdKKDSR0l884926YIblfMOeGAKOCzNsSG1CUNu
         B0OF7r7orh0eYuJvdCwKZ9cyYj747Lghl1yQZVxUHQFL8hvs8L2Vqq9Q0IqFaYufi9/e
         rzj15ENsRvzfEM4r7gTQaHcvKnetvNTrq4uYlYo1nXyJTt2RbFAIKROqYV3VnlU1ZmLE
         BBtBgyRoK4kl3MXouA4OkiPECpL4IRCgPO2U1x+XNazaGe3k+q2vpmnPh3Xtoj3yoEo9
         Omm6zG+2uliMvBvh2jxCGrs3A6kmSFJUtad75n+QZI9xGs25eJxisp8WPZ0J5SN4xsWW
         lumQ==
X-Gm-Message-State: AOJu0YxRM4KOnHGoHuPHauEvQrn7gCNtEISAIa29Y101R/kQ7aiw6imh
	HM6mZLFKPpBBBZOUlzfjRkO/PWp1VNCUistY87NCwD4WO7yhNTIw5RI87+pxOJu8q3bnk+Yw7xV
	UTGzLa2GxmWju6BIGTqvYQiFiiKVsxhp2KowSRGk3JdRjtubQb0hoHEjK0A==
X-Gm-Gg: AY/fxX6gIybf2XSuNUN9vw8NRlBj3RbrNvsJ8bEODgyvPaX7ZFe1A+yZ6+/krO/Bf14
	wo4qJOAzWNC7smIOSfVB97IziNT18vBedfot/A7ZxKvV2AOW2Ze4LM64CvkCWPUU7N2qIpkxf3q
	N/7f1Xqpuol5F0+qzYOijQGnsM16nH3OT5qe04r0u4v9sAi3ixFEpF+sOZCamhU2KAe8xmBFKBj
	ekeYi/wmXsgayXQA6R7SwB/UZzGTeuEJE6fH1obACI14yDnp7UO/26jrrf/I3qLSvuXZ33dttYs
	qqAdQ572xvjAjUQkTvtn6YhqVx5bOh9WxFNiM0r0Ca/iUmvybHf7qwWX5ACnH3bQG9sgo8AQgpv
	rHXjajQPNgXf4Hw==
X-Received: by 2002:a5d:588d:0:b0:432:851d:35ef with SMTP id ffacd0b85a97d-4342c547dbamr7818775f8f.42.1768472581007;
        Thu, 15 Jan 2026 02:23:01 -0800 (PST)
X-Received: by 2002:a5d:588d:0:b0:432:851d:35ef with SMTP id ffacd0b85a97d-4342c547dbamr7818742f8f.42.1768472580610;
        Thu, 15 Jan 2026 02:23:00 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6fca86sm5029391f8f.43.2026.01.15.02.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 02:23:00 -0800 (PST)
Message-ID: <d42f0c80-e289-4e0f-8608-10580d315fd9@redhat.com>
Date: Thu, 15 Jan 2026 11:22:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6] net/sched: Fix packet loops in mirred and netem
To: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 victor@mojatatu.com, dcaratti@redhat.com, lariel@nvidia.com,
 daniel@iogearbox.net, pablo@netfilter.org, kadlec@netfilter.org,
 fw@strlen.de, phil@nwl.cc, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, zyc199902@zohomail.cn, lrGerlinde@mailfence.com,
 jschung2@proton.me
References: <20260111163947.811248-1-jhs@mojatatu.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260111163947.811248-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/26 5:39 PM, Jamal Hadi Salim wrote:
> We introduce a 2-bit global skb->ttl counter.Patch #1 describes how we puti
> together those bits. Patches #2 and patch #5 use these bits.
> I added Fixes tags to patch #1 in case it is useful for backporting.
> Patch #3 and #4 revert William's earlier netem commits. Patch #6 introduces
> tdc test cases.

Generally speaking I think that a more self-encapsulated solution should
be preferable.

I [mis?]understand that your main concern with Cong's series is the
possible parent qlen corruption in case of duplication and the last
iteration of such series includes a self-test for that, is there
anything missing there?

The new sk_buff field looks a bit controversial. Adding such field
opens/implies using it for other/all loop detection; a 2 bits counter
will not be enough for that, and the struct sk_buff will increase for
typical build otherwise.

FTR I don't think that sk_buff the size increase for minimal config is
very relevant, as most/all of the binary layout optimization and not
thought for such build.

/P


