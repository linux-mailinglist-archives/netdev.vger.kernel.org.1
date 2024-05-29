Return-Path: <netdev+bounces-99141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576AF8D3CF1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095B41F22DA3
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DBB190675;
	Wed, 29 May 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1lNlsPJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBC190683
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000550; cv=none; b=jurRC09mU/gOPGvYTrmG9/UCPN1b+Yadnpm3CXhagbY3Wn5lJaO1FAAHGvPXZ1vu7w0VaipvZAvCjWilbDhzttwUxKaClx6ywKUpSA7FxeJw6fLJguwfblCv1MGm11jUdmqVk/Riu7Bo5USbfTwOWhjeOD4xCp1QxtAAMPFVy8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000550; c=relaxed/simple;
	bh=qgGukKDSkPK9vfHhWqco4OcAy5VASq0kydUQkgHFPr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SkoQTEb1Jyx0JDfSoBW9iwRM6Cwpanre2iml6Z12ELu26r+BtzGgJ8RMACOs3jANOAp3IScrQqUwMUq6q/bMToI0Dykz1EQy90z5fCXILy/fvPjiNcQJJiLDunijFwh6VxSmNWDh65nT2Rsr1IIAVVKBMhoqbwzh5rztFleyW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1lNlsPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B650AC4AF0A;
	Wed, 29 May 2024 16:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717000550;
	bh=qgGukKDSkPK9vfHhWqco4OcAy5VASq0kydUQkgHFPr8=;
	h=From:To:Cc:Subject:Date:From;
	b=Y1lNlsPJrgTfEENcaF6nMYh7SUh21puxCIQl8Apy2qUFgEShGb3Ee0dCrpod4BmbJ
	 NBrQL7W8c1LjSFXrteci3IjH2kgATqy73tqQekHWXIiBq01j+iH2XELXqKdk8nvWmN
	 GiCqLPEFO1l0Ufwc3RW4Kt2QQOKfkZX80UqfeSdkfMlabTw9E2W5xzvR0HGRORZp0a
	 QNRe7NBQ+xtXWFE2OSfa3A4ULDBYu/ZRhy+LuIZU+YgywRxIREo7hp6KxTX+9KXzS1
	 S5BZsVhVW858CG/Ch9w3/LHVR+vUPI18yL5JKubS2sZqfTev+Zbh4ZVhsZbAuARL+N
	 /NbubHQMwQedQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	sdf@google.com,
	amritha.nambiar@intel.com,
	hawk@kernel.org,
	sridhar.samudrala@intel.com,
	jdamato@fastly.com
Subject: [PATCH net] netdev: add qstat for csum complete
Date: Wed, 29 May 2024 09:35:47 -0700
Message-ID: <20240529163547.3693194-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent commit 0cfe71f45f42 ("netdev: add queue stats") added
a lot of useful stats, but only those immediately needed by virtio.
Presumably virtio does not support CHECKSUM_COMPLETE,
so statistic for that form of checksumming wasn't included.
Other drivers will definitely need it, in fact we expect it
to be needed in net-next soon (mlx5). So let's add the definition
of the counter for CHECKSUM_COMPLETE to uAPI in net already,
so that the counters are in a more natural order (all subsequent
counters have not been present in any released kernel, yet).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf@google.com
CC: amritha.nambiar@intel.com
CC: hawk@kernel.org
CC: sridhar.samudrala@intel.com
CC: jdamato@fastly.com
---
 Documentation/netlink/specs/netdev.yaml | 4 ++++
 include/uapi/linux/netdev.h             | 1 +
 tools/include/uapi/linux/netdev.h       | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 11a32373365a..959755be4d7f 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -349,6 +349,10 @@ name: netdev
           Number of packets dropped due to transient lack of resources, such as
           buffer space, host descriptors etc.
         type: uint
+      -
+        name: rx-csum-complete
+        doc: Number of packets that were marked as CHECKSUM_COMPLETE.
+        type: uint
       -
         name: rx-csum-unnecessary
         doc: Number of packets that were marked as CHECKSUM_UNNECESSARY.
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index a8188202413e..43742ac5b00d 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -148,6 +148,7 @@ enum {
 	NETDEV_A_QSTATS_RX_ALLOC_FAIL,
 	NETDEV_A_QSTATS_RX_HW_DROPS,
 	NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS,
+	NETDEV_A_QSTATS_RX_CSUM_COMPLETE,
 	NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY,
 	NETDEV_A_QSTATS_RX_CSUM_NONE,
 	NETDEV_A_QSTATS_RX_CSUM_BAD,
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index a8188202413e..43742ac5b00d 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -148,6 +148,7 @@ enum {
 	NETDEV_A_QSTATS_RX_ALLOC_FAIL,
 	NETDEV_A_QSTATS_RX_HW_DROPS,
 	NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS,
+	NETDEV_A_QSTATS_RX_CSUM_COMPLETE,
 	NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY,
 	NETDEV_A_QSTATS_RX_CSUM_NONE,
 	NETDEV_A_QSTATS_RX_CSUM_BAD,
-- 
2.45.1


