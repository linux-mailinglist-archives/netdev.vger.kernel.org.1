Return-Path: <netdev+bounces-103663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EACDC908F93
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8A5B22408
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE7F146A9D;
	Fri, 14 Jun 2024 16:04:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24902B9A5;
	Fri, 14 Jun 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381052; cv=none; b=Vre/drbomWHy6HhKmaJQQ4rZiqy6ccrY1AMX0cWbBPEF/hA/SyqKTDu85pzcj5Co1AmKaDc7gH0C4uMDA95xZU6wJ9PSn+qE+qqNIgLHa8CGhnqh600WVzkiZeMDgYVxd5AG/2DMbqEa2aBgGg+BOoz3UD7wYLPEGqHW/YZ5ERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381052; c=relaxed/simple;
	bh=h70utgHBorbBfshCIgE/ucDMVVK2Rn8sFXr9Eehm52E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e58CEHZ4fQDrtmbe+fZWIngWSTGBOMOs2aDDA7BV7ZSSobCunGsj1oUphhhXZ9uLWCPYPkrqrD/TbTsKnUKbFfvOjPbYissQozVQ10y9nrAzRbjmdJwnrnGV4dCJtkoaWvP8MXSLeH80IkPYQw4hjGOIp4Km7/gTyNCkWNui+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35FFC32786;
	Fri, 14 Jun 2024 16:04:08 +0000 (UTC)
Date: Fri, 14 Jun 2024 12:04:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Eric Dumazet 
 <edumazet@google.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel
 Bristot de Oliveira <bristot@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Ben Segall <bsegall@google.com>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 net-next 08/15] net: softnet_data: Make
 xmit.recursion per task.
Message-ID: <20240614120407.3eb2ac80@rorschach.local.home>
In-Reply-To: <834b61b93df3cbf5053e459f337e622e2c510fbd.camel@redhat.com>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
	<20240612170303.3896084-9-bigeasy@linutronix.de>
	<20240612131829.2e33ca71@rorschach.local.home>
	<20240614082758.6pSMV3aq@linutronix.de>
	<CANn89i+YfdmKSMgHni4ogMDq0BpFQtjubA0RxXcfZ8fpgV5_fw@mail.gmail.com>
	<20240614094809.gvOugqZT@linutronix.de>
	<834b61b93df3cbf5053e459f337e622e2c510fbd.camel@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 16:08:42 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> > Is this what we want or not?  
> 
> I personally think (fear mostly) there is still the potential for some
> (performance) regression. I think it would be safer to introduce this
> change under a compiler conditional and eventually follow-up with a
> patch making the code generic.
> 
> Should such later change prove to be problematic, we could revert it
> without impacting the series as a whole. 

That makes sense to me.

-- Steve

