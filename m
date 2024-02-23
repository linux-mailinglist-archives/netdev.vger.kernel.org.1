Return-Path: <netdev+bounces-74449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA58615BA
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD871C24A2C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404C84FA1;
	Fri, 23 Feb 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoXXN40g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7493839E8
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701950; cv=none; b=R+VdNJbiGl1eiZVlGQETIJCT8n2Uj++fzQK9TGpl2oI823kzDnMp2r5FLYGPb9bxyypXbCjzHJASKYRwSHnTUEyctIvTPnRCx/wXekol73istjnKNU4HpV4tSehyrnY4Wjw1cEQJXdQLq+WyXR4YGzzL4b2PdSCUFBl6c+xAOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701950; c=relaxed/simple;
	bh=GHiO1Ph5AR62ZpoutySWZL3Wjhb8D+Z1k5mOYNAvbZY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=GylpFDOHFrzPkyC7Jvwzn6K1NBuyvi8Riplpfg4gE5+MMZpe1IOvFiBt0dV6QLnc6C2b394dlWA8RoulFaRs2+lI3JL+jcbDNjQrbsuVSBoCeIo5A316qZc0Nsyw8YeXWgSCE3wumDCHvlNUrD7QW9qqilLLT3hJQP1/57C1nGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoXXN40g; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d6cc6d2fcso423944f8f.2
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701947; x=1709306747; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8x4AG9mjqtl/pkiPXxF+DuEBOotZLHOE1f3YoiLaBQ=;
        b=NoXXN40g9/hGmYQrWMK3+xo8WaE3oza354ePGHnvIEKsEG/7tMkImK4xAsleiHqNHI
         YmSEJIM1INWfaLxitVIuAO8UZlWgtZ/OSoC437KPWc5G/pnccHazRkYWSrZrUvU8IvBZ
         o2xrX59h87JVnR/G3glmQc04Rk3D16fGmULNDC8Uqv+MlAT0NRLZXm8NoGRhXoULKTp1
         6TRaNBjrQo1iEGaR8hmdmKxHr4gtg2Md9tUVULmMs+5WOlklp7S9jSHS0SKgNDd3h3cn
         fO9QmKjYac5+N3TKsouy7uj6NK6LANTqbaXk7V5Xc3CsVDl3Ld0RbOpDxb4FC2UfL1rZ
         G6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701947; x=1709306747;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8x4AG9mjqtl/pkiPXxF+DuEBOotZLHOE1f3YoiLaBQ=;
        b=uUSMqFiSjVAr4x0tNT5rbZ1zOV4LBK1V/RjKcRqc0kXTE3XjHNuY/x6M2K5+DLtsHu
         CVSM4WeCnXIQkUndeXsluJB/Vh/WWAxQEdyJOTAHrxS0C+WJ22q9peLAgofjWzv5svfW
         xmKWWRFYvoo6lgvQFg8/qs6Wp1hntqKTrj7Jg4OUtEUDzG6I+VXr/X35fTfZxYqzZCh4
         0Pk5vpViaeZTPgySYh8AHzCCTI7O1LlyzfC4EJe3M0GYhPmvkt0PZhq2W+iyqjFB4EJf
         Nk4jRBQSnbtbMogjMoMuy/exf0RCRJR80jM+y8f176vb5cujdlEY14FxYaVLHdlO3fdh
         Kupw==
X-Forwarded-Encrypted: i=1; AJvYcCXpSih4FvvKiqfcOid9IKjZXpp4XSyPG0E9phDPi7F18GkD9l/T+jgDpgie8Tc2Jjk5Rj8OhclhQ77jLqXRFJuS2towdYJT
X-Gm-Message-State: AOJu0Yxw9IiZtXSmNgUrVFGil6QyBn/GLZJSoAiuDLLML9FnLjp9t4yn
	uQEibHkQrqY9wFf5GWrx+iA/+M9p+1ZVSH3rOMVrUzrQlckh2vmc
X-Google-Smtp-Source: AGHT+IGAQYvc7kIH41udF7oUbneaEAqwIasQ4r1A9ORY2g6YwtATSLOdwjOdn/Er92c83A1tlBbwqQ==
X-Received: by 2002:a5d:64e9:0:b0:33d:7d88:bd3e with SMTP id g9-20020a5d64e9000000b0033d7d88bd3emr143322wri.43.1708701947008;
        Fri, 23 Feb 2024 07:25:47 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id f5-20020adff985000000b0033d5aee2ff1sm3074792wrr.97.2024.02.23.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:25:46 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 01/14] rtnetlink: prepare nla_put_iflink()
 to run under RCU
In-Reply-To: <20240222105021.1943116-2-edumazet@google.com> (Eric Dumazet's
	message of "Thu, 22 Feb 2024 10:50:08 +0000")
Date: Fri, 23 Feb 2024 13:29:58 +0000
Message-ID: <m2wmqvqpex.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-2-edumazet@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> We want to be able to run rtnl_fill_ifinfo() under RCU protection
> instead of RTNL in the future.
>
> This patch prepares dev_get_iflink() and nla_put_iflink()
> to run either with RTNL or RCU held.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

I notice that several of the *_get_iflink() implementations are wrapped
with rcu_read_lock()/unlock() and many are not. Shouldn't this be done
consistently for all?

e.g.

> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> index 7a5be705d71830d5bb3aa26a96a4463df03883a4..6f2a688fccbfb02ae7bdf3d55cca0e77fa9b56b4 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
> @@ -1272,10 +1272,10 @@ static int ipoib_get_iflink(const struct net_device *dev)
>  
>  	/* parent interface */
>  	if (!test_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags))
> -		return dev->ifindex;
> +		return READ_ONCE(dev->ifindex);
>  
>  	/* child/vlan interface */
> -	return priv->parent->ifindex;
> +	return READ_ONCE(priv->parent->ifindex);
>  }
>  
>  static u32 ipoib_addr_hash(struct ipoib_neigh_hash *htbl, u8 *daddr)
> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index 98c669ad5141479b509ee924ddba3da6bca554cd..f7fabba707ea640cab8863e63bb19294e333ba2c 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -119,7 +119,7 @@ static int vxcan_get_iflink(const struct net_device *dev)
>  
>  	rcu_read_lock();
>  	peer = rcu_dereference(priv->peer);
> -	iflink = peer ? peer->ifindex : 0;
> +	iflink = peer ? READ_ONCE(peer->ifindex) : 0;
>  	rcu_read_unlock();
>  
>  	return iflink;

