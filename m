Return-Path: <netdev+bounces-163315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE6A29E90
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB640165706
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022341AAC;
	Thu,  6 Feb 2025 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="lrdJzxr9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BB1B7F4
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738807038; cv=none; b=t/mYtrYgBajLebHOYWufUAMkRCQbszdeHVsDAaHjSYiuajFFNRXa2Rxd8x+utYdECVbCskcYLRilC25iSo4/Bc45lfrFsQ/P6BPMcN4KefFUYUK0VeFtS4k9nLZURmC4QDN3d1ueJr4K93mA2oEd9UO6IJLitxqVNes/UC29ZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738807038; c=relaxed/simple;
	bh=G+m6gXSWHlwEkZVgpCeMIOkavhA/IGyHQ8xcGu+aQ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/t8VxfqPr9CIqjSXV02/AHJl29D2Tp5J8j+6ndAUv1QekZ7Xb2sj4FgayVFGwNQp7CrlvcLTSvqZsd49nyW+W+7KmiPQDQv/Eb4E0XeZjQJLTGg6bmCLAepQ7kOSmOX8/8NZUMCPuLRUDImkAoORinqcR8nykGgi0M+1AVArHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=lrdJzxr9; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso3329465ab.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 17:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1738807034; x=1739411834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymtJ1d+Lp5XPp8rPQf+GKJG0Zon1c5xsrQMQ4duRKHQ=;
        b=lrdJzxr9fJw2YI1T3z+A9eKupQL8Y/W5b3Kp8l0M58QS3p7LZCFJNIVxDgo8q/CQJB
         TDQwSoOLiOa3VPVG7HNkJlI/AE80fyeUUmZdkQRPbr+x0ADnGwn/aDNvDNEtp5hj0Z/d
         YbcIJzpKOifNbLTuGxY24+2Q0NSVl9faIE3odjDRGaqxFMcbZ3jPYe9YIHTvDsntj/nD
         xrP+MY79LaKfHJBh+kFAjlV8Sej0gteZmSb7xzICtd9Q11Hu21yBsmlggnfSDBBjSkqY
         sUk+jQhq6xnLAzufA7Vj24SDLXzx6odk1vKE/d8/xhQeyhSqYJ5W9ppC4Vm6LObL87ZY
         zzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738807034; x=1739411834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymtJ1d+Lp5XPp8rPQf+GKJG0Zon1c5xsrQMQ4duRKHQ=;
        b=srPGT86t7r3PJct4TNJPNgV90HBWLo8qQBSXrtk5rd5tDr5WCmB3K5OKJ9kQQky87K
         WHKpPsYHInic8AoJnlkP9QW0DNFwvIrpR/NxVhQSV2WZzDx2/5YgYeoc2VPu9JwjpEC4
         0Ay1ZIob/4KNYBhh9GorulL5UzXr6mJBy7CjI85ZvniLsWreO+gv8ZMUNqBvCbXsUXCL
         OE4sh3yYGuEY/IdabCVlS5PN0DfzY6JljSN/uaNGMND6fIQ27wTAyhEFrGH6id6aElOS
         jD/tjMwyTdSCZJeQYsls+IIGGT8V87g1Rycxs9ABEtXni7z1WTh/1uIjUjyYs78TNQYH
         fjxg==
X-Gm-Message-State: AOJu0Yz1CNXohroDrHLDeN3Eyan3tIqONca7TvgrzihuBG8hkyZiTAPU
	bjP31MWBKJbumnEQZt9Uj58ri+yyBRkgrtnB9wWhwkW+YBkdgvVg/K4LuwhTf6h/Ige56dOwthP
	eMIM=
X-Gm-Gg: ASbGncuKu4ze02FaAqGt4CLhlwK4yXVidzzQuuOK7ZRsZhNyXAKHD1VWAhwQSw+T3x3
	assUFORpqbV5cdy8rbNDP3V47Q0HsQpbtgg4cNcmZq1fsmREX+3IUo3OMPE4tSS9UPGSRtTX+dz
	kOCh6/gF2e++r9MLwI+zjZu0pjXCaZ+51Nu7url7xRJYbN10H22Wpq/Z1du5DI0M7A/R2i2JmkO
	KRW5jhcnU4eb94v2PPucHz+1WU1EeNoZFQJ61q+8Z5zr8MlNyPf3COHaZ64Zj4ZqDWlEvRFzyMq
	4lzxrQ6+SZAmcTpq1dSm7+4y3j93om/eGRflFLTS
X-Google-Smtp-Source: AGHT+IEhNim5yGJ7cIj6+Ci/dS+KvjdvqyQHYF9WCcfgd24aA8y+c4Nk0+l7mcQ9xBC712+nQAbEmw==
X-Received: by 2002:a05:6e02:12ec:b0:3d0:4b0d:b22e with SMTP id e9e14a558f8ab-3d04f43459cmr46430275ab.10.1738807034484;
        Wed, 05 Feb 2025 17:57:14 -0800 (PST)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccfae7cd5sm54076173.104.2025.02.05.17.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 17:57:14 -0800 (PST)
From: Will Hawkins <hawkinsw@obs.cr>
To: netdev@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH net] icmp: MUST silently discard certain extended echo requests
Date: Wed,  5 Feb 2025 20:57:10 -0500
Message-ID: <20250206015711.2627417-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per RFC 8335 Section 4,
"""
When a node receives an ICMP Extended Echo Request message and any of
the following conditions apply, the node MUST silently discard the
incoming message:

...
- The Source Address of the incoming message is not a unicast address.
- The Destination Address of the incoming message is a multicast address.
"""

Packets meeting the former criteria do not pass martian detection, but
packets meeting the latter criteria must be explicitly dropped.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---

I hope that this small change is helpful. There is code that already
prevents the kernel from transmitting packets that violate the latter
criteria, but I read the RFC as saying that these rogue packets must
be dropped before even being handled.

I have a history of Kernel contribution but I do so infrequently. I
have tried very hard to follow all the proper protocol. Forgive me
if I messed up. Thank you for all the work that you do maintaining
_the_ most important Kernel subsystem!

 net/ipv4/icmp.c | 16 ++++++++++++++++
 net/ipv6/icmp.c | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 963a89ae9c26..081264b6e9eb 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1241,6 +1241,22 @@ int icmp_rcv(struct sk_buff *skb)
 
 	/* Check for ICMP Extended Echo (PROBE) messages */
 	if (icmph->type == ICMP_EXT_ECHO) {
+		/*
+		 *	RFC 8335: 4 When a node receives [a message] and any of
+		 *	  the following conditions apply, the node MUST silently
+		 *	  discard the incoming message:
+		 *	  ...
+		 *	  - The Source Address of the incoming message is not
+		 *	    a unicast address.
+		 *	  - The Destination Address of the incoming message is a
+		 *	    multicast address.
+		 *	(Former constraint is handled by martian detection.)
+		 */
+		if (rt->rt_flags & RTCF_MULTICAST) {
+			reason = SKB_DROP_REASON_INVALID_PROTO;
+			goto error;
+		}
+
 		/* We can't use icmp_pointers[].handler() because it is an array of
 		 * size NR_ICMP_TYPES + 1 (19 elements) and PROBE has code 42.
 		 */
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 071b0bc1179d..76498a37e465 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -738,6 +738,21 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	    net->ipv6.sysctl.icmpv6_echo_ignore_multicast)
 		return reason;
 
+	/*
+	 *	RFC 8335: 4 When a node receives [a message] and any of
+	 *	  the following conditions apply, the node MUST silently
+	 *	  discard the incoming message:
+	 *	  ...
+	 *	  - The Source Address of the incoming message is not
+	 *	    a unicast address.
+	 *	  - The Destination Address of the incoming message is a
+	 *	    multicast address.
+	 *	(Former constraint is handled by martian detection.)
+	 */
+	if (icmph->icmp6_type == ICMPV6_EXT_ECHO_REQUEST &&
+	    ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr))
+		return reason;
+
 	saddr = &ipv6_hdr(skb)->daddr;
 
 	acast = ipv6_anycast_destination(skb_dst(skb), saddr);
-- 
2.47.1


