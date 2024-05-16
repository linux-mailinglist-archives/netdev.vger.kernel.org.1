Return-Path: <netdev+bounces-96681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A94D8C71FF
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164DB1F21074
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AD9134CE3;
	Thu, 16 May 2024 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scaleway.com header.i=@scaleway.com header.b="JJzHXs7+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A313174F
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844232; cv=none; b=tv102zWekNpuOrq1XxfaYH9NyEJoSS/qt6VKVvajsixNWlpNmDSq2l2RohQkvyXCtERNfrsl+23n5PiDd2YV1w7D+r+DuM/ve1TVQ4lkd8qjXNAFPiEtXksG3MXP0eGx2Jog/k7OaSgjbQeCcQwSZRHkeMjKYE7xA16aW1dg7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844232; c=relaxed/simple;
	bh=BM28czHJkrxIOn/sbZz4geF2C2RwLLHZzoDcy2dKKIk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ptnts1KFzZhJw60NoaPqdNSi/FJalSU1hUpp08lGMeqkJJymwHKGihn33DHC1DmDjUkD16USHtSR2yJle/kobSf150B3jroCM/PvxtGH4sa/LpNIETzWUYH/E0Fwtci2Mke2OqManMmXthKLgsNUKZVwDZr8GNkHWrL3WgYIQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scaleway.com; spf=pass smtp.mailfrom=scaleway.com; dkim=pass (2048-bit key) header.d=scaleway.com header.i=@scaleway.com header.b=JJzHXs7+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scaleway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scaleway.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34dc8d3fbf1so6342569f8f.1
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scaleway.com; s=google; t=1715844196; x=1716448996; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XL0FTfvENfwWrCYwB+MmbP6gqgnUiHTPhyDgj2XRp7o=;
        b=JJzHXs7+H0THnZJeCIljmQ0yzdqMNHNYTRl6CauRI7TsKw+IYnjG/TorUOShUgjGIn
         LbONcnl2U3wS8Kd/UmBOeZjVvzUZvnyoO6EnSS8J5FHa5m5t3F7x/JTDQvMbEdlGvZmY
         K4QtEeRd5hq2UDj8JsXgz94eYsFLhEb6dyRIQVzfoJNxD33i2SxT/rPb/ApqKhD2LkUV
         0ZdBPINzy1XjSGK1qqm/8QNXvDErHkUZtX0XD2UjGbbWrGLjirD1DNG6bTqvRSBG9SXQ
         K8kjhNDYob4KaVmrsma4pvlikFfrCApWTukqx+bSB+PKa3HNDxx3D0QZxphD8SL9TLP7
         mzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715844196; x=1716448996;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XL0FTfvENfwWrCYwB+MmbP6gqgnUiHTPhyDgj2XRp7o=;
        b=bzGPbWWKU4fcpIIVVlcKJ2s4kXQl2j2qKqAv3gUukfKPhQNFTBOcj1Qm6ItCIXwQbd
         f6PGYpdFsddJ0ZhjO8ZKUJpx3DYte6EkUayc3f9JvEwyTGO07/ynrEPvQTYXW0WCyt1N
         oaDwB+SBCY0rNQnpk5uPDbJIKBfpHQLRtFdbo7bNzKFaPYswzI7djMRG+23GyJmDn7oJ
         AACPklrUx1VBAe8ZQ5mYsDkKNBNoR8C+o4hyFUO8dSGaloL6ed4+pNFTE2wSiKcMa/D0
         jXixc8nvXSqU4aJVaJW9NVVhw4MAbSfzIVfTJEPP7daQhcCWs7oh6aL4QKrG/H8fXxHp
         3UQw==
X-Forwarded-Encrypted: i=1; AJvYcCVUg/Oi1WZXB2+ViQAsFjpRit9mPZZCc9X3NclTncav/AHUoteRWCwgKVWhP/VBwBZGkcaBBzu+8TMJ4vl+JNK/hTPpGzdC
X-Gm-Message-State: AOJu0YzbSge4Y3P3UyAHe57ieQ8aICad/y7KP8gmqeRrBrbxSU1d9NbK
	FvkdTD3gwS6y/awimDOS3/vgEDWU3nMuLneLvotZYZgVaEXLAtmQcpnmXhw3S2OW8zohcKwj5QL
	QZStYEimF9QazrORpY1iszoJJbi6eRxHIlHuo0TCbqEW84ztMSkc=
X-Google-Smtp-Source: AGHT+IEbBukBnzsyHqEO/oQoeZxlHx6cB8ynz0XKJg9oOYoFGq7/Dm/8ZydoKwUYG/jcVm7jAo7DM9I44o/Pg5RNylA=
X-Received: by 2002:a5d:61cd:0:b0:34d:b47c:7e6f with SMTP id
 ffacd0b85a97d-3504a6334c4mr11338959f8f.27.1715844196381; Thu, 16 May 2024
 00:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Frederic TOULBOT <ftoulbot@scaleway.com>
Date: Thu, 16 May 2024 09:23:05 +0200
Message-ID: <CAAV7vNcRbVb00vp_u1q0f6jjqwVhx4GFAzWoP0AsRA1MhAfeBw@mail.gmail.com>
Subject: ethtool module info only reports hex info
To: mkubecek@suse.cz, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I have the impression that there is an unwanted change in the
output of the ethtool -m command with a certain QSFP type

I tested versions 6.5-1 / 5.16-1 / 5.4-1

The bug seems very close to this one
https://lists.openwall.net/netdev/2023/11/23/118

lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description: Ubuntu 22.04.4 LTS
Release: 22.04
Codename: jammy

With ethtool 6.5-1 and 5.16-1
~# ethtool -m ens1f1
Offset Values
------ ------
0x0000: 11 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0010: 00 00 00 00 00 00 1d 0e 00 00 81 85 00 00 00 00
0x0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

And with version 5.4.1, we receive the expected result


lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description: Ubuntu 20.04 LTS
Release: 20.04
Codename: focal

dpkg -l ethtool
ii  ethtool        1:5.4-1      amd64        display or change
Ethernet device settings
~# ethtool -m ens1f0
Identifier                                : 0x11 (QSFP28)
Extended identifier                       : 0x10
Extended identifier description           : 1.5W max. Power consumption
Extended identifier description           : No CDR in TX, No CDR in RX
Extended identifier description           : High Power Class (> 3.5 W)
not enabled
Connector                                 : 0x23 (No separable connector)
Transceiver codes                         : 0x80 0x00 0x00 0x00 0x00
0x00 0x00 0x00
Transceiver type                          : 100G Ethernet: 100G
Base-CR4 or 25G Base-CR CA-L
Encoding                                  : 0x05 (64B/66B)
BR, Nominal                               : 25500Mbps
Rate identifier                           : 0x00
Length (SMF,km)                           : 0km
Length (OM3 50um)                         : 0m
Length (OM2 50um)                         : 0m
Length (OM1 62.5um)                       : 0m
Length (Copper or Active cable)           : 2m
Transmitter technology                    : 0xa0 (Copper cable unequalized)
Attenuation at 2.5GHz                     : 7db
Attenuation at 5.0GHz                     : 10db
Attenuation at 7.0GHz                     : 13db
Attenuation at 12.9GHz                    : 18db
Vendor name                               : CISCO-PUREOPTICS
Vendor OUI                                : 00:00:00
Vendor PN                                 : QSFP-4SFP25G-CU2
Vendor rev                                : 6
Vendor SN                                 : M9BE9185
Date code                                 : 220412
Revision Compliance                       : SFF-8636 Rev 2.5/2.6/2.7
Module temperature                        : 29.05 degrees C / 84.30 degrees F
Module voltage                            : 3.3157 V
Alarm/warning flags implemented           : Yes
Laser tx ...

