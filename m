Return-Path: <netdev+bounces-245884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 061E3CD9EFB
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 17:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C4B1303D9E9
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008DC33B6EE;
	Tue, 23 Dec 2025 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPO1QXmK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7732C30A
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506989; cv=none; b=NMy1kCU9JrQUI8S6OA7DVeAa7QD1xf+nylYL8LOv+z2o+JL++Nnsak1V/PqyekSBKoqVG3jbgolmCEbaNgk3M+kXwXStZnZ6lAnAkdAoCBBIX4ziFdjF88MqQ1xbO8YnBNiY2SVDDGryNRRgqJ5vyK/oVeSKuWkL4i2q9bGKvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506989; c=relaxed/simple;
	bh=GKPaNY7QWTY19RuVeufMVEXbo/uVc4+Y/Ah38ODdTZc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq796jqKMtEgXRMDcs4eGJmmqp0WHUQWDfX2/wZfOsdd228EfHtkkgsiD3omhhNICTUn/Bi6zA3SekrKlflZljOKp+gi+SWRxqb1X8Cb4PkBovY1q+In5tNJH8VFQ26zebGgTlG5jM3B85sqtW/DlM/4CVtBZ/MbQypYrhtAcKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPO1QXmK; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7881b67da53so42625017b3.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 08:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766506987; x=1767111787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxTdv+ra6WTSrvAACCD5473883LzKfjRBEu683WsRJ4=;
        b=KPO1QXmKF0lB4WIpRSrEqMViusHH8RnNZqtPaCCtIIU/LoinZVMUwseXnn1PJPxPYe
         T6jZw8xavdCndk127FPSAV0Oz/IuoSrzSU9vUIDVQv8fiZxkyFTdPpfl89W/hhe24jSC
         nSx1BNRNM/kShnqs2XM8EpCXj5qC6JcdXloyPk25IdqSF2eA+VovGXXZ5NUYS/sEttdm
         duCyw133AN/lLzlPR/xOhwl2AK517FfZS14iHo/A2shQz8oVV9k5bq4yJaczfGk8LKJW
         aICNmKFiztBwiydJmB9Sk4ujx0jnLVJZ1gP6OUHGF3iCjyA55MaFf3QBgy0xw24Lzuke
         xY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766506987; x=1767111787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QxTdv+ra6WTSrvAACCD5473883LzKfjRBEu683WsRJ4=;
        b=a4/02AcKtvmTDj5tcDWlMWXWYSNsWNsX3a/do70cL7lrYYF6+UpPqd1KWcy9SJiRdh
         4EVnjg0PgdjqoVANj2gKQMppcfqcN3UowslLM3MLtn6jOdNVTq+ms7oYiWe3UbkJitJx
         UpjJI3FntrWrHQTz6r4+ZGq5wysCzDhNUvA/1aru+RIlGlS0AsmxQLf1oCyFErj8vFzG
         8pjgJoHWnDnwTEs6ADJ7XBGMfEjEeE9UxvLmxOn7c9FC6UENcT/XoalrXhxLN+oJXRrq
         f4qr0aM81l49W8G5YtaKw/4btPOKnsOuQrM0kk1yxdphuQnW78UcfsZBexbPb6wKN5rW
         j4jA==
X-Forwarded-Encrypted: i=1; AJvYcCX3phupbNSNwFmnsqJMaaBDRR4O6Ma4x5IaYIyj3OxahVWUqLnHR5IdA1diqjd3gI0kESdM6Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyttTbxKQz36HCf5fobW0ptD6dhnHWesRMyfpYP0rweXsvYOUg1
	jZ7DWUA5eMYraPBpzKXDzLnCPVHE2sRaFRZKhIym7AzffOgjfuYWbASg
X-Gm-Gg: AY/fxX6BbuRBpFJJW1poT4RPzLqihkGnQNYSOlygi/xnxRDyh5Di/hWPyFib0ihRF/c
	AD3mJsS25O6lrhaTGs5uKo96naHilK1RSu9PldDKP9Thd/YpiydDQnGCPEZWhLMg+ccUIFV5MI/
	OJlK0XM7AKL41D99r1ILKRaYMkvORugWv14WgHNVfQdmsvyw4yriAOooDUR+vEqrO/s4JpaHf87
	6cTJ15shGtgfKpMPJu6m3wSh9ohwDjRFiOgBb32OzogZoH1Tag2D02bMVFzqNdD2OaeRencQTr8
	U0tTWhAxSPoMFP0OKvdRyPBca8/v+Xhwmyqsms8vs2ZMoDY85LRknqvBsUpfkzCfLwEkJ7tFTU0
	YM6sdbnNLJfDlmSdiL8Dsq+XLiIwxylUgwIj02qZ8sv1JpKLbUT4OH51PLuoiYcXh3JzhmmqVav
	AKSsD5pHU=
X-Google-Smtp-Source: AGHT+IEGEhV4TsQdUzp8xMXw7tvphhY7j9O64Fl0+gPJd1P63myvvp3KKR6dH1soGRGdQRJHWMAQUA==
X-Received: by 2002:a05:690c:c83:b0:784:abe3:4454 with SMTP id 00721157ae682-78fb4067fc8mr122715137b3.47.1766506987336;
        Tue, 23 Dec 2025 08:23:07 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:4913:14a4:1114:ff0d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4377c99sm56081067b3.3.2025.12.23.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 08:23:07 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ice: use bitmap_weighted_xor() in ice_find_free_recp_res_idx()
Date: Tue, 23 Dec 2025 11:23:01 -0500
Message-ID: <20251223162303.434659-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223162303.434659-1-yury.norov@gmail.com>
References: <20251223162303.434659-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the right helper and save one bitmaps traverse. 

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 84848f0123e7..903417477929 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4984,10 +4984,8 @@ ice_find_free_recp_res_idx(struct ice_hw *hw, const unsigned long *profiles,
 			  hw->switch_info->recp_list[bit].res_idxs,
 			  ICE_MAX_FV_WORDS);
 
-	bitmap_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
-
 	/* return number of free indexes */
-	return (u16)bitmap_weight(free_idx, ICE_MAX_FV_WORDS);
+	return (u16)bitmap_weighted_xor(free_idx, used_idx, possible_idx, ICE_MAX_FV_WORDS);
 }
 
 /**
-- 
2.43.0


