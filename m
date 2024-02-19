Return-Path: <netdev+bounces-73056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E485ABD6
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24391C20C6A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8910F4F5F2;
	Mon, 19 Feb 2024 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGuo8wA1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E5B47F7E
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370169; cv=none; b=s8b+g1G2JOIV8ZzTh4KQLhSfTCm3WikBv9R08uV2gaUmol99TPAkMHXFa9CZGa9hUBm5DICKWWiWeEPYYov6Bnh2CotQTb7cRJvgKwcwO3fM9eXtaC8GDmBsLTa4vTRgYmoTRGHa9nffs53SU9NFvDY6TZD2pcBzNRUmMQACB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370169; c=relaxed/simple;
	bh=iT3Rswow2SB+NikRVwwEJT/+qBtzzsfH/7XNpeotAsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J5L7+yfSVS85toYxgZcM38t7V1lELWn1ePn/okIBdMgSvURi8kd+hLcMcQhV6mj7L5fd6tXstqMeXY2WXl3g7GW2QwHPWi4KeuXF71qfPzLKx/FiZDX0OygicW9rt4tXg4jKRxszTHehYCid4/zCjEEIyrFq8k/DLQBh8ioXsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGuo8wA1; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42dd9dfe170so15193071cf.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 11:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708370166; x=1708974966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ugHzuE1fkOiHLvE/GEqkAUIAY7MolMx7tfKw9H6RHDs=;
        b=AGuo8wA1cdRO2K2mq3VRfxtn0wzYR5LJRp2LySquM1Yp1Lsan1e+XDatl0DAFbaaxb
         eCQPdu+XzTohhbwMvcEgGJIFTC7FOGqTEIWmNM52x/mIWeNabRN5udn/Ortnk8ZmK+CH
         3B2nSKahbseaZyke/Zrr8hjbXFKnYUMK3qkSuKzcTKqI9PffnzzZeYCNwcwR8rXjrPus
         NhGoRvoJBRk0/eMR0hnxx7FEaAn7RWFVf/jd3sNOKZIgsM/VsOd2zpvSz+sD4hXgAwmY
         aaG11oiSHA4V4gsI6IRjIZBqr5dRMeVQgO/fHLd1QjT0k/Q/MQ/q+7CkfewspOdYW4AG
         0E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708370166; x=1708974966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugHzuE1fkOiHLvE/GEqkAUIAY7MolMx7tfKw9H6RHDs=;
        b=fxtZmL8XvGGlVMNI+KDT5bxeN6T3BMfpx73eSnifY/NB8UfsUDHYrYip/o3/Sz0CjX
         D9d8hHH2jTJdjuaW72lkFDRUUMCtApincfVupHlcmoSfcMqgJX6qLXACV+1tUpMqNB/Q
         Ru0fw193wtFDY+ybnc6xG3S9wE3TFvKhVDk6FIFlYSqalWmEdAEbZDpBQKejmLGty8Io
         oGe0g7zPaIpj6gxNeBAvEvrYx8x3bEDXQnvVvBUIIJeCssF9auaFvwXyJuIIWDqDzrLc
         alTbtHdGqa1/e3xJc03X5lEVLfmKYBnWm0UiyXh6WbkAu8KA25yH8jR/RLtx14vAcc7p
         t1DQ==
X-Gm-Message-State: AOJu0Yz6f+TjboovzqZR+HC096pQChuR8K2nFuiNV8nRK5xaK4htQMBo
	MKj5hpUCsh1DVQTTAg6fYcQMW3QISdLRWnKah6JyGiONw3Am87RkWr+8KaaG
X-Google-Smtp-Source: AGHT+IHFVLbcxdHrRGq/zCv7ez6Qy7K7ukgLEiXi8w2lFGeN+QDVRPhV8v/fsAl97SuwWpbptXlIoQ==
X-Received: by 2002:a05:622a:28f:b0:42e:2493:b0fd with SMTP id z15-20020a05622a028f00b0042e2493b0fdmr516241qtw.1.1708370166499;
        Mon, 19 Feb 2024 11:16:06 -0800 (PST)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h19-20020ac87153000000b0042c7b9abef7sm2767463qtp.96.2024.02.19.11.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:16:06 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	David Ahern <dsahern@gmail.com>,
	stephen@networkplumber.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH iproute2] man: ip-link.8: add a note for gso_ipv4_max_size
Date: Mon, 19 Feb 2024 14:16:04 -0500
Message-Id: <76a426018ec585c7dc40148fc832746e119dae60.1708370164.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Paolo noticed, a skb->len check against gso_max_size was added in:

  https://lore.kernel.org/netdev/20231219125331.4127498-1-edumazet@google.com/

gso_max_size needs to be set to a value greater than or equal to
gso_ipv4_max_size to make BIG TCP IPv4 work properly.

To not break the current setup, this patch just adds a note into its
man doc for this.

Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 man/man8/ip-link.8.in | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index c8c65657..444e7bca 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -441,6 +441,11 @@ TCP for IPv6 on this device when the size is greater than 65536.
 specifies the recommended maximum size of a IPv4 Generic Segment Offload
 packet the new device should accept. This is especially used to enable
 BIG TCP for IPv4 on this device by setting to a size greater than 65536.
+Note that
+.B gso_max_size
+needs to be set to a size greater than or equal to
+.B gso_ipv4_max_size
+to really enable BIG TCP for IPv4.
 
 .TP
 .BI gso_max_segs " SEGMENTS "
-- 
2.39.1


