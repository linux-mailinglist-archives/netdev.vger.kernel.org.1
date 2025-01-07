Return-Path: <netdev+bounces-156002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF10A0499D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 19:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4590E1670FF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CAB1F2C35;
	Tue,  7 Jan 2025 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgSksf8f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345DD1DFD87
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275984; cv=none; b=d8pA75yMj4OFOtK6GmgnQFULowSQfZlqteeFXL5dA5qBsM7t3pntjKcx4ooX6IW6rB6HwZi5CDBspoX5qFtZFOdu4dPumUGIKSvUD1qAePs5XvhbgmqT8huGd0qMXdjCbJcyDylXr3Kgb6y6aT6Hdkw9WCB80IJLH9HeWKJyKKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275984; c=relaxed/simple;
	bh=9vk+IEkJXpCiBn7KvXO2yU7lodW9ptwAp0TajUHl5ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMk/LPfAA7YfSvfoabsNzewpJb5n/fHk8JOkGD3H/wIT9t8xa90qQXh0W/cgtigCfUdhydTmaBpHVtTF9ZhVTCcYBlJY/yiXkpPstn+IzkSf+TxRXwoWKujecsVJ///UuvRBJgmVPTpQ2gwifJubIqPSLsIGZjWZXBArqKd8MnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgSksf8f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736275982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nweBwiQ4x8uvN5jQ4KfKWDvicEgXxH48zPPJEyuktZU=;
	b=XgSksf8fJagTPKpXUMdh2YmIFVwk5aqCprrinSUtpiwfnvc5B+JwbjLehwCxiUw+BHYdb0
	TfzwKtbNfSOaVw+IW7WLhzLvdORBVi66aXOM3JPcmAXgmGXrEEi9c22AxeypioP9ZXDc4O
	gukCfiRb43jfypa71ozl++kowN8FYhk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-hDlqxUtJO9CBeOq_TN9zdw-1; Tue,
 07 Jan 2025 13:52:58 -0500
X-MC-Unique: hDlqxUtJO9CBeOq_TN9zdw-1
X-Mimecast-MFC-AGG-ID: hDlqxUtJO9CBeOq_TN9zdw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E650619560A3;
	Tue,  7 Jan 2025 18:52:55 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.156])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3E1C51956053;
	Tue,  7 Jan 2025 18:52:48 +0000 (UTC)
Date: Tue, 7 Jan 2025 15:52:47 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Jeff Garzik <jgarzik@redhat.com>, Auke Kok <auke-jan.h.kok@intel.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH iwl-net 0/4] igb: fix igb_msix_other() handling for
 PREEMPT_RT
Message-ID: <taea3z7nof4szjir2azxsjtbouymqxyy4draa3hz35zbacqeeq@t3uidpha64k7>
References: <20241204114229.21452-1-wander@redhat.com>
 <20250107135106.WWrtBMXY@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107135106.WWrtBMXY@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jan 07, 2025 at 02:51:06PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-12-04 08:42:23 [-0300], Wander Lairson Costa wrote:
> > This is the second attempt at fixing the behavior of igb_msix_other()
> > for PREEMPT_RT. The previous attempt [1] was reverted [2] following
> > concerns raised by Sebastian [3].
> > 
> > The initial approach proposed converting vfs_lock to a raw_spinlock,
> > a minor change intended to make it safe. However, it became evident
> > that igb_rcv_msg_from_vf() invokes kcalloc with GFP_ATOMIC,
> > which is unsafe in interrupt context on PREEMPT_RT systems.
> > 
> > To address this, the solution involves splitting igb_msg_task()
> > into two parts:
> > 
> >     * One part invoked from the IRQ context.
> >     * Another part called from the threaded interrupt handler.
> > 
> > To accommodate this, vfs_lock has been restructured into a double
> > lock: a spinlock_t and a raw_spinlock_t. In the revised design:
> > 
> >     * igb_disable_sriov() locks both spinlocks.
> >     * Each part of igb_msg_task() locks the appropriate spinlock for
> >     its execution context.
> 
> - Is this limited to PREEMPT_RT or does it also occur on PREEMPT systems
>   with threadirqs? And if this is PREEMPT_RT only, why?

PREEMPT systems configured to use threadirqs should be affected as well,
although I never tested with this configuration. Honestly, until now I wasn't
aware of the possibility of a non PREEMPT_RT kernel with threaded IRQs by default.

> 
> - What causes the failure? I see you reworked into two parts to behave
>   similar to what happens without threaded interrupts. There is still no
>   explanation for it. Is there a timing limit or was there another
>   register operation which removed the mailbox message?
> 

I explained the root cause of the issue in the last commit. Maybe I should
have added the explanation to the cover letter as well.  Anyway, here is a
partial verbatim copy of it:

"During testing of SR-IOV, Red Hat QE encountered an issue where the
ip link up command intermittently fails for the igbvf interfaces when
using the PREEMPT_RT variant. Investigation revealed that
e1000_write_posted_mbx returns an error due to the lack of an ACK
from e1000_poll_for_ack.

The underlying issue arises from the fact that IRQs are threaded by
default under PREEMPT_RT. While the exact hardware details are not
available, it appears that the IRQ handled by igb_msix_other must
be processed before e1000_poll_for_ack times out. However,
e1000_write_posted_mbx is called with preemption disabled, leading
to a scenario where the IRQ is serviced only after the failure of
e1000_write_posted_mbx."

The call chain from igb_msg_task():

igb_msg_task
	igb_rcv_msg_from_vf
		igb_set_vf_multicasts
			igb_set_rx_mode
				igb_write_mc_addr_list
					kmalloc

Cannot happen from interrupt context under PREEMPT_RT. So this part of
the interrupt handler is deferred to a threaded IRQ handler.

> > Cheers,
> > Wander
> 
> Sebastian
> 


