Return-Path: <netdev+bounces-67833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C2D845161
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D8A28EFD9
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 06:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A6286AC3;
	Thu,  1 Feb 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3zDs329"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443D7D408
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769011; cv=none; b=QPutUEDfSCuUMiVPX3ih2qC0O7SqDE5wktzB59Z9uwBIoRypSRM6eNG4hAFVniQbor3qP918GPvbodJT2DFo4d0mslx1L2VcVydKmXsH/5/yvs3WfZM08RU3Cf0r1cSqHwg+7fodlmxEnUc/a+nO7ECkynQ4VfxJL70gwUkD/eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769011; c=relaxed/simple;
	bh=gJQE8wRVd0GajJkI88jFA5ZoJgVe1m9Id162/M4AmuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ku4lMHbvEeIJ6xpEML8TIv28rD+86/KGKiKY6PCk7mZMpmjEWkXAhSW+7GVgfrsdhZgr47leUoJbreZf/pFzGa3c3GCgGb90ZYRL1a/lAENq2FpP52UFC5OxC+1QhgilYJFRNPBg6b535POirkI6lwpdoJ134+tOkmfpXxhwoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3zDs329; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-295ff33ae32so417657a91.2
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 22:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706769008; x=1707373808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK5lXYghVCWitYGnZ7kIQtJ1HeoGTh9XeToUTcvTOG4=;
        b=Y3zDs329sWItLRQyDePWLcYcNmQNN7KcbaIgt2DSUMddcG44MwnU+HWBok+0C4QuP6
         ajPESldYXvwZf5tQM3lpyLQF9F1P6AHBi4D4OV6P5lHErLZ7HXKhwa/oUvhVYDe7Ug9q
         05mxusLawdLPKxfiksn5E7+PiWUsQMOPupesfvz3SRtEHcaq3jxM6+qsSVQoZDAGvXro
         F+rAPElvidcJQFLbnX7BB6bODPl6CCw86rt3rOEGT90ZtABqcJo/bivP9I6PgxlUlS9C
         TxNrgDtJIP6MYdue1DFLXnnCnpqsHp2wCBbq6hH5464xufNLgJQHjGUEoXT2oeLe1xda
         35rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706769008; x=1707373808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK5lXYghVCWitYGnZ7kIQtJ1HeoGTh9XeToUTcvTOG4=;
        b=CMQBjDfxg4+6TDtu7C9k1QNI/GsPhRmeERI7KYjZJuve2Cg4pV6dlAy4jS2DqL0K05
         SHkjXYVugovLPfzyiRhxiAMiOKXuM2bBsAjWBLjL/vcgC+22D30sg6LNgaD64zEdKPZS
         2503Jm/hlp9WZ+UYqEeGfTn5uQBTQbSAuMBdbg2WmFawVHMzeiZaVRV4p6jIEQdDB/tz
         ogrAbcUaNpm0JlGoUS6RCSqIhzXP1wNhwV1p4Yi+momaauUbr9OKMhR9SK1fDdOI73HF
         uR4Brp9IfzKeTKcc9wMzwtRsCyU6s5IwV2NDCccvqhqVoib5tmmjce8B84Swhxx7O+JZ
         puvg==
X-Gm-Message-State: AOJu0Yxx7LO3p5QrCiPtViKgsHl2DbSUv+Zz60v5hDPpMSoAph3rmy5a
	gdko9Kgw+m9VJGQHpQMe1x8kjMpePHlvL0VzWL7ZJT+/V/8/CrX46XwHgb/T1nps0Snx
X-Google-Smtp-Source: AGHT+IHjl1NObgoMWBTapQuAmzjvWyOGFZOis9i2PjdAgQbLdTLRh7KlI3xfTx3Dl02O7P5ptm376g==
X-Received: by 2002:a17:90a:fb8f:b0:295:b0cd:9be6 with SMTP id cp15-20020a17090afb8f00b00295b0cd9be6mr1148845pjb.30.1706769008546;
        Wed, 31 Jan 2024 22:30:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVMvdFe7EohbMAn54EXJdscrdDZ9m4GCU4sqMYZletBSefFuQiQstnObxpd8tg9iiJUgh5afLGUOLxYS4ADTtVRtSgOgSJN5q5UAbeIpZqFQB/WeRl+Uf8r/8TA/9HelbgyPuimqauNFj2XNw9SZMlP4Uo+L7pdbOBvE6zCO+nxRl8RlauLutPwXd8UVbIaplHxNBvYv4Y1QNP6ZwWrZM0MOv0KgEJK3W/S+hlCYs/IFlotNNM0AV5CEfKC4N7G9hb5aA==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id pm12-20020a17090b3c4c00b0029618dbe87dsm515895pjb.3.2024.01.31.22.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:30:08 -0800 (PST)
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
Subject: [PATCHv2 net-next 2/4] selftests: bonding: use tc filter to check if LACP was sent
Date: Thu,  1 Feb 2024 14:29:52 +0800
Message-ID: <20240201062954.421145-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201062954.421145-1-liuhangbin@gmail.com>
References: <20240201062954.421145-1-liuhangbin@gmail.com>
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
index 6358df5752f9..01dcf501da41 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
@@ -20,21 +20,21 @@
 #    +------+ +------+
 #
 # We use veths instead of physical interfaces
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+source "$lib_dir"/net_forwarding_lib.sh
 
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


