Return-Path: <netdev+bounces-80556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EE787FC7F
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0830B213B9
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC977E591;
	Tue, 19 Mar 2024 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="EXxBJsmu"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E71CD13
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846125; cv=none; b=q8+v5R5SUH8h7SkRaWsEN3i03QjgAhjIqPglkA4KDztSrgzYQu5JoqaaY3soxlPiStLz77L9N5aGWWfREcQK+/Q2MInW5egUBhxZZLL7jvx+LFpaJoVYjr272SOAUfwzk/ptadFeGQ36ZkLiSMML/Z8DsLZXgR8J+WmuMzlOJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846125; c=relaxed/simple;
	bh=nAOY/c3yMb4jf3GZy76dDj2x1NP9DmuAsDEztCfslX8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a2JWFJX5TqX0CdvS8NnFmda9MtkSzyWXu0kKx0NBPtH8E15HSyBwtD0IHEq1uj06uQ/1r6BrQei+r+V/uy32Yq6ELM4Xs1omnIthOpXkMOJbnfepKHaD8qdoZGnZ+Gl8Axl//hgpnyzxXDJKv2YRlpUucezlquCA8GQuzpzmnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=EXxBJsmu; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id CD46F20561;
	Tue, 19 Mar 2024 12:02:01 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sqHcnakjWAgj; Tue, 19 Mar 2024 12:01:57 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 75484207BB;
	Tue, 19 Mar 2024 12:01:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 75484207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710846116;
	bh=MiFyMBANwGJII33S4Jxclxv2qgEUm2aNDgsiKfaTbak=;
	h=From:To:CC:Subject:Date:From;
	b=EXxBJsmutdSic8TcubhZY9z5qUjkivKmftZNy49FzhUrLFBDKkZsKWX17rfWRYbpY
	 m/esYiR8o4i1JnP2J2tEEiZ0f94M5Cm/qw1hDeZWi+2ilq7X4dNznRfvpZdMZXxJbP
	 Q4lGdgS4rizUZW/3/EywBNWTiWjDIea9hYdEr0jS3aPL/VJKoDq/UL6xNKt4iUkseE
	 4G1FglaK4AdIXXVOFHa+maesimMPmkPgRJ9Do2PoUgqH7H6J2BYwYqiuNp5RDNEi/9
	 rmoG7Oa0ZZJO5pYni/DXbReJxqgkmHilhfiFG/IvgcFiSxHAg/PpE8LOXC/Dbb62Xp
	 Boh78pOuCEkJA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 6891980004A;
	Tue, 19 Mar 2024 12:01:56 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 12:01:56 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 12:01:55 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 73C3931849BD; Tue, 19 Mar 2024 12:01:55 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/2] pull request (net): ipsec 2024-03-19
Date: Tue, 19 Mar 2024 12:01:49 +0100
Message-ID: <20240319110151.409825-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

1) Fix possible page_pool leak triggered by esp_output.
   From Dragos Tatulea.

2) Fix UDP encapsulation in software GSO path.
   From Leon Romanovsky.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 6ebfad33161afacb3e1e59ed1c2feefef70f9f97:

  packet: annotate data-races around ignore_outgoing (2024-03-18 09:34:54 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2024-03-19

for you to fetch changes up to 773bb766ca4a05bf363203030b72b10088869224:

  xfrm: Allow UDP encapsulation only in offload modes (2024-03-18 11:56:11 +0100)

----------------------------------------------------------------
ipsec-2024-03-19

----------------------------------------------------------------
Dragos Tatulea (1):
      net: esp: fix bad handling of pages from page_pool

Leon Romanovsky (1):
      xfrm: Allow UDP encapsulation only in offload modes

 include/linux/skbuff.h | 10 ++++++++++
 net/ipv4/esp4.c        |  8 ++++----
 net/ipv6/esp6.c        |  8 ++++----
 net/xfrm/xfrm_device.c |  3 ++-
 4 files changed, 20 insertions(+), 9 deletions(-)

