Return-Path: <netdev+bounces-106288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A41915AB1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944921C21319
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 23:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF88140BF5;
	Mon, 24 Jun 2024 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc3GVIKj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8217BA7;
	Mon, 24 Jun 2024 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719272181; cv=none; b=ROVQ8GCXTyRCmz96WO8uTBFplW90yKMfQXuJ2Z+z3nLP8G6Jmq8cmxZhZO/mx3s4BD6CqZsFuiv+BgBYMLWK5iZthmbABEbLVWxf1xRo2HK4TcYorDnwGmSCeGyZCPY5Nh0UqgeB2kGBGOixFUPNv4zveEPQY65pYbgZUJfwptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719272181; c=relaxed/simple;
	bh=Ngx/MU1a5WJxKJN+ihznyk1g56houIJ0LTWcBMsNHkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wp64cwQUj+pKV0DMvsZuwgGtC/ZA9d05o4vfFyVkuf5xudU4ADMyoJFUVkCWJ4I0uA0nODSARnKsyLSo693MUvnfAWZVndrDDiFgtWqLqO9WIDBls6ObXyG7oQInhojcGKtoUNVRky0q+r7I5M1pLEHke62d/3AHDpf3xKHIKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc3GVIKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E00C2BBFC;
	Mon, 24 Jun 2024 23:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719272181;
	bh=Ngx/MU1a5WJxKJN+ihznyk1g56houIJ0LTWcBMsNHkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jc3GVIKj10Lb+OUSZgFb3fYBA2xEspM8PXNiJoyoHrcwu4K12I4yBK7NNTU+MRt3P
	 dAW3RlZGXgDJYSdejqKF296xzrQp/XgBndA1WJpAytN1SRJVKNBkZOWYjA5T74AIGO
	 kml7CRvoj3cnMAetaOAmUisAgZLdoZmscel3l32vguv5YQW9iNLdR74KjbJ+E9vI42
	 X2S4dmgeYzQx5SWez1YLGedTgXgzxPO+gRHB9Swav6kp5lccxyQXOboVd9g9rWGB30
	 gGOTiBIA4L8bnIonLtci9f4rNUmXeZiX/I3O74vppagRlGBsTB1PHHVpQpNwMFJsVY
	 9sjXe9jkZAIiA==
Date: Mon, 24 Jun 2024 16:36:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Daniel Bristot de Oliveira <bristot@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>, Ben Segall <bsegall@google.com>, Daniel Bristot de
 Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, Steven
 Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v9 net-next 08/15] net: softnet_data: Make xmit per
 task.
Message-ID: <20240624163619.47dce4e4@kernel.org>
In-Reply-To: <20240624102018.WYAKspD9@linutronix.de>
References: <20240620132727.660738-1-bigeasy@linutronix.de>
	<20240620132727.660738-9-bigeasy@linutronix.de>
	<20240621191245.1016a5d6@kernel.org>
	<20240624102018.WYAKspD9@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 12:20:18 +0200 Sebastian Andrzej Siewior wrote:
> Any update request?

Current version is good, then, thanks for investigating!

