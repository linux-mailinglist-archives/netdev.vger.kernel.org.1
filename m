Return-Path: <netdev+bounces-266356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLqwAFuUsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:59:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD165258950
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E96393026B4D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D36F3F210F;
	Tue, 10 Mar 2026 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="t3LYsIwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hrxy2CcX"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25C3F2100;
	Tue, 10 Mar 2026 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179979; cv=none; b=RwbyH8VcCNykqG8kBlUuynLDfcwRDxGgsbvM8ZSR4pv6fKPJsV35ppAjFBTJoRqn7ZxJviaIhTTlpIys/zDmL4dk+0FSKza3Z4XbGFeCiR+FjgYHVO9ZjCxJfbJ02VqlIIvFJDjlnrUkxyM5utFgCOcT69Dk3DZqEDF2z7JdB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179979; c=relaxed/simple;
	bh=f13w/2doTpmIhJWf4uNRNpxAIztGNJszb7YjfVlaz/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZwxNYMsT9dinPJI6pTMnfTEsIjMPyIxddBMncxEWqEWqLcYGPUSixRb111Cg3JCaPxHBeSE5UgHCBHy5M3mlv4LKD5SP2qJO/k6x99Jjb9pPAeEZ0IyMauGHeIWHp75cif6/PWuvoIWZ8aDorFLP7cpV7aCBLHkeElgi1lDt70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=t3LYsIwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hrxy2CcX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C0CC01D0013B;
	Tue, 10 Mar 2026 17:59:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 17:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773179976; x=
	1773266376; bh=HUoqezWhH6kt8wLNIqdnuF3T0mjP7eY5jUwHwQGXiXs=; b=t
	3LYsIwZgFiyE0Ol9Q6U576l1PExPjmKZvkHznd8mfT8PrJv1NYkF9uzMoXtVIx0I
	92iv3K5DWUnLeuPJ4CUFA1jezYJ3OtmgbLqxpIoen1HR7h+O9BX+9G6V5rIWU4ja
	2dWODUtJDMLLdbCTljP8z/OmqgyQ81Ayj8F6wlt3zJ2VGmjG9XypsdkiI7K31qol
	J7OSM40nid9hUvCnEDdslWTkXpT4cxGfEpddEbCiPH9aZNb+rl/4yYMwpildGxO7
	gvxhz6L6FL0GeQEAEzsBkfl36+lXjct0JYS7vOHCqjUwRSY0geTHMU4N/VTBY7lv
	Vd9DhxgQUH6Rpl/dSRPRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773179976; x=1773266376; bh=H
	UoqezWhH6kt8wLNIqdnuF3T0mjP7eY5jUwHwQGXiXs=; b=Hrxy2CcXLOfkJaz6C
	gdf6VZIb4MkmR78RD0TLNBybZgondCO9tsFslL556/e/Tje3EJHxYeTYx/GAsop9
	tYCCdNpJRzQfV7+by4agLx+4NHvB1nzHEAySNIBxiynQd74fDwvrKcWTAEpyS0sJ
	edUbe356Dc1JPjzSy2nicaGA89hCBBh8C95zKu12df0fG4AyEf9BGP1ttXciY5RX
	GAiUnvcMqt+APqVAC6X919mnPmnP3mY8NtrF7B/oswjS+B2c8bF3QV+759+SULu2
	JOKMOKVmUwRIQBAAa/n2e6sCObYuTgZkrfF+AazxERtCgDt6dXW6Pb1NMjt9Qtnb
	hxKdw==
X-ME-Sender: <xms:SJSwaR9eGJIO4o3ubbk-l511GFEUR0ZKTM_hYQPcDizzQ5SDZLnY-Q>
    <xme:SJSwafBccaOoUCwc_TYbN3K9e6IbJ6Gi1029NcREDKwZlLFe9ntwtaE3HMtsBFF4h
    JXJsBNLe0uvkwu-bYs0ZFD-z83LkS4cdp0Q8l6u8VT4j3ULDn8FyTs>
X-ME-Received: <xmr:SJSwaWQBeqQ7cKTmnVsnsAx191iSEEL_mMehm2q0yDdgP0Fm9B98km5lE4Yp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphht
    thhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhksh
    gvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhi
    hihusehgohhoghhlvgdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:SJSwaWuOkjQJnvLI5nmXlkVglgKcRBZh_Oqh0ljCMX8P0oC2YsCFdA>
    <xmx:SJSwaS08BzFoDbJvaVIU1XZKiQ1mYlR7IiIGEVvR5AN0guGvZn-AoQ>
    <xmx:SJSwaXURb950NvpjIV0ct9Fj_jkvALDfv5ggWDdLHEsrv3SG6hWi-Q>
    <xmx:SJSwadJoGfi7s0PT6XHwrRbhV7T9NKEG_7j5yedCkXPHyRMr7sB6Mw>
    <xmx:SJSwaWKONHZjljmi82wO2uDIX2-96vEp29d0f7-9yR5H4GM9EZlfI_Ux>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 17:59:36 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net 2/2] selftests: rtnetlink: add neighbour update test
Date: Tue, 10 Mar 2026 22:59:17 +0100
Message-ID: <d28f72b5b4ff4c9ecbbbde06146a938dcc4c264a.1772894876.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1772894876.git.sd@queasysnail.net>
References: <cover.1772894876.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD165258950
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[queasysnail.net];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266356-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid]
X-Rspamd-Action: no action

Check that protocol and flags are updated correctly for
neighbour and pneigh entries.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/rtnetlink.sh | 55 ++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 248c2b91fe42..5a5ff88321d5 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -28,6 +28,7 @@ ALL_TESTS="
 	kci_test_fdb_get
 	kci_test_fdb_del
 	kci_test_neigh_get
+	kci_test_neigh_update
 	kci_test_bridge_parent_id
 	kci_test_address_proto
 	kci_test_enslave_bonding
@@ -1160,6 +1161,60 @@ kci_test_neigh_get()
 	end_test "PASS: neigh get"
 }
 
+kci_test_neigh_update()
+{
+	dstip=10.0.2.4
+	dstmac=de:ad:be:ef:13:37
+	local ret=0
+
+	for proxy in "" "proxy" ; do
+		# add a neighbour entry without any flags
+		run_cmd ip neigh add $proxy $dstip dev "$devdummy" lladdr $dstmac nud permanent
+		run_cmd_grep $dstip ip neigh show $proxy
+		run_cmd_grep_fail "$dstip dev $devdummy .*\(managed\|use\|router\|extern\)" ip neigh show $proxy
+
+		# set the extern_learn flag, but no other
+		run_cmd ip neigh change $proxy $dstip dev "$devdummy" extern_learn
+		run_cmd_grep "$dstip dev $devdummy .* extern_learn" ip neigh show $proxy
+		run_cmd_grep_fail "$dstip dev $devdummy .* \(managed\|use\|router\)" ip neigh show $proxy
+
+		# flags are reset when not provided
+		run_cmd ip neigh change $proxy $dstip dev "$devdummy"
+		run_cmd_grep $dstip ip neigh show $proxy
+		run_cmd_grep_fail "$dstip dev $devdummy .* extern_learn" ip neigh show $proxy
+
+		# add a protocol
+		run_cmd ip neigh change $proxy $dstip dev "$devdummy" protocol boot
+		run_cmd_grep "$dstip dev $devdummy .* proto boot" ip neigh show $proxy
+
+		# protocol is retained when not provided
+		run_cmd ip neigh change $proxy $dstip dev "$devdummy"
+		run_cmd_grep "$dstip dev $devdummy .* proto boot" ip neigh show $proxy
+
+		# change protocol
+		run_cmd ip neigh change $proxy $dstip dev "$devdummy" protocol static
+		run_cmd_grep "$dstip dev $devdummy .* proto static" ip neigh show $proxy
+
+		# also check an extended flag for non-proxy neighs
+		if [ "$proxy" = "" ]; then
+			run_cmd ip neigh change $proxy $dstip dev "$devdummy" managed
+			run_cmd_grep "$dstip dev $devdummy managed" ip neigh show $proxy
+
+			run_cmd ip neigh change $proxy $dstip dev "$devdummy" lladdr $dstmac
+			run_cmd_grep_fail "$dstip dev $devdummy managed" ip neigh show $proxy
+		fi
+
+		run_cmd ip neigh del $proxy $dstip dev "$devdummy"
+	done
+
+	if [ $ret -ne 0 ];then
+		end_test "FAIL: neigh update"
+		return 1
+	fi
+
+	end_test "PASS: neigh update"
+}
+
 kci_test_bridge_parent_id()
 {
 	local ret=0
-- 
2.51.2


