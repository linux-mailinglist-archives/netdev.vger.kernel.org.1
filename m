Return-Path: <netdev+bounces-111021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C301A92F4D5
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 07:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210801F2200B
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 05:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22DA179AA;
	Fri, 12 Jul 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pe9dhbZj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C7F9D9
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720760912; cv=none; b=PShXRZxH8UZ82fhck9SF7xwEfxwVXcJ3F6URfJ1CTmB/EI+I/R1gS/CBiIbYcU6ssoAWLl1Az7L5eKAht1nA4dH3+wQ+OFINCmn4eqm1QITsnyeMJ4Dxojz0khpkWGTxbqqKGOui/AJJ1gXBItTSHV8JenMT1kZiUj82vt88TY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720760912; c=relaxed/simple;
	bh=quD3eQBmDxEAJKB+NYwpsdf49UT/bDb7wR7wjnMGw7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClgM5SbxNjhYh+ZBQYfVRvC+4dif5qk3lotNUhVKFfSB5gJTyNQqwZ036OMAI7fmyKBRjVjX/EcVP5FW/q5SYVloPIojz0BpvhAlF04X6UYHNNzX3lYOFZg2ETMY4mXRRVhW2dD7nDFs1xP4P2Sc6mmprCfOEaL4qWllJFP43Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pe9dhbZj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c964f5a037so1264920a91.0
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720760910; x=1721365710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=geafdiUc3ASmD6z1Vp7rcV2+UbdFglhr8xZyA5Zn/lA=;
        b=Pe9dhbZj4U5/xUDeabLfgKw7iazU8aY12cM3vfaPuHAZUqdV1pbdozOiLCTcnpA6Es
         bZQn2ej1q8mcocsfWArO0MA912KAZIQBCU5v/cu6zSx0d7tCYM0TxYVp+LygXJWJ2kbm
         Z2QhDH9HB6BH/P+ne+8ETowMBPE6ISY6i0BFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720760910; x=1721365710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geafdiUc3ASmD6z1Vp7rcV2+UbdFglhr8xZyA5Zn/lA=;
        b=P+yRPyLj4rs/VA/KQHy/mUck5yhGc0mJFKYje+zQyrZ19hy2BmCdAdAksZyHX2w8Wh
         +XpM8zeAX2i0CjiM6sp4nd5Ri14FF6kYaFpoZApumU7QwbIT7PQeD9myUMOLkW03adr9
         2Km6oDBULm7/8zTNChfGxZLN8Wak+aagQCPnJEKQBRKidpGROiYM3gA6ALzAYfgTKZOn
         Ovpk1qgVlwjm9+XqycfR4TwC1Pr5sydG9xqfHwBOZxJipQuq4+CO8+J0VCpnutZ7BjxZ
         yLkDW15e6PmZhFnjgc/VaQOalAEG8hQKJukXvOiXYKcfzB4swcA6gM6SiMdDUwmxWRAf
         HDQg==
X-Forwarded-Encrypted: i=1; AJvYcCXDPUvNkfsFs8CEBHvXU9Inb8ZBRuMeTmuEs6Yvwfn4yExZIrye/5PK/jkIPBsvqausALOQpHJ354bhhNUnque8uZN/UOIC
X-Gm-Message-State: AOJu0YwNGmw1rucPWF8I5sboSsF7/e7uDPyM/9RhjTtkI6mJRAdGary+
	LuFq7PlvkmbTuoxd4LeISUVv5U4QG2FlqvpbbAUGV69DEOzBQaXRDYg3gip4KVu15RhciHuiptW
	DQBUqSecmJ0ISQWUF+1ZCpIEvxRzQ23cemeLS
X-Google-Smtp-Source: AGHT+IF+jxOpmeZyH0WHbt89/+cHQ1F2Dp262Bdqw9iMKj26WNoc7LBA9RdBZqCOF012tjaeXyn1IkVeCfLtsl2JfGs=
X-Received: by 2002:a17:90b:d85:b0:2c9:6b02:15ca with SMTP id
 98e67ed59e1d1-2ca35d4b0f0mr8165889a91.39.1720760910245; Thu, 11 Jul 2024
 22:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711220713.283778-1-kuba@kernel.org>
In-Reply-To: <20240711220713.283778-1-kuba@kernel.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Fri, 12 Jul 2024 10:38:17 +0530
Message-ID: <CALs4sv1_0vzEE9g0cH0Oab0nYEC0b590s5XsaHrfED6CT-Ghbg@mail.gmail.com>
Subject: Re: [PATCH net-next 00/11] eth: bnxt: use the new RSS API
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, ecree.xilinx@gmail.com, michael.chan@broadcom.com, 
	horms@kernel.org, przemyslaw.kitszel@intel.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d3e00b061d05de1d"

--000000000000d3e00b061d05de1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 3:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Convert bnxt from using the set_rxfh API to separate create/modify/remove
> callbacks.
>
> Two small extensions to the core APIs are necessary:
>  - the ability to discard contexts if for some catastrophic reasons
>    device can no longer provide them;
>  - the ability to reserve space in the context for RSS table growth.
>
> The driver is adjusted to store indirection tables on u32 to make
> it easier to use core structs directly.
>
> With that out of the way the conversion is fairly straightforward.
>
> Since the opposition to discarding contexts was relatively mild
> and its what bnxt does already, I'm sticking to that. We may very
> well need to revisit that at a later time.
>
> v2:
>  - move "lost context" helper to common.c to avoid build problems
>    when ethtool-nl isn't enabled
>  - add a note about the counter proposal in the commit message
>  - move key_off to the end, under the private label (hiding from kdoc)
>  - remove bnxt_get_max_rss_ctx_ring()
>  - switch from sizeof(u32) to sizeof(*indir_tbl)
>  - add a sentence to the commit msg
>  - store a pointer to struct ethtool_rxfh_param instead of
>    adding the ethtool_rxfh_priv_context() helper
> v1: https://lore.kernel.org/all/20240702234757.4188344-1-kuba@kernel.org/

For a moment I was confused and a little scared not seeing v2 in the
subject line, until I opened the email :)
Series LGTM. Thanks to Edward and you for a cleaner infrastructure.
For the series:
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

>
> Jakub Kicinski (11):
>   net: ethtool: let drivers remove lost RSS contexts
>   net: ethtool: let drivers declare max size of RSS indir table and key
>   eth: bnxt: allow deleting RSS contexts when the device is down
>   eth: bnxt: move from .set_rxfh to .create_rxfh_context and friends
>   eth: bnxt: remove rss_ctx_bmap
>   eth: bnxt: depend on core cleaning up RSS contexts
>   eth: bnxt: use context priv for struct bnxt_rss_ctx
>   eth: bnxt: use the RSS context XArray instead of the local list
>   eth: bnxt: pad out the correct indirection table
>   eth: bnxt: bump the entry size in indir tables to u32
>   eth: bnxt: use the indir table from ethtool context
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 126 +++++--------
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  17 +-
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 165 ++++++++++--------
>  include/linux/ethtool.h                       |  20 +--
>  net/ethtool/common.c                          |  14 ++
>  net/ethtool/ioctl.c                           |  46 +++--
>  6 files changed, 194 insertions(+), 194 deletions(-)
>
> --
> 2.45.2
>
>

--000000000000d3e00b061d05de1d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFEcbnAuoIGTHqlGuoDo+IYgABmonWLa
ideRagCcxWbcMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcx
MjA1MDgzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA+BQE9Tw9huSBJVA6UBrPeP7N6G8tUlf/1N+367fpB1XX30sfK
8zN81plzIntUdGtqzuGQtYWH6gphMz/TlmJ+h3gRYvxEAIlwpi5wQx0deEJp4ZbFsAHrjx98OcvY
UdFKtpc5ZYidarFEOvdddDCmO/TRnXVOUjyqdMCs9LMPkYa3pteiXwjAQjUSJR45zmOlrdTyJAFp
ge3Rkdcj+LafI+DSfTzo0XEDaQoM5vajf9GBDEXq7jeJ77JoOBZSccwUtEFJA8wdnNzzH0ALwmSF
pWdpRQcED//6PqBky3uTuTvF3vardIhM8PKcjz5LQoleTPpS4MW2JkZh2CnhnEJs
--000000000000d3e00b061d05de1d--

