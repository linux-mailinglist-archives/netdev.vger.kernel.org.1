Return-Path: <netdev+bounces-245948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A64CDB724
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 07:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93231301CEAE
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 06:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE29220F2D;
	Wed, 24 Dec 2025 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEBaIsKZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272312C859
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766556056; cv=none; b=cv9hdByTLqhwFLi5rplfAuRyg9nwHndEyb7r37P2XzZCtznhX4sVRr5sOu5Rk8IMRVwvtAtnRCWR/c5YHyjMpJJAv+50QcKGL4BoyfjEHKpi+BCv8WY+jycZAKoYeDa1Fro3lH0G+rqjgYwrepvyhzVYshPNPFdGTTMFxRwxA/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766556056; c=relaxed/simple;
	bh=4KnLqL/TEa3MSOZCB9dELfhSJRA432Z3mw/vi4VAXYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/uh5sLYh/WOZFGLSLm9nR/c3RLFZ6p8+FIwipCfO2jmxamEyDJgX656no5Tnu0Ls05OJNJ6E60gTD+V2g8EQGL6vlLewMiM160mR86Rjtu1N82JdD09OBnTazzZ9Sbyep3f34SqRdD958+cmwlvocRIxVuRu4wbDyofUFDCCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEBaIsKZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d67f1877so71294865ad.2
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 22:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766556054; x=1767160854; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WzCFPFhicgxdzEA495vvbt2R8Q18C5G3xxc5mmiZN3A=;
        b=IEBaIsKZFaef+plvg8LqTLJAnfhTZw/+1YeJz3SHZiTjn+v3hI9iIu2E2NSkvOln3K
         uPIL/QX75ZuCfWByC6c1hZrDOMQPgVDIHwMT3ZlzwGocueo+CERmriNM6jdeEHtES/b4
         GVs4rrJgjvdWLyvEgmhne+ou+r/2faXYFEXtPF0+4tmDR1+T3cyHnluAPnWsrHs+2N0c
         9aRih/K6YTbH1qV9V4hAHSCRInLBzWSiLsk0l5mnhDZ9fSioUnYIUP6JkAOpRkcqJqlW
         F4hCBkBHKnKA5TRDcKDvrak5Pr0XWLmQ02mPAFRogV2kcZ7mRj2dqwxE1z8zlARh4TeM
         N+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766556054; x=1767160854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzCFPFhicgxdzEA495vvbt2R8Q18C5G3xxc5mmiZN3A=;
        b=HIYkXYeUKqrvLphXU/3f2Hn1Hg/M2QsuHvqgtxNWRjpDxaGe7WVfW6UL3NHQvkUc3r
         0hjteq5wU+jcut0q/cQMarXsUSoHtPsj6JVSEW5zFs/cZbVoT7qG/dwlKWo1GSHzVk/b
         DYt0x5uXwGeH6XRn054sOpE90hsYe8xqBCbSPryOfx5uE88F77eAQ6wrC9rSBE/qNfUF
         tJpfp00y8WLAlbPA+6uItQbfJQfLUcffwDFZUXnJFU31S+ITIhSXQiDzv/h2WAzYZEpU
         wlHazm9qjVC+Y3iu4OZ5ZdxeN7SVKPOXmGBYfwusARL3mHMbaPhajHPszI4UOtRE4+uy
         3rGg==
X-Gm-Message-State: AOJu0YxqDSdhCTqKdapS2RF8PMs+OecGL4EUUXOVFH5N7vsaBgkMEn71
	b1hmwQiGPa8ioQMUBI8FvT/f/4Rsw0WFuF32GR+BYiy+1ykt+6Pq9Q5q5+RVV0cp
X-Gm-Gg: AY/fxX4t0+Nr72z3WGaBraxc/IbEBI+9VFTYK9uIl5Fvse48XnpwCqTWwq3neChWQCR
	1YcMw4sIqnsRkZgjldQiUL1dOwg5DeyQc5hH1y9pCkpfWjJK1EyNp2BDyns0g+zlO9UKn0UKc6T
	gdVw6YhjJm2YHwifvuKHBV3uSHg3omTftqqYxSXCje4lsh/OnvE5Wdu1ZTzmeOjNNbpDEvvYn7O
	MHbAvXDnAFzu1Hj2ZhK9mDjKfyaNPOp+n9+biU0MeJsc8CrifD4cyGscyCaxBnHS+wSKaLyaRRP
	wnBnB2omY4Wh5N2dCkRpv9d+joZb9IdhkYFXZ7YDQvZzHXFj4ueh7JM5YKxxYIp1zTbVPu1OcJr
	mZKanBofhkSxwFTY4s5LVFr7DimHI6i3QYX/kDbehwU6ipedAAfQ83a3TQ7VTZmE6oMbeL3G7ey
	gZllS2dOrRz5ADn0U=
X-Google-Smtp-Source: AGHT+IGfOj+dVSeKIOrW1erGR186G3lu1tALbRhdEfrye098/45mbPtRtgCKgPeOOt8aiPe7rzxZMQ==
X-Received: by 2002:a17:903:910:b0:29e:9e97:ca70 with SMTP id d9443c01a7336-2a2f232774fmr144161445ad.25.1766556054413;
        Tue, 23 Dec 2025 22:00:54 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c7263a3sm13305371a12.32.2025.12.23.22.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 22:00:53 -0800 (PST)
Date: Wed, 24 Dec 2025 06:00:45 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 3/4] net: bonding: skip the 2nd trylock when
 first one fail
Message-ID: <aUuBjZMNZiqwBnex@fedora>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-4-tonghao@bamaicloud.com>
 <aS1FPdC98q6wxviG@fedora>
 <10FF7526-38C4-4776-BA00-7ECF6E7E143D@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10FF7526-38C4-4776-BA00-7ECF6E7E143D@bamaicloud.com>

On Mon, Dec 22, 2025 at 10:15:07PM +0800, Tonghao Zhang wrote:
> 
> 
> > On Dec 1, 2025, at 15:35, Hangbin Liu <liuhangbin@gmail.com> wrote:
> > 
> > On Sun, Nov 30, 2025 at 03:48:45PM +0800, Tonghao Zhang wrote:
> >> After the first trylock fail, retrying immediately is
> >> not advised as there is a high probability of failing
> >> to acquire the lock again. This optimization makes sense.
> >> 
> >> Cc: Jay Vosburgh <jv@jvosburgh.net>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Eric Dumazet <edumazet@google.com>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Cc: Simon Horman <horms@kernel.org>
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> >> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> >> Cc: Hangbin Liu <liuhangbin@gmail.com>
> >> Cc: Jason Xing <kerneljasonxing@gmail.com>
> >> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> >> ---
> >> v1:
> >> - splitted from: https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
> >> - this patch only skip the 2nd rtnl lock.
> >> - add this patch to series
> >> ---
> >> drivers/net/bonding/bond_main.c | 16 +++++++++-------
> >> 1 file changed, 9 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >> index 1b16c4cd90e0..025ca0a45615 100644
> >> --- a/drivers/net/bonding/bond_main.c
> >> +++ b/drivers/net/bonding/bond_main.c
> >> @@ -3756,7 +3756,7 @@ static bool bond_ab_arp_probe(struct bonding *bond)
> >> 
> >> static void bond_activebackup_arp_mon(struct bonding *bond)
> >> {
> >> - bool should_notify_rtnl = false;
> >> + bool should_notify_rtnl;
> >> int delta_in_ticks;
> >> 
> >> delta_in_ticks = msecs_to_jiffies(bond->params.arp_interval);
> >> @@ -3784,13 +3784,11 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
> >> should_notify_rtnl = bond_ab_arp_probe(bond);
> >> rcu_read_unlock();
> >> 
> >> -re_arm:
> >> - if (bond->params.arp_interval)
> >> - queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
> >> -
> >> if (bond->send_peer_notif || should_notify_rtnl) {
> >> - if (!rtnl_trylock())
> >> - return;
> >> + if (!rtnl_trylock()) {
> >> + delta_in_ticks = 1;
> >> + goto re_arm;
> >> + }
> >> 
> >> if (bond->send_peer_notif) {
> >> if (bond_should_notify_peers(bond))
> >> @@ -3805,6 +3803,10 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
> >> 
> >> rtnl_unlock();
> >> }
> >> +
> >> +re_arm:
> >> + if (bond->params.arp_interval)
> >> + queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
> >> }
> >> 
> >> static void bond_arp_monitor(struct work_struct *work)
> >> -- 
> >> 2.34.1
> >> 
> > 
> > Maybe this patch should be merged together with patch 02, since the issue
> > was introduced there. Before patch 02, both should_notify_peers and
> > should_notify_rtnl would be false when the first rtnl_trylock() failed,
> > so the second trylock() would never be called.
> Yes, but Paolo suggested that put it in a separate patch file, because this code is unrelated from patch02. It's all good to me.
> “”"
> The above skips the 2nd trylock attempt when the first one fail, which
> IMHO makes sense, but its unrelated from the rest of the change here. I
> think this specific bits should go in a separate patch.
> “"

OK, then let's follow Paolo's suggestion.

Hangbin

