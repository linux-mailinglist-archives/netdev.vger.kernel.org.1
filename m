Return-Path: <netdev+bounces-72433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05211858148
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 16:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3890C1C21016
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC891420A6;
	Fri, 16 Feb 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W66p4Xsr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A732C13AA56
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097338; cv=none; b=eRU1gKaTbVBuhXLTMVHZcW5aM5bEi5foxxPdf9yd0+uhp6fDjGSDyY06F2sNvFtkV0UT7Je71sHF++v22XY8nuSIstTBtHMC6zfEBHD4iRDrBFgyO8QCapKkY+sp1+WHqaw9Zhv+1FnnekU3AtlSWarHSQQedCj9Mqcbqh4Ko0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097338; c=relaxed/simple;
	bh=gFKj/PeEIe6OjteVeU7pc6vwa/E3Z3NoAKff2scSwiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7LGDH5yyiAEvbq+evLuFSIYIzles47jNFnNDj6soebC73UdC3/lHZ0XPgpJscwlY78XK2uJhvgZl3kp5l7+4xopGBBT5RjvUZm/UzkEv5rfXGTyP6mfIK5kdMglfP4S3Mgw5pIRVmeZJLl7GSKhcvwwhoZB3lqCW4SO0D/nT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W66p4Xsr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708097335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD4pjXcBxUTwpnjEXzSh5eXbo4UExERB9Ao4MtQZ2EA=;
	b=W66p4Xsr0EqqqXGOIRDlPZ+HBNxIDJ5MhIix35tiM1WTew4Fp6Yjh6x3beeKFg26vtmmXN
	PdRhqrgISIe0WmJKHxOkl3MLiVHlfjdq/15+rxIYtFYEuZANyJplDMtVd0tNT2Re8/YYP5
	f+g9Acq2brF8a6oRkzDqVc5oKEgVEnQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-ehuCETy6MRiidclAeDfzIw-1; Fri,
 16 Feb 2024 10:28:51 -0500
X-MC-Unique: ehuCETy6MRiidclAeDfzIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C93B3C1E9CA;
	Fri, 16 Feb 2024 15:28:50 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E5AA1C06532;
	Fri, 16 Feb 2024 15:28:50 +0000 (UTC)
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
Subject: [RFC 5/7] selftests: openvswitch: make arping test a bit 'slower'
Date: Fri, 16 Feb 2024 10:28:44 -0500
Message-ID: <20240216152846.1850120-6-aconole@redhat.com>
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

The arping test transmits a single packet and immediately tries to pull
the log for upcall details.  This works fine in practice on most systems
but can fail under a slower VM where it can take a while for the log
data to be written.  By adding addtional transmits we give the system
time to write, and also increase the opportunity to not miss processing
the upcall queue.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/openvswitch/openvswitch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 8dc315585710..a2c106104fb8 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -598,7 +598,7 @@ test_upcall_interfaces() {
 
 	sleep 1
 	info "sending arping"
-	ip netns exec upc arping -I l0 172.31.110.20 -c 1 \
+	ip netns exec upc arping -I l0 172.31.110.20 -c 3 \
 	    >$ovs_dir/arping.stdout 2>$ovs_dir/arping.stderr
 
 	grep -E "MISS upcall\[0/yes\]: .*arp\(sip=172.31.110.1,tip=172.31.110.20,op=1,sha=" $ovs_dir/left0.out >/dev/null 2>&1 || return 1
-- 
2.41.0


