Return-Path: <netdev+bounces-264871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFJKBnn6qmmcZAEAu9opvQ
	(envelope-from <netdev+bounces-264871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:02:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB483224767
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 843E63036D4C
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA937BE8A;
	Fri,  6 Mar 2026 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U/qx5K17"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA33E7155
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812457; cv=pass; b=InKHS5VpGP5zK9BZ5s/6S7/O5sWBy7bws8bucqNSwO//Hw3TwnKDlaoa6+z1uMmLDYBIC9zWk6SmaCjkwxFxCIROhylPy+IxmS8jiKHqxkaYvFEixbVAimHFwOlSTCvMgFR+CG/MnuPkEJIkcM0hVbIKwAcrBntCGnVU/Bo01Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812457; c=relaxed/simple;
	bh=zzi0KrduAWTtbq/y5xUz3YnLX1wL5NeWTtFwa3ChS8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvulWTG8Vxa2nRVbwexy0WAiOjTkFaz9eNfeV5cZNoJTZAykm2xhpmMYLG5/O/t56FxMZm+JFVrR12b9jHo+48R9jGPqbUg1Ek7rGuosMeHdEidInTOTWlUKBpDi3I9I7GUAdaze4AOHBzWDANAF0bFeuqnIT5zoy2UxrTm3iUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U/qx5K17; arc=pass smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ae50a33ff8so44580935ad.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812455; x=1773417255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzi0KrduAWTtbq/y5xUz3YnLX1wL5NeWTtFwa3ChS8Q=;
        b=tMKxHCl7a8YoiVpkScNQIFJp0gQKdQhaVT5aYIXCErFKtwtzWOwApolXAHwebHqmyv
         0/uGBcERk5U+q8uJbkZEM+y9Nc3dYHDiHAWVGzWw54A2d5mg6kR+cx5meyP7Bcc7sgCX
         vr0pl5SRPxPJB1sv/sKOsXILnYQPW8xFCctZfMjxucGyzTfSkbkKWUCCn7wwlO0AxMWr
         8eSLTfjUdok2ykcHOAa5cR2Bg+ePYXHvtEmwDgt06Qdj0RZ3tyY2jcMEvgrXb4rieCli
         1+aAvr1KcEt/cJBPqVdOmmtHZCxikzwytr+Et02OeKb8relvfNym0DM+R1TDN6rC+Bs+
         7EEg==
X-Forwarded-Encrypted: i=2; AJvYcCUJ6aNnTzhoEVeASZ717As9WpOzcQ6N8Bwr1oMPXRVFy67QZjBOB0mrEguSEGODkbKxEB71r4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4gApzUxPVTUXm83CWxmGL8cAeWS4qPdEzxLwTS3hX5VtD7ou0
	VJs1YX3cFakiuVBskM67Z6vrkSy6Mh+a/E6LAJ/9BR4EoY78TIAcjY8dJsDPbVSQ+zltyaPGY/K
	tTQHRTvzVt++Dw/NO87OXFK7ndhqo1TDA7vX9WJM7ON4KBmjHl1q1SJt2Dxj4Ni3mf6VaPdYdyO
	fAIMgxD8HJN+GNqUzyISEQTDFoUwLCG2EErQzMzqpuPObdhPOSsLuFGk4Hujv4VN/30OcKy31/2
	M4qJCpPc6H2x2dpkg==
X-Gm-Gg: ATEYQzyGTFzm5MY0IVw+nSi4GT68pIcIHlfqHCZ3Pn1I3Ro2/LSAcLaHZsZxa+VWEFU
	X2JUs2D6mJt1nXXT4TS2YQGyw1jv3U/tWn5tX/WMjJoXMFsenySLPvJoDrbPQm6R4RrlJb8KLi6
	FP6wA+Q0kB7sAxubw3O+/o98Wj2d33siI0RMcRPOCi91hz2nEd04yIW4LSw2HzNNF3cBOtHG6c2
	fjfE065b+xoxBEnXhlC9LbJPEb+HGED3ssb+XWHonJ0VcdgmMe0XqB4SzXfZyj9HA+tR9u2bvrM
	gmtwhNGC5m5aag0KOZ5SKD6Gxle/9BSJZ1SqXIVKo4LCs+Cfeqvkv6BRx3imyPhNtf+8LHt+aUD
	XF4zP1s8wmGqnBCn/gT0WYk3bYPzbC9yLpkBfox30HyQ3QaHIQ75wMtjz4SvlthiU9r2gBHiDnm
	Iv8E9AVaAE45PcHpo0ZnKLVsyg17oQdiipzQcxYggP3nFxda7MHJrJh8Wm1e6lSXISQQ==
X-Received: by 2002:a17:903:19ce:b0:2ad:e975:4735 with SMTP id d9443c01a7336-2ae8239798emr25754885ad.20.1772812455017;
        Fri, 06 Mar 2026 07:54:15 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ae83f3a752sm2517635ad.37.2026.03.06.07.54.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2026 07:54:15 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7985951fa83so175408017b3.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:54:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772812454; cv=none;
        d=google.com; s=arc-20240605;
        b=TyDAcnjV6PHsJcWOJc6js5Rlj73diX+LsDKN0ZPKisLC1+JUdKLZ95EXOITblHWBVN
         NUuNUs/dxLlPpaUsxyhGA5q9sdNc3C5i/JKHyibylPDwaOE0N2Sa5nQTU8aZbDCun4SJ
         tyv4vs+r9/MqaYoXFmavYaZ5M8F1syaZr0pUru+JGwKA04lA+7C/OZpEJPZc3dv702f8
         IaClSqLafTr1hfaJ+mrlnBh7NNMZitzd+37l0QTQBqRdwVR63gdne/yI6sAShEbwvMFc
         rCSZT83FypjN0G8Ib5jEUYLYO0xH2QqvEnao9eqLqzr0olFVAZhf9iiOrC7WYuGu9RzH
         hjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zzi0KrduAWTtbq/y5xUz3YnLX1wL5NeWTtFwa3ChS8Q=;
        fh=/9kHUBzf3pIPA6xnMFh97UNwrsu1k16sf4Htq9iNoo8=;
        b=OLMNbKuji2N05yFAt2HZS5Xa4k11ZARi+Uhhh89JmnSbPnBWgqoeG05ANi1CLcpKqO
         TvAhonw6CKjQwCFoP2kb26P1jCj8A9BoncXAKE6YaFfOC9fAS7+QkpkVcPynKWiD283O
         Z7WdQc4r+3gtlXRm4AAfdDzRSwsm5+aqWCdMm7hv+pAYC0+T9WeM21rRIYAmYUL4QeRZ
         RkZAJ5OEniqpeuvM3/fQZQCdI6MZQX/Q29rSxbZV1Leo+ejyPa624k+4P0R9JUnViDEY
         REn14H0v5QVsW0dRSH34/XO0VYGw7PTgSqsiLHq+YwKSbKAqL3sEWBn3AgM2jlHbZbVI
         5eXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772812454; x=1773417254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zzi0KrduAWTtbq/y5xUz3YnLX1wL5NeWTtFwa3ChS8Q=;
        b=U/qx5K17Z+ENZPwKFRnab+1chFuuqZg6ro5214ZM5BfLBzZO+lq+dI7DZaXDSvSw+h
         MPTxg3JJzm1wvy8ngfbUqqUIZ62nkV3U+J/Swa3A/X9ofNP5iuZLWidUwLK2Kg5W1YVQ
         jYKOY1V9WSIuHSu31aCSmiZwmp70NyOz5v3w4=
X-Forwarded-Encrypted: i=1; AJvYcCV172B7RujO//4tTtandza6GszDoPOz/GfnUkAXJL3g/1qUZZ1TLQwzSPqqx1r60VPPZVQxB4A=@vger.kernel.org
X-Received: by 2002:a05:690c:c510:b0:798:c5cf:8a1c with SMTP id 00721157ae682-798dd7a5aa1mr23772067b3.45.1772812453996;
        Fri, 06 Mar 2026 07:54:13 -0800 (PST)
X-Received: by 2002:a05:690c:c510:b0:798:c5cf:8a1c with SMTP id
 00721157ae682-798dd7a5aa1mr23771877b3.45.1772812453605; Fri, 06 Mar 2026
 07:54:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
 <20260302195352.1015990-2-akhilesh.samineni@broadcom.com> <willemdebruijn.kernel.270f71617ce0@gmail.com>
 <CANQF7iAYmKUj_WeDgf4dg941Zxm5bBVzz=yvX17PmyKMOYe6ng@mail.gmail.com> <20260305065915.1e6e3284@kernel.org>
In-Reply-To: <20260305065915.1e6e3284@kernel.org>
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Date: Fri, 6 Mar 2026 21:24:01 +0530
X-Gm-Features: AaiRm51xXmGze7AfkSUJ0ppq60qrAuv0y7yuQIF3NHrlxRf-iWcSkEuRUO_Hjco
Message-ID: <CANQF7iCc_t43FHa+fysnZ=vB9DibvkV5n7v10OXkbZ-Ogsyt2Q@mail.gmail.com>
Subject: Re: [net-next 1/3] psp: Support resetting statistics on a device
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, willemb@google.com, daniel.zahka@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	kiran.kella@broadcom.com, sachin.suman@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000097cb7f064c5d104e"
X-Rspamd-Queue-Id: AB483224767
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264871-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[broadcom.com:query timed out];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RSPAMD_EMAILBL_FAIL(0.00)[kuba.kernel.org:query timed out];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:dkim]
X-Rspamd-Action: no action

--00000000000097cb7f064c5d104e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 8:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 5 Mar 2026 16:24:05 +0530 Akhilesh Samineni wrote:
> > The PSP supports dynamic administrative states, allowing it to be
> > enabled or disabled during runtime. Currently, statistics are
> > persistent across these state transitions, which can lead to baseline
> > drift and complicate telemetry analysis.
>
> Baseline drift? What _concrete_ use case do you actually have in mind?
> Do you know of other stats that get reset when something is disabled
> in networking?

This can be useful in scenarios such as when the device configuration
changes between different versions or algorithms, or when the PSP
device is reassigned between tenants/VMs in a multi-tenant
environment. In such cases, having a dedicated control to reset the
counters allows users to start monitoring statistics from a clean
state.

That said, if the common practice in netdev is to avoid providing
explicit reset functionality for such statistics, we are fine with
aligning with that convention and not introducing a deviation.

--00000000000097cb7f064c5d104e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDCI38VoeiWHImjdPjDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMzA1MjIwODU3NDhaFw0yNjA1MjIwODU3NDhaMIGY
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGjAYBgNVBAMTEUFraGlsZXNoIFNhbWluZW5pMS0wKwYJKoZI
hvcNAQkBFh5ha2hpbGVzaC5zYW1pbmVuaUBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQDAO001ZnYPXmhKsI+E+ksMK/hc9m3qLeGDkvGAIpfLyKfdk2C4d6tsRhM8
4xrNQmMMM+f5wF271rTc0O+CTfIIIayklTmjzksl5CwimtzjGpPZRcLeABJk4Z8VdCU+TW0gSDgU
UGsHqEkCW3ifD8UhO+1xsg2k1ER9gbJ5HfkiiRjtx/jG0Eik3rXjcrxyU4CSTJeFrMsRfHBINs1b
XQiZIKEA2v9ryzZcqBG67oV2mIMYV0PyoO5ccmjophMLX5I6d9LmhVG+o7Fb8fYE43v1Gmx1cF3/
HLCRJ9lVtOZNrDg8Tx5LaODYomcqd8Jym3+vbToQ+O0SQyV9WNR9n6OnAgMBAAGjggHfMIIB2zAO
BgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2Vj
dXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQw
QQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczov
L3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8
oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3JsMCkGA1UdEQQiMCCBHmFraGlsZXNoLnNhbWluZW5pQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU7Bc6
vjugq1VNABQ8AiT04kX10IgwDQYJKoZIhvcNAQELBQADggEBAELCFtU20SHhQMZA0lekkhYfBuuc
/5XYCUX21R6IQyTnqwWwOQ4xNOiq5rC7P2bOGpEKMcMBcHB/VDqpT7Cs0PXecOkC+0cWvmZoxCjx
Hk+3d71Ie1w8r5QiYuGOgGhNWbfhc5aVZUENjC+zlYStnReq3uZcf/oziznbvTX38pyuhVsuHFSo
+SP9KHflLUYGQLmToaPGlRjPh+LJmpbiZ0NRrRXz883+dlADC7tW3fUlrqdeLN9xsoTh7CoWxLUl
xSAQfSnXdfTNfF36dQxm8Az8xhjNmD04jilAg+UVGs7xWqnIkFChNe8pykTtDwdrkjzaaISKeUDj
4fW8f5qx0B4xggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
AgwiN/FaHolhyJo3T4wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEICoQK5HyKnBx
GRLEWYqY47hh1pok5qxLi4hUgDUM4YHAMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDMwNjE1NTQxNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAKHOWJauxmrKt0WX2CgWirEET+cNy0Ix6w9gWBLdD7IOJ3o1
5A5Leei7OyusjkstDTRF7Sc31niykeC/K2GTApxp50baM65nTlptIqD3o6E+ad1LPChPFUnO8dpB
unB+0jb4kkF41xblFmhtSMrP7AwiCldO3mS0um47gmYXY9uCSkROIgfmlhz+paSqVuVZyPpGUFGz
qxdWDYPErPbF3W4+wtF6B9nDtb4A8JONEKyMoZVLY5Q8vKzQ3KFFANDRjb5lfb00DIayqqCFbAyG
4Oux0NbtqkiFenmXOA+GDQ+aSSryiy47XE1EYhpEW2cpQbYAn8ygsJFNdnxU1pm++mg=
--00000000000097cb7f064c5d104e--

