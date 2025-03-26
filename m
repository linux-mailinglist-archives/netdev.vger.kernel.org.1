Return-Path: <netdev+bounces-177809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AE5A71D9B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D4F1889C7E
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 17:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D67219A90;
	Wed, 26 Mar 2025 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+5Oa9yC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC601F3BAE
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011035; cv=none; b=YjUDGs63RFZiK7XtBNkJhJeoUkTmklf9bLjnYPmYONkfHVYA3GjNAcGN39ztAwJ4HQywXgRvOEfTv+MMUcyESkaJ2QcT6fKkv/CQ0F7lb+KWiqIJjqOlJpmdcMA/z2bQvPfnfGKBFDIh/8UG+D57ZLZI72hwkvfjdLfi1QsHByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011035; c=relaxed/simple;
	bh=FMkJnTA0LCYHq0qm7IkZhFQkDO4ooZjWWIpjtI+qqQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhfebliq/eQ6s5RouUPh4qOZikp1LDV6SFVWDs6GUrb+w4L/kDZ8ebjLXITLxlaxKpC7qIre63lqBjU2KDd7cx/tTafVSjr2d8bRndVt7eiXivfmpWvErMEPFy6jMsRR3niaRDWYq7OEFUSHdGMx/e0SgdJTu6xjLbSzcqhQ420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+5Oa9yC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2243803b776so5523285ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743011032; x=1743615832; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PDIVG9s2JXZKnRJ+wRh+epyKgcjwWwGpC5K3EYrEuvk=;
        b=T+5Oa9yCRpXypIKmmT0/BG/XnSkhOJ8ykVey1zTP/MefbLfGs0UHMRlKCnZIoFEueY
         EBIR/x+lK1x0yCwz/or9MPEt6ZOEQpsFi1003R2OxVfU2se6C9mVPgrkTXvR4NaIuy2a
         lwfRDwD+8+mxB+fKVgQC644anIkBa3I4VCEIYMBIha7owQ1gYWc1TSy0a92qaqgI/UIp
         XRC+Hi7Js1NKy/ffq6vzY3+eNjznFTVjrfL0t0h6zzCC8qxwku7ZORKoM5d71+lS8WcZ
         Fg9Kch3POBlh7/1DerRi81UOOfVDLTOofwpFjt+kG22hVV6qMea07UmQVz0C+7pD2alB
         KbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743011032; x=1743615832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDIVG9s2JXZKnRJ+wRh+epyKgcjwWwGpC5K3EYrEuvk=;
        b=XO9Ip9DjZczoQvbPkZmwpt2z2fyLWGHhjK2UVHRhVjfkv25L+TS5tu1pCzoFhHa3eF
         AYh5yoXzHWxgW5i8uPNNRBiM3+hultHzEkgeskcyOLAq4oCt2A3k7wMcE8nev4/GeIN8
         a0h15aHOKArnv1O4q14XV07KNfOB56YeCBwF0/LI/xrPJgGCRDgBBMnAcWrxde/nIYRL
         ImM+vm07vTgfXMKe57zCvykxAsAEET0o7ttskJYFHPYSmYVZee1nGYUHU7t8E/jW9MfD
         4ld8DEr4facDEnvZ/u007PmbDWAvO7t/fXxWRqzDsfN6Vk3P9hetiJiobAkMKwQmAbhr
         GL8Q==
X-Gm-Message-State: AOJu0YwGDk+I7yJbM3jTARptVwAo6+8aV64LrpUtBaMQf1vAz4baoxa5
	OGFn0ddL55CQKuDNTEx8C6uK9gjTVEokZwGbOmtMkZviP+2Us1A=
X-Gm-Gg: ASbGnctlG8i1ucYMvG/xIBP2/nxx0fA5U1NknNmXBBIKrnYc9bp52oqM6nZ1VDkmVXf
	CNl8lDztARrTw6ueXZUNSZs0dkMmNEuBMtFLalW0jnetrSr/dPYnXojnA0Xex0FgWhclsbbvGNH
	NBNkV0nOb5yH9umZozlybu+t+YaL5J7M7QqatjbFhJ9iEcEAgazqAba0C7G969J+gJHx8HWWX6N
	YsWXj1GZfsZH72LknHCirFa9nf6LfDMzRq8k8KeWDmenZXjmi2WzLHCsxpH/McdeoAABXCkkYIq
	/UBVRQXnoyvtbRTt4PyGvPv3pXU/boD4KeCzKvrhbTWO
X-Google-Smtp-Source: AGHT+IFUBx7ETb/N1f2CyTLrrw0yum8Fyx+ftvB4yD6ZdKRkmV1LpjLt150wARPcMb6+5QBSFOEeSw==
X-Received: by 2002:a05:6a00:998:b0:730:99cb:7c2f with SMTP id d2e1a72fcca58-73960e2cfaamr547839b3a.6.1743011032296;
        Wed, 26 Mar 2025 10:43:52 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739061598f2sm12585031b3a.153.2025.03.26.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:43:51 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:43:50 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/9] net: hold instance lock during
 NETDEV_REGISTER/UP/UNREGISTER
Message-ID: <Z-Q81rFZ2BW_7fYY@mini-arch>
References: <20250325213056.332902-1-sdf@fomichev.me>
 <20250325213056.332902-3-sdf@fomichev.me>
 <86b753c439badc25968a01d03ed59b734886ad9b.camel@nvidia.com>
 <cc1597b12b617cbb62d325285c3a50bfb2b1ce1a.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc1597b12b617cbb62d325285c3a50bfb2b1ce1a.camel@nvidia.com>

On 03/26, Cosmin Ratiu wrote:
> On Wed, 2025-03-26 at 15:03 +0000, Cosmin Ratiu wrote:
> > On Tue, 2025-03-25 at 14:30 -0700, Stanislav Fomichev wrote:
> > > @@ -2072,8 +2087,8 @@ static void
> > > __move_netdevice_notifier_net(struct net *src_net,
> > >  					  struct net *dst_net,
> > >  					  struct notifier_block
> > > *nb)
> > >  {
> > > -	__unregister_netdevice_notifier_net(src_net, nb);
> > > -	__register_netdevice_notifier_net(dst_net, nb, true);
> > > +	__unregister_netdevice_notifier_net(src_net, nb, false);
> > > +	__register_netdevice_notifier_net(dst_net, nb, true,
> > > false);
> > >  }
> > 
> > I tested with your (and the rest of Jakub's) patches.
> > The problem with this approach is that when a netdev's net is
> > changed,
> > its lock will be acquired, but the notifiers for ALL netdevs in the
> > old
> > and the new namespace will be called, which will result in correct
> > behavior for that device and lockdep_assert_held failure for all
> > others.
> 
> But a thing I've learned many years ago about locking is that locks
> should protect data, not code. Shouldn't we avoid locking deep call
> hierarchies (like notifiers) with the instance lock and instead focus
> on 1) what fields need to be protected by the lock and 2) reduce
> critical section length for those fields.
> 
> That plus reference counting usually does the trick and should avoid
> these ugly deadlocks.

We want the operations to look atomic from the userspace if possible.
So the whole device is either moved or not, some other thread should
not be able to change, say, mtu mid-way.

And we do try to clarify what's specifically protected in terms of data:
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/include/linux/netdevice.h#n2494

But the notifiers are super tricky. There are years of natural growth
with the assumption of a single rtnl lock :-(

