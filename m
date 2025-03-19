Return-Path: <netdev+bounces-176006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C817A6854E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 07:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5CF3A6320
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 06:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FB524EAA4;
	Wed, 19 Mar 2025 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="TwxQXZhk"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A93F204685
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367328; cv=none; b=J2OvEqrn8Q3Sruuk1jtiTfnvBbPuYs0A5s8SOQwK3n0m9WV6WcGsm7o8wfH6KqiitVAVuE0EbKp2x/mNfDOaEwxdVn0IvYpiWZbZ3U0Q6r7eLxHxJFkMz3keZfogB+7/fsNADISndWQi8rEDd9SXHv+DXen8y5gkY6lb92u7Wl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367328; c=relaxed/simple;
	bh=qunMYex9ypeCc2jiYzGCxyMdYiAPp42BYdp879GIPc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AoVEwM0SE0NLAaKVin7xELE2xUN6p9AIe2oTIO+1A/EK1g/Gh2PYRVQcYRLxt1286PcyImD5fe0MlcNB1FdAARhJvF8xQeC2yuWSqQ0rf9WXk4JWGbWc32mZKqAp4X0vEZn5Iujva6Ego8xtBLP2Lkxcn7NvXYP7sae9VaySk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=TwxQXZhk; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 455AE207B0;
	Wed, 19 Mar 2025 07:55:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qfPjah2beWnY; Wed, 19 Mar 2025 07:55:17 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B7ED1200BC;
	Wed, 19 Mar 2025 07:55:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B7ED1200BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742367317;
	bh=47itfgCJqlnTS+O+hl6rARfFA0sRpi4eGYYszRv+y1M=;
	h=From:To:CC:Subject:Date:From;
	b=TwxQXZhkJRXR6V2Us6BLjAycOADuezXdU/IFs21eeW1L869a3DO5+/S4xyMBy4grO
	 yam19+YbrufRMaa6xH3kfTx8ERyWTUWhzllhnag25gM3Y+vPts/WGVwBnJJktmKVrw
	 MJ+hupF9GJMg5EyqjeIlBXCeF3MwY9yuHFHpcVJ9kaIZxExu1GGiMLh1cKd9joj4Ds
	 CldCFoGYJ15aOi7PMAYrGb5VRjXdOZSbeIK+by3M1NJoi846R7MvbFn53elK6rTM3s
	 vLe05f0lh3Z8lg54tNSBHO1s4JvASZ46erlLcKxUnMzBOz83iDEYXFLp6GEo/iCJVt
	 KKzFyPQU4ziVQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Mar 2025 07:55:17 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 07:55:17 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8A0E53183D88; Wed, 19 Mar 2025 07:55:16 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/2] pull request (net): ipsec 2025-03-19
Date: Wed, 19 Mar 2025 07:55:11 +0100
Message-ID: <20250319065513.987135-1-steffen.klassert@secunet.com>
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

1) Fix tunnel mode TX datapath in packet offload mode
   by directly putting it to the xmit path.
   From Alexandre Cassen.

2) Force software GSO only in tunnel mode in favor
   of potential HW GSO. From Cosmin Ratiu.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit a1300691aed9ee852b0a9192e29e2bdc2411a7e6:

  net: rose: lock the socket in rose_bind() (2025-02-04 14:03:58 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2025-03-19

for you to fetch changes up to 0aae2867aa6067f73d066bc98385e23c8454a1d7:

  xfrm_output: Force software GSO only in tunnel mode (2025-02-21 08:20:06 +0100)

----------------------------------------------------------------
ipsec-2025-03-19

----------------------------------------------------------------
Alexandre Cassen (1):
      xfrm: fix tunnel mode TX datapath in packet offload mode

Cosmin Ratiu (1):
      xfrm_output: Force software GSO only in tunnel mode

 net/xfrm/xfrm_output.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

