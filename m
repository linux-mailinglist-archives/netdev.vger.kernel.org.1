Return-Path: <netdev+bounces-131268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2435098DEFC
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5302875B7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DACE1D0F58;
	Wed,  2 Oct 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LkNpzt8n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD641D0E35;
	Wed,  2 Oct 2024 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882760; cv=none; b=aYTMfVmoXkkqajo9VD7uLF9n096gK6tDta2xpVfCbTVwxnvqUINpoHlYuGg7fJRnW/8kyR8S/jSl2EWyVD0EIPD3P+yOyfuSVvWE0pngvgefpoqC0hpNiF3XSujDN8E+yR1zLtdb//Ib+UPJjxP7feDfJJt/VZTgMMruLmD9GoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882760; c=relaxed/simple;
	bh=lKhyf48RMLpspZ3ymS6szfFA1piNDk8WumAeRcg/MuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMNGhbLyShLeHvQdHR9iQABR6dEe0eMpsEMl6fXYG9tM8JBi7bNRGNcnUYJPT4tcz+CJSqtVIW8BnAqcLJFeVc4LN/GELyOBIfAo4XPyKQH/2TzXRzSgibFR8tHk1g5hNvVfy346kAF2ILNCkji6fFgcig5bmpEe/ElNxkP0ZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LkNpzt8n; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727882759; x=1759418759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yz3Wsj7pxR718E2/bctzq5t+/Vno2EGn0C6LCYN4jtw=;
  b=LkNpzt8nVC5i2Eaky0++AlQbVSWBlZnIoYMp9iuSY6I2aHrDWEURbNG2
   w6eCrMiESDtz7M2CfC7cohCIlPKRBzo3sgzK/fB3CjRYKpk98LtxcOsij
   nE4gpmownESby9VLhAQ+clmtEqZRDoE14jggcILCRHDGMNlqM2UYgTJqw
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,172,1725321600"; 
   d="scan'208";a="663149872"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 15:25:53 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:2518]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.191:2525] with esmtp (Farcaster)
 id f7d7adac-7501-46c1-8368-2fe41a4590eb; Wed, 2 Oct 2024 15:25:51 +0000 (UTC)
X-Farcaster-Flow-ID: f7d7adac-7501-46c1-8368-2fe41a4590eb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 15:25:51 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 2 Oct 2024 15:25:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <akinobu.mita@gmail.com>, <aleksander.lobakin@intel.com>,
	<almasrymina@google.com>, <asml.silence@gmail.com>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <willemb@google.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] net: Implement fault injection forcing skb reallocation
Date: Wed, 2 Oct 2024 08:25:40 -0700
Message-ID: <20241002152540.51408-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241002113316.2527669-1-leitao@debian.org>
References: <20241002113316.2527669-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Wed,  2 Oct 2024 04:32:54 -0700
> diff --git a/net/Kconfig.debug b/net/Kconfig.debug
> index 5e3fffe707dd..f61935e028bd 100644
> --- a/net/Kconfig.debug
> +++ b/net/Kconfig.debug

This config is networking-specific, but I think lib/Kconfig.debug would be
a better fit as other fault injection configs are placed there together.

Now we need to enable fault injection first and go back to the net-specific
items in menuconfig.


> @@ -24,3 +24,14 @@ config DEBUG_NET
>  	help
>  	  Enable extra sanity checks in networking.
>  	  This is mostly used by fuzzers, but is safe to select.
> +
> +config FAIL_SKB_FORCE_REALLOC
> +	bool "Fault-injection capability forcing skb to reallocate"
> +	depends on FAULT_INJECTION && DEBUG_NET
> +	default n
> +	help
> +	  Provide fault-injection capability that forces the skb to be
> +	  reallocated, caughting possible invalid pointers to the skb.
> +
> +	  For more information, check
> +	  Documentation/dev-tools/fault-injection/fault-injection.rst

