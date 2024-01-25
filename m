Return-Path: <netdev+bounces-65955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCF283CA61
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996EE28FB65
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A826B131E40;
	Thu, 25 Jan 2024 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T0+9gGD7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562C13173D
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205511; cv=none; b=TDai0yskxgdbXNatwf46LTFgY85WOCe/VGpWcZi8peMYQ7XjDE21oGoZox3g3nnWdbHHJvZX7bi+TZeVz2Iph7VErIa4KHG2tTrnr2QHJ9oaPXmwkhulVvZ83AKA8NUT4rfYtfjZdUGprMcijkV9p2HaP4s6Nr3s4aszvZId+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205511; c=relaxed/simple;
	bh=vaQ90PYL10Qbi9wUi2QpzVjumNu6Z7X5ony9lokAw8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGIlSaQJVhJE8wiGWhfUFIy3ZH6CfNzBvV8O5j2XMX/bQ66G87eHfHvHvZy3YyX/CRJbuECDh3jrs91yIvD5tNimv1i9hIAnJgwIc40isXvp08ofBCtDpkL8C3s0zYoSbtrjx0pPJ2e0Edyv4Mp9oqiKqspPLGEclIBDh44r6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T0+9gGD7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so8470358a12.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706205508; x=1706810308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vaQ90PYL10Qbi9wUi2QpzVjumNu6Z7X5ony9lokAw8U=;
        b=T0+9gGD7sWsQn8kN/7t+hqA659b0+mbW1OSksZddvBByShPTB5gBE3V5TLw+EQ7ywb
         mEIcx6L+1mD9BII7C30Zk5BIlZHEZPaVr/Z1+DvSwwVXmKyfhh4DoB2s7zaXdkAlbb4G
         pPvIuxQ3KLbuIUsmo4zeMSVnBHc/AAbOqrOjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706205508; x=1706810308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaQ90PYL10Qbi9wUi2QpzVjumNu6Z7X5ony9lokAw8U=;
        b=nw0RJBCRiQ/TYe+czxecaQtvRRhz+Qlrhlg70B99lR8v65kLd26MfQxy/7zqHPqzqs
         bGrOsBf74BDJjHUvCLEOFbb0bx7V2yPuYCpz+llW5j47qAmFSEiSYyHLkB2J7Cy/Eoq7
         4aYqA950LZzDmTl4CBQCY1GBkdd5BGKnjOoaeurYalV3uFWgGdURYmKGT9DZaomHeftB
         4NX+EIr9IwwYBjQZi4mqULL1/anOchuF+OkwZBVNsxEFeKLyrRMEXW4B6R9am/T4OtUO
         GN9e+2P0uLzH3MPhGOmFCC1tBdGBwHzNjtJlxdBeFQNnlQYrDF5/0bS9qVzQegQ7Z1eE
         bx4g==
X-Gm-Message-State: AOJu0Yy/Q35+UoK6EEHofQqhq0h62UWqjEBzkCl+aq3Jdr5Lss7buHor
	jWpsnz5THIxP6e4jw0VH3hi9HDpqHoYW9Tzg2l21uLfqE8jZI9hUNs+nPzKLlXVoZALUtZr+QWj
	/X1ccTo3NP9PLTXkzNQuA0xhnqrJ9JPKwl7pNO8Kbm0UORZu8NA==
X-Google-Smtp-Source: AGHT+IF9sZdy3BdK6SDBslqiijKWGUz4xonjpiiKLmbT51Q9Avf1kDvk/em9mM/DH/9mJB9eeSb7jof2V8Q0kgX8nyI=
X-Received: by 2002:a05:6402:1619:b0:557:ecab:55c1 with SMTP id
 f25-20020a056402161900b00557ecab55c1mr4119edv.9.1706205507914; Thu, 25 Jan
 2024 09:58:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125134104.2045573-1-leitao@debian.org> <CALs4sv2U+3uu1Nz0Sf9_Ya6YKxK09WU=QH4VmO94FjC3iWX3rA@mail.gmail.com>
 <ZbJ11qxfmOfRseJO@gmail.com> <CALs4sv3cpcy5G6d+3UL8dVSyN1vFbgiin8gLiVxKOfWUAAB0+Q@mail.gmail.com>
 <20240125094444.3185487e@kernel.org>
In-Reply-To: <20240125094444.3185487e@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 25 Jan 2024 09:58:15 -0800
Message-ID: <CACKFLikMtipC_aJZcRztsv5wixsK4sFXo=_5N--_RkOupgoSxA@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Make PTP timestamp HWRM more silent
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, gospo@broadcom.com, 
	"open list:BROADCOM BNXT_EN 50 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003d8175060fc8ed43"

--0000000000003d8175060fc8ed43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 9:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 25 Jan 2024 20:51:25 +0530 Pavan Chebbi wrote:
> > > > LGTM, however, you may still need to add a proper fixes tag.
> > >
> > > Thanks. I didn't include a fix tag because it is not a fix per se, bu=
t,
> > > I can easily send a v2 if this is needed.
>
> We should pick it as a fix. If we put it in net-next and someone
> complains cherry-picking it into net would be a PITA. And we shouldn't
> spew WARN()s about known-to-be-occurring conditions, GregKH is pretty
> clear about that.
>
> If you can post the Fixes tag in a reply our apply scripts should pick
> it up automatically. Or at least mine will :)

Fixes: 056bce63c469 ("bnxt_en: Make PTP TX timestamp HWRM query silent")
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--0000000000003d8175060fc8ed43
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJWZ4AMB73YsiDkiyp0qHDS9WMWWxkCO
Ft4bE5Fhg3ZTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEy
NTE3NTgyOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAN7cvchXhkhdzr9N7tEAvZHVh6PEzDVKiFnJjKLG8K4S5ds8gt
LQYBcbgeHo0fIf0QlII5/lu5pkSafij5d+JdISONpaNPVp8qmYJDPVGrior/offtHm8cSoVZB068
lqyZPOdVyzvTXOWqnIZz8ygQzwA5oWYYRjUFLV/ivLAo5FT0Pg12Jf6cgjKIwqYfb0Ejl7fxpTxJ
bqDaMQmk6it0k1upIbdgxvlBsBS5mImYxEscvfFj2vLkFTwNeQ6eYeQTm+P1VRlqVka+U5/HiCRX
IqRaGXWtfqMWuBfujntrBFrVRIKrwjm8+G8/oeN58N6GAcYsTCmqlG9cmO29RuTQ
--0000000000003d8175060fc8ed43--

