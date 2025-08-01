Return-Path: <netdev+bounces-211398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09309B18887
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 23:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE60567BF2
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AA5214A91;
	Fri,  1 Aug 2025 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a12Th1H9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F612101B3
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082307; cv=none; b=NWf7ri7kCTS9ws6PcfqGGWYWQUoCy3Oi7JpfPxxBGob2cc9AOmHPCkflpdRepIhxyY7jj3jAzIl2AMvrxzNbnHdV+aEnH6IwKZWf7lrzCyWzffRdnEMghvAxQX9oQaLoe5gkwiwI4JBdJMfKVggyrArM+Hx/Magj3AFUCAYXH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082307; c=relaxed/simple;
	bh=JZoyAST6+OVTTphG6ee2gzu1er796wvSDXhYeGpIXYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjfTEvIXDvrh80p3H8FGy2OSMOJAainMn2v+I6d6JDGfiy7R+mJqgOL6FQMlHWtrckJzmhMllz7SJOrnNsHZSVvACkaPs6z2BF2xrTTQKtH1dHQPH9L+jpQm/kdWFbO9gzel+3a7LLppfDg0/yAbZrmPcTLj4OUNmh5pWk2Uujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a12Th1H9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1571C4CEE7;
	Fri,  1 Aug 2025 21:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754082307;
	bh=JZoyAST6+OVTTphG6ee2gzu1er796wvSDXhYeGpIXYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a12Th1H9SU84ANeXE6RWjoDNGIdzwPxBkj2yUU4qCCj+vWGQn6wxlwFN1gs3RoPxg
	 WEYyV0yAkIeNp+fLhr2QaIEOAm0tpBd4DXHncyDQS6yRva6OS0AJFV1BWON7EBB5cF
	 eanxdoGtSDU8/2idCWxTgMTr5YWmLn/je759+TGll0EFIKijXWlZWAkkRHwj7nrXAz
	 2E/u/jKHY88fOkpV0oLp6DM3nCAFNLeW8jUGGB1f53Jz/+B8T0fPcIcM+NDF/Gb9qD
	 xKntdNmB87bV1LaPPL4DayphdxXgxTiq0nkrrsSPRhm5H5oC05YjJ32pX0KalYmFmt
	 oRMycu3lcHvHA==
Date: Fri, 1 Aug 2025 14:05:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, David Wei
 <dw@davidwei.uk>, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, almasrymina@google.com,
 sdf@fomichev.me
Subject: Re: [PATCH net] net: page_pool: allow enabling recycling late, fix
 false positive warning
Message-ID: <20250801140506.5b3e7213@kernel.org>
In-Reply-To: <aI0prRzAJkEXdkEa@mini-arch>
References: <20250801173011.2454447-1-kuba@kernel.org>
	<aI0prRzAJkEXdkEa@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Aug 2025 13:55:09 -0700 Stanislav Fomichev wrote:
> > +static void bnxt_enable_rx_page_pool(struct bnxt_rx_ring_info *rxr)
> > +{
> > +	page_pool_enable_direct_recycling(rxr->head_pool, &rxr->bnapi->napi);
> > +	page_pool_enable_direct_recycling(rxr->page_pool, &rxr->bnapi->napi);  
> 
> We do bnxt_separate_head_pool check for the disable_direct_recycling
> of head_pool. Is it safe to skip the check here because we always allocate two
> pps from queue_mgmt callbacks? (not clear for me from a quick glance at
> bnxt_alloc_rx_page_pool)

It's safe (I hope) because the helper is duplicate-call-friendly:

+void page_pool_enable_direct_recycling(struct page_pool *pool,
+				       struct napi_struct *napi)
+{
+	if (READ_ONCE(pool->p.napi) == napi)   <<< right here
+		return;
+	WARN_ON_ONCE(!napi || pool->p.napi);
+
+	mutex_lock(&page_pools_lock);
+	WRITE_ONCE(pool->p.napi, napi);
+	mutex_unlock(&page_pools_lock);
+}

We already have a refcount in page pool, I'm planning to add
page_pool_get() in net-next and remove the

	if (bnxt_separate_head_pool)

before page_pool_destroy(), too.

