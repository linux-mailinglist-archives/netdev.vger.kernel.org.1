Return-Path: <netdev+bounces-198188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 724BEADB8C1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D124188FC09
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052C4289814;
	Mon, 16 Jun 2025 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPxJAh1v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA3289372
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750098118; cv=none; b=RBK1BecuBPnI/BRkFVCwV5mTxSvxaubiqrjiKFZ+BbMPWGQ623nVY0AU3TboR9+jDtb4A4cfr88aLLAiOrFf89vxsOMby8A32vhhlwRhfs8Mxi0M+VsbvVufM8gt1H4zgC1LG71otwKCtxtLqqpnfzF1AEgFfOzEyLyRgC/DpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750098118; c=relaxed/simple;
	bh=Tvtj9/S8sGNITixPalBzFHVJoj67W4kIE7hwOlp+V1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYaO0xeqw9CTkrAr7vINs0Ku+qV5L3+3zHNq5Vgbvx+DneNAcO2aWzes9T00AcnD6vFiZTJrByg38e0pDdoGNJD3JB9sf61c803rpZRr1fvZuXx3YpgC661sGgFp+7QLVk/yEw1uPxueCzXLFwdPzgnbiR4ANJjUU6dvViAR5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPxJAh1v; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2fd091f826so3509868a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750098117; x=1750702917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsWNbqmbnowbyH8z2ns5ItSCz/0q2EqIE2jbQt8FjB0=;
        b=MPxJAh1vtSd9pUhTnzgG2jSXTDw14dT3L7fHDsTrz2nXO5cz3ADOOuDVxlwjuqNKxn
         OCHQeCnSLpkcHrMM/RsLh7wQR20H2hJvOF7rcN19qPG6mScgOsyZ4Xpo8x9uFLb2TMou
         A7X8nYmu6bPNH9qyScHGHPfXqtXsfGrS3svwuX/jL9l3Mm2TMv07Q34rwvNH/cjyUx4i
         PxPyXnWqdIu83Oe2SAOXVyDbfdmgz/OJIKsnNzJwqP9OpVy4ZMo2Jrd6546vsg6b/DPA
         A2v1k/JGC41Ua+ElUFdY7gY/ZNTEGe7LVRQNYfO4sWPm9Efgt5lJa8vk7/rnUHGsUnVX
         ISLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750098117; x=1750702917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsWNbqmbnowbyH8z2ns5ItSCz/0q2EqIE2jbQt8FjB0=;
        b=skFxclt2Pw36I0sulZyWfpafdiXNSbtWMoVdckYgOzi25DOKWreMFMneH/AErvZG6w
         nzj87q7CHUa4pede18C0PLo5zp/sdq8t5fUBxYfYxHjIreBhM31c/QIbojFHtLUlB8gH
         6vvWrT/j2VeJFZnn1iepqCMpUC97kWFzZ/U+GHFjxX17gh0+ooyv9bWgZpv1nOPDv61O
         Ti93DWGqzRzxF+S0m+ojhK1wd2RidSxIgdf3Lkt89prkBcBTUuAR26nFH0N8Bri8FdRt
         tneZ8ZS/PtrwuTdqSMlAnYcDCIqCSvaBooaR+qFiES0uocbcPdrcknG78V4rR7/qTLtV
         tGdA==
X-Forwarded-Encrypted: i=1; AJvYcCUX4I1Hv9827/u6xRbpdTSsEA3yxYdPwR2K3gzICSwlIipl2ykwJTyU2mqAW8Exe09cOVy5gHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUuuVrKZgewTNj7TiB0pDa/69HXkNs2iZ2P57R7b1yIWZMWtbQ
	mDY+ZRkhh3nxwEB+IHcHWQFp26ML1ko3m49ayMCSs3v76VrYROyJRAY2p2jI/gYAgQmz
X-Gm-Gg: ASbGncuxvSaOppBPKCW3UNEMSV1Ok8ahQ9BBwR02Hpx/pqnqXlADH+6Hyq27sg8qXB7
	oLcdf9JQbfSbFscRMRD5SAOcMFZtjWGSqxSgm4GoAhLMzgo7IxXUwJ1gUmxZTrws3/luR0WhXj/
	3NygjOCjyCGLnKsfQK5s8GoYOe5yTq8CJ9C4We4XZghfHnOnhBuvkF1TvJQOhotMW/8nnGMfavO
	IvYl8AGgV+mVQbJRnd2/9+fOLa1dxapoBJaNoVm7fusOXPHT/8wskSYT+zedFjjy/Xox9UK/3d3
	zTSYl0mBeRucLUXKpyt1Qa2wduMApMAPdZflSfjji2viJuusWw==
X-Google-Smtp-Source: AGHT+IF326xBxVWd56D2iAvnaN14cnTo+a2JZCQm55rw+u1fKe4opHnU6nb4869oYKecpggAmhXRHw==
X-Received: by 2002:a05:6300:6713:b0:218:2ee9:2c67 with SMTP id adf61e73a8af0-21fb8f04a56mr19130818637.9.1750098116580;
        Mon, 16 Jun 2025 11:21:56 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe169205dsm7243188a12.74.2025.06.16.11.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 11:21:56 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net
Subject: [PATCH v2 net 2/2] atm: Revert atm_account_tx() if copy_from_iter_full() fails.
Date: Mon, 16 Jun 2025 11:21:15 -0700
Message-ID: <20250616182147.963333-3-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616182147.963333-1-kuni1840@gmail.com>
References: <20250616182147.963333-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

In vcc_sendmsg(), we account skb->truesize to sk->sk_wmem_alloc by
atm_account_tx().

It is expected to be reverted by atm_pop_raw() later called by
vcc->dev->ops->send(vcc, skb).

However, vcc_sendmsg() misses the same revert when copy_from_iter_full()
fails, and then we will leak a socket.

Let's factorise the revert part as atm_return_tx() and call it in
the failure path.

Note that the corresponding sk_wmem_alloc operation can be found in
alloc_tx() as of the blamed commit.

  $ git blame -L:alloc_tx net/atm/common.c c55fa3cccbc2c~

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Simon Horman <horms@kernel.org>
Closes: https://lore.kernel.org/netdev/20250614161959.GR414686@horms.kernel.org/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/atmdev.h | 6 ++++++
 net/atm/common.c       | 1 +
 net/atm/raw.c          | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 9b02961d65ee..45f2f278b50a 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -249,6 +249,12 @@ static inline void atm_account_tx(struct atm_vcc *vcc, struct sk_buff *skb)
 	ATM_SKB(skb)->atm_options = vcc->atm_options;
 }
 
+static inline void atm_return_tx(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	WARN_ON_ONCE(refcount_sub_and_test(ATM_SKB(skb)->acct_truesize,
+					   &sk_atm(vcc)->sk_wmem_alloc));
+}
+
 static inline void atm_force_charge(struct atm_vcc *vcc,int truesize)
 {
 	atomic_add(truesize, &sk_atm(vcc)->sk_rmem_alloc);
diff --git a/net/atm/common.c b/net/atm/common.c
index 9b75699992ff..d7f7976ea13a 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -635,6 +635,7 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 
 	skb->dev = NULL; /* for paths shared with net_device interfaces */
 	if (!copy_from_iter_full(skb_put(skb, size), size, &m->msg_iter)) {
+		atm_return_tx(vcc, skb);
 		kfree_skb(skb);
 		error = -EFAULT;
 		goto out;
diff --git a/net/atm/raw.c b/net/atm/raw.c
index 2b5f78a7ec3e..1e6511ec842c 100644
--- a/net/atm/raw.c
+++ b/net/atm/raw.c
@@ -36,7 +36,7 @@ static void atm_pop_raw(struct atm_vcc *vcc, struct sk_buff *skb)
 
 	pr_debug("(%d) %d -= %d\n",
 		 vcc->vci, sk_wmem_alloc_get(sk), ATM_SKB(skb)->acct_truesize);
-	WARN_ON(refcount_sub_and_test(ATM_SKB(skb)->acct_truesize, &sk->sk_wmem_alloc));
+	atm_return_tx(vcc, skb);
 	dev_kfree_skb_any(skb);
 	sk->sk_write_space(sk);
 }
-- 
2.49.0


