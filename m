Return-Path: <netdev+bounces-231828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEB5BFDD34
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BED94ED229
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937334B1B0;
	Wed, 22 Oct 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="fVT/R152"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188B347BBB;
	Wed, 22 Oct 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157641; cv=none; b=BpJYcM2c6fGIbHDHrQC3ufcGotHkDT2i0EA9teK/j3vmBj07jPRfIQCdtMYExsdGyt5CHuacoBSdTTAHiByv431lizdw4efW2rqLhPjGCptHLdTDzSg9L2nBA8duvsDekNnc/u1vp4yrqX6qUYk3IEtrCl5gLknQTR5jGTsG3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157641; c=relaxed/simple;
	bh=bZEztPyk7BTGQIjoohhhOl7ODQE8PExaiHuzd1d/bXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqHq1dJyKb9K3AsGPLIPr4iNQ+keHtzggMp8tENZLrSULM/n5dGID/Dza2IigvaxSJ/gXTMKGpY3ynfyK4F5sEuPR9I3q7s0DGmjzrHhKq57ZuLPkXGE5cDFJjat3XwTKE2VyFO0EwJlnXIo/vjUlBj01h5MD42up/ri8jao2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=fVT/R152; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761157634;
	bh=bZEztPyk7BTGQIjoohhhOl7ODQE8PExaiHuzd1d/bXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVT/R152bGhLwMPLdp5Mp3v7fPx0SjpBM7gpmIGiKKIIOnRog7K7VNxXE/alT/bHl
	 BVIog5Jy74X1QxzvmNqWiBV8stqOeC/zn4036cZwixWythFSUavJAlkYdO2W7z7EVH
	 xLn26jXNgxT2PT0L2EpoMHMAAphdEri4ZSQMTw/MFXKnC3mfan9qSgV6MLO6DEKLzn
	 ca/jAsuVBDmm/maNYTlEfkhD0EKsZCVdEXXnQyKWsF++rGiVdfAXV+z9JuI4/pcaTj
	 HpJsm5ea/8KhJyt4wLGPnwwNxeobez3WTw9F5BiE5Ge6PdQwbBJv4Z11+n0sInH+E1
	 uE54xNcxyuWyA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id D66E460109;
	Wed, 22 Oct 2025 18:27:14 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id C73B7202805; Wed, 22 Oct 2025 18:27:09 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 7/7] netlink: specs: tc: set ignore-index on indexed-arrays
Date: Wed, 22 Oct 2025 18:27:00 +0000
Message-ID: <20251022182701.250897-8-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022182701.250897-1-ast@fiberby.net>
References: <20251022182701.250897-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The indexes in tc indexed-arrays are mostly used for defining
the priority winin an array of actions, and when parsed by the
kernel they must be unique, and not exceed TCA_ACT_MAX_PRIO (32).

Therefore this patch only sets ignore-index on a single
attribute TCA_CAKE_STATS_TIN_STATS, which is only used for
dumping statistics, and never ingested by the kernel.

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━━━┳━━━━━━━━┓
┃                                  ┃ out/    ┃ input/ ┃ ignore ┃
┃ Attribute                        ┃ dump    ┃ parsed ┃ -index ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━╇━━━━━━━━╇━━━━━━━━┩
│ TCA_BASIC_ACT                    │ 1++ (2) │ yes(3) │ no     │
│ TCA_BPF_ACT                      │ 1++ (2) │ yes(3) │ no     │
│ TCA_CAKE_STATS_TIN_STATS         │ 1++ (4) │ -      │ yes    │
│ TCA_CGROUP_ACT                   │ 1++ (2) │ yes(3) │ no     │
│ TCA_FLOWER_ACT                   │ 1++ (2) │ yes(3) │ no     │
│ TCA_FW_ACT                       │ 1++ (2) │ yes(3) │ no     │
│ TCA_MATCHALL_ACT                 │ 1++ (2) │ yes(3) │ no     │
│ TCA_ROUTE4_ACT                   │ 1++ (2) │ yes(3) │ no     │
│ TCA_U32_ACT                      │ 1++ (2) │ yes(3) │ no     │
└──────────────────────────────────┴─────────┴────────┴────────┘

Where:
  1++) incrementing index starting from 1
  2)   All _ACT are dumped with tcf_exts_dump() calling tcf_action_dump().
  3)   Parsed in tcf_action_init().
  4)   Dumped in cake_dump_stats().

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/tc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index b398f7a46dae1..24866fccb7d15 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -2188,6 +2188,7 @@ attribute-sets:
         name: tin-stats
         type: indexed-array
         sub-type: nest
+        ignore-index: true
         nested-attributes: cake-tin-stats-attrs
       -
         name: deficit
-- 
2.51.0


