Return-Path: <netdev+bounces-57464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E60813225
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17671C21988
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7665F57882;
	Thu, 14 Dec 2023 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="wC+FpOpj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5E011B
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:48 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9e9c2989dso109769541fa.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702561847; x=1703166647; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YxrqJh4RI5o+SiUcRUsEa0bDuwUC9pIjnReRob7DVvo=;
        b=wC+FpOpjX1NpCstzOtPZELy2NpkPMqefRk+nyjuJgWbJ8n5QqlN+I4kSBgOqAriZNy
         hjCEfitV+Mx5qHUhGEvXTyTGkQIEYJ73sUHljPNv6CcszXNsOkJLA0doA3lmWlLj1nKq
         c1r3nlOQA+HmWWKnYE5wfyfW0IBD+FxwBz4KZ2lM5Rsvt6V6HmyIBFJNLtjAaaGORRuV
         6HOniBr6GD30joDjMSRrF5medNUTcYcq68nCUpLhyi9ySkshG0msDQChHLR/4ojN5lFn
         6mOtelI2aTZvXYSW3AjSWhcjCZ80pYowI62kYS7JyDmitisQ0akCpDnZ0MZYNADqPzp8
         zfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561847; x=1703166647;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxrqJh4RI5o+SiUcRUsEa0bDuwUC9pIjnReRob7DVvo=;
        b=V5DTJyXKUh8GQXccXMBNgiPQMYk9nP8n9Tg299tu8nJutplFVfPpqLIyXU2ljUEwzK
         4bxlZlc6dykllkCgavmLtzz3OWqQKlaWznju/BaAc6yhrq8z60lBj2TvvHliF4NqjH/B
         tff29veuWeYCPMVnapPMA3RWl9W3y1jeOIcW7TbUkZ/Wd3/LqJdbGlkjoYjbPPm7VoOD
         UhDC7IprMMGsdbF1fx5F9IAg7m6KGeeRtFreqLDAAWNGaeyCgoIFqhVyLXPBLoCV+Yd2
         ZZcFTqY9ihBzqjpff4UQZMkCI+031abRhqKtlFqRbb+wh9NEmohA71mgEWjkqNeSW3xR
         a7Uw==
X-Gm-Message-State: AOJu0Ywp1fWINj0+04FpeulAvJqVA8KvDsy2ZLdauRuUh5aerYwqpX9W
	XdmjjKWfqNQXSjFBRJ/pSGXmhw==
X-Google-Smtp-Source: AGHT+IFyOcQbkX3qvv+0VFOCiG4Uiyy/LPpzMm8qwgBrdvOWW8ImLVUFtyGf72DmvaRmjrmb0b0qlw==
X-Received: by 2002:a2e:81a:0:b0:2cc:3f53:eb85 with SMTP id 26-20020a2e081a000000b002cc3f53eb85mr913374lji.69.1702561846205;
        Thu, 14 Dec 2023 05:50:46 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a2ebc84000000b002cc258b5491sm1154010ljf.10.2023.12.14.05.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:45 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v4 net-next 0/8] net: dsa: mv88e6xxx: Add "eth-mac" and "rmon" counter group support
Date: Thu, 14 Dec 2023 14:50:21 +0100
Message-Id: <20231214135029.383595-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

The majority of the changes (2/8) are about refactoring the existing
ethtool statistics support to make it possible to read individual
counters, rather than the whole set.

4/8 tries to collect all information about a stat in a single place
using a mapper macro, which is then used to generate the original list
of stats, along with a matching enum. checkpatch is less than amused
with this construct, but prior art exists (__BPF_FUNC_MAPPER in
include/uapi/linux/bpf.h, for example).

To support the histogram counters from the "rmon" group, we have to
change mv88e6xxx's configuration of them. Instead of counting rx and
tx, we restrict them to rx-only. 6/8 has the details.

With that in place, adding the actual counter groups is pretty
straight forward (5,7/8).

Tie it all together with a selftest (8/8).

v3 -> v4:
- Return size_t from mv88e6xxx_stats_get_stats
- Spelling errors in commit message of 6/8
- Improve selftest:
  - Report progress per-bucket
  - Test both ports in the pair
  - Increase MTU, if required

v2 -> v3:
- Added 6/8
- Added 8/8

v1 -> v2:
- Added 1/6
- Added 3/6
- Changed prototype of stats operation to reflect the fact that the
  number of read stats are returned, no errors
- Moved comma into MV88E6XXX_HW_STAT_MAPPER definition
- Avoid the construction of mapping table iteration which relied on
  struct layouts outside of mv88e6xxx's control

Tobias Waldekranz (8):
  net: dsa: mv88e6xxx: Push locking into stats snapshotting
  net: dsa: mv88e6xxx: Create API to read a single stat counter
  net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path
  net: dsa: mv88e6xxx: Give each hw stat an ID
  net: dsa: mv88e6xxx: Add "eth-mac" counter group support
  net: dsa: mv88e6xxx: Limit histogram counters to ingress traffic
  net: dsa: mv88e6xxx: Add "rmon" counter group support
  selftests: forwarding: ethtool_rmon: Add histogram counter test

 drivers/net/dsa/mv88e6xxx/chip.c              | 392 ++++++++++++------
 drivers/net/dsa/mv88e6xxx/chip.h              |  31 +-
 drivers/net/dsa/mv88e6xxx/global1.c           |   7 +-
 drivers/net/dsa/mv88e6xxx/serdes.c            |  10 +-
 drivers/net/dsa/mv88e6xxx/serdes.h            |   8 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../selftests/net/forwarding/ethtool_rmon.sh  | 143 +++++++
 tools/testing/selftests/net/forwarding/lib.sh |   9 +
 8 files changed, 435 insertions(+), 166 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/ethtool_rmon.sh

-- 
2.34.1


