Return-Path: <netdev+bounces-185645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E20A9B31F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1346C3A3C1E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBF927CB2E;
	Thu, 24 Apr 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="F/CtYs45"
X-Original-To: netdev@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADA1B412B;
	Thu, 24 Apr 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510141; cv=none; b=f/awo6ETzl3fWI70nKmXUUvRjeY2vOmSkeHgsj40I0oN9FJPw2ZkYyMa0FZory+Yg58LlBnEMJ+QuK2RwrgA2fect8T3PlvyeRhAYO5GctXOjT9Izg4nWi2oumqs/pew9jj53kITQ5UGyOeHdcbArYNy4vyA9cNiBqjhllzI9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510141; c=relaxed/simple;
	bh=12yUJ4grL7NgIfQ2rnFlOyiAYUoctTlGrYJZvROSXww=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B/M7HebBV3IJn9d7jy/7uMGX/wEVS2FZZQuHe/w7BMi9tl2vfQ0kjPdez7jo459gF9OwDbo1S5T/vhDhHjV0UZCxDGEKfaVLv13n7c9RDwPwJjDMamqihW9WOD+B2o83r6cfXRcFDLNv8hXFYWo6+ebR2dpR2HjMkM6qgNI/ZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=F/CtYs45; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1745509804;
	bh=12yUJ4grL7NgIfQ2rnFlOyiAYUoctTlGrYJZvROSXww=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=F/CtYs459Oy8O1pm+AJw1dxg5AUJXX/ejVmgPfmvAbRpvnOBv9D3Zwpj0PfgirXc9
	 5NbOrPXDuPWLVmm33Bu7Rn/Ldxgs19izIxCzk4YyfgmFkL48N9DDpBfOEuzl9ZBTyp
	 vG3Pihdhg6mu2+pv3kyslPNQ6rtbVlpQWHrX+DzQ=
Received: by gentwo.org (Postfix, from userid 1003)
	id 77B364025D; Thu, 24 Apr 2025 08:50:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 75BE5401F6;
	Thu, 24 Apr 2025 08:50:04 -0700 (PDT)
Date: Thu, 24 Apr 2025 08:50:04 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Harry Yoo <harry.yoo@oracle.com>
cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, 
    Tejun Heo <tj@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
    Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
    Jiri Pirko <jiri@resnulli.us>, Vlad Buslov <vladbu@nvidia.com>, 
    Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>, 
    Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the percpu
 allocator scalability problem
In-Reply-To: <20250424080755.272925-1-harry.yoo@oracle.com>
Message-ID: <80208a6c-ec42-6260-5f6f-b3c5c2788fcd@gentwo.org>
References: <20250424080755.272925-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-869478563-1745509804=:2657"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-869478563-1745509804=:2657
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 24 Apr 2025, Harry Yoo wrote:

> Consider mm_struct: it allocates two percpu regions (mm_cid and rss_stat),
> so each allocate–free cycle requires two expensive acquire/release on
> that mutex.

> We can mitigate this contention by retaining the percpu regions after
> the object is freed and releasing them only when the backing slab pages
> are freed.

Could you keep a cache of recently used per cpu regions so that you can
avoid frequent percpu allocation operation?

You could allocate larger percpu areas for a batch of them and
then assign as needed.

--8323329-869478563-1745509804=:2657--

