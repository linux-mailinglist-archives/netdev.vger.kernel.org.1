Return-Path: <netdev+bounces-232160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2BAC01F17
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8D18350118
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381EA311C1E;
	Thu, 23 Oct 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkKKvPFE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9632E69A
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231482; cv=none; b=FE5tmImhtDDrv3JMvujZb3em6j/gkMdNQqzOTXt13ryykwPY4VVtp5aE1kNuB0jFgWAoJ9AWTwVB9OH6iEGTfY7Pd8uW0gnW5lryvtFr0VlOQ6jzyAOK9MFVam7yLwuSyv2GNdEURe/B3uoZmfXMR50hUc680FNet5DW1wbGmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231482; c=relaxed/simple;
	bh=zLuv+P05fR1PDJc1gb7G1HiUlEs2h5+XHgiL0ZmD7+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1x4dTEn0vF4Fp+OOb+cUwVp8lyB5qMNwg1xkHqqOlaPn3EtS7S9r6mdyntDfUgXmKIsMH2sCQr3bvAOglWS814X3j3+L+QLmUVeP/yzDQnMuiauUakB+qEfed6dWJbff88B0D6lbCyI434PVv/PdTVnJriRiNWVqICd+E002us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkKKvPFE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so799721a91.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231480; x=1761836280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdIBQPcbJPp/v0ECGLHUc6b0o6HYeXdKX+8k63J4F5o=;
        b=FkKKvPFEekd97sQh+kpn7n8zB2aSoUm6zdRokt184pUqXEmwcBQe/pL8IbRiu0sKQq
         a97EuMZMqYq8GUgUhS2kuEdzjOzgpZiyKXvi544kFJLmnjzaxGfXPsjffu5xhO8XfivD
         k46QBj2K1vRVYbOoEQepM7O5Pcz6w2f6Ah1jAyfpa6d7jjD0oCzCEni9DZz92kJu6lVB
         kESuHRr46bf8PNmvwurb1qlUVl2PCWJdAOPK9ZT1Qkbh1PNFSZ4bWqlgvAYKNmmtLGjr
         tJRH4maGFO84tpNg2z9IK9qxCJRgpulb5l+xwoSYogr7FvzSyFtipjv2LVI8CGw+dgSF
         tpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231480; x=1761836280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdIBQPcbJPp/v0ECGLHUc6b0o6HYeXdKX+8k63J4F5o=;
        b=GANniJJ0Zc2+2DJTRsujxDb/A655HE84WkK3oVxwy/kAMtTP44kVGBGrU0htgYHjYS
         V/aAiDCk3UeA6wwLZBrJylAnnSwwBpbnVEmNB6llqyarCChiZsNtPZUoCXfWArygaYIJ
         aiaf0TBYYxhmsJUE6gPWSCfLHCbPkErm3ICxSQHLRVaigRG5W/nT2slIRVxE+5UxpQq9
         KJZEl7zDn5xG6m8aBW/a1yeBtbvXwqUSrntwu5L1MJj5tQY8RD39DZgSjo6UcvJDWyoI
         ffpzEGaMPX5fexViH+3UMFrf1pF2ythhkSalhMxN4mMrCUnXlPuBXg7uMskYDyg5T6xK
         4PzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZDCF8zdOb5St22kMIqdDZiOT7JgeZmNbrIOZazo5YYXboLwFFEQnn3Yy2/8ObuDpD2Vuat7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5PM8xHCrIKRdUn4N2lHdEPKxTSFA+m0d4uIpanC5f0CJyNNKH
	uPw3eHzCudy954Erj+3dDnv/tTw7/zvr+oXDKbMaZEIhS66JRy4MlFZE
X-Gm-Gg: ASbGncsOJA3ks79Ragxt28L7SAWnpKJY6vUVf385/Mpz5WCZ8AqrBgRHunwcNQOJgpj
	YBY4k4syBSPrPE2UfFSw1NlpAmAQCDnbi3XXiJV6SmMnul4NownJdFqa+K4k47JhvrB/7O1hbLD
	V2TCZRscKMBcE0OjKuYnD6SsZ79z+LT0v2XUdl7nKATMYs/paFv9Bnvn9MeOQ/uZeiqa65Zy7GP
	y+3au+0g472PTVy/si0+87r+T5/8474sM82GMIpn8INt6YSm9FheEUf7qEWP4DgCJnRddlc0aYr
	BiOKE+EaO9dd9vj3LJc+1mtLcL0SanX9sj/+78k1YAvlk+/VG7x6TUqXSI5Q67tvxK5LBvXbCR4
	4aWftfGxTrhjt1SAYb+TMiUMVtv4TeONin7V24aS/T7noExqWPnVpgR4Qd4Is11gBSivy2qjEAG
	k50aFmjZ8o5dxAYZM=
X-Google-Smtp-Source: AGHT+IFSi4LUU6uvPS4EAaycN/pLV0YAOoTgM8I/cwLZFPbgfiu1UMMIfYflMDVAwEr5Ex5bBfC0Zg==
X-Received: by 2002:a17:90b:28c4:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-33bcf8e4f50mr32240389a91.24.1761231479990;
        Thu, 23 Oct 2025 07:57:59 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb67f151sm4360980a91.2.2025.10.23.07.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:57:59 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:57:51 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	Oscar Maes <oscmaes92@gmail.com>
Subject: Re: [PATCH net] net: vlan: sync VLAN features with lower device
Message-ID: <aPpCb_WP5_5v5N2E@fedora>
References: <20251021095658.86478-1-liuhangbin@gmail.com>
 <38605efc-32f5-4c78-a628-11f8f07668f0@redhat.com>
 <20251023065517.2d3dfca0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023065517.2d3dfca0@kernel.org>

On Thu, Oct 23, 2025 at 06:55:17AM -0700, Jakub Kicinski wrote:
> On Thu, 23 Oct 2025 15:39:07 +0200 Paolo Abeni wrote:
> > > @@ -193,6 +193,8 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack)
> > >  	vlan_group_set_device(grp, vlan->vlan_proto, vlan_id, dev);
> > >  	grp->nr_vlan_devs++;
> > >  
> > > +	netdev_change_features(dev);  
> > 
> > Is this just for NETIF_F_LRO? it feels a bit overkill for single flag.
> > Also, why netdev_change_features() (vs netdev_update_features())?
> 
> Another thought -- isn't this a problem for more uppers?
> Isn't this what all callers of netdev_upper_dev_link() effectively
> need, and therefore perhaps we should stick it somewhere in the core
> (netdev_upper_dev_link() itself or when device is registered) ?

I saw bond/team/bridge/hsr disabled lro via dev_disable_lro() when add new
ports. But net_failover/ipvlan/macvlan and some others did not.

Maybe as you said, we can do it in netdev_upper_dev_link(), as some
devices may register first but not set upper dev link yet.

Thanks
Hangbin

