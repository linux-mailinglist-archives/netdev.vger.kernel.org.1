Return-Path: <netdev+bounces-39635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94677C0350
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8479B281BBA
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36E5225C9;
	Tue, 10 Oct 2023 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5EnDBU4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80577225C6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A183FC433C8;
	Tue, 10 Oct 2023 18:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696962121;
	bh=gsgMih498v6fa2PRvVLUrxOZYf+dQQnX3FWP2cbDuZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E5EnDBU4zDp6mHxCoksNNXaEQBX8J1yQHTV6+ixsy0EY5gNM47/Qs24GpNDhx2aLx
	 TucE/xEYK5YAaXl/rSL21GMoVga6sOZUzucS95BjvyHPv+M58Mvu51Tx3T/wRLKLp0
	 QA7LetWY2REkAFNweLwi26iKXkhPDLQDHuRY12g51FeN3qV4ReFh2CtBL8gEceQ8Nn
	 h36zXcQ81AF3JmDJ/xBudpyOXaMwcdEjSqZ4yxdygWBSJgkIgdXSqr7+TM5CdMEuRq
	 /6jj+KpPfJqRjKRur5UlmTDe7/xg6ltIqxtpS6bzB03vnAjPLQZGSexvE1rxH6b9wW
	 KsYMG3+eKM4Zg==
Date: Tue, 10 Oct 2023 11:21:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <vadim.fedorenko@linux.dev>, <lkp@intel.com>,
 <horms@kernel.org>, Sean Tranchetti <quic_stranche@quicinc.com>
Subject: Re: [PATCH net-next v4] net: qualcomm: rmnet: Add side band flow
 control support
Message-ID: <20231010112159.2e2e1b86@kernel.org>
In-Reply-To: <b1efa230-b30b-0ace-5e99-fe8593eeb12e@quicinc.com>
References: <20231006001614.1678782-1-quic_subashab@quicinc.com>
	<20231009194251.641e9134@kernel.org>
	<28518005-bb25-caed-1b12-bf12a3ded4bc@quicinc.com>
	<20231010075655.2f8fbeb3@kernel.org>
	<b1efa230-b30b-0ace-5e99-fe8593eeb12e@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 09:23:12 -0600 Subash Abhinov Kasiviswanathan (KS)
wrote:
> > I'm not sure what you mean. Qdiscs can form hierarchies.
> > You put mq first and then whatever child qdisc you want for individual
> > queues.  
> 
> There is no userspace interface exposed today currently to invoke 
> netif_tx_stop_queue(dev, queue) / netif_tx_wake_queue(dev, queue). The 
> API itself can only be invoked within kernel.
> 
> I was wondering if it would be acceptable to add a user accessible 
> interface in core networking to stop_queue / wake_queue instead of the 
> driver.

Maybe not driver queue control but if there's no qdisc which allows
users to pause from user space, I think that would be a much easier
sale.

That said the flow of the whole thing seems a bit complex.
Can't the driver somehow be notified by the device directly?
User space will suffer from all sort of wake up / scheduling
latencies, it'd be better if the whole sleep / wake thing was 
handled in the kernel.

