Return-Path: <netdev+bounces-234690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1A4C260C9
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 787F14F90DB
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080E5314D0B;
	Fri, 31 Oct 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="v4yk6fei"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B72FD1DD;
	Fri, 31 Oct 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926848; cv=none; b=sXa8u8pLp16P7o+jlZCzvt3vEGz71hsYybA7Ic/Y3eX+yDmU75YnFfzVZCYveVnllSOvsDnTAXNmCKFZyY5NphWeJkpByPdLcea2+hyAuangeFfheSyqNgV1uxWxoQKQzp4/wdeYTw8If+klT1e/cDhex62/qPlUwThS5LLIW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926848; c=relaxed/simple;
	bh=eTnEqUfZ1QM8rQVdqe622sxSi3uLZoHR6Wimv93HDIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxT5DEUFX49fnzsTmpQrzomhvmbOPzEIAzGUpdIOrzUfUt0ndH4sya+p6lMDcTqND4ChCdk1LvMTjakULSVhIepqhkG/b7+zcEBRyh92DlgvcMH+rcS4w23IccLHC5DHjR3/CyQ9gnq6sQk3l25zZJ/pI0GYpHHM1V2G2KI1heY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=v4yk6fei; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761926832;
	bh=eTnEqUfZ1QM8rQVdqe622sxSi3uLZoHR6Wimv93HDIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v4yk6feiw7nbhJf4pm6xbTJ6j/pFdYbj1RktGh8CXT0l9bsDlVxsLY0oL0EpNWYe5
	 MGUr1fPi5HVcOmZkyjG6d35GS8eEike+ar2peSRO4Jc487X6q+NiJAqZtEOQAUPyRf
	 CWm5xuO1VHheIp2TSqdf6J+AXYllO6nWUufhT7ZTJ+uke8pBczVaz1aXLXNwzYqvfg
	 tQyTr0HpZapshULDeQjmHTZOvdU6vdgxwdeAillU3HHvapKg5LMEF4WQhiF50cE0Zs
	 Qk2pq8iLvu73XMfT4WARpEpNQeZIljDu1mmUHpG7m4GAQR2FQ2qfAnuyWM51DSPSd/
	 h7UxmgyzZ8sNw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 76A216012B;
	Fri, 31 Oct 2025 16:07:12 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 665D2203673; Fri, 31 Oct 2025 16:05:43 +0000 (UTC)
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
Subject: [PATCH net-next v2 03/11] wireguard: netlink: enable strict genetlink validation
Date: Fri, 31 Oct 2025 16:05:29 +0000
Message-ID: <20251031160539.1701943-4-ast@fiberby.net>
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
index db57a74d379b..682678d24a9f 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -633,7 +633,6 @@ static const struct genl_ops genl_ops[] = {
 static struct genl_family genl_family __ro_after_init = {
 	.ops = genl_ops,
 	.n_ops = ARRAY_SIZE(genl_ops),
-	.resv_start_op = WG_CMD_SET_DEVICE + 1,
 	.name = WG_GENL_NAME,
 	.version = WG_GENL_VERSION,
 	.maxattr = WGDEVICE_A_MAX,
-- 
2.51.0


