Return-Path: <netdev+bounces-234691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750C0C2618C
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E4467E8C
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5174D263C8C;
	Fri, 31 Oct 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Znn9uAyB"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D2E28314E;
	Fri, 31 Oct 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926849; cv=none; b=pyeSri+OnhY3jHE/i/iRF7mQ4CjsMdMyPKiW1aup3mqkVQtw3TeP1+5xPYPhFJfLXoYn7tKVsMsN9JhcM6fkwWzcVorv9mlPPhWAU9X9z/JLaQ39zBvaBcnWnWNdglAwOeCmbr7lP/CF/9IE4F2KXcFvKew165QKRHgVV8OszFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926849; c=relaxed/simple;
	bh=YP/7Az468O3K9xv25TYnGVQmzRYsWPioltt1rTnsRhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIZ4g6/nyR8VOfZtTcwpJD4RgzbKVoZwDtALklMxHFe91ZYWasIq2eurQ1E6wkiW/Yv41D1Tac0LQYIN+WjQw2QqVYi9ulVABanm2sU5XlpMLj4Xa0lFxjbprWTSeuIFmXazUaB3wXfA9kEJAWMSU09VQKYy0HE59wQ3Fz+z5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Znn9uAyB; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761926832;
	bh=YP/7Az468O3K9xv25TYnGVQmzRYsWPioltt1rTnsRhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Znn9uAyBEEw1yjQRjQ2/2gxm06TplVmAsDIJx7RJN0g1LVodQeSPTBTiq35G0BBfF
	 SgiQfBa2XgXnT31AKI+Fy8HYuTreEuksDR8dlG2y8yXzWZjQ+Fi7QiWgPoygaCbyE1
	 dVNKpj/usLmKI1aBA3jDaSthQEvOib6Kbb6N7apFqjSEH7PaZij0isLCwnYEz/Mw7U
	 OV8MdlzN9mK+AeFOAtlZ71I/L4UUfHvZH4P2aTV82iVoe1YvKgrcwf6TJGlcxWANhL
	 +xg6qOV6U+WMynZ4y4hFfMtpEUqMuUA14BDItPhjYL3Uyj3OWUi8wqhdd+TqJI9UWg
	 OUFal7ELAo3HA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 58CE46012A;
	Fri, 31 Oct 2025 16:07:12 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 5FFDB205085; Fri, 31 Oct 2025 16:05:46 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 09/11] wireguard: netlink: convert to split ops
Date: Fri, 31 Oct 2025 16:05:35 +0000
Message-ID: <20251031160539.1701943-10-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031160539.1701943-1-ast@fiberby.net>
References: <20251031160539.1701943-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch converts wireguard from using legacy struct genl_ops
to struct genl_split_ops, by applying the same transformation
as genl_cmd_full_to_split() would otherwise do at runtime.

WGDEVICE_A_MAX is swapped for WGDEVICE_A_PEERS, while they are
currently equivalent, then .maxattr should be the maximum attribute
that a given command supports, which might not be WGDEVICE_A_MAX.

This is an incremental step towards adopting netlink policy code
generated by ynl-gen, ensuring that the code and spec is aligned.

This is a trivial patch with no behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/wireguard/netlink.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index f9bed135000f..7fecc25bd781 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -616,28 +616,30 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static const struct genl_ops genl_ops[] = {
+static const struct genl_split_ops wireguard_nl_ops[] = {
 	{
 		.cmd = WG_CMD_GET_DEVICE,
 		.start = wg_get_device_start,
 		.dumpit = wg_get_device_dump,
 		.done = wg_get_device_done,
-		.flags = GENL_UNS_ADMIN_PERM
+		.policy = device_policy,
+		.maxattr = WGDEVICE_A_PEERS,
+		.flags = GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	}, {
 		.cmd = WG_CMD_SET_DEVICE,
 		.doit = wg_set_device,
-		.flags = GENL_UNS_ADMIN_PERM
+		.policy = device_policy,
+		.maxattr = WGDEVICE_A_PEERS,
+		.flags = GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	}
 };
 
 static struct genl_family genl_family __ro_after_init = {
-	.ops = genl_ops,
-	.n_ops = ARRAY_SIZE(genl_ops),
+	.split_ops = wireguard_nl_ops,
+	.n_split_ops = ARRAY_SIZE(wireguard_nl_ops),
 	.name = WG_GENL_NAME,
 	.version = WG_GENL_VERSION,
-	.maxattr = WGDEVICE_A_MAX,
 	.module = THIS_MODULE,
-	.policy = device_policy,
 	.netnsok = true
 };
 
-- 
2.51.0


