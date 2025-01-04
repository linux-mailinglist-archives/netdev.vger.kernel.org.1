Return-Path: <netdev+bounces-155126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70B5A012C4
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 07:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13153A4629
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 06:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC3E14F125;
	Sat,  4 Jan 2025 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pxyHU21V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3D114D2AC
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 06:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735972158; cv=none; b=JUNvDNHK7pplANZOEdIEfeHEXNmZxLo1qzBs5qE7y/hJSRWkCo0ygP+fkkESxD9rL7W6Ysyh9OiMwf150g661zEbnnEIkD50BKoVj7JjS3dub4iz7ivBqf1pMP51YMORWrgq4f25Kj+LQxNpnS/l95bk+BgvpK2uFRYplgTQf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735972158; c=relaxed/simple;
	bh=aOyURRyhcWOGb5Fxjy7UOuAjJ0h3C08xLivl/PJMAGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wqk9zo6Oe8rSivCgiwGa2TMSGJol+Zd+u+1jlqpZFCZ/owP9RB+EqwXYuFOseHwjTquMJ/vVpyTvHA8v/fYrutCNaR2ZABdzrdl+xXKkEMgn02cC+U+fZKgjL83SVyJlFnN+xGlb7ziFwnEj3qW6rk7Osuk6k9B1zP51MuHHljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pxyHU21V; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735972157; x=1767508157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OGTJLjW/nD4B+SyryceeaUNFHmAZy2oT5V1cZjrmzS0=;
  b=pxyHU21Vi3kzB2CHkcPNDAAvhS+Toy3rQ7E8651ph+9YV7DN8O60RN82
   dho3J8+aStTaPtwhvqRIifVKgnvlZz+wIv2qx7S0dUtm/4Ew7NcC9c4Zd
   wdtDuBC8hGCm2m7kIqhj0Cus+i0BOSxqJsz2wTDC8U9fVke26ylMz18jf
   w=;
X-IronPort-AV: E=Sophos;i="6.12,288,1728950400"; 
   d="scan'208";a="161618138"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 06:29:15 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:32459]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.219:2525] with esmtp (Farcaster)
 id 7bafdb22-354e-4bca-80f4-a0139cbed5ea; Sat, 4 Jan 2025 06:29:14 +0000 (UTC)
X-Farcaster-Flow-ID: 7bafdb22-354e-4bca-80f4-a0139cbed5ea
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:29:14 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.9.250) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:29:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>, <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v2 net] ipvlan: Fix use-after-free in ipvlan_get_iflink().
Date: Sat, 4 Jan 2025 15:29:01 +0900
Message-ID: <20250104062901.35982-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250103080645.5129915b@kernel.org>
References: <20250103080645.5129915b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 3 Jan 2025 08:06:45 -0800
> On Fri, 3 Jan 2025 23:08:13 +0900 Kuniyuki Iwashima wrote:
> > +		if (dev->reg_state <= NETREG_UNREGISTERED)
> 
> s/UN//

Oops, will fix it, thanks!

