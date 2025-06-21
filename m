Return-Path: <netdev+bounces-199994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 190D2AE2A91
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 19:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D360917998A
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A86F22259E;
	Sat, 21 Jun 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUsfuqYe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06088222582
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526394; cv=none; b=inVnMRMvO1M+Pp2oCwbJoqP13HKDLWQloEUx1iELFw/0I5frakx+asW9AhYALRZkH2D2cz2ZZhmRY129yPqQpol2dH2lHwTkZUQ8Wk9MREKzLizVGLtIjQnZY+vJpvtDmiiN6kPfwKwBfhF9EvFu70vWLrYXwZ30TLZVImGszvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526394; c=relaxed/simple;
	bh=gPwvKz+R2GLo3MDSwTi0kYMrKy9t1SEbsIMBJxUo/gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Drrm0OtdW/B5lvdkZJgbqfHQb2QZcjx19eDgll7owKpWGEKqEs+UqriAxJCuibhRnXk5Jh+bXzcxs5Ln0Mf1u9HFjMepGaQy0Vaayl9pJHVcFkHhYn9l+/0SSF+GqDqwGx3ibjPX98s7hKFass8g87MKtofKtgFAyFj9bCz7+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUsfuqYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B140C4CEF4;
	Sat, 21 Jun 2025 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750526393;
	bh=gPwvKz+R2GLo3MDSwTi0kYMrKy9t1SEbsIMBJxUo/gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUsfuqYetZ1EzooEPT6fNqv1LBhhMFk9iGYZ8jZkwUvW6tuk+wfC3rQ4CZkWmfv3I
	 sKpjfShPC9QPzyl/mNE6eopwyWfMs+rz717D5jJiv8Af4R553pOhPv0DMRKFL/4HXn
	 hMnBwdlWp70fvgG6OYUgHxuDPPJ7K+zFKqgj2eFwb9P8HH0kh/2JXuJie70mtntqxW
	 z8Am6H0koq6zHuL1Y6TJcoJxZzB3F0TGG71xLGwhpBhDoh3PECJDDnoWnH5J5bD+lk
	 7uwglwBwE0Urd0CAj34693QHvrxlV2efdTjWnWoxgAAFdH6dkKYv7a/656qTDvsQfm
	 8KvH58quOQQ4g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/9] net: ethtool: call .parse_request for SET handlers
Date: Sat, 21 Jun 2025 10:19:38 -0700
Message-ID: <20250621171944.2619249-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621171944.2619249-1-kuba@kernel.org>
References: <20250621171944.2619249-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using req_info to carry parameters between SET
and NTF - call .parse_request during ethnl_default_set_doit().

The main question here is whether .parse_request is intended to be
GET-specific. Originally the SET handling was delegated to each subcommand
directly - ethnl_default_set_doit() and .set callbacks in ethnl_request_ops
did not exist. Looking at existing users does not shed much light, all
of the following subcommands use .parse_request but have no SET handler
(and no NTF):

  net/ethtool/eeprom.c
  net/ethtool/rss.c
  net/ethtool/stats.c
  net/ethtool/strset.c
  net/ethtool/tsinfo.c

There's only one which does have a SET:

  net/ethtool/pause.c

where .parse_request handling is used to select which statistics to query.
Not relevant for SET but also harmless.

Going back to RSS (which doesn't have SET today) .parse_request parses
the rss_context ID. Using the req_info struct to pass the context ID
from SET to NTF will be very useful.

Switch to ethnl_default_parse(), effectively adding the .parse_request
for SET handlers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/netlink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index a9467b96f00c..c5ec3c82ab2e 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -878,9 +878,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!req_info)
 		return -ENOMEM;
 
-	ret = ethnl_parse_header_dev_get(req_info, info->attrs[ops->hdr_attr],
-					 genl_info_net(info), info->extack,
-					 true);
+	ret = ethnl_default_parse(req_info, info,  ops, true);
 	if (ret < 0)
 		goto out_free_req;
 
-- 
2.49.0


