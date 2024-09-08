Return-Path: <netdev+bounces-126311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2739709BE
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 22:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA911F22013
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 20:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6573517A59B;
	Sun,  8 Sep 2024 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="u+9j2KLk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76893178CDE
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725827776; cv=none; b=GXRCywWMN4Y0f34fru67i+oXfsX1LjIdv2VM0guZWJ9FVzV4aOr/PUkUnKlSm6OCvKKXBZajws25FLCS6GKHDrwgNG89Ky6CixqIxyTrp3sXkzj/1fGhu9+X0NXNjr9yR3fgLlcrOH7kwIpfYB6xte2jBN4enlnpei4DFW7AMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725827776; c=relaxed/simple;
	bh=JBK/+8+xE6SKdG2I/38E82/V5dQx54e/WDpzVZy6Az8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5W6gNvBxAk7eSUOlQogiz1J6glP3S3oYOX5eHcGr3UBcc7zns/rXkbxPWDUSKtm5+Q2DR+QrQdOjCx4BRvq0kX/WWFbSprLpOk14LYdX9+fG9o0jbqke+swZO0i75mCweiPMNA5Et6RNPmRap2qY5UWYcNrd2GeHRn5ODgtsJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=u+9j2KLk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so529437666b.0
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725827772; x=1726432572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbBTL5pJFbc4WoL9/Ssz6+tLyOzVs5blYq3ErDDrhAE=;
        b=u+9j2KLk9l3Vgo4opW5FTNhqaqXAsHAo3YRo9nRy/dNJzJJfWCXGdL7e3fHhUD3bHI
         9kPF+rP4cdpfMynHeyZoji+7hy/QckxnHiHHxdCAkPxE3K2CU8WrnUVhesjtBigFL+yo
         C2qMFAuiNrSPcnqRopqSMSyp2w1SG6pTbc1RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725827772; x=1726432572;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbBTL5pJFbc4WoL9/Ssz6+tLyOzVs5blYq3ErDDrhAE=;
        b=VhMmymceyNVQ0kcSo48hM3lur4x401FYXcnCkGMSu7Et/3VIMkeK0SgAxpD5U+cG+B
         O6Rv5ynO6S9IEantQKH2yi7ijDN8LOtI+yCZH6etaG3+JcYVUl0Ra9cCFeT4+ONSyMcZ
         WglhYmJF5svDEKa6uGbDxbtvstA6/gry/gD4eMOw6GaEPCRtJeqXgFP56imOW7fiE3vr
         1lyYB4E7jtjq6X3k4pRwM6f+l/3X/8w6CmZ8H5VqYb4nRTYvHqQi09qHHcT2TPnIUV30
         /6s9xBxn/sJ8wYCJ6UgBFljl7V+u3SzIqtC1gjrwoewbjZkQOLYENn6RJhZcn48OPAuf
         WIsA==
X-Gm-Message-State: AOJu0Yw3ziMKIKg9CZWFD/wzIrx+r46Fzm47cgwKxRFKo5fRXO0s0anJ
	Gl9llnpEZeFSHQsp0JyEOpvQeJ/rA+TUDnoHNOAlc05QAx2hdgMU9QopYkxelBVspuLC7zgAy/l
	5KbNp26AnmOQv5kJWQfqVtK6eNznG2bPo7STQjS9qsJlZxh4JsNwILXKTNppj0lrmoXXtY5fPK/
	bQoOG5NG5POfZ7P8ebWxxAEHsp+7Z/T+x/VCrjP9d4shE=
X-Google-Smtp-Source: AGHT+IFOxhb2pMqFVg3cQTabJXtA0kstKltwdqMCbv+++XsxCaWtLu3qNwqExqs50+Jq6di85P9Wkg==
X-Received: by 2002:a17:907:c13:b0:a8d:35a5:c8e5 with SMTP id a640c23a62f3a-a8d35a5cd2dmr333281166b.6.1725827771622;
        Sun, 08 Sep 2024 13:36:11 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835b0bsm248837566b.12.2024.09.08.13.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 13:36:11 -0700 (PDT)
Date: Sun, 8 Sep 2024 22:36:09 +0200
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 4/9] netdev-genl: Dump napi_defer_hard_irqs
Message-ID: <Zt4KuV77wt1as5QW@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, kuba@kernel.org, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240908160702.56618-1-jdamato@fastly.com>
 <20240908160702.56618-5-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908160702.56618-5-jdamato@fastly.com>

On Sun, Sep 08, 2024 at 04:06:38PM +0000, Joe Damato wrote:
> Support dumping defer_hard_irqs for a NAPI ID.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 8 ++++++++
>  include/uapi/linux/netdev.h             | 1 +
>  net/core/netdev-genl.c                  | 5 +++++
>  tools/include/uapi/linux/netdev.h       | 1 +
>  4 files changed, 15 insertions(+)

[...]

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 9561841b9d2d..f1e505ad069f 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -160,6 +160,7 @@ static int
>  netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
>  			const struct genl_info *info)
>  {
> +	int napi_defer_hard_irqs;

I've already made this a u32 in my rfcv2 branch.

>  	void *hdr;
>  	pid_t pid;
>  
> @@ -191,6 +192,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
>  			goto nla_put_failure;
>  	}
>  
> +	napi_defer_hard_irqs = napi_get_defer_hard_irqs(napi);
> +	if (nla_put_s32(rsp, NETDEV_A_NAPI_DEFER_HARD_IRQS, napi_defer_hard_irqs))
> +		goto nla_put_failure;
> +
>  	genlmsg_end(rsp, hdr);
>  
>  	return 0;

