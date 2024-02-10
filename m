Return-Path: <netdev+bounces-70740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5273685037A
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 09:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772BB1C21B52
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3772B9B7;
	Sat, 10 Feb 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xUmmVlux";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YlGVbRns";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xUmmVlux";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YlGVbRns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35063B3
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707552712; cv=none; b=EMrmphE6DbS0LAwCi9PLrgqFm6x1RQBNWokytQ/SDP3LPpYcpe4LRMSOWjTqba6EuzrN6+684F3G42X3QvDx9SyeszTX2R0ogVcIS6HygPTinkKZQ1UT1ZOEbasQqYo134GC/Tra9DVtEzd+/G1ZpKQ5iAmNKcRlxHZtJFSdy6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707552712; c=relaxed/simple;
	bh=NWSY+g42RZuy0xDi6w77zSNVGjZgJ+RbnDia10ISmcE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMoE1MGrS5T6lMOMMn1mDY7wMVdpuvjZFg1mkofBt0dO0NvCzhAFTmBRdtLqVb81Oo8Jf6Ju1/N0okItk32tFpIlMOnxz+Y06coBiPHKp+3/efqePJkk+IqmdxDW2sUFwJSmIaH/zX8r2Lh0dhIrlfsCCzmEw/tr5YfJwBSaYN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xUmmVlux; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YlGVbRns; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xUmmVlux; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YlGVbRns; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 947BA22062;
	Sat, 10 Feb 2024 08:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707552708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIKaYWQAHPQQKillJl7ieWf2e+NpOZ0s1E82u/VS/NI=;
	b=xUmmVluxO/If6cp2t39WrzwQIYOTuLAgJ9/LnQneDFzUBR0FIOntRQRi7c2SEsZj8fEafb
	0ZfFBCyLrquEMhGelyoccvD6SJHLrYWaxd5mmKEwLsvMiNbY5Ry66y+YURD69VPkVGIP4k
	7Hd3Y0ZpJ3RkvcJcK7Bf3WjxWHAwlfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707552708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIKaYWQAHPQQKillJl7ieWf2e+NpOZ0s1E82u/VS/NI=;
	b=YlGVbRnsvqLnPZ6W5s2EvUj4m7y6DwHYCKyIsWfciK5D8grAWc1OWrlPnGp5gbMsVNVOHj
	1fmxHiLwlhSZBHBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707552708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIKaYWQAHPQQKillJl7ieWf2e+NpOZ0s1E82u/VS/NI=;
	b=xUmmVluxO/If6cp2t39WrzwQIYOTuLAgJ9/LnQneDFzUBR0FIOntRQRi7c2SEsZj8fEafb
	0ZfFBCyLrquEMhGelyoccvD6SJHLrYWaxd5mmKEwLsvMiNbY5Ry66y+YURD69VPkVGIP4k
	7Hd3Y0ZpJ3RkvcJcK7Bf3WjxWHAwlfg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707552708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIKaYWQAHPQQKillJl7ieWf2e+NpOZ0s1E82u/VS/NI=;
	b=YlGVbRnsvqLnPZ6W5s2EvUj4m7y6DwHYCKyIsWfciK5D8grAWc1OWrlPnGp5gbMsVNVOHj
	1fmxHiLwlhSZBHBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EB6A13867;
	Sat, 10 Feb 2024 08:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B2REBMQvx2UTcgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 10 Feb 2024 08:11:48 +0000
Date: Sat, 10 Feb 2024 09:11:47 +0100
Message-ID: <874jegzqkc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Joe Salmeri <jmscdba@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	tiwai@suse.com
Subject: Re: Kernel Module r8169 and the Realtek 8126 PCIe 5 G/bps WIRED ethernet adapter
In-Reply-To: <c60e31ad-ddc6-4c93-83d3-d1255927c5d4@gmail.com>
References: <edabbc1f-5440-4170-83a4-f436a6d04f76@gmail.com>
	<64b65025-792c-43c9-8ae5-22030264e374@gmail.com>
	<208a69de-af5b-4624-85d5-86e87dfe6272@gmail.com>
	<55163a6d-b40a-472d-bacb-bb252bc85007@gmail.com>
	<f344abc6-f164-46d9-b9d1-405709b77bba@gmail.com>
	<7ee3893f-8303-46a1-a303-7a009031ca4e@gmail.com>
	<e7092019-dfe0-4d6c-96f2-2a1b909dc130@gmail.com>
	<87cytg1wiz.wl-tiwai@suse.de>
	<c60e31ad-ddc6-4c93-83d3-d1255927c5d4@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xUmmVlux;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YlGVbRns
X-Spamd-Result: default: False [-1.76 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.de,gmail.com,vger.kernel.org,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.45)[91.28%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 947BA22062
X-Spam-Level: 
X-Spam-Score: -1.76
X-Spam-Flag: NO

On Fri, 09 Feb 2024 23:01:27 +0100,
Heiner Kallweit wrote:
> 
> On 01.02.2024 08:19, Takashi Iwai wrote:
> > On Thu, 01 Feb 2024 08:09:21 +0100,
> > Heiner Kallweit wrote:
> >>
> >> On 01.02.2024 00:36, Joe Salmeri wrote:
> >>> You mentioned support showing up in the 6.9 kernel.   Was that correct or did you mean 6.8 which comes out in March ?
> >>>
> >> 6.8 is already in rc phase and closed for new features.
> > 
> > As those are rather trivial changes, I can backport the stuff to
> > openSUSE Tumbleweed kernel if the changes are accepted by the
> > subsystem.
> > 
> > Heiner, did you already submit the patch for r8169, too?
> > I couldn't find it, only I saw a realtek phy patch in
> >   https://lore.kernel.org/netdev/0c8e67ea-6505-43d1-bd51-94e7ecd6e222@gmail.com
> > 
> Meanwhile all relevant patches for RTL8126A support have been applied and are
> available in linux-next.
> 
> net: phy: realtek: add 5Gbps support to rtl822x_config_aneg()
> net: phy: realtek: use generic MDIO constants
> net: mdio: add 2.5g and 5g related PMA speed constants
> net: phy: realtek: add support for RTL8126A-integrated 5Gbps PHY
> 
> r8169: add support for RTL8126A

Awesome, thanks!


Takashi

