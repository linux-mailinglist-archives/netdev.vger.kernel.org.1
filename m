Return-Path: <netdev+bounces-56067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C280DB57
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876AC1F21A62
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245AE5380E;
	Mon, 11 Dec 2023 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL0fmRjE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DAB51036
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A780C433C8;
	Mon, 11 Dec 2023 20:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702325650;
	bh=1Xtip+7vpslDMt+EAlOYykStn1lMrjnsm0PG/aFT3lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FL0fmRjEtdFc6xX6XIthj3lBq4lv0BgbGAUj8ztWy+gxPy4ndQUS7sAu1ADc1TN/O
	 ME1ZTTSjRU980syPqJFHPi9bqDGcH8Xn3C00RvFfytaj8f0Q6MlX2S9CRB4eJsQBHv
	 2GCAQRmRmspQQ1KJNQMq1zjkEksjWIgiTvBjWHu4mtPUaymmSWcjLMtV/IWNqtnghY
	 mp7FCXXxukF9UCo88CRuGMjj7tVLIFSiqbi2U3ZzuZTQGafQiTRusVUhzIKeYVYlfj
	 nuU85A/6OY6enMRJDty/w8eoMIrJuL5Xb7YQnDOW/fVOYLNMIe+KThLzWHAqqm4mNU
	 ECjfuEu1UmyvQ==
Date: Mon, 11 Dec 2023 12:14:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Liang Chen <liangchen.linux@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org,
 jasowang@redhat.com, almasrymina@google.com
Subject: Re: [PATCH net-next v8 4/4] skbuff: Optimization of SKB coalescing
 for page pool
Message-ID: <20231211121409.5cfaebd5@kernel.org>
In-Reply-To: <CAC_iWjJX3ixPevJAVpszx7nVMb99EtmEeeQcoqxd0GWocK0zkw@mail.gmail.com>
References: <20231211035243.15774-1-liangchen.linux@gmail.com>
	<20231211035243.15774-5-liangchen.linux@gmail.com>
	<CAC_iWjJX3ixPevJAVpszx7nVMb99EtmEeeQcoqxd0GWocK0zkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:46:55 +0200 Ilias Apalodimas wrote:
> As I said in the past the patch look correct. I don't like the fact
> that more pp internals creep into the default network stack, but
> perhaps this is fine with the bigger adoption?
> Jakub any thoughts/objections?

Now that you asked... the helper does seem to be in sort of 
a in-between state of being skb specific.

What worries me is that this:

+/**
+ * skb_pp_frag_ref() - Increase fragment reference count of a page
+ * @page:	page of the fragment on which to increase a reference
+ *
+ * Increase fragment reference count (pp_ref_count) on a page, but if it is
+ * not a page pool page, fallback to increase a reference(_refcount) on a
+ * normal page.
+ */
+static void skb_pp_frag_ref(struct page *page)
+{
+	struct page *head_page = compound_head(page);
+
+	if (likely(is_pp_page(head_page)))
+		page_pool_ref_page(head_page);
+	else
+		page_ref_inc(head_page);
+}

doesn't even document that the caller must make sure that the skb
which owns this page is marked for pp recycling. The caller added
by this patch does that, but we should indicate somewhere that doing
skb_pp_frag_ref() for frag in a non-pp-recycling skb is not correct.

We can either lean in the direction of making it less skb specific,
put the code in page_pool.c / helpers.h and make it clear that the
caller has to be careful.
Or we make it more skb specific, take a skb pointer as arg, and also
look at its recycling marking..
or just improve the kdoc.

