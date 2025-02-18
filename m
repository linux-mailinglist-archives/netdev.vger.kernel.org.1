Return-Path: <netdev+bounces-167205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF0FA39222
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 05:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D207316A493
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 04:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF841ACECB;
	Tue, 18 Feb 2025 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myghX7l7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9041AB6DE
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739853154; cv=none; b=Bl25ZMaCWfGTPHoAXa3RBoycnm0hSXxO9wqsroO59/XM0Q2alq4reLOURWgkTfEQgcYPxug5HfohJJxzJUGje0kr+NA4kImjfpJt1aBjfmGcJ0twWLetBnuGh7f/Wh9OO3beBFBiOeFeDwaronWZqdBjwXXNvKLqWYOm6abL6eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739853154; c=relaxed/simple;
	bh=K0nUvKTL+oKjINXniaj/u7aFwM1Yq9iSu+s3rsVQTG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ok/pUKNPpEjopFs3VH86unTQWflDuUY4vEnmktgqis6RlKSunytUCSVTLUlYK4vi6Xd6c4r9zgrGlNYv2FBqMqHAYiT1OffX4QEa7T9FIz3wgis4wrfTN1JOk83HKh9CfXKT3am8IqMA5CKP5RIo+nX2etSIwPP2gepRzAc4Fvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myghX7l7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220e6028214so82279115ad.0
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 20:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739853152; x=1740457952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaMoKp/08ZfOYxZZIFyKP1+AXjFJ41FwH1Rc4CFQ+5E=;
        b=myghX7l7ZuCJnNDZ1ZBpjxQX38B/XUe/DtgX24PJIKJzdCudRV/DfuTo3qDgk7C99R
         iidpVlXNbbX4LmEKm3k70easUCRlgygqrrWslVuHKzKHzGLov+26O5RzJTmCWbzHmN32
         emGrK2XG6Hh/KNdIjy9jgRpoGiFSA8TAt2BU9SRZFjmUP/UO4798Si8i3lM4/Jcyuyzw
         UCxpbVcKd3n6d69euzBny+2Am9kL5n+jCQ42UoSf3cp5ktuCREcmJhG/dutXBIlsTwuU
         JtnFc4oqOXHqjun49hY9Rh6TvqNs1wDo+fF10VBGYrc7hKykJqLok2D6f2aXtFfkcIYl
         IrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739853152; x=1740457952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaMoKp/08ZfOYxZZIFyKP1+AXjFJ41FwH1Rc4CFQ+5E=;
        b=LzhVBOMEz96+vO3m8zMvwlk2Y2MxLL7VKRDfpl1OJ6aAhgQLbFfrqHYRxRPxJmUpoZ
         3CXjnj9H9ZifS55KJ4wPZQT2RaOBzStHvkHRgLl9LtA2+pECMk0K/OqK08BXlcsTlowW
         8QTG5Sq5DSjr6Jki7QviJI3wQKs34XZTaC+8Xp1SOLtBw195GAnfOi11DD3rNTb+oYEx
         vP8LzQlaYHZwolol1I5GLdQQHsSHTBMSxzIhK/KOkSMM318eRfXl35O1m21I2rYqztGu
         tZ9szuUz9HSa3YfKA9eX3UCHhjsfpkNUyUT98/LsJRGlUblyV6mtvd8qqEG5zfFSFTt0
         XwQQ==
X-Gm-Message-State: AOJu0YxGb5T9/V2nQ5Jlz5JgjJXm42G3OgjwucRdqJDTG08eqhs1YI+v
	1LSVu4FdJQF7RyQK0vGF2G893JOzKCyjQctEb+ge4o2xDBeT180EPsc4Dg==
X-Gm-Gg: ASbGncsJPKK7Q2iTmbnqO7u/xkwjAeXQpAxU85vFnxBxCXvD1BnHAp1MyxW2YTgrpzF
	336ekgkdAF5diGdc1oz63cc/KoUdy1m437NC14IJQAOyZkALxBNYAysYeLeClW08dO0sUJPbXkU
	aZmtuLFxntgGcuy8/E5dyslZONPy6MadgKyIcXhzK4IHU48kXMWnyGgvkWqtbNwm8tpX2hJQpzF
	jYPb4/7zwFawal6XuiQ95Vuik4ddamc7glkb2eQLGZJpV4GwUUL4j8LCFWvs8IxKoRRW4Eo9Hx0
	hMfXqd5XzPnNA3VaObJUHVByj+RhrhyVUcVedWwPApni
X-Google-Smtp-Source: AGHT+IH81BRK+IoU2xmJ2VR8pW+yiu7XQx1xaOYfeC3zbTEkMWVoUREJgA6ZNRe8GMYb87DXP21I3g==
X-Received: by 2002:a05:6300:8005:b0:1ee:b8bc:3d2e with SMTP id adf61e73a8af0-1eeb8be5abdmr7371630637.8.1739853151741;
        Mon, 17 Feb 2025 20:32:31 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:304e:ca62:f87b:b334])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326aef465dsm4907501b3a.177.2025.02.17.20.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 20:32:31 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	Qiang Zhang <dtzq01@gmail.com>,
	Yoshiki Komachi <komachi.yoshiki@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [Patch net 3/4] flow_dissector: Fix port range key handling in BPF conversion
Date: Mon, 17 Feb 2025 20:32:09 -0800
Message-Id: <20250218043210.732959-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
References: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix how port range keys are handled in __skb_flow_bpf_to_target() by:
- Separating PORTS and PORTS_RANGE key handling
- Using correct key_ports_range structure for range keys
- Properly initializing both key types independently

This ensures port range information is correctly stored in its dedicated
structure rather than incorrectly using the regular ports key structure.

Fixes: 59fb9b62fb6c ("flow_dissector: Fix to use new variables for port ranges in bpf hook")
Reported-by: Qiang Zhang <dtzq01@gmail.com>
Closes: https://lore.kernel.org/netdev/CAPx+-5uvFxkhkz4=j_Xuwkezjn9U6kzKTD5jz4tZ9msSJ0fOJA@mail.gmail.com/
Cc: Yoshiki Komachi <komachi.yoshiki@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/core/flow_dissector.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index c33af3ef0b79..9cd8de6bebb5 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -931,6 +931,7 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 				     struct flow_dissector *flow_dissector,
 				     void *target_container)
 {
+	struct flow_dissector_key_ports_range *key_ports_range = NULL;
 	struct flow_dissector_key_ports *key_ports = NULL;
 	struct flow_dissector_key_control *key_control;
 	struct flow_dissector_key_basic *key_basic;
@@ -975,20 +976,21 @@ static void __skb_flow_bpf_to_target(const struct bpf_flow_keys *flow_keys,
 		key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
 	}
 
-	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS))
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_PORTS)) {
 		key_ports = skb_flow_dissector_target(flow_dissector,
 						      FLOW_DISSECTOR_KEY_PORTS,
 						      target_container);
-	else if (dissector_uses_key(flow_dissector,
-				    FLOW_DISSECTOR_KEY_PORTS_RANGE))
-		key_ports = skb_flow_dissector_target(flow_dissector,
-						      FLOW_DISSECTOR_KEY_PORTS_RANGE,
-						      target_container);
-
-	if (key_ports) {
 		key_ports->src = flow_keys->sport;
 		key_ports->dst = flow_keys->dport;
 	}
+	if (dissector_uses_key(flow_dissector,
+			       FLOW_DISSECTOR_KEY_PORTS_RANGE)) {
+		key_ports_range = skb_flow_dissector_target(flow_dissector,
+							    FLOW_DISSECTOR_KEY_PORTS_RANGE,
+							    target_container);
+		key_ports_range->tp.src = flow_keys->sport;
+		key_ports_range->tp.dst = flow_keys->dport;
+	}
 
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_FLOW_LABEL)) {
-- 
2.34.1


