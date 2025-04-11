Return-Path: <netdev+bounces-181731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB482A864F4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5779174DF4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD9E23A997;
	Fri, 11 Apr 2025 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxSXhuxv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93595238D52
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393322; cv=none; b=VGsIvYuThUCio+1D1NrkU20Q4nTsqd735WHAwkBaa8PEBVts+iJll950AsS/8SqmN/sinut+FITyJvEQj6S4D8mRMMZUBYpapgkaMxpwKoZB8ML/mEwB1sEpC/vuyoaCnq/1HYk8d2O7v5U7IHRmgPMmceAMCTOq+qeRGL4AHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393322; c=relaxed/simple;
	bh=T2axtetN7M3DsTpMIGoFih3V3KSH1rJ+lKDcAXc5G/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVPCVZpPqbAA5QJR4H+mfGKJUY8YULPSeclNOW8xchr3ezCtdOWcB+9nQyGsdxuh5nfAB5zJaqbGR8iHIGyBG6xVLrR8Ha1dcwTHRhiAXTx4qAZ85/5/O4VM2ck1u9hrsiTQNYEE9E/IrJTEz4aqygO8zmBeJJomgewQZCBgk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxSXhuxv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22401f4d35aso27764655ad.2
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744393320; x=1744998120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RbTF9em4MvA6vxVP7Zx+H3Bbc3FZuI2FXmrdbsQyG50=;
        b=YxSXhuxvkJQlsJp2ex0xvTHLQor4DiW2OK4fN++TogTxLgtSF+AVzl7FizQQbnUfFy
         DJh4jhtDbnwyfDYlyIaMHLMb7WazbtIr7CUzbddNUTXjpI8jkjMSyHRE/243BnzOQTbX
         Aa6gt+AiVTA4hRGz6nqHWKk+C/ht9na5l8imbiJEyBxE3Y1/Y4dmP8lMmoMRxrBXXrUf
         R6xPoQ8rSO/rwPj045QcSbwE9vgzJJQQ+Yk0NUCrPEI3KMti5Ido96uzMGPJP3JgsCnw
         +2vOrv7GuZInXrVbaoxQc+DzikzuKs+/RSdlCJg6Ck7+ngxEBELlJrbaktdyHW/2zR3R
         yjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744393320; x=1744998120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbTF9em4MvA6vxVP7Zx+H3Bbc3FZuI2FXmrdbsQyG50=;
        b=ZYWshjdBwinHnPrj6cBDN6JXj+AQK/k4Cr/yKvdh3j87/yGAQou3ncjxPmZ37nMu7o
         KWcSqNIHvf8J46YhZiKHzj4kRlXHBdciNkviNIODbrxIDrButmKPYfhKux4CL0r5UhXj
         NmffJZW1XBBOOdrT6ntcnloBJXvUUFt9tkjO6Oq4mwyFhJn2lGwVzFkG2r4y1RNfoaiM
         h0gX/3KFml/awvnSgToOirSKvQIHGztPsPYBE69r3HusvpYh8EM+ckNvVzOXCa9jyNEk
         k4hCR58LmiSCF5CHJejuWu2UBlAI5HLGj3VktIf+XWzE09oUnANl4YOs0IgUFEdEMCZv
         4yyA==
X-Forwarded-Encrypted: i=1; AJvYcCWLJc4J54dRH1dLDoo+rjj3UjUXSxMK0dbkJSYwD61VpxHVngLOCUezGZLOh/dTX6eG9sYm8lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ZmSqHVw7PeZTiKOGkJczbm/UHxy/DzZyNkrUZ66DMdOXqqDq
	FHKLbOsd02Bi9n+ViE4JDRvU51lN9p4HVfJxdEdEUl1tCGocS84=
X-Gm-Gg: ASbGncuaCmfp7zAKtJf+xfUHtH1KjGL2F5WLo3xxRlLNP0hEvSHa6yiohq4F0xc52LG
	f9qVjKi4eF0oagBCekcP4MYAjjSZq8DTPn8h7a7dfjchMUDgfIqaPTAPKHd1r+TPszlRPDWxcBB
	LkFW/U9uHRn4+A+yaL+RyAyzi1r8FIOpmLNeLKk39joQBMRl3k9SS2ea4h1KK9fhQRIROXNLKu7
	FRg4Hnu8vgUVst5eOiJpkmAXzIPkCzLjkzLKZNO9ng8+BlPNOvaTqg0aA+W2eqK/9lBxgO6txoV
	pbdueUH/U7gpBo+gYo9DI24m6BQFxg4y+S2Rnhvw
X-Google-Smtp-Source: AGHT+IFyfwHbBlEdJ/i1+RukZ193D4G6+xmEQLS5GlPsvCL6yH82ojaQXxnUKapdj2HLrNONd8I53w==
X-Received: by 2002:a17:903:144e:b0:21f:4c8b:c4de with SMTP id d9443c01a7336-22bea4f26dcmr44179785ad.42.1744393319678;
        Fri, 11 Apr 2025 10:41:59 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7cbdfe7sm52682835ad.207.2025.04.11.10.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:41:59 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:41:58 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: sdf@fomichev.me, Kuniyuki Iwashima <kuniyu@amazon.com>,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, hramamurthy@google.com, jdamato@fastly.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 6/8] netdev: depend on netdev->lock for xdp
 features
Message-ID: <Z_lUZgRc9JYhjnIG@mini-arch>
References: <20250408195956.412733-7-kuba@kernel.org>
 <20250410171019.62128-1-kuniyu@amazon.com>
 <20250410191028.31a0eaf2@kernel.org>
 <20250410192326.0a5dbb10@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250410192326.0a5dbb10@kernel.org>

On 04/10, Jakub Kicinski wrote:
> On Thu, 10 Apr 2025 19:10:28 -0700 Jakub Kicinski wrote:
> > On Thu, 10 Apr 2025 10:10:01 -0700 Kuniyuki Iwashima wrote:
> > > syzkaller reported splats in register_netdevice() and
> > > unregister_netdevice_many_notify().
> > > 
> > > In register_netdevice(), some devices cannot use
> > > netdev_assert_locked().
> > > 
> > > In unregister_netdevice_many_notify(), maybe we need to
> > > hold ops lock in UNREGISTER as you initially suggested.
> > > Now do_setlink() deadlock does not happen.  
> > 
> > Ah...  Thank you.
> > 
> > Do you have a reference to use as Reported-by, or its from a
> > non-public instance ?
> > 
> > I'll test this shortly:
> > 
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index b64c614a00c4..891e2f60922f 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -38,7 +38,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
> >         u64 xdp_rx_meta = 0;
> >         void *hdr;
> >  
> > -       netdev_assert_locked(netdev); /* note: rtnl_lock may not be held! */
> > +       /* note: rtnl_lock may or may not be held! */
> > +       netdev_assert_locked_or_invisible(netdev);
> >  
> >         hdr = genlmsg_iput(rsp, info);
> >         if (!hdr)
> > @@ -966,7 +967,9 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
> >                 netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_ADD_NTF);
> >                 break;
> >         case NETDEV_UNREGISTER:
> > +               netdev_lock(netdev);
> >                 netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_DEL_NTF);
> > +               netdev_unlock(netdev);
> >                 break;
> >         case NETDEV_XDP_FEAT_CHANGE:
> >                 netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_CHANGE_NTF);
> 
> Ugh, REGISTER is ops locked we'd need conditional locking here.
> 
> Stanislav, I can make the REGISTERED notifier fully locked, right?
> I suspect any new object we add that's protected by the instance
> lock will want to lock the dev.

Are you suggesting to do s/netdev_lock_ops/netdev_lock/ around
call_netdevice_notifiers in register_netdevice? We can try, the biggest
concern, as usual, are the stacking devices (with an extra lock), but
casually grepping for NETDEV_REGISTER doesn't bring up anything
suspicious.

But if you're gonna do conditional locking for NETDEV_UNREGISTER, any
reason not to play it safe and add conditional locking to NETDEV_REGISTER
in netdev_genl_netdevice_event?

