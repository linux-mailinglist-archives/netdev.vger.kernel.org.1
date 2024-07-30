Return-Path: <netdev+bounces-114282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89AC94204B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 21:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32951C23618
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 19:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8FF18A6A3;
	Tue, 30 Jul 2024 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PmvF/gXw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D91AA3C5;
	Tue, 30 Jul 2024 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366397; cv=none; b=Nkk8riUiGZW4XWW1QYKw0OhYkpR0V1ZxnNKvYfEm/X5DR57e2H/RRorDs2zK8it81n+8VNAWLyiudiyTti0maAWz2yS+AyoYBX4Qc/vpH4BwKEm7f8R76rcvhgvtAv865xWwzFPbx5lrFMzZB5xfXIe8D4bXEfOyNg12Q4gFOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366397; c=relaxed/simple;
	bh=otPqEQYFLD8H3akyUR9O8rU5UGmkX1M2I3WCn5i/vic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1SrNz7UC6XLTzxjLRssJrGzy8yJFEqOe1tADx4yO+eQnj8HLe+CiJSj+c14aaL8uKc88YCE6qFbPOsy0F5coDAsJmcsyXUOQcZPs2fHR/nD78TB92gOIo1Mx4Fm9VlAfwqQ+MICBkfoH7203VL26qNjveFi90mOae+IUIpTQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PmvF/gXw; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722366396; x=1753902396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NVf6enMgAn0nRp15Rba4pCbZQnD5Nx0jm9+QNNSc7gI=;
  b=PmvF/gXwcorseZIPLbDsbAyh/0mWe6zLcPkOrg1UwF8BnWyLIroAkYzW
   87xMmQDeF7QQ9hX7C3j0m6UO2t4x4AygF5RZTPqHK8oPwIc6RTIu0h4wL
   Iuqe2fIX/kwpngNRZwSU1Do4PgcYK6gSUsTeTDRYUiiHwqJZzY6EFh4u0
   Y=;
X-IronPort-AV: E=Sophos;i="6.09,248,1716249600"; 
   d="scan'208";a="746459685"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 19:06:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:20946]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.198:2525] with esmtp (Farcaster)
 id b863f0b2-9293-430f-a8eb-88decde807f3; Tue, 30 Jul 2024 19:06:29 +0000 (UTC)
X-Farcaster-Flow-ID: b863f0b2-9293-430f-a8eb-88decde807f3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 19:06:29 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 19:06:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dmantipov@yandex.ru>
CC: <kees@kernel.org>, <linux-hardening@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH] net: core: use __counted_by for trailing VLA of struct sock_reuseport
Date: Tue, 30 Jul 2024 12:06:16 -0700
Message-ID: <20240730190616.84555-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240730160449.368698-1-dmantipov@yandex.ru>
References: <20240730160449.368698-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dmitry Antipov <dmantipov@yandex.ru>
Date: Tue, 30 Jul 2024 19:04:49 +0300
> According to '__reuseport_alloc()', annotate trailing VLA 'sock' of
> 'struct sock_reuseport' with '__counted_by()' and use convenient
> 'struct_size()' to simplify the math used in 'kzalloc()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

