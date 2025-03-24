Return-Path: <netdev+bounces-177114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3174A6DF40
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357577A6DE4
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FFB1CD1E4;
	Mon, 24 Mar 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKVC2VSJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4225D1E1
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832394; cv=none; b=slGfYncorS5ehS48bm9eHjUDumDXzNUAc0eGDF9oq+3S+P5Y/YMKhg/j7At/gU0D+GElG2y4XUvA1IPoqiGyhRhbHKhYHnR319LwGqcg/sDQs9B0vSJiDlGz1TPca7+FZLNF1yqX/jyqUaMQLskKgUuu3olhUm5Qo7eP2gTrMnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832394; c=relaxed/simple;
	bh=dRVzxvfhNxdRwR48y8+sy/jLw48lh6EGmnzhH0v2FEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAb/dGRrKg+HrK58QFOE2PuXaPQ8t7iv99/n1vmc6cG1B1r2xmGA7QGgT3yZnIIv6KRIHsCyFnRbL+mQ0RrW/0oEth1myo1ZKrpbw3kFHQdkgEZkmLv+XwLX3a+DQ9xs3T3VzFwMCSVYRkvCLjFa2BMAxiOTFFmcsAJLo4SJUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKVC2VSJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225477548e1so84658435ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742832392; x=1743437192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S4odyFEb+XsVIPdPFvTGi0S/IAmkDNJRFHpO2w+iqfQ=;
        b=AKVC2VSJB3yt8cu4Luef63UxO+zL72OXQ++nAfeGEZL7DvTwWYRcAGxwT0PN8qNPhU
         Ye+tPQmyqMzvXUYDU0EMLLSQHm2hm/WFx72lSfSPmE2BXAMHbKGJ4uZstRJZPZkc8B2G
         eCjSxvQcXl7fY4GjEH7SrbTpcmiq+dR0PDomZuBZ5odbqVMZKl8r05/o6onW9CIQ4VrT
         68y3CaA3imTFzXfSQSIfmmmPjeEAVmG3sisQL3XYfMaC33/xM74w1T3c51kUs7n3WmRK
         +NLbdFH3m3IAdeNNh3sMqOei1FBdFXnVbrgALIlixeqTgiZhrqrPKvxwXFGZRtQQRpRe
         v1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742832392; x=1743437192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4odyFEb+XsVIPdPFvTGi0S/IAmkDNJRFHpO2w+iqfQ=;
        b=X9RZ6XqSywR3clfrjg6Y2eERYAdEGBDr4VWCjH5w33vhgjh8i3//9a4VePbVh3auDa
         E+INvVYLxj6MgT4rcOgeDQiAZDbOAb1dm/r+1w0ReBQiUYUH45JpNUZqRJ5diKWmSYb0
         x5GQC7mKEqvCwGUjF1HXrONyBX2HVBIEx3QaXdVZg/p/x+UlN+n8BWDLMUI9JaN+XHB1
         q4Gf//3vfbSSFrcza1t21C71h2ZyOw5IaE5yK9U+i2SDPmjPuBPYuENR999rl62+/g28
         L+MNVWlhCe83mBC36g3Lespacma0FNCwf3JbIImbApXCP5XR98OuGFcf5ROISNmb0ClO
         uFEg==
X-Gm-Message-State: AOJu0Yw7wg2K7SAG3Dbhuf70UbeJ4SKqDoCJi/MWQMWHDq4lhdD+4I1W
	bXeYxsy3NN8eKgW/3mPpwvzotGEkH70lCqjFpMU6iRArRakYEUw=
X-Gm-Gg: ASbGncugErAqjTnsWVfNYuUanqN6VFyCo3MJg47kGFV62JQX+OVicn/OStB+eY/SkQQ
	mVRwc/V+pqnGevSGmPSm2WW4UDcXklJrzz+GqF0QSbZh6ZjPt4rARh5iYFPG2Tyjaau7W1VC+mZ
	08+5Vl63AhwACTfhlTEznCuS3iuiyAiq8zGUeNuyHgDdM8ZZSAZf+uRw6z2IQ9XQUs6xL29y40b
	dawVu5fL29Ja0LY2NVEKL6IAFr8z9OZH5B8ZT8VFnUpfxrUc8utGw/IBfDGALcXdQgXmCu3rIGG
	ifgeUZIDxYs2Ufk42mIrx35Rf0Oe3greeQnm5sWBnwsJ
X-Google-Smtp-Source: AGHT+IGsCFpoIZ2F98ytOxXCwkFleAU00v4T+Fjgcruo3unwpk530SFjUB9sa1tPUNplwuJJ27+Ntg==
X-Received: by 2002:a05:6a21:3a90:b0:1f5:8cdb:2777 with SMTP id adf61e73a8af0-1fe42f08e3cmr23177056637.3.1742832391498;
        Mon, 24 Mar 2025 09:06:31 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73906159f6fsm8130282b3a.156.2025.03.24.09.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:06:31 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:06:30 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"saeed@kernel.org" <saeed@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v10 08/14] net: hold netdev instance lock during
 sysfs operations
Message-ID: <Z-GDBlDsnPyc21RM@mini-arch>
References: <20250305163732.2766420-1-sdf@fomichev.me>
 <20250305163732.2766420-9-sdf@fomichev.me>
 <700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com>

On 03/24, Cosmin Ratiu wrote:
> On Wed, 2025-03-05 at 08:37 -0800, Stanislav Fomichev wrote:
> > diff --git a/net/core/dev_api.c b/net/core/dev_api.c
> > index 059413d9ef9d..7bd667b34b80 100644
> > --- a/net/core/dev_api.c
> > +++ b/net/core/dev_api.c
> > +
> > +/**
> > + * dev_disable_lro() - disable Large Receive Offload on a device
> > + * @dev: device
> > + *
> > + * Disable Large Receive Offload (LRO) on a net device.  Must be
> > + * called under RTNL.  This is needed if received packets may be
> > + * forwarded to another interface.
> > + */
> > +void dev_disable_lro(struct net_device *dev)
> > +{
> > +	netdev_lock_ops(dev);
> > +	netif_disable_lro(dev);
> > +	netdev_unlock_ops(dev);
> > +}
> 
> It seems this part plus the following part from patch 6 of this series
> result in a recursive deadlock when inet forwarding is not enabled:
> 
> > @@ -3013,6 +3021,8 @@ static int do_setlink(const struct sk_buff
> > *skb, struct net_device *dev,
> >  	char ifname[IFNAMSIZ];
> >  	int err;
> >  
> > +	netdev_lock_ops(dev);
> > +
> >  	err = validate_linkmsg(dev, tb, extack);
> >  	if (err < 0)
> >  		goto errout;
> > 
> 
> Call Trace:
> dump_stack_lvl+0x62/0x90
> print_deadlock_bug+0x274/0x3b0
> __lock_acquire+0x1229/0x2470
> lock_acquire+0xb7/0x2b0
> __mutex_lock+0xa6/0xd20
> dev_disable_lro+0x20/0x80
> inetdev_init+0x12f/0x1f0
> inetdev_event+0x48b/0x870
> notifier_call_chain+0x38/0xf0
> netif_change_net_namespace+0x72e/0x9f0
> do_setlink.isra.0+0xd5/0x1220
> rtnl_newlink+0x7ea/0xb50
> rtnetlink_rcv_msg+0x459/0x5e0
> netlink_rcv_skb+0x54/0x100
> netlink_unicast+0x193/0x270
> netlink_sendmsg+0x204/0x450
> 
> inetdev_init conditionally disables LRO if forwarding is on:
>         if (IPV4_DEVCONF(in_dev->cnf, FORWARDING)) 
>                 dev_disable_lro(dev);
> 
> What to do in this case (besides the silly workaround to disable
> forwarding)?

I think something like the patch below should fix it? inetdev_init is
called for blackhole (sw device, we don't care about ops lock) and from
REGISTER/UNREGISTER notifiers. We hold the lock during REGISTER,
and will soon hold the lock during UNREGISTER:
https://lore.kernel.org/netdev/20250312223507.805719-9-kuba@kernel.org/

(might also need to EXPORT_SYM netif_disable_lro)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 754f60fb6e25..77e5705ac799 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -281,7 +281,7 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	if (!in_dev->arp_parms)
 		goto out_kfree;
 	if (IPV4_DEVCONF(in_dev->cnf, FORWARDING))
-		dev_disable_lro(dev);
+		netif_disable_lro(dev);
 	/* Reference in_dev->dev */
 	netdev_hold(dev, &in_dev->dev_tracker, GFP_KERNEL);
 	/* Account for reference dev->ip_ptr (below) */

