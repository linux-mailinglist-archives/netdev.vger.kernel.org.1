Return-Path: <netdev+bounces-251140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6861AD3ABED
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 114C13013C7D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C166137F0F4;
	Mon, 19 Jan 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrzTy+0+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35D1ACEDF
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833010; cv=none; b=ufnaG5b+MjWwgJbXR26F8joYshJ1RVip1t1c/NpcSbSTG50ZWLJ94U/C3/S3ui6ZJY2otESMj6JkBckHrwTsrpFUpC46O1YaiGuZ17mxhQHcRVkcq6OZUo1M3BmbBXJ0wTq6rDIg2fpCHMxWJ/KcHfEwkUQft3czvIzeFbPeoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833010; c=relaxed/simple;
	bh=FtP4HAYvFWkyxpbF+8WjWH+DpyL+6HYbs2ci02wcDtY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aeLO6zMveqw6NsU2VONwQRETfN7OU4Xz1ZIHiGqb34f2etQBfMSEtGOPSCOUxjpQBXeDDZFDs9X6vd4L60bI8aDlSDDD9AFkG4bwP1WfLT1kwZ1XKZ4vPK+9UTURu6ieY/iD1KTIs1J5TMxYPUM8Sq3fUdDb5sd+X1MREoPDyKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrzTy+0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617D9C19424;
	Mon, 19 Jan 2026 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833010;
	bh=FtP4HAYvFWkyxpbF+8WjWH+DpyL+6HYbs2ci02wcDtY=;
	h=From:Subject:Date:To:Cc:From;
	b=OrzTy+0+AAZnH4eZqb+7ua0jmxATU0W9SRfJ2LXlofX9HQu3TNGY4e9a9O3FrElF9
	 swn9J+sSBGIajRtFrA9N7Eezcu1Fk6XxfsgOPBBX6+KvbEafB0jfUacaB2V52Vz9FJ
	 +Q/WFfowtGsi8UV3eoLEDDXBP8pxg0JZyxsJyNXQL8k4UMbJ87P7dqoIfGnmsaKmDA
	 yrXoU+c7CbNKPmjJCc7W9mNSdDSM8KIcipbwZoqMGoD6p2xyoRkE8H+dNDI6Zv66J6
	 B+3XJmO3SvXywmbjMB0skNK3+u1KqNU0nW9YWVpAfy6iHaPAFFAZrMq6zViwR6V3mK
	 Ihcj/eG9lTmTA==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v2 0/4] net: dsa: ks8995: Post-move fixes
Date: Mon, 19 Jan 2026 15:30:04 +0100
Message-Id: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6DIBBFf8XMutPw0Ba66n80LogOSmzQACU2h
 n8vcd/lyck994BIwVGER3NAoOyiW30FcWlgmI2fCN1YGQQTN8a5wiUqrTu0bv9sEVVrRWcGaVt
 2h7rZAlVz9l7gKaGnPUFfzexiWsP3PMr89H+amSNDzkyrpWVS6vG5UPD0vq5hgr6U8gMLK8W6t
 QAAAA==
X-Change-ID: 20260118-ks8995-fixups-84f25ac3f407
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

This fixes some glearing issues in the Micrel KS8995 driver
pointed out by Vladimir.

This patch series implements some required functionality
and strips the driver down to just KS8995 deeming the other
"micrel" variants to be actually handled by the Microchip
KSZ driver.

If the KS8995 should actually *also* be managed by the Microchip
driver and this driver deleted remains to be seen. It is clearly
the origin chip for that hardware: it is very close to the
"KSZ8 family" but there are differences.

It definitely has a different custom tag format for proper DSA
tagging, but I have implemented that: I now have to figure out
whether to do that on top of this driver or the KSZ driver before
continuing.

In the meantime, this patch series makes the situation better.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Do port_bitmask in another way and fix a bug where BIT(port_bitmask)
  was used instead of just port_bitmask.
- Link to v1: https://lore.kernel.org/r/20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org

---
Linus Walleij (4):
      net: dsa: ks8995: Add shutdown callback
      net: dsa: ks8955: Delete KSZ8864 and KSZ8795 support
      net: dsa: ks8995: Add stub bridge join/leave
      net: dsa: ks8995: Implement port isolation

 drivers/net/dsa/ks8995.c | 317 +++++++++++++++++++++++++++--------------------
 1 file changed, 185 insertions(+), 132 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260118-ks8995-fixups-84f25ac3f407

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


