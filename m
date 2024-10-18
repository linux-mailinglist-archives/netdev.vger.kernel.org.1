Return-Path: <netdev+bounces-137079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4CF9A4470
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E70A6B2258E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7DA82488;
	Fri, 18 Oct 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HiH9c4m1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8F20E312
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271801; cv=none; b=EXbcItSaDaBkF6acb59VZV7SEh+KAx7cbjdovFlUzn3cOeURkna4WUffBv9P4ixtZ+i9xJf2rTQ2yavE70q9eOnTJAfzCMhb4RYUWfqaEkTRl7LP9OQLVvOLumR15SQFEGQ2brn8mWXP8lpmAFMNkkXYITRsfWbiIoprM+pyPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271801; c=relaxed/simple;
	bh=FCzib0r1Tbuf5gZAYxHppM561CNDVEk/n/1lZWjReB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hT1/0UXGVl5dqdMs+oz+6EsCSvE6xrhFZ+QiJBe/GFIVWV1VdHkj4Zc39CTeFSasisR1aTSDchpdqudJ69TyvjsF799gfvIpZj4oU2nHoQvhkUhwZMTx8Lpz2mv4kxjEcwbRuSFUs6f0VqQNb27tlW4PCAkbcUDn7i6Rl0rUrhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HiH9c4m1; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729271799; x=1760807799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pkKSB7wm0fqKdkit5Ok8L3c8oy5p2fmz+di5tCD+ZfA=;
  b=HiH9c4m1g5OV8TO7iVji6+HaRP1RXTfwt25jaevc+OTWTulT8QEbUQfA
   kta0xuHjIH2VoaB9fYxaskQ99oVW4bOOeWM5G8Ws/jW3ovnrrKlCFFq2A
   n8dE1W1hGhXhNzcJvZ0l2coDs9k2AUgOT84JzvJYzVW2gTc4KiKbY7kr3
   0=;
X-IronPort-AV: E=Sophos;i="6.11,214,1725321600"; 
   d="scan'208";a="344314648"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 17:16:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:15686]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 76ec3339-75bd-445c-9e9e-f1e33a33b320; Fri, 18 Oct 2024 17:16:33 +0000 (UTC)
X-Farcaster-Flow-ID: 76ec3339-75bd-445c-9e9e-f1e33a33b320
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 17:16:33 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 17:16:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <remi@remlab.net>
CC: <kuni1840@gmail.com>, <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 5/9] phonet: Don't hold RTNL for getaddr_dumpit().
Date: Fri, 18 Oct 2024 10:16:29 -0700
Message-ID: <20241018171629.92709-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2341285.ElGaqSPkdT@basile.remlab.net>
References: <2341285.ElGaqSPkdT@basile.remlab.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Rémi Denis-Courmont" <remi@remlab.net>
Date: Thu, 17 Oct 2024 21:49:18 +0300
> > diff --git a/net/phonet/pn_netlink.c b/net/phonet/pn_netlink.c
> > index 5996141e258f..14928fa04675 100644
> > --- a/net/phonet/pn_netlink.c
> > +++ b/net/phonet/pn_netlink.c
> > @@ -127,14 +127,17 @@ static int fill_addr(struct sk_buff *skb, u32 ifindex,
> > u8 addr,
> > 
> >  static int getaddr_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> > {
> > +	int addr_idx = 0, addr_start_idx = cb->args[1];
> > +	int dev_idx = 0, dev_start_idx = cb->args[0];
> >  	struct phonet_device_list *pndevs;
> >  	struct phonet_device *pnd;
> > -	int dev_idx = 0, dev_start_idx = cb->args[0];
> > -	int addr_idx = 0, addr_start_idx = cb->args[1];
> > +	int err = 0;
> > 
> >  	pndevs = phonet_device_list(sock_net(skb->sk));
> > +
> >  	rcu_read_lock();
> >  	list_for_each_entry_rcu(pnd, &pndevs->list, list) {
> > +		DECLARE_BITMAP(addrs, 64);
> >  		u8 addr;
> > 
> >  		if (dev_idx > dev_start_idx)
> > @@ -143,23 +146,26 @@ static int getaddr_dumpit(struct sk_buff *skb, struct
> > netlink_callback *cb) continue;
> > 
> >  		addr_idx = 0;
> > -		for_each_set_bit(addr, pnd->addrs, 64) {
> > +		memcpy(addrs, pnd->addrs, sizeof(pnd->addrs));
> 
> Is that really safe? Are we sure that the bit-field writers are atomic w.r.t. 
> memcpy() on all platforms? If READ_ONCE is needed for an integer, using 
> memcpy() seems sketchy, TBH.

I think bit-field read/write need not be atomic here because even
if a data-race happens, for_each_set_bit() iterates each bit, which
is the real data, regardless of whether data-race happened or not.

