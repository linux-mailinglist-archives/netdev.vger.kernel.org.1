Return-Path: <netdev+bounces-147547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9399DA1AA
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 06:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E618B231DF
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 05:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146E413B590;
	Wed, 27 Nov 2024 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UwO1Q8v1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jCp5m+6a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UwO1Q8v1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jCp5m+6a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52579DC7
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732684591; cv=none; b=rymCrKKQxRC/A0eha8Gqp6/LEvYIEHEzUp1YPrkmWySU0aoAehl4v8gLa/SIxtMtbkm+yI9V1hOiENEzz5890gWLRk6dpjDXQPXdM8RPdeuZ180P/Jl5GGMCXCI/tKS02qauHDPMx2kdFJV2jYg0utVMjaon121IeMZYVIh6xlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732684591; c=relaxed/simple;
	bh=lwHdK8DqXlI11h3LtOiXzMbABd0XEf/T0A2760dxajg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZrKaLgReK4TYPdfgI2Is1ZCNmaQNUS06Si5Gu/CGJbVL/v3mjk3xU9xPKLHHU/+sH+hddW6XuBc940D6kjp7kwWhYAQ8x+tYHlSOb02mCA9IjyWL2PIpuSrG33/TUvXh3O1lzfygu1BQDMOKwKVQ69V6Vmk/YVuDfZiEgqetTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UwO1Q8v1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jCp5m+6a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UwO1Q8v1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jCp5m+6a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7EE9121168;
	Wed, 27 Nov 2024 05:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732684587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/Hkx+WgMD79JnBOEd/Rs4wDaPjtC8Mfd+e/aZcUacc=;
	b=UwO1Q8v1XTARuQ5Fi5P84Mtd9XsTj7ICddz/p2kII67vDPgxAz3dx+jf4liGRMY0+ggawr
	blMyzSpzhQpzANIGz2zx3q1TYONn/I3JOE+n/c5/J2BgTNyKak+W/42DE6nw4uqNaR1AS1
	7LCMgMTDmJpBHJU39+UJv1EovmjMLVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732684587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/Hkx+WgMD79JnBOEd/Rs4wDaPjtC8Mfd+e/aZcUacc=;
	b=jCp5m+6aT7f0i0HTtMXGN1o1Wgd2svUQHOTOo14yaMlfbpVRQ3dS9tZY4ryWzZweyXYiob
	VZaPRkvbsEgc5bCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732684587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/Hkx+WgMD79JnBOEd/Rs4wDaPjtC8Mfd+e/aZcUacc=;
	b=UwO1Q8v1XTARuQ5Fi5P84Mtd9XsTj7ICddz/p2kII67vDPgxAz3dx+jf4liGRMY0+ggawr
	blMyzSpzhQpzANIGz2zx3q1TYONn/I3JOE+n/c5/J2BgTNyKak+W/42DE6nw4uqNaR1AS1
	7LCMgMTDmJpBHJU39+UJv1EovmjMLVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732684587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/Hkx+WgMD79JnBOEd/Rs4wDaPjtC8Mfd+e/aZcUacc=;
	b=jCp5m+6aT7f0i0HTtMXGN1o1Wgd2svUQHOTOo14yaMlfbpVRQ3dS9tZY4ryWzZweyXYiob
	VZaPRkvbsEgc5bCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07D5113941;
	Wed, 27 Nov 2024 05:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nvAhLCmrRmcHdQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 27 Nov 2024 05:16:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Thomas Graf" <tgraf@suug.ch>, netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
In-reply-to: <Z0VQZnLaYpjziend@gondor.apana.org.au>
References: <>, <Z0VQZnLaYpjziend@gondor.apana.org.au>
Date: Wed, 27 Nov 2024 16:16:23 +1100
Message-id: <173268458312.1734440.13279313139938918812@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 26 Nov 2024, Herbert Xu wrote:
> On Mon, Nov 25, 2024 at 11:35:48PM -0500, Kent Overstreet wrote:
> >
> > That knob was. That's not what I'm suggesting. Can you go back and
> > re-read my, and Neal's, suggestion?
>=20
> That's exactly what the knob used to do.  Let you add entries
> without any limit.

And that is what my

  https://lore.kernel.org/all/152210718434.11435.6551477417902631683.stgit@no=
ble/

was designed to do.  If you are willing to accept something like that,
I'll try to find time to write a new patch.

Thanks,
NeilBrown

