Return-Path: <netdev+bounces-209376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFFDB0F6A0
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE716188669B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F76A2FA634;
	Wed, 23 Jul 2025 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emuh77eD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B92EAB90
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282873; cv=none; b=AXdCiD+7Sud89FWBvTEuL53imCn047JV/opTOZx9gRSzulFXb5cG84BGOzd7sRjMNest46uK7nruVCuzDB//bdPhfO+q5HDuyhWYBBvP1+/02w66Jtu3ZfFcNlaG1o9bZCsy96BU5kD7k5oBhLmBik36FTAcYp82Hw21tdELyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282873; c=relaxed/simple;
	bh=AabBx5BYjS+/SMIykckJScnxqWNY6c3CGqbwkiMDUXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9PgC5gLI1pvZCjRj9haT7j8TdS8QTX71nB1aQ68HsWnwC3OLNk9w2u5PK45LwxFqCd47VaeCZm2XgrnkeZ4ziyDZme2zWz3VLw3w1m6gC2eeZhhWUcQBis3aBuIApgjzkXiDe/vQtZzE/vnXFeLlGuLT5zNQyTLry3mPbQ+/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emuh77eD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4563bc166a5so67725e9.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282810; x=1753887610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+FPF2o+5r2yoV1xVlteeOQ9jnyMKh/mbcDf//y20oM=;
        b=emuh77eDJEgVCOewpsUnGDrCc8+Lz8m7oqTHdRo9KNRJgEy14wkoBrfrW0qNF2RZMe
         PPB/lw5k3lfboASOMzVImaLHCTYynSziFA8MHmdlFYKQp0QFe15NJMmLv8II261aQWYn
         sdydfpFZtYAohGez1dRHrudDuGwcz3hrP9nlgE0BEkxAPhJo6YKyEH69wQiWE100bXZ3
         3dZKBDrGNbmiBtR6eddxygllTo+ZakVp8R+gk+QyrTCwqyoHUDCghm1bZnn9+LMO17eY
         Tbc6b9hD7C2scEHJfpv7UX7W0nf1DruKDay0N7Em+PjHVsSspeLgtS8k5zDHkbbWnro7
         YovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282810; x=1753887610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+FPF2o+5r2yoV1xVlteeOQ9jnyMKh/mbcDf//y20oM=;
        b=at4MSWFXaIFHICktgWdBazugw423KoAt9pKyiKeORm//2YXhcueTtxB2jhxSrGl3Xb
         Tjem/09yfiyR04hVVqelW/4h27Zva4eXtgdnR1Pca81x14uN+aUJMu398/L9CpEEoHBu
         KNX7DepR3K2RczaxcIRlArWSZQmWQ1KSamUqzNJy+rxXujgqBYToBONavumXzq2DorK8
         QqkIVCXPChTxlq0qRRrMGIBA6xWub3Tv7KcQ/6vJTSuH+M4/XbGxTq3aAtue8L4Eszq8
         fHuEnRjgxU5xClYom2IpYsb74c4pAigb22/v0Tu/kK5TaPrgQAbDCs2b/cBY7dFJtznC
         39Ug==
X-Gm-Message-State: AOJu0YyWTgSM+REI6thtV1x29CYUckNhn9DQ0RQSSeTc5dCw2J3rlniB
	gJgOmopu11CR75koeTH0DyF5s7y44cw2jhYA7ZMy6Ofxvlz4bA9pGSUpx5nTNNgP
X-Gm-Gg: ASbGnctdbcRVSOXczeH40Q2pwA6HVM8Dfg1rp9BW9hbKXfHhoJzwzEYgULw0HoEOG1R
	YUD9UA0ECNfexC75QSMfP240nHAsi3WWspEQQGxfEjZdjm9QaU/IDCHsIsiELzxqxvHw5l7gjwK
	twD3FoKOGWGzEoxQ0Es3qwo2Q0LuYYsAc6JbbzRw1OfRrLO4zHu6MTyIWcWwIoLoJyO8Qhjvh21
	W+E9JyQba7Ida/zZozD2AF32eCGBKZckaD1IZf6OU6HbgJkPrExgs5stxNdvvC36UkvpthrKe6F
	N77yjfbKDiHkrE1CCvH4W8EtYTFPDAb7EllUnzUpWTrEqupJIcFMwzAm+GxEQ4ZeV5IFzEq67WX
	MsNlONRB72Se9Qltjjlph
X-Google-Smtp-Source: AGHT+IGAFBl3KGseGCTSjGlNh1/6ngsb7ceZlGASXKeOPGorS46qExpxFAR1C/qv5pyDHCacT3mlcg==
X-Received: by 2002:a05:600c:4f12:b0:456:2139:456a with SMTP id 5b1f17b1804b1-45868b4b2b7mr32606935e9.15.1753282809407;
        Wed, 23 Jul 2025 08:00:09 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:48::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458693cd07esm26201725e9.22.2025.07.23.08.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:00:08 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jdamato@fastly.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net-next 4/9] eth: fbnic: Prefetch packet headers on Rx
Date: Wed, 23 Jul 2025 07:59:21 -0700
Message-ID: <20250723145926.4120434-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue a prefetch for the start of the buffer on Rx to try to avoid cache
miss on packet headers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index f5725c0972a5..71af7b9d5bcd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -888,7 +888,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 
 	/* Build frame around buffer */
 	hdr_start = page_address(page) + hdr_pg_start;
-
+	net_prefetch(pkt->buff.data);
 	xdp_prepare_buff(&pkt->buff, hdr_start, headroom,
 			 len - FBNIC_RX_PAD, true);
 
-- 
2.47.1


