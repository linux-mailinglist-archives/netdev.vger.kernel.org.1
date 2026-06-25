Return-Path: <netdev+bounces-301808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XZfyJt17PGpWoggAu9opvQ
	(envelope-from <netdev+bounces-301808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:52:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 139036C20A0
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:52:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WxBuM8Z7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301808-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301808-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E58C23020115
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA893655F4;
	Thu, 25 Jun 2026 00:52:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF025B0B2;
	Thu, 25 Jun 2026 00:52:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782348762; cv=none; b=XF0oRSssby8JwvA+D3SuR3wfzsC1pNxmqutX44sVqaL0Oc2tnJxkO8V4FZKBPUHn8Pa23JZ2x2fXgVeSxxyY/fRdSnq7VGI6/BKrI7a1HpuybMczYGErldKAdlWU9ZEfIdp3TCK5S2VgMJmAP44mH5rKzuXixz0f9fcOZAJYw5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782348762; c=relaxed/simple;
	bh=0AMKS7tX3e7fNO25+P+PqfA4uB818tZGJjQJOji2fIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWf8Lax0DKD7waYN2sC5HOyhYCblkqeqJ+D+Bsl1gZCrc+QxAyBy+o3p+eIsMd94t6BCADoIJaSghX88OCs1Vk5bx+T95uhEDX+YaC8S2r6dV0W1bc38m/JuBzhxHWyALbv2lZOmZT4/MjkMyMpxC1MOo2GDjd4rByzfRBpLf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxBuM8Z7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2FF1F000E9;
	Thu, 25 Jun 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782348761;
	bh=VrwdlgDz+t1t50+a4QFA6MhIfgM+szbN6Qir7v/5OhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WxBuM8Z78ShcLFmBvjwBYuGOEXUjF2i0NFuhMDGtiJdKYdN8fqJUBDSNJvNuPP0ID
	 EjvnaRWy8/fnsCPzJHMLzaEuAr4twxjnijW84+PAHJowJZvV4bIcHM54pR8T2mqtXc
	 W54tH/8ovxcwbiQpDyvVUGYSs9LqwA2XmpXR41JUoYdsuVveKbA2Rb/oDXvWpDLEPi
	 w3oGOUUQjVp6paYiLn03qjSPCvWhved66LSY02nUzmxIoAikl4M6ystaDqhCrTjT4T
	 4GEpj5u717ZfsKg0UQRWuaav3kyHCHP8n1AKN3UWXV4oOzqt5MzVcYtK4Xxjp8oU91
	 83WP1nQzU0/5A==
Date: Wed, 24 Jun 2026 17:52:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: mxl862xx: avoid unaligned 16-bit
 access in api_wrap
Message-ID: <20260624175239.1b97aaa6@kernel.org>
In-Reply-To: <20260619100154.794168e5@pumpkin>
References: <599327521db465a534d277de53ab9b6cac01928b.1781702256.git.daniel@makrotopia.org>
	<20260619100154.794168e5@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301808-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 139036C20A0

On Fri, 19 Jun 2026 10:01:54 +0100 David Laight wrote:
> > The MXL862XX_API_* macros pass the address of a stack-allocated, __packed
> > firmware-ABI struct to mxl862xx_api_wrap() as a void *. The struct has an
> > alignment of 1, so the compiler is free to place it at an odd address.
> > 
> > mxl862xx_api_wrap() reinterprets that buffer as a __le16 * and accesses it
> > with data[i], for which the compiler assumes the natural 2-byte alignment
> > of __le16 and emits aligned 16-bit loads/stores (e.g. lhu/sh on MIPS).
> > When the buffer lands on an odd address these fault on architectures that
> > do not support unaligned access, such as MIPS32.  
> 
> Isn't the correct fix to not pack the structure?
> (or probably any of the associated structures??)

Agreed, this is very silly:

struct mxl862xx_register_mod {
	__le16 addr;
	__le16 data;
	__le16 mask;
} __packed;

But some structs won't get aligned:

struct mxl862xx_mac_table_clear {
	u8 type;
	u8 port_id;
} __packed;

So I guess the "just don't pack" will have some corner cases, too.

