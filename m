Return-Path: <netdev+bounces-72431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4491585813F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95691F21BD5
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93813AA48;
	Fri, 16 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRoRWqFU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885A137C5F
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097336; cv=none; b=c5fHGFmz7hDjxbUpJSyPCQ/QMsUWJJZD7e8du00efKGGkVOsiBO/zsAVZTwXJ2P3qfmyAKJ46f1NI/s/nFcEwUG6f3kAhkEDkexYmzV7UlIQou6okkcccHWPwYIq7lbGpkKkHwJDJe6WZI3Jr1MCCWST45RTjMwIbXZkKwvPV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097336; c=relaxed/simple;
	bh=+VPEA2dIxiq+tX8ezqarB+b9JozN2PIUG9DrLT+mW38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmJWgWOnASHYHp2fWU32+tBb+Jp/yoFCFnIfGFYNj+OhRPEQUQHguG1KKVLqDCNBn27BKPnQ4eEJNcWwGiw1V9c7RqXECvcfF/GLerNqrNprJ44KAuogrHQsmSswyXSmKz0oCT0p9iEhC7H6tkgcc/uceT5rh4zuSGZSQMMe0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gRoRWqFU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708097333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ92gCXKw2n0LovijjEifDOZBlKXAd8WxMwKdfCj/2k=;
	b=gRoRWqFUo6Vz5Vv1U8XgMRLQpON1t+J87qTYfPSurbK3vft20AZpv96hgH0AzCGUHX4aD3
	ZOlIA93p2q0ADVVmdrSCt3T295rkh5tCUCbwF6bREk0Sv5dCiPZgbZjdyhyoc7Tqu0UBHE
	QxnqvUslmjSKmorY57XKOxcoX2CYDlI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-8_nAtaiIPCazoS_e_UC5-w-1; Fri, 16 Feb 2024 10:28:50 -0500
X-MC-Unique: 8_nAtaiIPCazoS_e_UC5-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00E81185A784;
	Fri, 16 Feb 2024 15:28:50 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7F84C1C05E0F;
	Fri, 16 Feb 2024 15:28:49 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Simon Horman <horms@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC 4/7] selftests: openvswitch: delete previously allocated netns
Date: Fri, 16 Feb 2024 10:28:43 -0500
Message-ID: <20240216152846.1850120-5-aconole@redhat.com>
In-Reply-To: <20240216152846.1850120-1-aconole@redhat.com>
References: <20240216152846.1850120-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Many openvswitch test cases reused netns and interface names.  This works
fine as long as the test case cleans up gracefully.  However, if there is
some kind of ungraceful termination (such as an external signal) the netns
or interfaces can be left lingering.  This happens when the selftest
timeout gets exceeded, while running under very slow debugging conditions.

The solution here is to cleanup the netns on executing the next test.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/openvswitch/openvswitch.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 678a72ad47c1..8dc315585710 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -115,6 +115,10 @@ ovs_netns_spawn_daemon() {
 
 ovs_add_netns_and_veths () {
 	info "Adding netns attached: sbx:$1 dp:$2 {$3, $4, $5}"
+	ntns_e=`ip netns list | grep $3`
+	[ "$ntns_e" != "" ] && ip netns del "$3"
+	if4_e=`ip link show $4 2>/dev/null`
+	[ "$if4_e" != "" ] && ip link del "$4"
 	ovs_sbx "$1" ip netns add "$3" || return 1
 	on_exit "ovs_sbx $1 ip netns del $3"
 	ovs_sbx "$1" ip link add "$4" type veth peer name "$5" || return 1
-- 
2.41.0


