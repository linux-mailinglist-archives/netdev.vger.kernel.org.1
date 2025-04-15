Return-Path: <netdev+bounces-182727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DFAA89C6B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22A63BE2E5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0582951C3;
	Tue, 15 Apr 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="Gwtgp6Pt"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F422951B1
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716368; cv=none; b=WBB8CZn7eXU9fDppaTHmFV7/x7ULX7Wh6yM/RDDX2s1vH/pUwN8ik1sffl4hbpw4xmzf3Ohr4qfHHWMAmK6qZrYfugHJyMebi8hENlgQSow/y9BUu+iMgED+iayeMjFoPwjlH6yPMhHSDdWU9fQ7U5Hevt25n/6kvGcazgZK+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716368; c=relaxed/simple;
	bh=IlZ8KvRGjcOZXmBk47jslg83M2P7njiwDsJg1o2U9b0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=il7AYLDR0lg6RZ0DrC0cN+QDLrAcIMHpaa7pee1RuO6B+hqP06qimiNCiMnxVlnqC1w4T07uBDmYXGBMsvgsjn+VY/QOdWLHEeNms6lIYfQ5InnOmLBnkRbTkLvMhBGu3KcBn0jw1iNUviMaaQrrHvOEIujevNCzfWfap1h7llk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=Gwtgp6Pt; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 83F64200BFEE;
	Tue, 15 Apr 2025 13:26:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 83F64200BFEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744716364;
	bh=8774+QXG539mWtMXdC7U9jISV+ST5e9zcjs3YLUv2e8=;
	h=From:To:Cc:Subject:Date:From;
	b=Gwtgp6PtXLqEsmql7Dq8bmInxTrQuh0PYEpvafd7hjAEayGfyxhZpBU7BsJXatSQn
	 lwvdozPw3hzy9nbm+OUohGKAag22eF0Rf0FnUxn7CrWy5wtF1lR1aeAmMXRjurKGE9
	 BvX3GFMzdm/z8PLuwUnU+L3nUsnMCGpphYHCiMupiwD/SAAdNH9PexF0n8FVRdTMnQ
	 d/t0F0yCzWdEU8EXFeDGgFhLtK92kQ0+70UsbX/hT5xzlBcMlnYzx+tQeF9JSBfkAI
	 GG9jxhoGakcfEsBTxFllJfU6tmetxubGQX41zc3QNPvAVoqIIV25ZzODyrfES4cWnH
	 zYvRDm+8psXYA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v2 0/2] Mitigate double allocations in ioam6_iptunnel
Date: Tue, 15 Apr 2025 13:25:52 +0200
Message-Id: <20250415112554.23823-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- rephrase misleading comment
- move BH disable/enable around if condition
v1:
- https://lore.kernel.org/netdev/20250410152432.30246-1-justin.iurman@uliege.be/T/#t

Commit dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc
issue") fixed the double allocation issue in ioam6_iptunnel. However,
since commit 92191dd10730 ("net: ipv6: fix dst ref loops in rpl, seg6
and ioam6 lwtunnels"), the fix was left incomplete. Because the cache is
now empty when the dst_entry is the same post transformation in order to
avoid a reference loop, the double reallocation is back for such cases
(e.g., inline mode) which are valid for IOAM. This patch provides a way
to detect such cases without having a reference loop in the cache, and
so to avoid the double reallocation issue for all cases again.

Justin Iurman (2):
  net: ipv6: ioam6: use consistent dst names
  net: ipv6: ioam6: fix double reallocation

 net/ipv6/ioam6_iptunnel.c | 76 +++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 22 deletions(-)

-- 
2.34.1


