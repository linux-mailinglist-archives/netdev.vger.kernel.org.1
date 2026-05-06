Return-Path: <netdev+bounces-284738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMIIN2f1+mk1UwMAu9opvQ
	(envelope-from <netdev+bounces-284738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:01:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21A4D78FB
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB0AC300F1A1
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A690C3E1D0C;
	Wed,  6 May 2026 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VQj7MScI"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E336EA86;
	Wed,  6 May 2026 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778054493; cv=none; b=IfkyTdT+AxMA/m02ezR3YVxheLjnh9hsbglGL5C6QwLfm9LBpeNBB9IWKl+dqykCFiN6OIi7rPIdCu3phQ0hL1hnag1d9g3wic9lfoVJ3yBUwo+TM6gdhPAbWbRjtkf5GNv2sXz1ufVUWUSG1H8fievf2QT1A63m+Qs5xq7oklA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778054493; c=relaxed/simple;
	bh=fEy/EElTG2y9S5Zv4ZGcII21zEVeNc+trnQ0Tex/jHk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbTZllXAn6FghHkUGJx07Diek0IYs6XK4gUN4E/rTlF0yzw/k/OTXHXaJHKSy1oFzpVhRUFlG4dWsjzEf58cHZas6T7+xNF476tSRQsof41ZjKRb1+Aq7W/L+ZyWS+CeTntobfrmbyenEmDi1P8DsEZSyADEIYccGf+PqxSBBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VQj7MScI; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1778054482;
	bh=fEy/EElTG2y9S5Zv4ZGcII21zEVeNc+trnQ0Tex/jHk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VQj7MScI5z6erM5Zh/UwdVC3UA5vu+7rMs6BlEAYHvEdD46ZyP+C+5F67+RCi0ijh
	 ruywhNWm91R/iS078hDx4s4vyqeNDVQBdOS98ql2sgp0NDzQ6E4PkwSRKf1iYlNvON
	 c1JRtU15PC8Wq4/PrPrsWe8sFn7CJPBT27d680zpg9SswdN3TRCLV/2d0OFT3vrNyw
	 ns22S3WlknyTPhn21FVQNgEX0QCDd2VRHcTWY96FZxYGfSPXis144OlPOOjJkkNpw4
	 oXhsDJCg8R8jeY4bNTz8o9np5W/CE8vQZPqAjhkieHY56ezP/TcOMp4k1XMouJ9cNK
	 JCebKXdfjyDEA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B713660417;
	Wed,  6 May 2026 16:01:20 +0800 (AWST)
Message-ID: <88cb1f245485d991b845886827876f27f11792ae.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp i2c: check packet length before marking flow active
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "William A. Kennington III" <william@wkennington.com>, Matt Johnston	
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Wolfram Sang
 <wsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 May 2026 16:01:20 +0800
In-Reply-To: <0c396f24-366b-49ed-ae84-9f1982866a99@wkennington.com>
References: <20260423001517.79219-1-william@wkennington.com>
	 <61bb1b3838609996600f46ccb2c4ff89d085ee6f.camel@codeconstruct.com.au>
	 <c94fc7c9-279b-4b4b-92f3-7f1b88bc0c64@wkennington.com>
	 <1651e98dcc86f38a0b39679b1a6f9ef604e0812a.camel@codeconstruct.com.au>
	 <0c396f24-366b-49ed-ae84-9f1982866a99@wkennington.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: DC21A4D78FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	TAGGED_FROM(0.00)[bounces-284738-lists,netdev=lfdr.de];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[codeconstruct.com.au:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[codeconstruct.com.au:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[codeconstruct.com.au:query timed out];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi William,

> > Just to clarify my understanding of the state: "being held by two
> > owners" would indicate a violation of the lock itself. Or is it that
> > there are two threads blocked waiting to acquire the mutex?
> I think it=E2=80=99s actually this, 2 threads are waiting on acquiring th=
e lock.=20

OK, that's good news!

> There was a theory that it was a lock underflow that allowed 2 threads=
=20
> to acquire the lock that lead to this patch.
>
> > For NVMe-MI, you're likely using manual tag allocation, where the tag
> > allocation (and hence flow state) is entirely controlled by userspace.
> > It may be that the NVMe protocol-level errors are causing that tags to
> > be held for long durations, perhaps?
>=20
> Yeah, this is very plausible given the device(s) stop responding=20
> correctly. I imagine we are getting stuck with manual allocations and
> not releasing locks. Can we reset the state machine back to NEW instead=
=20
> of holding the lock?

Not sure what you're referring to here; if the userspace application is
not releasing the tag, we have to keep the i2c bus locked, otherwise we
may not receive a response from the device.

The one case I can think of (in upstream infrastructure, at least) is
that this might be triggered by the device reporting a long MPRT value,
and then a response gets lost. libnvme is respecting the MPRT, and not
releasing the tag for that (excessive) duration.

However, the tag -> i2c lock associations are only useful if you have
muxes in the i2c topology. Is that the case on your platform? If not,
perhaps we could elide all the bus locking when we can detect that...

Cheers,


Jeremy

