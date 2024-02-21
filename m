Return-Path: <netdev+bounces-73840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5143385EC95
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 00:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E729D1F231EB
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 23:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AD8126F11;
	Wed, 21 Feb 2024 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjObbt6f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DB85290
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557135; cv=none; b=YWUQFJwB6PmQuyjNDf87+od+5RZPBNvI6XCCGX948SA/s1N49hAkleTBAqum9lrfz4aRZduZPDzDGAx8CXPBq5ar8YI4hebfSmOMU8vs8c8G/Y+Dmt7EWsc5AIub9GtpXlajE4ofOuaeip3tM404/vFlhkGCcQgmWpqgWwghQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557135; c=relaxed/simple;
	bh=OKvQEk7OfnLbcJPSya1xNE2VXghzq1VpBhlFsoDVtz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDBNTnqWmRnomrMIiKlnXvi8Wo61Wky4APXTG33ZuV9IBk7+BNA5IXMQ5FCNTqoGJjwTk82UmZgKY1l7u/vMbz3Ly9+I5hjJGxdTVhQX62qXHncTwC3vO5jsPOCVQapzi4CcbsySQ3mo7XrnN9qQY4FzM9qngvmGpiq+HQ/OMPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjObbt6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D395BC43399;
	Wed, 21 Feb 2024 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708557135;
	bh=OKvQEk7OfnLbcJPSya1xNE2VXghzq1VpBhlFsoDVtz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjObbt6fcTyyDg+OUQHBvd0qJ8Z7abiVn3jrjI5cjDq6QPBV2r1FPo0Uae2Gg/tiQ
	 c1nm8Cdd+VtfnqIE1QeQclYYcbvppRWT/ubtTRZQstijYulLIOUCvZpBSLgDsfrgGN
	 xRDgOtYl5aGtGtaQXc3vVm1fAC9cHlW+Kq8et6GgFAfLwgavGo1G7sVPb7koaAYJmO
	 kLxMgCL5xuyyRECJn90Fo7y360LBSCPRpD4548rN87WA23tbsbS5Ejt3TmFGmkAd3U
	 YzMeYXcLgOiMJmynB9cwlSkSvz2G+v7m+L86Xow7D9euJIZlkWyaF0qAJlb7LZlR1F
	 KI3EHTb4Dhjcg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	lorenzo@kernel.org,
	toke@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/2] selftests: net: veth: test syncing GRO and XDP state while device is down
Date: Wed, 21 Feb 2024 15:12:11 -0800
Message-ID: <20240221231211.3478896-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221231211.3478896-1-kuba@kernel.org>
References: <20240221231211.3478896-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that we keep GRO flag in sync when XDP is disabled while
the device is closed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/veth.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 27574bbf2d63..5ae85def0739 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -246,6 +246,20 @@ ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
 chk_gro "        - aggregation with TSO off" 1
 cleanup
 
+create_ns
+ip -n $NS_DST link set dev veth$DST up
+ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
+chk_gro_flag "gro vs xdp while down - gro flag on" $DST on
+ip -n $NS_DST link set dev veth$DST down
+chk_gro_flag "                      - after down" $DST on
+ip -n $NS_DST link set dev veth$DST xdp off
+chk_gro_flag "                      - after xdp off" $DST off
+ip -n $NS_DST link set dev veth$DST up
+chk_gro_flag "                      - after up" $DST off
+ip -n $NS_SRC link set dev veth$SRC xdp object ${BPF_FILE} section xdp
+chk_gro_flag "                      - after peer xdp" $DST off
+cleanup
+
 create_ns
 chk_channels "default channels" $DST 1 1
 
-- 
2.43.0


