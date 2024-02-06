Return-Path: <netdev+bounces-69468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A342684B605
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47EA2B26583
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D4212FF6C;
	Tue,  6 Feb 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9xywpBw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427C130AFD
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225115; cv=none; b=XeS5oyZgzQ4GLIDpD+E2sRE5gn8rTD9tLq34DIcUGta7OVYwuo4PfSx7h/NSZOi6Y27MMMB4IZKS6s7rEKF4Zze+iQ/mW/FUUCoWAPi7WWpCHgmqM/qZP4vQMX7pytzoFBNWQ7Idfxa4HYNavd8Z5M0ZxElsmG1tyyDj1eNBGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225115; c=relaxed/simple;
	bh=2vwVb7Nghwjlr4vuq8xMoDjaG0FDt8oTkMKLvufRpYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+BjBw7Vv6WilLaWGl9cLIZ9GgMO7nWCS6WqmFTB3T+muttTPd9CgDtr2On1qtIF7cWLnPlsE7bhFuD/OY68h8E6Awf5APV4uuhNB+jQtxCPrirGJrhBjB0RIUmYZSOjqfovT9s3L43V4AMYWFV4I6nRK8O0Og3elT/UjnE/WYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9xywpBw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707225111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1nCJtXy//H7+SnPAkDXeApA63PBqCy/bYvy+OG2uGgI=;
	b=N9xywpBwlPql9SETXfp+PXLRfEwC7xGoHETniXmwj23gf/2PjV3OZ15GHVqKnmCkJMZLWd
	T/wBC/X+BdzQ1QCdMws+TaejNviT4iv3VCZnedLLrjyKi3PnMlTZ7hIgL2sV/Gd6DGpJj6
	FSOqJw9D5YSv0jDavFW+rj2m9tESefw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-cJScLZNtM76y44T-tuaLEA-1; Tue, 06 Feb 2024 08:11:48 -0500
X-MC-Unique: cJScLZNtM76y44T-tuaLEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3146D86C047;
	Tue,  6 Feb 2024 13:11:48 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.8.151])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B23CC2026D06;
	Tue,  6 Feb 2024 13:11:47 +0000 (UTC)
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
	Eelco Chaudron <echaudro@redhat.com>
Subject: [PATCH net 0/2] net: openvswitch: limit the recursions from action sets
Date: Tue,  6 Feb 2024 08:11:45 -0500
Message-ID: <20240206131147.1286530-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Open vSwitch module accepts actions as a list from the netlink socket
and then creates a copy which it uses in the action set processing.
During processing of the action list on a packet, the module keeps a
count of the execution depth and exits processing if the action depth
goes too high.

However, during netlink processing the recursion depth isn't checked
anywhere, and the copy trusts that kernel has large enough stack to
accommodate it.  The OVS sample action was the original action which
could perform this kinds of recursion, and it originally checked that
it didn't exceed the sample depth limit.  However, when sample became
optimized to provide the clone() semantics, the recursion limit was
dropped.

This series adds a depth limit during the __ovs_nla_copy_actions() call
that will ensure we don't exceed the max that the OVS userspace could
generate for a clone().

Additionally, this series provides a selftest in 2/2 that can be used to
determine if the OVS module is allowing unbounded access.  It can be
safely omitted where the ovs selftest framework isn't available.

Aaron Conole (2):
  net: openvswitch: limit the number of recursions from action sets
  selftests: openvswitch: Add validation for the recursion test

 net/openvswitch/flow_netlink.c                | 33 +++++++--
 .../selftests/net/openvswitch/openvswitch.sh  | 13 ++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 71 +++++++++++++++----
 3 files changed, 97 insertions(+), 20 deletions(-)

-- 
2.41.0


