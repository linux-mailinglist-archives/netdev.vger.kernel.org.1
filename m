Return-Path: <netdev+bounces-77486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383FD871E93
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A40F1C2173D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8271F59B44;
	Tue,  5 Mar 2024 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZXDxm8w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693E5917C
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640457; cv=none; b=EQd0CBDXukA7dPdAlMC+hNBUNvY6qomBZ2lIHVlV8EcwyLoL0zmvaUPhBR5rQBlHJNQ3XbEVtJxBE3NNd97QIfJ4uEs/Xt1HQGy+qMpNwKH9Yb4weOJYReeUol+zTHqLJPH4xgzta2TzL199LihFbWB3D84rJnDZZSA3iZF7F5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640457; c=relaxed/simple;
	bh=55L4paee6Jf2kzypxu8nRT59dfZZnSAHinu2nGHFAHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HizgbAZBH19Yb8QQRPsC2XV8SEaQ965jo04qe7KrdVlEHkyz7p1MhDUDPlHW+5EuR/ePhde+OTw0ro6mm65tpfW/orZytLhWGpmieBjQylku3TK7o7agi2zFvriGPrq4Ub+0v10qkLFEOqH+hj+Hxbed7QB/l7rYVae/7424jzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZXDxm8w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709640454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QyIC8KPbVcnO8UHh0csU+uYuN8rUZZss5zbYqVrpg8=;
	b=fZXDxm8wX6fhmhvQNs6on4xuoq0hY1iydBFadFtKunF2oh9V2VKb5kLaYtYrXnyveDWSeD
	DCM4oNXs/SIOnzVhfVIOeJIkDc34UVMN3FbhznPRgBFCEFm8O23I/bZhPqTnC1p6sOGAnv
	mQU5Nv+rb9mz3NCxQkeZR4nSSdpEHPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-R8xLdif8PLGF4ZeyJyAmLA-1; Tue, 05 Mar 2024 07:07:31 -0500
X-MC-Unique: R8xLdif8PLGF4ZeyJyAmLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2925185A783;
	Tue,  5 Mar 2024 12:07:30 +0000 (UTC)
Received: from fedora (unknown [10.22.16.174])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ACF1A2166AED;
	Tue,  5 Mar 2024 12:07:27 +0000 (UTC)
Date: Tue, 5 Mar 2024 09:07:26 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v4 net-next 0/4] net: Provide SMP threads for backlog NAPI
Message-ID: <3fpntlz5golidj775wfnlzecd7ksimwutcqg7e6d2efejt6sip@akexo2hmy3hb>
References: <20240305120002.1499223-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305120002.1499223-1-bigeasy@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Tue, Mar 05, 2024 at 12:53:18PM +0100, Sebastian Andrzej Siewior wrote:
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
> 
> Changes:
> - v3…v4 https://lore.kernel.org/all/20240228121000.526645-1-bigeasy@linutronix.de/
> 
>   - Rebase on top of current net-next, collect Acks.
> 
>   - Add struct softnet_data as an argument to kick_defer_list_purge().
> 
>   - Add sd_has_rps_ipi_waiting() check to napi_threaded_poll_loop() which was
>     accidentally removed.
> 
> - v2…v3 https://lore.kernel.org/all/20240221172032.78737-1-bigeasy@linutronix.de/
> 
>   - Move the "if use_backlog_threads()" case into the CONFIG_RPS block
>     within napi_schedule_rps().
> 
>   - Use __napi_schedule_irqoff() instead of napi_schedule_rps() in
>     kick_defer_list_purge().
> 
> - v1…v2 https://lore.kernel.org/all/20230929162121.1822900-1-bigeasy@linutronix.de/
> 
>   - Patch #1 is new. It ensures that NAPI_STATE_SCHED_THREADED is always
>     set (instead conditional based on task state) and the smboot thread
>     logic relies on this bit now. In v1 NAPI_STATE_SCHED was used but is
>     racy.
> 
>   - The defer list clean up is split out and also relies on
>     NAPI_STATE_SCHED_THREADED. This fixes a different race.
> 
> - RFC…v1 https://lore.kernel.org/all/20230814093528.117342-1-bigeasy@linutronix.de/
> 
>    - Patch #2 has been removed. Removing the warning is still an option.
> 
>    - There are two patches in the series:
>      - Patch #1 always creates backlog threads
>      - Patch #2 creates the backlog threads if requested at boot time,
>        mandatory on PREEMPT_RT.
>      So it is either or and I wanted to show how both look like.
> 
>    - The kernel test robot reported a performance regression with
>      loopback (stress-ng --udp X --udp-ops Y) against the RFC version.
>      The regression is now avoided by using local-NAPI if backlog
>      processing is requested on the local CPU.
> 
> Sebastian
> 

Patch 0002 does not apply for me. I tried torvalds/master and
linux-rt-devel/linux-6.8.y-rt. Which tree should I use?


