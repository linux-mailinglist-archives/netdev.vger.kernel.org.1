Return-Path: <netdev+bounces-180096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260CBA7F92B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A00E3B3BEE
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40D21ADC3;
	Tue,  8 Apr 2025 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="YKdHt5h5";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="JbWIdq+j"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9161264A77;
	Tue,  8 Apr 2025 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103768; cv=pass; b=kP2CgEKLRkbDX/yu8bfk9Fe0vwg2lvnaWWACE1cd9XSM50QKqn/l03jTiF8YF7qJKyAIE765knYromBcXnlopaBdTuY2/lqMLR/jUbK6a2ZQcl0CO1BtSjsMYfMSVoUqnSYTiisoFf9Kmci8hIkbfCBG4g6qyNQrPCTAmbjATUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103768; c=relaxed/simple;
	bh=j06atkAE5GaJghbZbm7QfVldihTFSd3UlHN8BHnQW38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WphHL1CGpaMFEyzF7uJI2m3CPfSEkcMv7F88+aVVP53TXY5lGRiXldokRI8K2cfFxEQzjXpZ3pfr0hQaU3yqK3UP4d0siIzCe22n8HwzEc/mjLTBhdBqrwqO0yZMbWFxkq4EL/gqUnujaM8S0klkTF/ti5UCPlHEsAxSBZCLl2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=YKdHt5h5; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=JbWIdq+j; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
ARC-Seal: i=1; a=rsa-sha256; t=1744103756; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Lnj/+Ab+BInSFoJPRhY8Ez4a8zIb2BsVZj0QOZzYZO4aGE+W+MWvcsaJNIFDn9DJ1R
    d0SKg5NrMu3qW1hzBq2JltkhgeH2FrdRr2/aBGFPBkJlcXeShFnSi3fUa8gUTcE4qO6w
    izhEFXSJ/rf+hrAaKY0lkrjRLberkAPU+vSUfrhhUQVOdhVuQGLuQ0cWh1Cf0A51kHhm
    3ullM0pmWbYcnvIjSBqlihwGhpUOaCiJIQ3xW9lIe/0bEa0hbPeZ6FLsL9G6XhF9sXgC
    KwFmqTCLogsfBDkfqE+vsCQpz/aFEIdc+VJ1YIGoIYJ0FIxi7Ij8rzIh13AKmcda4LUI
    PITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744103756;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=JH7bAes1a5f2oruGiUBDVJZHj7HNc2J4ERrWSVZgLYw=;
    b=ox7qEDu9c+9pGu9ZFd9UA5D7mA/tDOb6yleh5Yb59PksyDFBKVEXZ4aMm4dTGuGtPW
    /Bhh9hEB9Me2CSzYFYL3yko6p6IBtRXRed3+Vm6hqGtLwpIkbh/XXRSMHfARiE4uJhuj
    KpijiiYIMwm7Orh7RZIP2k8t18M/ZAJColUgibootAOGrou6DSHY6LkqX7wm2XaUFyvJ
    d+H5iDBYwUXLqIUo6ddWezW5i3Lg3gKZ4lg6drhVtFLRejThy5///rHxApmwY4LLNP8i
    5lVqTIxeBZJ457HxEFmMnFXwhWQrLa7sYwN/WljdpNmkK5aAiTP5k+nkov9zB51lSbtz
    gAWQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744103756;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=JH7bAes1a5f2oruGiUBDVJZHj7HNc2J4ERrWSVZgLYw=;
    b=YKdHt5h5KEWl9jZf78YV6NH1uPcqvkWqZcz5G2L2C4wdPzTBBvvNby1eZk58nEQJfX
    r++2aLRB2+S/1QY9drnS9+BPuGDJRD/tIbjHmf7GXefHLc1yvDTAdEKdwO5R7ppb9Pdw
    9njCFRYO/0+DYO7lSpN+JoDpJjbto+Vfr/mNgBxKvd7CeYehhNtsMx2M6Olhq9JXyqih
    GndiRc2x6EcjhcJ8CblvNAlS44vluUTDLuXt0Gm/O5DS2nyCpy8gd9EdLtY6/erE6tRy
    zkuuyXacc1aZUbwiRmAhgN2Xp5kXSPwMAjBd/N0p//UfqOwHptRPpChFxvyRDcZprciN
    otXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744103756;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=JH7bAes1a5f2oruGiUBDVJZHj7HNc2J4ERrWSVZgLYw=;
    b=JbWIdq+ju8+whTyI81mm2OrXkaFXB3HKVsyuzhzMeQzOLqPJAjPbVG+NzZzuNLKe+W
    yxJu69g/XSw45vLLPEDA==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J2b1101389FtX7t
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 8 Apr 2025 11:15:55 +0200 (CEST)
From: Julian Vetter <julian@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH] net: remove __get_unaligned_cpu32 from macvlan driver
Date: Tue,  8 Apr 2025 11:15:48 +0200
Message-Id: <20250408091548.2263911-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The __get_unaligned_cpu32 function is deprecated. So, replace it with
the more generic get_unaligned and just cast the input parameter.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 drivers/net/macvlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index d0dfa6bca6cc..7045b1d58754 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -254,7 +254,7 @@ static u32 macvlan_hash_mix(const struct macvlan_dev *vlan)
 static unsigned int mc_hash(const struct macvlan_dev *vlan,
 			    const unsigned char *addr)
 {
-	u32 val = __get_unaligned_cpu32(addr + 2);
+	u32 val = get_unaligned((u32 *)(addr + 2));
 
 	val ^= macvlan_hash_mix(vlan);
 	return hash_32(val, MACVLAN_MC_FILTER_BITS);
-- 
2.34.1


