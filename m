Return-Path: <netdev+bounces-28654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614CD78026F
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 02:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB5B28226B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 00:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCE8360;
	Fri, 18 Aug 2023 00:08:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E527363
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 00:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC33C433C8;
	Fri, 18 Aug 2023 00:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692317329;
	bh=sEjLL4lEj6Q3EBKmWjUxUPCVA8xsnPN1NIRn5fYN7Yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=etvKyqFPWZ6/MkmgXKLPwbTF1NtXvAzEooyjjFG+Ccuxx/EVLqDWEuhPXcRQwcpjQ
	 HOJnRBZgBTtSeukBu2DaZnI1Jin7bfyXKhiO7MCbATniVeFXWDR1aoMh22WCQw7n3F
	 cyv97Zujp1lKQIjynMBLVBtg2XB44Bmg9X0YUmlSRs0LHvtqgzeKWQgK6jtZP8FVYf
	 iah/M3VDn1uEwelv0bVleOoDQqSCH+agxVF7XIZ5qvweRrxqgZ4c4n7wXCi3Qr4dRs
	 Le25YnMNcpuSwJAEmCGa6J+BPpsPA6ytzA9ph17Pud/lusJAGjIdbL5VPYBIhDAQat
	 iXjbooJYULucQ==
Date: Thu, 17 Aug 2023 17:08:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 aleksander.lobakin@intel.com, linyunsheng@huawei.com
Subject: Re: [RFC net-next 04/13] net: page_pool: id the page pools
Message-ID: <20230817170848.4f96f9c5@kernel.org>
In-Reply-To: <CAHS8izOu=DxeRdD7Gdt-N2qvH_Nnwpcem1KkNgjOLeWzHZ_5JQ@mail.gmail.com>
References: <20230816234303.3786178-1-kuba@kernel.org>
	<20230816234303.3786178-5-kuba@kernel.org>
	<CAHS8izOu=DxeRdD7Gdt-N2qvH_Nnwpcem1KkNgjOLeWzHZ_5JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 14:56:01 -0700 Mina Almasry wrote:
> Sorry maybe I'm missing something, but it's a bit curious to me that
> this ID is needed.

Right.. now I realize that I haven't explained the queue side.

I expect a similar API will be added to dump queue info, and then page
pool ID will be added to the queue object, to link which queue is being
fed from which page pool. I guess I should have said that in the cover
letter...

> An rx queue can only ever have 1 page-pool
> associated with it at a time, right? Could you instead add a pointer
> to the page_pool into 'struct netdev_rx_queue', 

100% my intention, which is why I moved the location of that struct
recently :)

> and then page-pool can be referred to by the netdev id & the rx-queue
> number? 

And use/type (headers vs payloads). And then nothing stops a driver from
using one page pool for multiple queues of the same type within a NAPI.
And then the page pools can die and linger (see patch 11).

> Wouldn't that make the implementation much simpler? I also believe
> the userspace refers to the rx-queue by its index number for the
> ethtool APIs like adding flow steering rules, so extending that to
> here maybe makes sense.

