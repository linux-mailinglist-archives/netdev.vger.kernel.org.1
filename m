Return-Path: <netdev+bounces-293011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGErCbo5GWpVtAgAu9opvQ
	(envelope-from <netdev+bounces-293011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:01:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED365FE42B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE1733023DD3
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84B63A0B1D;
	Fri, 29 May 2026 06:56:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C80262D0B;
	Fri, 29 May 2026 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037805; cv=none; b=LLy5hzvN2OKVmJSrdB4wZ4A0tTCZnDve0HWVcPmezLudzclhgWVdsPf6SaaNJwFhUjqP00l2QfdnwDedxWiEYMTbLl7CvnQXmov3HlWlL40kSB6cm3tflHnBOGks/BcmQSrKTbK0zgDnyQ+cLwyXuUWWyLnrLDlpMQ2cxAPPDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037805; c=relaxed/simple;
	bh=UIuQy+F4qbn6DPgmVlFDOhnNRiHnjEFOzy/XhRM93lI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nuHeGoxtcnjLkIGSqsuq0yEZuPmE1uc+KanCGjtPBcNzm0O3my7AKIJm3GDNyGVjt8BvRbFi9ZBO8GX9A+C4CJnSsmea2tGRsvO10Qu0xysaSU5VOS+wvmh4IYdpvS7Z6UTtyLpRCJ396mKJ47W5kYjtl6FhpHQ4bbhObNCgDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-05 (Coremail) with SMTP id zQCowADnLxKPOBlqiG67EQ--.10286S2;
	Fri, 29 May 2026 14:56:16 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	kees@kernel.org,
	jacob.e.keller@intel.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Subject: [PATCH net-next v2] net: microchip: sparx5: clean up PSFP resources on flower setup failure
Date: Fri, 29 May 2026 14:56:15 +0800
Message-Id: <20260529065615.35782-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnLxKPOBlqiG67EQ--.10286S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1UWw18Xr4UtFW7CrykXwb_yoW8uryfpF
	WUA3s3ury8Gr4fCF18tw40vFn8u34SqrWxWF4fK345Zr15CF4kCFn8K3W8Kr1YgryUJF93
	ZF4UAF4UCwnxGrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwsCE2oY6gj-LQAAsf
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293011-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihaoxiang@isrc.iscas.ac.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,isrc.iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 3ED365FE42B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add error handling paths to unwind the PSFP resources that have already
been allocated before returning the error.

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
 - Rebase on netdev/net-next.
 - Add a Reviewed-by tag.
---
 .../microchip/sparx5/sparx5_tc_flower.c        | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index f779a5c00803..a17143953502 100644
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


