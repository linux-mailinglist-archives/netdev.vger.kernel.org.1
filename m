Return-Path: <netdev+bounces-85086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94C089955C
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 08:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A321F22EF3
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D7749A;
	Fri,  5 Apr 2024 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3sXDAoN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD871370
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298702; cv=none; b=XTYueu39PwRzxgHd1XtADL8ILDeZHOLWiVVCs9e9blVu7cMXUhfbGzBLKYPzZY2J7BpeztxOAxcMdvRJRrHCPNl6V5oPHxXYNnwQ74QZxy5m+te2sNtuuDToOY5p1MpAgjdo1MvWdywVY/VCShBeIuDPSp2pXhzvzYDiQE2/Egg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298702; c=relaxed/simple;
	bh=uxxPoPZX0e5BY4xDMmem2tMwFEgVCc4Kd+kbH208rQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W0DUs1WM2lyne5qgKHoeoI50ML8IX2rtrqT2NsmhW63CVqy7k+07htClPJU1cHEuKIaIBl50HipOwJCppJGUNCYjkOCLq0GcLrp/mBzIQMAC+W8TtETlg26B9FuVBPQZUBC2ORxOq/B71uYI/TajTTRDNM7eqdUiMFVetHETq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3sXDAoN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712298701; x=1743834701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uxxPoPZX0e5BY4xDMmem2tMwFEgVCc4Kd+kbH208rQA=;
  b=n3sXDAoNRZtp6xRBFyT8FnoTHHu4v+DO2zlnI/A7UC6xDDjSTEhgvNph
   Ie+YpwC7EjJjwtAl6HaLIVALy3zdfkEZ3/t+RLIzbWLL1gdoCJOcLwDYE
   YvDAM2MPj/ySzdDkbSYrlYQj2chYgD9LlkD/3wsi5k2ingmvZcGY4ZtLt
   JlSJDnIE4dPxXbP5g8wldbOdxgglWA3fd4dQdHvS34KafHBsNVb9Zl9kC
   drVoitYYDcD/2fnoKQW01H3AIPf9f1RednNm+LGEGJed8VQbxsS9WsuDS
   gjmGtQpiNp0NpK+iue8c5du7rpYjB1OIx0v4sQHCoS2MRMbegEyyIOhzG
   Q==;
X-CSE-ConnectionGUID: ydBq7WI2RnGBYO8nIbRBlA==
X-CSE-MsgGUID: UhStp0jjRF6q8ulTkmZJvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25123821"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208,223";a="25123821"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 23:31:40 -0700
X-CSE-ConnectionGUID: dZkq5PdmSyuSQ7yVYkmoSg==
X-CSE-MsgGUID: RntyAcHaSAWHCSR5ndLZKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208,223";a="19097876"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa009.fm.intel.com with ESMTP; 04 Apr 2024 23:31:38 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	aleksander.lobakin@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [net-next v2] pfcp: avoid copy warning by simplifing code
Date: Fri,  5 Apr 2024 08:36:05 +0200
Message-ID: <20240405063605.649744-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From Arnd comments:
"The memcpy() in the ip_tunnel_info_opts_set() causes
a string.h fortification warning, with at least gcc-13:

    In function 'fortify_memcpy_chk',
        inlined from 'ip_tunnel_info_opts_set' at include/net/ip_tunnels.h:619:3,
        inlined from 'pfcp_encap_recv' at drivers/net/pfcp.c:84:2:
    include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
      553 |                         __write_overflow_field(p_size_field, size);"

It is a false-positivie caused by ambiguity of the union.

However, as Arnd noticed, copying here is unescessary. The code can be
simplified to avoid calling ip_tunnel_info_opts_set(), which is doing
copying, setting flags and options_len.

Set correct flags and options_len directly on tun_info.

Fixes: 6dd514f48110 ("pfcp: always set pfcp metadata")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/netdev/701f8f93-f5fb-408b-822a-37a1d5c424ba@app.fastmail.com/
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v1 --> v2:
Links: https://lore.kernel.org/netdev/Zg6yMB%2F3w4EBQVDm@mev-dev/
 * Add Fixes and Closes tag
---
 drivers/net/pfcp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index cc5b28c5f99f..69434fd13f96 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -80,9 +80,8 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	else
 		pfcp_node_recv(pfcp, skb, md);
 
-	__set_bit(IP_TUNNEL_PFCP_OPT_BIT, flags);
-	ip_tunnel_info_opts_set(&tun_dst->u.tun_info, md, sizeof(*md),
-				flags);
+	__set_bit(IP_TUNNEL_PFCP_OPT_BIT, tun_dst->u.tun_info.key.tun_flags);
+	tun_dst->u.tun_info.options_len = sizeof(*md);
 
 	if (unlikely(iptunnel_pull_header(skb, PFCP_HLEN, skb->protocol,
 					  !net_eq(sock_net(sk),
-- 
2.42.0


