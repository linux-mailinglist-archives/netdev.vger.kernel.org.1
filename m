Return-Path: <netdev+bounces-188955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF076AAF92B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC7A7AEB4A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FA72236E1;
	Thu,  8 May 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRVSUdnD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10020B20A;
	Thu,  8 May 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746705154; cv=none; b=MNJHnRKoqZWR7OxpGiTOoE6AGPCToPNkfBWFx4RozWKTjUvBILVyzCsKPEDipb5EW8TQYgnjnqFXFV7eqN3P4W5dddLJxRT0EDWdwyqRZvve+0ESWLj4U1B+r7ViFJowPmnji+N4BIoHEnhobYUV70Fkl7507d9v5N4F1qxoMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746705154; c=relaxed/simple;
	bh=omRrd5ep4K0j/ZnvsXT7V7FD+w6iWHSbJolDdGMoPPs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=KfmaMKzaZZuh1vK7/wdYABov4ZzR8NQWhfUqnTwnC+uJe9z2EblzQpqcNtPHLvPOnDsXmrBvbSRzA6EHJqJSKMDQkxjAruQlsDKN6wTIrINwNJESk+HitncbL5fR96QCFu+lHBvphBSh90wjQAnZOcBQz22DzbUCCt28AurfSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRVSUdnD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so147538566b.3;
        Thu, 08 May 2025 04:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746705151; x=1747309951; darn=vger.kernel.org;
        h=cc:to:autocrypt:subject:from:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omRrd5ep4K0j/ZnvsXT7V7FD+w6iWHSbJolDdGMoPPs=;
        b=CRVSUdnDRyr3AXFoylwJ7D+eNv/c942zizsUQ7tS9I/O16MhAQhCQkwyPWbE3NB8hQ
         gWW+tesEJSHNM6FUm5WRkYt9TmDCLSCKH9AXiH0edY/GS1Rp6lktSfjrT/CGVWGUjZDu
         hyBcP3Gi5Gk+MxOpDlKSa3EAU31MHJ6KHamFRb7E2PkUAN/0+uQq7kW8j426P2vW6XzJ
         HO94TayF6dkwwCsBgnedEIEvaIUyyHfNGvrWdCmbId9OpVutdA3C5yiGS3XqihfJXUf6
         I332v+KDVxyxKaOSFRzFVKyztMtENNSZsNxSy/JLapbL2UUxmCaICTwtb4zarCpeSZQM
         abLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746705151; x=1747309951;
        h=cc:to:autocrypt:subject:from:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=omRrd5ep4K0j/ZnvsXT7V7FD+w6iWHSbJolDdGMoPPs=;
        b=eu7qY3RfTkjl6D0QdvMwGsuPzPUqXU8BQ+2J67lxrUaOsuRqQp9fcBD9aE3DS3waxK
         MsEn3WjT39QfSsqrPOaYsvtmh+tQ8BWvKExWcObh/prcXdEqv2NbzI5p/BqEvdD+m4A5
         tLX07Xq+CN3NZ63BKtRt2hBWCq5dkzJWuUvzMXKPxwOqr32oNMej4WAY3v0WlXSYKrvH
         i/BXy0ztP8ytGENOY0C7YQjEg0dELTp9gfxCAZ/Xrah5Wiin3OmmJrUABk/FBM20a+C5
         Bxd1dPJ4HE/JvjGcdfEPvJez9K/1/dq+Y+/zpSX9Qd+lv9YRf9laJU1fQCj8OKcPmDDq
         lhEg==
X-Forwarded-Encrypted: i=1; AJvYcCXWXW/C090j4WybKJ7afFj5UkuE9hzIcZmKJB+jj8CF+9dmM0rxEKuQFxoVsBvzwI6eo8W/d7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw35LMBRpAlw7lZ/10SMn8dMpsghfJGjyhA2efvXVNfV/yWhMOV
	XJFufFG2bcvCv595zlfNdPTntC944uZEXfunolhUVm2DtRFgvN98
X-Gm-Gg: ASbGnctrjUFLHcoRgYRqhrdVXSK5HGNIJAIFTyV5YxHL2OjnGr4T35q4+C8WgZbkRjX
	h77jc8ULE1EJExx21dBB0To5bLjR4v0l67UGGfyoFfoeTv5mVvUyDrDJtV1MHzBkSSz6kn0Jub8
	Hov0enNoGFisgwSydMVKajcpzt/Rp+X25B4tOtzKYJpcbRQFvL/dHpZeD6J+Xe0Ww0nKyf8IAzL
	JZ/bmeEvT12hLscEyEbz30ImGTmruB95YSZyNRnBggBebCAwIq+8509vR6x8eFtDG1Tkdx7TpNX
	MYdyrqT0KBe7yRr2kyT8nsg2Un/+u4x6ccpTMb4UHSRegJU=
X-Google-Smtp-Source: AGHT+IHgeS3PIC39LDmNFD7dYmUmPzcGLiZprCOcT6ye6miyh7180bnGiwPKrUnZ1sND/wtyLDqxEQ==
X-Received: by 2002:a17:907:728f:b0:ac2:a473:4186 with SMTP id a640c23a62f3a-ad1e8ce60b2mr597451166b.34.1746705151304;
        Thu, 08 May 2025 04:52:31 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.1.131])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad189148b8csm1064618266b.35.2025.05.08.04.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 04:52:30 -0700 (PDT)
Message-ID: <90373113-c45f-4fdb-bbe9-08cb65b862d3@gmail.com>
Date: Thu, 8 May 2025 12:52:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: qlogic: netxen: possibly incorrect mask used for a couple of
 NEXTXEN_DIMM_* macros
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
To: Manish Chopra <manishc@marvell.com>, Manish Chopra <manishc@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------PLiGPd1cYhFoS0QZdea0pMF2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------PLiGPd1cYhFoS0QZdea0pMF2
Content-Type: multipart/mixed; boundary="------------2dEkOvsW5dkbe14uUoR0ghFi";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Manish Chopra <manishc@marvell.com>, Manish Chopra <manishc@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <90373113-c45f-4fdb-bbe9-08cb65b862d3@gmail.com>
Subject: qlogic: netxen: possibly incorrect mask used for a couple of
 NEXTXEN_DIMM_* macros

--------------2dEkOvsW5dkbe14uUoR0ghFi
Content-Type: multipart/mixed; boundary="------------ZjMHpNota21pXDGjMahJvu0M"

--------------ZjMHpNota21pXDGjMahJvu0M
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkluIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9uZXR4ZW4vbmV0eGVuX25p
Y19oZHIuaCB0aGVyZSBhcmUgdGhlIA0KZm9sbG93aW5nIG1hY3JvczoNCg0KI2RlZmluZSBO
RVRYRU5fRElNTV9OVU1SQU5LUyhWQUwpICAgICAgICAgICAgICAgKChWQUwgPj4gMTUpICYg
MHgzKQ0KI2RlZmluZSBORVRYRU5fRElNTV9EQVRBV0lEVEgoVkFMKSAgICAgICAgICAgICAg
KChWQUwgPj4gMTgpICYgMHgzKQ0KI2RlZmluZSBORVRYRU5fRElNTV9OVU1CQU5LUyhWQUwp
ICAgICAgICAgICAgICAgKChWQUwgPj4gMjEpICYgMHhmKQ0KDQpUaGUgTkVUWEVOX0RJTU1f
TlVNUkFOS1MgYW5kIE5FVFhFTl9ESU1NX0RBVEFXSURUSCBtYWNyb3MgZXh0cmFjdCAzIGJp
dHMgDQp3b3J0aCBvZiBpbmZvcm1hdGlvbiBmcm9tIFZBTCBob3dldmVyIHRoZSBtYXNrIGlz
IDB4MyAoanVzdCAyIGJpdHMpIA0KcmF0aGVyIHRoYW4gMHg3ICgzIGJpdHMpLiBJIGRvbid0
IGhhdmUgdGhlIGhhcmR3YXJlIG9yIGRhdGFzaGVldCBmb3IgdGhlIA0KaGFyZHdhcmUgc28g
SSBjYW4ndCBiZSBzdXJlIGlmIHRoaXMgaXMgaW50ZW50aW9uYWwgb3IganVzdCBhIG1hc2tp
bmcgYnVnIA0KaW4gb25lIGFuZC9vciBib3RoIG9mIHRoZXNlIHR3byBtYWNyb3MuDQoNCkkg
aGlnaGx5IHN1c3BlY3QgdGhlIE5FVFhFTl9ESU1NX0RBVEFXSURUSCBpcyBpbmNvcnJlY3Qg
YmVjYXVzZSA4IA0KZGlmZmVyZW50IGRhdGEgd2lkdGhzIGFyZSBiZWluZyBjaGVja2VkIGlu
IHRoZSBzd2l0Y2ggc3RhdGVtZW50IGluIA0KbmV0eGVuX3N5c2ZzX3JlYWRfZGltbSgpOg0K
DQogICAgICAgIHN3aXRjaCAoZHcpIHsNCiAgICAgICAgIGNhc2UgMHgwOg0KICAgICAgICAg
ICAgICAgICBkdyA9IDMyOw0KICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgIGNh
c2UgMHgxOg0KICAgICAgICAgICAgICAgICBkdyA9IDMzOw0KICAgICAgICAgICAgICAgICBi
cmVhazsNCiAgICAgICAgIGNhc2UgMHgyOg0KICAgICAgICAgICAgICAgICBkdyA9IDM2Ow0K
ICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgIGNhc2UgMHgzOg0KICAgICAgICAg
ICAgICAgICBkdyA9IDY0Ow0KICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgIGNh
c2UgMHg0Og0KICAgICAgICAgICAgICAgICBkdyA9IDcyOw0KICAgICAgICAgICAgICAgICBi
cmVhazsNCiAgICAgICAgIGNhc2UgMHg1Og0KICAgICAgICAgICAgICAgICBkdyA9IDgwOw0K
ICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgIGNhc2UgMHg2Og0KICAgICAgICAg
ICAgICAgICBkdyA9IDEyODsNCiAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgICBj
YXNlIDB4NzoNCiAgICAgICAgICAgICAgICAgZHcgPSAxNDQ7DQogICAgICAgICAgICAgICAg
IGJyZWFrOw0KICAgICAgICAgZGVmYXVsdDoNCiAgICAgICAgICAgICAgICAgbmV0ZGV2X2Vy
cihuZXRkZXYsICJJbnZhbGlkIGRhdGEtd2lkdGggJXhcbiIsIGR3KTsNCiAgICAgICAgICAg
ICAgICAgZ290byBvdXQ7DQogICAgICAgICB9DQoNCkFueWhvdywgSSdtIHVuc3VyZSBhYm91
dCB0aGlzIGFuZCBJIHdhbnRlZCB0byBmbGFnIHRoaXMgdXAgYXMgcG90ZW50aWFsIA0KaXNz
dWUgaW4gdGhlIGRyaXZlci4NCg0KQ29saW4NCg==
--------------ZjMHpNota21pXDGjMahJvu0M
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------ZjMHpNota21pXDGjMahJvu0M--

--------------2dEkOvsW5dkbe14uUoR0ghFi--

--------------PLiGPd1cYhFoS0QZdea0pMF2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmgcmvMFAwAAAAAACgkQaMKH38aoAiYl
tA/+MzBWcgNMcE3hINJtRCuDHH3pf7mFVNOGfu4SxMerd7Zpgcda8tqQ8Ic1w8bUO1bzbH99C88C
T32lV/YpF47E8QF2KmLbSfhbsifU/+n+kn4i0ATjknGD+Ho9mA4tP9tgIoFHTf4BPwMutczn4ATN
BJeHp43f0ltus0nnAJ7k6kd49z5WNB4HkMHONs8y3HK9ElH7IBXmjtiMXrfltAlfs396wo/SyMnv
mMkKdRuhmarZt5MTQ78mzZkpWLf3dw7iq5tWjlYQXCxjzmA4GOn1NFuUchDZ/KkQTQEwoz/q0bbR
qj0OY6b+6FYvN0ZENHLPTK1UTggtgCl2IwSlt6RSps2y0VSJPya7miG5/A9zjK3nIfMWj1yy5pzU
lsQod7oaGB5vhnMIcyr8Vfh1K503dVon9reTtMrGrg4WOMpKzQfBzw+wFF+IJyumkitLQN7BhSeI
emMv9QgLV92vVEVmxoHEP7sShtP37p+KGL2079Gvpf5TLVymAX98plFuDxovHLzFXs3C+DDC4fbU
7olmEkx0jyQTgBU3LXN7pT5N57g1tT1ejH0Rta1x0QGgHU8ri1rnZlkPBSpn5olhag7vOQR5csry
jABQfCUqDvklG2xAn/JgQ+y1LTaAw7XXOC+/36mW8xmeTFqIkDNb7Oj6Z70KWF8ifTtSD2F0eZbo
gdk=
=4d5D
-----END PGP SIGNATURE-----

--------------PLiGPd1cYhFoS0QZdea0pMF2--

