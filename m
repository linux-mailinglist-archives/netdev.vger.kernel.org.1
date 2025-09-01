Return-Path: <netdev+bounces-218777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6416CB3E7E2
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865357B15ED
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 14:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03AF313E2F;
	Mon,  1 Sep 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="YZcn32pR"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678DE26FA6F;
	Mon,  1 Sep 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738339; cv=none; b=phq+cIxzo/u/VdbBtof+z3IWOYwnOZV8DmW7G2ANO85lJkgbu+lns1X5TZsqlmCeIZIaDApP6lU5tsg5v1GIO9q4YOM16IAf2vIMdIEv3ou8tIZa28x1fmJzkxRNAdgf6opqS9Yl1kq6Kr783AAJs/HIvTyNMSXspQ3eQUMd1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738339; c=relaxed/simple;
	bh=A3oQDNtC9t8GXyz1Onu5bXHPGEEu2KnjT/PlSY2LNfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bb2/g1GlEJ5cZeK8smJ6+dBSxlfcLCmAd18EGA7AQbpQBClUqYT/qu1TdJgHdthI8zwS2ukdVEAKDaIEMVccHg5ndto2YfrcHa5hgugDMuVtmZXsYBFyRAxylmi0tqnZ/0vllMm1o9lQjcMYmFecDN2y7GjP824vorH5xiTC3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=YZcn32pR; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1756738334;
	bh=A3oQDNtC9t8GXyz1Onu5bXHPGEEu2KnjT/PlSY2LNfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZcn32pRvgCPxUHhdbcid7QSZs4Y0AsQQQOBZ4giN4TxgRTjsm/pQQicMkxrkngsQ
	 +r1+J3vWSQLG4DNXN6ftUKzlB3ZS6ViJCAmDaSBnBPDWtpoN9D3TVtkpbyJhjp9kWq
	 UUZToBMPGAlr+kFkxdPyxQY9njO4xtPk+1BzzCwUwKTVlU5fwlhXvnbaPt66SbFf84
	 bpXrwF2C8BM9DQy2F+kUynrTgkzaGjn4x2FNNd82oB38Cq9/Uly0g+iKlzqxdh6hA6
	 6kOKLM/fH9fHPYAYVXYHyF5v7C9bGG0D+P4Ntpak4Q6F//oPAo0HJeT+iHUNhJA1Wh
	 2nr6CXCZRD5fQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id DC5B160078;
	Mon,  1 Sep 2025 14:51:16 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 82082202310; Mon, 01 Sep 2025 14:50:57 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 4/4] genetlink: fix typo in comment
Date: Mon,  1 Sep 2025 14:50:23 +0000
Message-ID: <20250901145034.525518-5-ast@fiberby.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250901145034.525518-1-ast@fiberby.net>
References: <20250901145034.525518-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In this context "not that ..." should properly be "note that ...".

Fixes: b8fd60c36a44 ("genetlink: allow families to use split ops directly")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/genetlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index a03d567658328..7b84f2cef8b1f 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -62,7 +62,7 @@ struct genl_info;
  * @small_ops: the small-struct operations supported by this family
  * @n_small_ops: number of small-struct operations supported by this family
  * @split_ops: the split do/dump form of operation definition
- * @n_split_ops: number of entries in @split_ops, not that with split do/dump
+ * @n_split_ops: number of entries in @split_ops, note that with split do/dump
  *	ops the number of entries is not the same as number of commands
  * @sock_priv_size: the size of per-socket private memory
  * @sock_priv_init: the per-socket private memory initializer
-- 
2.50.1


