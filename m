Return-Path: <netdev+bounces-161482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41729A21CC5
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F1F167152
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89641C831A;
	Wed, 29 Jan 2025 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JjGk/jZ9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xeK6wOw4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JjGk/jZ9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xeK6wOw4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8C1D8A16;
	Wed, 29 Jan 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151828; cv=none; b=V8OfBh4+WVQRhU0foCd4FC5jji9B1nT7Arwap4SHHqirvm4wujPeXrKQVMzop+lEFgHMiyzCbihsvhJixAmv9pns3b+EvHlrNpzQl7JQfX6Xsl6+P1VcwJTzCkcVkWv6/Txcsyz+lmSw9buTpYCxRTQxwZUiwD27L38XJoM3MI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151828; c=relaxed/simple;
	bh=f/Yv5FpH9xCbPRqBlK/YMIkmTd/lFyaH/6i6ZGUdHp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eErqiZcCrbnhoZGxzRo3VjhnieZ/FbtOpeob9tjPO73Fm9+DPiscMqaI7kPiWT25aen4R2fjG/2TrTH0eKSbMJK02GRmfyluQFpr5rdXWmCtYhXT0WjKE0SBqK6K+xh5Ive3crknsbEpuJHp+7sNSAw66VmJQdjhXnjqev3Yvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JjGk/jZ9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xeK6wOw4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JjGk/jZ9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xeK6wOw4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28F79210FE;
	Wed, 29 Jan 2025 11:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738151825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6csAmdtxGoBAMBdYCBlVvZwJ0nvr7epfYlm1x3fUIqw=;
	b=JjGk/jZ90W/usLuFUUABIpVZyzxRpYHqxJt8QsT0/bI3htTKtTl87tTOrl1VA0qI70OnhD
	NHBeKDXpYcouv7CHU/J9FQ2HU+flXLYq5uAzgSopypsqg+YlU9Z2Ln9MKeAeCLV8gXBj+3
	v0am3CltSfGq7iojQZwOXGgfmJiXcLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738151825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6csAmdtxGoBAMBdYCBlVvZwJ0nvr7epfYlm1x3fUIqw=;
	b=xeK6wOw4pqohFXj7tdLZpbYh5iBgmzz46kE+mX4pXFiNS2nmXROa8qjt4I/5uP9NFle6iL
	4gocAF4cmIgDFOBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738151825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6csAmdtxGoBAMBdYCBlVvZwJ0nvr7epfYlm1x3fUIqw=;
	b=JjGk/jZ90W/usLuFUUABIpVZyzxRpYHqxJt8QsT0/bI3htTKtTl87tTOrl1VA0qI70OnhD
	NHBeKDXpYcouv7CHU/J9FQ2HU+flXLYq5uAzgSopypsqg+YlU9Z2Ln9MKeAeCLV8gXBj+3
	v0am3CltSfGq7iojQZwOXGgfmJiXcLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738151825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6csAmdtxGoBAMBdYCBlVvZwJ0nvr7epfYlm1x3fUIqw=;
	b=xeK6wOw4pqohFXj7tdLZpbYh5iBgmzz46kE+mX4pXFiNS2nmXROa8qjt4I/5uP9NFle6iL
	4gocAF4cmIgDFOBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F19F7137DB;
	Wed, 29 Jan 2025 11:57:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 54eFOZAXmmevQgAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Wed, 29 Jan 2025 11:57:04 +0000
Date: Wed, 29 Jan 2025 12:57:00 +0100
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] gro_cells: Avoid packet re-ordering for cloned
 skbs
Message-ID: <20250129125700.2337ecdb@samweis>
In-Reply-To: <20250129123129.0c102586@samweis>
References: <20250121115010.110053-1-tbogendoerfer@suse.de>
	<3fe1299c-9aea-4d6a-b65b-6ac050769d6e@redhat.com>
	<CANn89iLwOWvzZqN2VpUQ74a5BXRgvZH4_D2iesQBdnGWmZodcg@mail.gmail.com>
	<de2d5f6e-9913-44c1-9f4e-3e274b215ebf@redhat.com>
	<CANn89iJODT0+qe678jOfs4ssy10cNXg5ZsYbvgHKDYyZ6q_rgg@mail.gmail.com>
	<20250129123129.0c102586@samweis>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed, 29 Jan 2025 12:31:29 +0100
Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:

> My test scenario is simple:
>=20
> TCP Sender in namespace A -> ip6_tunnel -> ipvlan -> ipvlan -> ip6_tunnel=
 -> TCP receiver

sorry, messed it up. It looks like this

<-        Namespace A           ->    <-        Namespace b             ->
TCP Sender -> ip6_tunnel -> ipvlan -> ipvlan -> ip6_tunnel -> TCP Receiver

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

