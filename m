Return-Path: <netdev+bounces-95682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3448C3017
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 09:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5C61F230AF
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990BD531;
	Sat, 11 May 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="OtLeZxNH"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217A7DF51;
	Sat, 11 May 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715413050; cv=none; b=Y+TYoDk+nRScQ/xnY9mMTIG2zqS+0g5OEl3xMvcpwB1CDPCvZW20bYI3lO3GvYdYsjsPzZUutqntMBheAhdJ40lcJb4+eKLmna7Sa1uQWAUrVunrT1T7+TAj4nUS3ppsNRnnvBxyIIUMhLS5KDtL7dhh+HVnF0hMnYvuNZex/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715413050; c=relaxed/simple;
	bh=kJafBWp71h/evMtYr/Du6Ci3edph+pmh0152VsFNhR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vASN5lcXUiVDLZ92ZZY3bc7sOSYivtAVerFswm/fDPRSrdMhVxlLBu/09JDcVng3wassTnmrrharXICFHmkhtDgaa9drkQvMqNFjKKs4uhGikX3eDO2iND6vHGp2o4hx4z6XwwBsWMynQSKglGLyYuVlVekEgT0hm3fgJlLJLHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=OtLeZxNH; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 56898600A2;
	Sat, 11 May 2024 07:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715413037;
	bh=kJafBWp71h/evMtYr/Du6Ci3edph+pmh0152VsFNhR8=;
	h=From:To:Cc:Subject:Date:From;
	b=OtLeZxNHdwCrdkB55itjKbLRAMJhqyQdpJXNIumtvx3MUFjhAcUjtCiGgCu5mbNtT
	 B7aRxi4m4Pz/raxBw9N4EY5i63OnIjB1UVwNWQLgKpM7mZXXuL0KR+Pnz+Yq/wDT09
	 V5FAFl6ZrIBKyGxLdBzrwKwRLamRHrE7cb+aE1Vx9+lOa1ftJkdkTngX1l1Oor0i9P
	 CQfGd4FXYw7zUD1Mzr9/0audlYtssyH2nHgZjNcro8O1JaJteZRjhjN4U/UgnoPjNw
	 9xnCG1tGWf7Zplne/1HlL4dBRNPfFGFRpKRfIglv2Ht+1tgLUrei7i36xriWFVLlkU
	 /cOPb3vIj8Xzg==
Received: by x201s (Postfix, from userid 1000)
	id C2C81200C89; Sat, 11 May 2024 07:37:10 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next v2] net: qede: flower: validate control flags
Date: Sat, 11 May 2024 07:37:03 +0000
Message-ID: <20240511073705.230507-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver currently doesn't support any control flags.

Use flow_rule_match_has_control_flags() to check for control flags,
such as can be set through `tc flower ... ip_flags frag`.

In case any control flags are masked, flow_rule_match_has_control_flags()
sets a NL extended error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---

AFAICT this is the last driver which didn't validate these flags.

$ git grep FLOW_DISSECTOR_KEY_CONTROL drivers/
$ git grep 'flow_rule_.*_control_flags' drivers/

Changelog:

v2:
- rework patch, to use flow_rule_match_has_control_flags(), now that the
  driver have been converted to use extack for error reporting.

v1: https://lore.kernel.org/netdev/20240424134250.465904-1-ast@fiberby.net/

 drivers/net/ethernet/qlogic/qede/qede_filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 9c72febc6a42..985026dd816f 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1848,6 +1848,9 @@ qede_parse_flow_attr(__be16 proto, struct flow_rule *rule,
 		return -EOPNOTSUPP;
 	}
 
+	if (flow_rule_match_has_control_flags(rule, extack))
+		return -EOPNOTSUPP;
+
 	if (proto != htons(ETH_P_IP) &&
 	    proto != htons(ETH_P_IPV6)) {
 		NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported proto=0x%x",
-- 
2.43.0


