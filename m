Return-Path: <netdev+bounces-253624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xZh7OZX+d2lqnAEAu9opvQ
	(envelope-from <netdev+bounces-253624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:53:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459F8E554
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 320473018D79
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D4F3101D8;
	Mon, 26 Jan 2026 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR+1j1qP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92442D94B4
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471634; cv=none; b=HR2aansqUDdBFVS4KqP5wHTypDXzwVUkFhZWjHg88GO1AQ+bcvvji/o7SY3RRlS0ZpyTfobG+9pCjdPwhS0Zzn38apb5v8WKCbho6SYRibc0IjVqp3E/7IU4DtYS/L3u0EHgoKdwdoCuwTbkD/4h8V65p0GN1v0nVe34AY+ns2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471634; c=relaxed/simple;
	bh=FXrt+gvFE7I7a/y+qW6eteDMg2gQf4kuOSO/dloC+nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kk/zGeQx8eNoTxCTSKBpmZJjOjVCCTZYJT7NW8cNXMgLuSH1tABssuW5UShFujUiYH9hG7CwBd4jRtAAwygv0FiPQ1uVTDt4Y8ujf9ITqbPDYeYAKXvG8TXFLvlLinA0WlIkUKvzn+E27WhShnSpOy4AugpVo0vSpmxGNDB+XX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR+1j1qP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so50322655e9.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 15:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769471631; x=1770076431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NwOokDGd1yHaZSqePwW74hCKjWo3HyDY9570nB5Oua8=;
        b=UR+1j1qPRd44+1ecbI0HM7SUfAnSiFDX1EhclyzK1Ha7CHcNchUbfokSc5k1MlDhXf
         UO47WZP60XKxhpoTXnDbJTGg76vEVDVtzGWgHcCBab1gB7xfAXNkP06XQQyZJ6SNHDSE
         BuCbUSVYaEh9HqA5FFUnfjQCxj9OvAMBKHzupoKs2pcyXUs9vp4WYMiH+kHT8/VmOIPP
         ZCLdgk+HFCt8k61O6ySVQ8tx+V/ONUtgxHx5ln73b2JQnLGQgxojlcjouHx+9VCUBQQz
         KoX/Kq24BSU36x2na1Is2MA51yvGNC5nQoU40WHA5pKSy56lbaxuq8CHqvMO8Gl/boQy
         RlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471631; x=1770076431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwOokDGd1yHaZSqePwW74hCKjWo3HyDY9570nB5Oua8=;
        b=h1oiZjDcMUS96nFZ/4ZrN1kuHMGI1VlFbLIW7UZTlOccilNAsB2Zf3roqbAR1qERgn
         wn4KaLDUKB8WZb+DNWzcsaOmRN7o+wVj2leetM0v8L1r25An1+BMxree+6lRONu34fys
         TdmU4OsT0+Fs/Y9l+1sYykvaOXnWfD7vTg//YmXEY3yfydfOOBn0XCOQEaD+jXpKernZ
         Zzx9dJvZYBy7CIyO3+1BOjOzRHXVvh4EMqNIX1NZ3PYx0rBx4UthPguELOxfo5WqZXeg
         zeQL5TU8GqFIB+TtThb2G3rvNgx5nFBikYMprnCCwjo2TS9GKrPY6PftRMSZuIEqbpGN
         jIiQ==
X-Gm-Message-State: AOJu0YywyWhw9dvIkC2U2Gp5P6jjU0ZLPjVwzgWDkAxrO2IiY9ytFPL4
	3ArnGgeaBYILH/8XG6QPLexdGzEG4fd93R5v8wQm3GbwO/nzexBs4QgFrr6IsQ==
X-Gm-Gg: AZuq6aIc78yqlkxosCMQ8A8T1Sm9dJPr0/itRlwpptXLKLFkc020V+SA+Tvw20foAfU
	gC+vA2/fD2cjoCZYd4Fp0akdI5W0wCCxQMFflvsEdZP4+3/yvYvjJb4hGuK/cXWXOeOud51aph/
	+XDv9LPld4oy1rlp6fvu/+EM62rwldvLnhGqVFBDzeRwtc7l18yuo2qgp1r4X+zIJHPrPpkvpfv
	+/8Te2gB6J8PA+gG4WtC162b3sVrLW2o4JrnBOKWCzEL1MHoFasT3V6Ue/dl23AFusrXZ54ui1K
	VfMKE6lTBMVdI+jxkZ+dioN3AdmtF7fuDf1e1tHA2S5+SXgU39pugWBSlLm0MjK7rDGjRmntwLn
	3gTf0WGt4NpHEwi33sKvrlkQ/j3TxqzatqfjAXOyIKgT5QnGp5HwdYTi202UA/F/aMJBc3WwoOR
	oKZ2sa2OtPeQ/nY6oZVURFR6lfWLauZKBKPXsEMZoIEuEip/8wTUspnpAlVjNXJ1BrptbjeVMvk
	KRcow4TEJchgsSAZj7zUT6dRBqAxB6BidU57YqHWk/AIW18faGgEpvylE4TaYIiACS8j3A=
X-Received: by 2002:a05:600c:a106:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-4805e6fd919mr76939315e9.19.1769471630910;
        Mon, 26 Jan 2026 15:53:50 -0800 (PST)
Received: from localhost.localdomain (105.red-79-153-133.dynamicip.rima-tde.net. [79.153.133.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066be7404sm22658615e9.1.2026.01.26.15.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:53:50 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net v2 0/4] discard ARP/NDP b/mcast/null announce (poison)
Date: Tue, 27 Jan 2026 00:53:01 +0100
Message-ID: <cover.1769464405.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-253624-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[marcdevel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3459F8E554
X-Rspamd-Action: no action

The current ARP and NDP implementations accept announcements with
multicast (broadcast incl.) and null MAC addresses as Sender HW Address
(SHA) in ARP or src/target lladdr in NDP, and updates the cache
for that neighbour.

Multicast (incl. broadcast) and null MAC addresses shall never be
associated with a unicast or a multicast IPv4/6 address (see RFC1812,
section 3.3.2).

ARP/NDP poisioning with a broadcast and certain multicast MAC addresses,
especially when poisoning a Gateway IP, have some undesired implications
compared to an ARP/NDP poisioning with a regular MAC (see commit message
in patch 1 for more information).

Worth mentioning that if an attacker is able to ARP/NDP poison in
a L2 segment, that in itself is probably a bigger security threat
(Man-in-middle etc., see Note2 in patch 1)

Since these MACs should never be announced, this patch series discards/drops
these packets, which prevents broadcast and multicast ARP/NDP poisoning
vectors.

This patchset only modifies the behaviour of the neighbouring subsystem
when processing network packets. Static entries can still be added with
mcast/bcast/null MACs.

v1: https://lore.kernel.org/netdev/cover.1766349632.git.marcdevel@gmail.com/

Changes since RFC v1
====================
  - Discard announcements with multicast MAC addresses
  - Check for dev->type == ARPHRD_ETHER instead of HW addrlen in ARP
  - Use !is_valid_ether_addr()
  - Added multicast test coverage and renamed tests accordingly
  - Dropped patch 5 (scapy utils)

Comments
========

As discussed in v1, certain Load Balancers make use of Multicast MAC addresses
for their VIPs:

https://support.huawei.com/enterprise/en/doc/EDOC1100213154/d8621162/dynamic-learning-of-arp-entries-with-multicast-mac-addresses
https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/configure-network-to-support-nlb-operation-mode

But as stated in the Microsoft NLB documentation, it is expected that
static entries are created for it to work:

  To support this configuration, you must configure the network
  infrastructure to use static ARP entries and MAC address table
  entries. Network switches cannot learn the NLB multicast MAC address
  in the course of their usual operations. If you skip the manual
  configuration step, the network switches may flood NLB traffic to
  all ports or drop packets. The network may seem to function
  correctly at first, but problems increase over time.

Marc Suñé (4):
  arp: discard invalid sha addr (b/mcast ARP poison)
  selftests/net: add no ARP b/mcast,null poison test
  neigh: discard invalid lladdr (b/mcast poison)
  selftests/net: add no NDP b/mcast,null poison test

 net/ipv4/arp.c                                |   8 +
 net/ipv6/ndisc.c                              |  16 +
 tools/testing/selftests/net/.gitignore        |   2 +
 tools/testing/selftests/net/Makefile          |   3 +
 .../net/arp_ndisc_no_invalid_sha_poison.sh    | 368 ++++++++++++++++++
 tools/testing/selftests/net/arp_send.c        | 138 +++++++
 tools/testing/selftests/net/ndisc_send.c      | 198 ++++++++++
 7 files changed, 733 insertions(+)
 create mode 100755 tools/testing/selftests/net/arp_ndisc_no_invalid_sha_poison.sh
 create mode 100644 tools/testing/selftests/net/arp_send.c
 create mode 100644 tools/testing/selftests/net/ndisc_send.c

-- 
2.47.3


