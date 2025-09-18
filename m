Return-Path: <netdev+bounces-224516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCD4B85D3E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361F12A4D4D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296D53148C9;
	Thu, 18 Sep 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7MMJYkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD163128A5
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210730; cv=none; b=p32rE4aAlyU5l3SgxHZLvWZv3Lf1peRJvAmH9JFmvAuSKmW9MCMbIox9AGrrMZdZ1Ka0YVHId/Q4Y64Zfeouo6xLurkmlZ1JevS9P0D03KSlr7MPtNS69jbzK5l+HmcVzjRr+rYCzdSBUKbxpJIvkKiHFCsVkT9sTzthpHYvxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210730; c=relaxed/simple;
	bh=9dS+A1MCpTUWoZwN3jkGjfj07XOHejZcQs9lzfmozos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4XabcbQP8wRNB0xpEOKutWn4771PqcFCyXsZT35NDAPYg2JgjSG41PL9ln1g7nlMTnsYZ+F30lr5D5bURoguN9nkwJ6W3v+IiT77j8tcGpGzq0Ujy5TsbqxnoKMMdMeRXCxB58A9c6hc1epb1Zmxjkke1EfQPREYwo3vf3OAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7MMJYkQ; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63289cc1785so490705d50.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758210727; x=1758815527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvZZ9x23sqD5CkCnQWGks1ZNqju3pXW8WxGRh83DWmM=;
        b=f7MMJYkQ5kqC5h9o0cM1E0YUL8m5sgkSE/sJuh13I2Hts1tXI0dIcO1BVxARyj2JnH
         sYGbR/ruiSxhgLjpeMQLavUh3wWoOpDdJgpPRZDIzQUiYKjpGIV89XRzuj8PE7dg/NsM
         7E25o/s1yUJ3TVv3tqqkBom1k6PHtXE0tzQO8SMHimVqDQb+Bsl2laBdeunYbVi81n4M
         oEjOBCUsHD63zkJ7IHqR7qkkVmoe9dAHWX4Jc1N6cdFUJoD9beDwoQYRAFDbnFxpUICy
         tOb59sXVSAoCGtt0vhpXDb5t8jFMMWAnZbX5JRNyc1SJmRiRCdi7zViQn2B8XQp/watk
         Bfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210727; x=1758815527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvZZ9x23sqD5CkCnQWGks1ZNqju3pXW8WxGRh83DWmM=;
        b=ParfcuplmdmEKHoA8hRKDIGNs9EcKHYF4FhxYHAWgdp0YAM97uFVTdMDlx4/FepygD
         mau6GUwcaU3KTq0/xJlNLIMPKjsCMu59YQEnnzcSH0J+LzZ66RUqbXjr8q8MLG+/ymPe
         YZ5NATlIsdq9DVFI/RreM1c7300qL1OEzrPlQKqFWlVcVlwuWGUX9YioGAxcuZ+eqVkN
         VWJAbS1om3ErdwHRHtL9SfXR3GxLxl79vBF7cNjU2/EzvruyB9QU0OVqtW13QEqKqZPb
         T9mS7xKXpk+rfjh2g2mBfQcTiVGfhWzJZsw5wY4F2u/8LnQmw7mgTXHPubQkfIgBNMU3
         SSqw==
X-Forwarded-Encrypted: i=1; AJvYcCVKb8BsIxE22NY4662vkECxE8N+K9DycrMtycBSeOkxZ7x5tFE+diMIBJiPoQI0bB0iRxhdLS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNEzrifeMi0FTho12QtRBRRsWTcLG+sXGN9GyX+5quXIPqqrUh
	zHa4Bghpzv+Nrmhy2/SqW3na9TYUb4Nu4jH42AAz1p7OxmZHeL5Gcm8A
X-Gm-Gg: ASbGnctk0hqw+0Ify6LsZl+yCK63He0wISihRkf/FTEowECHLAoZ1XIhZ+cYEaTdhSV
	75pmrvQo0K328omMmWI/D2i3m1V7VSy8nEwIdmFcnywwez1Y4g9JzeyLjs8YIqySrhhSGxgVf3S
	TlK1ugvUdEiy5wBzA2+TL+xKMghJTuRq9Zr35XPJz4ztK1nWYyaAWTnmThzqd3RMWv5NWgb7Atz
	YjAgCya8Ku2/9+To1hHC+fi6z3wrv8KT5XlUJIhq4b/zsBf6rt7gH5C7H0Ig5uLnMEw9jVd4/pp
	Qu4oRiA8zL7A2CXjNCHPP/AoVu3BbfrIbYo2A6zbwPIxAueNody2NlazT2a5fwbGzWZ5nYhO+0I
	KxqZv3pdZJfzZerxEaBsnfdGmxCPAzsSF8V4nTQ8=
X-Google-Smtp-Source: AGHT+IGB6Oe9W9U/ioFX3P/cSEj5MSGdLzEzNXqDKHBmAIfnA7brCK8YSwsSTbI73kOnso8VU039PQ==
X-Received: by 2002:a05:690e:164e:b0:634:776e:feab with SMTP id 956f58d0204a3-6347f5a2a73mr7350d50.32.1758210727579;
        Thu, 18 Sep 2025 08:52:07 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739718adaadsm7337397b3.57.2025.09.18.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:52:07 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/3] psp: make struct sock argument const in psp_sk_get_assoc_rcu()
Date: Thu, 18 Sep 2025 08:52:02 -0700
Message-ID: <20250918155205.2197603-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250918155205.2197603-1-daniel.zahka@gmail.com>
References: <20250918155205.2197603-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function does not need a mutable reference to its argument.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 include/net/psp/functions.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 91ba06733321..fb3cbe8427ea 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -124,7 +124,7 @@ psp_twsk_rx_policy_check(struct inet_timewait_sock *tw, struct sk_buff *skb)
 	return __psp_sk_rx_policy_check(skb, rcu_dereference(tw->psp_assoc));
 }
 
-static inline struct psp_assoc *psp_sk_get_assoc_rcu(struct sock *sk)
+static inline struct psp_assoc *psp_sk_get_assoc_rcu(const struct sock *sk)
 {
 	struct inet_timewait_sock *tw;
 	struct psp_assoc *pas;
-- 
2.47.3


