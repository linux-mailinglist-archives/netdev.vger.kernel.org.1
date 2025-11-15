Return-Path: <netdev+bounces-238850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2C1C602EF
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 11:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5683B9845
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 10:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2492B283FCE;
	Sat, 15 Nov 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="etEVKcuS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IM9ek51z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="etEVKcuS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IM9ek51z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57A26B08F
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763200797; cv=none; b=Prx2DdPeo+pCtggRoZ+juQF4MWvTfP1XCr2seIZDddxYv9zP0Bp8fdYNz5i5AST+sjbN3MkK2V09SdpD8wZ5xdtAPKl35QhJLsohJXhy5GkrmXIecciBzkqP+TQrI46CX3FcehGvmOgoxzN3T7na/r2vH568xjVbY68BGDeatX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763200797; c=relaxed/simple;
	bh=e2Tl1miqkRAhXSd57qLVHFSkvWyTBUJHym3qKPplFgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwMpFbkG9EmoezbXMwknEBXJqbXINZJ4+oT+8LIqoHUl4feBbk8yc7OOQwTcC0ACd14qyEZo609Zxf5xojNbLQL62oeabmjFB2SdwOoetKcC720wiXsarGHY6k6zhf8cq4bQScx2xPaVFOck5TFFi/Lh0Zu7wvzb8DDmcsCoXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=etEVKcuS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IM9ek51z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=etEVKcuS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IM9ek51z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7D121F391;
	Sat, 15 Nov 2025 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763200793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4GpMazD84jEI2hqrc08wxyKwKyHSNJQrdd13QWWmqg=;
	b=etEVKcuSteNrcfvVmPgzqNzsC08LOkSsL76aeN2FI/ogPE4ULPtioqt8XXeguLfsfKSfSL
	LhAUfykE2ns2UJUlP3KgUVcPysxPVuXmsLzynl57ArwyK6EiyaD/paeizbOxXqCyHQHKFZ
	iCs18wIO3eXpycHuQxdT4fIgj/nosLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763200793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4GpMazD84jEI2hqrc08wxyKwKyHSNJQrdd13QWWmqg=;
	b=IM9ek51zoX1YftwOOKGqmZNInqUMqcz6vl5clj5TkkHFRBYIZuNRmwJaTVf4PhsAzIVPeq
	xXp8nj1xGdr2NlDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=etEVKcuS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IM9ek51z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763200793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4GpMazD84jEI2hqrc08wxyKwKyHSNJQrdd13QWWmqg=;
	b=etEVKcuSteNrcfvVmPgzqNzsC08LOkSsL76aeN2FI/ogPE4ULPtioqt8XXeguLfsfKSfSL
	LhAUfykE2ns2UJUlP3KgUVcPysxPVuXmsLzynl57ArwyK6EiyaD/paeizbOxXqCyHQHKFZ
	iCs18wIO3eXpycHuQxdT4fIgj/nosLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763200793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4GpMazD84jEI2hqrc08wxyKwKyHSNJQrdd13QWWmqg=;
	b=IM9ek51zoX1YftwOOKGqmZNInqUMqcz6vl5clj5TkkHFRBYIZuNRmwJaTVf4PhsAzIVPeq
	xXp8nj1xGdr2NlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C5073EA61;
	Sat, 15 Nov 2025 09:59:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YGDnBxlPGGl+HQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 15 Nov 2025 09:59:53 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 net-next v2] selftests: fib_tests: add fib6 from ra to static test
Date: Sat, 15 Nov 2025 10:59:39 +0100
Message-ID: <20251115095939.6967-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115095939.6967-1-fmancera@suse.de>
References: <20251115095939.6967-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A7D121F391
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

The new test checks that a route that has been promoted from RA-learned
to static does not switch back when a new RA message arrives. In
addition, it checks that the route is owned by RA again when the static
address is removed.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: added this patch to the series
---
 tools/testing/selftests/net/fib_tests.sh | 66 +++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index a94b73a53f72..a88f797c549a 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -11,7 +11,8 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
        ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics \
        ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
        ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
-       ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance"
+       ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance \
+       fib6_ra_to_static"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -1476,6 +1477,68 @@ ipv6_route_metrics_test()
 	route_cleanup
 }
 
+fib6_ra_to_static()
+{
+	setup
+
+	echo
+	echo "Fib6 route promotion from RA-learned to static test"
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
+	$IP -6 address add 2001:10::1/64 dev veth1 nodad
+	$IP -6 address add 2001:10::2/64 dev veth2 nodad
+
+	# Make veth1 ready to receive RA messages.
+	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.accept_ra=2
+
+	# Send a RA message with a prefix from veth2.
+	$NS_EXEC ra6 -i veth2 -d 2001:10::1 -P 2001:12::/64\#LA\#120\#60
+
+	# Wait for the RA message.
+	sleep 1
+
+	# systemd may mess up the test. Make sure that
+	# systemd-networkd.service and systemd-networkd.socket are stopped.
+	check_rt_num_clean 2 $($IP -6 route list|grep expires|wc -l) || return
+
+	# Configure static address on the same prefix
+	$IP -6 address add 2001:12::dead/64 dev veth1 nodad
+
+	# On-link route won't expire anymore, default route still owned by RA
+	check_rt_num 1 $($IP -6 route list |grep expires|wc -l)
+
+	# Send a second RA message with a prefix from veth2.
+	$NS_EXEC ra6 -i veth2 -d 2001:10::1 -P 2001:12::/64\#LA\#120\#60
+	sleep 1
+
+	# Expire is not back, on-link route is still static
+	check_rt_num 1 $($IP -6 route list |grep expires|wc -l)
+
+	$IP -6 address del 2001:12::dead/64 dev veth1 nodad
+
+	# Expire is back, on-link route is now owned by RA again
+	check_rt_num 2 $($IP -6 route list |grep expires|wc -l)
+
+	log_test $ret 0 "ipv6 promote RA route to static"
+
+	set +e
+
+	cleanup &> /dev/null
+}
+
 # add route for a prefix, flushing any existing routes first
 # expected to be the first step of a test
 add_route()
@@ -2798,6 +2861,7 @@ do
 	ipv6_mpath_list)		ipv6_mpath_list_test;;
 	ipv4_mpath_balance)		ipv4_mpath_balance_test;;
 	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
+	fib6_ra_to_static)		fib6_ra_to_static;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.51.1


