Return-Path: <netdev+bounces-97257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859438CA544
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 01:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CEF1C214A7
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 23:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D035139569;
	Mon, 20 May 2024 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gkMkTpuo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5328E7
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716249551; cv=none; b=Vrl/HdnfUQb7i3WCaSe64Z4W248cb3X4/t/fqVjAKhu9EGPt0q7v0QdkcawcMz/5kh3Ww953HF3qss7UAF8FOfJU5PsDvDapcdmgHV9ZrnppHy8mR7tmDy1aMUpwdfVlgxbnt1HkEkQTbgTpQwdjBE/eg4z1uZrc2pSg0onam3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716249551; c=relaxed/simple;
	bh=xiGzFz5+hu1xpjpEUf4HSER5PouTUhVlGDQbTva3RGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjXHoNsqQhXCkfpu7CAybf6HwXiDU4X5cpRmytYFdR1mke86qf8DdTc0jhej/N+5q8uJHRSfFZduv5d8CRWYn1v31zIr75bTvlTxOY2zADOrGDDaWfp3Ib4TBdP2N559LLGB1Xw+GCMXpngGnpE127z+Uhhdw39TM6fRm5BCzTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gkMkTpuo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec486198b6so84840975ad.1
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 16:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1716249548; x=1716854348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MSMZDcDirakrNTBU0fNIxBAtvPtCqIO/PWdx7abHpI=;
        b=gkMkTpuodemqcggQX+QS8j0l5j69KRlVLl/ZYmtwb+jylUbVhpJAYPDwzBAiMbv0kK
         M1mBQHqmg5/XNBvKwFVPPwvw2omyLT0NWme67XFACTm1V7P9WWOJJ4bim4M4I4APfk7m
         25q97hqUuUqKSWtajbFFdBUFkM56qr7ObCE6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716249548; x=1716854348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MSMZDcDirakrNTBU0fNIxBAtvPtCqIO/PWdx7abHpI=;
        b=SF5YyHqBkmTXZwvf0fm3HHvrSUCJHachEjJqt/AbJfwZeW3s8GX07jncyGaw2c9t5p
         hIknXZ9oSCGAdxjSVl7+IC8s/F+x2lHTrR7PPTWSvFIDO7PqYYaMan2Rh3z4gKMVVKA1
         vIDkbDn+51alxjJ6PeJOjN2MsnhFLWF0lZTCwhgHaxJqlj1g30YhhlMOVXSpFcYqPlyq
         zLtX3D39TTZVDA3oxRJ7vrI4GDkdnOMC3MsQjBBYxIK3tRieuP4xx2DPf8c2PuliNTnE
         QQRXxV/hDAMtusz/GRfW0XsXjBg3gO26x5/Hzd8kakWC1t+AeAmQOyAUT2+pGS81NEI/
         Z1oA==
X-Forwarded-Encrypted: i=1; AJvYcCXm5JTeB/qTPHsOOwklEDKUBa7gK5ho/K5mXF29pvCkBdl90BrmUmrvhmKnR16RuN5BK66h2kHJ8VEeTaoYSACLv+ky6QmZ
X-Gm-Message-State: AOJu0YxzcAV7U85HWfXNAZ7GYS3gg9+fPFlg7VhYbUaec47sN2wgbjp2
	clTjsb/vyp9ZFhZtUfO2Yulfmz+oDzxOGjc3dfYMxjLmkqqpX+EnpoYeXZVv9wQ=
X-Google-Smtp-Source: AGHT+IEU8qMZMI8smQVTlaGJaOblB8+OFUaGoNtT7FdaCarnHSQtmXoufAf+oYRHDz0WoQmCt8OpTA==
X-Received: by 2002:a05:6a20:96d2:b0:1af:d07a:37c8 with SMTP id adf61e73a8af0-1afde128be9mr28414750637.37.1716249547566;
        Mon, 20 May 2024 16:59:07 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f66e4a24f4sm11111009b3a.0.2024.05.20.16.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 16:59:07 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH net] testing: net-drv: use stats64 for testing
Date: Mon, 20 May 2024 23:58:43 +0000
Message-Id: <20240520235850.190041-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing a network device that has large numbers of bytes/packets may
overflow. Using stats64 when comparing fixes this problem.

I tripped on this while iterating on a qstats patch for mlx5. See below
for confirmation without my added code that this is a bug.

Before this patch (with added debugging output):

$ NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
KTAP version 1
1..4
ok 1 stats.check_pause
ok 2 stats.check_fec
rstat: 481708634 qstat: 666201639514 key: tx-bytes
not ok 3 stats.pkt_byte_sum
ok 4 stats.qstat_by_ifindex

Note the huge delta above ^^^ in the rtnl vs qstats.

After this patch:

$ NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
KTAP version 1
1..4
ok 1 stats.check_pause
ok 2 stats.check_fec
ok 3 stats.pkt_byte_sum
ok 4 stats.qstat_by_ifindex

It looks like rtnl_fill_stats in net/core/rtnetlink.c will attempt to
copy the 64bit stats into a 32bit structure which is probably why this
behavior is occurring.

To show this is happening, you can get the underlying stats that the
stats.py test uses like this:

$ ./cli.py --spec ../../../Documentation/netlink/specs/rt_link.yaml \
           --do getlink --json '{"ifi-index": 7}'

And examine the output (heavily snipped to show relevant fields):

 'stats': {
           'multicast': 3739197,
           'rx-bytes': 1201525399,
           'rx-packets': 56807158,
           'tx-bytes': 492404458,
           'tx-packets': 1200285371,

 'stats64': {
             'multicast': 3739197,
             'rx-bytes': 35561263767,
             'rx-packets': 56807158,
             'tx-bytes': 666212335338,
             'tx-packets': 1200285371,

The stats.py test prior to this patch was using the 'stats' structure
above, which matches the failure output on my system.

Comparing side by side, rx-bytes and tx-bytes, and getting ethtool -S
output:

rx-bytes stats:    1201525399
rx-bytes stats64: 35561263767
rx-bytes ethtool: 36203402638

tx-bytes stats:      492404458
tx-bytes stats64: 666212335338
tx-bytes ethtool: 666215360113

Note that the above was taken from a system with an mlx5 NIC, which only
exposes ndo_get_stats64.

Based on the ethtool output and qstat output, it appears that stats.py
should be updated to use the 'stats64' structure for accurate
comparisons when packet/byte counters get very large.

To confirm that this was not related to the qstats code I was iterating
on, I booted a kernel without my driver changes and re-ran the test
which shows the qstats are skipped (as they don't exist for mlx5):

NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
KTAP version 1
1..4
ok 1 stats.check_pause
ok 2 stats.check_fec
ok 3 stats.pkt_byte_sum # SKIP qstats not supported by the device
ok 4 stats.qstat_by_ifindex # SKIP No ifindex supports qstats

But, fetching the stats using the CLI

$ ./cli.py --spec ../../../Documentation/netlink/specs/rt_link.yaml \
           --do getlink --json '{"ifi-index": 7}'

Shows the same issue (heavily snipped for relevant fields only):

 'stats': {
           'multicast': 105489,
           'rx-bytes': 530879526,
           'rx-packets': 751415,
           'tx-bytes': 2510191396,
           'tx-packets': 27700323,
 'stats64': {
             'multicast': 105489,
             'rx-bytes': 530879526,
             'rx-packets': 751415,
             'tx-bytes': 15395093284,
             'tx-packets': 27700323,

Comparing side by side with ethtool -S on the unmodified mlx5 driver:

tx-bytes stats:    2510191396
tx-bytes stats64: 15395093284
tx-bytes ethtool: 17718435810

Fixes: f0e6c86e4bab ("testing: net-drv: add a driver test for stats reporting")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/drivers/net/stats.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 7a7b16b180e2..820b8e0a22c6 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -69,7 +69,7 @@ def pkt_byte_sum(cfg) -> None:
         return 0
 
     for _ in range(10):
-        rtstat = rtnl.getlink({"ifi-index": cfg.ifindex})['stats']
+        rtstat = rtnl.getlink({"ifi-index": cfg.ifindex})['stats64']
         if stat_cmp(rtstat, qstat) < 0:
             raise Exception("RTNL stats are lower, fetched later")
         qstat = get_qstat(cfg)
-- 
2.25.1


