Return-Path: <netdev+bounces-234160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 375EEC1D4EC
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F330A4E45B7
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2146531A57A;
	Wed, 29 Oct 2025 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="unybq+cU"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7303168F2;
	Wed, 29 Oct 2025 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771130; cv=none; b=GvD8V2m6AbmhFtySJPklQdvl1O/XT03Cfki5Z+i536tmf887fZ1Xd8Gbjo4WaWFFQV1zj7vbbGoEsrlqJKl6AKLjw5nzjx9F/AO2wBUPRzDaF47BtkUuE+eOKzndgIv9gqFVIRkl3G1stLde+l4FU3NCz2X6YSrL5+v157h/cqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771130; c=relaxed/simple;
	bh=LOfrWk6ONClCwAMyA52kAi+ma98US5uAFAh1afwodTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+9IF6OrpGcdkivhr2+dsC3r+MJzrdDakNcFr/vVHj/XuT72qUCeNniD/YlzLLdgq4OMuyKel3Nmc0FkmlxbVVykqZLzzi9ljGeuMhXuDFb4cuZnPIl6GY7AJsOT20robUPThR3y76TKjmobQ5MqBN53IZSNzquLLo5syrLFYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=unybq+cU; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761771115;
	bh=LOfrWk6ONClCwAMyA52kAi+ma98US5uAFAh1afwodTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=unybq+cU3lKbzBjiuP2eErccpA1Myxpj+7N3axyMbM8w3GhUh63idw2WV8oCTr2aZ
	 1GjoOnv8D3gCCNcW6LtrsU+b1yfOVvGctipt+FJ8wzjjNzo/Ui8TlCQ2a/0iuO4GCJ
	 D2h/icTw7XIIA71JGvqNcpH2Uc/k3054QCoLW0Gwy/TeIPG16XwTz2qqxG/4SXLkrP
	 AkI9NAI/RdNYcFY9yfu2cyivl92MCas4+j0j95jPlM6rBhPafYCK0rb9w8Ld3zpIo0
	 MXyttBLOgruB3wXSAK4vyvVD4YPE3dW7NZIzI7GvQotPCDvzTxUswmuYLcJpdRYtrw
	 RhPoDKjlt6L4A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3EE3D60114;
	Wed, 29 Oct 2025 20:51:55 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id EA3EF20308B; Wed, 29 Oct 2025 20:51:29 +0000 (UTC)
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
Subject: [PATCH net-next v1 03/11] wireguard: netlink: enable strict genetlink validation
Date: Wed, 29 Oct 2025 20:51:11 +0000
Message-ID: <20251029205123.286115-4-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029205123.286115-1-ast@fiberby.net>
References: <20251029205123.286115-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Wireguard is a modern enough genetlink family, that it doesn't
need resv_start_op. It already had policies in place when it was
first merged, it has also never used the reserved field, or other
things toggled by resv_start_op.

wireguard-tools have always used zero initialized memory, and
have never touched the reserved field, neither have any other
clients I have checked. Closed-source clients are much more
likely to use the embeddedable library from wireguard-tools,
than a DIY implementation using uninitialized memory.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/wireguard/netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index d36e94220d2c3..024d4a6cc74c6 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -631,7 +631,6 @@ static const struct genl_ops genl_ops[] = {
 static struct genl_family genl_family __ro_after_init = {
 	.ops = genl_ops,
 	.n_ops = ARRAY_SIZE(genl_ops),
-	.resv_start_op = WG_CMD_SET_DEVICE + 1,
 	.name = WG_GENL_NAME,
 	.version = WG_GENL_VERSION,
 	.maxattr = WGDEVICE_A_MAX,
-- 
2.51.0


