Return-Path: <netdev+bounces-173814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4887FA5BD76
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88FE21720F2
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65A32343CF;
	Tue, 11 Mar 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL2Mwe7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26DE22FAC3
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688117; cv=none; b=hSCVt5RWWfzVVo5/xrnbjzocZCatdTZLuqDx3G+kyXbEviL9Vt+4ZwOozPGsuEk6CQJtSytZFoOrDRLXSCNlGFsSr39eEJaA6KJd/Lu9T0fCJI3FhUbsFKfyjcYuaNKHjm9SXQbRENOfxr+ngLngIZa/AgIzIgeCQGwpftdMZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688117; c=relaxed/simple;
	bh=HZwSYm11VBDcul3japy1DOyUxDTxiwNTfktik/jhMIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTMhhqmuxQMT4K2pLwFmxCQKVD8U0i/AFFPoH2lQO8pbeYTAC/rl/156UxQbnIQbDzeWNnKnY86jCqDoRM8Nc1mZHZaLCGDdTD02YI/zm76mjtNTUCWgmDq9yI/Y/ON47KWO+XcpGn2y94rSLhmTyPTYLIAbFzCdqBLPFyncZe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL2Mwe7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89442C4CEE9;
	Tue, 11 Mar 2025 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741688117;
	bh=HZwSYm11VBDcul3japy1DOyUxDTxiwNTfktik/jhMIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mL2Mwe7diSVX/KfxxyWAGfowSVtU7UJ6J1r7/WhbG69WnnARMJhtSAERDBajslM4+
	 cdoknatsScGuCHy//1gO9VkhQg23Kw+EYntjw6Ieo+bfAbCFyJ5JT42DFAtRMIqwjS
	 +aXyjOyK01vljYkRLoAfbk5pAAHyFk0Lw6fHrigLGG4ci9tQq1cit76i0vyOpE5JAs
	 lT7ht7yBZgPmVlhWUJtYzHhTJGTSQHTx2oNesUYOt6kd6YL9qEaIZTlwKU4SeVx9YU
	 G3X5OH2elPJLmgFgIueb/CLFZmJOrr/CeUla7DIEsvBsg2p3fW2Y07NAY2NANZj1/B
	 z/pbkTq5uO6rA==
Date: Tue, 11 Mar 2025 11:15:11 +0100
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, Hannes Reinecke
 <hare@suse.de>
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
Message-ID: <20250311111511.2531b260@kernel.org>
In-Reply-To: <20250310143544.1216127-1-willy@infradead.org>
References: <20250310143544.1216127-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 14:35:24 +0000 Matthew Wilcox (Oracle) wrote:
> Long-term, networking needs to stop taking a refcount on the pages that
> it uses and rely on the caller to hold whatever references are necessary
> to make the memory stable. 

TBH I'm not clear on who is going to fix this.
IIRC we already told NVMe people that sending slab memory over sendpage 
is not well supported. Plus the bug is in BPF integration, judging by
the stack traces (skmsg is a BPF thing). Joy.

