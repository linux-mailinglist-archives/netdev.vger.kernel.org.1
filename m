Return-Path: <netdev+bounces-168206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191DAA3E1AC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCBC8702801
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A299213E8E;
	Thu, 20 Feb 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbFpXPP5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFA212D83;
	Thu, 20 Feb 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070298; cv=none; b=Lu2w+KEVu9kZxUtbha+mLLNqCl0pMKQ4R1FashnU+CgKVobv1ODJD9oqWOhqjfl33lCeflHlDaC5I+lNOWxvM/urox2LS4Ub2gjces17quTXzj4Bf3F18pi9EpX8A7qP26D9Mces/B/v6/rFAHBw5l33pdock8s05Kz5oVicspY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070298; c=relaxed/simple;
	bh=ytorNLXwu82ndLPg3sEbUexyVt7Oym5cZyN0OL7j5lo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEI7EzxNq/ZZQM5YKVsfmPNXMmuUUCi3VPiwqJi4EwzE+URzamwQlCSDtmqjEabOlrcYEIhr2fG/HiJx7mciyYnC7xfpmEObc3QFJ6742kMt6vzfwaQApe0zbyGc6N59Ehzmqwk189b11SXgDycD6Ld0LhkzKxjc1yX3j2C3TJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbFpXPP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2EBC4CED1;
	Thu, 20 Feb 2025 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070298;
	bh=ytorNLXwu82ndLPg3sEbUexyVt7Oym5cZyN0OL7j5lo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UbFpXPP5KyWYzG6qjfZTd9upfy3L6tmNigf/hvozaXyEXyztnrVSG8yeBAgQv/5j+
	 apss/yzYtBCqm6bJ5Dj+4/PmbClVoovFCT2+yN7Bh3VDlax2omy+vlmCJPrutwMOC1
	 hrb1CtdsTB2qQZbeFXiTbAZ+9ndgymDlb/RaSyrm2KvipN4eW4yj3lblsazVzz66/r
	 arMSzGtLBYwO5o48h1zZxCV0Gx7W52FHBFYl6pwDJUwJCl4gl4BEM0Jf4uiifimt2f
	 WOOX3DbnizclE6v8vY04f7bgnOBMNfoUNvycH5PW2k6UNuSmQrEcAJkRuEe04Fi1X4
	 Qagvn9WZiNCcg==
Date: Thu, 20 Feb 2025 08:51:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net-next] net: cadence: macb: Implement BQL
Message-ID: <20250220085137.62360239@kernel.org>
In-Reply-To: <10a50a6c-a6be-4723-80b3-62119f667977@linux.dev>
References: <20250214211643.2617340-1-sean.anderson@linux.dev>
	<20250218175700.4493dc49@kernel.org>
	<10a50a6c-a6be-4723-80b3-62119f667977@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:55:45 -0500 Sean Anderson wrote:
> On 2/18/25 20:57, Jakub Kicinski wrote:
> > On Fri, 14 Feb 2025 16:16:43 -0500 Sean Anderson wrote:  
> >> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> >> index 48496209fb16..63c65b4bb348 100644
> >> --- a/drivers/net/ethernet/cadence/macb_main.c
> >> +++ b/drivers/net/ethernet/cadence/macb_main.c
> >> @@ -1081,6 +1081,9 @@ static void macb_tx_error_task(struct work_struct *work)
> >>  						      tx_error_task);
> >>  	bool			halt_timeout = false;
> >>  	struct macb		*bp = queue->bp;
> >> +	u32			queue_index = queue - bp->queues;  
> > 
> > nit: breaking reverse xmas tree here  
> 
> It has to happen here since bp isn't available earlier.

Move it from init to normal code?

