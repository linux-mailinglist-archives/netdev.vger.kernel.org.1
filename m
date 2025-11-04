Return-Path: <netdev+bounces-235458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF83C30DEA
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C250425496
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8A62ECD3F;
	Tue,  4 Nov 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Uqdac/00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650C2EC56F
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257805; cv=none; b=HeuHLOtjPxB9B6p5lFZ/U97NbhZc7q4Z1fgpv9b1if/tWsApedj1UqXQWujsN+narGwBkn6CRa9hM2vVWzRcY9BHysPrv/BBUmjeCFUW8Dx8y4nxsynznUBj0+HDNXp8o+puwPSLGCTGYv8r479qyedkvT9bSXshFK0oMKUY6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257805; c=relaxed/simple;
	bh=WqQ5LOsWzxd4q/cXJqOV2o+0+/GhIJo/SZMXegXdxEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTIQ+uP2dhq6R+Fz9LJU0Ilxx4sSmZ9ndWb98RVPmsUeONt5RKccJ6ZIFqkEwOOSo5kH0VyTNIAVLUdHaUkPBBCKvJo5Y5S4g0wQyND0qxaWwxHEYAzLqUR006tSvgCGyDi/Inn0/+v4PaVb732KyKikgxmwFz5C5OvglZb/63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Uqdac/00; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3b27b50090so841870166b.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 04:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762257802; x=1762862602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvbqWBgLxJDAhey/iacVcsdDYJtkr5fIj/Bp321hkOg=;
        b=Uqdac/00tlJHKEnit5Npz42uX9A1x1i/AWq1tWm9u4LOvNmN3GkDhwGbKrh9OVcCv6
         xNANwPEMRsSg6K3vrCnz3NfmWcuEJ0MQsOQm14z/TdRdsI5zcKstFw8xB92IjcCJXlj2
         9atZFGe4LDsQJ+r5OBCDfB6KecLAj0NwGgSj8WDHWBlAnFISX3vCM/9Xj/JC27TSdsat
         LWPt8EMYNg7OsEPRwWuFNgrFGMC+NdvdWylE94MPK8pfMexls0TQKQ/38AX9Fu26077u
         HG+qWsJ7SQKTFtCMnDNfxpP+93OqYRXLjbMKj+ueknaAuKZ8jwHBDYItQSli5A0LwN5p
         zWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257802; x=1762862602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvbqWBgLxJDAhey/iacVcsdDYJtkr5fIj/Bp321hkOg=;
        b=me5AlWKZuHrQiyAd84P6Jo24ipkmN3xAcKFqBmXIqBhPergWUQEVR6jrl5QfA02wIN
         WfTS2zneopT0gKnozdtThkK/fDhnMqEFwojXfNm0m/umfhUQtdnAw1BZ+XexOK8muVAN
         YhXAEveICJpNLsZg2dNCBQVhQ5S4Js5FmY1vPCxsphdAibPmHcZVBna4Iwd184Zvjh9d
         QCOlfag1QkplANzvYuXKz98hOx2M8tTYZ8paRvbv0tAklsi4LX04yfwUpEeDmqjH8ypG
         ZmCESSd2UNxNoMb1iExSySIeeoxEen0GVGIH19hvcXBlIxZam9exKCoTe9TVM7IuyVSq
         j4tw==
X-Gm-Message-State: AOJu0YxcLSCxgxgWw0Jatrtk2/ZqN/gcK5bTK0xXxcqq/DMVor+tb2D2
	74jMaumIHVS3pAQluUKfTOeEGsfM99ag+5LHvemjNfNITyYPlfh4VsZ07V6RLuGyirkN9kzq51x
	mLpCZhpc=
X-Gm-Gg: ASbGncuqMDIhAfs7JL7sklg+eEmlbwcynBaIJ+4ZgD+knxJWQg+9W5XMXXrM5e3THMs
	9K8thSNkqoVe9fGzdzKiGuXTTM5t40IeuP4TaxtXVy3dlMDYesyFi67xxDkIq+R7b6D7avzNqij
	xE2WwCZL7spZSRXItIPwi2v5M4uvjSdl5wFCgGrZbtpnfeOI0DYWvclxJgVvTTRzz2go7FfLGJn
	UGcHvw6fcc5miKUt9AeEyinxtpS6RIuDqQnJaHs6T7d9gVtGaeLVpwxzghgrhL5nmxWrKXMTObO
	+QyQtN81QE1qTBUNV7gg7eDwelzXJBIxxQ8FuigpXdbRQYskUM9d6AM0R35CDU/d4BNbrtnvxGj
	6/6Rs/d+tWnazhwUNjzk7HbuO/DWxRl5hj4ewj+HG/lJK6bD0OxgmJ5C/MRr5DZuemrrbVpMiDf
	AsY7s+P5hBIxeb0+J1Wz6+ABcM6TrGGQuFVw==
X-Google-Smtp-Source: AGHT+IEeTSpLZEihOentgy2q7pULZCs4PZHYtywdpRDtbjbVTMWaGOn0tMquXEH/8nFuSuogXRleNg==
X-Received: by 2002:a17:906:7953:b0:b72:5a54:172f with SMTP id a640c23a62f3a-b725a541c89mr102075766b.53.1762257801493;
        Tue, 04 Nov 2025 04:03:21 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3082sm195032166b.11.2025.11.04.04.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:03:20 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	davem@davemloft.net,
	bridge@lists.linux.dev,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 2/2] selftests: forwarding: bridge: add a state bypass with disabled VLAN filtering test
Date: Tue,  4 Nov 2025 14:03:13 +0200
Message-ID: <20251104120313.1306566-3-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104120313.1306566-1-razor@blackwall.org>
References: <20251104120313.1306566-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test which checks that port state bypass cannot happen if we have
VLAN filtering disabled and MST enabled. Such bypass could lead to race
condition when deleting a port because learning may happen after its
state has been toggled to disabled while it's being deleted, leading to
a use after free.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 .../net/forwarding/bridge_vlan_unaware.sh     | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
index 2b5700b61ffa..20769793310e 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding pvid_change"
+ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding pvid_change mst_state_no_bypass"
 NUM_NETIFS=4
 source lib.sh
 
@@ -114,6 +114,39 @@ pvid_change()
 	ping_ipv6 " with bridge port $swp1 PVID deleted"
 }
 
+mst_state_no_bypass()
+{
+	local mac=de:ad:be:ef:13:37
+
+	# Test that port state isn't bypassed when MST is enabled and VLAN
+	# filtering is disabled
+	RET=0
+
+	# MST can be enabled only when there are no VLANs
+	bridge vlan del vid 1 dev $swp1
+	bridge vlan del vid 1 dev $swp2
+	bridge vlan del vid 1 dev br0 self
+
+	ip link set br0 type bridge mst_enabled 1
+	check_err $? "Could not enable MST"
+
+	bridge link set dev $swp1 state disabled
+	check_err $? "Could not set port state"
+
+	$MZ $h1 -c 1 -p 64 -a $mac -t ip -q
+
+	bridge fdb show brport $swp1 | grep -q de:ad:be:ef:13:37
+	check_fail $? "FDB entry found when it shouldn't be"
+
+	log_test "VLAN filtering disabled and MST enabled port state no bypass"
+
+	ip link set br0 type bridge mst_enabled 0
+	bridge link set dev $swp1 state forwarding
+	bridge vlan add vid 1 dev $swp1 pvid untagged
+	bridge vlan add vid 1 dev $swp2 pvid untagged
+	bridge vlan add vid 1 dev br0 self
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.51.0


