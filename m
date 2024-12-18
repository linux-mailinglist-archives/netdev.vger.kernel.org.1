Return-Path: <netdev+bounces-152747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 160BD9F5BA1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C17116ABEF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558F25777;
	Wed, 18 Dec 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="jDFxBStL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463BF1F5F6
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482161; cv=none; b=I1XjTSVxMD/EGJH7uny9aGyxWWn9tpEFBKesSqEQfCl4RLnLVPbvnZpSdbTNTnfZ7CSe8YJwCyuvcKGyKxNiLzzo8I7mUhTmEcrr6kr+lyHzNkQ88az8AJY4+90bnPkmQLaElByek1QcazpsRPvH6eiEqApptB1dIeAQcYParUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482161; c=relaxed/simple;
	bh=CztbvP9+RIyhpbrNQZVgPuMnd7qkzCOzRjukEnHDodc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdQkJPgL6WprHY4SshyRBMNELfD/KD7PvavMHH8Qp0SvmCNQISQ23F3K9XuCfX4BPAYBURpV+Qufya6dSvzYlqW1WFMpEVdWrpfkf2SXQGWcZD+QVCiqTMK/p+/gP/12U4agohsTD1iQ2fvP/0RNuB2fS2tNIokg50y+iyRrvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=jDFxBStL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-728e3826211so4742498b3a.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734482159; x=1735086959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FmBtD/9kNoCPyeDOsGVnpCJKDKHQdivfmWBaZAFy/E=;
        b=jDFxBStL702Qzebhgvjw8DUM/qZhn4Bsh/MwdZdhABqeeXz5NJCwomO9mlRzsayg4K
         CQHx/nVFUcDZrCDm3EEDER72/s0CGN73a6YjUhPpWQi87d2IkBO6KVzkLghs8dlZgmPg
         0YGPa5GK/hFwQETXwA8v6YYP2aogWx9zAg0Omg0RhxES0aR1C36AxuN+sjtuP+khVoSo
         O6pNPnPfJeXc+IIhCa9JwK1NefLnHq5vEC4BrJl2XgMUVu9ka4u0HP6CkSyQ2+V4yvLA
         QyIWP0s5H3Vy4t+fJIalnmpaBwS1XojhI9Sj64yND51FKRrQ/pvV8XVh6y3NtEKbRhx7
         CTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482159; x=1735086959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FmBtD/9kNoCPyeDOsGVnpCJKDKHQdivfmWBaZAFy/E=;
        b=HEeY8LWMa0JwSpPFJRE6LS1+MxmugRtT8d3mJboBGkAPIR4HHfKo3+cczBy84NTdK0
         u8YCn7cHfIAhoy/7B+wRI60cAc/fMKrJNnF1iL41qt6iaBlJEitS8VUnWT+v2TsH7ibo
         8MNPVaEtN9pegHyGEoQT41tVuQQQKd+8w9vlGsH5SbEvJgvE/oIOmWcaRTPCQDSQqKRd
         Cg3oO7ej8INO87/piGGv3eFCz7GJRUdTUYkjm2iPBOBo89GuSUoiSosazh2xB6IYYHUc
         yD/LQX5aiaL8fqrBSn2S+9r+a7eK9+45B7dolz5qLsSEWT5xDMvGmtha/h25hZCku+dB
         tsXA==
X-Forwarded-Encrypted: i=1; AJvYcCXLCgk0gBme8f1/9YaDRS4wWlP7zoxcXPPSklYT8q82OVBRb9qYUdbYW6QSJinETLNFNU8WhOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzURO2Jo96uowG/DNLTTTylZ2HdV3nwVAikOMOInD32Oy6th96x
	VBis2T5RNgFsJ60Z2bQNBf8jY2EG5BYLDBPZStGHsxPBr9ReNnaHaFKWIH2WA00=
X-Gm-Gg: ASbGnculGBW7KTv67HHirKiM/WV8SSQj3VBT5W+CiTALYjm6amUuK4ehPs5Xql7HT6h
	EbCgcB2hFdmrH0pt41CFqmUCAMFlaUeggW/TwxK9e5MuW3SLnMPx47q8m0y9qKtOkXUNe6RsfTn
	Gw2geq1W/p1Be8Mxh025iOmGLcJKuw2QULK7Rq2LsRl2qJwQx/VsY8+KBAw+qxUB2LGrjbdvvlF
	xYMerjLp2Vayw8xaonF86RIORLZmC44L7tXANUofA==
X-Google-Smtp-Source: AGHT+IHQ+upJz/RGUUcV/5i4GKWOu+LYEOubkwJvJFMyfJVlxE6d4/uwYN9uI8/eqCX8ruOMmIPNzA==
X-Received: by 2002:a05:6a21:3991:b0:1e1:a094:f20e with SMTP id adf61e73a8af0-1e5b47fc6c3mr1441096637.17.1734482159683;
        Tue, 17 Dec 2024 16:35:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a933c1sm6453128a12.2.2024.12.17.16.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:35:59 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [--bla-- 01/20] net: page_pool: don't cast mp param to devmem
Date: Tue, 17 Dec 2024 16:35:29 -0800
Message-ID: <20241218003549.786301-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218003549.786301-1-dw@davidwei.uk>
References: <20241218003549.786301-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

page_pool_check_memory_provider() is a generic path and shouldn't assume
anything about the actual type of the memory provider argument. It's
fine while devmem is the only provider, but cast away the devmem
specific binding types to avoid confusion.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/page_pool_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 48335766c1bf..8d31c71bea1a 100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -353,7 +353,7 @@ void page_pool_unlist(struct page_pool *pool)
 int page_pool_check_memory_provider(struct net_device *dev,
 				    struct netdev_rx_queue *rxq)
 {
-	struct net_devmem_dmabuf_binding *binding = rxq->mp_params.mp_priv;
+	void *binding = rxq->mp_params.mp_priv;
 	struct page_pool *pool;
 	struct hlist_node *n;
 
-- 
2.43.5


