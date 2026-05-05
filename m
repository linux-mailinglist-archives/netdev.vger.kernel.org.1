Return-Path: <netdev+bounces-284590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJj8AB1v+mnJOwMAu9opvQ
	(envelope-from <netdev+bounces-284590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 00:28:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCD44D4577
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 00:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78FA33024A06
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EF94A13A7;
	Tue,  5 May 2026 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="REi5JWFZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yQLTBHku";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="REi5JWFZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yQLTBHku"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963D348C8C1
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020116; cv=none; b=HMb31Kc/RQLsyZDGfTCr1qk8p00YNNei/yQieQbNx6VEAaGKHyBmSWIyBB0UzpOazhzyoughUb2isjqtiXdOVJdZ8FYpbSykF8G0YWiGmSRCRYVvdtr8I0Dl0ivoORNXF04Gs+pHl58aTCm1BxKUn0ZE9CW4PVx9gG0uyI0Rdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020116; c=relaxed/simple;
	bh=XIjnEptouLZ6KVsPwaSokKtanFObwEy4KxicyBMAf6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9I/CMp0A4owj3bZiNs9wUX72RPs/gYaVGRb2xeTBOeSXUne7hqE+YW+MpJDWys8hT6GpbXKdoBi+Jh7GGPK+TDbrKdhkvBQMX429i7j81xRgrgP+JYkIi/G415zu0TTMq/VCncx0ll8nUMfuMNiPp729fRD589zyflChwJt6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=REi5JWFZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yQLTBHku; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=REi5JWFZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yQLTBHku; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 019985CDF6;
	Tue,  5 May 2026 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778020111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmBMrQPk+PWVFnZpG4VVHeAwNBDyjX3pd1XscF9ZoDI=;
	b=REi5JWFZQ7z27jAFX29Ynv4uBhFKV34g5oN7xTBdMGZ+v3a+de3uKFovxziBBL8djnYBpu
	GZReMvLCq2UTHptkAFLE0BFZtVJ+IuDk6hyGsOzCyL6KWmOTfErLlyweqy7o3k9/UwfEMz
	825hdsCiZWx15Itzta78ygS24xVncDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778020111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmBMrQPk+PWVFnZpG4VVHeAwNBDyjX3pd1XscF9ZoDI=;
	b=yQLTBHkuHER6h3bRH8ZQ+0sVibpryz/8z7DGglzI4jyTyuh2Ykex+uBQtjpjEBTzTszcQR
	KMjw80EzGHTxTfBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778020111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmBMrQPk+PWVFnZpG4VVHeAwNBDyjX3pd1XscF9ZoDI=;
	b=REi5JWFZQ7z27jAFX29Ynv4uBhFKV34g5oN7xTBdMGZ+v3a+de3uKFovxziBBL8djnYBpu
	GZReMvLCq2UTHptkAFLE0BFZtVJ+IuDk6hyGsOzCyL6KWmOTfErLlyweqy7o3k9/UwfEMz
	825hdsCiZWx15Itzta78ygS24xVncDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778020111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmBMrQPk+PWVFnZpG4VVHeAwNBDyjX3pd1XscF9ZoDI=;
	b=yQLTBHkuHER6h3bRH8ZQ+0sVibpryz/8z7DGglzI4jyTyuh2Ykex+uBQtjpjEBTzTszcQR
	KMjw80EzGHTxTfBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69960593A3;
	Tue,  5 May 2026 22:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2JT+Fg5v+mkbWgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 05 May 2026 22:28:30 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net v2] selftests: fib_tests: add temporary IPv6 address renewal test
Date: Wed,  6 May 2026 00:28:02 +0200
Message-ID: <20260505222802.4296-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222802.4296-1-fmancera@suse.de>
References: <20260505222802.4296-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 8BCD44D4577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284590-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Add a test to check that temporary IPv6 address is regenerated properly
after the base prefix is deprecated and restored.

Fib6 temporary address renewal test
    TEST: IPv6 temporary address cleanly deprecated and regenerated     [ OK ]

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: adjusted the sleep so there is enough time for the issue to trigger,
added cleanup at the end
---
 tools/testing/selftests/net/fib_tests.sh | 59 +++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index af64f93bb2e1..8f10de0eb985 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -12,7 +12,7 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
        ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
        ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
        ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance \
-       ipv4_mpath_balance_preferred fib6_ra_to_static"
+       ipv4_mpath_balance_preferred fib6_ra_to_static fib6_temp_addr_renewal"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -1611,6 +1611,62 @@ fib6_ra_to_static()
 	cleanup &> /dev/null
 }
 
+fib6_temp_addr_renewal() {
+	setup
+
+	echo
+	echo "Fib6 temporary address renewal test"
+	set -e
+
+	# ra6 is required for the test. (ipv6toolkit)
+	if [ ! -x "$(command -v ra6)" ]; then
+	    echo "SKIP: ra6 not found."
+	    set +e
+	    cleanup &> /dev/null
+	    return
+	fi
+
+	# Create a pair of veth devices to send a RA message from one
+	# device to another.
+	$IP link add veth1 type veth peer name veth2
+	$IP link set dev veth1 up
+	$IP link set dev veth2 up
+
+	# Make veth1 ready to receive RA messages.
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.accept_ra=2
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.use_tempaddr=2
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.temp_prefered_lft=15
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.max_desync_factor=0
+
+	# Send a RA message with a prefix from veth2.
+	$NS_EXEC ra6 -i veth2 -s fe80::1 -d ff02::1 -P 2001:12::/64\#LA\#3600\#3600 -e
+	sleep 3
+
+	# Deprecate it
+	$NS_EXEC ra6 -i veth2 -s fe80::1 -d ff02::1 -P 2001:12::/64\#LA\#3600\#0 -e
+	sleep 3
+
+	# Restore it
+	$NS_EXEC ra6 -i veth2 -s fe80::1 -d ff02::1 -P 2001:12::/64\#LA\#3600\#3600 -e
+
+	ret=1
+	for i in $(seq 1 25); do
+		sleep 1
+		num_dep="$($IP -6 addr | grep -c "temporary deprecated" || true)"
+		num_tot="$($IP -6 addr | grep -c "temporary" || true)"
+
+		if [ "$num_dep" -eq 1 ] && [ "$num_tot" -ge 2 ]; then
+			ret=0
+			break
+		fi
+	done
+	log_test "$ret" 0 "IPv6 temporary address cleanly deprecated and regenerated"
+
+	set +e
+
+	cleanup &> /dev/null
+}
+
 # add route for a prefix, flushing any existing routes first
 # expected to be the first step of a test
 add_route()
@@ -3002,6 +3058,7 @@ do
 	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
 	ipv4_mpath_balance_preferred)	ipv4_mpath_balance_preferred_test;;
 	fib6_ra_to_static)		fib6_ra_to_static;;
+	fib6_temp_addr_renewal)		fib6_temp_addr_renewal;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.53.0


