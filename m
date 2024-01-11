Return-Path: <netdev+bounces-63127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D611382B4DB
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FEBDB23302
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D40454BC8;
	Thu, 11 Jan 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="JzV6ieP2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C85053E19
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso4337916a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 10:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704998704; x=1705603504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8BdktxS3T9FnT+KN6r57I70iQkEv8DZXhJrz4qu/0s=;
        b=JzV6ieP2otY+J8o9qYfKaOiZ37ZioBa7R45rXrGXV1BsnlA4PW1w09ckUG4lfNmS/p
         wDFLcDUKIXSk3976aJat4AVeCkE95AgixBWiRPpbViW/UHYUa9BXqpx8sOhoJCisQ2Oh
         gjbYvs98OGzKcnbg23kb9BsXJE+ZvK5Sxvq8709oqQsxnWY2C+1RfpLkKZDNfMAlHVB2
         CVtN6f9N6yj8AWn/+mSDEFFU2JR9TUdk7he9f3CFlckf815l2i/NipmcWJQVDt1yKSEW
         tcA7gYAtf1RNu+0OTjpNNnScNqor+YsR2kkl8mCsofd3MpSfE0Nl8nov01yjFiFJglL/
         3TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998704; x=1705603504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8BdktxS3T9FnT+KN6r57I70iQkEv8DZXhJrz4qu/0s=;
        b=ZcvuKiHnsFccHuRwhKRJXFpWine+AUTmdaheAAh1UYI4O+SN/2VemrVNu8zGJ36fSL
         Xk3DPq5SiWti3nijZPzerlfSE69fMlO/sv0Q6xz92UF8aIkVqQmHcPNjLQziYEvfw63r
         4aXYiqNuS7FjjygFEWmvfRgX36LzE0vq+8VpVY9gFZgZft3Cl5pMyFfFlgvaUAWjm+0f
         zmkymSTw2LSjBtGxdx/yxouJCcBQvDzfUt1KLgZdlnmefEU2+bfPLkMEcMKKdmunZ18s
         22XISbKD9PSqCBn7ZnDpz7n+u+R1etTkaFfGFl0Yw0PgZCVdus6Iuil3gMTaGC62T0io
         AEHw==
X-Gm-Message-State: AOJu0YxWFf3HKE/FRhuim3ouW+EYlXd4VLLqFXmPcx/TWCNXGGdMR9x2
	cS4M6N9o3D1N2DOl/PU1vLejrNgYsPdhLJajhTppC47DLCKAmg==
X-Google-Smtp-Source: AGHT+IGVNZ/KyFooojyH+QMGKx61wTo+C4dF8eeFYzH0BIb1MICs3+/dj2kp70Ut73/rUN9L3TRyvA==
X-Received: by 2002:a05:6a20:7503:b0:199:dab1:8b6e with SMTP id r3-20020a056a20750300b00199dab18b6emr236816pzd.39.1704998703598;
        Thu, 11 Jan 2024 10:45:03 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78083000000b006d9b4303f9csm1513460pff.71.2024.01.11.10.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 10:45:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 1/4] man: get rid of doc/actions/mirred-usage
Date: Thu, 11 Jan 2024 10:44:08 -0800
Message-ID: <20240111184451.48227-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111184451.48227-1-stephen@networkplumber.org>
References: <20240111184451.48227-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only bit of information not already on the man page
is some of the limitations.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/actions/mirred-usage | 164 ---------------------------------------
 man/man8/tc-mirred.8     |   8 ++
 2 files changed, 8 insertions(+), 164 deletions(-)
 delete mode 100644 doc/actions/mirred-usage

diff --git a/doc/actions/mirred-usage b/doc/actions/mirred-usage
deleted file mode 100644
index 482ff66d6aaf..000000000000
--- a/doc/actions/mirred-usage
+++ /dev/null
@@ -1,164 +0,0 @@
-
-Very funky action. I do plan to add to a few more things to it
-This is the basic stuff. Idea borrowed from the way ethernet switches
-mirror and redirect packets. The main difference with say a vannila
-ethernet switch is that you can use u32 classifier to select a
-flow to be mirrored. High end switches typically can select based
-on more than just a port (eg a 5 tuple classifier). They may also be
-capable of redirecting.
-
-Usage:
-
-mirred <DIRECTION> <ACTION> [index INDEX] <dev DEVICENAME>
-where:
-DIRECTION := <ingress | egress>
-ACTION := <mirror | redirect>
-INDEX is the specific policy instance id
-DEVICENAME is the devicename
-
-Direction:
-- Ingress is not supported at the moment. It will be in the
-future as well as mirror/redirecting to a socket.
-
-Action:
-- Mirror takes a copy of the packet and sends it to specified
-dev ("port" in ethernet switch/bridging terminology)
-- redirect
-steals the packet and redirects to specified destination dev.
-
-What NOT to do if you don't want your machine to crash:
-------------------------------------------------------
-
-Do not create loops!
-Loops are not hard to create in the egress qdiscs.
-
-Here are simple rules to follow if you don't want to get
-hurt:
-A) Do not have the same packet go to same netdevice twice
-in a single graph of policies. Your machine will just hang!
-This is design intent _not a bug_ to teach you some lessons.
-
-In the future if there are easy ways to do this in the kernel
-without affecting other packets not interested in this feature
-I will add them. At the moment that is not clear.
-
-Some examples of bad things NOT to do:
-1) redirecting eth0 to eth0
-2) eth0->eth1-> eth0
-3) eth0->lo-> eth1-> eth0
-
-B) Do not redirect from one IFB device to another.
-Remember that IFB is a very specialized case of packet redirecting
-device. Instead of redirecting it puts packets at the exact spot
-on the stack it found them from.
-Redirecting from ifbX->ifbY will actually not crash your machine but your
-packets will all be dropped (this is much simpler to detect
-and resolve and is only affecting users of ifb as opposed to the
-whole stack).
-
-In the case of A) the problem has to do with a recursive contention
-for the devices queue lock and in the second case for the transmit lock.
-
-Some examples:
--------------
-
-1) Mirror all packets arriving on eth0 to be sent out on eth1.
-You may have a sniffer or some accounting box hooked up on eth1.
-
----
-tc qdisc add dev eth0 ingress
-tc filter add dev eth0 parent ffff: protocol ip prio 10 u32 \
-match u32 0 0 flowid 1:2 action mirred egress mirror dev eth1
----
-
-If you replace "mirror" with "redirect" then not a copy but rather
-the original packet is sent to eth1.
-
-2) Host A is hooked  up to us on eth0
-
-# redirect all packets arriving on ingress of lo to eth0
----
-tc qdisc add dev lo ingress
-tc filter add dev lo parent ffff: protocol ip prio 10 u32 \
-match u32 0 0 flowid 1:2 action mirred egress redirect dev eth0
----
-
-On host A start a tcpdump on interface connecting to us.
-
-on our host ping -c 2 127.0.0.1
-
-Ping would fail since all packets are heading out eth0
-tcpudmp on host A would show them
-
-if you substitute the redirect with mirror above as in:
-tc filter add dev lo parent ffff: protocol ip prio 10 u32 \
-match u32 0 0 flowid 1:2 action mirred egress mirror dev eth0
-
-Then you should see the packets on both host A and the local
-stack (i.e ping would work).
-
-3) Even more funky example:
-
-#
-#allow 1 out 10 packets on ingress of lo to randomly make it to the
-# host A (Randomness uses the netrand generator)
-#
----
-tc filter add dev lo parent ffff: protocol ip prio 10 u32 \
-match u32 0 0 flowid 1:2 \
-action drop random determ ok 10\
-action mirred egress mirror dev eth0
----
-
-4)
-# for packets from 10.0.0.9 going out on eth0 (could be local
-# IP or something # we are forwarding) -
-# if exceeding a 100Kbps rate, then redirect to eth1
-#
-
----
-tc qdisc add dev eth0 handle 1:0 root prio
-tc filter add dev eth0 parent 1:0 protocol ip prio 6 u32 \
-match ip src 10.0.0.9/32 flowid 1:16 \
-action police rate 100kbit burst 90k ok \
-action mirred egress mirror dev eth1
----
-
-A more interesting example is when you mirror flows to a dummy device
-so you could tcpdump them (dummy by defaults drops all packets it sees).
-This is a very useful debug feature.
-
-Lets say you are policing packets from alias 192.168.200.200/32
-you don't want those to exceed 100kbps going out.
-
----
-tc qdisc add dev eth0 handle 1:0 root prio
-tc filter add dev eth0 parent 1: protocol ip prio 10 u32 \
-match ip src 192.168.200.200/32 flowid 1:2 \
-action police rate 100kbit burst 90k drop
----
-
-If you run tcpdump on eth0 you will see all packets going out
-with src 192.168.200.200/32 dropped or not (since tcpdump shows
-all packets being egressed).
-Extend the rule a little to see only the packets making it out.
-
----
-tc qdisc add dev eth0 handle 1:0 root prio
-tc filter add dev eth0 parent 1: protocol ip prio 10 u32 \
-match ip src 192.168.200.200/32 flowid 1:2 \
-action police rate 10kbit burst 90k drop \
-action mirred egress mirror dev dummy0
----
-
-Now fire tcpdump on dummy0 to see only those packets ..
-tcpdump -n -i dummy0 -x -e -t
-
-Essentially a good debugging/logging interface (sort of like
-BSDs speacialized log device does without needing one).
-
-If you replace mirror with redirect, those packets will be
-blackholed and will never make it out.
-
-cheers,
-jamal
diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
index 38833b452d92..71f3c93df472 100644
--- a/man/man8/tc-mirred.8
+++ b/man/man8/tc-mirred.8
@@ -94,6 +94,14 @@ interface, it is possible to send ingress traffic through an instance of
 .EE
 .RE
 
+.SH LIMITIATIONS
+It is possible to create loops which will cause the kernel to hang.
+Do not have the same packet go the same netdevice twice in a single graph of policies.
+.PP
+Do not redirect for one IFB device to another.
+IFB is a very specialized case of packet redirecting device.
+Redirecting from ifbX->ifbY will cause all packets to be dropped.
+
 .SH SEE ALSO
 .BR tc (8),
 .BR tc-u32 (8)
-- 
2.43.0


