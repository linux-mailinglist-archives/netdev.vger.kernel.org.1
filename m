Return-Path: <netdev+bounces-209245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25BCB0EC9E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D346E1886950
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A8E279333;
	Wed, 23 Jul 2025 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Y1rcLH6v"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552FB217F24
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257849; cv=none; b=ATd5fAq8VPusgFHaOiVzPExm9XSk/b3Ni111Yx0Om6AOY2HF3Q+aHDvZpzeavEHKD0eAcTvtsFU7RW3OlOm6New/UwGreoFAzvdg5Styz2w1ufl1dIEmYAuUl9tkMARtifJU9vB2N5z3DD1sEUCjWhNaN9SmidVddxKMQcAJzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257849; c=relaxed/simple;
	bh=+tnZfGedtEk7H9WQYMu/GrfGANUch1ev/PFBqcxM6IU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQGsCj2JfzLm6aSP0Z4LCViKHm+I0pM5agKXZgV4/yOKQ3QqpuwYbGPk1414bpx3aLfkDofLWLG2TQcJ+KfvmRbVKuNGqsbjo9ifZEf1DlJ84gT5KSf6sb7umQmMku1VeuH2aR+EJr1271mVHcJAJ1TqrN9msqmmSMsWydEOo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Y1rcLH6v; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8DEC52069C;
	Wed, 23 Jul 2025 10:04:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xjvu3UG1b3Hs; Wed, 23 Jul 2025 10:04:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9973C2088A;
	Wed, 23 Jul 2025 10:04:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9973C2088A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753257845;
	bh=dpQ7/upwclKQ1GnV4E83L32EYNxU0o2BjP7O4taZQTk=;
	h=From:To:CC:Subject:Date:From;
	b=Y1rcLH6v+/dEP6u4rAyZ+PXPB4FgbC9TEt5Mgk/gb1mIe0z8aWalRsm/4upjPzGtK
	 apWvnfNqNY4tP20DajQ5yy8VCHa6It75b+p0I5SjI9PKmacdLtDNxTDDd7JmSzLt0D
	 FGNtc/n1KwU+7j8NA4mkoRXDLF2yF9RcxHu3AKJRdj3N5yjkoZzTbACG7CpzA/U6ty
	 6ho8ssFu1n/1dcaTowF7K9KK9k5iOOczyrsrpiJK7eZ1GpISK+bFGJMHyO+3QMvyPt
	 SDz/pOwS5JDnF1MV/ohmlGsMPJBTTZchHFrmtECrSTk95NU2vnTQ0ZgJr2H69jhMe4
	 Ve722460l+ZOA==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 23 Jul
 2025 10:04:05 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9624C3181838; Wed, 23 Jul 2025 10:04:04 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/3] pull request (net-next): ipsec-next 2025-07-23
Date: Wed, 23 Jul 2025 10:03:47 +0200
Message-ID: <20250723080402.3439619-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

1) Optimize to hold device only for the asynchronous decryption,
   where it is really needed.
   From Jianbo Liu.

2) Align our inbund SA lookup to RFC 4301. Only SPI and protocol
   should be used for an inbound SA lookup.
   From Aakash Kumar S.

3) Skip redundant statistics update for xfrm crypto offload.
   From Jianbo Liu.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 4f4040ea5d3e4bebebbef9379f88085c8b99221c:

  net: ti: icssg-prueth: Add prp offload support to ICSSG driver (2025-06-19 18:24:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2025-07-23

for you to fetch changes up to 95cfe23285a6de17f11715378c93e6aee6d0ca75:

  xfrm: Skip redundant statistics update for crypto offload (2025-07-04 09:30:22 +0200)

----------------------------------------------------------------
ipsec-next-2025-07-23

----------------------------------------------------------------
Aakash Kumar S (1):
      xfrm: Duplicate SPI Handling

Jianbo Liu (2):
      xfrm: hold device only for the asynchronous decryption
      xfrm: Skip redundant statistics update for crypto offload

 net/xfrm/xfrm_input.c | 17 +++++------
 net/xfrm/xfrm_state.c | 79 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 58 insertions(+), 38 deletions(-)

