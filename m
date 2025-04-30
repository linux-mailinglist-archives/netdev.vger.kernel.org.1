Return-Path: <netdev+bounces-187141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C08AA52B3
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 19:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702DD4E22E6
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72999231845;
	Wed, 30 Apr 2025 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZnEli6FC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98B1A3177
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746034629; cv=none; b=QmRvgFPwElLL5F//jqVkjJABURQzMAuRJ+2jICBed84GQMoWgza5bvcRWNrvNZS6d8GpKxATuDwRJyCLv6npm6JR+SRRjSBQzHS3EQ9VJyi4FPRIJVAztKVoj48LkRHYlV1qUd7totancjnGdXLKvnIbVj1oXvTgHtanHaxPB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746034629; c=relaxed/simple;
	bh=UBkpy5vDRMHh2aM95MJDqelfLSnbUMgAnpORMtlH2Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJRgEbfLTT1581/fbFg1n7XGrg1NidlVOtO8XA8J59ivah3xfwdTOP600WsIYRe4gwxe6QeOTUmU8OlQLITbVL1ksFJX3stecqf52zSLw4+nvtuqUwtE+w+aBbRGUBmqD02uCye4fiwhgESXRPd8tRsYIMr7quZsMe5r/yQs5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZnEli6FC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso297042a12.0
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746034626; x=1746639426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tcd2Gt+RWZNO6TkLmRjy/t3WCsfrr+5R42mYPuL8BzY=;
        b=ZnEli6FC+axwZ9im0I5B7TPiDIeIDoZiNgZEx4/MwDs7/pvP6tmObMMipV8WIt6JKl
         q+iIzPW+YKTdM9SMg225Zi54V7rGRzAnwqC+zOu3KNbP14P+57dxzN6/LeyzCWCqbwC8
         /MDzcse77KWNMcWeyVreWqTghskkyezNO6fnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746034626; x=1746639426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tcd2Gt+RWZNO6TkLmRjy/t3WCsfrr+5R42mYPuL8BzY=;
        b=WNNkHKG3lwRcZHoYt5FdEQYZ4JT7qpMpysmhA4umtGFl7nePSwxGaDHAz7kBJq1/50
         wTYywnVAYHavhkCW120jaOBDcdJN3lVVQeTbRQrxQ/42/lGfX3gcS2p8hjvyAfxG2JkE
         OLnKqmn92MAywBQzHwFR2aq5x+UGqxyndbf/niKUbN19SUlBs+6R0795FjcI77QqkCOU
         kXmPrbSfVPjXSOQ7tadYuEy7uKvDBzv+kWOHr02hy1nTkDfih94Z+T117RPOdOL1UPoU
         a/o7O/R7awWlC4tBumTQOkCSn5jwGAR73o3hO9EwmqGGKxVrErtghRN6NeXAiOZtrJzp
         KHpA==
X-Forwarded-Encrypted: i=1; AJvYcCVMV/3xbXhJC5gLOtS8a5UOLl6NMKuSLyiYKc51yo9vQ80XbDdbhzRNKFywNhU8MPIEebBHklU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2p0/5EHKT9UgJryDWOGelkFa2KwAQaM+YGyclnnCrPz/F6aOJ
	8aHj92Gcg7bWpw3NwiX6g3iUfdmedABfr5qWVRYePgfxySfKpUFlduhs5ugKDqjaTh26L5O0Rbu
	zCgBE3AQ5M0Rt7W9VFwxsDToupxFgsA3gIEoG
X-Gm-Gg: ASbGnctNQ3JGRzQsCPKOdgc94rsqlmLR9Ye5pSwTITBCdEZnUr4E0MLkI1xxmo6cCxS
	fC5M31q8zdIh783aRtpJ5bvF56eNf0ZbBOmHRw/Q93Y1326A/qB7N4UbuJJkDHQJYj8ZkAKg4t1
	sXxPhrdEJv7KOj81BI4TJdwWVhHBc4jmTlHA==
X-Google-Smtp-Source: AGHT+IEhNDKTl5vPF1HzfY9TPVSTTk+UgDhkV1/x2UHNVlXOIxdgQmzomE9nb5aTRViWWRrpxTzmRPDiGHFoL7E41Pg=
X-Received: by 2002:a05:6402:4011:b0:5f6:25d6:71e1 with SMTP id
 4fb4d7f45d1cf-5f8aec5aa07mr3112921a12.0.1746034625802; Wed, 30 Apr 2025
 10:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430170343.759126-1-vadfed@meta.com>
In-Reply-To: <20250430170343.759126-1-vadfed@meta.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 30 Apr 2025 10:36:53 -0700
X-Gm-Features: ATxdqUEEL_hFhTaF_5r4C9ASw4CJBaTJFtIZqe0wTNPaXPcfZz3T5F-U4z5ndQk
Message-ID: <CACKFLiniEL5bcf7Zz1WD8PEZOaiLYNEzN5oT7fqCfB-10VNT8Q@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: fix module unload sequence
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Jakub Kicinski <kuba@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a911b10634025df3"

--000000000000a911b10634025df3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 10:03=E2=80=AFAM Vadim Fedorenko <vadfed@meta.com> =
wrote:
>
> Recent updates to the PTP part of bnxt changed the way PTP FIFO is
> cleared, skbs waiting for TX timestamps are now cleared during
> ndo_close() call. To do clearing procedure, the ptp structure must
> exist and point to a valid address. Module destroy sequence had ptp
> clear code running before netdev close causing invalid memory access and
> kernel crash. Change the sequence to destroy ptp structure after device
> close.
>
> Fixes: 8f7ae5a85137 ("bnxt_en: improve TX timestamping FIFO configuration=
")
> Reported-by: Taehee Yoo <ap420073@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAMArcTWDe2cd41=3Dub=3DzzvYifaYcYv=
-N-csxfqxUvejy_L0D6UQ@mail.gmail.com/
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

The PTP destroy sequence is now consistent with bnxt_shutdown() and
bnxt_suspend().  Thanks.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000a911b10634025df3
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGGjhgcGRX3d6uMY4epjEX3vcCzo0EeX
H+vQCY2//yXNMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQz
MDE3MzcwNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAJIV6ZNzNUERuNCeZva32fO7JnWzYpOX3rT/3moMOemiBzDF5muLY15a+anSqkEn/oGC
30mlmZuuG1RMho5UxF2MH/B+5JwfskrBj1H6XjF86LIYBGyVI5tuDGBViqrqMu/aDFHkHnawaR9v
Ynwn+H4fAW5nj1gd0xn0qQOyk1vNP7u3ke8XcquPdNqb0zOHYwxIrkHeDv8K1INDkgkTNOhlD5lV
w5/5BJFltocw9YJFh/08iXS3pLcVvB9weph9b9eG74XmxJQ0/db9vsjkXL6mnDA6K3hLzzLAJZil
64DUVmcxBRZhTGN1vM0Ze6ddsAeSEAwig6lCX0LJRAkZZpI=
--000000000000a911b10634025df3--

