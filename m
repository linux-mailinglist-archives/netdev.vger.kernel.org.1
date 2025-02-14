Return-Path: <netdev+bounces-166599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2080A368AD
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E0B170F26
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CAF1FCD1F;
	Fri, 14 Feb 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr5zhzIE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B0B1FCD0C
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573165; cv=none; b=MyXDiU6r80HvGYz1MZhRPeC5nd5eFU7hVTmvT+r0S3Nrhwp/MN7UBiSNlQ+buwrYuLW3EDcplcMVbQfCbMce851rnBnwNMm54z1viW1GLJDTPSXPMECEB8Tz8QK+cVqR1OY6tcSAz3cBhyFoL94ckpfVe7upTHajYNwq9ObN0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573165; c=relaxed/simple;
	bh=Tf36ND/7Va/aOXlN5jjfJ8JzWElmGjCudShLKwWLncI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDTrgfm4/5vujgi3JskvqsKjXWT12jSJlsXThA/rH9sdhxKEXFOHtQk+w10JBSYF431NdUt1tOBsQZB834GAmdL/tq4MKOvyFn25vEDooGwPZiwyXTAmXaz6jXwFX8CfM61/fnT+GOFOGkxAgqYIqdaz9x0d5e+bNc+qcDY1Wu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr5zhzIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165DBC4CED1;
	Fri, 14 Feb 2025 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739573164;
	bh=Tf36ND/7Va/aOXlN5jjfJ8JzWElmGjCudShLKwWLncI=;
	h=From:To:Cc:Subject:Date:From;
	b=Xr5zhzIEajkA68SFxrYun20gTp+lVe9NdVjBhfobHZ+eEEp9utZh9pYXDFEUAYP4q
	 oVfFYISOZcgyCcgTaSwme7Zlx991J+msuz0IFv439Q0UfhkFyPNqjyPRre2kLM/R2X
	 r0DoAj1fKKl6qX1MdHcevrXsfwPtW2pptFKEOIA9kJvOBzQAtICvwL+XltcNHIhBZj
	 MN5T4kbZHQzOKUpfFSQ4zfR9wRj6YE/+CFFfVNzT/A0cxsCRavrywlMCh4kSaJBdlN
	 wXJLEFCfrdC8OvpNLSKzbvop0L3rP8DFhBfRnheyWraQYSVaR3wpLxwwAm6ufyJrKT
	 nuwDoczin/nVg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	willemb@google.com,
	ecree.xilinx@gmail.com,
	neescoba@cisco.com
Subject: [PATCH net-next v2] netdev: clarify GSO vs csum in qstats
Date: Fri, 14 Feb 2025 14:46:01 -0800
Message-ID: <20250214224601.2271201-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Could be just me, but I had to pause and double check that the Tx csum
counter in qstat should include GSO'd packets. GSO pretty much implies
csum so one could possibly interpret the csum counter as pure csum offload.

But the counters are based on virtio:

  [tx_needs_csum]
      The number of packets which require checksum calculation by the device.

  [rx_needs_csum]
      The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.

and VIRTIO_NET_HDR_F_NEEDS_CSUM gets set on GSO packets virtio sends.

Clarify this in the spec to avoid any confusion.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove the note that almost all GSO types need L4 csum
v1: https://lore.kernel.org/20250213010457.1351376-1-kuba@kernel.org

CC: willemb@google.com
CC: ecree.xilinx@gmail.com
CC: neescoba@cisco.com
---
 Documentation/netlink/specs/netdev.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 288923e965ae..48159eb116a4 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -457,6 +457,8 @@ name: netdev
         name: tx-needs-csum
         doc: |
           Number of packets that required the device to calculate the checksum.
+          This counter includes the number of GSO wire packets for which device
+          calculated the L4 checksum.
         type: uint
       -
         name: tx-hw-gso-packets
-- 
2.48.1


