Return-Path: <netdev+bounces-182093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51673A87C08
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4AD21889DA4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB68262D02;
	Mon, 14 Apr 2025 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U5wwHp87"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569925A345
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623465; cv=none; b=uL91H1liPWECRdvZvQKk3mRBkWr2RDAJO/MYU6u4cANkCemRJPMraDRLJLwvZEqNr4SB6dXg8FncY4pz7MdCM8NnL90J19GfrLRWdtoFcfuuhtWVAC4HphErXGMEHWp33k85knd4vwunojZCxyq9gFZiBrvgeEgVk/DQ11a51nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623465; c=relaxed/simple;
	bh=RfmKRKgsCSXvsFbpEfR7G5fGocEUnY6wL7YBYirtd9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyKb69O2bpebtdQ0azrDeU70IgqKbQeKYPpUlHMSPl/J1q+lsXoPlO5YjLD/4e2Dbsv2BA4HC+yBKSYlGrkazkCX1QXIh6+tLC1dAjy0ksIjDihya3PCbWiv4jHXwCOheOKUikTvA5Peg+klXC/Emx5VGYXcDv6amZXqlgI5G8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U5wwHp87; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b6aea926-ebb6-48fe-a1be-6f428a648eae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744623449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq648+S4Hz/D1ux1j2t4fcnqzswyqgLomIbtcNpKqs4=;
	b=U5wwHp87Ecx4muexWBZG4O/daJF6fMDsFzfC9DSSkjunEY4Q8ztQUwKuWtT8w7pioc0OQq
	tQLTRrQoBCwOiS7+kl+xscSWXHHL027H2V6PZBWGyz124wyZ4kHxI/mjZXvvuG5tczS3bw
	uPwZ2Uz/ug3fORviq3lLflAf1TooDoQ=
Date: Mon, 14 Apr 2025 10:37:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] ptp: ocp: fix NULL deref in _signal_summary_show
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250414085412.117120-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250414085412.117120-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/04/2025 09:54, Sagi Maimon wrote:
> Sysfs signal show operations can invoke _signal_summary_show before
> signal_out array elements are initialized, causing a NULL pointer
> dereference. Add NULL checks for signal_out elements to prevent kernel
> crashes.
> 
> Fixes: b325af3cfab9 ("ptp: ocp: Add signal generators and update sysfs nodes")
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
>   drivers/ptp/ptp_ocp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 7945c6be1f7c..4c7893539cec 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -3963,6 +3963,9 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
>   	bool on;
>   	u32 val;
>   
> +	if (!bp->signal_out[nr])
> +		return;
> +
>   	on = signal->running;
>   	sprintf(label, "GEN%d", nr + 1);
>   	seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu pol:%d",

That's not correct, the dereference of bp->signal_out[nr] happens before
the check. But I just wonder how can that even happen?

I believe the proper fix is to move ptp_ocp_attr_group_add() closer to
the end of ptp_ocp_adva_board_init() like it's done for other boards.

--
pw-bot: cr

