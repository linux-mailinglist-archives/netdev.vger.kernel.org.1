Return-Path: <netdev+bounces-107385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E6891ABF3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50741F21F37
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9F1991BE;
	Thu, 27 Jun 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ec29hWVR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F00198E69
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503702; cv=none; b=Fm4zlr+fBLVONapdrBzQCzf6QFNH/xc7NKiR0r7lcKgtrlmYXJT+7Tg95XjzMZbs2XVPzF7uYXFQqxA5Jv3dbSbTru4bTDgxt9ygJcADJdaaI0d6DQ3UD8oo6bZ1jeCDESNtSSMkYItRhfyYgaY2gNFqIEcb72ZChhcf8xzh+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503702; c=relaxed/simple;
	bh=opIWC9CeXwyOiAjcwFPwOt7FfxgxxrYLbp/kBlMnJRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsMyfxzjj4eGPqIth09flKWZBcPtdOrtkoqKWklihcrDjpULbLrnig51qC8KZyGh9HVFf+C8wbTrn0FEyKIID7Hk16Sk985aieMAjVXTMDQndhBbmx90qbRxIlsjb4NpkUL3ISXUBX/H7l3+lpPg//KdAy+uQrGWEdbUq21zReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ec29hWVR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so91184531fa.2
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719503698; x=1720108498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RH+YREQFUMU44LSB4bmzgJEqJMEMyaQKGby0+4WdZmA=;
        b=ec29hWVRUvq2rOWQx7vMV2oRYrDRUyJQ+QBpmgdkUmHZb008mXvG0A5GL6PtUvSxUI
         YJATJZ4YHn4pi9y3FXmcXAN0i/4j0gi4s0iIW6uCoYf0wVbxpD52WOPRbeKb9FOnQ+8S
         PfeqeX45dQsGPxr4SRajd/e3SiBMafXE0jhgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719503698; x=1720108498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RH+YREQFUMU44LSB4bmzgJEqJMEMyaQKGby0+4WdZmA=;
        b=u9Qzmaq5n0+H7EfLif9om5TWaQ4tUG0/jcuHCOxDBON660kHgrVv3lyMwY6Wgqv8em
         sBRbiBc6WPa+I7UzYsPdsIUZ79ITL/ZmOVdputM3Qhg5soXVw6U1szDWDOAdMwUVRwSN
         3NTYjLafz2qkZBpzM7IfM9aZwGMqbUedGePk1LS2TPQBYiqNWyjokrHqP9fFkycKPfCJ
         xw0WBd9WfmysmJaIiBkG1hGvXedI4hSBdBh0PbxSQbvxNnBFU1tRbsHRywVKVEwD/ySG
         mngEJcA+7vXbfu5mVDGwDESZ7uYFX3MZD4tPmDzqr+TG1Mqi2DXQvwUFWPoIgesX+msc
         rdZA==
X-Gm-Message-State: AOJu0YyxPgElwn++4IV6pckjnlTlNtKO86Cr6aLqvy2hs8LS6X/NvA7u
	PqTWKeLz/YFRBxsOEssMOGXw9NFD3sC4qO67eGh8Lvlkr1pSu1y8GLsx7dkRdJsj8vAXi5M4oF1
	PiN7FAhjvraOJD6SlxYqDLHsTIALJKpco1yc3
X-Google-Smtp-Source: AGHT+IHgJRwunIkWBuK32VYQeq1xLq0gE9XWiZ6kR0QdnrIhh7Lmo7SyYtI4umdCwtSJ9aVDm6ugEhSYkbpVCrD9fCc=
X-Received: by 2002:a2e:9d86:0:b0:2ec:5061:d7d2 with SMTP id
 38308e7fff4ca-2ec5b338a67mr85309141fa.18.1719503697909; Thu, 27 Jun 2024
 08:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626164307.219568-1-michael.chan@broadcom.com>
 <20240626164307.219568-2-michael.chan@broadcom.com> <86bf3922-e38f-4230-9a9b-1461f36d85a5@intel.com>
In-Reply-To: <86bf3922-e38f-4230-9a9b-1461f36d85a5@intel.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 27 Jun 2024 08:54:46 -0700
Message-ID: <CACKFLi=w90Vk5tr9PvjDxX4zuwvA+BoqbmRvYiDLqd_RQev_HQ@mail.gmail.com>
Subject: Re: [PATCH net-next 01/10] bnxt_en: Add new TX timestamp completion definitions
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, 
	richardcochran@gmail.com, davem@davemloft.net
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002677ad061be127b9"

--0000000000002677ad061be127b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:00=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 6/26/24 18:42, Michael Chan wrote:
> > The new BCM5760X chips will generate this new TX timestamp completion
> > when a TX packet's timestamp has been taken right before transmission.
>
> Tx
>
> > The driver logic to retreive the timestamp will be added in the next
>
> retrieve
>
> > few patches.
> >
> > Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> > Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> > ---
> >   drivers/net/ethernet/broadcom/bnxt/bnxt.h | 26 ++++++++++++++++++++++=
+
> >   1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.h
> > index 9cf0acfa04e5..d3ad73d4c00a 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > @@ -181,6 +181,32 @@ struct tx_cmp {
> >   #define TX_CMP_SQ_CONS_IDX(txcmp)                                   \
> >       (le32_to_cpu((txcmp)->sq_cons_idx) & TX_CMP_SQ_CONS_IDX_MASK)
> >
> > +struct tx_ts_cmp {
> > +     __le32 tx_ts_cmp_flags_type;
> > +     #define TX_TS_CMP_FLAGS_ERROR                           (1 << 6)
>
> those should be BIT(6)
>
> > +     #define TX_TS_CMP_FLAGS_TS_TYPE                         (1 << 7)
> > +      #define TX_TS_CMP_FLAGS_TS_TYPE_PM                      (0 << 7)
>
> weird way to spell 0

These hardware interface structures are generated internally from
yaml.  All similar structures in this .h file have the same format.  I
think it will be better to convert them all together in the future to
keep everything consistent.

--0000000000002677ad061be127b9
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILvNJ4Kn1aXREG6XrS+6OvtJ20qjSzzB
8+TWv2GGL4tdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
NzE1NTQ1OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQArXt79bEnsl+y0cj9suGnxSgzNJGj4fo9cTfq8mADT182big/K
qQf9DWd9HVURVZOq9Lq/oh7syqZy0RY9LuNTPxidJ4LIbpg+qVj0KCFUwb1suCjZ+JLm7Ls0FW52
fAaM2yLr8vO6dzm1GaJramp/4p3qlu2ZGl2LRf0Gs7fGzpk1Y+IVzsL1igC7lrFaPYPBAx3BVplg
41Tm31W4DzWhkSd2oxxN9fFjfAX0a3YJDnXLHm65gFTwzrSXH3m7ywhVsQj70McE4Msd/shLhMul
ixFrgiHJF2nGi4SYwQe7GoSiDKkx5rtJCLihLkXqqIJStXG2hSS1Mz4BaRog6mOp
--0000000000002677ad061be127b9--

