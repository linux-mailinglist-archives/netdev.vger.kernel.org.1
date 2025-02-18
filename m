Return-Path: <netdev+bounces-167373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1BCA3A03F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876843B0B5E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C901E26AAAF;
	Tue, 18 Feb 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="VyJ86S4J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f100.google.com (mail-wr1-f100.google.com [209.85.221.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF526AAA8
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889452; cv=none; b=MwRTIIc+gHWtbdeD50+qjC5bdKbl1PHU6TK+8SbLXRD9zYrHrxDOpou8O0+u461bPdGGQjdYjlKmDvsNvGZq/FwGg9rwPjP1A+YLI9mYS9jFcHzmC36xrywSASrvwCSDSYw98ubJHfIOKpp7yR45+ajzY58Z8nVerp8xtt3FxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889452; c=relaxed/simple;
	bh=F7CU3SjttFUtRSGBymRHsv840h1VFAJkwXTXlRaJQIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZXu9YIFmnZiB/H+I6pMV+nSGSYotG4nEJksLd+3SOVx0AbPVSLUNfsjws2AZShLbpbXjRdsxbi8YhgwC/bj+cfoZt5f77O/BgIeGuojGrZgyaFkzTbSUzHdVEagERyLF7FfIyk02atP6+RottUtB7V8bnu5zfXWVeQt1zhWe+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=VyJ86S4J; arc=none smtp.client-ip=209.85.221.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f100.google.com with SMTP id ffacd0b85a97d-38c62ef85daso709242f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 06:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1739889448; x=1740494248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqnb8+jtJsmI6l4qHBPvShuE/GUMKktlnKKKsjXBn9g=;
        b=VyJ86S4JmmQ9EGWok1QHHZVQOrVP6eIVLdDnSo4kptWVCOF05bBZdTH63P7vUGmMEm
         3ElBwvRSCn6EIDXl0R7SX9ObKgCJ/BexAY0Nl/qm82Ue7IXgkTYgMmCX1qfqTI0+jxHU
         /c50gPYZOHh75Gn+x2uluQJQTgPJ7+mJLl5m0qvXX3C16ffXslorHM3KymB2NbEl/S3I
         IE3ImAG7kQlTzHXKvxNje5w5m/I7+a02OYWQ0fRbiX7HwkgfpFxi44XJMMcXXxlMbEQY
         xqMajqvJOpHadLCqvZ46LjXJR6FFPcBBy5jMo73Vd45xp+1TpkgFboEiDH/60jP6RPQ1
         9R/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739889448; x=1740494248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqnb8+jtJsmI6l4qHBPvShuE/GUMKktlnKKKsjXBn9g=;
        b=oi8vjpnNEkIRlvmU/savgugbiyIL3zwtZb+IZvO1XYQ8O1+ep3vuv0q2SKiM1wijJa
         +I1bzUbQ6y3dtx2fEv/cy27l3qylJgVRqPYwIGbNDy4Qp8D9EllDLCPv9pxMN+2rS9PT
         rq3Fyup7LTbDT8lGGwdYyRGUT54/gXT1eMwdwKvEcc9pOEYGcjBOk3wSyOf/hSp9fGp5
         hSbMF2H4NYsy23oNkTPqaP5yMZ7b3vdErEZhMEo9yBqJwb+TkwCPDSonZY3tzn+ggAKt
         Oh5QsgF1nxKKvqEayGHTEFeQUiEBxpSacCyQu0COyTE8YXe3jAqTC559t+f7wcgE4BsA
         3qtQ==
X-Gm-Message-State: AOJu0YxTb+7I2lmo4aUe5NIBq+0MFzqeSAW2Jvbsgb9TCN362RNq7COL
	HtIjfLh7JRkQgAaAroWsjiPoUjEG8xZL1xT8+0VaxoH2oZydFL/OtE5CC1WGZBfKp0lXawqA9qG
	7pcmfJxhw7if2gtNz+rr1yC2S5kNeXwN4
X-Gm-Gg: ASbGnct1FKxYKkUEldM4yW32fbw9eGOS+rafH1iJmIoejdqPflAaMylr1A2EcZK/8qs
	k6NhOODkkP8UpMr3LSkN7+6BExS3R/dmEX9yCslkH/I1JpBuiNqM5+e8l5oRZpZZED16ANax1WX
	BgZ6AaY1XiS4q6K+iJN6MRlEGPDtvyqXzK2whRESgmLtXuZqGMCTFcy5ZChYuLvboA5xeapfXUs
	qPHd6YuZ7bdCvUZKcVDSs+5B3f/iaHH9e98dVxWX+g5dBkgCnbeOSnIK31gBZj4MBRI+2BCxb4C
	gxvDpuD1c0oWJo9laY6sBby5DaBFI/8cOn7ksCB4Zs7kLHMnwuEAnmMWcWyY
X-Google-Smtp-Source: AGHT+IE0QS+LO+Skn8Adyu09y6iFqvz1AOvM49k4T/+YvhvqN5OTTYtMEI7iwrRhrpnpu/KAnfipT6LrGWwR
X-Received: by 2002:a05:6000:2c6:b0:38f:2ad4:6b1b with SMTP id ffacd0b85a97d-38f33f565f8mr5591232f8f.13.1739889447983;
        Tue, 18 Feb 2025 06:37:27 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-43959d4973fsm11301145e9.10.2025.02.18.06.37.27;
        Tue, 18 Feb 2025 06:37:27 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id CEA8812324;
	Tue, 18 Feb 2025 15:37:27 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tkOj1-00F1Ty-J0; Tue, 18 Feb 2025 15:37:27 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next] skbuff: kill skb_flow_get_ports()
Date: Tue, 18 Feb 2025 15:37:17 +0100
Message-ID: <20250218143717.3580605-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is not used anymore.

Fixes: a815bde56b15 ("net, bonding: Refactor bond_xmit_hash for use with xdp_buff")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/linux/skbuff.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..f403d43064a5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1530,12 +1530,6 @@ u32 __skb_get_poff(const struct sk_buff *skb, const void *data,
 __be32 __skb_flow_get_ports(const struct sk_buff *skb, int thoff, u8 ip_proto,
 			    const void *data, int hlen_proto);
 
-static inline __be32 skb_flow_get_ports(const struct sk_buff *skb,
-					int thoff, u8 ip_proto)
-{
-	return __skb_flow_get_ports(skb, thoff, ip_proto, NULL, 0);
-}
-
 void skb_flow_dissector_init(struct flow_dissector *flow_dissector,
 			     const struct flow_dissector_key *key,
 			     unsigned int key_count);
-- 
2.47.1


