Return-Path: <netdev+bounces-305157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VXcWK8v5S2rAdwEAu9opvQ
	(envelope-from <netdev+bounces-305157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:54:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDAB714B42
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:54:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=N2AhnmO6;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305157-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305157-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ABEF3056AA0
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA6E343D64;
	Mon,  6 Jul 2026 17:12:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF0338939
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:12:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357936; cv=none; b=Q6mVoqCkOigpcD4OYNy5lGxzoyYIipyNvFDPFg6dBBkZqeV2p3+8ZAZHYYNSXqOItL7WjqlVSgfPQKOUD3QeG7fYOrhl551LJMF5r+vIGRcyv/hW6UFriwaVnSD1JhvmYcFLi0gbF2ihKXStIfOx7cgmjBOUaiS/Q9+K8WGDNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357936; c=relaxed/simple;
	bh=9Qaxnft5QcjEe+8OGMPo6pcL4qMHnO2VQLIGwoXXX70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLFNurcpusrK+MTIroNNt5dBHuIENcWYIdXw8nNyxh3fofA+82ND1BsbHfX6IwrQjmw3kCopdioJhpmB/tMLKon4s8IfHk0hvIS4VvaxNCoHwYCj6b6frHVWA9dirJcYtVIdt1v0Ewr52WKI1+CtKfxiPC0mwVHBgu7mIwD89MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=N2AhnmO6; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493d3135e9bso12576405e9.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783357931; x=1783962731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Qaxnft5QcjEe+8OGMPo6pcL4qMHnO2VQLIGwoXXX70=;
        b=N2AhnmO6qH2PcgazgauOqjcnYJCAfUD8BXzo0vfgNpSHNK3oQR7N/PcMILpCwT1KPq
         KmX3pQt0GsXNx5PsnLQvt4SVQzIwOJjNeDvkObkrVGuEd3NhS4Xgp5PjqNH7j2S3Qi0d
         CyVicMWbPZqZlTeB9nmghjLlRefD9oJocEeLVaODdqj7jul7BxX4A/6AqZLGqktOzXK1
         YX9sijuJy4Ll8gjKnNHAF99+I34v3OP0yWko8elnXAP2KIPs3JETNtD2oskPeH17Erzw
         DL8pVSar5jl7bHM+o8MKy0a/NWjL58cxnKQDAqImHhUIe/zen7npTRECQI7mo5pgOFmR
         3EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357931; x=1783962731;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Qaxnft5QcjEe+8OGMPo6pcL4qMHnO2VQLIGwoXXX70=;
        b=F+nTkLuuZofk6m237GQF1emGy6zko+OVLcxr4+3/GqaHJxjIMeyfwZ1ocprBzb6TQZ
         ZbFd031ME8i5U/YDxokVL9T2od4srTl6RjxoQJ5hEwOKkvKJGnUqlEeKCTpC9+1qqnyB
         I4l6k4YKZyWSKOJ+WXsAoY0mgsWNGmAor9s69DQuY/hYeQk0qckjS7nyL/3EhF3aB4wq
         qUg5JMd54UFEwzI9fK8xmIDYpkAT86ucZNHALliYV0m24QjI6TDcsAzNOjoGE2LmaViA
         GNwESP31GB3r08rwI/suKtMo0lyFo/z4KufvlK0vsO0+hFuh9AxhvWNnAFjQszssssPF
         05Tw==
X-Forwarded-Encrypted: i=1; AHgh+RqWmYCvJ1TvsZFLaUEFZoqoYS73XZr4MfpLWtyPZtYhA+5su+upYEqj9Lt7drI2cNifUJv4Dh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlp6ZFhAFZ8hT2uX/ljaxyqSkE/tEAAuYMwY7Y//NWiNHX3FAv
	MdomT/GbRyKK9IZXN31gVIDQOZ5GiO8jsU7Fn/I1gIM+gOv/AeEGPkNEYnRjhyeUTbA=
X-Gm-Gg: AfdE7clkuwXg1xjFeXWmSHAvxSJyeZAYETa/dUp42rV7r4a4+kURNPCdskK1F72+Xry
	kImr5rGp+sl+i0ZWZvtXljW1+8oCW+spsv6C+vZyOoTshVdHEZ9g1STlb9B7u3OjwRYZ7WS1TJb
	AO29WpgNmL17ULpUevmT6zh/thW71/EC4+KBkejv110Tt3f2ne1g09MiUiaGUPfgsQqEzJg6yKi
	rKTALdNLRzaSz/BtgMeRwza0wusD7CfM+bZnnGVBJ6thynWQz8XbVaZJ8u3ABxoqQrJN9s+VAvj
	njj3JL1JC3RkFXljfiEUVfGlQ/xTiSp0SJhB/AcnqwCZV9IUqbmlvD9wg8Q6Xj3LzN99lVvRGXB
	9/q0FUVQUEHOFu49YUay/7dfcT0BzcQ9EG0VASgbzBkNdnkY6QAYF5+Ul8xA105iJiyKW1TbAVp
	BZRyk2S3pD+f5YlqHweT9UgOZur55itSsRUUmodR4SQixiTu1FtPkyuaeu1dQd7xpytyKEOmDh0
	y4=
X-Received: by 2002:a05:600c:5395:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-493df076a4bmr16790325e9.31.1783357931631;
        Mon, 06 Jul 2026 10:12:11 -0700 (PDT)
Received: from localhost (p200300f65f47db0404eb41111570ffdc.dip0.t-ipconnect.de. [2003:f6:5f47:db04:4eb:4111:1570:ffdc])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493c6375764sm337785835e9.5.2026.07.06.10.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:12:10 -0700 (PDT)
Date: Mon, 6 Jul 2026 19:12:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Golle <daniel@makrotopia.org>, =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v5 2/4] net: pse-pd: add Realtek/Broadcom PSE
 MCU core
Message-ID: <akvhq1YcUFP6eizf@monoceros>
References: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
 <20260706112425.3149226-3-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="apc7am3fmzbmx2nr"
Content-Disposition: inline
In-Reply-To: <20260706112425.3149226-3-jelonek.jonas@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305157-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,monoceros:mid,baylibre.com:from_mime,baylibre.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DDAB714B42


--apc7am3fmzbmx2nr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH net-next v5 2/4] net: pse-pd: add Realtek/Broadcom PSE
 MCU core
MIME-Version: 1.0

Hello,

On Mon, Jul 06, 2026 at 11:24:22AM +0000, Jonas Jelonek wrote:
> +#include <linux/mod_devicetable.h>

Please only include those <linux/device-id/*.h> that you actively need.
I'm working on getting rid of <linux/mod_devicetable.h>, so please don't
introduce new users.

Best regards
Uwe

--apc7am3fmzbmx2nr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpL4eYACgkQj4D7WH0S
/k6+5AgAm3qO0xKJJhBH9p6HlFmRDo8vQdEDyKRnzn8xXCoR1DY35sx0w/TXAGjb
agwxL+lihe7DRNl9CoRJvSS7N0gUL1GYvceTOMqp+LY1hOkHJa8aVd6LxpGa3+E0
YD38sCkSBzrHuX5m77awrFD3HfcqGfSxqEPsY8Ew18i9ja0LpBQ3XEx3MTeOZZS2
1/IynC9RQj3xL5Q1QpTYsCSqAtCBu7zksVn+bCkTI/k77WEbX4RGs9uwMf7Futu8
CuaTJc1Fqjx7mlZPuqF6uWCB7u12JdMi6QnRk337CFf+B7FzgreNTL5qx6RPFEw4
it+yXyRgBxgFj/bfOuAqnHcEXp8iSw==
=A8qs
-----END PGP SIGNATURE-----

--apc7am3fmzbmx2nr--

