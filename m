Return-Path: <netdev+bounces-297986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XXvrN4NnKmpFowMAu9opvQ
	(envelope-from <netdev+bounces-297986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:45:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAFA66F7FD
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:45:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=lX1Je+dO;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=HbzqTIyX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297986-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297986-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6624301EB3E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB3367F2F;
	Thu, 11 Jun 2026 07:39:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D884369217;
	Thu, 11 Jun 2026 07:39:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163585; cv=none; b=g0MBpYnRBQOAuGMxvDr0yoXiGqDVA9yx6AyMy1WPio3RwOh82AvU3pNY81X4lrw9k7WhnG1LyUJaBKjHpbmnLVLs8WQKsrC+DKZuBxaz33SYz4EEJE7ByNDyhWMKAezLFg+iFlXIAVVkfgYTHbMlt5X9uLlarX1ZMHG30OR1sUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163585; c=relaxed/simple;
	bh=90BBj+30RkBnC5enEeGREaru5H8IbzHzWWrxHYg7QFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D16cFiR1jthoDrHNoRIdS4v8S1Zq6xUYb7dBSNcPM0CDdq8B7gdzV+o8APezyGvfdNOXtFptXJoucjvvyPgnhvnBpl9uR4aIrQgZ9hpWQBeXXrymaRW0kwWuuSUCCVBOneehtEhRWhF6PyXX5lVs5r2IiKvOY56HEI8t11Qxpjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lX1Je+dO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HbzqTIyX; arc=none smtp.client-ip=193.142.43.55
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781163582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90BBj+30RkBnC5enEeGREaru5H8IbzHzWWrxHYg7QFw=;
	b=lX1Je+dOYFG7la7cuX6b9dWIsBMcJ2h+QDYMdiNT37l6cvOTYfw7RZy+9OogqjUVE7yq3r
	Rc5n5ZkJ2cAnJgUrTpEsZMpyToMAM0DRQHTWdPiBE9pPePaEa6nsSkmtCXa4Cc2HiSdrX7
	aC232/pvC2XuRgKFH95Ytcwj4ML8OYOWJbDrmR31N9BSLMvQQwP/+C686Zh6UR8gqb/dDq
	U3ilhEBQsP9BtE2X7CdQMOfjl0oKNE7vyJ264ftX6U6oC15IhxdPHJwLOe1SkzaU1qXLfa
	WdYbH6E5jSJuQMO+EJEP1tOs8UbR8rSIxRX0DEx2z6ewFWpCVU5cBi1VA7B7Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781163582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90BBj+30RkBnC5enEeGREaru5H8IbzHzWWrxHYg7QFw=;
	b=HbzqTIyXPqZlgoo54Q8cK6+5x2jLlpDSvXgaOz1kfQtdxE1KaA/jgnuUfewCwR8C8XNNgR
	VZ35sCZquEmXvICQ==
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri
 Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] net: dsa: hellcreek: avoid devlink
 resource IDs collision with PARENT_TOP
In-Reply-To: <20260611070856.889700-4-mmyangfl@gmail.com>
References: <20260611070856.889700-1-mmyangfl@gmail.com>
 <20260611070856.889700-4-mmyangfl@gmail.com>
Date: Thu, 11 Jun 2026 09:39:39 +0200
Message-ID: <87se6t4jb8.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297986-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jiri@resnulli.us,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kurt@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:email,linutronix.de:from_mime,kurt.kurt.home:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEAFA66F7FD

--=-=-=
Content-Type: text/plain

On Thu Jun 11 2026, David Yang wrote:
> This might not cause real problems, but the hellcreek devlink resource
> ID collides with the sentinel DEVLINK_RESOURCE_ID_PARENT_TOP (0). Avoid
> it by keeping the real resource IDs starting at 1.
>
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Acked-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmoqZjwTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzghM5EACsrIP64HE7TceOpFHtej93JnJS4rcZ
cev8tr1CcY+Ak9vtfPBsZ1E5l3rxGxitC2jp8iKt1FYhaUATLGhNxwFVrh1ce06E
whxcKpmyHgdsbEZ8vMNkqH7Hsowxqef/GRqEopKu8NIppeD91XKWnzYEfL3DBeWT
JMq6WUw3/ifIatqhQAW6SV3jlUSI0hWw4RZjU4Y6H5Es/dv+7SeZ94W25egsfnuU
5TLrJiGvCr34oHRPY/JZiSHanc7o5R1iGjLXYOZvjZnVl3d6wh7L6SUyMY5Al0oq
pJFAkFqwj+v5CvzTI+M+7uRluAx7xycxLTHiDnVEQa9pXUhfOmvVFkhQ03YvzrHr
PoG5ewPUJJn9b/8OBvLidoyhmbhIBMp9RpdTunoTM1c+LWa7gd9MTwIwlDz4wTK3
Wrvh+wtqhxSfRZRF/AluW+sutQCmtBI3wn4wcugsZzusa7jxIlr3RF72EDOcm4Q3
N5N1humt4rwyawOTW3MT6FINfeEUWZb45u7czsTu8em0naAmkmLePpkfAIiCVSpA
dFNbYy1WNgKlTJgYTHExmziRdrHnl0PM9cxywEk+vDrTVZosKAQgy1iRIZegaQZf
F7K+kGk2xW3oesVfRZRVUQwtOAXHV2jJ/+0JwkYjs0hKc/GFy7COKiRC34VmeA9a
VT6K1NzCmdj65Q==
=TcEy
-----END PGP SIGNATURE-----
--=-=-=--

