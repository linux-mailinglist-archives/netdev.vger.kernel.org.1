Return-Path: <netdev+bounces-165741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB7A3345E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4151888B18
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F5727456;
	Thu, 13 Feb 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djD0smPx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A86FC3
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739408701; cv=none; b=CiuLJRxwOFH13ovQKuqIK0tesCCK6Czu6EyXdrPojipPknIHH0oz9q8yyey7kM2zGFcSHXHvrtdCmFq7bsx7s6+wlg3FuE2Fc4/zJQc7CtDZdmqm1st1C374frgkRM/VAyc5RJ98ipbGJnI5Y69K1W7ySzMQPuHCRYjNlwWKOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739408701; c=relaxed/simple;
	bh=VCp+k0b0I8i8qNTDjUCqpTUw616ANXo4Ro4S57vttdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4QC4uAzlgTvEHnk265+gRqm0zTuiCzfYIun1WnKAZ2hg/wEijJ2mzH+rCIksh0Y82HjmVVsESoHH5gZcTjlFWpNd/W1F3FQ1gsn/cwpCYRxTQ6x9WZvhgO1pNKOk1OtjsKB9w8o3vUWS/5k2gIWJrLHIn0eTChes7iiDvMSBM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djD0smPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1F9C4CEDF;
	Thu, 13 Feb 2025 01:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739408701;
	bh=VCp+k0b0I8i8qNTDjUCqpTUw616ANXo4Ro4S57vttdk=;
	h=From:To:Cc:Subject:Date:From;
	b=djD0smPxq/JbHicC6PGDIgvygsnp2NWaFEoGXTWMBHeIuL42J3SWSEn6vlyzagcF/
	 aYjS3kEUs6uKPr5mFqg1dDV+bRD14oM3pHtfGkr5wlifuk879Lz7OA/SXBVo6nzzBO
	 3s7TG6fNDnvQLfLjcgGHe40J+s18A5qC1n4C6bGLcyR6FsARZQRKPhtFhjPNNTGgqB
	 CbaO9e0pmNbHTQKQg2vHfZsso4PaJMyWvpWHH0FC6g4lFiIltnMJAHhuh3ucYMeYGg
	 ZGw6ApNncspFk9b2eiw4tMsHyo6laxC7ZXJ1P6n7SWu0yuQIK1Pu1v2Oo0Dt5Sqega
	 JHa4g7v3YYYsA==
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
Subject: [PATCH net-next] netdev: clarify GSO vs csum in qstats
Date: Wed, 12 Feb 2025 17:04:57 -0800
Message-ID: <20250213010457.1351376-1-kuba@kernel.org>
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
CC: willemb@google.com
CC: ecree.xilinx@gmail.com
CC: neescoba@cisco.com
---
 Documentation/netlink/specs/netdev.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 288923e965ae..0b311dc49691 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -457,6 +457,8 @@ name: netdev
         name: tx-needs-csum
         doc: |
           Number of packets that required the device to calculate the checksum.
+          This counter includes the number of GSO wire packets for which device
+          calculated the L4 checksum (which means pretty much all of them).
         type: uint
       -
         name: tx-hw-gso-packets
-- 
2.48.1


