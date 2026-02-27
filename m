Return-Path: <netdev+bounces-261909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKnlEsK+oWnPwAQAu9opvQ
	(envelope-from <netdev+bounces-261909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:56:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECD1BA663
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C11363004C1F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659C3ED131;
	Fri, 27 Feb 2026 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSX/yAbK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC03624D2;
	Fri, 27 Feb 2026 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207557; cv=none; b=jhzhd1SwDlv6omCKiTLaV5HXyt+STpiec5oBMLZ5GOZZXFY2Y1T1uQvzbCXLV8gyybGlSOD2tAncNcv0kp69A8/Zja3u322iKGkRGZ+SZT8Z8g99oqYeTEJKo2gVSmveKmsnJNYg2LKx8P156ZE0d+37hyhZAKofIUF6BK0Qmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207557; c=relaxed/simple;
	bh=f45vMFSM+cbg6BIT4gb2mHHhAB+82XYmdtpsZXu6y8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mymby2aRVegt0uMsZ9lcAzYWBNJ2xKlL5uSp4b2dj/Mrz5gXkqkxvQhghbiv28sldL/bkFT9xfBfWaA3WTCZUnnRZkc/1nKW6/BCkZkWYQzS7eHHlnz5neKd9CUksXXyQBrl/1NqUl5RjM/OIlJZksJa8gIQXbPaS7bR2nofyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSX/yAbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99433C116C6;
	Fri, 27 Feb 2026 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772207557;
	bh=f45vMFSM+cbg6BIT4gb2mHHhAB+82XYmdtpsZXu6y8o=;
	h=From:Date:Subject:To:Cc:From;
	b=dSX/yAbKDT8GYcoF0V1ZeVPeKXrr0so50mXacVtvjae0z/HUWE9Y4I+ZhJ15axeCP
	 CVy54CH2evuDnlgWVBovzdakTvHnRJxAU8Evddu2bEDsiVl5TMEiPhH9AxL8JXrlm8
	 AmzODyD4VePSTvldhpvxhQm+b0lU+hPoSeaxEOzyoLbBMHz6eRQLUuzrvu5DheJzLk
	 2SLngo8gA/P1BGNCsEf6H54wDk/8yP+qL/3MMJRBo0dbGl0vss3LNiQhEJAsOHhp9H
	 Q2zCZmCIBFptge0BnKYDyZRIq3bWOE42PyROuuRzyFcSM6NRRb/SRY8plxzJwp97Q3
	 hNp4rXoowxN0g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 27 Feb 2026 16:52:11 +0100
Subject: [PATCH net] net: ethernet: mtk_eth_soc: Reset prog ptr to NULL in
 case of error in mtk_xdp_setup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-mtk-xdp-prog-ptr-fix-v1-1-b73d7588b645@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bqGEivpKdDBbbYlMVolA+nvSc
 QZmMkQSpghTlUHo5siXL9DWFZhde0fIW2FQjeobpQY804HPFjDI5TAkQcsPatuN62gMDauGkga
 hov/tDJ4SLO/7ATjD46ZrAAAA
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
 Stanislav Fomichev <sdf@fomichev.me>
Cc: Paolo Valerio <pvalerio@redhat.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 bpf@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261909-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7ECD1BA663
X-Rspamd-Action: no action

Reset eBPF prog pointer to NULL if mtk_open routine in mtk_xdp_setup()
fails.

Fixes: 7c26c20da5d42 ("net: ethernet: mtk_eth_soc: add basic XDP support")
Suggested-by: Paolo Valerio <pvalerio@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index e5e2ffa9c542bfc88dc0d7553d0a6b2a169ec74b..e199f2e243d21f3545e8282ab821135e0962f5c3 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3751,8 +3751,16 @@ static int mtk_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
-	if (netif_running(dev) && need_update)
-		return mtk_open(dev);
+	if (netif_running(dev) && need_update) {
+		int err;
+
+		err = mtk_open(dev);
+		if (err) {
+			rcu_assign_pointer(eth->prog, NULL);
+
+			return err;
+		}
+	}
 
 	return 0;
 }

---
base-commit: fd6dad4e1ae296b67b87291256878a58dad36c93
change-id: 20260227-mtk-xdp-prog-ptr-fix-af59b9cce7ba

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


