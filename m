Return-Path: <netdev+bounces-115420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8EA946503
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 23:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E2D1F21FBE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 21:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540AB745F2;
	Fri,  2 Aug 2024 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FVgHj7cR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7C6E5ED
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633930; cv=none; b=cnn+DB6jC1/nlfKWIEl3hejrVm2lRbE6Kg2YfzMqN3sWnGxhsiT1poJz1pEmaBR9Omi8gV5P2Y8zSxJffOJhzyQNF85PM1Ld6hsvenpOfFzM8BgMJrhaWJGyPfwEXGZirBYjnSZoBkyMaFnxBf0w4WunCnESuIFNFaDJOkGASsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633930; c=relaxed/simple;
	bh=wJ6+gE0RrxkbSeXufjLsFecuQwSw48fVi4HHohbH25s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChKH2alUPkY1qPXrMnAIFNXp222/q+nflmgOhRerTiRprtaNsgZHhmm48l54lnAgi5NFWRPimICv4zZdaMLNhIoZKhyetG2e2QY5deqy5ZhFtksg3mCWSdQEhSdF+F94a/0cWc8CWHA4v5/ss1L1xGJKdsut2gMBFspWuIxAMKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FVgHj7cR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso135305341fa.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722633926; x=1723238726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gpe72X5jSdzjCl+8RLDY6YiI0u0uaABwzZ+qE0pvc/4=;
        b=FVgHj7cRSAAkxauUbaLiFJxOjJ8BJRu6a+3wBe1K8d18K4L8FLDwrf9y2q3Ij7vGb7
         g3cXNt9CMxtPdICW8//JJGS0HqfRuWBeh88xh0iy/8XPEeoFhesRHE/4bwEcL4juKA+C
         2oCIwjdJabxqWwu8880lCm6Ngi0ZvETzRV6DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633926; x=1723238726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gpe72X5jSdzjCl+8RLDY6YiI0u0uaABwzZ+qE0pvc/4=;
        b=j58JQzRYMmqF/MmSYUKZYcswBV49lfUn8I5+++udhyf25jxakjK23lgLCkSoyRaWQB
         8t+dZKsaPtYG+V/mWMgBrKm8LQO5SktaPp9rddCXbCs4yJg9BF7gZEyJR55woUmocIR0
         6Cx9XaoYe51UraYNfHhYwPRquTQCZxzqIu2Q38KiJHvXiAYa0DU3jReXKdxI7yZ0dn0d
         qWv3SCfQVmDPE+sEZtUyYS6frRhaF8IofyOH2auaeV8ddlTVhTlb8N+EKJo9tFzcnG8g
         nPeGCZNAaH8HWxocKvE+qnu2eQQpGg9g384GV+fgiGK1X/QmHXvi8K/4uFLGi0oVOTfB
         UBjg==
X-Forwarded-Encrypted: i=1; AJvYcCU+FnwloPcYsT4/v+lgFR+fYolhCvRWH73Ok8P+tfJ52WhOX74SMJw8BN8C/CwJDYvX8mN+updUmZ0eYvP1TqEbtIpK/B1k
X-Gm-Message-State: AOJu0YwDmehgjm12UPwqEcy7X7fruosoj9z4+NAQSmKn3PuxjhTAqscW
	HTofv1ojJpCbtTKcuQ3MgT6OtYXdsbO32NeIiw831Vles9kcHe6XKqeaoZd9i3IRRUdZDA90Is7
	hOquTEl12ViF0wzDAP7mvlgZHLNLfLoGEcLc2
X-Google-Smtp-Source: AGHT+IE+iLKKhc+5zi31CYsrRlLbv456kbdSqIBXBRw1vXMW0hnorrLhy6cRC5FpmcH7Nr4ulw6B6azfrDPW6pN+0L0=
X-Received: by 2002:a2e:8384:0:b0:2ef:1bbb:b6f8 with SMTP id
 38308e7fff4ca-2f15aaf6431mr37132381fa.32.1722633926106; Fri, 02 Aug 2024
 14:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802100448.10745-1-pmenzel@molgen.mpg.de> <CACKFLikjqVZUXtWY5YBJPT56OqW0z00DxkaENzG74M64Rrr81w@mail.gmail.com>
 <3b36a977-426f-4f5a-9a1f-989a95a55a2a@molgen.mpg.de>
In-Reply-To: <3b36a977-426f-4f5a-9a1f-989a95a55a2a@molgen.mpg.de>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 2 Aug 2024 14:25:14 -0700
Message-ID: <CACKFLimBsxB=jsjbS+GTd+0yMtFc4Qh55Y_DzY9SFOryYbwLFA@mail.gmail.com>
Subject: Re: [PATCH] tg3: Add param `short_preamble` to enable MDIO traffic to
 external PHYs
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roy Lee <roy_lee@accton.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Saikrishna Arcot <sarcot@microsoft.com>, Guohan Lu <lguohan@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000483fd9061eb9f770"

--000000000000483fd9061eb9f770
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 1:55=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> >> +static int short_preamble =3D 0;
> >> +module_param(short_preamble, int, 0);
> >> +MODULE_PARM_DESC(short_preamble, "Enable short preamble.");
> >> +
> >
> > Module parameters are generally not accepted.  If this is something
> > other devices can potentially use, it's better to use a more common
> > interface.
>
> I saw the patch in the SONiC repository and took a shot at upstreaming
> it. `tg.h` defines the macro:
>
>      #define  MAC_MI_MODE_SHORT_PREAMBLE  0x00000002
>
> Any idea how this should be used? Can it be enabled unconditionally? I
> do not even have the datasheet.
>

Here's the programmer's reference:

https://docs.broadcom.com/doc/571X-5720-PG1XX

But there is not much additional information about the SHORT_PREAMBLE
bit.  I will need to ask internally about this bit.  Thanks.

--000000000000483fd9061eb9f770
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGO1xxcypfeI6uKpRE06lFgzNe5AK8PC
kMul3wUNnnAtMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDgw
MjIxMjUyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAZ7Lhm1fBLSBBWzgTpzimrMlcqsWEUTKgk2uIlQiA2ZW8KGucL
g2WoZOQqcbM6ghnsthPUkUMs52hHaYvtSu8/6fd8s341flBT0WGv1uhW+4txMjmauzgZs5GwCdIU
agd5rBmIJZ6b9M1EfsoL9zDJyPUPm/Txk74f8he82sJEeTRDQ1y4x9efRqgzMqlAT2hPzDl5mMpx
vo7he/snCtuxKc3QqAg3/umLm3XljEOvFzmgFZZs6kha7T9DJp8GX+xSOy5piSJMVhWJixF8MhCt
Ov2c0NprF93ppckEmgFKKgQyAv70GMtPqBssiA+2zhIO+80LVMqGiJz1Bxw/Y982
--000000000000483fd9061eb9f770--

