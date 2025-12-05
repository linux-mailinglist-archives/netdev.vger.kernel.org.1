Return-Path: <netdev+bounces-243818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62700CA7E53
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66773159FF9
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 14:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504AA28642D;
	Fri,  5 Dec 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbE7AXPQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCEF2E974D
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943618; cv=none; b=naMC+M4AO5ZHaX1avNuBpFRYsk1c2aN2q7Mlw0wXVu++ci+q8aYF7JxlxdG80507bywxO2UK3SZMyNFr2WT+zjoa56iPYq+e5imGHP5AGW7uG/hcVp3sUxqZ8U6GUcXki2CvUFDmQDevya8NejCpLXfxWjP7uugwKPlSTrzNpjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943618; c=relaxed/simple;
	bh=VSstG9zcCfh9eV9IiT0zbtVD+JSCl+s8oOgqm0VMmjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kms15gdZRRI7EvkXcqFMhulPIZ0lRBD8OU7ekHqjnsiJfWLjM2UjFnYmZ3ItTOqzYl5G6ePzpjnf1baoIevyeBiLxOVUpy02GshDRxG0a0v6ZQtUMC3ijivuoSC+krTDUXoiVN6S/QrakOFhIpti7X0Z9LYgdveLjiy/Chz51b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbE7AXPQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764943584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+iMTeVc+7sO/2YkTfilp2vysDjDsIEE82XFegn4CvsE=;
	b=ZbE7AXPQgtFF9BcYmo+7Cla+6bXzVZ6w3fw/PRX8K95WtgBdUgWRsMqUkDCh3OJgo7UyaI
	/f6AsDCg7XO9wH6tW2Ky7T83CJGtwDYFwk0pAkpCIKyQngecyx65gcPLlPZWg8+WGlYnwD
	lcPpGSYTdcXG9h8Tman6V7fXZ7LAo1E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-Eo7eiYGoMmGdWKYpU8BILQ-1; Fri,
 05 Dec 2025 09:04:58 -0500
X-MC-Unique: Eo7eiYGoMmGdWKYpU8BILQ-1
X-Mimecast-MFC-AGG-ID: Eo7eiYGoMmGdWKYpU8BILQ_1764943465
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 003BB19560A5;
	Fri,  5 Dec 2025 14:04:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D70D219560B4;
	Fri,  5 Dec 2025 14:04:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: [RFC PATCH 0/2] net: gro: avoid touching transport header
Date: Fri,  5 Dec 2025 15:03:29 +0100
Message-ID: <cover.1764943231.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This series is basically a pre-req for GRO support for double UDP
encapsulation:

https://lore.kernel.org/netdev/cover.1764056123.git.pabeni@redhat.com/

that otherwise would requiring explicitly disabling gro on the outer
geneve device.

I *think* it should also help plain TCP GRO performances, even if don't
have a very high speed, full zero-copy, big TCP testbed handy to
actually prove it - see patch 1 for the gory details.

Paolo Abeni (2):
  net: gro: avoid relaying on skb->transport_header at receive time
  net: gro: set the transport header later

 include/net/gro.h        | 26 ++++++++++++++++++++++++++
 include/net/tcp.h        |  3 ++-
 net/ipv4/af_inet.c       |  2 +-
 net/ipv4/tcp_offload.c   | 16 +++++++++-------
 net/ipv4/udp_offload.c   |  8 ++++++--
 net/ipv6/ip6_offload.c   |  3 +--
 net/ipv6/tcpv6_offload.c |  2 +-
 7 files changed, 46 insertions(+), 14 deletions(-)

-- 
2.52.0


