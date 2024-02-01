Return-Path: <netdev+bounces-67844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358278451D8
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53BFB22DA7
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47C21552E8;
	Thu,  1 Feb 2024 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bo+OXXKp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kcxyNRo6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bo+OXXKp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kcxyNRo6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190071586D2
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771992; cv=none; b=RGFV8AiJAKbA5Ny4tgI5o+VW+l8GlYZlwwWYSXBp7dyVgf7QG3T1KVOfjQ8Oqydu/o3IQyKUGoLhN6BJerxTFua4CUsQdihtWHNi5uflZ4Ps3NkUWbn6Y7hBqeEAs+M4h2RwqPMS7QkHOFT5XNgtqmg6wrZUs5dAMvE2GQz+JJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771992; c=relaxed/simple;
	bh=+91a28CLUGMyXMzV68n0pHKrGbRfAn+jHF8/dS6BdQ0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adD5r6wu3SD7tRW0ILkoJinedYDAkOLUWMlAw2bBM9l7jKxeHipbizxhJM5zoLGEnubiGmJt6qx47BfystpVw3yFek2tOawi9+e0qYGNbnr8nZrrZVkAlsOwEG0D/vqsg8/MzTxfbSFkiQz+TS2SbQPEcGlC4pYM7K4/Rg6+RCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bo+OXXKp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kcxyNRo6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bo+OXXKp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kcxyNRo6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 458201FB8D;
	Thu,  1 Feb 2024 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706771989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tU3HZ8TRhIa1ljHB/7xlkHMq8P+0Mu3fKjcUBBNSlKo=;
	b=bo+OXXKpp4nRZ3h3zNsPWUxWTEH7D601LlHYTJIi0Oz55ovDbdrFzRWxXGzMQfmPMCu/8m
	8Em2iz0jxz4ZtcSOhFYYDSPBy+mack9VoZdILHWIC2E5jTZt7Prnys/AQ4zcNZyQIhZCKX
	k06LFdvpUAfV5U8A/ogM3HSNGhjfD2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706771989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tU3HZ8TRhIa1ljHB/7xlkHMq8P+0Mu3fKjcUBBNSlKo=;
	b=kcxyNRo600jiD7pMAO7DsTnwOyA6wp9u/mS4SwEd7Nxjh6o6V0pLzxxWSpf4hoUtPHOnFO
	Om9tqMpQ5EQYXPAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706771989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tU3HZ8TRhIa1ljHB/7xlkHMq8P+0Mu3fKjcUBBNSlKo=;
	b=bo+OXXKpp4nRZ3h3zNsPWUxWTEH7D601LlHYTJIi0Oz55ovDbdrFzRWxXGzMQfmPMCu/8m
	8Em2iz0jxz4ZtcSOhFYYDSPBy+mack9VoZdILHWIC2E5jTZt7Prnys/AQ4zcNZyQIhZCKX
	k06LFdvpUAfV5U8A/ogM3HSNGhjfD2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706771989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tU3HZ8TRhIa1ljHB/7xlkHMq8P+0Mu3fKjcUBBNSlKo=;
	b=kcxyNRo600jiD7pMAO7DsTnwOyA6wp9u/mS4SwEd7Nxjh6o6V0pLzxxWSpf4hoUtPHOnFO
	Om9tqMpQ5EQYXPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 180CD139B1;
	Thu,  1 Feb 2024 07:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rQ+3AxVGu2UnXgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 01 Feb 2024 07:19:49 +0000
Date: Thu, 01 Feb 2024 08:19:48 +0100
Message-ID: <87cytg1wiz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Joe Salmeri <jmscdba@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	tiwai@suse.com
Subject: Re: Kernel Module r8169 and the Realtek 8126 PCIe 5 G/bps WIRED ethernet adapter
In-Reply-To: <e7092019-dfe0-4d6c-96f2-2a1b909dc130@gmail.com>
References: <edabbc1f-5440-4170-83a4-f436a6d04f76@gmail.com>
	<64b65025-792c-43c9-8ae5-22030264e374@gmail.com>
	<208a69de-af5b-4624-85d5-86e87dfe6272@gmail.com>
	<55163a6d-b40a-472d-bacb-bb252bc85007@gmail.com>
	<f344abc6-f164-46d9-b9d1-405709b77bba@gmail.com>
	<7ee3893f-8303-46a1-a303-7a009031ca4e@gmail.com>
	<e7092019-dfe0-4d6c-96f2-2a1b909dc130@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.45
X-Spamd-Result: default: False [-2.45 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.15)[95.94%]
X-Spam-Flag: NO

On Thu, 01 Feb 2024 08:09:21 +0100,
Heiner Kallweit wrote:
> 
> On 01.02.2024 00:36, Joe Salmeri wrote:
> > You mentioned support showing up in the 6.9 kernel.   Was that correct or did you mean 6.8 which comes out in March ?
> > 
> 6.8 is already in rc phase and closed for new features.

As those are rather trivial changes, I can backport the stuff to
openSUSE Tumbleweed kernel if the changes are accepted by the
subsystem.

Heiner, did you already submit the patch for r8169, too?
I couldn't find it, only I saw a realtek phy patch in
  https://lore.kernel.org/netdev/0c8e67ea-6505-43d1-bd51-94e7ecd6e222@gmail.com


thanks,

Takashi

