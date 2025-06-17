Return-Path: <netdev+bounces-198677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F104DADD077
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1402140421E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438132EB5CE;
	Tue, 17 Jun 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUXR+5G2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E72EB5C0
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171370; cv=none; b=c8eGQCl2SJbpSn06hF3R0zxI++CPfsIgha/SZl+5Wtl7H4Epqw1ZlcJLL/rd1ljUBZwM9jjQK2XWISOzzRprettNnVBii7VwEujXA+t52LNKDMCkRhs/3UEeH/rYEnHU/o33mdqiTZdilJeCJ1WAaeZ/HkttSn0LK0iSEGiVe7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171370; c=relaxed/simple;
	bh=xi/0J0PMhyK2hpMw7V85EB4a4XDUT5f9Dj33hdaiEkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NywqS4mhYL7VhfjudB16By4i5kFQr11JUcSrkGBKM3I5cAdTs7jdX0ciRplKNe89b0KeQCoYibNo9Rl5ilLIvR8EIWvQ51OVCn5SZZHADI1SNfzev6ynR13MGGnDEpCacVldYysAK2C91f+Hgb87cuQRlVWdCsGy1otQZYlUWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUXR+5G2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-adb2e9fd208so1175431366b.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171367; x=1750776167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpZ9g9LBepWtI/50rlGwLCDJm2CZ001eBZvjx5PwPPQ=;
        b=FUXR+5G2XxA4lROflsGehZhcaLnbp6bFDMc5pwt+zSxqjqpW/kfAjBfZS9083PCX+Q
         RZA02RxEKa1KEYoB/R3xi7Kl/JEWA1X3tJGFFH5JoPtrzsF4D3Yuesfd7zLtGXgq/Ibi
         1EgRO1b57/RJ+4voVYIiJZGouVY5+obZ9cjZAhDoqVf8Fu1B5knEDMm1n1DayGw6phjf
         6oQ/mXtx9/+GtL3lbmyC55sAuZnO9Ss3qBsIFQE8Wy/5M45v95bMFa8NVkVDHA7Dybmn
         CN7PnrxH0u4lpUorg32BBHz795fGSp9Rx2frkjE2bMqqGVA89gdveobuLiGcQyXsDNuI
         MD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171367; x=1750776167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpZ9g9LBepWtI/50rlGwLCDJm2CZ001eBZvjx5PwPPQ=;
        b=jdQgp3zsuXU/yo+PjDZU4Pwf5JNn4pmU/XOfKtohRyQb36O74tdsBA3qXD2HdhI6X2
         aHAadk6iSq4rGKLyPUFCRHc4MyQjKfTy8duHJY5kQeuMAfUNM+BHYI2VIBn93QJa8yO6
         5QY8lzb14EiWZGs6pN0RQW7vr8Il0L5IErcp2LsIT7lh0YEh82m+UX0/H48fHNMPx9A4
         /Gw7LWmUDImtVTIznDq501+4YVmUAU50TCsc2YAAP+9ryQ74QnIFFPbMJPtc658pkXX2
         WPd41uKetYLSRwsM2sHkaPRuMCmRyIgdayQDFKrO/JigXWw4ZsNPrVQNOl5muzmTFp2c
         6FgQ==
X-Gm-Message-State: AOJu0YxysGDyyFXiIeAK5e2bv6P51I7Oiu+mVeizA0PJIGVUGJ/SXEKH
	gfVnVajYzrYigIAiF3h1rKCUYmAAfurOAhnbegKFjr+tDQmqkOrwp4MP
X-Gm-Gg: ASbGncsDttu01akUt4S6e6dvCQ1yqflBBjjUXd3aZZw4PUL7meFTsc/xkeD+fcfnK94
	ovexf3wBHuJf2BiJC8iWZNkBAhsckM49g45JYwKwWT+YUwAe2He4K95HbnaEEE4gnXQ/89mrym9
	I5y64MkeNI7UzY0mI9kwXtSB5Y/y1TSw3bhZmFqu7H9EnlcOPbpMr1Ov0qSSJkbqtMbXmNarrpw
	0nD+vWHrXfKRvxpopTu/hXWVV3+Lmg638chYKPmKxvm2833JEIe2UQfLpjp2BH0l+CsQLCiNFq4
	xMY6EQdAKB+cXR5jkIsY46Su9f/tqSZ91/GM7xOiK9D/siLgrBW8SEqMCQac+pLbGG+Bv6kM1kJ
	uPKD6GU/qlj3I
X-Google-Smtp-Source: AGHT+IGNTqc6sFueTDTgrgFGYl3ue4NCmqn4JUYyD93oBqqcxpi3syO253TQmaLuTMixY2hgOWuRtA==
X-Received: by 2002:a17:907:6e8a:b0:ad5:5b2e:655b with SMTP id a640c23a62f3a-adfad3d9dc0mr1436358466b.25.1750171366573;
        Tue, 17 Jun 2025 07:42:46 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec81c0157sm866924666b.48.2025.06.17.07.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:46 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 09/17] gve: Remove jumbo_remove step from TX path
Date: Tue, 17 Jun 2025 16:40:08 +0200
Message-ID: <20250617144017.82931-10-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
unnecessary steps from the gve TX path, that used to check and remove
HBH.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 9d705d94b065..e7e7adfc9b47 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -925,9 +925,6 @@ static int gve_try_tx_skb(struct gve_priv *priv, struct gve_tx_ring *tx,
 	int num_buffer_descs;
 	int total_num_descs;
 
-	if (skb_is_gso(skb) && unlikely(ipv6_hopopt_jumbo_remove(skb)))
-		goto drop;
-
 	if (tx->dqo.qpl) {
 		/* We do not need to verify the number of buffers used per
 		 * packet or per segment in case of TSO as with 2K size buffers
-- 
2.49.0


