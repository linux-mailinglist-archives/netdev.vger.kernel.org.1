Return-Path: <netdev+bounces-249200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF4D15686
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 484283008995
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65903242CF;
	Mon, 12 Jan 2026 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoCNFoUY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8A32E6BE
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252781; cv=none; b=nY0jnt207hyQsomGCI1iU1+QsAaiIPhYtTKnc+YJUIAeDpa9E3Vd55ZT53C8bBI5mdTnvKdWBDFySqKGEsU64kAvz9oLUD48yUEdP3sMnftVaYNoy6WcL6pT8eoIxkcowwgjjpQ26aqAuYf+vWG3zTxI3F1EWsOPlwDvuunj9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252781; c=relaxed/simple;
	bh=jdMP22+z4mKu2MxwIO0TE6Y7dPloYZ06zIFsg23SP4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTvCCKeHtBRQpK0VEnKjP2jgcpjeiPNl1N0w3pYzzQuwEFl94J/mx0zNJeFT5d2Oc2mbwul2gdNxBwOOmZa9zAVekKk+h789xZEMMoMeCi6FoNffLYcJeYFYy/2v3IBE+W8sg0EEzAuaCZA+AyNHc1xiGkodGtStPNpY5aljo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoCNFoUY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-430fbb6012bso5557269f8f.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768252778; x=1768857578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR4ZfBgCSkGc4JjU8nDjqUHH2Va+zMHBS6jTWlrE/KA=;
        b=LoCNFoUY8Zc3eDhST4/ALMI493LgRYsNC/p6/nImFYLfrlY+bk71LEwv0EFVWsQ6DP
         QcMpSFLlQxUrhGH/5SZbKjDiGSsa4Vb0Jci0EuWJXPsouSRGJXQnhh5/sjdBt45vspHx
         9AhL8CJ+pQbH3kW/YyLBiF+za8IXuQvWhaZjzqeUxQkmMDSBBqUuldWciDRRwPA+PYWF
         2bNcjuI5Pxbs8rqzrxdghno7KvRh82WYSVGaDNXZ7mUnM9F/breDkUa5c2Iyig1JqgwS
         4pwPM4FsBrvtSOg+F4Ig3nUk9hzrAXYOuuqym1O4R1U6MRr+QJZi2zGzwYhRohDVn2Wt
         OwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252778; x=1768857578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PR4ZfBgCSkGc4JjU8nDjqUHH2Va+zMHBS6jTWlrE/KA=;
        b=ulGsYL017oW99ysn0EYrPtg4MKjHQY40OkCkQOUb495bLtNosKNeZpnMOXyHsIZ1DQ
         a2jeJ+mLlN2q0KRKlsC4ejp68z0EbK5BH5Z1IL/o0kxu06NdikVf4zZNpLg9EEUvgCim
         PSKPljeACdOrn/tLlXWnba+owoN6GazPMv1jZmL+o0UV1HW0FtTCWq4DMU6rVmvf/0xC
         FbDASFtnW975nxxJexYzcdFLdkPYbQpSD3TgUMtbYRF5gN9acfDhkoCBIGBWORUMumFM
         wA93Bi8FDSvpGRNKPp5wMFfUCjWxwQPW0MRLtkXzvnBtxSWq20JIDewY8fqcU/duIvSo
         PDnA==
X-Gm-Message-State: AOJu0Yxj19ZpwZ8KNud4uXrlVNIwKjO9m1ZJ5n3q7mupNTo18aXaB/1R
	xzqtMmKKA3OuQEHqTuqqh0zbFgxvsYbQS7N+Ghu+w+xNNytGKOIwrqbvEQ3TMFqX
X-Gm-Gg: AY/fxX7SnVuNEWc7lVEHFuRP4wgZJDYSSi6w8hzS+k1tNrbz1AIVHvAH+I+L7KXhuLP
	0cWLqtOagU20TdeSN7GjLSZQaNL8X9oLcQVnq0AhGSjK/zE9eImE2SocOEYSyEt053kptTsQy+L
	wlcpBUqvoSmTPSzir7esdl8GQ7tzTLSFVx0xForx5vnwRx/j9qdJKrcT40og9EyQEvw8C9xjHdL
	HH9F8Z2ORT4YW+5LCsIWOCN7T6nql2PCCNr5Jn/i3MMMseR/LoIiI42IiDZ3HUZAi4kIhIcpjWu
	ThKA32llz5td256oNE7nONX0KZGEE14/00vGoZd5l9enquLg3HDYXVo2GJBehVNSSB4o7tYdnIZ
	x0iWmkdW+gSUtj466Xj9QV62LFmjTaIoUGEul1i9LRuZ7CHsryP6ZXfwxh4mbrMArmOumrTdu9u
	dMT9L9bUuS
X-Google-Smtp-Source: AGHT+IF1U0wvzy4MtUphVMuvL7OsDSfESbqemk/8RWV/jow3XrYU91sMNxLQWLJvuOYp+75Kq76acA==
X-Received: by 2002:a05:6000:400f:b0:431:a50:6e98 with SMTP id ffacd0b85a97d-432c37982camr22927375f8f.30.1768252778150;
        Mon, 12 Jan 2026 13:19:38 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:55::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d9610671sm22909248f8f.34.2026.01.12.13.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:19:37 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	lee@trager.us,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next V0.5 1/5] eth: fbnic: Use GFP_KERNEL to allocting mbx pages
Date: Mon, 12 Jan 2026 13:19:21 -0800
Message-ID: <20260112211925.2551576-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
References: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace GFP_ATOMIC with GFP_KERNEL for mailbox RX page allocation. Since
interrupt handler is threaded GFP_KERNEL is a safe option to reduce
allocation failures.

Also remove __GFP_NOWARN so the kernel reports a warning on allocation
failure to aid debugging.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index d8d9b6cfde82..3dfd3f2442ff 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -205,8 +205,7 @@ static int fbnic_mbx_alloc_rx_msgs(struct fbnic_dev *fbd)
 	while (!err && count--) {
 		struct fbnic_tlv_msg *msg;
 
-		msg = (struct fbnic_tlv_msg *)__get_free_page(GFP_ATOMIC |
-							      __GFP_NOWARN);
+		msg = (struct fbnic_tlv_msg *)__get_free_page(GFP_KERNEL);
 		if (!msg) {
 			err = -ENOMEM;
 			break;
-- 
2.47.3


