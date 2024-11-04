Return-Path: <netdev+bounces-141611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53349BBBCB
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1951B22B2C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E321B5ED0;
	Mon,  4 Nov 2024 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ms3mfaJw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D101C4A16
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740932; cv=none; b=CD9baSH9ytzxe05hVMHIPfnEhsN5yptI86YhcN30gtBJWjrWiR8sHmcINbjj05dlCrmtE5FkSM4TiCnyMAxO7R8joYedC7q4T9BP1iZ7N1XvQaclbegYumSrwG8QEWtp+3C+jVYiRRNUdOvh6hPU4JZuSp0BiTogvPax+g1lc0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740932; c=relaxed/simple;
	bh=jksVMyMcoivF0oJA0zlWnGEgPTe2LIr48QE/qrYypTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNyyvY9fBSNsCE9sorgC1RPNBfTqdUSxtVwTVDBR5FmfgdoKtORcyChP8480uAQ3cWcMmzQ+nlHOAPibg7ieaXYStNiuoFg3tyOM6a9i4qGKy/kZz1XH69cD5ssgadNZibAgOKDaa/FxhYY6CKvjG3lraMGEwZ7MRvRonHxCN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ms3mfaJw; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so3043135f8f.2
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 09:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730740929; x=1731345729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P2orYyZ3jfWSRs71E/hD5IZN9fxgp2Ne631U0vJDZZ8=;
        b=Ms3mfaJw/bthgY+lkj8yl89WffFMWQuMjyPgTax2YTOLQ8zgGEB+FXWqlRA77PPq0W
         Lc8rVYaujzpYRrTNF4ngw9kpppPcJYDjPaMlHViy03rUSN/lMaOQd94DTKTPK1VA1RJY
         xiepy2/bRUOMwB7f4miMLRoEdG3KHJlg3ZHm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730740929; x=1731345729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2orYyZ3jfWSRs71E/hD5IZN9fxgp2Ne631U0vJDZZ8=;
        b=eD9ZxdILO6vSJ0zELegUhnv6LzY1ClhHC0BNQfaF9RJKQblOCgYouCE0kjwRvHFCAw
         Cgrd9MSM8MbtoJxKLIFowqvIwDVVFC3QvgYqpyFAybH8QzTcGeUYoHGInEZSkWlLHWP9
         gfIpJ0hdr5QcGceAqKXZZ4zhlBkii+uy9yANo9oqpoug5T++6SI6JE+icLh1TpJ16TL7
         EdZ0y52tMMOF6uJy3kb3nvRlhvMwPhza7XvglTwUD/B31n/TSuq5zEyLDTl59oQdb5di
         Mc+I+1iPQi7iB9tFswEwS0vPsMHIeuS9xFvvH2/62H8I8Sd+Swt5vVv08qu0snGI/DZY
         bdow==
X-Forwarded-Encrypted: i=1; AJvYcCWJitguOQvy9lt8eJ62ti3JvyLHhTyYdyYjAJBjUcNsq7B1E2mUX1QP3q1mwLOvUriEqYw8Edg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Tr5BNNGvdyESxMgBWJ9Q22lBhWygFuuKTRlyGjhZ/ezTvcJf
	9haaMn1Tr+80Q8edBRZpUJfAFos7/bNVv0BXtKQkGqXmYjIGbHyNitpIARNUkFVW7ClKFXnOmMD
	lFM6PGHDRNjvPj6bwArxe6badEjGygb8n8zIJ
X-Google-Smtp-Source: AGHT+IH6kQDuoQzLeOBrQCc+dLm9LWdCGi+7y2nxk2UoUIPdPETZ28/lyLSM2SeUVhkmGPZBjNiw9bJ9ygrqKS4/TTg=
X-Received: by 2002:a05:6000:2109:b0:381:df72:8678 with SMTP id
 ffacd0b85a97d-381df7286c3mr559176f8f.16.1730740929309; Mon, 04 Nov 2024
 09:22:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <219859e674ef7a9d8af9ab4f64a9095580f04bcc.1730436983.git.dxu@dxuuu.xyz>
 <CACKFLim3y5-XMBCpCMA-XnLe6yho6fY0Hbcu_1jbf5JKrhCH9w@mail.gmail.com> <zdshp6klnjjexwxpx6e5k62jej6xmxiubmkegkk3tixt2jk5t2@poolzxiibn3n>
In-Reply-To: <zdshp6klnjjexwxpx6e5k62jej6xmxiubmkegkk3tixt2jk5t2@poolzxiibn3n>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 4 Nov 2024 09:21:57 -0800
Message-ID: <CACKFLik=SE4p9gq8BZJY68W_9QB=szU6cAwd-UgsvnCxQ6yu4Q@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: ethtool: Fix ip[6] ntuple rule verification
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch, 
	kuba@kernel.org, vikas.gupta@broadcom.com, andrew.gospodarek@broadcom.com, 
	pabeni@redhat.com, pavan.chebbi@broadcom.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000516c5a06261986e4"

--000000000000516c5a06261986e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 3:42=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
> On Fri, Nov 01, 2024 at 12:20:44PM GMT, Michael Chan wrote:
> > Thanks for the patch.  I think the original author Vikas intended the
> > user to do this for ip only filters:
> >
> > ethtool -N eth0 flow-type ip6 dst-ip $IP6 l4_proto 0xff context 1
> >
> > But your patch makes sense and simplifies the usage for the user.  I
> > just need to check that FW can accept 0 for the ip_protocol field to
> > mean wildcard when it receives the FW message to create the filter.
> >
> > I will reply when I get the answer from the FW team.  If FW requires
> > 0xff, then we just need to make a small change to your patch.
>
> FWIW at least my HW/FW seems to behave correctly with my patch. I did
> some quick tracing last night w/ a UDP traffic generator running to
> confirm redirection occurs.
>
The FW team has confirmed that ip_protocol 0 will work as a wild card
on all FW supporting this feature.  So the patch will work.

But I think I want to eliminate the l4_proto 0xff usage.  It is
non-standard and non-intuitive.  So we should only support l4_proto to
be TCP, UDP, ICMP, or unspecified for any protocol.  Thanks.

--000000000000516c5a06261986e4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKQh/PwI35698dGnO6nKC0nApfj2AjcE
Ww+86L1eVMdQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTEw
NDE3MjIwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBPK1S2q7DKEa7a7EoZVWB0zO1r7rfaySnF4aABXNixFSsjDMHZ
zA3bj/d+wKM68wh9ei/dw7PgmvNZDDdlvTGlXm2xyh4/cvctD3nCUe2tBoNxBJuwD//MuSSLAr9g
XWOWomaxAHbhhBSkAmT/QpfVpEp6WS5lWSE3B0ENMHZI236XrjFuNtARZ0sLDgK8FsWNjl5orMw9
wYdpAF49Z5CpKkx73ckxvovyvVisGRQSVA3GfRQ5ByBK19n79xmy6mGpVDKt/BtVHWIW3BxXVUj6
nTarTzxVFbdgoj3doHQ/IlgSV8q52qvPm5xjA8VhbWjgBAoNTO3MsWqC7BRyj4qv
--000000000000516c5a06261986e4--

