Return-Path: <netdev+bounces-43283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA17D22ED
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 13:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FB41C208B8
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52967483;
	Sun, 22 Oct 2023 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk9zkKC4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30805698
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 11:32:04 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E2F11B;
	Sun, 22 Oct 2023 04:32:02 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b497c8575aso2350038b3a.1;
        Sun, 22 Oct 2023 04:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697974321; x=1698579121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ7n+v9m+PyKaMpTphITvlWXT1CO3oXKgg4jO6DVoj8=;
        b=Pk9zkKC4iq2w0RIHV9nWDaxhPYwZV79uUtMsRdU1wnW+esMA5XkYALbKYjbPITY/oK
         2VCSIBns+g6wSoU4IBr9YLHY6r3EnFUTz27EBH7A9m5zM1pGZdrBx5je5/G7jzvddjHh
         VPmBKuxIZ1w8XDz6p+J7Awf+JcB/nhwP7FbUpijY43judsOcEeITJLP8Vqd5fDuwW+kz
         6eCEXzeo6Bbhex7kGRDvbRjkV60aXks0Bz6prR7uBLeQHJrormf8IgXAEtKlP7bfC77L
         7H8HHh40peT3jN2AoIn6AQBSWqobRYylYAEcZ7jidhKT68FePjPD27/efofNbTYSXUg7
         yh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697974321; x=1698579121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQ7n+v9m+PyKaMpTphITvlWXT1CO3oXKgg4jO6DVoj8=;
        b=Orqa9iRYIrLafefXqS575JfEWWj+UZsJLdijui4/48l4glfTSGaf3+oTxpGRDefc1R
         OyV9uz2meOGbzGWJFDc4P2MFDvlioSOh9DbEeMQxjCxMxcYAf9qY1ioRDUiZ8XP3CKAn
         LvH3zV0a/B7flO8qn7EZjA3/wMX2E5zdocr8ppqHS0LBEcwJM7xDtiyGPQRBPZacyXIt
         T+aoX5mQJ3JLWtFIHmoquU3NOwd2ErN9yVvAlV/EvbG6ByRGbrVTQpR8EJ0FDMTy6dat
         XrF5KfPIchqn+WIKm0gl9ETnqH7hpv3yPhduqrHTqjB0GtbTuS8ysjfsbr7ByaCOYrFd
         SQbg==
X-Gm-Message-State: AOJu0YywU5cN4ov577XbeXppO1zb84qJYzTrD6lBcWdDCAdxXQCT2KgY
	iVmSyPZRH1jTi2uDLbVvsuA=
X-Google-Smtp-Source: AGHT+IFnMBSSH1d6q6yg4NNW4JuRt11TVePUFY5Tl9BRpqeJ5VZailqw59cOJDzX5i6/eylStgOudw==
X-Received: by 2002:a05:6a00:a27:b0:6bf:83d1:da6e with SMTP id p39-20020a056a000a2700b006bf83d1da6emr1955818pfh.22.1697974321053;
        Sun, 22 Oct 2023 04:32:01 -0700 (PDT)
Received: from swarup-virtual-machine.localdomain ([171.76.85.44])
        by smtp.gmail.com with ESMTPSA id f125-20020a625183000000b0065a1b05193asm4649833pfb.185.2023.10.22.04.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 04:32:00 -0700 (PDT)
From: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Cc: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Subject: [PATCH] selftests:net change ifconfig with ip command
Date: Sun, 22 Oct 2023 17:01:48 +0530
Message-Id: <20231022113148.2682-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change ifconfig with ip command,
on a system where ifconfig is
not used this script will not
work correcly.

Test result with this patchset:

sudo make TARGETS="net" kselftest
....
TAP version 13
1..1
 timeout set to 1500
 selftests: net: route_localnet.sh
 run arp_announce test
 net.ipv4.conf.veth0.route_localnet = 1
 net.ipv4.conf.veth1.route_localnet = 1
 net.ipv4.conf.veth0.arp_announce = 2
 net.ipv4.conf.veth1.arp_announce = 2
 PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84)
  bytes of data.
 64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.038 ms
 64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.068 ms
 64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.068 ms
 64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.068 ms
 64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.068 ms

 --- 127.25.3.14 ping statistics ---
 5 packets transmitted, 5 received, 0% packet loss, time 4073ms
 rtt min/avg/max/mdev = 0.038/0.062/0.068/0.012 ms
 ok
 run arp_ignore test
 net.ipv4.conf.veth0.route_localnet = 1
 net.ipv4.conf.veth1.route_localnet = 1
 net.ipv4.conf.veth0.arp_ignore = 3
 net.ipv4.conf.veth1.arp_ignore = 3
 PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84)
  bytes of data.
 64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.032 ms
 64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.065 ms
 64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.066 ms
 64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.065 ms
 64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.065 ms

 --- 127.25.3.14 ping statistics ---
 5 packets transmitted, 5 received, 0% packet loss, time 4092ms
 rtt min/avg/max/mdev = 0.032/0.058/0.066/0.013 ms
 ok
ok 1 selftests: net: route_localnet.sh
...

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
---
 tools/testing/selftests/net/route_localnet.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/route_localnet.sh b/tools/testing/selftests/net/route_localnet.sh
index 116bfeab72fa..3ab9beb4462c 100755
--- a/tools/testing/selftests/net/route_localnet.sh
+++ b/tools/testing/selftests/net/route_localnet.sh
@@ -18,8 +18,10 @@ setup() {
     ip route del 127.0.0.0/8 dev lo table local
     ip netns exec "${PEER_NS}" ip route del 127.0.0.0/8 dev lo table local
 
-    ifconfig veth0 127.25.3.4/24 up
-    ip netns exec "${PEER_NS}" ifconfig veth1 127.25.3.14/24 up
+    ip a add 127.25.3.4/24 dev veth0
+    ip link set dev veth0 up
+    ip netns exec "${PEER_NS}" ip a add 127.25.3.14/24 dev veth1
+    ip netns exec "${PEER_NS}" ip link set dev veth1 up
 
     ip route flush cache
     ip netns exec "${PEER_NS}" ip route flush cache
-- 
2.34.1


