Return-Path: <netdev+bounces-119009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F7953CE9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFE91C25265
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FCE156997;
	Thu, 15 Aug 2024 21:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="QMJ4qcFN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA315688C
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758392; cv=none; b=rnayLNKurdkYXpBQl+IbrDO9BB85VLOMhLtGF4q2FPr1/tIvIlzuwOlAO1UHpn8RDHfuxQMJh9JptWOtpEKBj4Gbu5URcp8vrYWU9TC6uoboo/Y60vM2UL7uKmSbQhPuzTJ5TYLXPNFWtiAAB8t+aMCCyuX/KFM+7ExJg5pncvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758392; c=relaxed/simple;
	bh=9cBs1VmwGUDwtfaUGPwFGHwA6yK6LQNIgBe9lhPxBbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aq8F6A0XEKQpNiERNEhG+XfANpMzwmTihh6DpHUV7BpzXnTYp4Cey/taIgYD0pIxcP1gBqaXZWcsIPDkM2hfcaInWvFto0B5gj9u3xlItmTdgeNQg3lpmR7sE+nDzDVh9/rsbhgHWZsfwxgPWSTrk0mcobNHXiqnkHq9b+v0Nq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=QMJ4qcFN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3e44b4613so174070a91.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758391; x=1724363191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qibwpDkMHgImrmFYGovT/+p+MzHHRNwi0Z9FJ0eqf3g=;
        b=QMJ4qcFNyVP07IVnBA8t4feEFpg/cgLvIUE/xFQDCcxyrvN5Ww4az8Wb6QUebV8P1K
         MdhSgrpWArPlc3IgKRwzqrR9CoZ37j2Izy8ntheMaPaXdUIae0HsvUx5zPoIRM67mEAV
         VjUSlZ8aIKgWd0/SP3bzX3CfrT0j4cuNNkfTF8gDzVPs1q0QRnm4bLsb2tUofG0DHKF8
         XozBvwi+QQVhpgiDSkwqV95ldHZs1t9Lo54Jenj5QzhrmR3XP+BD5ULrRUl/8wlGRV7A
         uoJnerrO0fSJOwYEmPJ2Vbo9eEFaomT0F3KMeR0uw9MolYYApVowaDl92iF4kjVaTREH
         rkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758391; x=1724363191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qibwpDkMHgImrmFYGovT/+p+MzHHRNwi0Z9FJ0eqf3g=;
        b=i2H9z9/F54oZ3/muZdzdltRFvoJLXOqEr2xvpzeUWfL9Q7iwEJ9itIh+Cgj0lrojaP
         nWmVGo38YvSMS5V/tkDfjLvLc4hRmAOQsU1ZWS/OEG2MbXNeIsUc1P9/2OanRIijc0Wi
         Ho6UVECwXPIwsMPxJwyY4rnfUBi5slicmDyP+8taJKADFa3zyOHx1/RR4fUCdooBp7jQ
         +ys7dZIS8KPhhPdcxUZjhBwe98QJwW1PGLqmkOlnaFuvRHIZonmSwT5qEGMRDXQpPa8w
         zxdzJk0Z/WG7FXMA0hyfxyY8GMA0Dy9TmOWpsqzGB40lQF3Eyh3vlqpmsMIfk7J9qDXR
         39Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVil/TLfVa/IkxpJVXhQ7oYs1ap2Xd+gmjgRBMYzbi+O4JnELfRK0EIyveg30tByuXGqg1141T1lHQh4ndZeydpqDR901vc
X-Gm-Message-State: AOJu0YzWuSWEsJtBx9OVHPXyBTILRcgz+w7xQSwmdisK/GXS4m4jkaLM
	dDI/lP2ki5Ul3jGVbVmVknG30IXlh4Q5NUiQCiXwxNmXcvOxzBym2AG9EsCr6A==
X-Google-Smtp-Source: AGHT+IHGFv0nA4sjqzXh4be1nvGKutFXONxschvn0iv3eDmWqI3MlkJhKmjEpzVw99xKD3KIcd9zaw==
X-Received: by 2002:a17:90b:88e:b0:2d3:de40:d767 with SMTP id 98e67ed59e1d1-2d3dfd8c698mr1207372a91.24.1723758390591;
        Thu, 15 Aug 2024 14:46:30 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:29 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 12/12] flow_dissector: Add case in ipproto switch for NEXTHDR_NONE
Date: Thu, 15 Aug 2024 14:45:27 -0700
Message-Id: <20240815214527.2100137-13-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815214527.2100137-1-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protocol number 59 (no-next-header) means nothing follows the
IP header, break out of the flow dissector loop on
FLOW_DISSECT_RET_OUT_GOOD when encountered in a packet

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/core/flow_dissector.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index b2abccf8aac2..fb1ca7d024de 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1971,6 +1971,9 @@ bool __skb_flow_dissect(const struct net *net,
 		fdret = FLOW_DISSECT_RET_OUT_GOOD;
 		break;
 	}
+	case NEXTHDR_NONE:
+		fdret = FLOW_DISSECT_RET_OUT_GOOD;
+		break;
 	case IPPROTO_IPIP:
 		if (flags & FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP) {
 			fdret = FLOW_DISSECT_RET_OUT_GOOD;
-- 
2.34.1


