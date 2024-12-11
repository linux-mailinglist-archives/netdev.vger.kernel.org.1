Return-Path: <netdev+bounces-150986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899239EC47B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECE31678A5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 05:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C081C2DC8;
	Wed, 11 Dec 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Cr7lkK3E"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC472451CC
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733896608; cv=none; b=OuhZZCgCFShXY1n/+5/KEsJzk4iEy6/QAeFqXPl+jIjl5nOWmeft7WXDBfB18FHnKGqDNbBDUTphzTRPaPZIlTO2gw0eN8lC7jPN4/W6peu7xGmr5ZQcIT4Ej8J5l+BjSOnOrKsnSQDGubxec7QTHFIgTg59rg7IfIAOQ13Xw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733896608; c=relaxed/simple;
	bh=cxzMck+PtZvX8MyDZSjRj8Or44yKgy7I+xPrmdtpN3Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jx5+RcxvcqGcNDsitTU9eGVLCgbwDpaNQSWZfjTg+r+u0gpm52Bd8uxwDB4UEI3gl5cUg6acWX1lhvHBP4nBzYZEFuNapGfm3j9gtvYy5ds8eHQ07Z0WJG0toJVSMfjPOwnGL00Xz3JyrJ0+6fxBuJFmJVWi5wuWP0LXpI6rb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Cr7lkK3E; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1733896598;
	bh=zZh2DWlFpOFLfTvIWRZqC9dDQryFloct5d0fU+hPoFo=;
	h=From:Subject:Date:To:Cc;
	b=Cr7lkK3Ea3tpvRxI6CVW6XEYqvtCsYVYB/L2Avl3jJG3CZAd0O84WQ50NRQk9+hvu
	 zcv/lKW5reHgFAgKfaHrsK6luOfh4wVIjicTHrBguk6lLRrxzaWSjVjGZo1fgHd7i6
	 ccojd4x0sj7uUi41pP5iinI6AByI6jKLGpSZc/eDS3oVsoZypLgDT5P+5p4S2GyesS
	 iGawE+DrR35M2fIj6l4b5xXBegDjVE6oNAxvkxlnG3F5Q5V/Q2uOQKXsWomemjvE/3
	 NS618NeWt/Abzcm5ZsjtS2k7OW00dV4hCZzCY/VErxlrZPykAEvHfHK2AEFFvaZmdD
	 Lh0qFquSIZOtw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 6DC546E761; Wed, 11 Dec 2024 13:56:38 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next 0/3] net: mctp: MCTP core updates
Date: Wed, 11 Dec 2024 13:56:15 +0800
Message-Id: <20241211-mctp-next-v1-0-e392f3d6d154@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH8pWWcC/x3MQQqAIBBA0avIrBtwzIi6SrQIm2oWWaiEEN49a
 fnh8V+IHIQjjOqFwI9EuXwNahS4Y/E7o6y1wWhjyRDh6dKNnnPCVlvq2OrN9QNUfwfeJP+vCTy
 nX8FcygfueuOGZQAAAA==
X-Change-ID: 20241211-mctp-next-30415e40fc79
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

This series adds a few minor fixes for the MCTP core support: ensure
we're handling socket delivery failure appropriately, and allow
MCTP_NET_ANY for the tag control ioctls.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Jeremy Kerr (3):
      net: mctp: handle skb cleanup on sock_queue failures
      net: mctp: Don't use MCTP_INITIAL_DEFAULT_NET for a fallback net
      net: mctp: Allow MCTP_NET_ANY for v2 tag control ioctls

 net/mctp/af_mctp.c         | 11 +++---
 net/mctp/route.c           | 38 +++++++++++++-------
 net/mctp/test/route-test.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 16 deletions(-)
---
base-commit: 7ea2745766d776866cfbc981b21ed3cfdf50124e
change-id: 20241211-mctp-next-30415e40fc79

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


