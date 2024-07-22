Return-Path: <netdev+bounces-112384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063E2938C2B
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18991F219E1
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D459416A945;
	Mon, 22 Jul 2024 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LwozCgo2"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0508B26ADB
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641317; cv=none; b=hY86SXLxjObpxu2xSSkaEpefK38pD4tjpRj08DyzJsYcahIbxDnVINOIXU2Su0fShh7VEgSgkBl2LD3v9WqrYVfC44zpsUwAF6xenjOjOOAbJPnBRsI9/hYjo1m0xfVFLyinHZgCeg/hE/p2s729O07dwkQxYcEmVKvP4n+R59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641317; c=relaxed/simple;
	bh=Wzq748dIIUkgOnN7auC0wKZzIokzeIK+4vYosMtcUKo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=quHf5EGJ+unF8g9R0uCnISr4AnQJ2STkWg1fljPGT4JDYGmLYsxom6Y04pgiICG5tfZKpCpvGtXPMCdisBIKbCRte+FzVCqQuYFU9qSnuFU5M4dno40DimNJi8VBlkSNeo7tFL8fzLToQ+u/GjBB/feUg1kcgMpoBskrF14qsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LwozCgo2; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=gPT7hkfMhbHv3fUO2r
	WQEG4hLgcPuqfdjvaE1i5pT5c=; b=LwozCgo267S24E1ZF5aUtuuCkT8Z/HPnSe
	Ne+GX8Pn+xE1SuzRP7YyL4a12v3qXG75z/uY15TPb2Yu6waKuPQEd8CCEB1BB6vc
	nvi/hgytlSbIJNjFf5urVATgFPwiAsY135bR1XGYK3TcJ19DLqvG0Ll2DafDUzNI
	fCp+Ddsqs=
Received: from localhost.localdomain (unknown [111.48.58.12])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wDXv2BBKZ5mQRNlAQ--.11942S2;
	Mon, 22 Jul 2024 17:41:22 +0800 (CST)
From: xiaolinkui@126.com
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.com>
Subject: [PATCH] tcp/dccp: replace using only even ports with all ports
Date: Mon, 22 Jul 2024 17:41:19 +0800
Message-Id: <20240722094119.31128-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDXv2BBKZ5mQRNlAQ--.11942S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryrAw17Jr4Utry8Zr1rtFb_yoW5try7p3
	yDKr1ktF1DtF1UKr1qvFykArySyw1kAF1DCF4kuwsIka4DJrnIqFZ2krsY9FyUuF40vFyj
	kay0qr18AF15W3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjmhwUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/1tbiOgUk1mVExrV7DQAAsp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Linkui Xiao <xiaolinkui@kylinos.com>

In commit 207184853dbd ("tcp/dccp: change source port selection at connect()
time"), the purpose is to address the issue of increased costs when all even
ports are in use.

But in my testing environment, this more cost issue has not been resolved.

The testing environment is as follows:
1. build an HTTP server(http://192.168.55.1:9999/);
2. on the client side, use the ab command to test the number of connections,
then kill it and simulate a large number of TIME-WAIT connections:

TARGET_TIME_WAIT=16384
CONCURRENCY=20000
MAX_CONCURRENCY=20000
MIN_CONCURRENCY=5000

while true; do
  CURRENT_TIME_WAIT=$(ss -tanp | grep TIME-WAIT | wc -l)
  echo "Current TIME_WAIT connections: $CURRENT_TIME_WAIT"

  if [ "$CURRENT_TIME_WAIT" -lt "$TARGET_TIME_WAIT" ]; then
    if [ "$CONCURRENCY" -lt "$MAX_CONCURRENCY" ]; then
      CONCURRENCY=$((CONCURRENCY + 5000))
      if [ "$CONCURRENCY" -gt "$MAX_CONCURRENCY" ]; then
        CONCURRENCY=$MAX_CONCURRENCY
      fi
      echo "Increasing concurrency to: $CONCURRENCY"
    fi
  elif [ "$CURRENT_TIME_WAIT" -gt "$TARGET_TIME_WAIT" ]; then
    if [ "$CONCURRENCY" -gt "$MIN_CONCURRENCY" ]; then
      CONCURRENCY=$((CONCURRENCY - 5000))
      if [ "$CONCURRENCY" -lt "$MIN_CONCURRENCY" ]; then
        CONCURRENCY=$MIN_CONCURRENCY
      fi
      echo "Decreasing concurrency to: $CONCURRENCY"
    fi
  fi

  ab -r -n 100000 -c "$CONCURRENCY" http://192.168.55.1:9999/ &

  AB_PID=$!
  sleep 1
  kill $AB_PID
  sleep 1
done

On the client side, use the command "mpstat - P ALL 1" to monitor the load
situation.It can be observed that the load of %sys decreased by about 50%
after patching.

Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.com>
---
 net/ipv4/inet_hashtables.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 48d0d494185b..4192531ba2d3 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1007,7 +1007,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	u32 remaining, offset;
 	int ret, i, low, high;
 	bool local_ports;
-	int step, l3mdev;
+	int l3mdev;
 	u32 index;
 
 	if (port) {
@@ -1020,7 +1020,6 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	l3mdev = inet_sk_bound_l3mdev(sk);
 
 	local_ports = inet_sk_get_local_port_range(sk, &low, &high);
-	step = local_ports ? 1 : 2;
 
 	high++; /* [32768, 60999] -> [32768, 61000[ */
 	remaining = high - low;
@@ -1041,7 +1040,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		offset &= ~1U;
 other_parity_scan:
 	port = low + offset;
-	for (i = 0; i < remaining; i += step, port += step) {
+	for (i = 0; i < remaining; i += 1, port += 1) {
 		if (unlikely(port >= high))
 			port -= remaining;
 		if (inet_is_local_reserved_port(net, port))
@@ -1108,8 +1107,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	 * on low contention the randomness is maximal and on high contention
 	 * it may be inexistent.
 	 */
-	i = max_t(int, i, get_random_u32_below(8) * step);
-	WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + i + step);
+	i = max_t(int, i, get_random_u32_below(8) * 1);
+	WRITE_ONCE(table_perturb[index], READ_ONCE(table_perturb[index]) + i + 1);
 
 	/* Head lock still held and bh's disabled */
 	inet_bind_hash(sk, tb, tb2, port);
-- 
2.17.1


