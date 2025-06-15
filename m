Return-Path: <netdev+bounces-197894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471C6ADA343
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 22:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640EA3ADC18
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 20:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C3262FD4;
	Sun, 15 Jun 2025 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r00YtgYa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050E189F56
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750018093; cv=none; b=EOG+weS4HblW01mTOYTYOPFCwwiBOClldm5CwhyNFv/hdRlAUX06gXnxYot5Y5YtK/8E5/NzL5cAoCfN+kqzpclbLMMalOt8kz+Qei3PFrxUUEsrGSZqA1ccQ7NW2xKcFct4r8qndhm3+DhHPDGYZcbqJbDj/mfSYOk0q6HYI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750018093; c=relaxed/simple;
	bh=uMOPMEFm6zkUEwkTzRTS07bcGtVy0E9xLhozA2iAlG8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ik71vtOEaS+IjH9QL5E/LAxO68u6jsBfHTIRm9YBhThgXOpC+CEhYQpU+bsTKYCHV+/40VsaNZVxk98cmr1pOS9TiwcHh3Zl6lFyLKKzSq0CZw41o8xOhDoYd3upfm2n25pX3B+u5lPfnUo6hCOFzzNyptc83XjNNo5LVDrH0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r00YtgYa; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74868e73f4fso2853330b3a.3
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750018091; x=1750622891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/A+Xw7FOtOaP2Wv05uKtCUa//XsXy8YvXBf7/4De0I4=;
        b=r00YtgYa/O4OWV7QmEG2L+PU9WgnC8BmKVurGH9XYUkx5YP4q72NZk3n/mqbRBW+yN
         Fvlzf4CjBSuPeFx9M40vZNmfYT5pQ7mvDTBSjfcekIIBZxZfAH5GKPAOjNOn0mvcKnGk
         ErNYzN/jAH0sYOLD6Ob0Pt3UGLS/73PKWWaItIytvXeQ2bXfrgs/plCG4VsJDmZ2qLTH
         Tkt1tsYgniYym/y80WswPSgv8rXoZgX3fZ0ov54c/gQCAhkmVIPXrZK1QT6xhe6SYwrU
         YFTwOXeG05k7payRYEJKTtTKeQFmtGo+FcmWTaL9OFS2Yp+iWqwFxlYXcd1delysI1Zh
         Zjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750018091; x=1750622891;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/A+Xw7FOtOaP2Wv05uKtCUa//XsXy8YvXBf7/4De0I4=;
        b=bWNB69iGmxRF0qWubhF62xxtliCRf5Sk65CQmhzU77vuCRo77W/EBQfQIOWrqNgAEH
         nQHk0Y0sAwIHowfOdAZJa15NaaBdIGgiqSXB2wX+93UIJINBPgXFWrdXsXBglFwXAZZL
         7VUR4f3YnArtSlOF5DpYMb36mJnzWEIcZ/F4gODFZ+rNr2PvnqFwvj4aljI80ntLO9Fe
         2d9y+CDAwvMLMJNmW52KDw/qmz1WguYhSupToa6vNvVBkE3zvVD43oTceb/XmvFqVPn9
         ko/OkUPBF+gaEc+a7mQnydSgepiF2T36OZoG1u6T0qNzBrpGZBDoIZ2w3rWJwZRG7NmP
         0+dw==
X-Gm-Message-State: AOJu0YyqXqABnkeRXp9LRRFYBCnUN1VLHBawE1VRHGNQyWnNjltWjakb
	3tQvYToIhiGsmhagy5A52TKbs38DTBVvfOBdhhpz4Pldk3BWNNxu/SG8qPBycW+KMJkoeQGp1iM
	I0SmxqYPD8Gjmg8YZ0i9+x+SFf9z/u65SqCSYSiXvyxjRP6sw/RZr3LBsLnHd/ugRBzHiyDFSOH
	iuWOTfynNojrR+jPfe/siS1DH/0VBzMEYmpbYyyv/4T3yLSTzxNPhxGKbqTSYmj5w=
X-Google-Smtp-Source: AGHT+IF23fHiZFDqsUkUJTe5Jy6SuSLB12ZzYWCujHdrS7T08CwiXfZM3+F+UZSGHgkckhnF3DgNgir4mq+nA4nJCA==
X-Received: from pgg12.prod.google.com ([2002:a05:6a02:4d8c:b0:b1f:dd75:de2a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:258e:b0:21f:a6c9:34d with SMTP id adf61e73a8af0-21fbd473bcemr10025937637.1.1750018091208;
 Sun, 15 Jun 2025 13:08:11 -0700 (PDT)
Date: Sun, 15 Jun 2025 20:07:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250615200733.520113-1-almasrymina@google.com>
Subject: [PATCH net v1] net: netmem: fix skb_ensure_writable with unreadable skbs
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, willemb@google.com, sdf@fomichev.me, 
	asml.silence@gmail.com
Content-Type: text/plain; charset="UTF-8"

skb_ensure_writable should succeed when it's trying to write to the
header of the unreadable skbs, so it doesn't need an unconditional
skb_frags_readable check. The preceding pskb_may_pull() call will
succeed if write_len is within the head and fail if we're trying to
write to the unreadable payload, so we don't need an additional check.

Removing this check restores DSCP functionality with unreadable skbs as
it's called from dscp_tg.

Cc: willemb@google.com
Cc: sdf@fomichev.me
Cc: asml.silence@gmail.com
Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/skbuff.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85fc82f72d26..d6420b74ea9c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6261,9 +6261,6 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len)
 	if (!pskb_may_pull(skb, write_len))
 		return -ENOMEM;
 
-	if (!skb_frags_readable(skb))
-		return -EFAULT;
-
 	if (!skb_cloned(skb) || skb_clone_writable(skb, write_len))
 		return 0;
 

base-commit: 5466491c9e3309ed5c7adbb8fad6e93fcc9a8fe9
-- 
2.50.0.rc1.591.g9c95f17f64-goog


