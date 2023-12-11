Return-Path: <netdev+bounces-56111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D880DE4D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2317B20E2F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782764CDE8;
	Mon, 11 Dec 2023 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="rm7jpG91"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6538FAB
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:33:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50c04ebe1bbso4889401e87.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702334037; x=1702938837; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vsEahIyCcr1hQAj1BxTdO8xOApu24tvuDSgTDDOa92A=;
        b=rm7jpG91991mU9aTClSSRNkE83NeoyvH9fNnTLZGQ7HGxIrN5FmEhrKtcle6pIzTbV
         gA8oHrzVGwAer+s4we0keT81x3HoYvtvLj3C55hRDQFVufvvPRdStB8F0C1nN832D543
         IKujrj1UbZbP9TonbnU5DFmE5ha2oA5LMuts7XWQ1QPbAduxN591+2vkz31AkP6rQsQ+
         WgVIJdQ3Tk9zbRMwY3wM/NbDSE2tOIYqw//+An/E7gJf6eKimWxZcrLd0S83/SHYWCPT
         6uV3AzcXhtoMzyoNfPPtG0a5iIwWHvUIflxjYgqIQRyKC5bTeNmUknatKY6BbtsouHje
         aB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702334037; x=1702938837;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsEahIyCcr1hQAj1BxTdO8xOApu24tvuDSgTDDOa92A=;
        b=XJLwpDgLEP1VA3tZEpQA3wQSFlp6tSjU+Jt+G0km+qnBvYWM2H8Tyv+8IatlZunksT
         XrHRxFrtpkMGr21oi6bhf2WTV+Zvhtk6hNQWQTeDU3YcCrc0WtZEYS/R4M6tfIDVRmrY
         s+xsRbKC2/0QZjmyb/rxr1Ky4NKDV4jH4erPlvJAk+ijkZy46zQmRQ9bnA51sejeCeE4
         Ok+nimm1+8FTnYK7hgIox8toa0BR1C8lnxa8/wC7fMO47UkyTitpUuFuac9gVdRwihZp
         B96QJHpGENbfSNqdpmzGowJQ+s73SLKquMJKiIYnFevCa0/5U46it3t+v/Xmys34MOcD
         r0wQ==
X-Gm-Message-State: AOJu0YzHukKemFpZBYR5N+7Nr3Zl5HoEKp//FhvwOpOuOGcxsta18pSE
	Og299kaNbq+fKGoX8xtuhYXzvA==
X-Google-Smtp-Source: AGHT+IE2RjNMP/a/FdYvmDQPouGCrdsMEg39UteXIhH323rjEops8UOeejIZv1mnZZLbsIOpHwriWA==
X-Received: by 2002:a05:6512:3f08:b0:50b:e6e0:cae9 with SMTP id y8-20020a0565123f0800b0050be6e0cae9mr3244961lfa.26.1702334037423;
        Mon, 11 Dec 2023 14:33:57 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id f17-20020a05651232d100b0050bfc6dbb8asm1217649lfg.302.2023.12.11.14.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:33:56 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next 0/8] net: dsa: mv88e6xxx: Add "eth-mac" and "rmon" counter group support
Date: Mon, 11 Dec 2023 23:33:38 +0100
Message-Id: <20231211223346.2497157-1-tobias@waldekranz.com>
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

 drivers/net/dsa/mv88e6xxx/chip.c              | 390 ++++++++++++------
 drivers/net/dsa/mv88e6xxx/chip.h              |  31 +-
 drivers/net/dsa/mv88e6xxx/global1.c           |   7 +-
 drivers/net/dsa/mv88e6xxx/serdes.c            |  10 +-
 drivers/net/dsa/mv88e6xxx/serdes.h            |   8 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../selftests/net/forwarding/ethtool_rmon.sh  | 106 +++++
 tools/testing/selftests/net/forwarding/lib.sh |   9 +
 8 files changed, 397 insertions(+), 165 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/ethtool_rmon.sh

-- 
2.34.1


