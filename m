Return-Path: <netdev+bounces-121828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FD895EE50
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 12:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0437C1F2219A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E7D146A97;
	Mon, 26 Aug 2024 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p/atFNu6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="icregVG+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p/atFNu6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="icregVG+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8151146A86;
	Mon, 26 Aug 2024 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667439; cv=none; b=gmMBy9rVrh2uSHhE8iVmDfF5dtigzhMB7cRjLtMa0mLWh9c0kRdAoSfFYKf7y9P1hM7xi9+62W7jmmXxjTjXwrzuZttoTeJao4od8jhfpgIMMkQM9ucZm/iPvr3m+PyvjOWhj6/My5WbPgr9qy8x2kYp6h/3VgP8hJyVNkOiR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667439; c=relaxed/simple;
	bh=ZlqsWviY6SbceThz+ITeQZl5YJfFTLdrn1JLlvlRAwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGZIAMnTjSfYPTpcOT+xC1rLzUWKQHknYeJRSKJC06Nu//SPKlhwb87/P84XlyTvGXa+xiwJgF5jfyUAxcR2u+dA93TfmYuxxRJcs2e+awmGO2IkSYeCYYCHhcvneYwnMhnLTuBtWM+5YVXGVD6HNlEtHqc02UifkKK0NyMPb4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p/atFNu6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=icregVG+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p/atFNu6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=icregVG+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C4BB21AAB;
	Mon, 26 Aug 2024 10:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724667436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlqsWviY6SbceThz+ITeQZl5YJfFTLdrn1JLlvlRAwk=;
	b=p/atFNu6uZCulZsmXvs8qulhJ4+BsK7WCwO/hIdnW0quJNDWVq7qlNYaUtOt61CtRuJfVh
	UZVuxNVcCjXEDtXOaRNNu71dnxPAMXsZL8o7s2ARGwyMNhjgV4py60Igp/sook7gxxasEt
	YRwmjXJRplojAl6vlSlZZHepMOCxwyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724667436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlqsWviY6SbceThz+ITeQZl5YJfFTLdrn1JLlvlRAwk=;
	b=icregVG+aVtPac08LDn8CUAddwuYM/MxDH3o9KKcXaORSNoSpfH05fAdd5Exxq0TI4QjP7
	mcZaY9SD+AnCC3DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724667436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlqsWviY6SbceThz+ITeQZl5YJfFTLdrn1JLlvlRAwk=;
	b=p/atFNu6uZCulZsmXvs8qulhJ4+BsK7WCwO/hIdnW0quJNDWVq7qlNYaUtOt61CtRuJfVh
	UZVuxNVcCjXEDtXOaRNNu71dnxPAMXsZL8o7s2ARGwyMNhjgV4py60Igp/sook7gxxasEt
	YRwmjXJRplojAl6vlSlZZHepMOCxwyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724667436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlqsWviY6SbceThz+ITeQZl5YJfFTLdrn1JLlvlRAwk=;
	b=icregVG+aVtPac08LDn8CUAddwuYM/MxDH3o9KKcXaORSNoSpfH05fAdd5Exxq0TI4QjP7
	mcZaY9SD+AnCC3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB1A513724;
	Mon, 26 Aug 2024 10:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eMF7NCtWzGbFfgAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Mon, 26 Aug 2024 10:17:15 +0000
Date: Mon, 26 Aug 2024 12:17:10 +0200
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ice: Fix NULL pointer access, if PF doesn't support
 SRIOV_LAG
Message-ID: <20240826121710.7fcd856e@samweis>
In-Reply-To: <ZsxNv6jN5hld7jYl@nanopsycho.orion>
References: <20240826085830.28136-1-tbogendoerfer@suse.de>
	<ZsxNv6jN5hld7jYl@nanopsycho.orion>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.969];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -3.79
X-Spam-Flag: NO

On Mon, 26 Aug 2024 11:41:19 +0200
Jiri Pirko <jiri@resnulli.us> wrote:

> Mon, Aug 26, 2024 at 10:58:30AM CEST, tbogendoerfer@suse.de wrote:
> >For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
> >allocated. So before accessing pf->lag a NULL pointer check is needed.
> >
> >Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de> =20
>=20
> You need to add a "fixes" tag blaming the commit that introduced the
> bug.

of course...

Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on
bonded interface")

Should I resend the patch ?

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

