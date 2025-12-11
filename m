Return-Path: <netdev+bounces-244401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9EECB6555
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 16:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08D8A302C8EA
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD22D1911;
	Thu, 11 Dec 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="aPr7wzkj"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CBE2B2D7
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466482; cv=none; b=N+oqTPiPwNzzELgyDCn+pluGqRazVKSeD5ECrDQ++/9LdRI7DN7ibDzjIQARri91p7vR58v/9sCnLwx7MKVbCe+UuT0KuIs1v2SB/ooVwah6/xvnAmkF8Nv296zE10/1UkRkcQt4wEy2PUpztIQCNSBNn9SS3/G+EtHnLcAEBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466482; c=relaxed/simple;
	bh=x2VdX2i9X06jNrcN9luUurZIbvprCejSI3S7F0omJLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sh9I2Gn5amEzOuh1/X55dHZCCbzQbh3AktmTV+6gjfJMmrB9tvx3r6sjOb6kiCqfLrRrA35P9SvHpRpNNSPygjlsrrvlhK20OEZ0Wh0HaABbOmaK2BdFoWJeAJGU9yRfFiPeV6+UFWkhwb6iXPeWQxvtECsNWSvdH0U8HnQR1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=aPr7wzkj; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765466481; x=1797002481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hA5ghf2zjiyqiApmgYxJPXwqkr78qqO+4ybETELdnUE=;
  b=aPr7wzkjAFsXDL5r3BtmFYKTWfvjn3ug6qDc99gFDIqZ+Jz+IR/gW2Up
   d0Di5t6XfkAjaWepPAXl9pH8RG5u1pc1qzk4dJK/7HeRhhS0O5Kc6UKQu
   U8z85ELxfnpkLpv0DYt4clkV7zGVc3aai4TYDcZdsdte6PfGPES5Pd0rS
   xgulVLw4RU2i5xM8v2AtgjVjOkdz82w5EPu45ESZ4h5rJPCLohqFpTppp
   60/rusDRiHP6lXqLJSo1VwXKdP28Fy+0jt2U+lsahL50UdUImCnwnrMQx
   WgkhaYsQbtONkn3mwR9bHlUD5dVU4nGSfsGwbOf7ZfSxvbLeKZfXDQdLN
   A==;
X-CSE-ConnectionGUID: mt8a03klQcKYYlHAJX1y8w==
X-CSE-MsgGUID: mbAKw7JSQtyWTXGchV76Sg==
X-IronPort-AV: E=Sophos;i="6.21,141,1763424000"; 
   d="scan'208";a="8896287"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 15:21:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:3976]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.57:2525] with esmtp (Farcaster)
 id d2410b6d-c80b-4f7a-9f36-ab9e35d30e25; Thu, 11 Dec 2025 15:21:16 +0000 (UTC)
X-Farcaster-Flow-ID: d2410b6d-c80b-4f7a-9f36-ab9e35d30e25
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 15:21:16 +0000
Received: from b0be8375a521.amazon.com (10.37.244.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 11 Dec 2025 15:21:13 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <aleksandr.loktionov@intel.com>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <enjuk@amazon.com>,
	<horms@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<jacob.e.keller@intel.com>, <jedrzej.jagielski@intel.com>, <kohei@enjuk.org>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<przemyslaw.kitszel@intel.com>, <stefan.wegrzyn@intel.com>
Subject: Re: RE: [Intel-wired-lan] [PATCH iwl-net v2 2/2] ixgbe: don't initialize aci lock in ixgbe_recovery_probe()
Date: Fri, 12 Dec 2025 00:20:58 +0900
Message-ID: <20251211152105.96440-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <IA3PR11MB89864C5819FCA7B7E8A06DEFE5A1A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB89864C5819FCA7B7E8A06DEFE5A1A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, 11 Dec 2025 10:12:19 +0000, Loktionov, Aleksandr wrote:

>> Subject: [Intel-wired-lan] [PATCH iwl-net v2 2/2] ixgbe: don't
>> initialize aci lock in ixgbe_recovery_probe()
>> 
>> hw->aci.lock is already initialized in ixgbe_sw_init(), so
>> ixgbe_recovery_probe() doesn't need to initialize the lock. This
>You claim that ixgbe_sw_init() initializes hw->aci.lock but don't provide evidence(s).
>Can you?

Hi Alex, thank you for reviewing!

Yeah, I claim that because currently ixgbe_recovery_probe() is only
called from ixgbe_probe(), and this is called after ixgbe_sw_init().
Also I don't expect ixgbe_recovery_probe() would be called from other
contexts in the future.

We confirmed the that double initialization would occur in the
context[1], but are there any recommended solutions we can adopt?

I understand that double initialization doesn't always introduce
realistic issue because it would be problematic only when reinialization
is done while the lock is held, but it's a fact that actually
unnecessary initialization is done in ixgbe_recovery_probe().

I believe this change would be right, but maybe we should ask Jedrzej
for the intention of mutex_init() in ixgbe_recovery_probe(), and
possibility that ixgbe_recovery_probe() would be called from any other
contexts.

[1] https://lore.kernel.org/all/b5787c94-2ad0-4519-9cdb-5e82acfebe05@intel.com/

