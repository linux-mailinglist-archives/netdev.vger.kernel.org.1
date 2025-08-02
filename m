Return-Path: <netdev+bounces-211445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01429B18A82
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 04:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C1A1AA3B11
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1491A8412;
	Sat,  2 Aug 2025 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZdHvuaM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1E19F464;
	Sat,  2 Aug 2025 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754102812; cv=none; b=T6sYuaPlqOeQ5QEz1f5+bI44jHgTS1r29FxXUTSUlzWdvBYTme1dqOdeq2IjxvopFuV3EPiHoXMag8BWqEg0iUBSXlL/CeokTas00Pwwk60jwU9WN3Vr83Lh4SBI8GgfenvQWfLK57lXi0bu/8KfcQBtHNZ17ehhKTi+gEVMOHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754102812; c=relaxed/simple;
	bh=ELOCPvBFHPOyVs7fLxvQFkxpCvhuApIqkjxST0zsWKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb9I90wUgV1QNydVIpoShzTTBaAWFRWno+Qrhy88+Yzm5QaRl06fhWe8CUSMjZKlzKoOFKxFW8bcwadwtOZmnlCHULpQI4nwt484MaRBo1KRKllII8sGkeh34wYemfKXG0pMYTvmiA/esNDt7E9G1/QZtBYgxNQxb+oUICHWMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZdHvuaM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78310b296so1687094f8f.2;
        Fri, 01 Aug 2025 19:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754102808; x=1754707608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAmHPL0z8d4qsKmnvk0WknZ0ahVVo0+kbEydX9GrYIo=;
        b=hZdHvuaMbvLicliiXzGgucdLg0OoPDK2j1Dy0g95yrecZRDwoExOoJ/SG7qh3KileV
         U70b8Z0nM3hJR69Ka/903nWtkKILRD/lTtIXgrIMEVr1GIDdJwsPrQAto7QSbhMoFS23
         x3LBhkVVhdlHx+9iCP40YUMMS7+/oV0btHD65TgP+cuSiPa946fSpAQV6rCRdSCH85g7
         pk4ZPi/yTtPlqbEGfFRZQtSee7DjW4rMxwX51OGMFTYIfvTBtpxgs8sK/VvbcfiTR6Tx
         aiucCXolZXtvTugwhiQSF0k6W9S6c0lpkbsS/sx1KJdn6IVurXtVG+It3I5y8AWicvqu
         QDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754102808; x=1754707608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAmHPL0z8d4qsKmnvk0WknZ0ahVVo0+kbEydX9GrYIo=;
        b=tcD80xgE2FLUWKFhkS83OflrTd876lHSBHr9F+R6F15JREMo5b4V60zCPdy6WiSoLd
         tVZTvvy/yHBOb+Fj9Ae/tc+OKVEIdu9b/Kq4xI/NCxraOoXh+om6FSQVANFLiH4jevVQ
         4URGrykD+jzx33VzrQh9ZA6DKBd4Oz7OhDCzu8TlJWKQNiQ2RNMk/j88iyIAuQpw88yM
         An36NjJQEpP5b/r5mHMensYNjdFLqaVp5n/+4pCY7jEVss6Ns1o4+xqRcypaxQJOKxVg
         FdEVJAvKyJTtQDJKbO861wfLdNQZesX2qTIZOUfAtcPonOlQNTxvKIgvQ/vPZZVAPjGV
         NQiw==
X-Forwarded-Encrypted: i=1; AJvYcCVcU94E5NqLZSWOJ+lEFDNc+c13BmLi4QGLbO4Nx7BKQVFjzSU13fiq71ZHCd1QxJVi6mG4SIK6MLr+NAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Jet1frq4K9ZuzLBZlcTz94Jn909YRv7RwVTER7g26Nm2yfnc
	+OsLuO5aUrsXjcii+ZHmXHs7Nx1ZYectnS4c5zR3zvuBhs2HLXPMq+PqqhS6EQ==
X-Gm-Gg: ASbGncsor1t4lVUcyb3kzBQ0zjZhNM81eU70ldoFBJVwdzLNIAXB9FTKGAw7V7UTO5/
	F9/oyZbnrvIjQvZ1+C8SJ3Xv6tURHdFWrhCslakdJg8FNceNKOtPzt5Bd6W7qy20VGhe78/m9/+
	rJj/Yn7r8EPUV1+Zg3xzBtgBtFvDp9blCneGIfBt9AvBzJ2U0lgZLFYH5nu0SSAACiL05dwMRRC
	ou1zT4mPZYZGK48qrdaDJvFJKVgkUuHzqU7w2Z2SYcvhcHxU5Rjoqouz0O1dz9Lu5BZ26h2PA8J
	aHd05BecdOLtj7Egomrkm29fcuemeCT2Bzx6COKwwvmcPN8TAviYo0we+6zA3f1wd3yFPGCJbdP
	FKccJ6MPbz9OYHdRZ2KU=
X-Google-Smtp-Source: AGHT+IEvSRusjovldvowvFtXLZQ+GP7u9AjrqRHFxEIEHePf9ZnlmxVrtOuYypqeMDu6ol5h9vU9Pw==
X-Received: by 2002:a05:6000:2289:b0:3b7:8d80:e382 with SMTP id ffacd0b85a97d-3b8d94698f1mr1359538f8f.4.1754102808190;
        Fri, 01 Aug 2025 19:46:48 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453333sm7979922f8f.45.2025.08.01.19.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 19:46:47 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net 2/2] eth: fbnic: Lock the tx_dropped update
Date: Fri,  1 Aug 2025 19:46:36 -0700
Message-ID: <20250802024636.679317-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250802024636.679317-1-mohsin.bashr@gmail.com>
References: <20250802024636.679317-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap copying of drop stats on TX path from fbd->hw_stats by the
hw_stats_lock. Currently, it is being performed outside the lock and
another thread accessing fbd->hw_stats can lead to inconsistencies.

Fixes: 5f8bd2ce8269 ("eth: fbnic: add support for TMI stats")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index dc295e1b8516..d0e381ad7bee 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -421,10 +421,12 @@ static void fbnic_get_stats64(struct net_device *dev,
 	tx_dropped = stats->dropped;
 
 	/* Record drops from Tx HW Datapath */
+	spin_lock(&fbd->hw_stats_lock);
 	tx_dropped += fbd->hw_stats.tmi.drop.frames.value +
 		      fbd->hw_stats.tti.cm_drop.frames.value +
 		      fbd->hw_stats.tti.frame_drop.frames.value +
 		      fbd->hw_stats.tti.tbi_drop.frames.value;
+	spin_unlock(&fbd->hw_stats_lock);
 
 	stats64->tx_bytes = tx_bytes;
 	stats64->tx_packets = tx_packets;
-- 
2.47.3


