Return-Path: <netdev+bounces-68899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5697E848C46
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 09:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB40B22EE8
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3907E11CBC;
	Sun,  4 Feb 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8IVJIdT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751216423
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707036710; cv=none; b=uU+AlMyl6xTDERl3cvjI9MhPrGaHUeORrvpI9avYbgRvKt42bfnkYyTpjI4lMgvGcqoIgUXLpKNlH7XQRzwlT+ksWAhIuDNdVD4QjjilpBVjGBBJQTa5jzs3lmR8ypv2rQ6fb5z2ob1ctNceygfFAhFGMN4+uheHMUjneIzO2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707036710; c=relaxed/simple;
	bh=9sCZCUTM9/Bv/osCyDQdlDwrCLiHF/EY3ax+mpZSXpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ukbq2WlLupBLlTBbcSIZ8HZkE2fnCiuE/ny4hrvfUCCxO8mRzw43EG8ekGlq8Ulnd+MS69nrZaABXz6DYWe+3ciLT7Sf06oDHcOUyhDqRdlzETzz0P4QJ/v3WksPWpY4PdzN+ur6T5o8dAnTLtB36uVhrvx34TxYBf5KNW3s0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8IVJIdT; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3430102a12.1
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 00:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707036707; x=1707641507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0292U331PRMk/JKM5bmBjV7z2aP5Wa2jlTcLtcJEHno=;
        b=C8IVJIdTvuX32cbUguIj28jiK15Wqc+rPAqv7r8AvxpMhaPgN5db504yMe+/Wt9DUB
         lbLi+68/2lx0k1mex0RKr9NRVj7gfjjQVlxLHzyv2fXMTSsCCTyHRuV9BRakHVwIpqcv
         zJs/3zK3dyYIV4J5GY9acGtrLGJXmhUWUS6vNyZ/Vh6JDos/P2+Hll9+CXQNhaakFUcN
         Rzj1ve69J2ngmgAfzcrUexPO1sFPgEaipqJI6UEI948ae2FKf0l6y0HBH2BdRx0D3BWY
         /8Ds2WQFPWc6DjevG/OKkiMd9aWhVnBht9Gg+AZGv/0kFof6b+ZfEwSVV9I7m28eIhDL
         Dd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707036707; x=1707641507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0292U331PRMk/JKM5bmBjV7z2aP5Wa2jlTcLtcJEHno=;
        b=hSfIyKDWW9Jxm5B8THzem1eaUD1MwpDD1BdOu+xqh6RStL6AWu4imjdJKag3LxUK1y
         bNYIsDmqYAIe7hAYtSzqivRCGYFV2vpEjP+mOR2mzjuxu2npkvcjrubY0fiv1m7OElTo
         GUWBSKQzeS8NhLTFoyJaetDJwI6Mo2u0T52aChTp5kxjDniiS3wRTYS1zIDNO2nlleVU
         lrmVB83uoxyrG4QBzguZiPpm6xuXx/1DlBWbDxDE5sLCT+ksf0yizoCphVzrY7hRrlJD
         AHY1OyiOuT7GufAFB8J5yNSQE+6sbKsZkAKkwaub8DSh3BXBtus/aoO00E8rBoBj+aTO
         kUjg==
X-Gm-Message-State: AOJu0YyO21uAHs8jP6KdijyNANiwMn0vtoA05zABKkNM3UHgnugwy3p7
	JiXwQz6uMMFlKDqwWVnbrdszt8enbpYONNlpM+xg8w4l258C6+NkE8g9dRDafzLa7g==
X-Google-Smtp-Source: AGHT+IEbd9UCtz8uG6GISMpSjgofEG1rEr87ZMY7E0d5j2hbWN5TGyIRWK2/vVcJmNUlLSQvN/OKnQ==
X-Received: by 2002:a05:6a20:ba7:b0:19c:9abb:8a64 with SMTP id i39-20020a056a200ba700b0019c9abb8a64mr6276566pzh.24.1707036707307;
        Sun, 04 Feb 2024 00:51:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW6T9Ag2cwoFWdQfoC6G9f1alkmlyy4exsLzkly2uQrvr17xF1XIlMtcMnU7RNAJnx4vTWmkOvGfrwMVm8p9DDF1VDQTfbVye88FtLN2QV4LbQJ0KNuwgz2wWL1Nvo3HTubJ3DX66dESKcf1Mj8zE4NKf8C/+eneA8iX5uMwzIrW/wyfPm6hN6y4PH3ZjSFkXx1s/Hya7IGRPi8BOZfFxvXoV8JSGceFtL/Mp2Dew0dZL7Sz/6BW/nYPtGad0d+h5FGSQ==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ka39-20020a056a0093a700b006d9b2694b0csm4398228pfb.200.2024.02.04.00.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 00:51:46 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 2/4] selftests: bonding: use tc filter to check if LACP was sent
Date: Sun,  4 Feb 2024 16:51:26 +0800
Message-ID: <20240204085128.1512341-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204085128.1512341-1-liuhangbin@gmail.com>
References: <20240204085128.1512341-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use tc filter to check if LACP was sent, which is accurate and save
more time.

No need to remove bonding module as some test env may buildin bonding.
And the bond link has been deleted.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../net/bonding/bond-break-lacpdu-tx.sh       | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
index 6358df5752f9..1ec7f59db7f4 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
@@ -20,21 +20,21 @@
 #    +------+ +------+
 #
 # We use veths instead of physical interfaces
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 set -e
-tmp=$(mktemp -q dump.XXXXXX)
 cleanup() {
 	ip link del fab-br0 >/dev/null 2>&1 || :
 	ip link del fbond  >/dev/null 2>&1 || :
 	ip link del veth1-bond  >/dev/null 2>&1 || :
 	ip link del veth2-bond  >/dev/null 2>&1 || :
-	modprobe -r bonding  >/dev/null 2>&1 || :
-	rm -f -- ${tmp}
 }
 
 trap cleanup 0 1 2
 cleanup
-sleep 1
 
 # create the bridge
 ip link add fab-br0 address 52:54:00:3B:7C:A6 mtu 1500 type bridge \
@@ -67,13 +67,12 @@ ip link set fab-br0 up
 ip link set fbond up
 ip addr add dev fab-br0 10.0.0.3
 
-tcpdump -n -i veth1-end -e ether proto 0x8809 >${tmp} 2>&1 &
-sleep 15
-pkill tcpdump >/dev/null 2>&1
 rc=0
-num=$(grep "packets captured" ${tmp} | awk '{print $1}')
-if test "$num" -gt 0; then
-	echo "PASS, captured ${num}"
+tc qdisc add dev veth1-end clsact
+tc filter add dev veth1-end ingress protocol 0x8809 pref 1 handle 101 flower skip_hw action pass
+if slowwait_for_counter 15 2 \
+	tc_rule_handle_stats_get "dev veth1-end ingress" 101 ".packets" "" &> /dev/null; then
+	echo "PASS, captured 2"
 else
 	echo "FAIL"
 	rc=1
-- 
2.43.0


