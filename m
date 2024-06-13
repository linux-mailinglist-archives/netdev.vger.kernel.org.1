Return-Path: <netdev+bounces-103152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C48B90692C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2D7286368
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B0140E3C;
	Thu, 13 Jun 2024 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jRzSoEwM"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61A13F45B
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271819; cv=none; b=d3YRYNdgA1GecFodaV3O3y7sN3rvTCYDesByWP86t3c2Bk1w+jdvb4dxWdXj8hqii6NDRK9T5dKz7jjDNYFxNEL3NLm2I51sgT64LWMAPpYgS9vkE9O+VNfDWa2aJl16d7Iz+0SlTnGrNHL93peAydaobDSW8T2qjXT3Pnc8gu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271819; c=relaxed/simple;
	bh=BatHYllYGjnkBtAFKKiZSH/3lSxA5yVkdIv2NqNK3MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s5pknIIiTXdpBxii7EBCFStH7F8WwVdyJe7+VMugcWIGj/chjzPTPvVoG8Emh3p59+mgXnnxf1SRpbXbr5YnvSgLUPul2Gql32/NxLEQAC3JdgOwKmkGF/Ic8RGVG5bOhvySyMz1UJPho5SDbMw8OJPTrJNZ8n8IMdpIdcmKCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jRzSoEwM; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=WtGeO
	DGLtrCC2vRcOXLwl3JI1hPgIRzC2fi4ArzUZag=; b=jRzSoEwM1T6XTP1TsoN6n
	pjCfx7wBDqvyqppzWQTT9sWL5PQdUY03p4R/CYxZmOX/PpthRPeXUZZSG5o8SYw0
	FbPr/o5foXsm+uEYoTzquoByKOyqiGss0/spGRQJ4e5NCFZEqsFChLFNzWqbmh+F
	PL8zNYY14aFHmPi6DcsI44=
Received: from vm-dev.test.com (unknown [36.111.140.9])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wBnNyApv2pmg1QMIA--.14264S3;
	Thu, 13 Jun 2024 17:43:07 +0800 (CST)
From: wujianguo106@163.com
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	contact@proelbtn.com,
	pablo@netfilter.org,
	dsahern@kernel.org,
	pabeni@redhat.com,
	wujianguo106@163.com,
	Jianguo Wu <wujianguo@chinatelecom.cn>
Subject: [PATCH net v3 0/4] fix NULL dereference trigger by SRv6 with netfilter
Date: Thu, 13 Jun 2024 17:42:45 +0800
Message-ID: <20240613094249.32658-1-wujianguo106@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnNyApv2pmg1QMIA--.14264S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr47XF1DAFyUCrWDXF1UJrb_yoW8Gr1rpF
	1rG345tF18GF13Jws3GFy0yr4YyFs5CF1Uu34avryDX3s5tFykJw4Skry2qa17u34qqrW3
	AFy7ta1rGan8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRHq2ZUUUUU=
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiRAz8kGVODNfP7AABs2

From: Jianguo Wu <wujianguo@chinatelecom.cn>

v3:
 - move the sysctl nf_hooks_lwtunnel into the netfilter core.
 - add CONFIG_IP_NF_MATCH_RPFILTER/CONFIG_IP6_NF_MATCH_RPFILTER
   into selftest net/config.
 - set selftrest scripts file mode to 755.

v2:
 - fix commit log.
 - add two selftests.

Jianguo Wu (4):
  seg6: fix parameter passing when calling NF_HOOK() in End.DX4 and
    End.DX6 behaviors
  netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core
  selftests: add selftest for the SRv6 End.DX4 behavior with netfilter
  selftests: add selftest for the SRv6 End.DX6 behavior with netfilter

 include/net/netns/netfilter.h                 |   3 +
 net/ipv6/seg6_local.c                         |   8 +-
 net/netfilter/core.c                          |  13 +-
 net/netfilter/nf_conntrack_standalone.c       |  15 -
 net/netfilter/nf_hooks_lwtunnel.c             |  68 ++++
 net/netfilter/nf_internals.h                  |   6 +
 tools/testing/selftests/net/Makefile          |   2 +
 tools/testing/selftests/net/config            |   2 +
 .../net/srv6_end_dx4_netfilter_test.sh        | 335 +++++++++++++++++
 .../net/srv6_end_dx6_netfilter_test.sh        | 340 ++++++++++++++++++
 10 files changed, 771 insertions(+), 21 deletions(-)
 create mode 100755 tools/testing/selftests/net/srv6_end_dx4_netfilter_test.sh
 create mode 100755 tools/testing/selftests/net/srv6_end_dx6_netfilter_test.sh

-- 
2.25.1


