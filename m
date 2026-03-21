Return-Path: <netdev+bounces-270204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IoXOLKMvmkLSwMAu9opvQ
	(envelope-from <netdev+bounces-270204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:18:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 431C02E5436
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBB41300CE69
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696732DB785;
	Sat, 21 Mar 2026 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFuanRLu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF07282F09
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774095514; cv=none; b=B+XfBmjqu206Mu+llaVD+BT4Zms8N8BtTIlYNwEVTgI9KfdE65pGUkDcbcKQDXrU4HVXjx/bXsrX0yC9Awz5RGu9NOkUy4GOwLayZx7NRyg8Zsv/jAKu10RKbXxHu53dsv2AxpvpKTqJc6h09edfOHVnPGWqWKYG2aRMUg4gwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774095514; c=relaxed/simple;
	bh=Y75XoYqKXvJELNiUFoBpV1yJXIJ4ij7GQ1MqArWPTFI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smCIC+DmrXBJva/LSoUA0VVPzVMrv3C4H+arbATmzUp9trf690dKtlGu6CsfF55rlYkXMdj4rqUx2V06+7gHk1RaiyG1xc/zfSNfX8hZlhtRhR6UTC2mLRaetn4wZHvD+OajoLz8q7o8GjniLe3FT1oif8LyDuzlBoj7NBbwfCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFuanRLu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4870206f73bso6590855e9.3
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774095511; x=1774700311; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y75XoYqKXvJELNiUFoBpV1yJXIJ4ij7GQ1MqArWPTFI=;
        b=UFuanRLu7gNAH2E9O4fsqe9AS1Z2gO2NvDudhdxWFY7LKDzOWAAVzSN8yA1rjoa2T9
         a2S4lObS5B8JWEEYouuCACf7tSx60bNHEi1vSW/pDJafF4QAKICUZU5gb1FjEbe5C++z
         MVCw/hWOZzs3xSNRwjZp7O7K6tOIXJ8GNLHQp/GDaN+jylijMONRrVnV7rM2G/rqCpDB
         /vGS2C97Gx9raJHuiOVO96qiRZafFzd1jIg/b/T+JxvDHe6jm9c3DMjAEyc+hNpwXMim
         RmGrcxZU1x8y7WUsdoVOsUJYlFSJ4W70LTBZFewUmUyt3Cel/CHtI3PcKA8fJicJOZOr
         0JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774095511; x=1774700311;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y75XoYqKXvJELNiUFoBpV1yJXIJ4ij7GQ1MqArWPTFI=;
        b=Ie1vpAX2vrjLJfXYQ8qK7FDEwTEHPGVMcwQaiKxxhd1IDvE1GxRdIdrwmuo2jxHq27
         R89ktX5V3iMUDlpxsK/QBDnq0uFJ6Cw7TKw3wSXKfoMDnoctgKWTxL1fpQFaD3CkLv5K
         LZKvZ2aI3gHthVRp1Twil6WOris6Oj/NsczxMnFUfTnWEzeVTGqKeQbyEnPNJOXY+Czo
         djC4VnmAPcvvg5+o15hMN7U87P9glC+S9cny7xNiTXpwNKwuQjPmWYpuvoPAzH2Ofyxs
         73ktsX04nTq7Azgiv2Rv5THcjVGwfa7Cc1bmIiDXWgyQwPgXMUWjLo9RNmDG/VjQhtn4
         NbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlCIPyJhUAZRt9654qa1CZJX9q/gfpyCSm1I2EW475JEh2Kdqe5fuUe0KQewAx63z6nGeadAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmACWEWvKVjGow5dKIkWsUpAKHAhp0fNDkiLG907EDe/mNrn4k
	BAgv0efyXBsH1xzN2ryvkYxFh4d7oC24pLvHgFs4VGm2gsHw3jUx6Xmzl6AyfA==
X-Gm-Gg: ATEYQzwAq/aJ7esvg+Ubxhw7uEULiVauSovJylqwcM0Vi1Tk0k3WpAObFh+Auz30UKV
	A5MjP1WjePzsg3tOdgguKrvIeCOrkJfvIxWAsvfQihGS7/ujkBG9Y+yTLEBbDoENNtUbGpXcKrF
	W+1V5Tv/sstgqzXl4Ut7/ckf4oadZ+M8G2Vh9AaW60K28kUZOnU3GO8GLK3C1ibotD6VvCIzuEL
	hpyZpnfe2KZdJTeYNebrN0/1GcIx25mx2m4/NsBPeaDOS5PtjWpyY5pXOZLKPRm3nHdm0uMqrQE
	nsbPLPmhEABlJInSrLcuIGW3gjZiwL1e6BBD+8kItFQKtsH+5Gfm+PIxATzkNsfcVZRvAr7ORMp
	W4at84CXiD98A69kiO9VTWvP89uj9IoSWF/qsTaRdI4JNZChkdTr6Vh6TkXIB3U+CKh3zw8uWTH
	8g4pt9tDVcoZHZo2u5Jt0V8mP9PaoRNbkT+LcwUQUguWwyBywAFFMkuXIrMMimTmXNivw0qO9mu
	fEX80k=
X-Received: by 2002:a05:600c:a55:b0:485:6bcc:87dc with SMTP id 5b1f17b1804b1-486fedc3db0mr86713255e9.14.1774095511033;
        Sat, 21 Mar 2026 05:18:31 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7dc4a2sm151991685e9.5.2026.03.21.05.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 05:18:30 -0700 (PDT)
Message-ID: <149f484b425573185a783cb6ed7a93fcb755fa78.camel@gmail.com>
Subject: Re: [PATCH net] selftests: forwarding: local_termination: fix PTP
 UDP cksums
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 21 Mar 2026 13:19:03 +0100
In-Reply-To: <651c3decb80023e4395ec149fd81110afa3869a1.1774067006.git.daniel@makrotopia.org>
References: 
	<651c3decb80023e4395ec149fd81110afa3869a1.1774067006.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270204-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandersverdlin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 431C02E5436
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel,

On Sat, 2026-03-21 at 04:26 +0000, Daniel Golle wrote:
> All six PTP-over-IP test frames (3x IPv4 + 3x IPv6) contain incorrect
> UDP checksums. The stored values are the ones-complement sums of just
> the pseudo-headers, not the complete UDP checksums over pseudo-header +
> UDP header + payload. This is characteristic of frames captured on the
> sender before TX checksum offload completion.
>=20
> For example, the IPv4 Sync and Follow-Up frames both store checksum
> 0xa3c8 despite having different UDP payloads and port numbers - 0xa3c8
> is their shared pseudo-header sum (same src/dst IP, same protocol and
> UDP length).
>=20
> While most L2 switches forward frames without verifying transport
> checksums, hardware that performs deep packet inspection or has PTP
> awareness may validate UDP checksums and drop frames that fail
> verification. This causes the 1588v2 over IPv4/IPv6 tests to fail on
> such hardware even though L2 PTP (which has no UDP checksum) passes
> fine.
>=20
> Replace all six pseudo-header partial sums with the correctly computed
> full UDP checksums:
>=20
> =C2=A0 IPv4 Sync:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0xa3c8 -> 0x9f41
> =C2=A0 IPv4 Follow-Up:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xa3c8 -> 0xeb8a
> =C2=A0 IPv4 Peer Delay Req: 0xa2bc -> 0x9ab9
> =C2=A0 IPv6 Sync:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x2e92 -> 0x1476
> =C2=A0 IPv6 Follow-Up:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x2e92 -> 0xf047
> =C2=A0 IPv6 Peer Delay Req: 0xb454 -> 0x891f
>=20
> Fixes: 2379795042649 ("selftests: net: local_termination: add PTP frames =
to the mix")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

wireshark agrees,

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0.../selftests/net/forwarding/local_termination.sh=C2=A0=C2=A0=C2=A0=
 | 12 ++++++------
> =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh =
b/tools/testing/selftests/net/forwarding/local_termination.sh
> index 9bc9d25e71368..15b1a1255a41f 100755
> --- a/tools/testing/selftests/net/forwarding/local_termination.sh
> +++ b/tools/testing/selftests/net/forwarding/local_termination.sh
> @@ -57,21 +57,21 @@ PTP_1588_L2_PDELAY_REQ=3D" \
> =C2=A0PTP_1588_IPV4_SYNC=3D" \
> =C2=A001:00:5e:00:01:81 00:00:de:ad:be:ef 08:00 45 00 \
> =C2=A000 48 0a 9a 40 00 01 11 cb 88 c0 00 02 01 e0 00 \
> -01 81 01 3f 01 3f 00 34 a3 c8 00 02 00 2c 00 00 \
> +01 81 01 3f 01 3f 00 34 9f 41 00 02 00 2c 00 00 \
> =C2=A002 00 00 00 00 00 00 00 00 00 00 00 00 00 3e 37 \
> =C2=A063 ff fe cf 17 0e 00 01 00 00 00 00 00 00 00 00 \
> =C2=A000 00 00 00 00 00"
> =C2=A0PTP_1588_IPV4_FOLLOW_UP=3D"
> =C2=A001:00:5e:00:01:81 00:00:de:ad:be:ef 08:00 45 00 \
> =C2=A000 48 0a 9b 40 00 01 11 cb 87 c0 00 02 01 e0 00 \
> -01 81 01 40 01 40 00 34 a3 c8 08 02 00 2c 00 00 \
> +01 81 01 40 01 40 00 34 eb 8a 08 02 00 2c 00 00 \
> =C2=A000 00 00 00 00 00 00 00 00 00 00 00 00 00 3e 37 \
> =C2=A063 ff fe cf 17 0e 00 01 00 00 02 00 00 00 66 83 \
> =C2=A0c6 0f 1d 9a 61 87"
> =C2=A0PTP_1588_IPV4_PDELAY_REQ=3D" \
> =C2=A001:00:5e:00:00:6b 00:00:de:ad:be:ef 08:00 45 00 \
> =C2=A000 52 35 a9 40 00 01 11 a1 85 c0 00 02 01 e0 00 \
> -00 6b 01 3f 01 3f 00 3e a2 bc 02 02 00 36 00 00 \
> +00 6b 01 3f 01 3f 00 3e 9a b9 02 02 00 36 00 00 \
> =C2=A000 00 00 00 00 00 00 00 00 00 00 00 00 00 3e 37 \
> =C2=A063 ff fe cf 17 0e 00 01 00 01 05 7f 00 00 00 00 \
> =C2=A000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00"
> @@ -79,7 +79,7 @@ PTP_1588_IPV6_SYNC=3D" \
> =C2=A033:33:00:00:01:81 00:00:de:ad:be:ef 86:dd 60 06 \
> =C2=A07c 2f 00 36 11 01 20 01 0d b8 00 01 00 00 00 00 \
> =C2=A000 00 00 00 00 01 ff 0e 00 00 00 00 00 00 00 00 \
> -00 00 00 00 01 81 01 3f 01 3f 00 36 2e 92 00 02 \
> +00 00 00 00 01 81 01 3f 01 3f 00 36 14 76 00 02 \
> =C2=A000 2c 00 00 02 00 00 00 00 00 00 00 00 00 00 00 \
> =C2=A000 00 3e 37 63 ff fe cf 17 0e 00 01 00 00 00 00 \
> =C2=A000 00 00 00 00 00 00 00 00 00 00 00"
> @@ -87,7 +87,7 @@ PTP_1588_IPV6_FOLLOW_UP=3D" \
> =C2=A033:33:00:00:01:81 00:00:de:ad:be:ef 86:dd 60 0a \
> =C2=A000 bc 00 36 11 01 20 01 0d b8 00 01 00 00 00 00 \
> =C2=A000 00 00 00 00 01 ff 0e 00 00 00 00 00 00 00 00 \
> -00 00 00 00 01 81 01 40 01 40 00 36 2e 92 08 02 \
> +00 00 00 00 01 81 01 40 01 40 00 36 f0 47 08 02 \
> =C2=A000 2c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
> =C2=A000 00 3e 37 63 ff fe cf 17 0e 00 01 00 00 02 00 \
> =C2=A000 00 66 83 c6 2a 32 09 bd 74 00 00"
> @@ -95,7 +95,7 @@ PTP_1588_IPV6_PDELAY_REQ=3D" \
> =C2=A033:33:00:00:00:6b 00:00:de:ad:be:ef 86:dd 60 0c \
> =C2=A05c fd 00 40 11 01 fe 80 00 00 00 00 00 00 3c 37 \
> =C2=A063 ff fe cf 17 0e ff 02 00 00 00 00 00 00 00 00 \
> -00 00 00 00 00 6b 01 3f 01 3f 00 40 b4 54 02 02 \
> +00 00 00 00 00 6b 01 3f 01 3f 00 40 89 1f 02 02 \
> =C2=A000 36 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
> =C2=A000 00 3e 37 63 ff fe cf 17 0e 00 01 00 01 05 7f \
> =C2=A000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \

--=20
Alexander Sverdlin.

