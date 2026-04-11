Return-Path: <netdev+bounces-277682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM/SJ4UI2mkEyAgAu9opvQ
	(envelope-from <netdev+bounces-277682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:38:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0713DEFE3
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 10:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14FA4301FCA5
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95062BEC55;
	Sat, 11 Apr 2026 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YarAFOyB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786951C84BB
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775896705; cv=none; b=CRh5kI7U+KDzEY2aFwGNM4DUegtSNN9ATFduBbFZnZaTxATqbrLbQsskYVYOXlAoiW+6KUl8aAZUMrRKCP5UziaeHZY3SocrvDX4BRNjkfg6eOFZ4Aoy4EmMuyppwh84Xr2899z3fa+wf5fePRN2OZcYL3xYgztjwEMf/5QW5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775896705; c=relaxed/simple;
	bh=x8BVMNA2/KGwbAiO9x5c79hLTT8UvvebSjMBIFfs2dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U56YiKPEWjl8UcIYbHA7RvohXMwEn2jg9YY+w/2B10qjzI+xbfdiuJ8mQ+L13WqRj7BoI2GNzumhMfkzy00oKx1JhCl84J29tOuBtpv9ucaa2e7D6jXBAGJkZFue41dn+qKGoj7ozFuKwy5FjjX4KfbroOVGUE1l6u2QC16mx3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YarAFOyB; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-66f747175d8so1392901eaf.0
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775896703; x=1776501503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8BVMNA2/KGwbAiO9x5c79hLTT8UvvebSjMBIFfs2dc=;
        b=hKM5C6v68SmmIqIhU800huqTf1B0k3na/mf8cQzfwvJ+bJbvkWxrkVh7CQpy2eTY6p
         B/T1R4EJPL5rX1OpUAxFBQZOjTQSMXBOdornOMbch8/HpD2AZ10VelSJr6vWru/QuFXB
         MIAwwgLg4LCVDKvcKcCNYNFyc6Uya0/Prvdz2Qoc6X5xvdwWjIowpx6uc02YHnlE++L3
         JJ5z+AzjJ0NyPtjPAt1T4rH21BT6hFrKvQnFi8b2hWno825MBSfPnMEsPyLgwH+Qt1Af
         maRLkhHZ7FXT7ISa50p6Qc1V+67nTYyWC46yiAzce6M4rxJ9uN5hIA+RDduMHFtivsU8
         wPVA==
X-Forwarded-Encrypted: i=1; AJvYcCVkC9pXUFCYn+TglzLHO6rdDsRClIY0Q8+g1WsWfuRsIeGpEopY8/aVNPZxNBsJLIK80PBLkqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6AxGz6Bp7OIvNxc+E9waoHUGeYz1EvhWDKmHQdUKWUbhSiBj3
	D3aV7AD5M4+E99LqjkKrky/yW/oIVTVRW6iajeXKI5/TYQFV4xkTSKW/rnOY/BpJf9RYnJNwaTX
	JTCpCr98f6RTpuHi7waAiQRcpfvMsZkkDOWT72xjY0w6QF40etyzIam4E39u8CpMnRGK2fVFWVv
	3npbmE9RPrm/Oi5oY0sqr2jl/fHkkH7uREgGCOxJMJxRrQFvpcjr2FmS313b9lokbXqei8rqx3A
	M1PXfrCAAz2sfwbYQ==
X-Gm-Gg: AeBDieuwoliB44gcQEQKwwdS93VBgx0WMnZMUvx0ISE1erKAkkMa0E3YyvOPmf75e8g
	gEDFZBR8dAeGHUFNaQhkb5Xg+mhQkG9GHcOcW0llBrh9Ub9MmIyPT+wSwyovOl0fFEKksgB2FZi
	zI5jsTnHjkd6ymw8mo7uoW3Uuwhc4Rfwr5o71vRA2S9Q/+q2sShuUSHTNOvS0d4H7DCGy21l36f
	1ZZBkwmMpfV1GaiPmNhmu2taBoreWwtBux5Tpm4wZRQdYy7/hOurx4bisp7gVDUjsaAhQ+KD20k
	dshSk9AnN4cBdPSVd2kP8pA0lgL0BozV1+x48Jv+0F93d8v1QXMwHOwY4Y040jC7vfaxFHCZwT7
	Dpn2ZvhLiXV2HO8LfXq6TGAZx/55jj5FC7jfv/MaM3WfMIch0Nkl8FZfBdeheLlOUYE7I1JSbrH
	D76a8j5mZw2dlY1mfFGjzntAgesHtOsECtPMFGvemUFByaf7l5f0Xr/gb7ST4QHd4=
X-Received: by 2002:a05:6820:2217:b0:68d:804:55e6 with SMTP id 006d021491bc7-68d080457dcmr1925268eaf.13.1775896703357;
        Sat, 11 Apr 2026 01:38:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-423ddbd0422sm688153fac.15.2026.04.11.01.38.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Apr 2026 01:38:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7949310b90cso62236157b3.2
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775896702; x=1776501502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x8BVMNA2/KGwbAiO9x5c79hLTT8UvvebSjMBIFfs2dc=;
        b=YarAFOyBFzN8DlEB1fYHEGXB/OUbl9T1YBbOueNgNyISBrBWZ2yQxn+xGHzo0Qqa70
         phxo3Ttjt+r2nEGEiCRW5ZUBxG6P6Kzc0Vlf9HGApmPQam3ZK/3b1BEMkvczssAlnXWG
         SvPL9Mn88PvMYmoecQ2n+w4E9zuIJYMhGKVeY=
X-Forwarded-Encrypted: i=1; AJvYcCWFS18bLhJIR5shN6zrLw2rEIqa7psxTkiANK+NKCg1H7qtlD3Qeg/RVzdFlnSHk+P0FN95XK4=@vger.kernel.org
X-Received: by 2002:a05:690c:c10e:b0:79a:b440:5c7f with SMTP id 00721157ae682-7af6f03b267mr63161367b3.2.1775896702268;
        Sat, 11 Apr 2026 01:38:22 -0700 (PDT)
X-Received: by 2002:a05:690c:c10e:b0:79a:b440:5c7f with SMTP id
 00721157ae682-7af6f03b267mr63161247b3.2.1775896701917; Sat, 11 Apr 2026
 01:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
 <20260406222305.4111170-2-akhilesh.samineni@broadcom.com> <willemdebruijn.kernel.1d7f9f774aa55@gmail.com>
 <20260407180432.102073cf@kernel.org> <CANQF7iDj1E6=3pod078-++5wbweyMg0H7gpeq0kbGFZHNytDdA@mail.gmail.com>
 <20260410135736.4bc7ed46@kernel.org>
In-Reply-To: <20260410135736.4bc7ed46@kernel.org>
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Date: Sat, 11 Apr 2026 14:08:10 +0530
X-Gm-Features: AQROBzBj6vIvdAqNKN6IHexvjaRve9x4_vbI7ZmVe8xlaGHcfoRtQucNCNNy9r8
Message-ID: <CANQF7iCVK1so39hNMPekFjJkk5TJckdkRUMGih-RAEuwd_NwgA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] psp: add crypt-offset and spi-threshold
 get/set attributes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, willemb@google.com, daniel.zahka@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	kiran.kella@broadcom.com, sachin.suman@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001c2182064f2b2c1e"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277682-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D0713DEFE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000001c2182064f2b2c1e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 2:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 11 Apr 2026 01:06:06 +0530 Akhilesh Samineni wrote:
> > On Wed, Apr 8, 2026 at 6:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > > On Tue, 07 Apr 2026 17:37:41 -0400 Willem de Bruijn wrote:
> > > > PSP defines a 6-bit field in 4 octet units. Does this need bounds c=
hecking?
> > >
> > > More fundamentally, were we to support this -- is it a device propert=
y
> > > or an assoc property?
> >
> > It's a device property. All associations under the device will share
> > the same crypt-offset.
>
> I don't think there's anything in the spec that says the crypto
> offset is device level.

Yes, the spec didn=E2=80=99t mention the device level. We currently chose t=
he
per-device approach based on the hardware implementation.

> At the very least every L4 proto may want to have a different offset.
We agree that per-protocol granularity would be more flexible because
L4 protocol header sizes differ.

> We should probably hold off adding this until a real user appears.
Sure we will hold off this change till that time.

--0000000000001c2182064f2b2c1e
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
AgwiN/FaHolhyJo3T4wwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEO93fP7hm0u
JBN8WhbDZ3UgO7e+ZJ1oBZyuw/51yF7vMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTI2MDQxMTA4MzgyMlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJAYFFqbxk6fk1sotRYpFWS0N2IPQrlBUrI+oRTwTJRGivc3
cN8fJYIUeFQUoJlnabfGnWXYpBvPlB/Y2puVc+1WavSStQbUlxkiVicSJSG9fR9uEwAq48/YaYni
ekMD/Nh5cA/5zxvskVNhTk3ng3+7A3CQwmAWC084n5wsd5bkxiZnTKKXnz6VUxXLfNhMPUTi02QU
6L/RBtk+BcG0YrpB0D8TK17frUEk/Gnz3FiwgGPAsFwS70RTrDinJ5vJr3vlgK4zhj96JE5Sl9x6
1s1c1c3Qxgpu1ERXLRt6b0RfSrLaDtTDohoN4WWuPgYSM9xKZYeBRqJ2KcJfb7wdsa0=
--0000000000001c2182064f2b2c1e--

