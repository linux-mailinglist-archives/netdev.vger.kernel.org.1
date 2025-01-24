Return-Path: <netdev+bounces-160798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A5A1B82C
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 15:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F029B3A6C08
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06038143C5D;
	Fri, 24 Jan 2025 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfHvaCro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D01428F3
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737730152; cv=none; b=PmflLUj3WKXXbKU3Mu9H5eJ5DKohVoHDQ2V5Fzvr9PfKUpCslq+pIL833fpbqcQAfNzLYUGiltH/Je8n6COOUruYAmDL/qUWDzQbS4GlRGaZo2tCut/DvdhrDWEhvOyNgO7CCVE6nq+pf+PU4WJEJyifCHOcz2pXTXztrAHqyVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737730152; c=relaxed/simple;
	bh=NydxaqTP6EDkgEiMRsHp+UOOwmDSujay0sykB5esncE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cJC0EiK7E86uVQZe2N4ZvaVl7mRAI2g63BIlbXlA2Si4WPHKKEV4oaN3rCbBCAYn2Q739e6ntCE6LW5CRz1f1p1kxtmAV7dDroML7t7yd9tyPwh/Laq7GympqgpO1nulqtT7jXMd4AuYDgnGTZSlbpaRh7bD9CRhTeySb2l8bVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JfHvaCro; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso15748505e9.1
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 06:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737730149; x=1738334949; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMkuRdm7dMRfIqCxtB5bKSUeXy3ZdBxZh7yMlRtwENM=;
        b=JfHvaCrotFxm9c1I7INCx8GEipqinY+truHUK5gAvBakqZ8GZSiBZMDKupviSi+tmJ
         Cfwhgeg96ASoMuR1tfwbJwhs0d2a/i62aOR2gGw9MmtuJFiFZVYwZ5/lGVrK6YR4GlMq
         Iq7cn2oMytPXCvavphWgsKfZgN6Al9npXznOteFrgZpwn5qXgK8AbLU92k8LKZgDyquG
         7CEs3zjrEshn2s2kbTa0rGoLpV2JJ4HLEAhUiHwoGr8kcOOOQp+eDU2TQ4qAjapqSb0z
         4HeqxgPYdFd0yUKVmK0PfHhp+VuZEMkXaeC8M9GlTglK48p5HwK+kj+Zeenk3cpsSuK1
         RjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737730149; x=1738334949;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMkuRdm7dMRfIqCxtB5bKSUeXy3ZdBxZh7yMlRtwENM=;
        b=nh+E1hW9i97m2c+KrLsY9wmjP/vKFxbwXS9KoypBte9lbsPxy4BxF+hUwQQZ2IfDb8
         kOpZBusozv5anpl2NGfTXGq+wiWIebzoREQxqTn5vwAfoA6cdffEZf3kZ4068CfKx4TC
         9dt+gVzDlRJa7PI2lqvbSn78ZjAgYIfdVGDdrG+qU7zEwIO10bh3iMfhkNLYbkFekv91
         i+Gy9mNfikxIXICClOKdqWxnEc54UplMi8zUstadSjWLuklNVHyeKlVeeYZS1pKLSKlM
         Trilkiaz/4fK4UhO6zLSegKxeAc3KnlhP7ySJnonLsvxdLmW5akiDFJQWd/Wd90et0yX
         DSgA==
X-Forwarded-Encrypted: i=1; AJvYcCVygJM/Ni5A85t7FW5DcqGAUThgLcsTGEcK8mBoMM7cPCmTOfuHquSKb2XM+1dGo9H6EUtgFr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0OJ1U3oEC+JNICg3DcLMJnNEHrWrKGSYTap4EBg04JGXG+dW
	TOii+Blficdmy1CFzWypZ6gxSNmM7sv7xicrEYArK8mLSuunSXI82+U0VRT9SGs=
X-Gm-Gg: ASbGnctsr0I5g6MGFotf/kZ26V14tIMUpgRZ8Wpfp4gFbIF3Axfu/k2nyFXXvfnZuud
	eNs7bX3fyqdXLdUjtiJFU1SJe8osc6uI0j4trnc9bL8y4z34de1ialLJMTME1b2nYSEMQtJxGYM
	hsJ7mn8A9ubcm0dBByX+3NeZ9lx4EPr6SU4whXtWe2XbPCkBZbhICo+whwL1fY7lbk5ARmxZE6U
	mt7TI1SHPNjLC9UVfnNqIDluQG9Fy134SbOP2XAasVFa4Qz72WMrp0Vc2QyHmx5ijD/eT+tqF0r
	BTKRTpjrrA==
X-Google-Smtp-Source: AGHT+IEgUTZS8mCn7dY7aS1e3HW4uNtkQsxfIiRO3BnkLr8VQ2g9RvGQrurzRlcy0FFiD4+EtIbf7Q==
X-Received: by 2002:a05:600c:524c:b0:435:306:e5dd with SMTP id 5b1f17b1804b1-4389143a66dmr264487745e9.22.1737730149323;
        Fri, 24 Jan 2025 06:49:09 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188bf5sm2964758f8f.50.2025.01.24.06.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 06:49:09 -0800 (PST)
Date: Fri, 24 Jan 2025 17:49:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: William Tu <u9012063@gmail.com>
Cc: Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	dev@openvswitch.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: ovs: prevent underflow in queue_userspace_packet()
Message-ID: <4d6d9d9e-b4d9-42f1-aa78-1a5979679b2e@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If "hlen" less than "cutlen" then when we call upcall_msg_size()
the "hlen - cutlen" parameter will be a very high positive
number.

Later in the function we use "skb->len - cutlen" but this change
addresses that potential underflow since skb->len is always going to
be greater than or equal to hlen.

Fixes: f2a4d086ed4c ("openvswitch: Add packet truncation support.")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From code review not testing.

 net/openvswitch/datapath.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 225f6048867f..bb25a2bbe8a0 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -477,6 +477,11 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 	else
 		hlen = skb->len;
 
+	if (hlen < cutlen) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	len = upcall_msg_size(upcall_info, hlen - cutlen,
 			      OVS_CB(skb)->acts_origlen);
 	user_skb = genlmsg_new(len, GFP_ATOMIC);
-- 
2.45.2


