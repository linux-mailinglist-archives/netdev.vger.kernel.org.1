Return-Path: <netdev+bounces-95451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9E08C24C4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412631F25C10
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1820243173;
	Fri, 10 May 2024 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2qdLHAt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666B15B130
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343920; cv=none; b=hUVPXdHyy6M6iEGA+GkgH70f+Tujm69icf81f9TmSvBzssMHxWruVZ6PXgpyE8KnLmtf0a7in/aotNi0RBcjj+sBcRccURKU4xMRkceK8isvB4MdKk01SYRRg0p3uXoN9W6nvFC756StVhxEZB+Es6fZLmuEgxZirVHamp9UDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343920; c=relaxed/simple;
	bh=/3wi7wJKWOBh7YdMKZ5L8V53sk1POv1ZXjrpRbSLbkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BaChAHwHdfs06hKZU2t5qODRQN2Bsh9XnKOqhWho7yA3H5XvlDpIb+0oQnETwxQFYyoDMqBNze3D8Kid8jNCN+gfbouDBg+XCZKRsJxdxEcjYbuDijJTn+Wp6nINHQFeFySMHz/EgaxnezJ8A1L58bkOb0+hPqG9Ap/t/YSxRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2qdLHAt; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5af03aa8814so1163219eaf.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715343917; x=1715948717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHpMFJ1UwPPt0NNwuNMaPd7lXkDR4LuxEDt7QyfdwyI=;
        b=c2qdLHAtgqpaoIF36po4T3QgD+Vm3AlE9rExnzR99ghUHNTHRgrvcBmNbyGmwwxbcL
         J74AHUdsmJOqDmddrK2V37cg5MHeWEPtwC5mEiT0cwDwZblBvWJK+nUxRJJ+VbYa6H9w
         Uo9qq1KmKUQAiQNozZ1hHp9SsYDNoKRRUe9hnuzidqKlYqqRQhq6Z9LbiaBCBJg/uD8/
         WXCzDnbCrwhwczasHGvNUoLtABX4Jc+aNyd1aOXcLnFBG4FkbXApme1zQqJzPSY6ID6D
         QlT/+KWa3utJbyCRFiMQbs59ODfZvrcPN9ufpoYNQUf8r77yM7XE+chS3yAI/8/UH3cj
         4fEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715343917; x=1715948717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHpMFJ1UwPPt0NNwuNMaPd7lXkDR4LuxEDt7QyfdwyI=;
        b=EgG6G7huqj0pwxggr8zpWb0OM2K7jMkYCMCNavOdGCBt1mc85BIIMaPxrMiPIeXd3q
         J1xFrV+FUu2T9H5rx0mqil83khkurniKwAyh5u+GEf/hVdnTVjj0k0wEzdv75Kxa0XxY
         RupJkHsyrGyEzWi3oabw81qoU93dv9d9ivaDexH8KYi2bKKlvrsL9LJKITvQbUOWdjIl
         mXwwrh7Txq0syS2lsPRshY56d7wxSGv4l3glz14wDRWcfknnXey5kniLNefilJyZSkfz
         71UN/fcNo9Iqj+0G7R6EQZq0z5PC+7Rli9Gec57Ax8UUd/Hi//IPaOhCqncjvCnoNl5i
         GHcQ==
X-Gm-Message-State: AOJu0YypfF8XeTQkCqifKVcEJP2OcCcAJ4MfsEAABJo0GdYMAOuZlpv9
	kU4TbKlGf1ObT2Hohhbp9HLKkfiV4F71sMYYOl8ERB/0UH2BBWus
X-Google-Smtp-Source: AGHT+IF7MMzRa0kNodl31ybwDPceV03b+aYoWpTUCldLQAMYy5+dJ5Zv7PfzZ3T2CVqWFctcWsn+BA==
X-Received: by 2002:a05:6358:8093:b0:192:5510:e3ee with SMTP id e5c5f4694b2df-193bb623eb1mr278302155d.13.1715343917510;
        Fri, 10 May 2024 05:25:17 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b57f362sm2943530a12.30.2024.05.10.05.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:25:17 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 3/5] tcp: rstreason: fully support in tcp_rcv_state_process()
Date: Fri, 10 May 2024 20:25:00 +0800
Message-Id: <20240510122502.27850-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240510122502.27850-1-kerneljasonxing@gmail.com>
References: <20240510122502.27850-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like the previous patch does in this series, finish the conversion map is
enough to let rstreason mechanism work in this function.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index 69404c14f45d..fc1b99702771 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -12,6 +12,9 @@
 	FN(TCP_RFC7323_PAWS)		\
 	FN(TCP_TOO_OLD_ACK)		\
 	FN(TCP_ACK_UNSENT_DATA)		\
+	FN(TCP_FLAGS)			\
+	FN(TCP_OLD_ACK)			\
+	FN(TCP_ABORT_ON_DATA)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -59,6 +62,15 @@ enum sk_rst_reason {
 	 * sent yet
 	 */
 	SK_RST_REASON_TCP_ACK_UNSENT_DATA,
+	/** @SK_RST_REASON_TCP_FLAGS: TCP flags invalid */
+	SK_RST_REASON_TCP_FLAGS,
+	/** @SK_RST_REASON_TCP_OLD_ACK: TCP ACK is old, but in window */
+	SK_RST_REASON_TCP_OLD_ACK,
+	/**
+	 * @SK_RST_REASON_TCP_ABORT_ON_DATA: abort on data
+	 * corresponding to LINUX_MIB_TCPABORTONDATA
+	 */
+	SK_RST_REASON_TCP_ABORT_ON_DATA,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
@@ -143,6 +155,12 @@ sk_rst_convert_drop_reason(enum skb_drop_reason reason)
 		return SK_RST_REASON_TCP_TOO_OLD_ACK;
 	case SKB_DROP_REASON_TCP_ACK_UNSENT_DATA:
 		return SK_RST_REASON_TCP_ACK_UNSENT_DATA;
+	case SKB_DROP_REASON_TCP_FLAGS:
+		return SK_RST_REASON_TCP_FLAGS;
+	case SKB_DROP_REASON_TCP_OLD_ACK:
+		return SK_RST_REASON_TCP_OLD_ACK;
+	case SKB_DROP_REASON_TCP_ABORT_ON_DATA:
+		return SK_RST_REASON_TCP_ABORT_ON_DATA;
 	default:
 		/* If we don't have our own corresponding reason */
 		return SK_RST_REASON_NOT_SPECIFIED;
-- 
2.37.3


