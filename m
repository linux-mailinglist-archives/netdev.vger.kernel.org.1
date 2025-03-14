Return-Path: <netdev+bounces-174851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38324A61087
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B3F19C299D
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79C1FE479;
	Fri, 14 Mar 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="PSMHaIzi"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809821FDE29
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953666; cv=none; b=iuyrBhkGAYaEB0/YiPEl87WSXOxzl08/Tyol2ypoZLaz3E1EAGVzfhMVNfF9c/x8uVC3RV0AbbYR2PClEb/X2rKlJv+t0UDa2KmAZ6XLI29LfnXQuFipc1Kg4UkN6XjfXyJeYkyB3VlPopNf4lkwf9huK08sXchxKRRS7gcCZ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953666; c=relaxed/simple;
	bh=QNC8IfK98lQuTIgxbFnhzW0qsfyAo5xbkcTJuyiIFfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kL9KqULdv6LNLm+2q+hb3rO2BMQopvreK4nCkPKXYX//FVUSQTDpwYVjGACewRtfClyCDDfwQXPSZNDWzUa5j1eCL5N4SEp2jNHp+KR3n70OeglaeaZjXG0BGMBwcQfqY9Jmfbdtetnlmkg9tECW3B8Brm4qqIm/h82HaYbAjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=PSMHaIzi; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (rtr-guestwired.meeting.ietf.org [31.133.144.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 5569E200DB8C;
	Fri, 14 Mar 2025 13:00:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 5569E200DB8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741953661;
	bh=/N+b2U5exw30WUtmMs5uGOIIslwhia7Le/wNC+fyVDM=;
	h=From:To:Cc:Subject:Date:From;
	b=PSMHaIziP2IYFV2l9xLpR+jyjlzkxAPKp55AKngtvxEoJ4SBz19Nr4yTE0d5W5oRg
	 qTSS3fb4MTBUP3Iw5921jjMusesvfaSt15gnNsRY+BP2ywUmMChFyNTJ3qolWlpskq
	 B9Uk6Qv2oc34iA6dvVOg2KwTI7x6s1izdiVQ6B2kW54+IyziqMnT8X4ulLPXC4ZQWs
	 oiH2lYjwvo0/DWgj37RWU/B3u1YR+HanI2P+L10pK6JASGTxN7YMQVSTgAyIRdbmI8
	 AEs1N5rT9x784yYCU99CFC5P/0Ml8nkJ785ZgKq3EV//OwOrydLOqdphER9b8WvIbe
	 UENyCUL2QUVhA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net v2 0/3] net: fix lwtunnel reentry loops
Date: Fri, 14 Mar 2025 13:00:45 +0100
Message-Id: <20250314120048.12569-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- removed some patches from the -v1 series
- added a patch that was initially sent separately
- code style for the selftest (thanks Paolo)
v1:
- https://lore.kernel.org/all/20250311141238.19862-1-justin.iurman@uliege.be/

When the destination is the same after the transformation, we enter a
lwtunnel loop. This is true for most of lwt users: ioam6, rpl, seg6,
seg6_local, ila_lwt, and lwt_bpf. It can happen in their input() and
output() handlers respectively, where either dst_input() or dst_output()
is called at the end. It can also happen in xmit() handlers.

Here is an example for rpl_input():

dump_stack_lvl+0x60/0x80
rpl_input+0x9d/0x320
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
[...]
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
lwtunnel_input+0x64/0xa0
ip6_sublist_rcv_finish+0x85/0x90
ip6_sublist_rcv+0x236/0x2f0

... until rpl_do_srh() fails, which means skb_cow_head() failed.

This series provides a fix at the core level of lwtunnel to catch such
loops when they're not caught by the respective lwtunnel users, and
handle the loop case in ioam6 which is one of the users. This series
also comes with a new selftest to detect some dst cache reference loops
in lwtunnel users.

Justin Iurman (3):
  net: lwtunnel: fix recursion loops
  net: ipv6: ioam6: fix lwtunnel_output() loop
  selftests: net: test for lwtunnel dst ref loops

 net/core/lwtunnel.c                           |  65 ++++-
 net/ipv6/ioam6_iptunnel.c                     |   8 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   2 +
 .../selftests/net/lwt_dst_cache_ref_loop.sh   | 246 ++++++++++++++++++
 5 files changed, 306 insertions(+), 16 deletions(-)
 create mode 100755 tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh

-- 
2.34.1


