Return-Path: <netdev+bounces-87634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8248A3E36
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 21:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEEE281AD6
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 19:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB2253803;
	Sat, 13 Apr 2024 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ru8VJJ66"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EB1758B
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713036273; cv=none; b=CdCmrM27asS4EO6vRxZRN2MIX5Lc16jcajWH9fQRNceriCoUfo/uyHNs33w1VXslLo3anoDY56K7+Inv8eAfx5jpYM3fP8O8gpmrHXTivgYDRBiYLakcm1jT/b8sfSIoBODqAVJO8nbQHh70UFMDOp+8igGVkuC5qsvAlHyNte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713036273; c=relaxed/simple;
	bh=0s5EG597TObH3SM1X1Vm5616HIMqG1Wi/nMhMkf22ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVXQTigMCwrY96Rzw8ZUEvOzvn0utrQzKl5XGFBouSVoZ294jYb0xdON58DwfE46QyTl6LR3XZPtaunhhLRdN3p6vnt3QyBs77uouGGqygKKv9VA952IG1hanTfEqtA+G0JOD66h7UbIBh4K4v0VeMFtH+USjc/0ahdONSHTCGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ru8VJJ66; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78ecacab93bso147387485a.3
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 12:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1713036269; x=1713641069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h6U5jQ7dp/zS0PtKBZkJYYIOAiBOYZXuvmBnqBTZVc0=;
        b=ru8VJJ66prV/ABxI0DYwZ63WBcaaSf3BNytWw1A4L/6JyB1NYG2/joZ0LvTnKW6NZk
         TTJh9oC0Sgo9vG0nA46LNRdo7biS/uuelwA6ESiqDNsDSasYp2I+RS/jXoqEACg5bXm1
         pnmH/y7CMPQavcl81ECUUpq8tiA68OfmsmYu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713036269; x=1713641069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6U5jQ7dp/zS0PtKBZkJYYIOAiBOYZXuvmBnqBTZVc0=;
        b=pSeqIYe6l0JzDmGYEHfY6uDtx4mtvJmgRiPSm7zTMi2ZTNNp+URorBfrQoE9E2mYY1
         +w9ZOTQv3SEGNWEkZpwyRXDeELgc+qxonPYBdtvAjKLIL+oTb1anSBOFCGL1TOkN5DbJ
         N9IOq904D+aMsqI0z4RTsW+Ms40JrPfEOBFMP62Lhkha+fLQ0JSdATKMBGCinSh14LRS
         R7F8Gs6T75BN2M9vsG+E3XHRx716Gf+xt9A6UI8O9PXB+Z2Wc/33rcLGSBAJ61FKwkAl
         XLq322omKZpQhlYo8vFfh70zwl46BMxDc1hGk8QXpgBCVP6U4/YNhvW4nJg0SomNvuoU
         mMjA==
X-Forwarded-Encrypted: i=1; AJvYcCVT117gi/dFCuz4z86FpkXALaC7uVGxt3/hC32Ke9Xo/h+/aTfRjWEXWEHZjk8FtuNXbx6Teq/9NSRpfcOA9KdS+S+ELB6x
X-Gm-Message-State: AOJu0YwteODp0jkMYnfiFmzmi2CZEx62A1WqxqVaCevTh1omN0Aeezd/
	UnLHGEKjTTn1R3H181LByGfVUkffPMNiBS/6r5Ws/2fTF/1NtpLnqrL5ynjj914=
X-Google-Smtp-Source: AGHT+IHEXGY9Gr4cajSLUAHRJBa+Fcg2ioygYaR2ysVN6dcQS0NWWrf0Y8W3a/4jXLRAJ4FhFfXaHA==
X-Received: by 2002:a05:620a:4091:b0:78e:d6b8:48d3 with SMTP id f17-20020a05620a409100b0078ed6b848d3mr3126712qko.5.1713036269443;
        Sat, 13 Apr 2024 12:24:29 -0700 (PDT)
Received: from LQ3V64L9R2 ([74.92.140.241])
        by smtp.gmail.com with ESMTPSA id ou5-20020a05620a620500b0078d5b3b5b4asm4089248qkn.125.2024.04.13.12.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 12:24:28 -0700 (PDT)
Date: Sat, 13 Apr 2024 15:24:26 -0400
From: Joe Damato <jdamato@fastly.com>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, sridhar.samudrala@intel.com,
	nalramli@fastly.com, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [intel-next 1/2] net/i40e: link NAPI instances to queues and IRQs
Message-ID: <Zhrb6qJAoTYks2lK@LQ3V64L9R2>
References: <20240410043936.206169-1-jdamato@fastly.com>
 <20240410043936.206169-2-jdamato@fastly.com>
 <bb0fbd29-c098-4a62-9217-c9fd1a450250@intel.com>
 <ZhckCOFplMR0GMjr@LQ3V64L9R2>
 <f6a3f010-8fb5-4494-9ef0-23501ea01f64@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a3f010-8fb5-4494-9ef0-23501ea01f64@intel.com>

On Thu, Apr 11, 2024 at 04:02:37PM -0700, Nambiar, Amritha wrote:
> On 4/10/2024 4:43 PM, Joe Damato wrote:
> > On Wed, Apr 10, 2024 at 02:10:52AM -0700, Nambiar, Amritha wrote:
> > > On 4/9/2024 9:39 PM, Joe Damato wrote:
> > > > Make i40e compatible with the newly added netlink queue GET APIs.
> > > > 
> > > > $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
> > > >     --do queue-get --json '{"ifindex": 3, "id": 1, "type": "rx"}'
> > > > 
> > > > {'id': 1, 'ifindex': 3, 'napi-id': 162, 'type': 'rx'}
> > > > 
> > > > $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
> > > >     --do napi-get --json '{"id": 162}'
> > > > 
> > > > {'id': 162, 'ifindex': 3, 'irq': 136}
> > > > 
> > > > The above output suggests that irq 136 was allocated for queue 1, which has
> > > > a NAPI ID of 162.
> > > > 
> > > > To double check this is correct, the IRQ to queue mapping can be verified
> > > > by checking /proc/interrupts:
> > > > 
> > > > $ cat /proc/interrupts  | grep 136\: | \
> > > >     awk '{print "irq: " $1 " name " $76}'
> > > > 
> > > > irq: 136: name i40e-vlan300-TxRx-1
> > > > 
> > > > Suggests that queue 1 has IRQ 136, as expected.
> > > > 
> > > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > > ---
> > > >    drivers/net/ethernet/intel/i40e/i40e.h      |  2 +
> > > >    drivers/net/ethernet/intel/i40e/i40e_main.c | 58 +++++++++++++++++++++
> > > >    drivers/net/ethernet/intel/i40e/i40e_txrx.c |  4 ++
> > > >    3 files changed, 64 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> > > > index 2fbabcdb5bb5..5900ed5c7170 100644
> > > > --- a/drivers/net/ethernet/intel/i40e/i40e.h
> > > > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> > > > @@ -1267,6 +1267,8 @@ int i40e_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
> > > >    int i40e_open(struct net_device *netdev);
> > > >    int i40e_close(struct net_device *netdev);
> > > >    int i40e_vsi_open(struct i40e_vsi *vsi);
> > > > +void i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
> > > > +			 enum netdev_queue_type type, struct napi_struct *napi);
> > > >    void i40e_vlan_stripping_disable(struct i40e_vsi *vsi);
> > > >    int i40e_add_vlan_all_mac(struct i40e_vsi *vsi, s16 vid);
> > > >    int i40e_vsi_add_vlan(struct i40e_vsi *vsi, u16 vid);
> > > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > index 0bdcdea0be3e..6384a0c73a05 100644
> > > > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > @@ -3448,6 +3448,58 @@ static struct xsk_buff_pool *i40e_xsk_pool(struct i40e_ring *ring)
> > > >    	return xsk_get_pool_from_qid(ring->vsi->netdev, qid);
> > > >    }
> > > > +/**
> > > > + * __i40e_queue_set_napi - Set the napi instance for the queue
> > > > + * @dev: device to which NAPI and queue belong
> > > > + * @queue_index: Index of queue
> > > > + * @type: queue type as RX or TX
> > > > + * @napi: NAPI context
> > > > + * @locked: is the rtnl_lock already held
> > > > + *
> > > > + * Set the napi instance for the queue. Caller indicates the lock status.
> > > > + */
> > > > +static void
> > > > +__i40e_queue_set_napi(struct net_device *dev, unsigned int queue_index,
> > > > +		      enum netdev_queue_type type, struct napi_struct *napi,
> > > > +		      bool locked)
> > > > +{
> > > > +	if (!locked)
> > > > +		rtnl_lock();
> > > > +	netif_queue_set_napi(dev, queue_index, type, napi);
> > > > +	if (!locked)
> > > > +		rtnl_unlock();
> > > > +}
> > > > +
> > > > +/**
> > > > + * i40e_queue_set_napi - Set the napi instance for the queue
> > > > + * @vsi: VSI being configured
> > > > + * @queue_index: Index of queue
> > > > + * @type: queue type as RX or TX
> > > > + * @napi: NAPI context
> > > > + *
> > > > + * Set the napi instance for the queue. The rtnl lock state is derived from the
> > > > + * execution path.
> > > > + */
> > > > +void
> > > > +i40e_queue_set_napi(struct i40e_vsi *vsi, unsigned int queue_index,
> > > > +		    enum netdev_queue_type type, struct napi_struct *napi)
> > > > +{
> > > > +	struct i40e_pf *pf = vsi->back;
> > > > +
> > > > +	if (!vsi->netdev)
> > > > +		return;
> > > > +
> > > > +	if (current_work() == &pf->service_task ||
> > > > +	    test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||
> > > 
> > > I think we might need something like ICE_PREPARED_FOR_RESET which detects
> > > all kinds of resets(PFR/CORE/GLOBR). __I40E_PF_RESET_REQUESTED handles PFR
> > > only. So, this might assert for RTNL lock on CORER/GLOBR.
> > 
> > The i40e code is a bit tricky so I'm not sure about these cases. Here's
> > what it looks like to me, but hopefully Intel can weigh-in here as well.
> > 
> > As some one who is not an expert in i40e, what follows is a guess that is
> > likely wrong ;)
> > 
> > The __I40E_GLOBAL_RESET_REQUESTED case it looks to me (I could totally
> > be wrong here) that the i40e_reset_subtask calls i40e_rebuild with
> > lock_acquired = false. In this case, we want __i40e_queue_set_napi to
> > pass locked = true (because i40e_rebuild will acquire the lock for us).
> > 
> > The __I40E_CORE_RESET_REQUESTED case appears to be the same as the
> > __I40E_GLOBAL_RESET_REQUESTED case in that i40e_rebuild is called with
> > lock_acquired = false meaning we also want __i40e_queue_set_napi to pass
> > locked = true (because i40e_rebuild will acquire the lock for us).
> > 
> > __I40E_PF_RESET_REQUESTED is more complex.
> > 
> > It seems:
> >            When the __I40E_PF_RESET_REQUESTED bit is set in:
> >              - i40e_handle_lldp_event
> >              - i40e_tx_timeout
> >              - i40e_intr
> >              - i40e_resume_port_tx
> >              - i40e_suspend_port_tx
> >              - i40e_hw_dcb_config
> > 
> >            then: i40e_service_event_schedule is called which queues
> >            i40e_service_task, which calls i40e_reset_subtask, which
> >            clears the __I40E_PF_RESET_REQUESTED bit and calls
> >            i40e_do_reset passing lock_acquired = false. In the
> >            __I40E_PF_RESET_REQUESTED case, i40e_reset_and_rebuild
> > 	  called with lock_acquired = false again and passed through to
> > 	  i40e_rebuild which will take rtnl on its own. This means
> >            in these cases, __i40e_queue_set_napi can pass locked = true.
> > 
> >            However...
> > 
> >              - i40e_set_features
> >              - i40e_ndo_bridge_setlink
> >              - i40e_create_queue_channel
> >              - i40e_configure_queue_channels
> >              - Error case in i40e_vsi_open
> > 
> >            call i40e_do_reset directly and pass lock_acquired = true so
> >            i40e_reset_and_rebuild will not take the RTNL.
> > 
> > 	  Important assumption: I assume that passing lock_acquired = true
> > 	  means that the lock really was previously acquired (and not simply
> > 	  unnecessary and not taken ?).
> > 
> > 	  If that is correct, then __i40e_queue_set_napi should also not take the rtnl (e.g.
> >            locked = true).
> > 
> > Again, I could be totally off here, but it looks like when:
> > 
> >    (current_work() == &pf->service_task) && test_bit(__I40E_PF_RESET_REQUESTED, pf->state)
> > 
> > is true, we want to call __i40e_queue_set_napi with locked = true,
> > 
> > and also all the other cases we want __i40e_queue_set_napi with locked = true
> > 
> > > > +	    test_bit(__I40E_DOWN, pf->state) ||
> > > > +	    test_bit(__I40E_SUSPENDED, pf->state))
> > > > +		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
> > > > +				      false);
> > > > +	else
> > > > +		__i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
> > > > +				      true);
> > 
> > I *think* (but honestly... I have no idea) the correct if statement *might* be
> > something like:
> > 
> >    /* __I40E_PF_RESET_REQUESTED via the service_task will
> >     * call i40e_rebuild with lock_acquired = false, causing rtnl to be
> >     * taken, meaning __i40e_queue_set_napi should *NOT* take the lock.
> >     *
> >     * __I40E_PF_RESET_REQUESTED when set directly and not via the
> >     * service task, i40e_reset is called with lock_acquired = true,
> >     * implying that the rtnl was already taken (and, more
> >     * specifically, the lock was not simply unnecessary and skipped)
> >     * and so __i40e_queue_set_napi should *NOT* take the lock.
> >     *
> >     * __I40E_GLOBAL_RESET_REQUESTED and __I40E_CORE_RESET_REQUESTED
> >     * trigger the service_task (via i40e_intr) which will cause
> >     * i40e_rebuild to acquire rtnl and so __i40e_queue_set_napi should
> >     * not acquire it.
> >     */
> >    if (current_work() == &pf->service_task ||
> >        test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||
> >        test_bit(__I40E_GLOBAL_RESET_REQUESTED, pf->state) ||
> >        test_bit(__I40E_CORE_RESET_REQUESTED, pf->state))
> >            __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
> >                                  true);
> >    else if (test_bit(__I40E_DOWN, pf->state) ||
> >             test_bit(__I40E_SUSPENDED, pf->state))
> >            __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
> >                                  false);
> >    else
> >            __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
> >                                  true);
> > 
> > I suppose to figure this out, I'd need to investigate all cases where
> > i40e_rebuild is called with lock_acquired = true to ensure that the lock was
> > actually acquired (and not just unnecessary).
> > 
> > Unless some one who knows about i40e can answer this question more
> > definitively.
> > 
> 
> I'll wait for the i40e maintainers to chime in here.

Based on the findings of I40E_SUSPENDED below, the above if statement is
still slightly incorrect, please see below.

> > > > +}
> > > > +
> > > >    /**
> > > >     * i40e_configure_tx_ring - Configure a transmit ring context and rest
> > > >     * @ring: The Tx ring to configure
> > > > @@ -3558,6 +3610,8 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
> > > >    	/* cache tail off for easier writes later */
> > > >    	ring->tail = hw->hw_addr + I40E_QTX_TAIL(pf_q);
> > > > +	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_TX,
> > > > +			    &ring->q_vector->napi);
> > > 
> > > I am not sure very sure of this, have you tested this for the reset/rebuild
> > > path as well (example: ethtool -L and change queues). Just wondering if this
> > > path is taken for first time VSI init or additionally for any VSI rebuilds
> > > as well.
> > 
> > Can you explain more about what your concern is? I'm not sure I follow.
> > Was the concern just that on rebuild this code path might not be
> > executed because the driver might take a different path?
> > 
> > If so, I traced the code (and tested with ethtool):
> > 
> > When the device is probed:
> > 
> > i40e_probe
> >    i40e_vsi_open
> >      i40e_vsi_configure
> >        i40e_vsi_configure_rx
> >          i40e_configure_rx_ring
> >        i40e_vsi_configure_tx
> >          i40e_configure_tx_ring
> > 
> > When you use ethtool to change the channel count:
> > 
> > i40e_set_channels
> >    i40e_reconfig_rss_queues
> >      i40e_reset_and_rebuild
> >        i40e_rebuild
> >          i40e_pf_unquiesce_all_vsi
> >            i40e_unquiesce_vsi
> >              i40e_vsi_open
> >                [.. the call stack above for i40e_vsi_open ..]
> > 
> > Are those the two paths you had in mind or were there other ones? FWIW, using
> > ethtool to change the channel count followed by using the cli.py returns what
> > appears to be correct data, so I think the ethtool -L case is covered.
> > 
> 
> Yes, this is what I had mind. Good to know that it is covered.

Thanks for the thorough review; I appreciate your insight. The more I look
at the i40e code paths, the more I realize that it is much trickier than I
originally thought.

> > Let me know if I am missing any cases you had in mind or if this answers your
> > question.
> > 
> 
> One other case was the suspend/resume callback. This path involves remapping
> vectors and rings (just like rebuild after changing channels), If this takes
> the i40e_rebuild path like before, then we are covered, as your changes are
> in i40e_vsi_configure. If not, we'll have to add it after re-initializing
> interrupt scheme .

Here's what I see in this path, namely that i40e_suspend does not call
i40e_queue_set_napi but sets appropriate bits that can be checked.

i40e_suspend:
  __I40E_DOWN is set
  __I40E_SUSPENDED is set
  rtnl_lock
    i40e_clear_interrupt_scheme
      i40e_vsi_free_q_vectors
        i40e_free_q_vector
  rtnl_unlock

It seems in the suspend case the i40e_free_rx_resources and
i40e_free_tx_resources are not called. This means I probably missed a case
and need to call i40e_queue_set_napi to set the NAPI mapping to NULL
somewhere in here without calling it twice. See further below for my
thoughts on this.

Continuing with resume, though:

i40e_resume:
  rtnl_lock
    i40e_restore_interrupt_scheme
      i40e_vsi_alloc_q_vectors
        i40e_vsi_alloc_q_vector
    __I40E_DOWN is cleared
    i40e_reset_and_rebuild (passes lock_acquired = true)
      i40e_rebuild (passes locked_acquired = true)
   rtnl_unlock
   __I40E_SUSPENDED is cleared

So, in this case i40e_resume would want to to call __i40e_queue_set_napi
with locked = true, to avoid rtnl since it's already been taken. I think to
cover this case __I40E_SUSPENDED needs to be checked but true can be passed
to the helper to avoid taking rtnl in the helper.

This is an adjusted if statement, which is likely still incorrect in some
cases (especially when considering my comments below on the
i40e_free_[rt]x_resource paths), but maybe getting slightly closer:

  /* __I40E_PF_RESET_REQUESTED via the service_task will
   * call i40e_rebuild with lock_acquired = false, causing rtnl to be
   * taken, meaning __i40e_queue_set_napi should *NOT* take the lock.
   *
   * __I40E_PF_RESET_REQUESTED when set directly and not via the
   * service task, i40e_reset is called with lock_acquired = true,
   * implying that the rtnl was already taken (and, more
   * specifically, the lock was not simply unnecessary and skipped)
   * and so __i40e_queue_set_napi should *NOT* take the lock.
   *
   * __I40E_GLOBAL_RESET_REQUESTED and __I40E_CORE_RESET_REQUESTED
   * trigger the service_task (via i40e_intr) which will cause
   * i40e_rebuild to acquire rtnl and so __i40e_queue_set_napi should
   * not acquire it.
   *
   * __I40E_SUSPENDED is set in i40e_suspend and cleared in i40e_resume
   * after rtnl_lock + i40_rebuild (with lock_acquired = true). In
   * i40e_resume's call to i40e_rebuild, rtnl is held so
   * __i40e_queue_set_napi should not take the lock, either.
   *
   * __I40E_IN_REMOVE is set in i40e_remove, and freeing the tx/rx
   * resources will trigger this path. In this case, rtnl will not be held,
   * so locked=false must be passed to the helper.
   *
   * __I40E_DOWN is set in a few places: i40e_probe, i40e_remove,
   * i40e_shutdown, i40e_suspend. It is only cleared in i40e_probe after
   * the vsi_open path is taken (in this case rtnl is needed) and it is
   * cleared in i40e_resume, where RTNL is not needed, but the i40e_resume
   * case is handled by checking __I40E_SUSPENDED in the first if block. 
   */
  if (current_work() == &pf->service_task ||
      test_bit(__I40E_PF_RESET_REQUESTED, pf->state) ||
      test_bit(__I40E_GLOBAL_RESET_REQUESTED, pf->state) ||
      test_bit(__I40E_CORE_RESET_REQUESTED, pf->state) |
      test_bit(__I40E_SUSPENDED, pf->state))
          __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
                                true);
  else if (test_bit(__I40E_IN_REMOVE, pf->state) ||
           test_bit(__I40E_DOWN, pf->state))
          __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
                                false);
  else
          __i40e_queue_set_napi(vsi->netdev, queue_index, type, napi,
                                true);


But please see below about i40e_free_q_vector.

> > > >    	return 0;
> > > >    }
> > > > @@ -3716,6 +3770,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
> > > >    			 ring->queue_index, pf_q);
> > > >    	}
> > > > +	i40e_queue_set_napi(vsi, ring->queue_index, NETDEV_QUEUE_TYPE_RX,
> > > > +			    &ring->q_vector->napi);
> > > > 
> > > Same as above.
> > > 
> > >    	return 0;
> > > >    }
> > > > @@ -4178,6 +4234,8 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
> > > >    		q_vector->affinity_notify.notify = i40e_irq_affinity_notify;
> > > >    		q_vector->affinity_notify.release = i40e_irq_affinity_release;
> > > >    		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
> > > > +		netif_napi_set_irq(&q_vector->napi, q_vector->irq_num);
> > > > +
> > > >    		/* Spread affinity hints out across online CPUs.
> > > >    		 *
> > > >    		 * get_cpu_mask returns a static constant mask with
> > > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > > > index 64d198ed166b..d380885ff26d 100644
> > > > --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > > > +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > > > @@ -821,6 +821,8 @@ void i40e_clean_tx_ring(struct i40e_ring *tx_ring)
> > > >    void i40e_free_tx_resources(struct i40e_ring *tx_ring)
> > > >    {
> > > >    	i40e_clean_tx_ring(tx_ring);
> > > > +	i40e_queue_set_napi(tx_ring->vsi, tx_ring->queue_index,
> > > > +			    NETDEV_QUEUE_TYPE_TX, NULL);
> > > >    	kfree(tx_ring->tx_bi);
> > > >    	tx_ring->tx_bi = NULL;
> > > > @@ -1526,6 +1528,8 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
> > > >    void i40e_free_rx_resources(struct i40e_ring *rx_ring)
> > > >    {
> > > >    	i40e_clean_rx_ring(rx_ring);
> > > > +	i40e_queue_set_napi(rx_ring->vsi, rx_ring->queue_index,
> > > > +			    NETDEV_QUEUE_TYPE_RX, NULL);

It appears to me that some cases may not end up calling
i40e_free_tx_resources or i40e_free_rx_resources, but most (or all?) cases
do call i40e_free_q_vector which is where the NAPI is deleted.

It probably makes more sense to put the NULL setting where the NAPI delete
happens, and then check those paths to see where rtnl is taken and make
sure the bit checking in the if statement lines up properly.

Before I go any deeper down this rabbit hole, I'll wait to see what the
i40e maintainers say / think about this.

> > > >    	if (rx_ring->vsi->type == I40E_VSI_MAIN)
> > > >    		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
> > > >    	rx_ring->xdp_prog = NULL;

