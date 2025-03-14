Return-Path: <netdev+bounces-174967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DA2A61B11
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 808D17A65A4
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ED02046BB;
	Fri, 14 Mar 2025 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tn9zZW5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065981EA7C9;
	Fri, 14 Mar 2025 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981997; cv=none; b=nHbgqT4NZfeZadbm6ibYSvwoGoh39ommBIaKnwDWHEXrujsW/sSNSvtzBT7ZskCxej1BCFBIimfa2EuV10kY8nMxb0sRaWtVs7OA8+o3A5xJugB2MVtz5IcmX1meIJWCa9D/h4FUTfU3jThksWIqFyUKi4/cUcrZ9tTAcyNfbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981997; c=relaxed/simple;
	bh=gM8WfVyBII6/j2HL+ucdv6nq4ooU7ZXCHfPJvRUhjAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPDF4yaELg6t2njvuDmbXRt1u059TUNA4imLRp/kq3j7tCLpQFO/+fuxnOMoINGc7tXiqk6O+F1XsObx8aU+u/0G1DAagFk6qYQCFF2s1p8ALa5ZNI8Fv65Zo/u5kTsACz66Xp1IKa3DtSvFWU8kEiyZW9tjbHp4sezEW35PRh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tn9zZW5+; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741981992; x=1773517992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ct5qp0A+ZizoTLQyrd/scXocaq2Cjowfc7prgTEJsnc=;
  b=Tn9zZW5+Yu4ECCEAztBlw+IDVKzUtvfCdtgfkHVora/xLs+mp4o9QMZ2
   OAXp+Ap7AUL48BuTDyXORIBffMj0Q/u82J5kOjcp3uineFYM2eaNpG8dn
   2w/PvISWpMZ5GLpkzRARIFj02CKZXl98TLL7frvVDVPdD+BBQHq3+hBmH
   U=;
X-IronPort-AV: E=Sophos;i="6.14,246,1736812800"; 
   d="scan'208";a="178745445"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 19:53:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:54232]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.127:2525] with esmtp (Farcaster)
 id 02162e03-ab2f-4946-b016-fed5ef51015b; Fri, 14 Mar 2025 19:53:10 +0000 (UTC)
X-Farcaster-Flow-ID: 02162e03-ab2f-4946-b016-fed5ef51015b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 19:53:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.227.109) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 19:53:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <aleksandr.mikhalitsyn@canonical.com>
CC: <alexander@mihalicyn.com>, <annaemesenyiri@gmail.com>,
	<edumazet@google.com>, <kerneljasonxing@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>, <willemb@google.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next] tools headers: Sync uapi/asm-generic/socket.h with the kernel sources
Date: Fri, 14 Mar 2025 12:52:40 -0700
Message-ID: <20250314195257.34854-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Sun,  9 Mar 2025 13:15:24 +0100
> This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.
> 
> Accidentally found while working on another patchset.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
> Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

It seems the patch is marked as Changes Requested on patchwork.
Also, I think this is net.git material than net-next.

So, could you repost to net.git ?

Thanks!



