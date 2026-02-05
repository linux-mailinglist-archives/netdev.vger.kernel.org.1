Return-Path: <netdev+bounces-256976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xRO4K4AvhGk90gMAu9opvQ
	(envelope-from <netdev+bounces-256976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:49:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0F1EECCE
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D684300EF90
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCE421A92F;
	Thu,  5 Feb 2026 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7ZBk17P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79835975
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770270589; cv=none; b=mqX0e8xoa7/SxhuxtEdcXhruxhN5KEd2bTR0hzd7ekTaTyEf+JgkpEolnG/DKt3534tJlRrE+29ERlG3S5LqoFBFCpF5mkaXpDLqzADobW5EGqDJdqtgvJ5x3XVZH3NBvdYhb5OncFRjth7wsQYV7V0xVhs4OYjl7BhxfTfIwyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770270589; c=relaxed/simple;
	bh=oigW+r2ll17N/8vVOo2Tasnmrl3lMwqxfoKQSEDokYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXRbUnHNo1WnLVJkcMUe82yl58gd8lxHhsXwOrfke/OBfWf+JveGgNa0tVjquZzf6rYcM9rHDAgZX4SCBaGNNTLqMKRB9AGD+O5AW9i31eP0NbHsAtvQU7xzhncXz+o10JK0t1meO/OMEMekiNIanqe7vCMOYaeaYH21ZQHMGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7ZBk17P; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c5384ee23fso53849085a.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 21:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770270588; x=1770875388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oigW+r2ll17N/8vVOo2Tasnmrl3lMwqxfoKQSEDokYU=;
        b=W7ZBk17PRrLlBpMLPfmhnHdJ1dKWcZSPsV2FI4AcVK6hPKJ+4VyMmSpYn/dIB5WxvG
         s6rVif5Cts4D0K/16vieK1o4YBKD0EI3W5hpH44FFRdI5lMUoiQhdtVdea3CQIDQoh+I
         jYKbhszYNVktBTCysjuK/AZlgXAu6GnJMNW1omPDmxq77pDJywSuaRMbuuRvPXhFXp9v
         cfZFre46xon4sVSbKPiMb3h4hiCm61jOTxOY0pcyG+KacAhZ9QlKAodsG8VXH4rhVxAR
         dwVU5lmR1hQEhBcixiANottWoo8pPu5a0iy6sJaxyXts4urqvrZKphzrZRyBeajBmlfQ
         UNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770270588; x=1770875388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oigW+r2ll17N/8vVOo2Tasnmrl3lMwqxfoKQSEDokYU=;
        b=pY9E20fauaNK4HTE4/frRqY9BGs5D4g6YZQOJIA6QSY+wrwrkmvkLvgX3zzijktY7u
         4NaW2c7AYko3UTSls2Ni+Fs4XZro/Jg3aMHcPD4/KSYqPUGgVYyNAZY/C629nqmM7nsi
         A8D1t4zYsC//QDZUSx8UvsnRpnZTO8P7Dh3DqPYg0N00XZbZpmaIb8TiFhy77YxMJQqR
         CYewXYsnT8hgADS0S6gERiZQVaVKHzNZGfk66iq7wQlFBJXRKBrj/fdjgmlu5CIFF9RI
         45+y+gcNbLLwhajA37WQTTSVKjcmZXacKqzDPOWL1sFpd3juPJRacwQ/YTzj/dKw2RAw
         PCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD5MDNFKRFU0I4o147RNCO2gNXdFCrw/NNRNdwE8oqYuETQm6pMRU78gSH9nNqlA0BVze4ZQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhvZzJForeuNruJzkMb9FTDjnSNwAcmMMqgV6CdUmW11GqiUW8
	NZ3Qg//bux/sk3i3myiweLMSgtUexGhuXgAiY4rCgKkDKKzhKw6+1K/e
X-Gm-Gg: AZuq6aLjwBowC0jNYOKHJeCl8pXZC1at6WVR3LDCwpcRKGQpPyNSBTJCbE8WUkBGvLF
	mDdyJUiJRxmamtTvoc2Irw001ijW2yB+EPAl1iVhqK/5lBn62UNpYmLhELb1e10daLLvzQomeil
	/C5gOu/VoTzTgQKKaoKAp4qBRVLRIWehGM3naHA8kVrGfhfasDMsYCA5f9OynmI0MWCsTEonYM1
	4jaKAJ3PoyTVHZFmSvJEftdw5EFRA6CxJq/Z1uDZJci2uz4Yql8XG3d0tp9sTPsC1B1niAxGdL6
	mmPIpaalljEwJ6wn3au2s9dKCNSFmuuQ3QJoxShUvIj/lWXUs1DkKzjonv8lF3eZzwss7H7/ot+
	SLheJ3M5it5J86JAXV/iYYwodtUIlwgKLTWGsn3Kkbn2Nif+WSYp7N1mgGT9xI+emZw35JLlbE6
	rSgmzKZpY=
X-Received: by 2002:a05:620a:4623:b0:8b1:adfd:f850 with SMTP id af79cd13be357-8ca2f83bfe5mr655910985a.18.1770270587966;
        Wed, 04 Feb 2026 21:49:47 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521c1a04fsm34592876d6.18.2026.02.04.21.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 21:49:47 -0800 (PST)
Date: Thu, 5 Feb 2026 13:49:40 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, edumazet@google.com, davem@davemloft.net,
	netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
	elfring@users.sourceforge.net, byungchul@sk.com,
	andrew+netdev@lunn.ch, h-mittal1@ti.com, danishanwar@ti.com,
	pabeni@redhat.com, m-malladi@ti.com, jacob.e.keller@intel.com,
	rogerq@kernel.org
Subject: Re: [net-next,1/2] net: ti: icssg-prueth-sr1: Remove unused workqueue
Message-ID: <aYQvdKUIcMdAUnuB@pek-khao-d3>
References: <20260204-icssg-prueth-workqueue-v1-1-9a892f4b293d@gmail.com>
 <20260205041702.2354424-1-kuba@kernel.org>
 <20260204201914.73fec717@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Jv5M08LD+MQV4go"
Content-Disposition: inline
In-Reply-To: <20260204201914.73fec717@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256976-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C0F1EECCE
X-Rspamd-Action: no action


--4Jv5M08LD+MQV4go
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2026 at 08:19:14PM -0800, Jakub Kicinski wrote:
> Maybe it's not worth separating the removal into two patches if there
> are surprising dependencies here?

Definitely.

> Squash them into one for v2 perhaps?

Will do.

Thanks,
Kevin

--4Jv5M08LD+MQV4go
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmmEL3QACgkQk1jtMN6u
sXGhxQf/VPEQ1+n0i5WJwMNoKnmYzjC+oR6X/EGKlYQeRHazBn9DH10JxDsEv1MP
rLc/fndeNia8H1+Mm8PvyRloGYulGXHtLpy9hM4fk08/VYi/QxUOOsaMqokEVc94
wblzvVQ5oMhsmgLMeXQX5Hgc/9U1cD4b6fhn1DIHOgvAw8DtAxWIR6oeflWMdm09
QuWsF+R7q4+DEnNZsSHPpapNLJ6nR+N1CUl5G9liBGypIi0X3ylFbsg36RxYZYi7
kUYY5ahPf0jNUkvuvWQrPvVO2fBAnJu8Ck/iRDm/GAgweUGRjosUZo0D/yTJ8xrO
R3db9kOjxQEmc85cYWBhLoFti1+IRA==
=hkZu
-----END PGP SIGNATURE-----

--4Jv5M08LD+MQV4go--

