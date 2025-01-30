Return-Path: <netdev+bounces-161642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265D3A22DB7
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 14:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E2E167009
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69341E3DEF;
	Thu, 30 Jan 2025 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BS0Gug+u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GFKGpyDV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pomLn+gj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NuwFBNSP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8157819;
	Thu, 30 Jan 2025 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738243605; cv=none; b=ecl5nf5r3ppcWF7c0iDoWgSZJo/KSuMR3xQIdoidOx/kQMlWTC9HrXVhgbEMPQBh109uNh6uvi6i+uIpUaFzUrFQnJBI7h1gxfsdp7/aJYiswkDEiQf0juMMob0RTg8YA0y51vaPbUUHA6XlfZ8yD4VeTgr1uv88TYU3BGui+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738243605; c=relaxed/simple;
	bh=o0W7CwYXiaMksx/uxQbxwSUNptgOd3iIBjTqvNBmsg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPxQ2Gl6MEOXzIncwzC/EJitjuutehbn9q6TX2moxs9VpFbUmGLC0aLt5BWaRf8FDqx/GvAxtcF7X9A9UOhrUZUF+2zWWKHApN53yMJPEs8e25TpdECSrQMrXPEeEl5C5+jYXCehURsHk3nVU2pr4+ctoxQ/p6jDNbKuJgAHX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BS0Gug+u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GFKGpyDV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pomLn+gj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NuwFBNSP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0CFD1F38D;
	Thu, 30 Jan 2025 13:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738243602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K2NSCqe89RUEievoFS2ztJqRbJIfGFt9yWV3cXB/As=;
	b=BS0Gug+uEwSEU9IqZBdZ9XJYDBQ70oV8BsBRMMYDaXRQ/0RFGnzDWtD2LuIwqqSmcU5LA+
	oC3pIvSr38LAf80zLm6YBC49gMUOgvLpsAnD0TP0rCwK/X577t0ZcK/9CKZnT/LaLBmn8q
	qjeIcZw7PNZSzaY8b2pSz1MN4HgqF9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738243602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K2NSCqe89RUEievoFS2ztJqRbJIfGFt9yWV3cXB/As=;
	b=GFKGpyDVOFS+12QZu8hFUplofOuXdxFMGXIRa1Doh7TXZEYuSt0jfzmbZ53UgBjUUistQ6
	UFfF5eyGq4FNwcCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pomLn+gj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NuwFBNSP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738243601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K2NSCqe89RUEievoFS2ztJqRbJIfGFt9yWV3cXB/As=;
	b=pomLn+gjgAW2HRZtVo6RWMDxca0ZsuBe6fWb+B2HH4FZOp3YO8nSmFM14U8BWA0lPEBTiT
	YHJGrZgqMNAWi4+DPDzbgQtCOAGeMSpnMlCjoHbMlSmBHu6mhmjCK7+po+gxnpWrgjBPk7
	pTuH07ayXELM1ri9D5CXEJb+yqAXKH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738243601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K2NSCqe89RUEievoFS2ztJqRbJIfGFt9yWV3cXB/As=;
	b=NuwFBNSPjljpOPCsvUO6Rc1CLSQpz19vDqqSjj5T27VOR+vXpM52YRkkOOOIb9nR8tVWS0
	Sc1uKbSof1an2TDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1AEF1396E;
	Thu, 30 Jan 2025 13:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCscJhF+m2dIXQAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Thu, 30 Jan 2025 13:26:41 +0000
Date: Thu, 30 Jan 2025 14:26:31 +0100
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] gro_cells: Avoid packet re-ordering for cloned
 skbs
Message-ID: <20250130142631.55651270@samweis>
In-Reply-To: <CANn89iKSrG40FKLpE3-qbftdXs9Goo61JfkmfXX_1=R5XV-=eQ@mail.gmail.com>
References: <20250121115010.110053-1-tbogendoerfer@suse.de>
	<3fe1299c-9aea-4d6a-b65b-6ac050769d6e@redhat.com>
	<CANn89iLwOWvzZqN2VpUQ74a5BXRgvZH4_D2iesQBdnGWmZodcg@mail.gmail.com>
	<de2d5f6e-9913-44c1-9f4e-3e274b215ebf@redhat.com>
	<CANn89iJODT0+qe678jOfs4ssy10cNXg5ZsYbvgHKDYyZ6q_rgg@mail.gmail.com>
	<20250129123129.0c102586@samweis>
	<20250129125700.2337ecdb@samweis>
	<CANn89iKSrG40FKLpE3-qbftdXs9Goo61JfkmfXX_1=R5XV-=eQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D0CFD1F38D
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 29 Jan 2025 13:06:49 +0100
Eric Dumazet <edumazet@google.com> wrote:

> "TCP Sender in namespace A -> ip6_tunnel -> ipvlan -> ipvlan ->
> ip6_tunnel -> TCP receiver"
> or
> " TCP Sender -> ip6_tunnel -> ipvlan -> ipvlan -> ip6_tunnel -> TCP Recei=
ver"
>=20
> In this case, GRO in ip6_tunnel is not needed at all, since proper TSO
> packets should already be cooked by TCP sender and be carried
> to the receiver as plain GRO packets.
>=20
> gro_cells was added at a time GRO layer was only  supporting native
> encapsulations : IPv4 + TCP or IPv6 + TCP.
>=20
> Nowadays, GRO supports encapsulated traffic just fine, same for TSO
> packets encapsulated in ip6_tunnel
>=20
> Maybe it is time to remove gro_cells from net/ipv6/ip6_tunnel.c
>=20
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 48fd53b9897265338086136e96ea8e8c6ec3cac..b91c253dc4f1998f8df74251a9=
3e29d00c03db5
> 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> [...]

this patch works for my test case. So the same thing should be probably
done for net/ipv4/ip_tunnel.c and net/ipv6/ip6_gre.c, too ?

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

