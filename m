Return-Path: <netdev+bounces-186768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F38AA0FFA
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B80A18834F9
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B47421CA08;
	Tue, 29 Apr 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4qoox7S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0921C9F2
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745939017; cv=none; b=XC20ZY+tZBlZibkBgryvlNJU1SSxUQfEa/bPvnhNWpiowKkbynjUbalqWgIjhnoX9PDP6Yi6eJLpeHQItRYPpgn9ugyuzuhtiMZfnG8J+esj0oUNKQ5A10YsVFh9UYSrVItaHl5o1O23Kt7FAvfumjmFb1hF7I+YfR8/SM8L+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745939017; c=relaxed/simple;
	bh=SkUrWsiYqIiwHbtz5HuTdDLsAer74oAI695ijzE7eVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joIYv+IHVZIqeW4/Fg5DMPpi/GjEIJuo83L7xh8XvoKk8NkU5cXHYs/VkmQ6NibcJVpx0YwSLZp1VijYzfmSAiOZ05SJ7QxNcdVBxt+qQ80gY/fbMKabVc+ciZyt3B11NeHngwUpzglaEkND8RtNAtpYzz2rFUfpuSgYKPG1jnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4qoox7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0DDC4CEE3;
	Tue, 29 Apr 2025 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745939017;
	bh=SkUrWsiYqIiwHbtz5HuTdDLsAer74oAI695ijzE7eVY=;
	h=From:To:Cc:Subject:Date:From;
	b=B4qoox7SDPMWFBpUqi97YVf4SCV2VxMJDHGPfpZKeKW8pEsNxtDHYkXdkqzRdRERW
	 8GNhAXMz+w0WW+QsKhiLhoRjLV/x/uXMOI8LkI8jjvZUtXMnZJPuWnB4oiJ2wqGOjt
	 c2UC5KigB4pwnWyRxh5sTHVWeQZEOYZDIrYW6ORVTW1egZMAGwOoysMx3P8eP63Ido
	 0+vFxCxr9hC2MRZ/HTszIk/xvyUPPmtjN8mPhwSTY0fgRjuNomKLTteh5NR1tdjAxO
	 inCLLy155/wbzcJdeEeGdEdBRJSeST58VMfTdyMoClDQlah7VvDLYvBkJUef3Uf1PP
	 G+/8v/rN+o/Xg==
From: Jakub Kicinski <kuba@kernel.org>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH ethtool-next] channels: support json output
Date: Tue, 29 Apr 2025 08:03:32 -0700
Message-ID: <20250429150332.2592930-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make -l | --show-channels support JSON output format.

  # ./ethtool -j -l '*' | jq
  [
    {
      "ifname": "eth0",
      "rx-max": 32,
      "tx-max": 32,
      "combined-max": 32,
      "rx": 0,
      "tx": 0,
      "combined": 20
    },
    {
      "ifname": "veth0",
      "rx-max": 80,
      "tx-max": 80,
      "rx": 1,
      "tx": 1
    },
    {
      "ifname": "veth1",
      "rx-max": 80,
      "tx-max": 80,
      "rx": 1,
      "tx": 1
    }
  ]

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 ethtool.c          |  1 +
 netlink/channels.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 9c8a5428affd..1485b0253253 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6046,6 +6046,7 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "-l|--show-channels",
+		.json	= true,
 		.func	= do_gchannels,
 		.nlfunc	= nl_gchannels,
 		.help	= "Query Channels"
diff --git a/netlink/channels.c b/netlink/channels.c
index 5cae227106d6..b8213d7e3172 100644
--- a/netlink/channels.c
+++ b/netlink/channels.c
@@ -33,22 +33,27 @@ int channels_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	if (!dev_ok(nlctx))
 		return err_ret;
 
+	open_json_object(NULL);
+
 	if (silent)
-		putchar('\n');
-	printf("Channel parameters for %s:\n", nlctx->devname);
-	printf("Pre-set maximums:\n");
+		show_cr();
+	print_string(PRINT_ANY, "ifname", "Channel parameters for %s:\n",
+		     nlctx->devname);
+	print_string(PRINT_FP, NULL, "Pre-set maximums:\n", NULL);
 	show_u32("rx-max", "RX:\t\t", tb[ETHTOOL_A_CHANNELS_RX_MAX]);
 	show_u32("tx-max", "TX:\t\t", tb[ETHTOOL_A_CHANNELS_TX_MAX]);
 	show_u32("other-max", "Other:\t\t", tb[ETHTOOL_A_CHANNELS_OTHER_MAX]);
 	show_u32("combined-max", "Combined:\t",
 		 tb[ETHTOOL_A_CHANNELS_COMBINED_MAX]);
-	printf("Current hardware settings:\n");
+	print_string(PRINT_FP, NULL, "Current hardware settings:\n", NULL);
 	show_u32("rx", "RX:\t\t", tb[ETHTOOL_A_CHANNELS_RX_COUNT]);
 	show_u32("tx", "TX:\t\t", tb[ETHTOOL_A_CHANNELS_TX_COUNT]);
 	show_u32("other", "Other:\t\t", tb[ETHTOOL_A_CHANNELS_OTHER_COUNT]);
 	show_u32("combined", "Combined:\t",
 		 tb[ETHTOOL_A_CHANNELS_COMBINED_COUNT]);
 
+	close_json_object();
+
 	return MNL_CB_OK;
 }
 
@@ -70,7 +75,10 @@ int nl_gchannels(struct cmd_context *ctx)
 				      ETHTOOL_A_CHANNELS_HEADER, 0);
 	if (ret < 0)
 		return ret;
-	return nlsock_send_get_request(nlsk, channels_reply_cb);
+	new_json_obj(ctx->json);
+	ret = nlsock_send_get_request(nlsk, channels_reply_cb);
+	delete_json_obj();
+	return ret;
 }
 
 /* CHANNELS_SET */
-- 
2.49.0


