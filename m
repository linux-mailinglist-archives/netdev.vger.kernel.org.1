Return-Path: <netdev+bounces-26341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3227778F7
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6931C2158D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27321E1C1;
	Thu, 10 Aug 2023 13:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68101E1A1
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:01:00 +0000 (UTC)
X-Greylist: delayed 472 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 06:00:59 PDT
Received: from out-113.mta1.migadu.com (out-113.mta1.migadu.com [IPv6:2001:41d0:203:375::71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280E1269F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:00:59 -0700 (PDT)
Message-ID: <51b2f9c6-fc0f-9e77-6863-2d6b71130c51@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691671985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xy88FBIClQTUKCv0spf0gk1GNKuEhs4Q++gIpxDDZP4=;
	b=PFXPskjKO6+cMm5GzTEBddF07cS+X1dSZL7XnornSxg9zckEBsTWcbtv1RiGygTR9biw8Q
	zr0VBzhOyVL1FVCF1kUv+TWXh+KgdduPv4h3JG5N0vFqSV4hrDRJL5lGnQBc/erxlPMWYC
	xL8RXFq6DxscTHdC/ZDkHzKXmwF2Fhw=
Date: Thu, 10 Aug 2023 20:53:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Michal Kubecek <mkubecek@suse.cz>
Cc: netdev@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gang Li <gang.li@linux.dev>
Subject: [PATCH 1/1] netlink: allow nl_sset return -EOPNOTSUPP to fallback to
 do_sset
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

netlink: Allow nl_sset return -EOPNOTSUPP to fallback to do_sset

Currently, nl_sset treats any negative value returned by nl_parser
(including -EOPNOTSUPP) as `1`. Consequently, netlink_run_handler
directly calls exit without returning to main and invoking do_sset
through ioctl_init.

To fallback to do_sset, this commit allows nl_sset return -EOPNOTSUPP.

Fixes: 392b12e ("netlink: add netlink handler for sset (-s)")
Signed-off-by: Gang Li <gang.li@linux.dev>
---
  netlink/settings.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/netlink/settings.c b/netlink/settings.c
index 9aad8d9..a506618 100644
--- a/netlink/settings.c
+++ b/netlink/settings.c
@@ -1342,6 +1342,9 @@ int nl_sset(struct cmd_context *ctx)
  	nlctx->devname = ctx->devname;

  	ret = nl_parser(nlctx, sset_params, NULL, PARSER_GROUP_MSG, msgbuffs);
+	if (ret == -EOPNOTSUPP)
+		return ret;
+
  	if (ret < 0) {
  		ret = 1;
  		goto out_free;
-- 
2.20.1


