Return-Path: <netdev+bounces-173126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A992BA577B7
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC5B189994B
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 02:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519431465AE;
	Sat,  8 Mar 2025 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKR/uN9k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D31613AA31
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741402405; cv=none; b=gYO1oRNnQYZLh9FbqgG1E2WQLH2C6zIoSJdM+nIuxHqzQYUbOravGmGoEAt3VHDzVQNLpMAYXahTW6EiAdRc4dXSds9c5IOaN4wZ1X7CCufYGyFRcynPqLazskiuLVkyWxTbTz4Soyh7N3BCU1jQPbHiCMmJBeh5K+3AeFQx9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741402405; c=relaxed/simple;
	bh=TFJZeWORbK61EuuElDtn2qLeOd3V3yiD/UOcUhSI0KA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZx7coY59YpZlx6p6BNZtpn4xZula4HY7SRRF/AEuz5mkxfDI1KD/jUE2LfLPLZw2Tw+Iwi9P64kJeyDkyz6RkvvJTbgOETPWDK5pt5SEsxAqDIFdt81Yt9gu9DuZGnSjvgjPzPZp8uPKhwxSwj6WUGpbHMdbdi4EhLpYvlhGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKR/uN9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76780C4CEE3;
	Sat,  8 Mar 2025 02:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741402404;
	bh=TFJZeWORbK61EuuElDtn2qLeOd3V3yiD/UOcUhSI0KA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EKR/uN9kL60DUeyeLIFt/WIe97VQ1mcYfwW0+E9oBI5PB1ZoDYpVowJ3aw1mgQZ3K
	 80bnMhymkOXIDwgNcLiNcdwr6ng4rcPAHjEA7G45wUeQhxxhwglKGZ+fG+P9RXXlr2
	 Vhbk5DQoxc1IZNwOpRtM8whmUNlVrcQrPiWu4BvYLggCkbHdOvjb7++eqz3IfMH28n
	 k8VlIAUnHGcDmemUH/clKz9QUdRsIwShJPjJJmmt0Jtq639kbzJ3lBTAnDOSMIQJzZ
	 2eGTct5/tpAQxbD8bbSLaWC5jOv8GY94tcGU72sqytbWNdMlMoCm1Z0S5vqX+ItTv2
	 98zajbIABuPtQ==
Date: Fri, 7 Mar 2025 18:53:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Message-ID: <20250307185323.74b80549@kernel.org>
In-Reply-To: <01576402efe6a5a76d895eca367aa01e7f169d3d.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	<20250227042638.82553-2-allison.henderson@oracle.com>
	<20250228161908.3d7c997c@kernel.org>
	<b3f771fbc3cb987cd2bd476b845fdd1f901c7730.camel@oracle.com>
	<20250304164412.24f4f23a@kernel.org>
	<ba0b69633769cd45fccf5715b9be9d869bc802ae.camel@oracle.com>
	<20250306101823.416efa9d@kernel.org>
	<01576402efe6a5a76d895eca367aa01e7f169d3d.camel@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 20:28:57 +0000 Allison Henderson wrote:
> > Let's be precise, can you give an example of 2 execution threads
> > and memory accesses which have to be ordered.  
> 
> Hi Jakub,
> 
> I just realized my last response referred to bits and functions in the next patch instead this of one.  Apologies for
> the confusion!  For this thread example though, I think a pair of threads in rds_send_worker and rds_sendmsg would be a
> good example?  How about this:
> 
> Thread A:
>   Calls rds_send_worker()
>     calls rds_clear_queued_send_work_bit()
>       clears RDS_SEND_WORK_QUEUED in cp->cp_flags
>     calls rds_send_xmit()
>     calls cond_resched()
> 
> Thread B:
>    Calls rds_sendmsg()
>    Calls rds_send_xmit
>    Calls rds_cond_queue_send_work 
>       checks and sets RDS_SEND_WORK_QUEUED in cp->cp_flags

We need at least two memory locations if we want to talk about ordering.
In your example we have cp_flags, but the rest is code.
What's the second memory location.
Take a look at e592b5110b3e9393 for an example of a good side by side
thread execution.. listing(?):

    Thread1 (oa_tc6_start_xmit)     Thread2 (oa_tc6_spi_thread_handler)
    ---------------------------     -----------------------------------
    - if waiting_tx_skb is NULL
                                    - if ongoing_tx_skb is NULL
                                    - ongoing_tx_skb = waiting_tx_skb
    - waiting_tx_skb = skb
                                    - waiting_tx_skb = NULL
                                    ...
                                    - ongoing_tx_skb = NULL
    - if waiting_tx_skb is NULL
    - waiting_tx_skb = skb


This makes it pretty clear what fields are at play and how the race
happens.

