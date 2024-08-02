Return-Path: <netdev+bounces-115167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935F0945540
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E04F286421
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F03C5223;
	Fri,  2 Aug 2024 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v0MBdjo9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9C33FD;
	Fri,  2 Aug 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558072; cv=none; b=iR2WhWOpjSN8pBLopNcbMcFbnbe0we/kLBcSqrG4WYhHu6+6KH9gmGT0j8rcTqju3xjg2Qt/IjwYiofQJ6FnObeuFLpjOLsss863ff76i/Zy3N2pj4JbzT7mA5El5c1ixmOUQelm+HYXNq93iLuJtWjRh4vBDhXrGDBGhrcIBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558072; c=relaxed/simple;
	bh=MsbrQyIGSikh7XBnI6DqfX7hVfeG33KwViqZGNJa5h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fABdXt9XxLOatkzINxG95HWr0fLJOLPCipSaZjz4Ehc2M58x+yFJcT39ypPyVDyUtc+NIynJ22aG2WIwcRu7zBbxTRh4rbnwVRvezyOvLqhCbtB9qkAjmLwj+jvHWQJfFdZyaDJ4VdCQDvn0/QEWiUBK9Mmxs9PMxghbXyk6TYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=v0MBdjo9; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722558069; x=1754094069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kJUu/tdhQcLdOpUFgiOjROMa8uFVLpgASD2SwjEAVZo=;
  b=v0MBdjo9j5N6cOKjiU+smVXDFtz21kQmhZIRNRL71o/G+lV8KV/haii0
   XfZlusoDuXoGv6y8QXybkOJtdC1mI8Bz+RK6P0BA8sRBcN3dpA43890H5
   NmW8lohrms1zZoLuN7bj1SMKq/A49nLKVpXBZp3RRFtS2Y+scW37P/cYQ
   A=;
X-IronPort-AV: E=Sophos;i="6.09,256,1716249600"; 
   d="scan'208";a="747148812"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 00:20:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:60468]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.75:2525] with esmtp (Farcaster)
 id 4a0ce127-70ca-4fda-8d6b-d31fc9baa09b; Fri, 2 Aug 2024 00:20:44 +0000 (UTC)
X-Farcaster-Flow-ID: 4a0ce127-70ca-4fda-8d6b-d31fc9baa09b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 2 Aug 2024 00:20:43 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 2 Aug 2024 00:20:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dmantipov@yandex.ru>
CC: <gustavo@embeddedor.com>, <kees@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-hardening@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3] net: core: annotate socks of struct sock_reuseport with __counted_by
Date: Thu, 1 Aug 2024 17:20:31 -0700
Message-ID: <20240802002031.78111-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240801142311.42837-1-dmantipov@yandex.ru>
References: <20240801142311.42837-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dmitry Antipov <dmantipov@yandex.ru>
Date: Thu,  1 Aug 2024 17:23:11 +0300
> According to '__reuseport_alloc()', annotate flexible array member
> 'sock' of 'struct sock_reuseport' with '__counted_by()' and use
> convenient 'struct_size()' to simplify the math used in 'kzalloc()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

