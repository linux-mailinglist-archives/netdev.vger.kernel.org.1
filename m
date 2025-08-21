Return-Path: <netdev+bounces-215672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92544B2FD99
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01416AA6087
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E87E27E1B1;
	Thu, 21 Aug 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQFcKtcF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E57C214204
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787903; cv=none; b=euTd21uhbDrXqfVWdPXotc2+PguJbF2fAfi019h5blDf6crTV8dRf9GQNNnkxPu5raKC358kmvr0QxSh8BVMSQMDhfgOXZ3fMrxvep26yzru3IQiDcl5TGeKi4DNU3jEPT/D2F7VmKp+BCbxbfRNmMtYPBpDV9upaw03eR9TRqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787903; c=relaxed/simple;
	bh=haGeC4GC3hxJ6JbqWzcnLgrLFTcjziUEqF5OO/4+17g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3MDS5dLgvwSh07EFC4wGErXvHsjAAuZsMgZ8OtzPXLCWLrq1zAdveU1tfjwJ0QhM1P6KIGmoJLWNX0qilhP1e1ZMXkUc0QX/kelRwxmhnxBcvU/rohHWHjoJwHnklMtVhqTM6pjVWlvyvozmrziToDnb4UsXU6OVWKTa6uvgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQFcKtcF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755787901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rr9rUoIkr1nx8JPvQgy7YChPIsLZS2L4L5UXWNYbAxw=;
	b=IQFcKtcF+nSydOs59Vl9GFF+H1PvrNXA4hL1lBfU67xvBvbTXTiORi6zMx5Yt/7gi2xK7u
	BO0bxm+q3T6SQdTX/heCylDj0bro+nabW6EhmzCrbiMOLblAO/XZptM2ssjtX5EYRD615w
	xFYt0FmDIM2QyOeckTXk+MDV/XkGP+c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-JBwv4IN1NdmZ4D-jFOQ2Bw-1; Thu,
 21 Aug 2025 10:51:37 -0400
X-MC-Unique: JBwv4IN1NdmZ4D-jFOQ2Bw-1
X-Mimecast-MFC-AGG-ID: JBwv4IN1NdmZ4D-jFOQ2Bw_1755787895
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C259D19541BD;
	Thu, 21 Aug 2025 14:51:34 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B836F3001453;
	Thu, 21 Aug 2025 14:51:30 +0000 (UTC)
Date: Thu, 21 Aug 2025 16:51:28 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
Message-ID: <aKcycAXlKfSxxhZ3@localhost>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
 <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
 <aKV_rEjYD_BDgG1A@localhost>
 <81c1a391-3193-41c6-8ab7-c50c58684a22@intel.com>
 <87ldncoqez.fsf@jax.kurt.home>
 <aKcYFbzbbfPXlrlN@localhost>
 <87cy8ooji5.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cy8ooji5.fsf@jax.kurt.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Aug 21, 2025 at 04:08:02PM +0200, Kurt Kanzenbach wrote:
> On Thu Aug 21 2025, Miroslav Lichvar wrote:
> >> >> Without the patch:
> >> >> NTP daemon TX timestamps   : 35835
> >> >> NTP kernel TX timestamps   : 1410956
> >> >> NTP hardware TX timestamps : 581575            
> >> >> 
> >> >> With the patch:
> >> >> NTP daemon TX timestamps   : 476908
> >> >> NTP kernel TX timestamps   : 646146
> >> >> NTP hardware TX timestamps : 412095

> > With the new patch at 200000 requests per second:
> > NTP daemon TX timestamps   : 192404
> > NTP kernel TX timestamps   : 1318971
> > NTP hardware TX timestamps : 418805

> Here's what I can see in the traces: In the current implementation, the
> kworker runs directly after the IRQ on the *same* CPU. With the AUX
> worker approach the kthread can be freely distributed to any other
> CPU. This in turn involves remote wakeups etc.
> 
> You could try to pin the PTP AUX worker (e.g. called ptp0) with taskset
> to the same CPU where the TS IRQs are processed. That might help to get
> the old behavior back. Adjusting the priority is not necessary, both the
> kworker and AUX thread run with 120 (SCHED_OTHER, nice value 0) by
> default.

Yes, that helps!

The server timestamping stats now show:
NTP daemon TX timestamps   : 32902
NTP kernel TX timestamps   : 1479293
NTP hardware TX timestamps : 520146

And the maximum response rate is only about 2-3% lower, so that looks
good to me.

Thanks,

-- 
Miroslav Lichvar


