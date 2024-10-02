Return-Path: <netdev+bounces-131243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDAA98D9CF
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5209528994E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3EF1D1E9B;
	Wed,  2 Oct 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="V1wjnvEq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2A1E52C
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878237; cv=none; b=iVXiEppdyiyj+1ImfW6V/xhMUT5nLEUBkWu1DaqBl5vj62TkTB/gytlWey+0sGOCBZ/8gAEuPfpJOc9TGRS1tBLxDOEo+/pmmIkAxfvJThgZmkGEz2x41VRPNwKc5g7nkzzWSDFj/ooMlRKL9ChfbT5eu7gUi8mZaEIEOT+u9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878237; c=relaxed/simple;
	bh=9qhrF6dWOZt3jTJdJ1xe2SB5GEpDGrJ6qbkp8tIIw6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjlxrSIvu9vNtb8ifEz7D0REZMbKJq8rciRi6sjYTHt97Uiw8QmwjLbrOQjtTKQ+Q7DJB3w5Q22Ag8n0YU1gwXUc4z8i1VTeOxk3p+/Xva3xSWNWwXd0dCh2FS0OEi6qzbl/U+wKxVoZ9jdipigieyXuo122hIWiWxaxZNqbcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=V1wjnvEq; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727878236; x=1759414236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=06vWo49lJU4SByqgIqPHwQstMjyfCgtKCOG5uo/+WaE=;
  b=V1wjnvEqzG+p4++nozEx05vYDvQNEYpegVHPKSKWARRzFcFqV2bbK9pk
   mt/3IBJP5mM2AQhKp8rtP93KoETNkUtTmWgov67+ZpoUoVrYB/0Mcq0QX
   EwyCRAVxI5r/wuaV/elyJXfh78VtA3kyPqhv0hTxUl6oPwEJBss8L6oZU
   o=;
X-IronPort-AV: E=Sophos;i="6.11,171,1725321600"; 
   d="scan'208";a="236175721"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:10:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:27755]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.107:2525] with esmtp (Farcaster)
 id dd50d66f-e96d-435b-971a-3bc4a29b722a; Wed, 2 Oct 2024 14:10:32 +0000 (UTC)
X-Farcaster-Flow-ID: dd50d66f-e96d-435b-971a-3bc4a29b722a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 14:10:31 +0000
Received: from 88665a182662.ant.amazon.com (10.94.36.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 2 Oct 2024 14:10:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <alexandre.ferrieux@gmail.com>, <alexandre.ferrieux@orange.com>,
	<netdev@vger.kernel.org>, <nicolas.dichtel@6wind.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2] ipv4: avoid quadratic behavior in FIB insertion of common address
Date: Wed, 2 Oct 2024 07:10:14 -0700
Message-ID: <20241002141014.43115-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iKg6J6=MZSLUy6odZSSddJvPyJRSz079pidDxDa1Yu-Uw@mail.gmail.com>
References: <CANn89iKg6J6=MZSLUy6odZSSddJvPyJRSz079pidDxDa1Yu-Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 10:38:11 +0200
> On Wed, Oct 2, 2024 at 1:14 AM Alexandre Ferrieux
> <alexandre.ferrieux@gmail.com> wrote:
> >
> > Mix netns into all IPv4 FIB hashes to avoid massive collision when
> > inserting the same address in many netns.
> >
> > Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> > ---
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> I guess we will have to use per-netns hash tables soon anyway.

Yes, it's on my stash :)

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

