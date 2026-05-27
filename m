Return-Path: <netdev+bounces-292145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OaeAbCfFmqBnwcAu9opvQ
	(envelope-from <netdev+bounces-292145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:39:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 203075E08C4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E92063011074
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BF23C945B;
	Wed, 27 May 2026 07:39:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453D3C98B8;
	Wed, 27 May 2026 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867562; cv=none; b=MLNToDWBNXwer1+K3Yf30MOqxXHdAQJbJKmk0J00fCrm1IZHAbrcL8vR1nYcY4EtwdI+espsdvN12YUFTsfaqM3WK7uZ4VdYI6P0FdVUhNKk/3EpU1AFXRir76ZV6b4ameaFbUPRDHBbOFhREAyH2lav0h+IKMpB389EpvtQUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867562; c=relaxed/simple;
	bh=0Lp7vfDUygmdEUcoxVQINnoJkgzUFPqX13URmoussu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kuPReamgLCpRhJEazaen2TrxNEnPi947r7EfIgXcB06ibrJ+UOX2Yu+p4Bd4REQM55VnKoZczpkNctHdb6QKdog/FTVKEyrY6NNYO4C2sgk0NvjM8RsiFBlYE6sij4kJa6w0w5Dx9oukf6FA1g40wOks6XjJwJ1Tg68069R2kgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-03 (Coremail) with SMTP id rQCowABXcdiQnxZqJcWHEg--.56S2;
	Wed, 27 May 2026 15:38:56 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: andrew+netdev@lunn.ch,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Subject: [PATCH] net: microchip: sparx5: clean up PSFP resources on flower setup failure
Date: Wed, 27 May 2026 15:38:55 +0800
Message-Id: <20260527073855.2334001-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXcdiQnxZqJcWHEg--.56S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1UWw48Cr4Duw43JrWkZwb_yoW8Zr4DpF
	WDAr9xCr18Gr4rCF18tr40vFn8Z34FqrWxWF4fK345Ar15CF4vkFn8t3W8Kr1YgryUXF93
	ZF4UAF4Uu3ZxGwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwsAE2oWirpdsAAAs+
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292145-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihaoxiang@isrc.iscas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.521];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,isrc.iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 203075E08C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add error handling paths to unwind the PSFP resources that have already
been allocated before returning the error.

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 .../microchip/sparx5/sparx5_tc_flower.c        | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index 4dc1ebd5d510..e5022d783ee6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -807,7 +807,7 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
 		/* Add new flow-meter */
 		ret = sparx5_psfp_fm_add(sparx5, pol_idx, fm, &psfp_fmid);
 		if (ret < 0)
-			return ret;
+			goto err_sg_del;
 	}
 
 	/* Map stream filter to stream gate */
@@ -816,7 +816,7 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
 	/* Add new stream-filter and map it to a steam gate */
 	ret = sparx5_psfp_sf_add(sparx5, sf, &psfp_sfid);
 	if (ret < 0)
-		return ret;
+		goto err_fm_del;
 
 	/* Streams are classified by ISDX - map ISDX 1:1 to sfid for now. */
 	sparx5_isdx_conf_set(sparx5, psfp_sfid, psfp_sfid, psfp_fmid);
@@ -824,13 +824,23 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
 	ret = vcap_rule_add_action_bit(vrule, VCAP_AF_ISDX_ADD_REPLACE_SEL,
 				       VCAP_BIT_1);
 	if (ret)
-		return ret;
+		goto err_sf_del;
 
 	ret = vcap_rule_add_action_u32(vrule, VCAP_AF_ISDX_VAL, psfp_sfid);
 	if (ret)
-		return ret;
+		goto err_sf_del;
 
 	return 0;
+
+err_sf_del:
+	sparx5_isdx_conf_set(sparx5, psfp_sfid, 0, 0);
+	sparx5_psfp_sf_del(sparx5, psfp_sfid);
+err_fm_del:
+	if (pol_idx >= 0)
+		sparx5_psfp_fm_del(sparx5, psfp_fmid);
+err_sg_del:
+	sparx5_psfp_sg_del(sparx5, psfp_sgid);
+	return ret;
 }
 
 /* Handle the action trap for a VCAP rule */
-- 
2.25.1


