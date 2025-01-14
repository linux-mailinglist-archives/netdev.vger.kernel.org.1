Return-Path: <netdev+bounces-158143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444EEA1094F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539E7167FBB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5A21474A2;
	Tue, 14 Jan 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnzIEmYu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F01369AE;
	Tue, 14 Jan 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865000; cv=none; b=AJhSatz0iprwGKaxc1KRtzjeIl85SrErCCKhzjx8AAHCnXXK3wpvTWLTXGGqlDNihs2nXzLtpTuhjS6BBWh+3K/vLzOrojkrL9FZwn4V4UUf0Mrq2I9xQJMXdSBzIxk4Q88gWrFbc46LfYglDG5TuRWJuEhw3kzs0zwVI3JNyNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865000; c=relaxed/simple;
	bh=G03YlzkTyU0wEKIS4zU4l6oXXy3VcSxiD/ish1mzBr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THJAEOWfAj0St7awDJyRuYBeaJ2F8vvx56njowoF+pADuTJ8KsA295H61k0HNMokd0LGha3vvS3mZfO8PhLFbV4ija+YALCV0ww/r33eB6fkpJJ/cgBO2HBdE8wWh15ig4y0rsxR7HR3WV1qPT5qPf3lz6amdEwBuA9i6vm7aH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnzIEmYu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2156e078563so82792345ad.2;
        Tue, 14 Jan 2025 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736864998; x=1737469798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3YKvYjMS3HKIoLbog9rjcuxZ+eEkVARKjAsTJOkXTc=;
        b=BnzIEmYuZEaVS8S2oMoTCBrhey36H3Q3xLIVSe0Ovhxa6fzgycMBCtdz9sBbKWKsgS
         GR2ZEfwRm/hTo+ODmD/dUys/8bGSycqtAVFiUsruBgyrH+VtMa/m/GivMazdoRk8B7V9
         LtDliEL2qntFBtGBX8sMgvg9yDNPDhiZ1iL7Wudbun0UEAhvNpGgC0behPgPv+pOC20I
         nfql+FEpGLACl08BPoja4iZAdtHmivggqxdevs0VvQwL/bIjR+Xz1Rj18Afzvz1gPgM9
         i5vJi3H7bfH5R7fyZ/Jrg90MdMvzOjDDMRDnTt7/nGKKSy0M/hJAZZbHBIDGm457vKPq
         jHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736864998; x=1737469798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3YKvYjMS3HKIoLbog9rjcuxZ+eEkVARKjAsTJOkXTc=;
        b=Gng5EJZkOSF6dcypcomodXAkIjTuwodMN7T5YBnshsPHe/EqsaKc/dVB0HqicUnk8L
         KOKcXxaxvGhUQQYj5C/H/BQxGiRJlEcspWTHqHrkQNDgxyxCoIwqX3eQUP2b1VMVyzHs
         JidiSu/l+fTM86SOwAeS8iBVChRHjbQ4KqR6cWgvTj5uRv7Qu1YErHxE3EgV6eeN9hC+
         urwxQ//g6+Vch4Dmci5PhPTVYYgXiGJfKV+9jQaYcjK6yxSHGaCrVZd2RW4kBQvRVngl
         +5pV6teUBORife+d3fj4jn1/K5oswhT8DMpa8vhetYMljzxbXlAc9+tvQhbG96YbSFmx
         PyZw==
X-Forwarded-Encrypted: i=1; AJvYcCWcba2EiGhPHHvuGisqKIy8TA0gRlB8fImFmHFEgdkpc6J3k7V1RG7b4DSQedqracVKZMWXs3F+e3M=@vger.kernel.org, AJvYcCXc7ZA12dKBZQh/5yj4zRNVs/gWuDKd4t+HYCyhDYoBEHfIA3MkG5bArjaeMroHBfrFoa6oVu/W@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Urnp6n2AdPHIf2ME0VkOasol7oEXNPUVhGa2OjX6djMmP0IN
	b3+hN6hvqsHGYxYrrgkdP98ZBfplCsKMwip7wwu/KDXubevpCIWP
X-Gm-Gg: ASbGncvyolV7LTwkjudUusSvXDQ0N28/niTYnRCF6+iKqEK56V8om0uUhHLFDFCCxW9
	Z9/Xhf0D7roecchI2NuXfuSVnIp7i69uWRu8J3zim7TzpJadk+t9+5qUG2eRpAOjb7GjgZSY0Je
	T0mQwrJLyuFjrozJRFo4c5Kl2JBs5tJln/qYu2jsiTHStXG7dihP8+nJFgJ+nZ56JqAZOs7LF8E
	T71zTeZSjpaldaFFUn+ybAldtw5vrONqdV7tARY96aaLQ==
X-Google-Smtp-Source: AGHT+IEOcS6m6L1FPIA2lo/58pLV4skymVLNwgqNQZqSet7D2LfqJMmrqpHRbXBKl5//TOX+Tdxfvg==
X-Received: by 2002:a05:6a20:d81a:b0:1e3:e6f3:6372 with SMTP id adf61e73a8af0-1e88d132ef8mr40813558637.27.1736864998339;
        Tue, 14 Jan 2025 06:29:58 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dfesm7474582b3a.156.2025.01.14.06.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:29:57 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v9 04/10] net: ethtool: add ring parameter filtering
Date: Tue, 14 Jan 2025 14:28:46 +0000
Message-Id: <20250114142852.3364986-5-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114142852.3364986-1-ap420073@gmail.com>
References: <20250114142852.3364986-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the devmem is running, the tcp-data-split and
hds-thresh configuration should not be changed.
If user tries to change tcp-data-split and threshold value while the
devmem is running, it fails and shows extack message.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v9:
 - No changes.

v8:
 - Add Review tag from Jakub.

v7:
 - Use dev->ethtool->hds members instead of calling ->get_ring_param().

v6:
 - No changes.

v5:
 - Add Review tag from Mina.

v4:
 - Check condition before __netif_get_rx_queue().
 - Separate condition check.
 - Add Test tag from Stanislav.

v3:
 - Patch added.

 net/ethtool/rings.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index a381913a19f0..d8cd4e4d7762 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -252,6 +252,19 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	if (dev_get_min_mp_channel_count(dev)) {
+		if (kernel_ringparam.tcp_data_split !=
+		    ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
+			NL_SET_ERR_MSG(info->extack,
+				       "can't disable tcp-data-split while device has memory provider enabled");
+			return -EINVAL;
+		} else if (kernel_ringparam.hds_thresh) {
+			NL_SET_ERR_MSG(info->extack,
+				       "can't set non-zero hds_thresh while device is memory provider enabled");
+			return -EINVAL;
+		}
+	}
+
 	/* ensure new ring parameters are within limits */
 	if (ringparam.rx_pending > ringparam.rx_max_pending)
 		err_attr = tb[ETHTOOL_A_RINGS_RX];
-- 
2.34.1


