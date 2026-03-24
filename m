Return-Path: <netdev+bounces-271296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAVLNUX5wmklngQAu9opvQ
	(envelope-from <netdev+bounces-271296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:51:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA331C87B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBC40303B1DA
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53B33B6DB;
	Tue, 24 Mar 2026 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICwJt85A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2878F26
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385475; cv=none; b=gUsAbCb2cIF2Xi3vWSBeWzHVATPMipBTIkl5udbbFn1EX1m/OHD2tLi5tbI9tlKsRja5XlICmqeLr0nNyGd39+FlyGrh+h5et/vzDO0cvRftyBAsVu1jHbbkrI0PORWqm28B4bl6hyeV2x0Ug0ce6R8WuS0gjt8AqR8kcJXbCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385475; c=relaxed/simple;
	bh=WOSadgevteDVxebTf1HjXpcBVMI22QfDIhpkZm6/+ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8lPQty2mxCVozXeJLEx4x8jaBSL7/MOw+IixpAJ/Nm3M5P/ol21tb1NYMD5oCvZwyeZ4judp/wRRuRGHCoOEyvrQufO6FXORzHWuj+2cY1zF/DO0VKU/cE1AGofzIOTAWicMSX4lDA8T381IlPsx5Ab4Mj5EjaUbtOb4dYri0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICwJt85A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090D3C19424;
	Tue, 24 Mar 2026 20:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774385475;
	bh=WOSadgevteDVxebTf1HjXpcBVMI22QfDIhpkZm6/+ow=;
	h=From:To:Cc:Subject:Date:From;
	b=ICwJt85AqchDDW9iKBXns1YHYZKuinL9YD5tSbcBvkZvzgtyU7eV5mvR/KOFr+3ok
	 yKePMAecFxpd0oU43bFiLNp+ocsuHW1+nbrkSmz5oc8al/y775EI0oo8Ls1SNdpk+Z
	 XBlqaDyTQJeWFT820tXNWMT/TmcIYcJ05d3fD6DPePSE9OW10WiUnwbK+sa84t6HO0
	 nr5GiCzUPYEq84tbyz6oCl67ZUFogt9hwAnqvLYhchEzu65Z421319K1goDWHxLW9c
	 F23ZOUlvNJt9Sw/2ZP4RVzAl/B/A0h5jzRpjXHNwe+mhlgoQxUAHJnGdEAMvLaTP80
	 1D/fO2TLzRy/g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Yiming Qian <yimingqian591@gmail.com>,
	daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net] net: psp: check for device unregister when creating assoc
Date: Tue, 24 Mar 2026 13:51:07 -0700
Message-ID: <20260324205107.318303-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271296-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DBA331C87B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

psp_assoc_device_get_locked() obtains a psp_dev reference via
psp_dev_get_for_sock() (which uses psp_dev_tryget() under RCU);
it then acquires psd->lock and drops the reference. Before
the lock is taken, psp_dev_unregister() can run to completion:
take psd->lock, clear out state, unlock, drop the registration
reference.

The expectation is that the lock prevents device unregistration,
but much like with netdevs special care has to be taken when
"upgrading" a reference to a locked device. Add the missing
check if device is still alive. psp_dev_is_registered() exists
already but had no callers, which makes me wonder if I either
forgot to add this or lost the check during refactoring...

Reported-by: Yiming Qian <yimingqian591@gmail.com>
Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: daniel.zahka@gmail.com
CC: willemdebruijn.kernel@gmail.com
---
 net/psp/psp_nl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 6afd7707ec12..c7c377a7790d 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -320,6 +320,11 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 	id = info->attrs[PSP_A_ASSOC_DEV_ID];
 	if (psd) {
 		mutex_lock(&psd->lock);
+		if (!psp_dev_is_registered(psd)) {
+			mutex_unlock(&psd->lock);
+			err = -ENODEV;
+			goto err_psd_put;
+		}
 		if (id && psd->id != nla_get_u32(id)) {
 			mutex_unlock(&psd->lock);
 			NL_SET_ERR_MSG_ATTR(info->extack, id,
-- 
2.53.0


