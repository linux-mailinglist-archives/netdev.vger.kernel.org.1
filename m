Return-Path: <netdev+bounces-200131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD0AE3449
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5FB188CF72
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 04:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC307151990;
	Mon, 23 Jun 2025 04:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="baQ4NHBo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AB92FB2
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 04:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750652448; cv=none; b=W1k8kaUwBD5PYGVaGq+FYRMsPmgLTkokwOzYC13Ytvak2i2+mX/KZgSUcUSUbi9XjUYOxkSe9fjxLk5Bn/KfaWS1PBfdMuMZARDbn99n9q3wJ7CIpc6rLQ5HyeUhgXo1/30ju+EH2hHL4whU5OZQMyWDBt4HV/vcqNep56XbqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750652448; c=relaxed/simple;
	bh=K7NiRpxiQepYNmS1OCTHXI+WbVvzR5mCKJabd87Elho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taenLHWbwAmsN4C1e60OAF0recfR61MW65OnlkPFBl842e3jflMNwmvtZ2gTu7hP+b6he0jykuM7PSrJ9k2J+QU4mCUi5ci7peEvcMphSFNQzq7KRT/xWqZo2qUhsodi1W9zB/8GUy/5mjU34S18mN+9AuM5JvO9jFpgGGYDNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=baQ4NHBo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607c5715ef2so6281035a12.0
        for <netdev@vger.kernel.org>; Sun, 22 Jun 2025 21:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750652445; x=1751257245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=71ikBjEpBzjBNJOMwbMD9kUK68mlelj5P9jKd38KVag=;
        b=baQ4NHBoc++N6yMwL0AaSsab0TrPtoZoSfkmOnnM9JYIDrEdgqYreSXR0BXruuH17j
         dmdp6eyCNebXq+vUIfNh26g8WmUbyTPDuHcmqeBk5xbLBV8aCcwYyKA0LKsgjKRlE7Ih
         Q7HuqslfoNrxZ3gy/esMwJXN2Tfu/c5uQ4ek0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750652445; x=1751257245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71ikBjEpBzjBNJOMwbMD9kUK68mlelj5P9jKd38KVag=;
        b=kNAbGGfn9K+W+OqadXATQZt8RmDZRS+Bvf1Wb6GfA+rwxjrhTPmgqDJWVXcxRqduxn
         EK5G30qupcRW6PpSiNw70IIV5ai2hhaQFlLBAPAn4CxVCfjmcxy3NAGPirExYrqc+e6G
         TxREIZBv8XFl+GVmkDLibiaHSOCCVmYP+5hIvYkEKxfdTQj+29oWw5oYoNXNvQ02oxHx
         +0RafiiCj7aop1st+kY0/MV+WMZoHnQhyOdVlAHnnanq717qyh8rcRCcKANOk+a+Q8Lt
         LIgcvPz6jmXReTeiolHo8FN6GgqWpzj1/vDDDvMM6dZaN5hLafRfts5Zfa+YPSTgznHQ
         njEg==
X-Forwarded-Encrypted: i=1; AJvYcCU7IbB0ZgCjgcXfkHalT/gkAU1oNrdQYVK+OltzIbCa8RYa4Uv2OWUC+bAeNVe30W88bINdps4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX3GK8sLpaATRUAxRtNFm6ZLIm63tVRg9UR8v1TXcTVkeHo6dF
	EkpUvaVILpWTme5FSFnevMapFmUHfCggsAb/wI6DTJlOwJut6ziYsyV/oEZsqX0807BOJmrWJcZ
	548B2JjmwpYD0pihed4d7KyjOC9dThtg57UzETHN3
X-Gm-Gg: ASbGnctNn5pmtoxNJPr0nVOcV4PDBI2LG5nSo3W8xG0srZlj966vJeZ7u2Hk7mmLfFB
	RmfRdGwaEACCLb7gi9evIi8yb+SgQEuvkFX53tyea/5I8J3/oH3J5gzLFm3aHOY6TTF3DNKiOtc
	/bkIXq6X4eih1K8ef4Au/w33IM3b6YTNfh5l6+yDzrqlxw0B9tFX5E4eM=
X-Google-Smtp-Source: AGHT+IGjHMc9nHKM//QELUxyhKgkkeP+UL9egvitt540ZZsdqbDQP+0ZwlWqbPaxlTo3TMgIP9p7tRR4ukO5bsBbHo8=
X-Received: by 2002:a17:906:6a2a:b0:ad8:9909:20b5 with SMTP id
 a640c23a62f3a-ae057c3ceb1mr1085250966b.56.1750652445216; Sun, 22 Jun 2025
 21:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609173442.1745856-1-kuba@kernel.org> <20250609173442.1745856-5-kuba@kernel.org>
 <CACKFLin1Y=XTJcWQQwR=aDnpEvjdYVYaKgJZDAYGQvWzTx=gsg@mail.gmail.com> <20250612180444.5767aeec@kernel.org>
In-Reply-To: <20250612180444.5767aeec@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 22 Jun 2025 21:20:32 -0700
X-Gm-Features: Ac12FXzo9y_daHWlxaVOx_n_295PNs7m0ILfJ_urvldAayoC5yovldbJCr9NlHY
Message-ID: <CACKFLik+AOKy3dy6Dv-rLOhsO4m+Q54KZRaNv5W7a6OFbMWorA@mail.gmail.com>
Subject: Re: [RFC net-next 4/6] eth: bnxt: support RSS on IPv6 Flow Label
To: Jakub Kicinski <kuba@kernel.org>
Cc: pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002420b306383589be"

--0000000000002420b306383589be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 6:04=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Jun 2025 17:11:18 -0700 Michael Chan wrote:
> > Just a quick update on this.  The FW call fails when this flag is set.
> > I am looking into it.
>
> Thanks for the update! FWIW I'm doing the refactoring to add netlink
> support as requested by Andrew:
> https://lore.kernel.org/all/20250611145949.2674086-1-kuba@kernel.org/
> There's 40 drivers to convert so even if it goes smoothly I wouldn't
> be able to repost for another week.

I've looked into this.  The way flow label works on our chip is that
the flow label can be hashed with the IPV6 source and destination
addresses only, effectively becoming a 3-tuple hash.  For example,
this would be valid:

ethtool -N eth0 rx-flow-hash tcp6 sdl

4-tuple hash cannot include the flow label.  2-tuple and 3-tuple are
mutually exclusive for IPV6.  For example, once tcp6 is configured for
3-tuple, udp6 cannot be configured for 2-tuple.

I can post the patch that I am testing after some more testing.  Thanks.

--0000000000002420b306383589be
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
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIL2JPw2FPWUtAjEt6jXh2IqTY9sLL8d+
03J8fnk64piXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDYy
MzA0MjA0NVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAKUM+Roj9Ua0suzZ1D690dd6+5pyKEsil2f53SeO+zdJ/lFCpA9PhSUZEW2PmKKYyk+B
onrrN3RIFMfI72TOkmrza0UQFTGswmpacAJ2twH7mUuiZ6eA5KsCnU0QKVb6IBsXUTAxz8RCG7Nk
sc0VJXiN83SuM1BliFHtG7e/dteG6B0CFBFkboA1BwOh9sQPeC2qhzSKGdtfl437DiOJMuB8UaOp
ZC/IOg2T/FW2tiaxhGI1HKHaTKOt12U2FyDo97a6KYoJ6/7KYktslNMpRYGGlgA5DGdzfgAySnnQ
prz73B+e1XKCaqMolcWGV0la4cwhZ+wzOEQJNyGFkp90lQ0=
--0000000000002420b306383589be--

