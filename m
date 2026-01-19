Return-Path: <netdev+bounces-251012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E186D3A240
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC82C3040673
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5934F3502AA;
	Mon, 19 Jan 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RxaqWGhc"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD27350A19;
	Mon, 19 Jan 2026 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812895; cv=none; b=bAUxVfKtcs4jAM2H3TEbNPlcbQ3ur+Nk4h8Or7sbElmwPEBXzYwUIk8cwXZTKg/B0h6PIf+ujp7tC8zip5ENx2oyWmfSxoF0Hp7kC/w1fethekAuvwThcm8GV+3/dFfpV3xDiQPwe2XqryQHtFVOVyWawPLXmofzHZ4CdqsfItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812895; c=relaxed/simple;
	bh=LzcMArRqWgQcXTYwxwzbB/77qDsZHUl+i9EJBPhIESE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtEFznKRj5D1RP/TONTS6uvNPVl3socqm8BXoWmvLrEGb6FCw1eV0QcVpnbFoujaBTy/7/un4MHIbsmdyOOxzobLHP3pQ+SmlIPHtszrQevwWCuVLNaTJEeS/LztRw6ReYXFhFbDSUJJgWIQp0rDtJ0jpwcr6DUE9nJAW1h+q6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RxaqWGhc; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 43D5620660;
	Mon, 19 Jan 2026 09:54:42 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 98DJpn7bfa6I; Mon, 19 Jan 2026 09:54:41 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id ABB3B201C7;
	Mon, 19 Jan 2026 09:54:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com ABB3B201C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768812881;
	bh=/JZWnbbYRAp9By2lYmPnf7Ew4d2bXhxV2boUsU8eHb4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=RxaqWGhc/1vTeoONZe8cRa3yAbg5pxMEDzGMLOaHJuwXovhebO5dEHa6P612pVM0x
	 g1z3l2bYerloX3Bi6hDFUztbnwgQUag/96I9/f1GI118QDG1HOxpXkGsFPBt8xy5eC
	 SoOeg9eQHLizE4tlTlMW2r23LPI0dZ/d/NdnAdLQXwfsHRKoAY9396WVKgJAJLTSUF
	 CZ+8nQA9gyJwVYcLde/sXPDGS3SeTaG58UFjPZJo7uRv0OC8PSbkd0dZAdmAzDNHKR
	 YG2NuqR7IukmOUC3OGZ1PWu8l1NRpluZbXPO4K4fJD5huB2LpcDTmuXI2dVmW6XBo1
	 vt5NAc7g6tFqg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:54:40 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next v4 3/5] xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
Date: Mon, 19 Jan 2026 09:54:27 +0100
Message-ID: <1dca41a449546d20a236c517272f2d6a34510deb.1768811736.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1768811736.git.antony.antony@secunet.com>
References: <cover.1768811736.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)

The current code prevents migrating an SA from UDP encapsulation to
plain ESP. This is needed when moving from a NATed path to a non-NATed
one, for example when switching from IPv4+NAT to IPv6.

Only copy the existing encapsulation during migration if the encap
attribute is explicitly provided.

Note: PF_KEY's SADB_X_MIGRATE always passes encap=NULL and never
supported encapsulation in migration. PF_KEY is deprecated and was
in feature freeze when UDP encapsulation was added to xfrm.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 4fd73a970a7a..f5f699f5f98e 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2008,14 +2008,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	}
 	x->props.calgo = orig->props.calgo;

-	if (encap || orig->encap) {
-		if (encap)
-			x->encap = kmemdup(encap, sizeof(*x->encap),
-					GFP_KERNEL);
-		else
-			x->encap = kmemdup(orig->encap, sizeof(*x->encap),
-					GFP_KERNEL);
-
+	if (encap) {
+		x->encap = kmemdup(encap, sizeof(*x->encap), GFP_KERNEL);
 		if (!x->encap)
 			goto error;
 	}
--
2.39.5


