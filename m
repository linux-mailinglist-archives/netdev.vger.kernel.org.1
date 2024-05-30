Return-Path: <netdev+bounces-99588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5D68D5651
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F621F24C92
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BAF55896;
	Thu, 30 May 2024 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3EZLpEu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370F184131;
	Thu, 30 May 2024 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112186; cv=none; b=H3tr27GQoi0v2vE43PnUUXO/6CStutCsrNIBmr76dNmpnXiNGYBNfBVLevvZ1m+JWZlQJnehuvtoeoHwH0p6HWCv3up3bQ0OPl1GQQgPiOABGGXnnmszXQTwMx7E3z8mbl3iJhj+2yh7AbJInkMsIx6C3jx6HCNlDo0FZfkTThs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112186; c=relaxed/simple;
	bh=S5ZLn3YP+Ae1I3NDRK6GuB5Vzzi/vin+j0G3JYyNVNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRj+U7gBg/0Rg0L7aptUON8PMXBTGegC33chLTaf0k/tkAJbn/rfWuGj47mWHQQvH0e9DtG7H4ACxD5rTgOqdQ8qErhv2Vm1+lyYjW94w3XGCMlKPAicQkftd0BxBAH9AevdyBab0FvqoFELY3ySaFpxLuF+EkiEsf1OK1K1/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3EZLpEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ED2C4AF14;
	Thu, 30 May 2024 23:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717112186;
	bh=S5ZLn3YP+Ae1I3NDRK6GuB5Vzzi/vin+j0G3JYyNVNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3EZLpEur6Bm7E+erfes/IqHtJceHUtwHx0GU69lCY8bZnxLoPNUd4ZBEEupGqwV3
	 bJJAZyfM/7i8QPyR9hdhKi1kBnjsM/bwg4Y3PBjOn7UqWw97/KQAP3i5paF7gqJ5Fo
	 +mvu7sJLWD1m3okoLFlGVjCczKlbC6TkHG8FBXmRVwTgoN5CFazKsswAFaH44OpLR7
	 rqF06a7S2nz0cyPcV7/tdEbTJhhee4Ak4G4FSrXHNSZHNMGvbPXnnrg7vv1nBuuH4c
	 D762TnPSE7/PJh3hdHO3Yvnh6B0cu0+D3x4NXStx58wUymNRGBbB8/D/1tXkszO92S
	 iA8305VdHYZlg==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com,
	pabeni@redhat.com
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	borisp@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] net: skb: add compatibility warnings to skb_shift()
Date: Thu, 30 May 2024 16:36:16 -0700
Message-ID: <20240530233616.85897-4-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530233616.85897-1-kuba@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to current semantics we should never try to shift data
between skbs which differ on decrypted or pp_recycle status.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 466999a7515e..c8ac79851cd6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4139,6 +4139,9 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 	if (skb_zcopy(tgt) || skb_zcopy(skb))
 		return 0;
 
+	DEBUG_NET_WARN_ON_ONCE(tgt->pp_recycle != skb->pp_recycle);
+	DEBUG_NET_WARN_ON_ONCE(skb_cmp_decrypted(tgt, skb));
+
 	todo = shiftlen;
 	from = 0;
 	to = skb_shinfo(tgt)->nr_frags;
-- 
2.45.1


