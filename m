Return-Path: <netdev+bounces-239450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ECEC68875
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D41D4EE1C1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53E7312824;
	Tue, 18 Nov 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="i7kshzNp"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0D2FE05B
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457980; cv=none; b=o0Cnt0GDTMUUoObQg77VObIKaBlLyb6UsylFRSwKQP2tPFo8b9yBNKkTSHFue16Mcw42fV+dcj+i6gdrdTlbg1bxr6ehuKAQGGF2dLklP6LJ+ym85NZAGpRxEoq/BM7n7L4esN8HgkMQMDKy6aRxmeqOs1VvGSoy6OZXnT8Hdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457980; c=relaxed/simple;
	bh=/wum0LCXGZzBul2gDBsn54Qx72uzo60798m98mRAJPY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jZJb4p37pWluJvJUVP4ZMWNcfNSYI6TN5b12CBSomBhjw68hJvm0pnGqKS3o3Cuk6oijUIYLO6NO5XKU+NF7OAeo2bYagrjaE3JCmwZAD+sg8xRaRyEPt1u8NvIJe/yoCNQ7bqV6+KPJCeg3ssRQbzGWCNE5Qk6XuCENQC2AApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=i7kshzNp; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 75D57200AC;
	Tue, 18 Nov 2025 10:26:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ghV0i3gd2GG3; Tue, 18 Nov 2025 10:26:15 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CF429207B2;
	Tue, 18 Nov 2025 10:26:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CF429207B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763457973;
	bh=dZtepT2pdrdcOzOcw02A2slMl+Tl+mM1Kws+Uxj1L3U=;
	h=From:To:CC:Subject:Date:From;
	b=i7kshzNpGNdTHQ0ggcBGpSY8FWcCtDW8r3H1AjfnQlWqkcoATxBivfeHJwXSVWov0
	 Q5i8pEStJzwX5Mt7+YKRwi6DR6sIhVagiRuV6ldl3xjVSO320gZjiB6N+LsUuYlaqU
	 +5tyHNsznyXUfcLqgfwnVgrfvd0HMSKEvXK4ZAI23Z9QifzOwMm53RFplRATED1QJp
	 AsDBhznvLWnnX5ffIBSyH+8iaxDdIZVNDbAelgFGIgxV5nEb84RmX+rK7xGECIycOE
	 k+fpmEz5Di7cajvcR5HJZ/gUrzO6WhfqAH7bohsMg3b0aiSosEdT7S+7uKsswuUAxE
	 7NpDhAaDK/cRw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 10:26:13 +0100
Received: (nullmailer pid 2223952 invoked by uid 1000);
	Tue, 18 Nov 2025 09:26:12 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/12] pull request (net-next): ipsec-next 2025-11-18
Date: Tue, 18 Nov 2025 10:25:37 +0100
Message-ID: <20251118092610.2223552-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

1) Relax a lock contention bottleneck to improve IPsec crypto
   offload performance. From Jianbo Liu.

2) Deprecate pfkey, the interface will be removed in 2027.

3) Update xfrm documentation and move it to ipsec maintainance.
   From Bagas Sanjaya.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit bfe62db5422b1a5f25752bd0877a097d436d876d:

  Merge branch 'dwmac-support-for-rockchip-rk3506' (2025-10-24 19:07:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2025-11-18

for you to fetch changes up to 939ba8c5b81cbaf37781d7aa4849170860124a5e:

  MAINTAINERS: Add entry for XFRM documentation (2025-11-12 08:30:03 +0100)

----------------------------------------------------------------
ipsec-next-2025-11-18

----------------------------------------------------------------
Bagas Sanjaya (9):
      Documentation: xfrm_device: Wrap iproute2 snippets in literal code block
      Documentation: xfrm_device: Use numbered list for offloading steps
      Documentation: xfrm_device: Separate hardware offload sublists
      Documentation: xfrm_sync: Properly reindent list text
      Documentation: xfrm_sync: Trim excess section heading characters
      Documentation: xfrm_sysctl: Trim trailing colon in section heading
      Documentation: xfrm_sync: Number the fifth section
      net: Move XFRM documentation into its own subdirectory
      MAINTAINERS: Add entry for XFRM documentation

Jianbo Liu (2):
      xfrm: Refactor xfrm_input lock to reduce contention with RSS
      xfrm: Skip redundant replay recheck for the hardware offload path

Steffen Klassert (2):
      Merge branch 'xfrm: IPsec hardware offload performance improvements'
      pfkey: Deprecate pfkey

 Documentation/networking/index.rst                 |  5 +-
 Documentation/networking/xfrm/index.rst            | 13 +++
 .../networking/{ => xfrm}/xfrm_device.rst          | 20 +++--
 Documentation/networking/{ => xfrm}/xfrm_proc.rst  |  0
 Documentation/networking/{ => xfrm}/xfrm_sync.rst  | 97 +++++++++++-----------
 .../networking/{ => xfrm}/xfrm_sysctl.rst          |  4 +-
 MAINTAINERS                                        |  1 +
 net/key/af_key.c                                   |  2 +
 net/xfrm/Kconfig                                   | 11 ++-
 net/xfrm/xfrm_input.c                              | 30 +++----
 10 files changed, 103 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/networking/xfrm/index.rst
 rename Documentation/networking/{ => xfrm}/xfrm_device.rst (95%)
 rename Documentation/networking/{ => xfrm}/xfrm_proc.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_sync.rst (64%)
 rename Documentation/networking/{ => xfrm}/xfrm_sysctl.rst (68%)

