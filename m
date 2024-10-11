Return-Path: <netdev+bounces-134625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C5C99A883
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E141F25283
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42155197A68;
	Fri, 11 Oct 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3bCJIF7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEDD188CB1
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662353; cv=none; b=MG69Ej9Y3xxF0JHIu2h9RVGCsEE+O82W6ULnn9UVplyRjKxALozBpNaS6ZuasPHA6E3nDJaik5qiOgn+vHKfj/fd3crkZUYvIzK8b9dry2dJGQMTZcRJPvHE9sOT0S2wEvKaa73sPkjyMUUVcMD0EJDgFn5ytAPNYuy29BvBKik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662353; c=relaxed/simple;
	bh=RMVXlO9wskeIe/UCksFGod6sFgHjhfZEWCwZlewcpVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P07zRlAF8gwrqSLh/o+hUdrPUxn9IokrO6Q97nXIpRHmMDVPF7hQU1ometF202K20P5ExAVkCdi7qiZu0q7Km5v9p9INqPDGpgY2a4LTjNi9vgQnlqmU7tblHypCgChkzx6e5/XgB6OBqqKuQ5N977p9LpJF7LFtSu0BswLKuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3bCJIF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526DFC4CEC3;
	Fri, 11 Oct 2024 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662352;
	bh=RMVXlO9wskeIe/UCksFGod6sFgHjhfZEWCwZlewcpVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j3bCJIF7xNIh+gA9VH9c+HEiDBHyRxQ583kAaJhtS0ZlUV7ArYKnV0BBHGQDB3apT
	 Zpj450yc8hMNAvVCd/QdYMbBUdCJSyCbk7wSa3FLIfWk1aH2IVsUtNy8lzC0WCcUGN
	 q7+ujzl/SzKp/AsSeG+i2FtPBAN4fNEuB5KhLHs8dlKQTq46E2w4McS1AfBgnXxuKx
	 d2da4x7vHNuQiqaxMTuyXHcmRLvC8XPvue/F/P64TbMF0hvdgiPChbwvFIVoTphKLo
	 2M0LdB8mv0WKFhJ8665N31dZLpHkx2JrlBkqY0aVUXTruN+jbPq5xty8+2Eo0YG38p
	 XIi0QDM3bdwgQ==
Date: Fri, 11 Oct 2024 08:59:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Jiri
 Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net] netdevsim: use cond_resched() in
 nsim_dev_trap_report_work()
Message-ID: <20241011085911.601bad62@kernel.org>
In-Reply-To: <20241011131843.2931995-1-edumazet@google.com>
References: <20241011131843.2931995-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 13:18:43 +0000 Eric Dumazet wrote:
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -848,11 +848,12 @@ static void nsim_dev_trap_report_work(struct work_struct *work)
>  			continue;
>  
>  		nsim_dev_trap_report(nsim_dev_port);
> +		cond_resched();
>  	}
>  	devl_unlock(priv_to_devlink(nsim_dev));
> -
> -	schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw,
> -			      msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
> +	queue_delayed_work(system_unbound_wq,
> +			   &nsim_dev->trap_data->trap_report_dw,
> +			   msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));

Makes sense, there's one more place which queues this work, in case we
couldn't grab the lock. Should it also be converted?

