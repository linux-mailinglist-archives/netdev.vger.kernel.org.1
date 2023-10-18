Return-Path: <netdev+bounces-42335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6AB7CE5AA
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A9E281C25
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37113FE32;
	Wed, 18 Oct 2023 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="firPQ1uX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0A154AC
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 17:58:43 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C9910F5
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 10:58:31 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3af609c4dfeso4539736b6e.1
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697651909; x=1698256709; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dL4EsNrrfgy5WLZo+vWceKEP/WwNtDrpz2gdCuhkj9E=;
        b=firPQ1uXyBqplLUthaTDc9e50SO5kTtALhCoY5GG7VpPfn4TTRgrvvbdo9i9doIhco
         v/+P23IqRXwCI3kSeL0MKXNSxzeLm2XPC3BbV/MFZedZg03fNbvUMoQjkk9viHK8ha99
         gngG+4qzaTT3B+owMUhknnogTpFFNtIR7JSIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697651909; x=1698256709;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dL4EsNrrfgy5WLZo+vWceKEP/WwNtDrpz2gdCuhkj9E=;
        b=J6BkoHy8A/5Qc4yrR9Jtf1wMVCFrALT5jsPFiS81idNoYt3287f169SAWqJaiFEQ0k
         Vvzv/LR86LFlsmtD3nFrnQs/fzTtA+9gIjz1vyfx1WZWmrH5S5YsYJR0PA1Uyr9mCoTy
         M01os/dbB6Yexi+K+rurx3Hp7Ehnhb1GfS5L2fVNq1HtLgBLA2vCACzh1snNxC6/6P2m
         SiWp4mCyS5yv+Sev8Vboex7RMTXiaBW+saWhccaSHoBbtrm6JiNNsmIntvXUvzOZJZSq
         K0KqR8k2SIfYxtxEuouPjfD/1O/9T0BxeBEBR0EXuT4V8rYuJEa46KYvMXuqAxE+8ayE
         8CLw==
X-Gm-Message-State: AOJu0YwIZK2AtCmXPqbEY9e9d5X+veyfD0M5NQlZVhcynwm3MQ23gYwz
	/7+6t1F+nSFwFJOvmXENAvYlnALIEJtiH0njp5Lbj2KWcB9a/Q1CMCrh1izCr0ESscZ70qtSzQ0
	98fZMuezzop6MTNfu3FlLkBMA5cUj0Xrv1ug+21QnYnP9LNt01tPuQLaX2acGaVXL1KJydlg6zE
	IzSyVQs1AFWQ==
X-Google-Smtp-Source: AGHT+IHCBn233UVVF4lPlF4wfwtRSRv/pVfjg3Q+c7fYH4OLsdzARQl698Qq7QwK0IpJkye8aMZY4w==
X-Received: by 2002:a05:6808:1493:b0:3b2:eab1:918 with SMTP id e19-20020a056808149300b003b2eab10918mr2365264oiw.29.1697651908888;
        Wed, 18 Oct 2023 10:58:28 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k15-20020a0cfa4f000000b00655d711180dsm133330qvo.17.2023.10.18.10.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:58:25 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH net-next v6 0/2] Switch DSA to inclusive terminology
Date: Wed, 18 Oct 2023 10:58:18 -0700
Message-Id: <20231018175820.455893-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000195ab060801630b"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000000195ab060801630b
Content-Transfer-Encoding: 8bit

One of the action items following Netconf'23 is to switch subsystems to
use inclusive terminology. DSA has been making extensive use of the
"master" and "slave" words which are now replaced by "conduit" and
"user" respectively.

Changes in v6:

- fixed typo in if_link.h (insted vs. instead)

Changes in v5:

- actually collected Rob's acked-by tag
- added Stephen's Acked-by tag
- fixed the stray references spotted by Vladimir

Changes in v4:

- added clarification that we used "master" and "slave" terms for a
  while
- fixed include guard names in user.h
- fixed some improper subtitutions
- renamed STATE_CHANGE notifier
- added Rob's ack on the DT patches from the first review

Changes in v3:
- properly align arguments with the changed function names
- ensure markup delimiters lengths are corrected to the name word length
- maintain the existing wording about LAG devices

Changes in v2:

- addressed kbuild test robots reports
- preserve capitalization where relevant
- fixed build error in mtk_ppe_offload.c

Florian Fainelli (2):
  net: dsa: Use conduit and user terms
  net: dsa: Rename IFLA_DSA_MASTER to IFLA_DSA_CONDUIT

 .../bindings/net/dsa/mediatek,mt7530.yaml     |    2 +-
 Documentation/networking/dsa/b53.rst          |   14 +-
 Documentation/networking/dsa/bcm_sf2.rst      |    2 +-
 .../networking/dsa/configuration.rst          |  102 +-
 Documentation/networking/dsa/dsa.rst          |  162 +-
 Documentation/networking/dsa/lan9303.rst      |    2 +-
 Documentation/networking/dsa/sja1105.rst      |    6 +-
 .../dts/marvell/armada-3720-espressobin.dtsi  |    2 +-
 drivers/net/dsa/b53/b53_common.c              |    4 +-
 drivers/net/dsa/b53/b53_mdio.c                |    2 +-
 drivers/net/dsa/bcm_sf2.c                     |   36 +-
 drivers/net/dsa/bcm_sf2.h                     |    2 +-
 drivers/net/dsa/bcm_sf2_cfp.c                 |    4 +-
 drivers/net/dsa/lan9303-core.c                |    4 +-
 drivers/net/dsa/lantiq_gswip.c                |   34 +-
 drivers/net/dsa/microchip/ksz9477.c           |    6 +-
 drivers/net/dsa/microchip/ksz_common.c        |   20 +-
 drivers/net/dsa/microchip/ksz_ptp.c           |    2 +-
 drivers/net/dsa/mt7530.c                      |   18 +-
 drivers/net/dsa/mv88e6xxx/chip.c              |    4 +-
 drivers/net/dsa/ocelot/felix.c                |   68 +-
 drivers/net/dsa/ocelot/felix.h                |    6 +-
 drivers/net/dsa/qca/qca8k-8xxx.c              |   50 +-
 drivers/net/dsa/qca/qca8k-common.c            |    4 +-
 drivers/net/dsa/qca/qca8k-leds.c              |    6 +-
 drivers/net/dsa/qca/qca8k.h                   |    2 +-
 drivers/net/dsa/realtek/realtek-smi.c         |   28 +-
 drivers/net/dsa/realtek/realtek.h             |    2 +-
 drivers/net/dsa/realtek/rtl8365mb.c           |    2 +-
 drivers/net/dsa/sja1105/sja1105_main.c        |    4 +-
 drivers/net/dsa/xrs700x/xrs700x.c             |   12 +-
 drivers/net/ethernet/broadcom/bcmsysport.c    |    2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |    2 +-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |    2 +-
 include/linux/dsa/sja1105.h                   |    2 +-
 include/net/dsa.h                             |   56 +-
 include/net/dsa_stubs.h                       |   22 +-
 include/uapi/linux/if_link.h                  |    4 +-
 net/core/dev_ioctl.c                          |    2 +-
 net/dsa/Makefile                              |    6 +-
 net/dsa/{master.c => conduit.c}               |  118 +-
 net/dsa/conduit.h                             |   22 +
 net/dsa/dsa.c                                 |  224 +--
 net/dsa/dsa.h                                 |   12 +-
 net/dsa/master.h                              |   22 -
 net/dsa/netlink.c                             |   22 +-
 net/dsa/port.c                                |  124 +-
 net/dsa/port.h                                |    4 +-
 net/dsa/slave.h                               |   69 -
 net/dsa/switch.c                              |   20 +-
 net/dsa/switch.h                              |    8 +-
 net/dsa/tag.c                                 |   10 +-
 net/dsa/tag.h                                 |   26 +-
 net/dsa/tag_8021q.c                           |   22 +-
 net/dsa/tag_8021q.h                           |    2 +-
 net/dsa/tag_ar9331.c                          |    4 +-
 net/dsa/tag_brcm.c                            |   14 +-
 net/dsa/tag_dsa.c                             |    6 +-
 net/dsa/tag_gswip.c                           |    4 +-
 net/dsa/tag_hellcreek.c                       |    4 +-
 net/dsa/tag_ksz.c                             |   12 +-
 net/dsa/tag_lan9303.c                         |    4 +-
 net/dsa/tag_mtk.c                             |    4 +-
 net/dsa/tag_none.c                            |    6 +-
 net/dsa/tag_ocelot.c                          |   22 +-
 net/dsa/tag_ocelot_8021q.c                    |   12 +-
 net/dsa/tag_qca.c                             |    6 +-
 net/dsa/tag_rtl4_a.c                          |    6 +-
 net/dsa/tag_rtl8_4.c                          |    6 +-
 net/dsa/tag_rzn1_a5psw.c                      |    4 +-
 net/dsa/tag_sja1105.c                         |   30 +-
 net/dsa/tag_trailer.c                         |    4 +-
 net/dsa/tag_xrs700x.c                         |    4 +-
 net/dsa/{slave.c => user.c}                   | 1464 ++++++++---------
 net/dsa/user.h                                |   69 +
 75 files changed, 1553 insertions(+), 1547 deletions(-)
 rename net/dsa/{master.c => conduit.c} (76%)
 create mode 100644 net/dsa/conduit.h
 delete mode 100644 net/dsa/master.h
 delete mode 100644 net/dsa/slave.h
 rename net/dsa/{slave.c => user.c} (62%)
 create mode 100644 net/dsa/user.h

-- 
2.34.1


--0000000000000195ab060801630b
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
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMF3Td5x1O4j+IJ6
jEqwYgSDuxD/YQYFBTu9ZdKak9oMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAxODE3NTgyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQD5KCDnzHwOn+YeVLfYt0CIxhRAN5rWX3PH
UXbwd8vdtdZvwOkwrhManB+jcSQ4ULnQrOMj1X1P1HhsERkXn9MqaC1b/Yggn1eb5pBB96wNETBI
fhFuXdy0XhOomdkV6aA2+nAUAO1PU3iCaVcT4WhKOBivQi9byP4P5Q4vTxl8BgSzjNuOPMuqSfyN
T+/cD58qwirWsIPUIIvMHOecRiN8VI0Xjn3BiPa0+J3ISrlWQwSruy4D+q1p/tWN7PiL5zx08Mu5
/gQZpvCzfHcAxVh2AWBRGkgWI1LKGhPUrihIIkAzoJ5K8Ejmh6PNtrCYcDg3QRZjsSo3hU/ExBh8
rS/V
--0000000000000195ab060801630b--

