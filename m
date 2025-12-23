Return-Path: <netdev+bounces-245826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1167FCD8F03
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64A2F304A134
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8932D443;
	Tue, 23 Dec 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cmTpNtD4"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF232E753;
	Tue, 23 Dec 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484255; cv=none; b=YEkF/8/tSGO1GpqVE2J/yhPgm8qAxH/HFrAPP1FwrUPp/tbG6wM/8pIpPOUc9pEXi+moVJftBrtWQR2zs/+S2eXCoHW1Nf5u633lWwB3Z7YzR6ZCP3M+DwcERS3LPJvFBYpHtkftr6+DyvoKrp3GT60A9CaHBlGHROYnMVuNWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484255; c=relaxed/simple;
	bh=Rye7TKeLjENQUoWynF0+eXw1TJYyJDFqMbxiRLqWSno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FhKEuJuUqQ8fPTK9QVn0ZQs4+jYE/ZUvhCuYbnBxW9VoRRSK+C6QXNwOpKoOES/O3JAuWT2muuSbxm2iJ7H0DY0U5HZUmMBj9QSwAJu7Rm7EwpEt0Yc1RNmsAtwPmhbeerNx6jnAliq4PG/SGiNAcHb91rhMkSQdTdI9cN4AY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cmTpNtD4; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vXyUm-00B31j-JB; Tue, 23 Dec 2025 10:15:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=ZAOAR3B/TVl8MoENDSu7BqSrLt+X6o9NJAyEvC2RqqE=; b=cmTpNtD4aXSsP1XPJo2kgiHP2f
	h52+Xyw9W73l0Op9w52hI+aGFd0DW0gX+dbw8hymhxelTvad/zCNjatpzA4IFfevHEortR44mh+n5
	ntfGQJLyeN5FYeCk2O0RoKEJqnjTJVQklTG8PST6zHE8Q+TfC4poCA+rEQJ7ED58ZZAQtAAkSM43o
	v0+0mE0zVphhVC225KZJmDvevgM2lVNeqoRDFe/yezmjwaAZva9cqLIiNIbfAaW3qA1kM+II0DU9T
	aVNmezd07CyCHXqMSULIlQDl8nBjjY15ypDygkrNDd8O42c8PtRAPXLqLldulv3HTZ89PePFKh0Lb
	+FCClZ/g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vXyUm-0001S4-9j; Tue, 23 Dec 2025 10:15:56 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vXyUg-009MHY-F6; Tue, 23 Dec 2025 10:15:50 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 23 Dec 2025 10:15:28 +0100
Subject: [PATCH net 1/2] vsock: Make accept()ed sockets use custom
 setsockopt()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-child-sock-custom-sockopt-v1-1-4654a75d0f58@rbox.co>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
In-Reply-To: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

SO_ZEROCOPY handling in vsock_connectible_setsockopt() does not get called
on accept()ed sockets due to a missing flag. Flip it.

Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index adcba1b7bf74..c093db8fec2d 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1787,6 +1787,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		} else {
 			newsock->state = SS_CONNECTED;
 			sock_graft(connected, newsock);
+			set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
 			if (vsock_msgzerocopy_allow(vconnected->transport))
 				set_bit(SOCK_SUPPORT_ZC,
 					&connected->sk_socket->flags);

-- 
2.52.0


