Return-Path: <netdev+bounces-132936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1AE993CD3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 04:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C291F225B4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AD11EA85;
	Tue,  8 Oct 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="rkhzLX1q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7921E535
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728354461; cv=none; b=gkK0lIIbs6Sn3TVsPf1pmX+ldg4dz+EnQxDfXhULwH00khm8RU4nORjBG5SpBLfia35DBYZ+oCPu9dSuPhBQAHoOxx6BuYCa5fr1ZiYCtu0eB/YgOzuqdV8awrWZ0lj9XqMor2AvWHgTdymDsXzAluIaV+annw8hcUPSS/adZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728354461; c=relaxed/simple;
	bh=l8ndyz3RQaEsFJHJYlXGVVJLYKHeF1rnK0WUWDY7nSU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kGMwOh7MnSPGLj8n/SdmPz1pT8sO3CkeutRLzX2R1VFwWhCcNXB7Y6k5uJ3rKIpWR7Bb5rhpeU3f3hif23V2YR2vBtSarC4EhTSGjeArLO/8qiPm9oxYVzJ+QzOqYOHYicPtefVhIypfsZSW/aqwIDmL3Uc6De543LnGy547HiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=rkhzLX1q; arc=none smtp.client-ip=209.85.166.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f195.google.com with SMTP id e9e14a558f8ab-3a363feabc6so19461545ab.1
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 19:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1728354459; x=1728959259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXG6JQjHvw8er20xtShXcOScOW4eWRr0M+PpnzpPqAI=;
        b=rkhzLX1q2Q87OqNocQTSemiIIZ471KYiOwyokg5sU+ZjXI3Jbl6KZroRZW0wp/b00N
         T6TtWCvqhWWS6mO703x+TaYrip7XUT60/nLdHuu1VBhZTsTwpKSTX6XpLfOl511nbFOg
         DXkfdyX0jKUhblBO1U38fM3HMuSlKvsR5XsJwTm1P6KGaoWDHAoNcz6FufB/vWp+iaoD
         JjMRVXSSvWLIfoe3JRs76VYwJnE4nVHyV0Xm5gb6k9ixQfs1F3TjfwDGtaVSewvSIc/l
         SmJmsW2DLtBjgLr3NvXLOJge52osBgYDVKVEzfV4/QcgsQX/K2UOF5YNBgx2llTP5rPs
         sBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728354459; x=1728959259;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXG6JQjHvw8er20xtShXcOScOW4eWRr0M+PpnzpPqAI=;
        b=eiLcMUXbkK/zmtpnjTdRDGCn9BT7rgyIwkNNlczF3N/Zh9A9Ef5w+jMirXWtuUGMem
         MChYXEmNhHH9u9LkYWyEMpvwJUTEkVhmr9UD7joK4sXqjTVU5bhEyDh6LdbRwVVm0d4x
         7ORLLc+NQC0wgTMM68ij9ftUPQDMpghhIO75YSxCIWbhuXGT+16hakZ+07Oel5NyDmGD
         oSV9k95YV3cpaTtepuVES56ch49t03V4cFQTg4hrxUchn3iG9ghzecg/MDlNdJE2nAVv
         lBdN2Z+jnF2WQwmgNuWOxmABB8pq/I18qr4iQRvepASbMRgGGZTa38LhUxTQclFfalo9
         dDuA==
X-Gm-Message-State: AOJu0YzTVCPoj97eJwUlSzg1i8lPfPnNoAN+pd2wILmKIpHgg11wixnH
	qjcknJqW25aAmgUxJZjv0s1NkZ6IJRg2GBmfhjRmcjOLUUKOZivKy6P6BxM2YyFNf29VrjQEju1
	wJNhSlg==
X-Google-Smtp-Source: AGHT+IGaUtB7PSLdAn7KrJ4oucdF64tDcRHURpLUrOxXJwE3X+W0t87oxYYeoWZu+QFSS1rpZrN3qw==
X-Received: by 2002:a05:6e02:1d0e:b0:39f:5def:a23d with SMTP id e9e14a558f8ab-3a38af1e5demr12435145ab.5.1728354458633;
        Mon, 07 Oct 2024 19:27:38 -0700 (PDT)
Received: from kf-ir16 ([2607:fb91:11a8:8b87:1343:77ca:e075:fe49])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6eb86f45sm1428399173.78.2024.10.07.19.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 19:27:38 -0700 (PDT)
Date: Mon, 7 Oct 2024 21:27:35 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, edumazet@google.com, Jason@zx2c4.com,
 davem@davemloft.net, adrelanos@kicksecure.com
Subject: [PATCH] net: add option for using randomized TCP ISNs
Message-ID: <20241007212735.460dc0eb@kf-ir16>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This patch is not yet ready for merging into the kernel. While there's
nothing in particular wrong with it that would keep it from being
usable in its current state (that I'm aware of), I'm conscious of the
fact that we are well past the merge window and am posting this
primarily for feedback. There's also some testing code left over to
make it easy for people to test the patch, as well as detailed
instructions on how to test it.

The current algorithm for generating TCP Initial Sequence Numbers
(ISNs) is to take data about the TCP connection, hash it with a
one-time generated key and SipHash, then add a system timer value to
it. This algorithm has the drawback of exposing relative timestamps to
servers. There are both known[1] and suspected[2] timing attacks that
can be carried out when relative timestamp values are used, and while
these may not be a concern for most, they are potentially concerning to
some subset of Linux users. Currently the only good solution for issues
who are worried about this is to use a third-party, out-of-tree kernel
module[3] that hot-patches the `secure_tcpv6_seq` and `secure_tcp_seq`
functions.

While the TCP protocol may suffer slight performance issues when ISNs
are not managed in an orderly fashion like the kernel currently does,
in practice it appears to not cause substantial issues in a desktop use
case. (I have not yet benchmarked this, but the author of [2] seems to
have not found the performance impact concerning, and whatever impact
there was, was unnoticeable for me in my limited testing.) Therefore it
is likely practical to simply use entirely random 32-bit numbers for
TCP ISNs, which is what this patch allows. Due to the possible
performance impact, this is not something that would be appropriate to
apply to all users of the Linux kernel, and so it is instead
implemented as an optional feature that can be toggled with a kernel
parameter.

To make testing easier, there are a couple of lines marked as "TODO:
Remove before merge" that print every ISN that is generated to
the kernel log. To test:

* Apply this patch to Linux 6.12-rc2, build it, and boot from it. Do
  not add `tcp_rand_isn` to the kernel command line.
* Create two Python scripts, "hammer.py" and "anvil.py". The content of
  these scripts should be as follows:

      hammer.py:
      #!/usr/bin/python3
      import socket
      s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
      s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
      s.bind(('', 4434))
      s.connect(("127.0.0.1", 7899))
      s.close()

      anvil.py:
      #!/usr/bin/python3
      import socket
      import time
      s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
      s.bind(("127.0.0.1", 7899))
      s.listen(100)
      while True:
          conn, addr = s.accept()
          data = conn.recv(1024)
          print(repr(data))
          time.sleep(0.001)
          conn.close()

* In one terminal, run `tail -f` on your logfile (for systemd-based
  distros use `journalctl -f`) to observe the kernel's notifications
  about generated ISNs.
* In a second terminal, run `python3 anvil.py`. It will block.
* In a third terminal, run `while true; do python3 hammer.py; done`.
  This will repeatedly establish a connection to the anvil.py server,
  then disconnect. The connections will always be established from the
  same source port. You should see a flood of ISN notifications in your
  kernel log. The number shown should constantly increment by small
  amounts.
* Reboot with the `tcp_rand_isn` kernel parameter, then run anvil.py
  and hammer.py as shown above while watching the syslog. You should
  see a flood of ISN notifications in your kernel log, and the number
  shown should change unpredictably.

[1]: https://murdoch.is/papers/ccs06hotornot.pdf
[2]: https://bitguard.wordpress.com/2019/09/03/an-analysis-of-tcp-secure-sn-generation-in-linux-and-its-privacy-issues/
[3]: https://github.com/0xsirus/tirdad/

Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
---
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..26472137086c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6645,6 +6645,16 @@
 			neutralize any effect of /proc/sys/kernel/sysrq.
 			Useful for debugging.
 
+	tcp_rand_isn
+			[NET]
+			Enables randomized TCP Initial Sequence Number (ISN)
+			generation. When disabled, the kernel will use an
+			algorithm for ISN generation that provides better
+			performance at the cost of potentially leaking timing
+			information over the network. When enabled, TCP ISNs
+			will be randomly generated, providing better security
+			with a potential performance hit.
+
 	tcpmhash_entries= [KNL,NET]
 			Set the number of tcp_metrics_hash slots.
 			Default value is 8192 or 16384 depending on total
diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
index b0ff6153be62..9982e8fcd679 100644
--- a/net/core/secure_seq.c
+++ b/net/core/secure_seq.c
@@ -22,6 +22,14 @@
 static siphash_aligned_key_t net_secret;
 static siphash_aligned_key_t ts_secret;
 
+static bool tcp_rand_isn;
+static int __init parse_tcp_rand_isn(char *arg)
+{
+	tcp_rand_isn = true;
+	return 0;
+}
+early_param("tcp_rand_isn", parse_tcp_rand_isn);
+
 #define EPHEMERAL_PORT_SHUFFLE_PERIOD (10 * HZ)
 
 static __always_inline void net_secret_init(void)
@@ -76,23 +84,33 @@ EXPORT_SYMBOL(secure_tcpv6_ts_off);
 u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
 		     __be16 sport, __be16 dport)
 {
-	const struct {
-		struct in6_addr saddr;
-		struct in6_addr daddr;
-		__be16 sport;
-		__be16 dport;
-	} __aligned(SIPHASH_ALIGNMENT) combined = {
-		.saddr = *(struct in6_addr *)saddr,
-		.daddr = *(struct in6_addr *)daddr,
-		.sport = sport,
-		.dport = dport
-	};
 	u32 hash;
 
-	net_secret_init();
-	hash = siphash(&combined, offsetofend(typeof(combined), dport),
-		       &net_secret);
-	return seq_scale(hash);
+	if (tcp_rand_isn) {
+		get_random_bytes(((char *)&hash), sizeof(hash));
+	} else {
+		const struct {
+			struct in6_addr saddr;
+			struct in6_addr daddr;
+			__be16 sport;
+			__be16 dport;
+		} __aligned(SIPHASH_ALIGNMENT) combined = {
+			.saddr = *(struct in6_addr *)saddr,
+			.daddr = *(struct in6_addr *)daddr,
+			.sport = sport,
+			.dport = dport
+		};
+
+		net_secret_init();
+		hash = siphash(&combined, offsetofend(typeof(combined),
+						      dport),
+			       &net_secret);
+		hash = seq_scale(hash);
+	}
+
+	// TODO: Remove before merge
+	printk("secure_seq: tcpv6 isn: %u", hash);
+	return hash;
 }
 EXPORT_SYMBOL(secure_tcpv6_seq);
 
@@ -138,11 +156,19 @@ u32 secure_tcp_seq(__be32 saddr, __be32 daddr,
 {
 	u32 hash;
 
-	net_secret_init();
-	hash = siphash_3u32((__force u32)saddr, (__force u32)daddr,
-			    (__force u32)sport << 16 | (__force u32)dport,
-			    &net_secret);
-	return seq_scale(hash);
+	if (tcp_rand_isn) {
+		get_random_bytes(((char *)&hash), sizeof(hash));
+	} else {
+		net_secret_init();
+		hash = siphash_3u32((__force u32)saddr, (__force u32)daddr,
+				    (__force u32)sport << 16 | (__force u32)dport,
+				    &net_secret);
+		hash = seq_scale(hash);
+	}
+
+	// TODO: Remove before merge
+	printk("secure_seq: tcp isn: %u", hash);
+	return hash;
 }
 EXPORT_SYMBOL_GPL(secure_tcp_seq);
 

