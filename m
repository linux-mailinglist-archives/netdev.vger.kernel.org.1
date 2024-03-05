Return-Path: <netdev+bounces-77323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEE087144B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 04:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3221C212FA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 03:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAE13717D;
	Tue,  5 Mar 2024 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnySXayk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABE29CE9
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609435; cv=none; b=lUoCt7iV9Wp8DT5QCwSHIvs2iOHmQwsOeE8A+rgl/2NtLDejqTzC0uO+tS7QE6OJ8uJcxiPr4ktX/ukosZHFkBZXzpNkwEUCn1ueyoNHcil4hjx0i5HmeIMF1cez8Pqxy0/EZqipAbmJGNI1W8IIECUTTSNAae8c13Ii/dkdhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609435; c=relaxed/simple;
	bh=Dq/B4ljB9H3GcsJ/1gKLhGkQjtIFUj74G/DiDDZrpuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kY0dtoyBYB9RzWC+lqTLK7DnK2UGNsFPqdfysTsmSCKIWhpOWCPDK4r+eRS4+2yGFdDYFghcDYipICIdpoIzsJNxpQcqEfobi4MUHc69/Y6OnG/jXkttdneZd1F9g2EhRKfLpDP57nFcfrAWjDBZtF45jRP8IiXAW5XjKMXWhVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnySXayk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8607EC433C7;
	Tue,  5 Mar 2024 03:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709609435;
	bh=Dq/B4ljB9H3GcsJ/1gKLhGkQjtIFUj74G/DiDDZrpuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tnySXaykffJTUD3hAOyXeU84hvJY/t/lcszYnRCWWBJ/nSXRHZQaZZvuFV/G/C87P
	 TcxGVw8uvHCe6eQUH8PU2AqGd/iZRV3BfEvwK54qZetwcAqkmv/XAEt/iBmajooJZ2
	 OdqUSeP29nAXrsAUp/ROxIU1UGN1TdZRD6eZG6PqHwDnbuz2Dcjuz2yxeH4jy8YOMd
	 xwzTe2OOUWuLYjP6d20F8Kkkv0xtO962vSPzJnyEgyutu7YNu5MdpE1S4av7ttvyG3
	 +n34cupnm/PdVMIHl5BauSjB9XXZX+Il5MrBX+WfASzE2cjWTwQt2DlHvt8A3vdsBe
	 x8VfcT0HBYysw==
Date: Mon, 4 Mar 2024 19:30:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Wander Lairson Costa <wander@redhat.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v3 net-next 0/3] net: Provide SMP threads for backlog
 NAPI
Message-ID: <20240304193033.1c433585@kernel.org>
In-Reply-To: <20240228121000.526645-1-bigeasy@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 13:05:47 +0100 Sebastian Andrzej Siewior wrote:
> The RPS code and "deferred skb free" both send IPI/ function call
> to a remote CPU in which a softirq is raised. This leads to a warning on
> PREEMPT_RT because raising softiqrs from function call led to undesired
> behaviour in the past. I had duct tape in RT for the "deferred skb free"
> and Wander Lairson Costa reported the RPS case.
> 
> This series only provides support for SMP threads for backlog NAPI, I
> did not attach a patch to make it default and remove the IPI related
> code to avoid confusion. I can post it for reference it asked.
> 
> The RedHat performance team was so kind to provide some testing here.
> The series (with the IPI code removed) has been tested and no regression
> vs without the series has been found. For testing iperf3 was used on 25G
> interface, provided by mlx5, ix40e or ice driver and RPS was enabled. I
> can provide the individual test results if needed.

Acked-by: Jakub Kicinski <kuba@kernel.org>

