Return-Path: <netdev+bounces-258599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCzkJzgIj2ltHQEAu9opvQ
	(envelope-from <netdev+bounces-258599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 12:17:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6900135A2A
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 12:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D80304A176
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E861F03EF;
	Fri, 13 Feb 2026 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ejhTv+SB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0428285058
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981149; cv=none; b=bNYOWZTG+mLQt9A/yS38MVLWCTu6T6QeIyG7eSHSaHtjjO3N5YdWBBMYXbQqsBuQ/UUsmc84kvwGwzovYZnYHjih13YprbNZOenRj7LjbgUVkjF0pe2wFsFebEc0/PwqhMp4Y2bEQoDLx0YTOh4Z4HTx08xYYhtB6PJjaKFU2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981149; c=relaxed/simple;
	bh=Ev/ToI45invKmxKsmjv/nTAYHo0Moc+rLWviNdbLiR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFIa6cbjYjBYH9/Efs7gldpM8xfah5sQmfHVneUw/vLvWksujSoL9KdyEWUi2CM2MfahtSv5zK/O15a2bOAwFmGdF364wSH4Mzn1nj4Kb1elpJSRqSAQx8gF7lYBbk7gwC+yHjKpk9kREE1+K/HxDiywJqzvp0MFiq5MGhBH1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ejhTv+SB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8f8f2106f1so103416466b.2
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 03:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770981146; x=1771585946; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ev/ToI45invKmxKsmjv/nTAYHo0Moc+rLWviNdbLiR0=;
        b=ejhTv+SBySYlKGQKXWflveRLaoCljDQr/nIO7zNAvuUVBfZUrbOjHafMEVTd9GHnfF
         yacGOztzAzWLYWqT8t9jLfSFYiGuff9BZK/2oraWkKuTMeJWZupnC2NlZdOoDEcCQgPr
         OiEeidw5EVYOIKJTVWRxR9XPeChedZPkdjad4RljuczTqJMNu4/Lqrx30U8isfmg4jm+
         NqUf/hQPeSFC6h9QccLlrA1h5X5YC7BhbRWxcOVqDgXshXV5IbeT++HlzobwjUOTC1As
         RbYTVV0QCFGZJpaza7uWrS/47pS+TJXEEESJp4METsLUvRGwTwSvBqwMTk7jJ+Z+t6Vj
         EdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770981146; x=1771585946;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev/ToI45invKmxKsmjv/nTAYHo0Moc+rLWviNdbLiR0=;
        b=pE/593+2+ZhGbfPfc+2iEbjE7b1n8c2Yfi308M/inSmQ1IIwMq64TY9/8ELSSlGRub
         24DEpX3E909o3hhP5OAUVzFoII0HHfG3bjFkDPYv51oHZTFMe19zpaWiKzRdEwgL+4tQ
         MPzbL0Kv6CZSAx35Q2M5qp6v/2b9a/wx9Gf8j9pywxfjT9fJ9/9D13x5H/eg87nxrgjI
         haMGSqLagbR2NFHb/cP8dMYhDQUbIw0gh/Cml+hDFfnw3Say2QdCZ2oqR1qxTWwlsoup
         x+xZiYoKT7ePatJlDyef66jVCucBh7FM6N4pXSQxBlnMDOv8pVfzEmoz/eembzGEBYGm
         RGOA==
X-Forwarded-Encrypted: i=1; AJvYcCUXaswdHll+2yrgKh0LibAekdQJMm4DbUZMS3a3yHkw89K7ga++x63/IK2tNpLIp53id7sfJaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzNczWsp7UXAxkzbM6KzL7hr+F/Kt1/8V/u4DGXWaEDxrpiOME
	XWz3q2oThEc6nFgBpndtcZ6x8vvdsF4WWJFEEyo+T2L8CyPTI4bvQc8aPUd84R/352s=
X-Gm-Gg: AZuq6aLN245cG0pZ23NoBrzTqj/6KT/MidCtoqJZQpC/ifR7w0DSOnykGMbuIG3oqWS
	O6QA2dqrOxIJcFOBaqZtvQiV5ATuFxaPkzBGeXGsh6LViqSDShlhqrc34IcHTPfdR+NMxQ6eC4g
	q+cmFxpkCid6K7RGBCVBNkjCRkS86MtFiWG9D/VZ0uR6KPv7cZ4nlwIFP1bF2gVHhdxEu3+dOTe
	3BG0V4NI4vSmodie7sIVwIis4dO5LyMzka2WVpAhk+GPrcXomeSY0r19Qa5mBIzQWchxBrgsAnf
	1EMlmFr6me5erBFEC2Ymxgibv0i9v+9K4Sd8QCxWM4qQSAFn4NZl19tFxNB7mTS8A0lBoAT6HGe
	xUNvTH1vAeXHcD91eV30R9fUSc2bxp4TavRwamz9Pe5mtjzKkodw+VwT/1dMa4okjgou505Q/+T
	soR0sY0oHXD6/h0u7heirJ4Vkf9fECK7YCAoFLO55EP+Gr1Uw2MlchdxRqLXQaW12KrhSBiPl9D
	zho+1enyqeq6P39W1J9GRHNl9vdsXg2OMfw8IUQw9x82B2cKw==
X-Received: by 2002:a17:906:6a21:b0:b8f:a853:add5 with SMTP id a640c23a62f3a-b8fb466c3dcmr84975466b.62.1770981146183;
        Fri, 13 Feb 2026 03:12:26 -0800 (PST)
Received: from ?IPV6:2a00:12d0:af5b:2f01:4042:c03:ce4d:a5a1? (2a00-12d0-af5b-2f01-4042-c03-ce4d-a5a1.ip.tng.de. [2a00:12d0:af5b:2f01:4042:c03:ce4d:a5a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fbe407520sm3682466b.43.2026.02.13.03.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 03:12:25 -0800 (PST)
Message-ID: <02459674-58f9-407c-b151-39374a6cf81a@suse.com>
Date: Fri, 13 Feb 2026 12:12:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xen-netback: reject zero-queue configuration from
 guest
To: Ziyi Guo <n7l8m4@u.northwestern.edu>, Wei Liu <wei.liu@kernel.org>,
 Paul Durrant <paul@xen.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: "Andrew J . Bennieston" <andrew.bennieston@citrix.com>,
 xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260212224040.86674-1-n7l8m4@u.northwestern.edu>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20260212224040.86674-1-n7l8m4@u.northwestern.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rmAWL2OMeeZDohi0r3FMp00n"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.85 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258599-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jgross@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6900135A2A
X-Rspamd-Action: no action

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rmAWL2OMeeZDohi0r3FMp00n
Content-Type: multipart/mixed; boundary="------------fzXF7bXgc7rK1nb40SukhLSf";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>, Wei Liu <wei.liu@kernel.org>,
 Paul Durrant <paul@xen.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: "Andrew J . Bennieston" <andrew.bennieston@citrix.com>,
 xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <02459674-58f9-407c-b151-39374a6cf81a@suse.com>
Subject: Re: [PATCH net] xen-netback: reject zero-queue configuration from
 guest
References: <20260212224040.86674-1-n7l8m4@u.northwestern.edu>
In-Reply-To: <20260212224040.86674-1-n7l8m4@u.northwestern.edu>

--------------fzXF7bXgc7rK1nb40SukhLSf
Content-Type: multipart/mixed; boundary="------------oPkhdrcLI3DudRxu4wTLSAHY"

--------------oPkhdrcLI3DudRxu4wTLSAHY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDIuMjYgMjM6NDAsIFppeWkgR3VvIHdyb3RlOg0KPiBBIG1hbGljaW91cyBvciBi
dWdneSBYZW4gZ3Vlc3QgY2FuIHdyaXRlICIwIiB0byB0aGUgeGVuYnVzIGtleQ0KPiAibXVs
dGktcXVldWUtbnVtLXF1ZXVlcyIuIFRoZSBjb25uZWN0KCkgZnVuY3Rpb24gaW4gdGhlIGJh
Y2tlbmQgb25seQ0KPiB2YWxpZGF0ZXMgdGhlIHVwcGVyIGJvdW5kIChyZXF1ZXN0ZWRfbnVt
X3F1ZXVlcyA+IHhlbnZpZl9tYXhfcXVldWVzKQ0KPiBidXQgbm90IHplcm8sIGFsbG93aW5n
IHJlcXVlc3RlZF9udW1fcXVldWVzPTAgdG8gcmVhY2gNCj4gdnphbGxvYyhhcnJheV9zaXpl
KDAsIHNpemVvZihzdHJ1Y3QgeGVudmlmX3F1ZXVlKSkpLCB3aGljaCB0cmlnZ2Vycw0KPiBX
QVJOX09OX09OQ0UoIXNpemUpIGluIF9fdm1hbGxvY19ub2RlX3JhbmdlKCkuDQo+IA0KPiBP
biBzeXN0ZW1zIHdpdGggcGFuaWNfb25fd2Fybj0xLCB0aGlzIGFsbG93cyBhIGd1ZXN0LXRv
LWhvc3QgZGVuaWFsDQo+IG9mIHNlcnZpY2UuDQo+IA0KPiBUaGUgWGVuIG5ldHdvcmsgaW50
ZXJmYWNlIHNwZWNpZmljYXRpb24gcmVxdWlyZXMNCj4gdGhlIHF1ZXVlIGNvdW50IHRvIGJl
ICJncmVhdGVyIHRoYW4gemVybyIuDQo+IA0KPiBBZGQgYSB6ZXJvIGNoZWNrIHRvIG1hdGNo
IHRoZSB2YWxpZGF0aW9uIGFscmVhZHkgcHJlc2VudA0KPiBpbiB4ZW4tYmxrYmFjaywgd2hp
Y2ggaGFzIGluY2x1ZGVkIHRoaXMNCj4gZ3VhcmQgc2luY2UgaXRzIG11bHRpLXF1ZXVlIHN1
cHBvcnQgd2FzIGFkZGVkLg0KPiANCj4gRml4ZXM6IDhkM2Q1M2IzZTQzMyAoInhlbi1uZXRi
YWNrOiBBZGQgc3VwcG9ydCBmb3IgbXVsdGlwbGUgcXVldWVzIikNCj4gU2lnbmVkLW9mZi1i
eTogWml5aSBHdW8gPG43bDhtNEB1Lm5vcnRod2VzdGVybi5lZHU+DQoNClJldmlld2VkLWJ5
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------oPkhdrcLI3DudRxu4wTLSAHY
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------oPkhdrcLI3DudRxu4wTLSAHY--

--------------fzXF7bXgc7rK1nb40SukhLSf--

--------------rmAWL2OMeeZDohi0r3FMp00n
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmmPBxkFAwAAAAAACgkQsN6d1ii/Ey9i
zQf+NoCNOcEARUKfM7WGvjBJICmF9LWnKvhG2fMAYCZ3gF3ybnoHStwJQ+ioMHEkirAye7g1vmnP
TRQsqYFYW53t0VuEy9LsniZk7fapy7fGr36uOjMJg3+xyU4q9xt+VFKF8b4dKVi5itasrGmC6yKQ
OM51/LLkoQBcMwj0BvyXmZrMIMrE5tSTO6EichMpEba3R7UyNKBSOZmOn8kRzo5cY9KIs4X5LZJs
eFKSb1dTjZwcpR5P0Nhmsb16K8alSpLyrROO3srwc6is92yY/k4eggBCPekIt7dybWFv/cVLeCxV
ptCCQ2s7NNh0hryMfq/CZQLGFoFeVImhq8GyuRuSCA==
=G6ik
-----END PGP SIGNATURE-----

--------------rmAWL2OMeeZDohi0r3FMp00n--

