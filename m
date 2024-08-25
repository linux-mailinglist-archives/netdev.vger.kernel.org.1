Return-Path: <netdev+bounces-121740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DDA95E4C1
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 20:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F9D1C20A97
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 18:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38DE1714D0;
	Sun, 25 Aug 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsy+1cDr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9359F153BEE
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724612000; cv=none; b=hqBz3InhIJBGk4KZ4sQ+2UhTPj6vFkwZCoDs3nwaLNe47Bmw9u88HU5a6B2wpC7NWWvpFf2n88UKJz44v8EQD5ulCwuQygny0LpxXCAWkeuc8bvJaLKBKVVYuTnG+rYjXb5Hbu2NXrSrt/oHp4/RNWaRmIADvugohe+yb3aGxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724612000; c=relaxed/simple;
	bh=ue6WPVo2ptKZgCeNkE1VgO0ePkeq3s2Ko4LKgOeSSVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB13YFkqjmqCmRsFNOESqQNacnmOqEyS8ry4Z9hN2Dkh36K9xxOVegZL6uj26ObykMffX6yKdKY/Mv4qbyxjmSQk1cYMgNtqD1FisqBeUWwjwvCApGB7jAmzM5dm26T1vcHyVRqycJOjgn7/aC+3YfIPTB21xIj+4F42ZwgcOAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dsy+1cDr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280ef642fbso4526395e9.1
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724611996; x=1725216796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMtvRXV/U3e/l+PzLA8fY7oKc3KTxA0nshrMdnXdyGM=;
        b=dsy+1cDriM61W99HKvwbK9ei2CQxz4x+igKMXXdEZJEfsTH1l7CFeaUsfcnDes98fA
         E8laq9bdkor1LXurWQmdAt1wz1m8e6V1zs7gZ4WqhUG1IbldkvAby1I/kpY/nfokt6WG
         FnhkKmR73l8UpKEreEPSIbtEjl0wrcN3L7Sjk1zSjpiG58bgkN450yC7mbRma47vDSiL
         l98bpzA+J4up//Zh3hspwOF5IS5+BlLLP3SRW35x9qK/rDzS7MgLyzCcyx8+MPibkiQD
         KiXY6vHC9gOL7B4YSrIBSbVQ6FUaeR+8XW9bHlhONRduJD5GB68Wx1JzsN9Y762XbKMx
         3Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724611996; x=1725216796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMtvRXV/U3e/l+PzLA8fY7oKc3KTxA0nshrMdnXdyGM=;
        b=NN3nqhqe1OqgAADuDt695lFmnE2XfBiYIrsXdO99kXQAFr9Qmzu7/dNk6yleMsCfpR
         +fgTXJNKvrfkMRFe9LBKVACZAn5VJERVzpJ4tdLeC85kbUf9H6ydL5ArKTJSFGilZLQ8
         H4hoh+l6V/mYYyIbslMuH/l2/UJWaJ8mZ7Rn8Xmq1v8/8SkdNX7fJ4EOQxoNfyZN37l8
         6x87xvcoe6OaEYHw1fVbTdiDtx2G+4xtOnDpHtlFlvWXl2noL9sTdMkH1IPiAPx3W1jB
         JXmKJIOTLa3HYc9VBPEelEN/7xnwGQsh4hLw0z0Zfz3ZfG/bpaByKodFfXLs4jxbm/fr
         AO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/NV42zKGMcDGCHmGb2GzE16kZfRgL9as0t7O3xADoT5TnwfZsfLD/B/aoinoC1Ys7Ggj3fYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+QIGUQYt546nLLveWxqdmbKli4A+pYZT1R7MwNYnBcBSxW6w
	WdIV0nkzd+13YWK9O98WrdjLVKqoFk8wItiqPy+SlPSEYWMWeZ1r8u+kSGCgMJ8=
X-Google-Smtp-Source: AGHT+IHyucbksivjR3R+yNUkpfBIrHJ9f9srz6KIurInP1xh+ETGUBuv8xZhVqT8mODj3jZN4xEo+w==
X-Received: by 2002:a05:600c:1c9f:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-42acc8de6bamr34058175e9.2.1724611995709;
        Sun, 25 Aug 2024 11:53:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810fb76sm9130963f8f.8.2024.08.25.11.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:53:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
Date: Sun, 25 Aug 2024 20:53:10 +0200
Message-ID: <20240825185311.109835-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
References: <20240825185311.109835-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver is leaking OF node reference from
of_parse_phandle_with_fixed_args() in hns_mac_get_info().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index f75668c47935..616a2768e504 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -933,6 +933,7 @@ static int hns_mac_get_info(struct hns_mac_cb *mac_cb)
 			mac_cb->cpld_ctrl = NULL;
 		} else {
 			syscon = syscon_node_to_regmap(cpld_args.np);
+			of_node_put(cpld_args.np);
 			if (IS_ERR_OR_NULL(syscon)) {
 				dev_dbg(mac_cb->dev, "no cpld-syscon found!\n");
 				mac_cb->cpld_ctrl = NULL;
-- 
2.43.0


