Return-Path: <netdev+bounces-42064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 590FF7CD0D7
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837651C20955
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 23:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A32F528;
	Tue, 17 Oct 2023 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mrb70A3E"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2D243102
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 23:35:43 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34421B0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 16:35:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c77449a6daso50619725ad.0
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 16:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697585740; x=1698190540; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cImd/Fhd+FMZtj9e5YHZnBefeuxEYvHxrfJNren1yFI=;
        b=Mrb70A3E31nZprLeGlgmbmkNVZegdHb80v1KL1yCZUDlkXS+kkoY+3hwQdeRrS0dMd
         X9U36R7IYUsNqHjy0JW3G6iT+EFBpY0EoRO59g276ACVeneBqgXs4MPCH5NHUeuKHc4Y
         HYFVEF3uWtrHNsbVCSGRsTc4PBot7RoclUedQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697585740; x=1698190540;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cImd/Fhd+FMZtj9e5YHZnBefeuxEYvHxrfJNren1yFI=;
        b=Clk6rvO1sxzd6BjRf9cP6Pbsfg41yjKiOBf0YKyy+O3lsJEkPUHwRlLgZW0Dlp+x25
         599AdjycNrV7W3vpNzbpigFKwtKdwzLTACE3CpArg7+LzELFrgCBlwYxFkJouAa/K6nf
         jK7Djoc38FbtGCialc+DLCJto7kdZr6jOR+Qs/STEROvMiaADj06VRo7tJXTTob5ZDmR
         5+7m5vOeuDLIL3g9LLANRIBjsGpbJMfcHklQtOYF86SUvLImbxVTpXA1xNyKaTvTiR95
         WHfi8Nl/Dr6JytbMkiP3Xm4i6clBcKTpkV9g0ZNzeR5fJpQq3dOqQCwOFWqAXbAUlow7
         U9bA==
X-Gm-Message-State: AOJu0YycXDb4ot45CbSwnRb+tMmIzGCmKidvrB3IQ1C8s/KID7X/jm5H
	ntY5tWXYgqLfHyVAW0zZ7ohbJCRSXR5uMNzZXu1EnDCKb6ImWOgrGmWUVaf6pmk1sq6bE2KKRso
	l+CwaViOlIanKkJtnw7+oxCdq8cU6tvZODDlp2EYFXak33Dj/22TWHLuXIatprIAwc/chHWn69k
	y5Ziql+nV1rQ==
X-Google-Smtp-Source: AGHT+IHYryXJgjRJ+3/6ydhVGgy9ALMB50NDAKiFnnrB8yQlvbIkLrvFNz0VP4oDLpcsQ9KAf8huVw==
X-Received: by 2002:a17:903:1249:b0:1c4:3cd5:4298 with SMTP id u9-20020a170903124900b001c43cd54298mr4336604plh.18.1697585740182;
        Tue, 17 Oct 2023 16:35:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001bc18e579aesm2139458plq.101.2023.10.17.16.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 16:35:39 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/2] Switch DSA to inclusive terminology
Date: Tue, 17 Oct 2023 16:35:34 -0700
Message-Id: <20231017233536.426704-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000c5da20607f1fbdb"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000000c5da20607f1fbdb
Content-Transfer-Encoding: 8bit

One of the action items following Netconf'23 is to switch subsystems to
use inclusive terminology. DSA has been making extensive use of the
"master" and "slave" words which are now replaced by "conduit" and
"user" respectively.

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


--0000000000000c5da20607f1fbdb
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAUP7dK8MqedE8lw
pyFKPsijeXOpTVXNzeisCLnlHdHoMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAxNzIzMzU0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDx2Pt8X9l1DQBgD6ONxkHXaCx3EcQdUUSq
1ZqeVUFKY1Dkcg3AFJGjQxisfFCbKgwky9cNPNmYmJ4zT0nVocRLaCZnpy2fxQUHILniQrUo/o1G
5WIx+TYV5ZPPNU45T/y/NolN7Bk0bZgy68y5LpLWgARk3wGFx235W1m1Wuzw0JZs0kQxUgu5rcK0
Uc6nqvQyKpnP4iu52WLrmE3ZI+uLcEa7+zZ6n4PFmGPQ98tRfYq6kyEvXQ616GcBEEVFRu/VIV3h
sJbF59BoHd5UIYYD825nv+r34LzvkIZzI1I9JRCUUfgnhUuxTSjjxhDICqPTqJT/w+sNMMKW8k86
EPF5
--0000000000000c5da20607f1fbdb--

