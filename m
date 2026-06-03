Return-Path: <netdev+bounces-294708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ngwB8kDIGpXuAAAu9opvQ
	(envelope-from <netdev+bounces-294708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:36:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5F636A65
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:36:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Mc92wN7T;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294708-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294708-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5D843101B99
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C9D34AB00;
	Wed,  3 Jun 2026 10:30:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9034D90C
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 10:30:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482632; cv=none; b=tZG2pF8ozuHWd3/zxnnOykECmdXDQRA4jGFXw4fNY30P/qVXxiXA0VgMcNRmp9FwC9isKZj22d5j6Nq5ft+V5/zy+vPYGzL1qkttYUMOg5rc+CvFWW6Oca546aJW9dQDezfq+LdejgFXxvcN0uf7xJMZ+Bu3msqq1cEB79OvWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482632; c=relaxed/simple;
	bh=FyeWWxgkQgJd3Wuo71kmP/3P6NEL6bCLEpz6VhRKoz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jr5ZKwDQ0RspNshnL74sGOHeSMrOC92yeG6LSVijPQDBS9zT//ba2Y69Lq07ex1cD3ii7ERfDoejdC13fveOzj+lnNqaqv/b4nu+sJ7ljyQPynAtO/zgsiiaLyOsVNwy1Ykqy6lUHfu97Il5LM8iJw6IKObZ1AAZ2DVp+NTsrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc92wN7T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B2F1F00893;
	Wed,  3 Jun 2026 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780482631;
	bh=mWj9HVq5gBiKHnyrvip7gxwpROvspRY6Q5wfNRCKOgc=;
	h=From:Date:Subject:To:Cc;
	b=Mc92wN7TYo0So44/VHoRjYGK/hlL+9mfKrxNyw6jQj0ppRxP9rwN7kagfRE4QcDOj
	 IaBnZBBjLowUFa66pVaT9Wsbanw5BBUK6FoN0uhQ4U+HTnGSQs09YZPUl0jXvYwM3f
	 4MRsarKQnSyoFwsd16LD8/JUi5iwYZhKiqJH8iE5c3Nx060wpix+IQjMSL1m6l8s0Z
	 kxS8JH3vHlIemn5HcSWIpwf9x/rAlaWKjCxTe2T0qjZScQk5nKghlZViTeKR4iAKEE
	 5yW9GbF4y/sc83zsTiLOfgBN5Qo7GzP/cIcMoX9DR7zVdFRdgK732Uf5UxjmCNMXjX
	 YbX//Ok4mt42Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 03 Jun 2026 12:30:01 +0200
Subject: [PATCH net-next] net: airoha: Report extack error to the user if
 airoha_tc_htb_modify_queue() fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-airoha_tc_htb_modify_queue-err-message-v1-1-33ec3ab997d9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQ7CIBQFr9L8tSSIBhOvYgyh9CF/UdAPbWqa3
 l3ichYzs1OFMCrdh50EK1cuucP5NFBIPr+geOpMRhurrb4oz1KSdy241EY3l4nj130WLFAQUTN
 q9d2K8DfjownX0VKPvQWRt//oQRlNZWyNnsfxAxKvlPaCAAAA
X-Change-ID: 20260603-airoha_tc_htb_modify_queue-err-message-fea72af2c4b6
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294708-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66F5F636A65

Report an extack error message in airoha_tc_htb_modify_queue routine if
airoha_qdma_set_tx_rate_limit() fails.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 6574901ebd19..d0d13f01e50f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2605,13 +2605,19 @@ static int airoha_tc_htb_modify_queue(struct net_device *dev,
 {
 	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
 	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
+	int err;
 
 	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
 		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
 		return -EINVAL;
 	}
 
-	return airoha_qdma_set_tx_rate_limit(dev, channel, rate, opt->quantum);
+	err = airoha_qdma_set_tx_rate_limit(dev, channel, rate, opt->quantum);
+	if (err)
+		NL_SET_ERR_MSG_MOD(opt->extack,
+				   "failed configuring htb offload");
+
+	return err;
 }
 
 static int airoha_tc_htb_alloc_leaf_queue(struct net_device *netdev,

---
base-commit: dfcc2ff12925d99e858eaf539eaa4aaaf81fe2a6
change-id: 20260603-airoha_tc_htb_modify_queue-err-message-fea72af2c4b6

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


