Return-Path: <netdev+bounces-281985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIhpFoLg8GmoagEAu9opvQ
	(envelope-from <netdev+bounces-281985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:29:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7F9488E93
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75624303C330
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E533033F5;
	Tue, 28 Apr 2026 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYh+wyVH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GswFMkIv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0C1C860C
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393611; cv=none; b=o2/TYoh8nw1tQKUfyZuIij68NFTQtXq+AX7k8uURQbgnNRH+46cG413QnhqfI5w622cKhOSCJZGi5iYN1F5k6vv+OGJjl4ywlqzmdTH3lfaCkDpnUEuciPDANAr8JUsSByY1kWvOspV+HF3+pvXdlatJQVSnSOa2RPSBCwxN7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393611; c=relaxed/simple;
	bh=YOxrYOW2XiUYIkrw5Ws4BEeoJlv7piRCf57Qrembd30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tnl0Olf5i3u50vWC9zsz3QV37RVuPLyPFYgXxi76M6GX1fMspD7SLrWHv44V0hl3AlZvQpnyuuZjNCWp37zKFrsT3bY0oPJ+gtiaAQ+4I2hJuIqJGyDHGmasUZSeDRCa6Gamk4rTf4fMmPRXMEh+BXmSNwcMnfpITBlO4CkPPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYh+wyVH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GswFMkIv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777393609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrFHh+IXnC+/GYwS6dyvxdLC3SMZIfTMFwt74S3Tudw=;
	b=JYh+wyVHyA0poGbEghbO0T6zKPF8c2X0vr+FdDH4QyGuIxJ/+XpJpaCpY5GCsAvS1WrGTz
	+PUEPo14MRz4lDKYhL2BEoBXJtATpsPsOo2whlE3k41XzOY5QbG5QgQaXjrHmuottkeD7r
	geNVfodFsy+a+3XoQqnjRQ/JRfXL7l8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-4knaj0vZNjqdQKj2MR0TXQ-1; Tue, 28 Apr 2026 12:26:48 -0400
X-MC-Unique: 4knaj0vZNjqdQKj2MR0TXQ-1
X-Mimecast-MFC-AGG-ID: 4knaj0vZNjqdQKj2MR0TXQ_1777393608
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8eb52a22e85so2149598885a.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777393608; x=1777998408; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xrFHh+IXnC+/GYwS6dyvxdLC3SMZIfTMFwt74S3Tudw=;
        b=GswFMkIvYXD978xkY2uOlsE4scUqi8x2dBD8jSVxKtl54ackU0dVtRIC+fbSbomHMJ
         jGZX2FwrVpnkRF+7NRtfP5J1oB2lx2mrhld1whT9VuoQff1qfMlYx89wqMB567ipvcSb
         wGFx6+mSoILq5c0MHkLstzOvzdLV1yiQ/ZrT1YqaUrD3VCckIb2bvw7LwRmwJa2085BX
         6GQ0BHGrGYS+axJ0ArCN6rkrJsKWqz8bQyqw/gK98t3F2KDLFjaJI32HpbyZU4T9jDFk
         CMwwX0mo8CnH+L/ZbndeKtsiwYmu5wZpQg9MZG6IPhTvhAP0MHmc6+Vfk26r3vjbsIqR
         qYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393608; x=1777998408;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrFHh+IXnC+/GYwS6dyvxdLC3SMZIfTMFwt74S3Tudw=;
        b=iYAbuHf+XnM7d8kpGDJ2v4Mdytn3X/SVabCJ5fEDwWAbrINeR6/+XrUuM8GXkPN9+D
         EhgNN4hDbrN9X7ylB8ieti1MD5cx/mtlNJkKcqnoA32IU2kNJ3EPtQ2upyMTnTOo+QbO
         St8bMJTSdiAn46Zb4wp4LCmu3foIrSpzotVmAjzYhXu6ZXkwuKKwRrtnouf+4U8KdSCP
         I4RJAAosrdCB69QZi9NWWl9i9baU6MmDxBxl0RkbLFYvf2Z3kw2tHcRHxKpmcrgjovUt
         vlJA2snmtkwIEAsiW0vL9y89XsxnSEbEdbBSICZi6mfP2V+uLRwt+x9c3D5kIFBvSiyc
         U0gw==
X-Gm-Message-State: AOJu0YwtXrvVs7gEMKrx8+f0GoYO0T5lKaw+nsisOcT3nsYIpLkAlvFb
	43HRbr+caV7OvcPgnO/M97jBBvdsUkgaa1xax4J2DPj2PfrxrdcOzVKovuk91JV1+WAk1OlCrIC
	Fq6rMDusd4Q6kaFixyb3azIgdfE7fnv0sI6nF+auuSpvT8ldWNdGAjrtJCA==
X-Gm-Gg: AeBDieu8l35qH2QSaLlmXXPSM+GqJ4XW06FxOC9HP8Ff7PGzEgPzKBrwNqYVRA/ez9O
	fwvjjfkJqRbPqTSNXqqWJhdbYEJ1leYDbpTYVgyBOfYL+R4w7NnGJiEO6ayFpvFZzrchxI94Xqb
	Gr0FnVSjjd1yU2gge0J+RJ99ZH5pk7iQbo4CS2ylniJlHXf3zxG6q3BfTca8q8kRMSCheeqAynX
	/EoMf5/CJDcUccczAZUsaEIr13L5NWGLidnrv6ieyBnjQg9rvXgYrWjepd5Orom2DYx8+djbObg
	6eroDWK7uwnMuPXXrKU7kzRkygjyAHy2YlqLp5u9ZBXta0j4NQQBv0wYU4gaGTSIIO1JId9Ea6V
	s+z65OBaOu+JqNjVn01kYFiBeGV4=
X-Received: by 2002:a05:620a:17ac:b0:8eb:f3c7:2248 with SMTP id af79cd13be357-8f7d98fdd73mr490612385a.42.1777393607446;
        Tue, 28 Apr 2026 09:26:47 -0700 (PDT)
X-Received: by 2002:a05:620a:17ac:b0:8eb:f3c7:2248 with SMTP id af79cd13be357-8f7d98fdd73mr490605285a.42.1777393606834;
        Tue, 28 Apr 2026 09:26:46 -0700 (PDT)
Received: from m8.users.ipa.redhat.com ([2603:7000:9400:fe80::fc6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c7cd2c68sm233679985a.22.2026.04.28.09.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:26:45 -0700 (PDT)
Message-ID: <33613b11328d830f8683fc6ec6900da2b479ae27.camel@redhat.com>
Subject: Re: [PATCH net-next v2 0/5] Reimplement TCP-AO using crypto library
From: Simo Sorce <simo@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Neal
 Cardwell	 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,  "Jason A .
 Donenfeld"	 <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Dmitry Safonov	 <dima@arista.com>
Date: Tue, 28 Apr 2026 12:26:44 -0400
In-Reply-To: <20260427232054.GA2700@sol>
References: <20260427172727.9310-1-ebiggers@kernel.org>
	 <CAJwJo6Z9oJSMMBUL_pbYWN6ha3n4MRpKV_aVut8E+af3JUDFkw@mail.gmail.com>
	 <20260427200116.GA3454259@google.com> <20260427232054.GA2700@sol>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5A7F9488E93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-281985-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simo@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ietf.org:url]

On Mon, 2026-04-27 at 16:20 -0700, Eric Biggers wrote:
> On Mon, Apr 27, 2026 at 08:01:16PM +0000, Eric Biggers wrote:
> > > - Ronald P. Bonica (the original RFC5925 author), together with Tony
> > > Li do have an active RFC draft to support the additional algorithms
> [...]
> > > [1] https://www.ietf.org/archive/id/draft-bonica-tcpm-tcp-ao-algs-00.=
html
>=20
> For what it's worth, that draft makes very little sense.  For example,
> it proposes three variants of HMAC-SHA3, instead of just making the
> modern choice of KMAC256.  And it proposes both HMAC-SHA384 and
> HMAC-SHA512, despite them being redundant with each other after the
> specified truncation to 128 bits.

Which is bogus in itself without proper security considerations, the
only considerations cited is an RFC from 1997 ... clearly the pinnacle
of cryptography advice ...

If they need a shorter hash they should make themselves a favor and use
SHAKE and then define the desired output length and desired key size.
That draft is just a disaster as written.

Specifically they should use KMAC128 as defined in NIST SP 800-185
(which uses cSHAKE128 underneath).

Simo.

--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc


