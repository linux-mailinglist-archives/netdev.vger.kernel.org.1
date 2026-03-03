Return-Path: <netdev+bounces-263344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eANjHMshp2mMegAAu9opvQ
	(envelope-from <netdev+bounces-263344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:00:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8201F4E44
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 745CC303DAD7
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 17:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C43DA5AC;
	Tue,  3 Mar 2026 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjFsNgIm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A13D6686;
	Tue,  3 Mar 2026 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560619; cv=none; b=sjMj0sdBH+jpIYJZ5swkWJQ0AT2SrsGxapDOlsQqkpnmsaaUv9T/c615HD+1vcdxG9aVVKT3VKS4XJVPeFq1U46eOAgV3FLIKSMDX01GinW6d5zcfMZjkZE3SP66Yn2qGg/efPmF2KPk0A8QcbyhRHzjonaDixK3gQILhhU2Nak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560619; c=relaxed/simple;
	bh=bubmxG6ci0dg97xq/tbfQq56C8X+tu4E9FIby9oyRm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qy7xDGFr4fM1wVPGpx051FVv88THQ0qKkSPzKuo6MFKc3mXufI1N5bHxEzQjMHuil+KI862zP7f0X84k4CM/Wb8H+USU/tcHMhaqDgGrAbWu41PbllB9JFsdUi356vSaBv9m4OFdKo3N6bQ9+m66Pm0LOji9kHyjpJyLm/c/t2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjFsNgIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F0EC116C6;
	Tue,  3 Mar 2026 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772560619;
	bh=bubmxG6ci0dg97xq/tbfQq56C8X+tu4E9FIby9oyRm8=;
	h=From:Date:Subject:To:Cc:From;
	b=FjFsNgImvwWgOpJ2x+WI4WKLDwcvsAoBvdRmmOmXg5wfa6Xz/SpFFDhVGX1xXSOB7
	 vEIyn2NrLaw7b3hNbYwILW9MV+to40lqRd85waV0qtmRj7JpXyYZi1uLRUiDAPnK7W
	 1gpRpD6NgRHq5jY3MO5UB8D0uGmH5nEGtSXaHomq8NbUzrz7zk3LnpV1969S3rG+ci
	 fx8tCrN+X3AinAgFmbxHA82BtSsL9ozCzl7n6L2SOBKBlQpRh8df36NLIQA3womgI1
	 J1aBMQjzbRsM6IR9l48CgcKRGPm9VwazZ/vT/e1MOf/FBZx8e/l4mjZznKOSbCLarh
	 Bcs6FqlA7g44w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 03 Mar 2026 18:56:39 +0100
Subject: [PATCH net v2] net: ethernet: mtk_eth_soc: Reset prog ptr to
 old_prog in case of error in mtk_xdp_setup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-mtk-xdp-prog-ptr-fix-v2-1-97b6dbbe240f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7RioQsGV9zAsaBmgQdtm2hAM4
 e42PYDL/37++wcEYkMBHsUBTJsJxtkUxKUAvQx2JjRjyiBK0ZRCSPzEFffRo2c3o4+Mk9lxmOp
 OdVqTVAOkqWdKOGtfYClCn+BiQnT8zVdblav/1q3CCpW8jbJuW9Xc6+dKbOl9dTxDf57nD7C5M
 /2+AAAA
X-Change-ID: 20260227-mtk-xdp-prog-ptr-fix-af59b9cce7ba
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Paolo Valerio <pvalerio@redhat.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: CB8201F4E44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263344-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,collabora.com,iogearbox.net,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Reset eBPF program pointer to old_prog and do not decrease its ref-count
if mtk_open routine in mtk_xdp_setup() fails.

Fixes: 7c26c20da5d42 ("net: ethernet: mtk_eth_soc: add basic XDP support")
Suggested-by: Paolo Valerio <pvalerio@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Reset prog_ptr to old_prog instead of always setting it to NULL
- Link to v1: https://lore.kernel.org/r/20260227-mtk-xdp-prog-ptr-fix-v1-1-b73d7588b645@kernel.org
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 1060764b9f17da251a1437c4e0fb7042d14307a8..bb8ced22ca3be239ae268f042efc119c96285947 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3770,12 +3770,21 @@ static int mtk_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 		mtk_stop(dev);
 
 	old_prog = rcu_replace_pointer(eth->prog, prog, lockdep_rtnl_is_held());
+
+	if (netif_running(dev) && need_update) {
+		int err;
+
+		err = mtk_open(dev);
+		if (err) {
+			rcu_assign_pointer(eth->prog, old_prog);
+
+			return err;
+		}
+	}
+
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
-	if (netif_running(dev) && need_update)
-		return mtk_open(dev);
-
 	return 0;
 }
 

---
base-commit: c69855ada28656fdd7e197b6e24cd40a04fe14d3
change-id: 20260227-mtk-xdp-prog-ptr-fix-af59b9cce7ba

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


