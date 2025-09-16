Return-Path: <netdev+bounces-223389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E5B58FE0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E2F16C35A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE4E2820AC;
	Tue, 16 Sep 2025 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo8QULt2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF841E7C08
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009699; cv=none; b=D/NHUPNz24s2CdG99QRUTNAyAGIzjnzKLS6mTP6VsLajNQTxh2MuVPqqiD53KWwtS036v4rf4hGXQn9vzGOpVKwA+fXR5Bfar3DYm0qukquEXP4UnrdAdarbV/XP7uc2eaU7gbsptjzRaVc5FZSufFLQIWX5m9rcEg2Y+YmX9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009699; c=relaxed/simple;
	bh=mqGWUlZwoHgWBZlqD1VSCCfvMkG1MrK5kSkMIxKISb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=smLE3Y4lZEK45NcUIpmlxpvZKyTEyh6IQ1mjzYucn9QEoUGtB+zOTWffeGECLkpRRbI3KCFtrr1Bw5gAIf+iNBeWI/tXEWNXcCByD6BxogO43tTEktJTJ/8SOTdLx3zwMifehE/RhjHrmYl3hP8S2zuWDVxDbO/e1aGwyPU7pdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo8QULt2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2570bf6058aso67519395ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758009697; x=1758614497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KkCnl+eb81QpaQTTvxabz46F6QSyAUyMb7u48G+yGh4=;
        b=Xo8QULt21Ot749bYDkGC3bRqgcJ6zgiusT6ophYIAB5gnC37YhQUT+KlT9/yeF81MY
         orW0SkAUM8l+CyEhasxkNkeS1ARDNIRCq17am9MGqgO8TbNmmY82DLaXdgKp4+ZXmMq0
         SdFhJqe7B+jAwADfSiratMsja/oCZLkR6BagQKS+1VS1FNh7fqb/Bbvg55OLWkMJH+fV
         7Y+y0Ew0rtsuZu7E1/oka9/MDao0IYfvkj7vFLIzY7bgrPs/SYZn/fnv2CWIK0ob6tmG
         jwmt5NNgGw8YXgW6DJ0wuZwk0YN3gr4RX0RhTB1anxL7QrHnU/e7zGasMUfMESnjGuOI
         Auag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009697; x=1758614497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkCnl+eb81QpaQTTvxabz46F6QSyAUyMb7u48G+yGh4=;
        b=vvJVPWoiOw+h4/g7XVCrwJCa3AjX39ut7+x9rqgqRDSH9X9fXVpseQvbOYzLMDNsAe
         mjNQzHc0Q4qKWeCLmRcC1qWqsiXMpTFxezH44H4rX3wun7d2Cqf2XtmOBr4qGFBd42QF
         FrhBzOThfM3HKhhL3FCYMI4qHkTJ0cNqj7t1HHItMBYifhL6Vdw+nNjOlKk+Gnr3XrCX
         iXX4t5Njk5ElwXI46cUkOUVRb3osqoyrNHGXPWZub3KZC7I6C3ZgJVv4EeHsDiwBDxO+
         UAUHGgTIwC1isLNvCXa8j7v2quli/12qcTz6CBoL5jPyP5WMmEujluamj8OqRT8XqnGz
         vHhQ==
X-Gm-Message-State: AOJu0YxHFX1ZDLTqUQ5T8y2hOI4L0Zd4uvjPEp4nfKvJKVvG9+fS2iDE
	kCEmcW0J10L2SLFNTgEqD1Ot+NT6ZM0XlQ6GtwukMTvy+l7MLFvlIhSak8rPZfE0juM=
X-Gm-Gg: ASbGncsTz5sneSz7YkzKqxa4nvvxVWIB3+rdsmW1TMzOe2HPHWWy2qyey3yKNFlfOiS
	pRcnXEr6RGPqnzxtH4ABRhTzGtOftmoclZmb5c91BRtYoHMGi4LqCLXb3WUuU4FmAmDVQGtKEiz
	MCXi40yJ4obvtCkOKsCbfbBYp13lzGw64Q5AI9lMEDhndMxQTCABEilTSIDJE80SJW/+SF7+cSl
	helF8iHGimzDdOplF8wcDaxO6BpVS8LIIeKiMBn6TRThYVbHe0L0CLyDZv2PAOFoMmn/GSOeO7f
	ROQp8CyyXKNjj9Br9kBy72M7hqX+j0JCmvr5TmxQQWGITDGBGJ7PDM+rJK5G/lpCVUxTIUKI4Qt
	apav2Gd7lr0AIzV6QZ7QgdtkO1NSOn7HXhkHoeeQUVg==
X-Google-Smtp-Source: AGHT+IHrLCCMrzbdvoWaPHSumLlPeKBEv6ZsmThgKihOIt27pHx+wvTkeVOiSm3Ch+x7zYTj9VFRqg==
X-Received: by 2002:a17:902:8484:b0:24c:ce43:e60b with SMTP id d9443c01a7336-25d24bb24bfmr150473565ad.18.1758009697201;
        Tue, 16 Sep 2025 01:01:37 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e37bf1c19sm6826371a91.22.2025.09.16.01.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:01:36 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	David Wilder <wilder@us.ibm.com>
Subject: [PATCHv4 net 1/2] bonding: don't set oif to bond dev when getting NS target destination
Date: Tue, 16 Sep 2025 08:01:26 +0000
Message-ID: <20250916080127.430626-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike IPv4, IPv6 routing strictly requires the source address to be valid
on the outgoing interface. If the NS target is set to a remote VLAN interface,
and the source address is also configured on a VLAN over a bond interface,
setting the oif to the bond device will fail to retrieve the correct
destination route.

Fix this by not setting the oif to the bond device when retrieving the NS
target destination. This allows the correct destination device (the VLAN
interface) to be determined, so that bond_verify_device_path can return the
proper VLAN tags for sending NS messages.

Reported-by: David Wilder <wilder@us.ibm.com>
Closes: https://lore.kernel.org/netdev/aGOKggdfjv0cApTO@fedora/
Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
Tested-by: David Wilder <wilder@us.ibm.com>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v4: rebase to latest net
v3: no update
v2: split the patch into 2 parts, the kernel change and test update (Jay Vosburgh)

---
 drivers/net/bonding/bond_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 8832bc9f107b..57be04f6cb11 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3356,7 +3356,6 @@ static void bond_ns_send_all(struct bonding *bond, struct slave *slave)
 		/* Find out through which dev should the packet go */
 		memset(&fl6, 0, sizeof(struct flowi6));
 		fl6.daddr = targets[i];
-		fl6.flowi6_oif = bond->dev->ifindex;
 
 		dst = ip6_route_output(dev_net(bond->dev), NULL, &fl6);
 		if (dst->error) {
-- 
2.50.1


