Return-Path: <netdev+bounces-278857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECGZOrLd32nXZgAAu9opvQ
	(envelope-from <netdev+bounces-278857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:49:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E9E407338
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F423011BFC
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085182D661C;
	Wed, 15 Apr 2026 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odJRrvOh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9123183C
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278900; cv=none; b=PmbB5kTr2EyY4aCDlkrQewfHjte2ifJMyz8kruWrnVcnjTMERQHVihs2o+uzipAxE5WyjtiyqFLHUfK99V/8JzEAek8gaukwdWi2UAtZRb0sv93mUydDIdS2hbal82aiG6u3vQAcGfE7aH2xjUZ2hJ6hHkaX0paNRPBHZTXFj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278900; c=relaxed/simple;
	bh=acK9LkwVJYGBHLimrLDGviQpqFjShAknFwnK7mICTZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=REg+xbdm5eQAh8GC0ObPUQ/GFh8JpolbceMCJ7Q7au++ksrmDFLQyq4mqkMDBRjnBFfM1pyEBg5mfULyrYGEGcb5oNLtcpWSIYftP7oPwu7ODX7myugT2Xc2SXFUbkf50RPkFTl68NmjT+3jggQ0noYGsTesub782A1z1btKjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odJRrvOh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9c9d03524cso901209766b.3
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 11:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278897; x=1776883697; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8AKpNB+fNRgXfs+tQXp/OXvp8qWOWVTBMYp3n9lbAA=;
        b=odJRrvOhVsi38rwjRAHirsIK9+n548bCwPY2RImlOkWbAG2veD2bICU2zaD8JlRTYn
         Y15bWCAdGg6EJJQBTaxF89pe28HpyCHqcgg+/GZNn4ZUV0u9j5Vhq9dPOwCXEhFdSDN/
         kgbaK596UO0/dv0u+TNvAdgRsi85FETXFkwwEc2McqroMbIwOz9x5KFlPMNJm/AewCn6
         HVGDaY+Q2yG+3ViFe+Yo9ml1FIjSxgXRHWCYe4FBn908GMJihPIEWqw1IuLjZRbkpckv
         jabydnAt4wj8s3JuXVTR5PQasg1j6KCjDh0/50Xxyejk10agrSB/K42Mn1GYKlN34nwR
         52ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278897; x=1776883697;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8AKpNB+fNRgXfs+tQXp/OXvp8qWOWVTBMYp3n9lbAA=;
        b=TQD8PJC5AlhvonHg72S2tK/2LSV9vw8xhabAlfEsBUFLYYKgxVd3WJreDZeOAqnVkp
         C7in3J0+f3iCC+df+vmrQK3MqA8Y0QPKm43fzv1HpvMp1r1nU/y8x/9ly1KYvvXMF5DF
         J9Rfm9Ten1nnyd+mPTqpFjmlkb0+5NoSR6az6N5h4N7PWinSn6Wd1bn1YJ4XoL24s8Xq
         sMVd7/X3uM1/hNf7WJdqkgczl4E/gPwuDYqqzg8ysGsPkBOb2SaZ4HJx49UT0PDKvrzU
         XzYTWd1uwRXvMoWN906ZRbTxzPbL0QkgRWUwq+ihGpOkoA6tLmshQQQOtzevTqO2stD2
         l0UA==
X-Gm-Message-State: AOJu0YxqW/5iS9274tfaZ+J6e9V5ZEJR/HTo+pJF/GbKTWUN9S+JQU8v
	ceQ231yVDotMZXUdBYn9EgmqV4t6kTtkvcsYOJmUEP51bcnoV+JUrHYCy5WGaEaj
X-Gm-Gg: AeBDies7HDZXosgp990OZVqy8RhrYlllu3wKZZ8sJ0a5UB6cLQFz2gbei8kqyHVELTj
	ewjiaWrjjn053p83QNrfUf2o6y/xvOtGhhXJwMD5MVpVclDsYYjk5uIKYIbL39Iq99DkzJ0lQJm
	84xnEfnf1xNxgjSg0A8FU/SJTS9FoTr1saVivyIVx6nlQjyhl1iz1vQnfnHCDxQ9tLkia0U+pce
	BSj/QX/bEBcZyHoR19pvu/CW+TduCjFXO+hb+ZsjCrAbgXWpSkb1vZzUpb7MYtikfWDZZemi+x+
	sDjnofHr6sVfVE/9HweJzqVjZJ5AuhsEOAkxY7HzNipaldHPLY+tewaDzE2vBFHC/4ruX6vtHoZ
	WWzN9M+TzJC7kY5/PmHak4mh8wYcj0B6+R9eyo4HmHp6uOfCQ7tOc8MLJiL5qGySXNV/+Tw4ZcZ
	bjtvkk9soqrfsUcwgCvrrnZfcbfi/eVzFN2iMjNA5noXBGOTwc/anW4c23n4L4cfEZM1tXzdE9a
	kk=
X-Received: by 2002:a17:907:9484:b0:b9f:18df:8821 with SMTP id a640c23a62f3a-b9f18df897bmr407715466b.48.1776278897159;
        Wed, 15 Apr 2026 11:48:17 -0700 (PDT)
Received: from dau-home-pc ([89.222.123.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67237fff72dsm657388a12.22.2026.04.15.11.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:48:16 -0700 (PDT)
Date: Wed, 15 Apr 2026 21:48:10 +0300
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH net-next v2 0/2] udp: fix FOU/GUE over multicast
Message-ID: <ad_dal164gVmImWl@dau-home-pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-278857-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fou_mcast_encap.py:url]
X-Rspamd-Queue-Id: 98E9E407338
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

UDP encapsulation (FOU, GUE) has never worked correctly with multicast
destination addresses. When a FOU-encapsulated packet arrives at a
multicast address, it enters __udp4_lib_mcast_deliver() which calls
consume_skb() on packets that need resubmission to the inner protocol
handler, silently dropping them instead.

The unicast delivery path and the GSO segmentation path both handle
this correctly, but the multicast path was never updated to support
UDP encapsulation resubmit.

This causes silent packet loss for FOU/GRETAP tunnels configured with
multicast remote addresses. The loss ratio depends on the early demux
cache hit rate - packets that hit early demux bypass the multicast path
and work correctly, masking the issue.

Reproducing the issue:

  ip netns add ns_a && ip netns add ns_b
  ip link add veth0 type veth peer name veth1
  ip link set veth0 netns ns_a && ip link set veth1 netns ns_b

  ip -n ns_a addr add 10.0.0.1/24 dev veth0 && ip -n ns_a link set veth0 up
  ip -n ns_b addr add 10.0.0.2/24 dev veth1 && ip -n ns_b link set veth1 up

  # Multicast routes
  ip -n ns_a route add 239.0.0.0/8 dev veth0
  ip -n ns_b route add 239.0.0.0/8 dev veth1

  # Disable early demux to expose the issue (otherwise it's partially masked)
  ip netns exec ns_b sysctl -w net.ipv4.ip_early_demux=0

  # Join multicast group on receiver
  ip -n ns_b addr add 239.0.0.1/32 dev veth1 autojoin

  # Sender: FOU + GRETAP with multicast remote
  ip netns exec ns_a ip fou add port 4797 ipproto 47
  ip -n ns_a link add eoudp0 type gretap \
      remote 239.0.0.1 local 10.0.0.1 \
      encap fou encap-sport 4797 encap-dport 4797 key 239.0.0.1
  ip -n ns_a link set eoudp0 up
  ip -n ns_a addr add 192.168.99.1/24 dev eoudp0

  # Receiver: FOU + GRETAP with multicast remote
  ip netns exec ns_b ip fou add port 4797 ipproto 47
  ip -n ns_b link add eoudp0 type gretap \
      remote 239.0.0.1 local 10.0.0.2 \
      encap fou encap-sport 4797 encap-dport 4797 key 239.0.0.1
  ip -n ns_b link set eoudp0 up
  ip -n ns_b addr add 192.168.99.2/24 dev eoudp0

  # Test: ping through the FOU/GRETAP tunnel
  ip netns exec ns_a ping -c 100 192.168.99.2
  # -> without this patch: 0 packets received on eoudp0
  # -> with this patch: all packets received on eoudp0

AI assistance (Claude, claude-opus-4-6) was used during root cause
analysis of the kernel source code (tracing the call chain from
udp_queue_rcv_skb through encap_rcv to ip_protocol_deliver_rcu,
comparing unicast/GSO/multicast paths) and during patch and selftest
authoring. The fix approach was identified by observing that the
unicast path (udp_unicast_rcv_skb) and the GSO path
(udp_queue_rcv_skb) both already handle encap resubmit correctly,
while the multicast path did not.

Changes since v1 (RFC):
  - Moved inline Python packet generator from the shell script into a
    separate helper (fou_mcast_encap.py) and added it to TEST_FILES
    in the Makefile

Anton Danilov (2):
  udp: fix encapsulation packet resubmit in multicast deliver
  selftests: net: add FOU multicast encapsulation resubmit test

 net/ipv4/udp.c                                |  13 ++-
 net/ipv6/udp.c                                |  13 ++-
 tools/testing/selftests/net/Makefile          |   2 +
 .../testing/selftests/net/fou_mcast_encap.py  |  81 ++++++++++++++
 .../testing/selftests/net/fou_mcast_encap.sh  | 105 ++++++++++++++++++
 5 files changed, 206 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.py
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh

--
2.47.3


