Return-Path: <netdev+bounces-171206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08615A4BF1A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A102F1884C8D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE28020103D;
	Mon,  3 Mar 2025 11:44:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9881FFC54;
	Mon,  3 Mar 2025 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002264; cv=none; b=O0PS8ae7HaQJuuJWYK0tjQ7sbYJDXsfPQfXN6kpCjYfASsAzDvOL8YwjQG4XZlVq+UKUqFOTWN3xGwElPUMh5XR7s4ZZNahsiMetplSkTuwDMkA6+al/IZ6+6QoHBqYKp3OXmuU0Z9/4jra76C/HD99JR0J8IH2KVCUda9fLT/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002264; c=relaxed/simple;
	bh=E6+HafXHG5+k0knqEhjQ87TeghBra0OEM7+NgUaC8pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DY//X1Yy/5FmF7P/SOpMP3iIOyWvWShKoCRaxaPXJSrti2+CHIihenYeq4Iq3djmzIgFrppSwPhCUGd8f2pL5F7cxNr8XCoMxRARMJ9gNhi4ZnhSH2dninBTdmlpvbPpvncCIyRig60ZcaQVHU2onrWiMFRhP6+4yTCUHzHJqFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso6800349a12.2;
        Mon, 03 Mar 2025 03:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002261; x=1741607061;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcCAGzrzj0+evLgZxNFpzXyvPT3wl6RxCmmrP8H1YRc=;
        b=sliz4qpQSn8kE3XILIs/KafPF6HXrhsqIdmTfawjB4GmJsfvWq1mDQ0XmUZQKzrrPV
         n1GfPNFVD/CwgJxUgGywh2sX1Z4HlaWOHtZ63LtOJya4sWmkj89aXyXkCky8uQ+TzTs5
         /9Xrf6K/OABzDHPgxnj2WjeRA9xm6spbJnHvx9uX+SncDuirF1GzSDiD23urW1g6BLiX
         KVa7XHB0dZpuMDm+MYZ9MI0Ny16hPzyh+pY0xP8adaejgv3nNGbKFZEhIgL9hA4lPOEb
         a6vPpcSx3Z3S2OddjmPlTr1JNJfKqarQuHwkZT984tJh0gNXgoNU3YjUvL0+avBvatHC
         dzUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqEICWcq5y8s/Hi7TEsDK6P4T62sZx6v4R2cWZk2QjQO3KpgQx5gYXyYI5yqoaulfhEYx285nn1UtQfg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmItlnh0ZfsBrPg3UXfWsJb34XCWL6XARL8Mv8znsdrg52hQuv
	/7n01GHOR/lhIFnuT8Zj618n61mk+OkaIo4WbMlSy3B/t2LE6tEW
X-Gm-Gg: ASbGncvEaZIWTINdZVbMyzw2mqKVnYK1LvRk3/HN3AKCfE6fSKTVCxtSHQD+y0sABI9
	zanWGfxzbNGOPFtLVcDll7oI6pX2TEDKCfEkc848g/ImqL2HEl+vPeqoMUK7+wjL9nnOGc8uP7p
	UlOrjIvpohE74tg0G1HMEDMvLwtWu+1VJFyZAFsVtHeBCPVB0eqVBH5WmdhX3DnWdTfKw3LcOtT
	wJrDnHX3928H+tNVkx+zwILa7XnlpgAlRkDKCauQy5P+hLp1qPj9mYzd34ioAQNnDEtQncSxcQK
	+xO/WwNXJsYhCmDrulKtEgDMhi2mebcC
X-Google-Smtp-Source: AGHT+IFvl3A++wGZQ0D/UVn0AOiGAsrHdcaA+4kK5FBe45Db5g4EHwtrovrAcVXm/U5HStsT6C9rWw==
X-Received: by 2002:a05:6402:2692:b0:5e1:dac1:fa22 with SMTP id 4fb4d7f45d1cf-5e4d6b628c9mr11901994a12.21.1741002260900;
        Mon, 03 Mar 2025 03:44:20 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb7363sm6815232a12.46.2025.03.03.03.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:44:19 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 03 Mar 2025 03:44:12 -0800
Subject: [PATCH net] netpoll: guard __netpoll_send_skb() with RCU read lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-netpoll_rcu_v2-v1-1-6b34d8a01fa2@debian.org>
X-B4-Tracking: v=1; b=H4sIAAuWxWcC/x3MUQqDMBAFwKss79tAmiCWXKUU0fhsFyRKoiKId
 xecA8yJwqwsCHIic9eic0KQVyWI/y79aHRAEDjrauutN4nrMk9Tm+PW7s6MHBrH3sb+7VEJlsx
 Rjyf8IHHF97pusdVmIWUAAAA=
X-Change-ID: 20250303-netpoll_rcu_v2-fed72eb0cb83
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Amerigo Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=leitao@debian.org;
 h=from:subject:message-id; bh=E6+HafXHG5+k0knqEhjQ87TeghBra0OEM7+NgUaC8pU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnxZYRcnZeDEaJOkv2dtyjAlPJ6s1NIunWSs6/X
 eF8xlRwTXOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8WWEQAKCRA1o5Of/Hh3
 beF/D/9+ebwAswXbXR2irz3Mkp+ze6xFiSt2WD29E0s7ZYCi8wpvgQr+O3tdI+nvB9LPMBBiUSA
 zSqhZuVhRArXgr2AzqXMlsPy+j+7fGEpGwUrC8zc7MCRMXbGSlOrGyVm5vFQOEOTdriurCc3W7y
 rgjeSmlZLIJtquAEZLeaLvEs382C5waYWpoCOId6v9qzDhKMrgyBZjt+7cQ9/4W9Aadvz3cxpZa
 ocYNxWBg5lCIYYySy+LrP0Zvbp9VhzTOzDIFMCGDcePqOpSM9L6uKAUse7c9jTDvZwHMk3ZRdn5
 oeQ5VPcStJd8r0g7yJI1rQmp7JA3OU78cR2+ggQaqHyIO1Vtub9BDRWsMiqLI6GZ/FUHnOnBPAM
 6RMDGDB+fZztdfZ3CgVDMWkVl6DFnsGHgvH6rHtJChwpnnRYtmYQ0IFEpSdVjaf7tztUmnP9oFt
 vRduPpwq5rfFqjCm4q3ISert4ZY0Y0rV/1w6dzq/xq8iwHGCY/6lx/Qjv0/yYwYEhWZO6uGDGLw
 j5w/r1MFE6ILAo12PYgJW/u9eBVQzpEy38zfcY4qMqs3OtJVVWH80u2/fnSOkp9cgEgLf1s9udy
 FQb0manj1C+XeE1c3xEkVDcZVo9mDhOiwisKJy9dPidjYv/Hag8IRYVsM0QTcVKepzhFEJq/YQo
 KZrFP6hH2jz01lQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The function __netpoll_send_skb() is being invoked without holding the
RCU read lock. This oversight triggers a warning message when
CONFIG_PROVE_RCU_LIST is enabled:

	net/core/netpoll.c:330 suspicious rcu_dereference_check() usage!

	 netpoll_send_skb
	 netpoll_send_udp
	 write_ext_msg
	 console_flush_all
	 console_unlock
	 vprintk_emit

To prevent npinfo from disappearing unexpectedly, ensure that
__netpoll_send_skb() is protected with the RCU read lock.

Fixes: 2899656b494dcd1 ("netpoll: take rcu_read_lock_bh() in netpoll_send_skb_on_dev()")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 62b4041aae1ae..cac389105e2d1 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -326,6 +326,7 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 
 	lockdep_assert_irqs_disabled();
 
+	guard(rcu)();
 	dev = np->dev;
 	npinfo = rcu_dereference_bh(dev->npinfo);
 

---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250303-netpoll_rcu_v2-fed72eb0cb83

Best regards,
-- 
Breno Leitao <leitao@debian.org>


