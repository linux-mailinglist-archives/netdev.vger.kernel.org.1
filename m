Return-Path: <netdev+bounces-212199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1805AB1EAC9
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BAB1882C5A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A6284693;
	Fri,  8 Aug 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTO7Wjlq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2838283FF2;
	Fri,  8 Aug 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664823; cv=none; b=pfaWfz5c8M7QKeabP1Rf9cUxEBe9xz8GGj+/PKUkYh7SMRvAJiYlnVQDVkgiMHVi07Lu/mPsU6A61qF5VVm7ETnnxszyYvtTgi6t7vt8HpLNYGfSiqeOrIogX/LeKww3b2ftzuuJvFJMyUDjyqhOMWnj5DjlFhFBiyTVSVHLH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664823; c=relaxed/simple;
	bh=FlAybfuKHbG6+a7ZbRKEB6/E7DbObThw5ayznKjijpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7t5dA2XrYU4ev7vWUj5AMGKL0tfymK+sgLlMnlL9/j3hISWNdVrEIrKdQvT2y6kG4Axr+3kw/BnxucgPsJ8B38ZT/RfzYQ2KuMgrPDptMdBd7G+/UxnFfELmalMM5TZFcWDLyLvLxG9PgKKsZMvItm3p9QExNGjxVTjRjOQSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTO7Wjlq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b786421e36so1174697f8f.3;
        Fri, 08 Aug 2025 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664820; x=1755269620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6CWZWRRbyysTyJbo/8Elocwsz5g3qKnhCwDIxLbwp8=;
        b=bTO7WjlqozRZS6dGXuoW9SkMoOHgW2OrkciXMa/49tdOOHn33S8PZH99HA+MRHyLNQ
         K+8PscCsTLYrJEbT1G9FbkMR7lE5oNHSTTLI+neIYY9Lf9rfIcWwqSc6mqIb4wZ47hH5
         9e2ePtcZvdHt0ueBw1Zzts7PI9PBUvFX3i8gcjrklCECKCV0IWUMXVT6afmy2euffw1+
         xg3laygiyPDCEVEsBPCmm1Z2/0Z8E7jh6lPotC71dl6vLnsHcKYNqxCSkfhLqMpiQjPI
         WLDWNmswZptXWPiyTcJwWJLfmOIlC8TItayNZPlgD6UHVg8dN2248cV8wrXw2iVNULlV
         6Lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664820; x=1755269620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6CWZWRRbyysTyJbo/8Elocwsz5g3qKnhCwDIxLbwp8=;
        b=f2CdFC/YgcmC8RnnM9KOtVH/RbCBusRHRNSybFi9tm9a+BmUCJEovhHbFs2zoM36qC
         88sUIP9xeZ5winQGjmuf3s88+Kwbh3eKRV3eft55jQ78yc7cjmz8almPyYgTnI/64Qvn
         GvJUN+N+MqDqlHhr4cmnYq8S3tUnhAcJxlf88dzJu8pqVo56BMUW+WTda80OiqOd+7Ea
         YrwxS9wFZ7VeAE12S3HrAJVTNLaKVYMCZ2ghDPBMQ/nYoKEXF22Mc1mcXmGg6K0ZCBkU
         6uYIXDp1qYSS38GB7a87YPP0mH7o3cbUeeFhqaNTI17LSs7s+Cem7ZdIJVGnJq+CuZRC
         vxdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6FbBHsx3nHNp22OSqyyUDT+Alfws1OGYwMecgM60Q0qeJYyvJ+KRQ03PciSI/Cik4Ka7cXpNN@vger.kernel.org, AJvYcCXAXcjcewigo5XMild/AgP7CX/3lKhhS77l+xqyGt5xOnGjxyL3cNy4I898FioxeAjr/udIpNz9apv44P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOqXHPT4GiANUILgHTDAQxn+WpEYTs5HZCn7EcseUn2/PdS76
	adSYVwy5azuEiXWWyYhJVvghQD0dlts/MuMfPWki6adsqQIbIm7lWVjt
X-Gm-Gg: ASbGnctb4yK6dELBbiyn9QTYR94C+JIprm4+p8NJ8rzFFVXSTOs94GUfwujRSJx7ooF
	2o1SPOcWIOkGdbn9DrnqmrSalK6fKCfdjMaPQdgtctvajMLfkYF5467dF8R+OdbSHf9wTOBVxfQ
	LUEJTKXg6CDmiNYEOEDNt+YKVaddOksJE5RaPcD25va/S1H642zSyq9H2A8XThVpNi52lSBedGF
	qfYwdMNmCqMQKJnua/M5kKiM0ZzxMIAcd5dt2BaNhEPCj8C/BPAou8BAmg4kGSQHywsMS0VB6ix
	MvmYti5uf1im16LpZrv6oq278HwunXZBdBPD3bT5U3V3TbQkanFnnCJcRZZfVAShY6gHF7JHO3w
	XM2gFGw==
X-Google-Smtp-Source: AGHT+IGzB3AKdcal9ILqmqOI71qV29JNxR+xFS/mmxw9AnjF1rxQ34VTCXNHqPNDIeUpsAYgLqlEoQ==
X-Received: by 2002:a05:6000:1ac7:b0:3b5:dd38:3523 with SMTP id ffacd0b85a97d-3b90092ca63mr2770273f8f.8.1754664819417;
        Fri, 08 Aug 2025 07:53:39 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:38 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 06/24] net: add rx_buf_len to netdev config
Date: Fri,  8 Aug 2025 15:54:29 +0100
Message-ID: <852f27dc0a77625b55869445920cb2daab3f2cbf.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add rx_buf_len to configuration maintained by the core.
Use "three-state" semantics where 0 means "driver default".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netdev_queues.h | 4 ++++
 net/ethtool/common.c        | 1 +
 net/ethtool/rings.c         | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index c8ce23e7c812..8c21ea9b9515 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -25,6 +25,10 @@ struct netdev_config {
 	 * If "unset" driver is free to decide, and may change its choice
 	 * as other parameters change.
 	 */
+	/** @rx_buf_len: Size of buffers on the Rx ring
+	 *		 (ETHTOOL_A_RINGS_RX_BUF_LEN).
+	 */
+	u32	rx_buf_len;
 	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
 	 */
 	u8	hds_config;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index faa95f91efad..44fd27480756 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -889,6 +889,7 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 
 	/* Driver gives us current state, we want to return current config */
 	kparam->tcp_data_split = dev->cfg->hds_config;
+	kparam->rx_buf_len = dev->cfg->rx_buf_len;
 }
 
 static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 628546a1827b..6a74e7e4064e 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -41,6 +41,7 @@ static int rings_prepare_data(const struct ethnl_req_info *req_base,
 		return ret;
 
 	data->kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
+	data->kernel_ringparam.rx_buf_len = dev->cfg->rx_buf_len;
 	data->kernel_ringparam.hds_thresh = dev->cfg->hds_thresh;
 
 	dev->ethtool_ops->get_ringparam(dev, &data->ringparam,
@@ -302,6 +303,7 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	dev->cfg_pending->rx_buf_len = kernel_ringparam.rx_buf_len;
 	dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;
 	dev->cfg_pending->hds_thresh = kernel_ringparam.hds_thresh;
 
-- 
2.49.0


