Return-Path: <netdev+bounces-165491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1348A3257A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 12:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1051E188A02B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 11:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF620B1FB;
	Wed, 12 Feb 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpGmcaQM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A37520B1ED
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361423; cv=none; b=fMG/ZIbZlKXCB3q2+s1H85PE0wfFH8T3NPrK53rTgMPw0654Gsk6UwNy9KqCUXJqfFUGKdACNXrYTsZRRHxHwCmA9l3ofiWq3Ak5BbU1KyZU1xoXxACm+ZUahB/GO2QNKtsDUx5D/eJmOF0WsHd3uvw6CtJt2mLa/7f+y0vVuhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361423; c=relaxed/simple;
	bh=1xOagMwx81LRVocevwDW4ihEkw7v08IAkRARjMvVq4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaHyZYHULJq8vamE6fTpjJAmooTAJk87fMdDyAcBusn4BMgD9S3Uwz/QVG8dAeZj529ge42bkbduZu9agF6WQkMFBAD4o9a7ZsI8nSIshSjECt5SHrwnU2494zrKAvlghtkYmkpalDBd2JxxJ5FypD+Hh01Hmy+BbppQw+r0aAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpGmcaQM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739361420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9wwg/EYSBHu1U4/7rjPkT7ZbHmVu3EteW6eLxGS4Ag=;
	b=PpGmcaQM3tJizR20wJydpOlZ1RM8omkfiOp3RrVGG4vh7DT23R6dUlArmLMdtwf+svWeIK
	L7xZkygcQjmqFMcmlgmW/MSEfZ0ZQue5HDgteu8xWP8TNLz61lJwwX0eiFsvl6+ZSNuzkb
	dDsAki1/uBcivgoy/YRNlrj9T1E7AbA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-WLVxtvUQNACcQ9SCF6KAZQ-1; Wed,
 12 Feb 2025 06:56:57 -0500
X-MC-Unique: WLVxtvUQNACcQ9SCF6KAZQ-1
X-Mimecast-MFC-AGG-ID: WLVxtvUQNACcQ9SCF6KAZQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF7131800879;
	Wed, 12 Feb 2025 11:56:54 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.107])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B06401800365;
	Wed, 12 Feb 2025 11:56:48 +0000 (UTC)
Date: Wed, 12 Feb 2025 08:56:47 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, rostedt@goodmis.org, clrkwllms@kernel.org, jgarzik@redhat.com, 
	yuma@redhat.com, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de>
 <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206115914.VfzGTwD8@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Feb 06, 2025 at 12:59:14PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-05 17:08:35 [-0300], Wander Lairson Costa wrote:
> > On Wed, Feb 05, 2025 at 10:48:18AM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2025-02-04 09:52:36 [-0800], Tony Nguyen wrote:
> > > > Wander Lairson Costa says:
> > > > 
> > > > This is the second attempt at fixing the behavior of igb_msix_other()
> > > > for PREEMPT_RT. The previous attempt [1] was reverted [2] following
> > > > concerns raised by Sebastian [3].
> > > 
> > > I still prefer a solution where we don't have the ifdef in the driver. I
> > > was presented two traces but I didn't get why it works in once case but
> > > not in the other. Maybe it was too obvious.
> > 
> > Copying the traces here for further explanation. Both cases are for
> > PREEMPT_RT.
> > 
> > Failure case:
> > 
> > kworker/-86      0...1    85.381866: function:                   igbvf_reset
> > kworker/-86      0...2    85.381866: function:                      e1000_reset_hw_vf
> > kworker/-86      0...2    85.381867: function:                         e1000_check_for_rst_vf
> > kworker/-86      0...2    85.381868: function:                         e1000_write_posted_mbx
> > kworker/-86      0...2    85.381868: function:                            e1000_write_mbx_vf
> > kworker/-86      0...2    85.381870: function:                            e1000_check_for_ack_vf // repeats for 2000 lines
> 
> So it repeats because it waits for the bit. It waits for the interrupts.
> 
> > ...
> > kworker/-86      0.N.2    86.393782: function:                         e1000_read_posted_mbx
> 
> Is this 2 the migrate-disable or preempt-disable counter? Because you
> should get preempted based on that N.
> 
> > kworker/-86      0.N.2    86.398606: function:                      e1000_init_hw_vf
> > kworker/-86      0.N.2    86.398606: function:                         e1000_rar_set_vf
> > kworker/-86      0.N.2    86.398606: function:                            e1000_write_posted_mbx
> > irq/65-e-1287    0d..1    86.398609: function:             igb_msix_other
> 
> So the kworker leaves and immediately the interrupt gets on the CPU.
> 
> > irq/65-e-1287    0d..1    86.398609: function:                igb_rd32
> > irq/65-e-1287    0d..2    86.398610: function:                igb_check_for_rst
> > irq/65-e-1287    0d..2    86.398610: function:                igb_check_for_rst_pf
> > irq/65-e-1287    0d..2    86.398610: function:                   igb_rd32
> > irq/65-e-1287    0d..2    86.398611: function:                igb_check_for_msg
> > irq/65-e-1287    0d..2    86.398611: function:                igb_check_for_msg_pf
> > irq/65-e-1287    0d..2    86.398611: function:                   igb_rd32
> > irq/65-e-1287    0d..2    86.398612: function:                igb_rcv_msg_from_vf
> > irq/65-e-1287    0d..2    86.398612: function:                   igb_read_mbx
> > irq/65-e-1287    0d..2    86.398612: function:                   igb_read_mbx_pf
> > irq/65-e-1287    0d..2    86.398612: function:                      igb_obtain_mbx_lock_pf
> > irq/65-e-1287    0d..2    86.398612: function:                         igb_rd32
> > 
> > In the above trace, observe that the ISR igb_msix_other() is only
> > scheduled after e1000_write_posted_mbx() fails due to a timeout.
> > The interrupt handler should run during the looping calls to
> > e1000_check_for_ack_vf(), but it is not scheduled because
> > preemption is disabled.
> 
> What disables preemption? On PREEMPT_RT the spin_lock() does not disable
> preemption. You shouldn't spin that long. When was interrupt scheduled.
> _Why_ is the interrupt delayed that long.
> 
When I was using trace-cmd report -l, it omitted some fields, one of
them is preempt-lazy-depth (which was something new to me), and it seems
this is what affects interrupts. It comes from here [1]. I had the logs,
but the machine went under maintenance  before I could save them. Once
it comes back, I can grab them and post here.

[1] https://elixir.bootlin.com/linux/v6.13.2/source/drivers/net/ethernet/intel/igbvf/netdev.c#L1522

> > Note that e1000_check_for_ack_vf() is called 2000 times before
> > it finally times out.
> 
> Exactly.
> 
> > Sucessful case:
> > 
> >       ip-5603    0...1  1884.710747: function:             igbvf_reset
> >       ip-5603    0...2  1884.710754: function:                e1000_reset_hw_vf
> >       ip-5603    0...2  1884.710755: function:                   e1000_check_for_rst_vf
> >       ip-5603    0...2  1884.710756: function:                   e1000_write_posted_mbx
> >       ip-5603    0...2  1884.710756: function:                      e1000_write_mbx_vf
> >       ip-5603    0...2  1884.710758: function:                      e1000_check_for_ack_vf
> >       ip-5603    0d.h2  1884.710760: function:             igb_msix_other
> >       ip-5603    0d.h2  1884.710760: function:                igb_rd32
> >       ip-5603    0d.h3  1884.710761: function:                igb_check_for_rst
> >       ip-5603    0d.h3  1884.710761: function:                igb_check_for_rst_pf
> >       ip-5603    0d.h3  1884.710761: function:                   igb_rd32
> >       ip-5603    0d.h3  1884.710762: function:                igb_check_for_msg
> >       ip-5603    0d.h3  1884.710762: function:                igb_check_for_msg_pf
> >       ip-5603    0d.h3  1884.710762: function:                   igb_rd32
> >       ip-5603    0d.h3  1884.710763: function:                igb_rcv_msg_from_vf
> >       ip-5603    0d.h3  1884.710763: function:                   igb_read_mbx
> >       ip-5603    0d.h3  1884.710763: function:                   igb_read_mbx_pf
> >       ip-5603    0d.h3  1884.710763: function:                      igb_obtain_mbx_lock_pf
> >       ip-5603    0d.h3  1884.710763: function:                         igb_rd32
> > 
> > Since we forced the interrupt context for igb_msix_other(), it now
> > runs immediately while the driver checks for an acknowledgment via
> > e1000_check_for_ack_vf().
> 
> Is this still RT or non-RT? I'm asking because igbvf_reset() is invoked
> in ip's context and not in a worker. Also igb_msix_other() runs with a
> 'h' so it is not threaded.
> 
> I have a theory of my own, mind testing 
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index d368b753a4675..6fe37b8001c36 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -912,7 +912,7 @@ static int igb_request_msix(struct igb_adapter *adapter)
>  	struct net_device *netdev = adapter->netdev;
>  	int i, err = 0, vector = 0, free_vector = 0;
>  
> -	err = request_irq(adapter->msix_entries[vector].vector,
> +	err = request_threaded_irq(adapter->msix_entries[vector].vector, NULL,
>  			  igb_msix_other, 0, netdev->name, adapter);
>  	if (err)
>  		goto err_out;
> 
> just to see if it solves the problem?
> 
I have two test cases:

1) Boot the machine with nr_cpus=1. The driver reports "PF still
resetting" message continuously. This issue is gone.

2) Run the following script:

    ipaddr_vlan=3
    nic_test=ens14f0
    vf=${nic_test}v0 # The main testing steps:
    while true; do
        ip link set ${nic_test} mtu 1500
        ip link set ${vf} mtu 1500
        ip link set $vf up
        # 3. set vlan and ip for VF
        ip link set ${nic_test} vf 0 vlan ${ipaddr_vlan}
        ip addr add 172.30.${ipaddr_vlan}.1/24 dev ${vf}
        ip addr add 2021:db8:${ipaddr_vlan}::1/64 dev ${vf}
        # 4. check the link state for VF and PF
        ip link show ${nic_test}
        if ! ip link show $vf | grep 'state UP'; then
            echo 'Error found'
            break
        fi
        ip link set $vf down
    done

This one eventually fails. It is the first time that one works and the
other fails. So far, it has been all or nothing. I didn't have time yet to
investigate why this happens.

> > 
> > > In the mean time:
> > > 
> > > igb_msg_task_irq_safe()
> > > -> vfs_raw_spin_lock_irqsave() // raw_spinlock_t
> > > -> igb_vf_reset_event()
> > >   -> igb_vf_reset()
> > >     -> igb_set_rx_mode()
> > >       -> igb_write_mc_addr_list()
> > >          -> mta_list = kcalloc(netdev_mc_count(netdev), 6, GFP_ATOMIC); // kaboom?
> > 
> > Perhaps the solution is to preallocate this buffer, if possible.
> > Doing so would significantly simplify the patch. However, this
> > would require knowing when the multicast (mc) count changes.
> > I attempted to identify this but have not succeeded so far.
> > 
> > > 
> > > By explicitly disabling preemption or using a raw_spinlock_t you need to
> > > pay attention not to do anything that might lead to unbounded loops
> > > (like iterating over many lists, polling on a bit for ages, …) and
> > > paying attention that the whole API underneath that it is not doing that
> > > is allowed to.
> > 
> > I unsure if I understood what you are trying to say.
> 
> The moment you start disabling preemption/ use raw_spin_lock_t you need
> to start about everything underneath/ everything within this section.
> While if you keep using spinlock_t you don't have to worry *that* much
> and worry if *this* will break PREEMPT_RT. Not to worry whether or not
> it is okay to allocate memory or call this function because it might
> break RT.
> OR if netdev_mc_count() returns 1 you loop once later and this costs you
> 1us. If it returns 100, you loop 100 times and it costs how much
> additional time?
> 
> Sebastian
> 


