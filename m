Return-Path: <netdev+bounces-77081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19584870134
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 13:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D9628365B
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F3A3C6BA;
	Mon,  4 Mar 2024 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9eB4K0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F03C6A4
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555251; cv=none; b=u0NOa6TtRyr9NgMF8G9YeoTgN5Bq6apePP1bIXvJLlga7M4pGBk+QHQ4Y2B3asKVd/AmmP7h8pAes9+R6cmEnXi618cbWiMP2gjP4AgH5JZMxcKQSeHd6RfnMzPpfikKc3MtQMKasa+sMQo2xk0k0gUqoKJs7fsNNkvueXMI40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555251; c=relaxed/simple;
	bh=blYlukxU1HrX2dJSmVG0czCTMtI+Y3s1o0pAib6j4Ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hGYAdJIiAQyl6ulu51L7m/aqBeu6nOIxEAOO6Bmi0YTfN6iEhsktjIqOyjyuV7xyou+LBeBwg+kOiPj30Sj4373fAYLsD0ju4Dx1lJ8rtjdFdJqMEIIpNgUbTB2ICsPzpSS4e+KKtf4PWBjS+5FpE1WBYlosK3QoeNKxtjPramc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9eB4K0s; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609a8fc232bso10398457b3.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 04:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709555248; x=1710160048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrCBWq0hJPaTwjXTInwIrzdabrZeuc3v/+N6nPE139A=;
        b=n9eB4K0sksunxUuj117d9lxBwdZM+gUAN9UIEPA3lTPsbRmuSltgt2BLe9S739akyl
         VwaQInegjIWkuDvPnPoYI2epOrXxXqlikiVDiL2Q+U+Ay+DE7aH0ge/KeTGrR4/3l46G
         gXQ2+KTi1KRy4rN3T1G2DFhjUtDu8/kjRkoyY/1VC+73V/FHOUtbFQSsKaVohpPakLR0
         1G6yittNfDwC7yhcIQa2s4JUmmGGEc7uzJsiV38/xs5XohUoMhRz59DauW9OEAg/9YOm
         qT8YTwqvsAMEqeHBS1X9yzJ5vcSN6wZtrEKUU+BR1Wt/awoxm44ID81BU9tn+3fv4Xue
         XNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709555248; x=1710160048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrCBWq0hJPaTwjXTInwIrzdabrZeuc3v/+N6nPE139A=;
        b=HDV/UV9OY9ZFohGPVNaUazQ/5nykBOdSy+2RamRoK2Bb4kX9kDv09TY9FeVdNYabNQ
         uDWcuij0l1aRpacwm0gkMyKqYytKgz3NkA9Z4AYs2CsaoUQb5QdCyC06m637C9g54G0d
         KLGTqTG5Hs/Ald9UPWsvSp2CK9v6J+3hRaXEs7RbUWBPpf7NKMZKePLqcjC0Y733otpn
         Ve5k8D8fctHg1pbNOi9OAIvmP6saBJSR/odei6EdgzNzrV7t4etiHRrxikSv3tFkReaE
         q9TcZVshnKY8PoGYa41UlWyi5Q4xoYbvMQgtIU830N1I7fWzK/1wTWQNTXIWv84qWY3Y
         hmjg==
X-Gm-Message-State: AOJu0Ywh3vt9c4hOgPre8T9pPSb4uRWhLkyAuKSO6YeO5JzPkSLWD8Wj
	jxjn/vNTl63mOChkqr13JtKrsWM2kINkusabIC0APkW445dZdB+fh6zwC/tW3R6FAcZF2Nzwx5V
	M7fzk/wxg5kgFmxx91uqc/Ez/gpU8YHeOz6qnmRYxzzH1Pc6gFCW333nAFRg6LXfL7AeM90aIkm
	Jx5b72AFc3sPeXvFbQB0qu7k8OawBPQ25B
X-Google-Smtp-Source: AGHT+IGG3w4SvOhTpHiSgHsknysO72W+q4nZXvHm+rPGzpgGYqxKIlcdpGBdMJ8qeLRtcomZBQ4SGbujCys=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:690c:c86:b0:608:ed2f:e8f1 with SMTP id
 cm6-20020a05690c0c8600b00608ed2fe8f1mr1894531ywb.8.1709555248579; Mon, 04 Mar
 2024 04:27:28 -0800 (PST)
Date: Mon,  4 Mar 2024 12:24:09 +0000
In-Reply-To: <20240304122409.355875-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304122409.355875-1-yumike@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240304122409.355875-3-yumike@google.com>
Subject: [PATCH ipsec 2/2] xfrm: set skb control buffer based on packet
 offload as well
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: stanleyjhu@google.com, martinwu@google.com, chiachangwang@google.com, 
	yumike@google.com
Content-Type: text/plain; charset="UTF-8"

In packet offload, packets are not encrypted in XFRM stack, so
the next network layer which the packets will be forwarded to
should depend on where the packet came from (either xfrm4_output
or xfrm6_output) rather than the matched SA's family type.

Test: verified IPv6-in-IPv4 packets on Android device with
      IPsec packet offload enabled
Signed-off-by: Mike Yu <yumike@google.com>
---
 net/xfrm/xfrm_output.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 662c83beb345..e5722c95b8bb 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -704,9 +704,13 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb_dst(skb)->dev);
 	struct xfrm_state *x = skb_dst(skb)->xfrm;
+	int family;
 	int err;
 
-	switch (x->outer_mode.family) {
+	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
+		: skb_dst(skb)->ops->family;
+
+	switch (family) {
 	case AF_INET:
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		IPCB(skb)->flags |= IPSKB_XFRM_TRANSFORMED;
-- 
2.44.0.rc1.240.g4c46232300-goog


