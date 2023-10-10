Return-Path: <netdev+bounces-39594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613D07BFFD5
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A6E1C20BA4
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B424C95;
	Tue, 10 Oct 2023 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mO6h1fac"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775B21364
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4181C433C8;
	Tue, 10 Oct 2023 14:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696949817;
	bh=t4UD2z8rKlfGoJs+bJB/tGBpc3MnXCf79Oj2FkiFxOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mO6h1facsM75UBJfDZ483aduGFwFwX6SmfAlOmrGIDPV+zb+hGweGd9Bqy/5i1NOE
	 n7ZH56YLbZbiOZVNTru5q8DWDIh4il8A69wWcCSwPN9XZgYYBo7JmA1ml8MBtKYa4v
	 6nd9vW7cmjtxu70epNIu6/aIma/SPKXJtLE2JDtHOUW00rMqhYlqqGHTgXjVsaSqzI
	 QphrxEFuHn6KS1KRZ3b/mnMSaHbElcZ49Q9TY0vKRyJ66lzHMRtN7N0NLtinqs88aU
	 68FRU/q4OVG8M3iDC3ONC8VaP6adtB0VAgjYui6uBeMQAelZzUevgKdP5SXump/OCc
	 Cbhu9DS9s2oYA==
Date: Tue, 10 Oct 2023 07:56:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <vadim.fedorenko@linux.dev>, <lkp@intel.com>,
 <horms@kernel.org>, Sean Tranchetti <quic_stranche@quicinc.com>
Subject: Re: [PATCH net-next v4] net: qualcomm: rmnet: Add side band flow
 control support
Message-ID: <20231010075655.2f8fbeb3@kernel.org>
In-Reply-To: <28518005-bb25-caed-1b12-bf12a3ded4bc@quicinc.com>
References: <20231006001614.1678782-1-quic_subashab@quicinc.com>
	<20231009194251.641e9134@kernel.org>
	<28518005-bb25-caed-1b12-bf12a3ded4bc@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Oct 2023 22:00:40 -0600 Subash Abhinov Kasiviswanathan (KS)
wrote:
> > I don't understand why you need driver specific commands to do this.
> > It should be easily achievable using existing TC qdisc infra.
> > What's the gap?  
> 
> tc doesn't allow userspace to manipulate the flow state (allow / 
> disallow traffic) on a specific queue. As I understand, the traffic 
> dequeued / queued / dropped on a specific queue of existing qdiscs are 
> controlled by the implementation of the qdisc itself.

I'm not sure what you mean. Qdiscs can form hierarchies.
You put mq first and then whatever child qdisc you want for individual
queues.

