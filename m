Return-Path: <netdev+bounces-280933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFoqC6/u6mn6FwAAu9opvQ
	(envelope-from <netdev+bounces-280933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 06:16:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69455459B35
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 06:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 210AE300C02D
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 04:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051C21146C;
	Fri, 24 Apr 2026 04:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BNISoCqY"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684D611E;
	Fri, 24 Apr 2026 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777004194; cv=none; b=Fy187EPxwYqqkEjL01mPvPTD7rnhIXqTJBeTa/vjrzTPAIWQFamEIY+3Rxrb1tlylbROso4KebFruwkVnTx7iJbw7hDN/PoX1FLti26hIb+2A8jiV3fkFv1qc6ItpE30J4VuZJYLYcUSMEITJMJ8tBsnx9yALL4/dneEmPx7iOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777004194; c=relaxed/simple;
	bh=myKpWR0QdMNH6RIf/Idoqfubh6hDKf8xLGAkjEuYn+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JlQzhsR1mB0U3dsjT2eYRzTTUBlvG23ApfEZS9xUnuhSd6VvRh1FXfCqv3uaG3NgH5i92FHRKY9euiMav3Oy+owSORS+1gt2vmCmBEfVz2QksskSeN94OHpfPO+MocY+MQhQEHSP3TVaJM0u/OSbsLZZDRMMstW5KhRZLO3gOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BNISoCqY; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1777004183;
	bh=myKpWR0QdMNH6RIf/Idoqfubh6hDKf8xLGAkjEuYn+w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BNISoCqYQvBArOoye6bzrSU6EbmhexQAF5jmDWC0vg4ZVRMimiy5cmBOKSR1gT9Tl
	 fbQPPRxi8UJYIKIkyml+p+EMQY0z+kd6/gtuEOyVsKAZNGxOHi5bzT8I4Cx/4GmNiG
	 JbZJl5nhxD/xnXDX3D2RWey2+XwVozjUfp2YiDdP+aJQpCloPZlTyQobZHyn8YEU78
	 2TCVpg1m909gV9azRJkz5flbgZf5mRBedmfaoNONVLwBYAJT39wq/eyiRHyXrI3Y0E
	 7ibvsBvGUzp8W/OoaHmoARC8UtBTpRm+v4CfvQldihaeWHbCDLiKKUtfTk21+boWDX
	 FqJs2pVSe1sSQ==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B637A6000B;
	Fri, 24 Apr 2026 12:16:22 +0800 (AWST)
Message-ID: <1651e98dcc86f38a0b39679b1a6f9ef604e0812a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp i2c: check packet length before marking flow active
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "William A. Kennington III" <william@wkennington.com>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Wolfram Sang
 <wsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 24 Apr 2026 12:16:21 +0800
In-Reply-To: <c94fc7c9-279b-4b4b-92f3-7f1b88bc0c64@wkennington.com>
References: <20260423001517.79219-1-william@wkennington.com>
	 <61bb1b3838609996600f46ccb2c4ff89d085ee6f.camel@codeconstruct.com.au>
	 <c94fc7c9-279b-4b4b-92f3-7f1b88bc0c64@wkennington.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 69455459B35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280933-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codeconstruct.com.au:dkim,codeconstruct.com.au:mid]

Hi William,

> > Out of curiosity though, how did you hit the hdr_byte_count mismatch in
> > the first place?
>=20
> Our current theory is that we have known buggy firmware on our NVME MCTP=
=20
> devices and we are seeing some kind of corruption on the bus that we are=
=20
> going to fix in on the firmware side.

OK, sounds good for the overall fix, but I don't think that would be
causing the path that you're addressing here. The fix is definitely
valid, but can't be hit through any RX data corruption (we're in the
TX path).

The header byte count is populated during header construction, so a
mismatch here would indicate modification of the skb between that point
at the actual xmit. Do you see the "Bad TX len" warning in these cases?

> We started also seeing kernel=20
> crashes along with the bad firmware symptoms, walked through ~110 kdumps=
=20
> and found i2c locks that were held by 2 owners (eeprom reading and the=
=20
> MCTP TX queue).

Just to clarify my understanding of the state: "being held by two
owners" would indicate a violation of the lock itself. Or is it that
there are two threads blocked waiting to acquire the mutex?

For NVMe-MI, you're likely using manual tag allocation, where the tag
allocation (and hence flow state) is entirely controlled by userspace.
It may be that the NVMe protocol-level errors are causing that tags to
be held for long durations, perhaps?

Cheers,


Jeremy

