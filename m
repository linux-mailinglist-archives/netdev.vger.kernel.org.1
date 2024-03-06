Return-Path: <netdev+bounces-78110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4753187419B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 21:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789271C20FDF
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9DF1757A;
	Wed,  6 Mar 2024 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wF0iZPPX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C117551
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709758783; cv=none; b=JaztrxS0YYmF7Q+CV5My41t0kDwDPDTZGWPeo2u3/None8L7Zc2EGPtJZgrJtRByaMxuXohSMPxS519CfvWuQhdxO2suqf3r8TRS9h/mAlTHtTGi15y/U14JYTUut817PPje92rH/jBdgN5e68nsz/XYzr5rjWP5jwKkmCF1HF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709758783; c=relaxed/simple;
	bh=VmDL2q8mRra5RqNhQk26EpO9ghC9iQlUegGh+nJI+UA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0WTmYBOOdX2pryOrivLxlDTmX3GsD+AT5uMJTZh1hctn4+NrULvTBNp6uf/WJitNzWFahYSVDefEW+d8VURP8KcBM97T2PChzRXxkxSG7UJn9Cj1nwv6XjRmLcJJyWMbdJgC76bVWi8fwmXFndRiXB9dkr7XdR4h/5YxYFQAbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=wF0iZPPX; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709758782; x=1741294782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VwLaCQrUK6eWTFDOUrS0YB8VGFnzn8/ts1CrITT24ss=;
  b=wF0iZPPX5M/GI46EmWWsqzREDEGwzd0WuqbHaGcJsc/d3MeScLO1N8va
   gr1U9tUla7XK+ngI3Qijx+aWWITadcl3lGsjW3jPqojOIpJPq54bG2YpT
   hoIv7ueGq6culvtm2HnVgaVmTmgFGhod0xFjGrL+Y9JqbSUZ46p6CUChm
   o=;
X-IronPort-AV: E=Sophos;i="6.06,209,1705363200"; 
   d="scan'208";a="189753578"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 20:59:39 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:11773]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.183:2525] with esmtp (Farcaster)
 id 934c7de6-0f71-4167-a2d0-2f0d2c668f22; Wed, 6 Mar 2024 20:59:38 +0000 (UTC)
X-Farcaster-Flow-ID: 934c7de6-0f71-4167-a2d0-2f0d2c668f22
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 6 Mar 2024 20:59:33 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 6 Mar 2024 20:59:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 net-next 12/15] af_unix: Assign a unique index to SCC.
Date: Wed, 6 Mar 2024 12:59:23 -0800
Message-ID: <20240306205923.17190-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0bddd6e22f91e0d629b41a84c9e2eb56e3260176.camel@redhat.com>
References: <0bddd6e22f91e0d629b41a84c9e2eb56e3260176.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 05 Mar 2024 09:44:00 +0100
> On Thu, 2024-02-29 at 18:22 -0800, Kuniyuki Iwashima wrote:
> > The definition of the lowlink in Tarjan's algorithm is the
> > smallest index of a vertex that is reachable with at most one
> > back-edge in SCC.  This is not useful for a cross-edge.
> > 
> > If we start traversing from A in the following graph, the final
> > lowlink of D is 3.  The cross-edge here is one between D and C.
> > 
> >   A -> B -> D   D = (4, 3)  (index, lowlink)
> >   ^    |    |   C = (3, 1)
> >   |    V    |   B = (2, 1)
> >   `--- C <--'   A = (1, 1)
> > 
> > This is because the lowlink of D is updated with the index of C.
> > 
> > In the following patch, we detect a dead SCC by checking two
> > conditions for each vertex.
> > 
> >   1) vertex has no edge directed to another SCC (no bridge)
> >   2) vertex's out_degree is the same as the refcount of its file
> > 
> > If 1) is false, there is a receiver of all fds of the SCC and
> > its ancestor SCC.
> > 
> > To evaluate 1), we need to assign a unique index to each SCC and
> > assign it to all vertices in the SCC.
> > 
> > This patch changes the lowlink update logic for cross-edge so
> > that in the example above, the lowlink of D is updated with the
> > lowlink of C.
> > 
> >   A -> B -> D   D = (4, 1)  (index, lowlink)
> >   ^    |    |   C = (3, 1)
> >   |    V    |   B = (2, 1)
> >   `--- C <--'   A = (1, 1)
> > 
> > Then, all vertices in the same SCC have the same lowlink, and we
> > can quickly find the bridge connecting to different SCC if exists.
> > 
> > However, it is no longer called lowlink, so we rename it to
> > scc_index.  (It's sometimes called lowpoint.)
> 
> I'm wondering if there is any reference to this variation of Tarjan's
> algorithm you can point, to help understanding, future memory,
> reviewing.

I don't have any reference... perhaps we can add comment like
/* why ? git-blame me. */ or .rst file under Documentation/ about
why GC is needed, how GC works / what algorithm is used, etc.

When I was wondering the same thing, I googled and found someone
who had the same question, but there was no reference.

  https://stackoverflow.com/questions/23213993/what-is-the-lowelink-mean-of-tarjans-algorithm

There might be a text book but I couldn't find online resources.
Even wiki says it looks odd.

  > // The next line may look odd - but is correct.
  > // It says w.index not w.lowlink; that is deliberate and from the original paper
  > v.lowlink := min(v.lowlink, w.index)
  https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm

Regarding "lowpoint", I saw it in the wiki for the first time.

  > The lowlink is different from the lowpoint, which is the smallest
  > index reachable from v through any part of the graph.[1]: 156 [2]

In a pdf linked from the wiki:

  > lowpoint(v) = The lowest numbered vertex reachable from v using
  > zero or more tree edges followed by at most one back or cross edge.
  https://www.cs.cmu.edu/~15451-f18/lectures/lec19-DFS-strong-components.pdf

But I've just found that the original paper used LOWPT, which
is called lowlink now... :S

  > LOWPT(v) :=min(LOWPT(v) ,NUMBER(w)) ;
  https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=4569669

