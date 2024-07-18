Return-Path: <netdev+bounces-112084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBEE934E0E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656E81F2289E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6372313D265;
	Thu, 18 Jul 2024 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLTxgW1X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676F7470
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309047; cv=none; b=pkTZya02WGPzlRSJap7xPl0W5bdB4Yzin+TPT+nA0TAYx9OoHei3idsjsA1LTsznvVcPCp22+uJnpPqnczRtScl/wtUGNaOIdoWZEFSdBMt/OrA+HwiE5iDwh826kM576fi/I+A/IPWr98/VsnIF2z4W3BCgOcrPcCw+SCa02xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309047; c=relaxed/simple;
	bh=e8Gt5DoXEoaLc59zx9tAiYZSpn+NdaCG5CVe0dGb2cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3bt+sEjv0GKat6sUlpps7rL+y+FMjaj2e3UO4E20bPxzNnvNjTHgmt0muYCwS8fRxR1j3Au23puk88ppM3Pi3DJuHvcsYClrfcp5HUbJ/KhjyC8wWK5p8L5/vrZeRan8tvH54kNpCIDZpT1Dbgk+FywgNFfJuF0Mz3zqZY2Wcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLTxgW1X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721309044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pC8J8VJrDT4jY1cfQPpkUs13TG9Pb72s3JfONTgrIxE=;
	b=QLTxgW1XM7qX40QTJ7ur0DryRpq/yaYwOoib4h4uhw1iweO/dabnjB52sjd36dl8UplHd7
	5BI64ZgKkzn1h1dngvFBgShb6FreKZf3VjkrD42Bu/HNxCZxd2W6hV3+RImcFYvnN4QLFy
	/j5LIdZcCeSitqMg6jFqx+cTMh1FYuk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-fzDM7iFDPZa6JfwWplkq4Q-1; Thu, 18 Jul 2024 09:24:03 -0400
X-MC-Unique: fzDM7iFDPZa6JfwWplkq4Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4267378f538so531025e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309041; x=1721913841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pC8J8VJrDT4jY1cfQPpkUs13TG9Pb72s3JfONTgrIxE=;
        b=cV9a4AVDWf9zgqmkmYFwp2gLrZUKf1zcgY1rJ366s2etzxgpMHZTjXmQTf6ee3nrU0
         W/R3KfD1pYhrDq5VtGc3Cg2szvP3zkyfqwcfUr9djWwbXa09tjB8lWVzd/uykBML8Ihk
         efZSUpdBTybGAhlgfDCyMsouS7egcMRhtxgvdodGNtRKz4ekwvwUa0mZ3kmw2RzwAAIv
         0Aa0Y7JLfplOtuB+ScT4hynVvgn84MElNGfDu9sN0iAmEQbgBKXP7vnQwlDPTj52mfow
         v0tsdj9u9MNZa01PrUuQ3wQ2jYKZlCx4rVI4nEJMOJxb/NAvMxT99ue1w7RpO6LEBOEt
         hqdA==
X-Forwarded-Encrypted: i=1; AJvYcCUvo/vt53qzs9idtfG+VAe4Chi/XFzxLj3kbsg2s/yrkmG8YiPQuEdECdIlpK0g6Jfdbo1bxwLRnS45tkhvDcnbLwTllHFB
X-Gm-Message-State: AOJu0Yxl6JxNRAC/foWxHyX+EYY+3dxJ7ouzOifQ2haeDtGcGY9D+3eT
	2whA7mwMPEgiElT/Rhf8gfVLAWFqc7mtIv6wp5Ae6gyQd5X45bAo7mrTeXl9g1MoXtWMmHDualE
	zCoTDpeJncJMrHPj0s4uny6VUg3OACjpcyz3wzGKyjXZhiYa8AcHQJrYMm+XKcw==
X-Received: by 2002:a05:600c:474d:b0:426:6358:7c5d with SMTP id 5b1f17b1804b1-427d2a9c38dmr4119645e9.4.1721309041451;
        Thu, 18 Jul 2024 06:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjjqE8eKUvRPrahinmrl/iowd9CcM13NP08fJiJ6s9e0m92tZaIVm5YLWDOhDSY1O59jr8QQ==
X-Received: by 2002:a05:600c:474d:b0:426:6358:7c5d with SMTP id 5b1f17b1804b1-427d2a9c38dmr4119485e9.4.1721309041012;
        Thu, 18 Jul 2024 06:24:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710::f71? ([2a0d:3341:b08b:7710::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b29d15sm13422565e9.37.2024.07.18.06.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 06:24:00 -0700 (PDT)
Message-ID: <050fc313-6277-4c82-be1c-71ec30c8bee3@redhat.com>
Date: Thu, 18 Jul 2024 15:23:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] openvswitch: switch to per-action label counting
 in conntrack
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 dev@openvswitch.org, ovs-dev@openvswitch.org
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Pravin B Shelar <pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>,
 Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
References: <cb6cfbcbdd576ce4f3b74be080b939a9398d21c7.1721268615.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cb6cfbcbdd576ce4f3b74be080b939a9398d21c7.1721268615.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 04:10, Xin Long wrote:
> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
> label counting"), we should also switch to per-action label counting
> in openvswitch conntrack, as Florian suggested.
> 
> The difference is that nf_connlabels_get() is called unconditionally
> when creating an ct action in ovs_ct_copy_action(). As with these
> flows:
> 
>    table=0,ip,actions=ct(commit,table=1)
>    table=1,ip,actions=ct(commit,exec(set_field:0xac->ct_label),table=2)
> 
> it needs to make sure the label ext is created in the 1st flow before
> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
> nf_ct_ext_add() when creating the label ext in the 2nd flow will
> be triggered:
> 
>     WARN_ON(nf_ct_is_confirmed(ct));
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

## Form letter - net-next-closed

The merge window for v6.11 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after July 29th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer



