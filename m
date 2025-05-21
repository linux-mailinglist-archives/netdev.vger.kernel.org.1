Return-Path: <netdev+bounces-192139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45270ABEA20
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B1A1BA6251
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947C19B5A7;
	Wed, 21 May 2025 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQOd6G0X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3642868B;
	Wed, 21 May 2025 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796422; cv=none; b=Dgnk+ur4TN5cynGewEW+CxYVVWVSy9JXeMjkgDUNuT2VWXqCTLh3T9Y0a2KqKUE54c04GDvIQWlgt1sFJRh2OU6weQ3jkCc0vB9YphA+AWHNaLPS/p3gJZI4+GlTu9ge+ql9KMUwkSu5qUDswJ48LeoEqUHL2LRRoyr0QeGxrug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796422; c=relaxed/simple;
	bh=m+G5nHu6Bq5QPf4p+ILeCqIjJYylj+PUCNxI2yBZxho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdHuzzFC405cG+iXIzM7BCqcdqQis42idMF762i+OEU7CxTMghsROKyfduniq1Fg8fU7mBQtRlIiLvJakHe2AiHr3+MwnoWIYDW9OwzKokPRaNdwTJTMlxxCtMNvsRYii1B91dPBiDb7MI1dMH/QxXp94fhtYLzYtYVc0d+Zrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQOd6G0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5182CC4CEE9;
	Wed, 21 May 2025 03:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747796421;
	bh=m+G5nHu6Bq5QPf4p+ILeCqIjJYylj+PUCNxI2yBZxho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gQOd6G0XA3fsa3Ie4n85ShZVJ+UZ6M/AhZAvEkv53cSH0Q0xRd4NYgul0qk1sjK7Y
	 oOjugUw6pUJMj63xSNIiZknaJgOdd58CU2zqF3mpAl7o29IhuLZObYXVpa44EzPr3a
	 nEUNTeoYOWNKjwiS/2sqnu9FlNgIK6+Czl6anc6fMBgIiQuPE/AFbNeH2U8BzTQ/fk
	 MQoW+MWGO4TfikmfBAP2DSktAe9X6H+6eyvjDbfPu0iRC1mT41hjWqTbcpoDng1NlY
	 FVtFCNMNz32Ks4Xg0D53E5nTM1yy92J2ONXwl5INgWZrgvDrfcpT7COa09mtg+PrWb
	 JUfR7IPriZ5SQ==
Date: Tue, 20 May 2025 20:00:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
Subject: Re: [PATCH net] af_packet: move notifier's packet_dev_mc out of rcu
 critical section
Message-ID: <20250520200020.270ff8b1@kernel.org>
In-Reply-To: <682d3d5a77189_97c02294a3@willemb.c.googlers.com.notmuch>
References: <20250520202046.2620300-1-stfomichev@gmail.com>
	<682d3d5a77189_97c02294a3@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 22:41:30 -0400 Willem de Bruijn wrote:
> > @@ -4277,6 +4280,13 @@ static int packet_notifier(struct notifier_block *this,
> >  		}
> >  	}
> >  	rcu_read_unlock();
> > +
> > +	/* packet_dev_mc might grab instance locks so can't run under rcu */
> > +	list_for_each_entry_safe(ml, tmp, &mclist, remove_list) {
> > +		packet_dev_mc(dev, ml, -1);
> > +		kfree(ml);
> > +	}
> > +  
> 
> Just verifying my understanding of the not entirely obvious locking:
> 
> po->mclist modifications (add, del, flush, unregister) are all
> protected by the RTNL, not the RCU. The RCU only protects the sklist
> and by extension the sks on it. So moving the mclist operations out of
> the RCU is fine.
> 
> The delayed operation on the mclist entry is still within the RTNL
> from unregister_netdevice_notifier. Which matter as it protects not
> only the list, but also the actual operations in packet_dev_mc, such
> as inc/dec on dev->promiscuity and associated dev_change_rx_flags.
> And new packet_mclist.remove_list too.

Matches my understanding FWIW, but this will be a great addition 
to the commit message. Let's add it in v2..

> >  	return NOTIFY_DONE;
> >  }
> >  
> > diff --git a/net/packet/internal.h b/net/packet/internal.h
> > index d5d70712007a..1e743d0316fd 100644
> > --- a/net/packet/internal.h
> > +++ b/net/packet/internal.h
> > @@ -11,6 +11,7 @@ struct packet_mclist {
> >  	unsigned short		type;
> >  	unsigned short		alen;
> >  	unsigned char		addr[MAX_ADDR_LEN];
> > +	struct list_head	remove_list;  
> 
> INIT_LIST_HEAD on alloc in packet_mc_add?

Just to be clear this is an "entry node" not a "head node",
is it common to init "entry nodes"? 
-- 
for the commit msg:
pw-bot: cr

