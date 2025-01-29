Return-Path: <netdev+bounces-161487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36A4A21D15
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E82318884DE
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8861DE4E6;
	Wed, 29 Jan 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDpzv0hu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B11DE4C7;
	Wed, 29 Jan 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738153494; cv=none; b=K2l0xXrcdf09cjZ+c/J5Pet8ZlDAdHVUZvIQpBLnIyXOeffbDprSDKeaynxro695W7/sUe5TCVTK1/86o0JRK+5SwK8/TH+lk5c28GY9wmKdWvAWFUMWoif/5FHOPH1VM+6q4ptRVfw7ztRCgAEMZDLMImQQJePRM3qwttGb1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738153494; c=relaxed/simple;
	bh=PNHY7pB1yKJQHDLat1IUY4AfzP0lAmqKb7O2GOovptA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cz/bcRUjFX/hSBlI/4Cfav89rzGqHNqwTRdf1KtcENyyz189jGGCVagO73Vu6Th8u+L4nk7ZSaMG+za2gUMjhkABfvisg1vfAN7c5NU1WljkTI7GfKWV969fzLqcQFH3XJj28VcG2KaLC1rGaPgTVTyFmqXly99krpd/sMskGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDpzv0hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77842C4CEE1;
	Wed, 29 Jan 2025 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738153493;
	bh=PNHY7pB1yKJQHDLat1IUY4AfzP0lAmqKb7O2GOovptA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GDpzv0hucxjEmCnM++SlsajNodToTDyCP0DrCgdwv2Eb8vy71EAVsv9W7RCV4oOQh
	 gfAtxn2U/bZ5EH17jhJ21MjV/rfLlaZZDtMFzEX5p8sDrMxBU3xYVGkyOk0zi0XyX0
	 Bdts+9kdG8zI5OLWLdMOijTJ4j27US5KkyEY3aOnX8G8UP/mCkpEfv8gv0100OiaVv
	 8pBBB9fNaWowYq8ABEUJouuRjei8u104nFT7edDD2HcRXLZekUnKXrUivsuui6ZFxs
	 q+7auiWpOo764wK+tDALsgjZd1Go9tH8lWK1a/i4S5toJBGhkyEwiy0h8wNhCZ2YaE
	 /ClSimOhqgPgg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 29 Jan 2025 13:24:33 +0100
Subject: [PATCH net 2/2] doc: mptcp: sysctl: blackhole_timeout is per-netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-net-mptcp-blackhole-fix-v1-2-afe88e5a6d2c@kernel.org>
References: <20250129-net-mptcp-blackhole-fix-v1-0-afe88e5a6d2c@kernel.org>
In-Reply-To: <20250129-net-mptcp-blackhole-fix-v1-0-afe88e5a6d2c@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PNHY7pB1yKJQHDLat1IUY4AfzP0lAmqKb7O2GOovptA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnmh4NjdaqXeG6Olh1zwAq7kCKEUnSBTmJ0EThN
 Rt+ZIkUSkuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5oeDQAKCRD2t4JPQmmg
 czrYEACXdgOMfYqlMN7DuMm4EYnPr+T7lV4HhBoy1KHrrcuhBOU6vf6l/Olx0MBZd3QehJvGroh
 651B4IdK6X7CQ91e9mEe/Cu7SmDKW/zLHbobk7cedycc3KxVybPtNMMtsiBRsb8+hFOL3l63QCX
 Ff/X4cThCatY3DMY2uLymA8vPu0XrxhTBnTrO60L7yj1tHxyx1WSF8Kb0E2cGARd7+Z80lF7lqS
 Yf+Z80AnX8su6/G71as0Xc86b55RYinF1uw/SiZSlamyNackIOvCI6VIU4Yk0WB+ss7dWoZduT8
 kFG4I1ryIW098vv2SYRyhQqhg/9bDRqgvZR6CC+tpsmDXx+06cXgv85R9/R4Sh1KjjaR5x6VpG8
 lGCR1y+y81QFD6Nr1vaHr9jyctuTQv61kY2M7ceGXdd+5OBjM5Nnr3a789920n7XqIStceqjxkl
 2Efde/2Efvp6MiI9zJrROlTrJ9qiiVTabAu5hbR0diAud+869VozKFdqzF5qIz1+SKFkyuZTNKh
 E/bUEFjECm3BBGblEgO9yAqibOU+ZN06PT56Lt0B8ixG/1vpRHJ6QSzRsoaf5OjTkVtEYrxn/Dd
 VICm9VKAa5we+aCPB5ezbX20SHv9wYPeaHj56m0S1iReFmiimtNyYnZ8VL+KYwHKzoNAOjmq/zd
 YcVBD1MlNZpaEOg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

All other sysctl entries mention it, and it is a per-namespace sysctl.

So mention it as well.

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index dc45c02113537b98dff76a6ed431c0449b5217f8..03e1d3610333e29423b0f40591c9e914dc2d0366 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -41,7 +41,7 @@ blackhole_timeout - INTEGER (seconds)
 	MPTCP is re-enabled and will reset to the initial value when the
 	blackhole issue goes away.
 
-	0 to disable the blackhole detection.
+	0 to disable the blackhole detection. This is a per-namespace sysctl.
 
 	Default: 3600
 

-- 
2.47.1


