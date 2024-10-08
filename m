Return-Path: <netdev+bounces-133147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD30C9951A5
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852E6282E36
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88341E00A1;
	Tue,  8 Oct 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5B1HrB8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70B1DFE2A;
	Tue,  8 Oct 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397510; cv=none; b=Cit4BJWsqCCETmz//kKk5+cXtbh91FQT5JCktd0tBpYNUvzlWvR2IAditoZANfPRHOMp4c/MqUVWyu3N7XANicnUrnLe9uYUOmar+0/41c/aHJHqzjQHrYAUmyrgl3s6qhzjr8eG82biKgqn8LnpTH9jpiFgWfnUpI6KyvsrFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397510; c=relaxed/simple;
	bh=dKbZM7+rvKdCAftLsIqRMrR/jd8BPaE4KCzu53bpfvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RH8gBeOM9vKlg1mZwXR08bkefToMOh6uEXTPCnPysCCNeTP3wetfUQYMFLFBhwuIX9+pJIOlvrQMSspCn8Dv6HVHxbrdUCjA68ICAfHO31MH0GWiO40a5lj/YxMoLnFI9eOLAk5AjhY9gXzXhxyii9jjXX3OfqjsyBSF5/fWbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5B1HrB8; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e1bfa9ddb3so4400190a91.0;
        Tue, 08 Oct 2024 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397509; x=1729002309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwQKLkW+/qRHGLn4gTua8kQBWJmQk8KcS+aTLWa1XwA=;
        b=E5B1HrB8DZ6VSBZpE3p6M6WK+wmllsw/McANJFxGfy5Ilh+UPnRBCehFRCgK23lQmf
         jjK1SnvPJtw8+8zeeT+9JYZIanSOJLBqSZ1W/dUJlMBHPJX7YiWLMPF9/SsRq0NSbgg6
         ogvNdnv3Nut8vmVuroQ7/rGHlSKU+mUjqHi1AHlKHcI7ZDzDOmklXMXfOGcOSAnCmbc1
         H+/QruvXh644K7yGT+vbrx2TnJdRgJsN/uvbdhH7m7vKVzo49WOwbEZiqsP7ul2cSacT
         9EmhrBxOnlOnm4fDfcVdoj85kNUwsjPMs9CNhxIhGInYBxZZE4Lg+q/DmFJIgJVD5k1V
         bxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397509; x=1729002309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwQKLkW+/qRHGLn4gTua8kQBWJmQk8KcS+aTLWa1XwA=;
        b=hvUWlDSOE0A5tiGnYkTu8bR84UouZrgO4HQCAfiQbwHRiPeREpUxJLCX1lKAurCZyA
         mPtP2wiWbc7zlJqlg25aFKHdggbceafrEBisAEo2uIUE2507o/NQyN0oqkGs0tMKjCm/
         xQFHvYC33A48WUO5hqYh1aBMUVZ0EZiWT4hFDA07Kueyi32yuiiy0LHi+e+99xfxvvuz
         /H4vUFBuyQ/wIDoALwKKaHhPULoc7VoRh+4giY2oNgmQ4xpELL1ldjLhfAcaXvVSTfBk
         H/rWHjdbaT0Zo9zlmTJKgbBAe3afAFysdD1ZOlJGCxkIa5kij1DDqUowkllR4zSg/iKE
         Uu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3TnWKzmsY0uCPq//hQhc34fUNibkbZetwZyuOGjolQSN/cH3WtmsXS9WzLpbAIlj6UQG0cLQQXLMQyhE=@vger.kernel.org, AJvYcCXZrEXbz5DBicL2wRPFcaQFRn7v9I7lb4qWGWiYkOi+j80KTolbA34LoZKoLxiS3Ere0QmJvDbD@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0OcaimTaYes4szUIes+bynqnfAN6eE1m69FK2Wg3e46dvqSi
	v7raEapm6Z95aX+lEP+Riwf2lWfdWLNr0WVFvDxay+2bBxP56gCN
X-Google-Smtp-Source: AGHT+IF1PHBCFMaFpGeZDTlx9CT8HkOAtUml40nGMXnA+2Y228lOaD0QQtn/w3dqxiJOqTUOopcUKQ==
X-Received: by 2002:a17:90a:71c8:b0:2d8:ea11:1c68 with SMTP id 98e67ed59e1d1-2e1e635434cmr17576173a91.31.1728397508617;
        Tue, 08 Oct 2024 07:25:08 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:25:08 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 11/12] net: vxlan: use kfree_skb_reason() in vxlan_encap_bypass()
Date: Tue,  8 Oct 2024 22:22:59 +0800
Message-Id: <20241008142300.236781-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008142300.236781-1-dongml2@chinatelecom.cn>
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb with kfree_skb_reason in vxlan_encap_bypass, and no new
skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 508693fa4fd9..da4de19d0331 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2290,7 +2290,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	rcu_read_lock();
 	dev = skb->dev;
 	if (unlikely(!(dev->flags & IFF_UP))) {
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
 	}
 
-- 
2.39.5


