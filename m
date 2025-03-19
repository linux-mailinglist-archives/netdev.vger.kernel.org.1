Return-Path: <netdev+bounces-176145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8157EA68FBC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C71916AA29
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936911E8354;
	Wed, 19 Mar 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJXv2r2F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE50A1E7C23
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394948; cv=none; b=gS9pGZfAMgdFh2eWTwDpOMbCYPZ33wwOvbb9eZUox8js723rKiz+Mz6Bi0E9jNRb2WsLPiK5/8sARGudrk1l3VTWfM50j3TKODDmJ4CueTWULHOrbgMH2zDF9aR90WLnSWI/OmQhB8qFRZyqN3K38P7x4GhrFY8jVqi8/D21Gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394948; c=relaxed/simple;
	bh=58hfUgeFGYKebnry7lE5WhCrKcbrFsKcSNdaBwthSDY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hbfTOJYqXWccFXZCx//OTQ7k5lsNBLOgOjpPy3jGGGgVjwfuPfH87Whb7BEzFZ4vXxiIxTzg0dgfRg76SI+y5XhA5wuz8T1mu7bapcDrISUkdyNo1Ij5pF7RS//kqngeN82E8VjRPWkhA8mOYn8Uyqj8AjnqIt9hdwmoIrd+4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJXv2r2F; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4767e969b94so56873461cf.2
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742394946; x=1742999746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09Hcees1eYi+FVMmt5I7+YEyCDq2mEmTvqZcxgO2f0M=;
        b=nJXv2r2FBblmxiLKlDsz7FKGHoAcRaGX5W6lPsszUJ7s5YaQxvrjFB3ii64mH7pxlO
         dFYeex7vlDv4Vu4IcazdfhkZy2jrMC20ZGOV6HoQVotTKIHrll7eNnWdxFfsNgtTt7SJ
         5p45G8UE6+SaNk0XVwUjDoz+CXiEpHUdcUP7FY7Igs+byyJhYtyGuwi4OOqjREw/by74
         K7a75WZ8CCjtMZd2oyDEkprpnhe3jGBJI9ujJ+AtrUZ+PWgC+qgLOemL7T9w7R1c8d7X
         05Eg5gxDN0cKLv/AoNnbFzWXNx3XM5iodZkwia9vLqAesFt9xdeNfDqs2ja3Le7HusiV
         pDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742394946; x=1742999746;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=09Hcees1eYi+FVMmt5I7+YEyCDq2mEmTvqZcxgO2f0M=;
        b=I+F1f4Yn3QTDCFYrfFvnp2EzyL8fo6ExyGxcKROOo77TIHQ7dUMtUObr6l1p0CvPfh
         /CEQbfXWeqiKteSqtYL5kyRIvMvjR/BaRx8q/zILHzk/5UT6+gkX4FeXHtqtmdySIZ80
         DXSKG9r72odO4M4MUiylIwdRT9+TxlMFObCi1JlnHCubPz05dAka2RDk97Mv5/gVIfhq
         jANJAJy04/upuYS1C/8/38dn5FLzPls/CIDyza8ikQ0LvoH3aCpng74o9P2b1ajptxq9
         bNBKaNXOED2oHGgPDb7E+AxNtPjv/dX1C/l+dMcsKJ1HrlnT+RMrSOow86DKxpuxk2VS
         dQcw==
X-Forwarded-Encrypted: i=1; AJvYcCU9j8uCsL7M7Ybst0O+PHyK8VEXj+4TCzf4qnwYX7Cqwt2XFgdOBj4CrolQVMTA3d1nN0zNyPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSRA9zGkUuqHbCrB+PIIagQac8AL/9b37OAjsowdKa7ktCF7J
	O2p2C6mquxRfrbufgu2nOybRUtceB8EHUH6wNFXJ65UocYlPFg1h
X-Gm-Gg: ASbGncsGxO3fD0DAgtjwSjHjm0g3j+OjY87RZqmG4gWZT3/HhGhPjJhwiGtMsPW7Fc+
	aa0k9SNnezB1ZSaVZjMkVzem2mIBVu22oscHEkPUWgJgloQ9n/C1sphV6ZvtuFpbY+EPct6tyXZ
	GEah27W4WhLtHCM8rgqpq2p6HnlkdnLvy2mSzQ4RidKvs2Js70iNr4RVH66LmwnE6ymlFyN8u3C
	7ZkYDK0C35oX1OHHt+CfmUJKLxeYdj+2pCx8kkgZP1oaL3mT0F7LD8tTInES3eXt/Fm3u8XVY3q
	bkt0KrORnJr2dUkTLvP3WTxAR+4ahj5plABaKMY6uSpYeh5QcLHI2RRz3ish6vVK+APLV7fnY9H
	NoRBfodUema2u8yghSzkaEg==
X-Google-Smtp-Source: AGHT+IHHbj0lFVpOPNMsr/oVCiHlyt1lf8nBgkwBnr+6UeqCqDWz15X2xlpbjACPMcOzLoWd4/498Q==
X-Received: by 2002:a05:622a:2514:b0:476:97d3:54f with SMTP id d75a77b69052e-47708375328mr52148541cf.14.1742394945700;
        Wed, 19 Mar 2025 07:35:45 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb7f3d5fsm80468331cf.62.2025.03.19.07.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:35:44 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:35:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 steffen.klassert@secunet.com
Message-ID: <67dad64082fc5_594829474@willemb.c.googlers.com.notmuch>
In-Reply-To: <6001185ace17e7d7d2ed176c20aef2461b60c613.1742323321.git.pabeni@redhat.com>
References: <6001185ace17e7d7d2ed176c20aef2461b60c613.1742323321.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next] udp_tunnel: properly deal with xfrm gro encap.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> The blamed commit below does not take in account that xfrm
> can enable GRO over UDP encapsulation without going through
> setup_udp_tunnel_sock().
> 
> At deletion time such socket will still go through
> udp_tunnel_cleanup_gro(), and the failed GRO type lookup will
> trigger the reported warning.
> 
> We can safely remove such warning, simply performing no action
> on failed GRO type lookup at deletion time.
> 
> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
> Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Because XFRM does not call udp_tunnel_update_gro_rcv when enabling its
UDP GRO offload, from set_xfrm_gro_udp_encap_rcv. But it does call it
when disabling the offload, as called for all udp sockest from
udp(v6)_destroy_sock. (Just to verify my understanding.)

Not calling udp_tunnel_update_gro_rcv on add will have the unintended
side effect of enabling the static call if one other tunnel is also
active, breaking UDP GRO for XFRM socket, right? Not a significant
consequence. But eventually XFRM would want to be counted, I suppose.

Reviewed-by: Willem de Bruijn <willemb@google.com>


> ---
>  net/ipv4/udp_offload.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 088aa8cb8ac0c..2e0b52ae665bc 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -110,14 +110,7 @@ void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
>  		cur = &udp_tunnel_gro_types[udp_tunnel_gro_type_nr++];
>  		refcount_set(&cur->count, 1);
>  		cur->gro_receive = up->gro_receive;
> -	} else {
> -		/*
> -		 * The stack cleanups only successfully added tunnel, the
> -		 * lookup on removal should never fail.
> -		 */
> -		if (WARN_ON_ONCE(!cur))
> -			goto out;
> -
> +	} else if (cur) {
>  		if (!refcount_dec_and_test(&cur->count))
>  			goto out;
>  
> -- 
> 2.48.1
> 



