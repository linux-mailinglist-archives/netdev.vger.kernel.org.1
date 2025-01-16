Return-Path: <netdev+bounces-158969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79E4A13FE7
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A563B16AFA4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F2A22F39F;
	Thu, 16 Jan 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kocE188b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791822F38C;
	Thu, 16 Jan 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046479; cv=none; b=EHpZKd/veX97UbkrvfadciW3aaIs8s16PQuBPpg0nGlMA4M1QzPkm6g3wQ7utC3LaKKIN+qQOtbmv2SJheP49Eb2U58s6HSm+lioPcyd8Rqn693Wkk0L5zwuVzB19YMU67JQIaTZhx3hJAQsF4L45SjCp8/1E8rCyqxlyiJaJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046479; c=relaxed/simple;
	bh=B/7KR3jBwTwNArI5wXpFWpYyFwZ/q/RqH8P6VfvLqUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqlKU+8B0IdIbP03CPPGgSKaNRlpokoAb0jcWWZdXPOFZGlN4+zEWIbHf4ybAgGrgn4Ualh0UU0zV03xaniPRk9syUecwuabfrrz8oUmz3/7Xl3sqSdaovz6Hxk9Hd6u8tBtz+hgP4VJAKgaAl+chjv6ewUuet0l+9zhS2zQln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kocE188b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C39FC4CED6;
	Thu, 16 Jan 2025 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046479;
	bh=B/7KR3jBwTwNArI5wXpFWpYyFwZ/q/RqH8P6VfvLqUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kocE188bKrxqczw35nkntL1/h5XiHxLaaJWv6+N1L/0mLxvsMU5MypQqHJTszaJyZ
	 kKe1yso05A8So0A1DEJxrIH7RJnokYQssze2m6XkZH0F3QDNsVfmCXgUgpdmp7Liv2
	 UoPak1BAKHT2GAd48W8SozgqmOTgSE7FnKeUmlujSkGvKCZK4u1GMfVqKmZ4L7iO1W
	 yRRVkUW0TXzokPqI+9JU3s5J4lW8QLJgSvPgsE5QJTpH8RPGkkK4zou5NJfH46yu0S
	 dQXoDqPHoodGuJfd1N5qZHnqhEkk73YGjJlS7aTUalKUwQiKzrN0QkibTf9Potk5Zr
	 nlLIi+grK8d7Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:24 +0100
Subject: [PATCH net-next 02/15] mptcp: pm: userspace: flags: clearer msg if
 no remote addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-2-c0b43f18fe06@kernel.org>
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
In-Reply-To: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B/7KR3jBwTwNArI5wXpFWpYyFwZ/q/RqH8P6VfvLqUs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnG4XnKMZnZXgKIw/bNiM6dV3QmPZNtyBlaZ
 vaXtuenvy6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xgAKCRD2t4JPQmmg
 c1yuD/0fl6XOA2/D9kN65aKOsvLheImK0w+a8hO8IqcY5pNYR8/9swt9kTlhJvl/UQvmTxdGGQH
 vIOfKpB+mVlxPVBigECUw29aGo2tKGpFtajpYfWjXwBR9LNYWALlTX1p8WgJYjQY1JR2+7BXImt
 DsGQK0oo55k0FIT9LZTWtSaGWIj0x3I3U0VaOK1Fs9h9ZmIw+MUb0bcOU5oKH6dAYFf4JBS5ttd
 b7PbRfDytyTcx/2LNiwKEtj+72RUiI9MqB5hSLghq/Eewhl8fvZBOjfFru9bzaPRctbSibDgHFX
 K6GDBP5fALJu629ODLEVzJCA9rhuyC3py+X5FajskUhu7Z2DGAnXXDigfdpgZ+saB7+0EzsShg5
 tLAO3yefNbhRqjUVORWXJ4atdricCKXyfkRGImPtz7sdOqXm48tQMTd7JklZgBM81/GFIOXppjt
 R8TtVUxo0sw4ljIojArqOgPJO2g1EipYI/D9gyR2UTt2hZznohL4lEwMyHVfvI5qnNLKeCNpd1n
 bOeJNC/6VaGUGuVABX4lXTZMnPMVpmKqy85jJuXaoqYSVv46o7cKh8QzZGmJDwdg/uhPt+EaAWc
 deNtVPQ+bGcK1RDzPENH5uURZVMDbWnx9AFMVTdEQbL02LK8g/Efgg+fv0owpzWd7Cn8xVmDSld
 xZTMivj0mBTH/DA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since its introduction in commit 892f396c8e68 ("mptcp: netlink: issue
MP_PRIO signals from userspace PMs"), it was mandatory to specify the
remote address, because of the 'if (rem->addr.family == AF_UNSPEC)'
check done later one.

In theory, this attribute can be optional, but it sounds better to be
precise to avoid sending the MP_PRIO on the wrong subflow, e.g. if there
are multiple subflows attached to the same local ID. This can be relaxed
later on if there is a need to act on multiple subflows with one
command.

For the moment, the check to see if attr_rem is NULL can be removed,
because mptcp_pm_parse_entry() will do this check as well, no need to do
that differently here.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4de38bc03ab8add367720262f353dd20cacac108..b6cf8ea1161ddc7f0f1662320aebfe720f55e722 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -580,11 +580,9 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
-		if (ret < 0)
-			goto set_flags_err;
-	}
+	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+	if (ret < 0)
+		goto set_flags_err;
 
 	if (loc.addr.family == AF_UNSPEC ||
 	    rem.addr.family == AF_UNSPEC) {

-- 
2.47.1


