Return-Path: <netdev+bounces-224620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B41B87219
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 23:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CA61CC310D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33ED2F5A2E;
	Thu, 18 Sep 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvz/hMmB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112632F7AAE
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230847; cv=none; b=nuLfdPrBo/Eg/+BvX0cI40Iz7O2FTIHPLEruejLJwHoijgJFomVyqzk2SUL4BQ1NCoph8soGeKFfF0CeKFbJHLrWtVDB8L4S6QHKz0XfrFMyWiTFJkFK+mI1gZvB5J4pyBtKMv+Xe4EqWEXlYRbC/Dc1reB3BTdZJZRwWm0aBHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230847; c=relaxed/simple;
	bh=Mx6WwJgcJ66hr40c8Ugwq46Wv8wcaujHqNp89ig/InE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xzy2XGV/O22EjQYwlEaAvld+Rol054r/DRnCm61BdyDK/hQ200xxSyMvRAUVrDJERVVjbPzQ2e1gzRkh7iJRoBMfn5k2xWqDgQySkI1VDkcxqYDj8y2LXeabPEM4D/iYkLUAWx6SddAxKQSbTb4SBAcO9YKvDG+yRRKakAIj5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvz/hMmB; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-723bc91d7bbso14373727b3.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758230845; x=1758835645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vov0IKiiUdBNpLSBeS2pEieN7Ns0EZdI/YYyfrKCXdA=;
        b=Gvz/hMmB2ggmd63NQWE/5Q+RpmLwnbTGSKSo3TgIBcgMNCWac2aLBWX5BDkJy9YMyp
         5rOLx3mslhmRtj+5nu4tgsVlRSB5DdH2yWELGh54uVzNdpYTlW159+ZYZeGwcPPUaGM+
         jIEZtRaP1GFuV4H3URemiq4RbhwKKImAa8igWdr3qwrpL0zui9xWvsRmsLMDNTULtbkB
         7vaZPzFaNxhCUu4QxgqFgQTIAcwddkG0hLRdTPKLYwHi3xwBlcQzhnKnxf/6OVePrFJk
         16SzsK/UbSVVC6jXO3QvV39bnh82s4QAfZN2WUm70eczrllYLiF/8UgNWOTBlHsKnqXg
         +Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758230845; x=1758835645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vov0IKiiUdBNpLSBeS2pEieN7Ns0EZdI/YYyfrKCXdA=;
        b=c4VjOuFVlusGGsnefJ4WyCfGdI3lH8e/MB9PkDDSBmrXztLOqIWN2pqEzpIMXZtfbM
         5PTHMopeeGLAjfQMGgM9g7ffBvpv6fep0npyhl7OtrcAi02u5dOIrBRuhNFQMFoC+PPp
         HTr7qO0aEFOIlfJtbQzBKD/yf6fHZ7zvAkBUfMBwPhlPqhbZKTbueSR6mAPaw2UhyaI+
         tzxoikFXARoShY9Qf1+E1RmTnBb+5ue/TMmttLKIINQ0K74ehPcGB9bMJiyPCyFT3ggP
         +9MCEdZ/3gEB5mNWDajGyoVtD7UXLQcfcohxhNCL2/Lp0Z5khPAH4F6Oe5yUhFZ0oUt2
         tJbg==
X-Forwarded-Encrypted: i=1; AJvYcCXYtSuO/vao/qWKn5RWZJG6vtuhvvQzQ9dCNQW9jECXBUrxQxWdPrBJ1ptMLo8sPoMhm5gOTdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4um/dk4t0TyKBm5CaVrUMRW/N9x+EPMLtm2dyFM4dkGtt432o
	iCNwHSvPZR4EdpqqcxS2l6NvVbw3AphUTyL/HiUOhwzpQvdsBtUDHM+7
X-Gm-Gg: ASbGncs3JhUbMmGb2xmd8TZh5VLl2b0M9ZOmtay/p2OW5v8g9adVB7fAYFW1BjrM3Vh
	IJaLL4hw8KRWnRe5C9IyGhXzkVWY6Nu669zW6Fz4Py/62a340g8e7wCTwkMsRJ0G5tTQB15PmqU
	c9oGt/17PsT1yL+66w2bOPziwHP61p8ocFTt5btElumVE3dtpx4FLilTzfCoU5y28JxHnaSDt4I
	t9p6V0mUyT3lL8FNRi7CgNmTyHNjGlRKN1uAaeSOZMUuVF+WeHAtq2PENa/suA5Ysic1bPAyaiD
	hheKF1rboggZdIgeiTe2v6/9+USgV2XdQKCoi4lVwt8nsZ6QBCgK6rdNyJjsovQN35gPD0PDEW6
	dNwXScT36QLWb21AeXlEeJrInML3hUu+5tukis2k=
X-Google-Smtp-Source: AGHT+IET42D7BwEvg6GLTKuLo8/nh3Px3gHlxICY4veupdPIEVVcevMA4Y23Y/y1Y0kXQGfFAWYD2g==
X-Received: by 2002:a05:690c:640c:b0:735:8634:be68 with SMTP id 00721157ae682-73d3760d89bmr9937967b3.23.1758230844740;
        Thu, 18 Sep 2025 14:27:24 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739716bf234sm9797467b3.2.2025.09.18.14.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:27:24 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] psp: clarify checksum behavior of psp_dev_rcv()
Date: Thu, 18 Sep 2025 14:27:20 -0700
Message-ID: <20250918212723.17495-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

psp_dev_rcv() decapsulates psp headers from a received frame. This
will make any csum complete computed by the device inaccurate. Rather
than attempt to patch up skb->csum in psp_dev_rcv() just make it clear
to callers what they can expect regarding checksum complete.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 net/psp/psp_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 0f8c50c8e943..481aaf0fc9fc 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -228,7 +228,8 @@ EXPORT_SYMBOL(psp_dev_encapsulate);
  * Presently it accepts only already-authenticated packets and does not
  * support optional fields, such as virtualization cookies. The caller should
  * ensure that skb->data is pointing to the mac header, and that skb->mac_len
- * is set.
+ * is set. This function does not currently adjust skb->csum (CHECKSUM_COMPLETE
+ * is not supported).
  */
 int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 {
-- 
2.47.3


