Return-Path: <netdev+bounces-75063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB33868088
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77F71C2035A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 19:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961A130E44;
	Mon, 26 Feb 2024 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FiGxXs0F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06CD12C815
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974479; cv=none; b=Gl5R0GSGTCvBAk6nDe6t6PmHofrcyw59tSSun4dGRdmUiL9NgrTBtjerYRnGZuktk4g6KD9Lf7b69wXqhuZ98uya42Y6szTj/VnvodlgG/MdpHhOz4C/VSbC7ZVBxYAhjQn6SOql1XoMGxZwrNt1Xp0/3yoaZmG2CW+gZrJh880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974479; c=relaxed/simple;
	bh=L8scKpuFDwoyP2sAc+awhMVtotMWditmGyjFRudQ0WI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNfNzy2MCttFlSi4mLugRwpkHcfRAPEpiZu/suGAjewR5eRl0lylV01LEbqRA8QvrM/K0q99k70q6ZdTy0AF0JCvTh4VAVm7wiVaJz960FGd7BhscoiCJnrMotUkSAunCPKJ6sB6FpRT4uy+ISGAvJxPzhjE+8JVwXmm7tv6VwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FiGxXs0F; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708974478; x=1740510478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EL+sALY9h1Ql9dmZzngXV3Y653/tFdFqvO1T0n2gSJs=;
  b=FiGxXs0FhK19BJdDl9usxdmwBVJ3h71rPYAfD1pnZ9cEPW2poDfcTfs8
   iG8331JyAzq2T/MFB0r2YoCt5DRHYud06KQWwbCAoP4znN8ClxNSeR3tM
   TPuLLwfVF9bTD3IM0Kf7Faeu5xGSWS4+lIEJhNPQ/9KTjsrYGgetVbMkl
   w=;
X-IronPort-AV: E=Sophos;i="6.06,186,1705363200"; 
   d="scan'208";a="389239343"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 19:07:55 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:60606]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.113:2525] with esmtp (Farcaster)
 id 63f26ee4-78cd-4674-a983-5359ebab3dff; Mon, 26 Feb 2024 19:07:54 +0000 (UTC)
X-Farcaster-Flow-ID: 63f26ee4-78cd-4674-a983-5359ebab3dff
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 19:07:53 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 26 Feb 2024 19:07:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 05/14] af_unix: Detect Strongly Connected Components.
Date: Mon, 26 Feb 2024 11:07:41 -0800
Message-ID: <20240226190741.66233-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240224163430.05595eb0@kernel.org>
References: <20240224163430.05595eb0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Sat, 24 Feb 2024 16:34:30 -0800
> On Fri, 23 Feb 2024 13:39:54 -0800 Kuniyuki Iwashima wrote:
> > +	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
> > +		struct unix_vertex *next_vertex = edge->successor->vertex;
> > +
> > +		if (!next_vertex)
> > +			continue;
> > +
> > +		if (next_vertex->index == UNIX_VERTEX_INDEX_UNVISITED) {
> > +			list_add(&edge->stack_entry, &edge_stack);
> > +
> > +			vertex = next_vertex;
> > +			goto next_vertex;
> > +prev_vertex:
> > +			next_vertex = vertex;
> > +
> > +			edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
> > +			list_del_init(&edge->stack_entry);
> > +
> > +			vertex = edge->predecessor->vertex;
> > +
> > +			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
> > +		} else if (edge->successor->vertex->on_stack) {
> > +			vertex->lowlink = min(vertex->lowlink, next_vertex->index);
> > +		}
> > +	}
> > +
> > +	if (vertex->index == vertex->lowlink) {
> > +		struct list_head scc;
> > +
> > +		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
> > +
> > +		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
> > +			list_move_tail(&vertex->entry, &unix_visited_vertices);
> > +
> > +			vertex->on_stack = false;
> > +		}
> > +
> > +		list_del(&scc);
> > +	}
> > +
> > +	if (!list_empty(&edge_stack))
> > +		goto prev_vertex;
> 
> coccicheck says:
> 
> net/unix/garbage.c:406:17-23: ERROR: invalid reference to the index variable of the iterator on line 425
> 
> this code looks way to complicated to untangle on a quick weekend scan,
> so please LMK if this is a false positive, I'll hide the patches from
> patchwork for now ;)

Yeah, I think it's false positive :)

The code above implements recursion withtout nesting call stack
and instead uses goto jump and restores the previous in-loop
variables there.

  __unix_walk_scc(struct unix_vertex *vertex)
  {
    ...
    list_for_each_entry(edge, &vertex->edges, vertex_entry) {
      if (next_vertex->index == UNIX_VERTEX_INDEX_UNVISITED) {
        __unix_walk_scc(next_vertex);

        ^-- This is rewritten with goto next_vertex & prev_vertex.

        vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
      } else {
        vertex->lowlink = min(vertex->lowlink, next_vertex->index);
      }
    }
    ...

Here's the original recursive pseudocode.
https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm

