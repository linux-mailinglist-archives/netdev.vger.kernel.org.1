Return-Path: <netdev+bounces-54003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AA680596D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEEA1F2181F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E087268EA7;
	Tue,  5 Dec 2023 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="DjEdXfg+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F8AC0
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:04:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso3554000e87.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701792268; x=1702397068; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hefuVLI8dQRhxU+WHeoQIQVTulctItLqeJf3NGa2D5E=;
        b=DjEdXfg+5gGbjwDFPvW4NoWTXWyqHHsc+HMUxXxa2I6d3e5j33WmCUbd8njHeQhVYF
         xWqgqRZfzDUpIUQSoA5fKmbGTzi3YXApmmNNFzAWI8lKuvqQdWGI9ZStQE1WuPAzOiTr
         kPZZ4/RaqLf/bpn+jiXRspDy0OUi1QDbadvCsi1/hdTg/a/lUNkySV5LzEpD+qFivVFX
         /XJMp2bP7H9x/yjnV2SyhCNKaiu5CADC8vDlNzsdmCpEWnW1hrYPT2iNdT7BKy3ml4nQ
         CISnEXa5W3r8/SRMbju/feoa/nxNInT/mj16mEXiMuyd9SyhkaYT/9pV0+5XunEcEaUO
         rnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792268; x=1702397068;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hefuVLI8dQRhxU+WHeoQIQVTulctItLqeJf3NGa2D5E=;
        b=Ksr8kq7uw8KQrUeY3BynzbfGLfXXeaauCfpiZTsDwrYbuNRNhqQcaZaL5EleqoT94f
         ebcvzaRwfV1Na9/D6FNtDo+7P11k7Xw+55zXdDG7uTdYDCX0uZCb6mUXM/cDkdzK6//F
         j27JRAXMV7ESuibsdMVD28mC3MxNUIDLQR/nDHXRtjrEHINCWpU+p/Hap7duCjAwe8Od
         Dl3rRyQ6sJW8a+5wht35Lwfr2aMJeRruhR2aqhPrLiyyFfGS2QMDmxCFeCIacXfwbhwt
         FyFqChapHhZmQm9z7KDJ+HN+exs57no6q2QQv6LSONmufqZcFq6mS3MvMnu/M034KBha
         Y8YA==
X-Gm-Message-State: AOJu0YyZiYDsbJ5yO1XcLUs2jd+8lyqM3/pYSbxAGep+LrbhMbBC6buv
	DLPM9ymshvljy9zfNSfnOyrSaw==
X-Google-Smtp-Source: AGHT+IH7rTBHM5u+Fv4fzHZOdGUY3Z1ncNDxD2LZ96x3Mj8kpv9VudAbxZAhdqwjb8PIIUzybxr0hQ==
X-Received: by 2002:a05:6512:1301:b0:50c:d79:b229 with SMTP id x1-20020a056512130100b0050c0d79b229mr685880lfu.23.1701792268493;
        Tue, 05 Dec 2023 08:04:28 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h25-20020a056512055900b0050c0bbbe3d2sm171341lfl.256.2023.12.05.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:04:27 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 0/6] net: dsa: mv88e6xxx: Add "eth-mac" and "rmon" counter group support
Date: Tue,  5 Dec 2023 17:04:12 +0100
Message-Id: <20231205160418.3770042-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

The majority of the changes (2/6) are about refactoring the existing
ethtool statistics support to make it possible to read individual
counters, rather than the whole set.

4/6 tries to collect all information about a stat in a single place
using a mapper macro, which is then used to generate the original list
of stats, along with a matching enum. checkpatch is less than amused
with this construct, but prior art exists (__BPF_FUNC_MAPPER in
include/uapi/linux/bpf.h, for example).

With that in place, adding the actual counter groups is pretty
straight forward (5-6/6).

v1 -> v2:
- Added 1/6
- Added 3/6
- Changed prototype of stats operation to reflect the fact that the
  number of read stats are returned, no errors
- Moved comma into MV88E6XXX_HW_STAT_MAPPER definition
- Avoid the construction of mapping table iteration which relied on
  struct layouts outside of mv88e6xxx's control

Tobias Waldekranz (6):
  net: dsa: mv88e6xxx: Push locking into stats snapshotting
  net: dsa: mv88e6xxx: Create API to read a single stat counter
  net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path
  net: dsa: mv88e6xxx: Give each hw stat an ID
  net: dsa: mv88e6xxx: Add "eth-mac" counter group support
  net: dsa: mv88e6xxx: Add "rmon" counter group support

 drivers/net/dsa/mv88e6xxx/chip.c   | 390 +++++++++++++++++++----------
 drivers/net/dsa/mv88e6xxx/chip.h   |  31 +--
 drivers/net/dsa/mv88e6xxx/serdes.c |  10 +-
 drivers/net/dsa/mv88e6xxx/serdes.h |   8 +-
 4 files changed, 278 insertions(+), 161 deletions(-)

-- 
2.34.1


