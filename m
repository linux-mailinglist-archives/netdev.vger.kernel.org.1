Return-Path: <netdev+bounces-167381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9532AA3A093
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9723A3EB6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900AE26A0AA;
	Tue, 18 Feb 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMQG9iKj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9672269B09
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890270; cv=none; b=c9ah6Yn4k5SUWfV26cHbajtZWFS1DoIqEzadyRYErHyAom+NzGVdCIQWVI/BcgfzqAJlWHk6EFMjvUs7oNaDDGyeCs5XNq3I1jjCUFLp3x0uAR6+ThBx0jQRae65CWvb9ML4+hqWy/LLi5aiTNses1FygZc7H535gIuD/rTHY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890270; c=relaxed/simple;
	bh=FMuFpPTBrULyxxvvxScPtLJI8/8wvMCaBKpNi9ZMeeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0SLwn4sKZURRU+WShjtTudY60HYAq2J/2yH8PIDikMT09hw5m4D+yIqjPsXwi9QRFY1HjtTGQNmlio0d8XOeE9RXmWxhtW8iUHnemPnVby2V+Jw2gkl2ZJ7iEolWmJeO1D8gXGph3jHuNkAnZSb3z8SF6ROWUMbS4MX9zgnnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMQG9iKj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6P2MEIvA9QOWntvXPcVC8OsToDuqqnrKzzMn7bgw/xo=;
	b=hMQG9iKjzvmdWUG3EnIr4+rWkY64N02o1kJIdnPYj/wBxAu9yeFLRBek3pQ2LoGTLmlT8z
	NZLjVfLMMhyq3SOgUSls5xhqoxb1FCYOhd9uzqMWpp9TINQ+A7Uo3aiC2+6wzMy+iYmlw6
	Y4cYcoFFWwCj5i5rSDziQn4xB+CR9fk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-3tB38lxtPEuVwP3b1bm93A-1; Tue,
 18 Feb 2025 09:51:04 -0500
X-MC-Unique: 3tB38lxtPEuVwP3b1bm93A-1
X-Mimecast-MFC-AGG-ID: 3tB38lxtPEuVwP3b1bm93A_1739890263
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CB2618D9599;
	Tue, 18 Feb 2025 14:51:02 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.153])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DA0FB1956094;
	Tue, 18 Feb 2025 14:50:56 +0000 (UTC)
Date: Tue, 18 Feb 2025 11:50:55 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, rostedt@goodmis.org, clrkwllms@kernel.org, jgarzik@redhat.com, 
	yuma@redhat.com, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de>
 <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de>
 <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de>
 <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
 <20250212152925.M7otWPiV@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212152925.M7otWPiV@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Feb 12, 2025 at 04:29:25PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-12 12:21:04 [-0300], Wander Lairson Costa wrote:
> > > "eventually fails". Does this mean it passes the first few iterations
> > > but then it times out? In that case it might be something else
> > >
> > Yes. Indeed, might be due something else. I will perform further investigation
> > when I get the machine back.
> 
> Okay. Then I consider this series not going to be applied, I have an
> idea what is happening and I wait until you get back.
> 

Sorry it took so long. After a day fighting the machine I could boot an
upstream kernel on it and generate the logs.

These logs are for the test case of booting the kernel with nr_cpus=1:

     kworker/0:0-8       [000] d..2.  2120.708145: process_one_work <-worker_thread
     kworker/0:0-8       [000] ...1.  2120.708145: igbvf_reset_task <-process_one_work
     kworker/0:0-8       [000] ...1.  2120.708145: igbvf_reinit_locked <-process_one_work
     kworker/0:0-8       [000] ...1.  2120.708145: igbvf_down <-igbvf_reinit_locked
     kworker/0:0-8       [000] ...1.  2120.718619: igbvf_update_stats <-igbvf_down
     kworker/0:0-8       [000] ...1.  2120.718619: igbvf_reset <-igbvf_down
     kworker/0:0-8       [000] b..13  2120.718620: e1000_reset_hw_vf <-igbvf_reset
     kworker/0:0-8       [000] b..13  2120.718620: e1000_check_for_rst_vf <-e1000_reset_hw_vf
     kworker/0:0-8       [000] b..13  2120.718621: e1000_write_posted_mbx <-e1000_reset_hw_vf
     kworker/0:0-8       [000] b..13  2120.718621: e1000_write_mbx_vf <-e1000_write_posted_mbx
     kworker/0:0-8       [000] b..13  2120.718624: e1000_check_for_ack_vf <-e1000_write_posted_mbx
     kworker/0:0-8       [000] D.h.3  2120.718626: irq_handler_entry: irq=63 name=ens14f0
     kworker/0:0-8       [000] b..13  2120.719133: e1000_check_for_ack_vf <-e1000_write_posted_mbx
	[...] repeats e1000_check_for_ack_vf for 2000 lines
     kworker/0:0-8       [000] b..13  2120.719634: e1000_check_for_ack_vf <-e1000_write_posted_mbx
     kworker/0:0-8       [000] b..13  2121.730639: e1000_read_posted_mbx <-e1000_reset_hw_vf
     kworker/0:0-8       [000] b..13  2121.730643: e1000_init_hw_vf <-igbvf_reset
     kworker/0:0-8       [000] b..13  2121.730643: e1000_rar_set_vf <-e1000_init_hw_vf
     kworker/0:0-8       [000] b..13  2121.730643: e1000_write_posted_mbx <-e1000_rar_set_vf
     kworker/0:0-8       [000] D.Zf2  2121.730645: igbvf_reset_L14: (igbvf_reset+0x62/0x120 [igbvf])
     kworker/0:0-8       [000] .N...  2121.730649: igbvf_reset_L16: (igbvf_reset+0x7b/0x120 [igbvf])
  irq/63-ens14f0-1112    [000] b..12  2121.730652: igb_msix_other <-irq_thread_fn
  irq/63-ens14f0-1112    [000] b..12  2121.730652: igb_rd32 <-igb_msix_other
  irq/63-ens14f0-1112    [000] b..13  2121.730653: igb_check_for_rst <-igb_msix_other
  irq/63-ens14f0-1112    [000] b..13  2121.730653: igb_check_for_rst_pf <-igb_msix_other

I created two custom probes inside igbvf_reset:

$ perf probe -m /lib/modules/6.14.0-rc3+/kernel/drivers/net/ethernet/intel/igbvf/igbvf.ko -L igbvf_reset
<igbvf_reset@/home/test/kernel-ark/drivers/net/ethernet/intel/igbvf/netdev.c:0>
      0  static void igbvf_reset(struct igbvf_adapter *adapter)
         {
      2         struct e1000_mac_info *mac = &adapter->hw.mac;
                struct net_device *netdev = adapter->netdev;
                struct e1000_hw *hw = &adapter->hw;
         
                spin_lock_bh(&hw->mbx_lock);
         
                /* Allow time for pending master requests to run */
      9         if (mac->ops.reset_hw(hw))
     10                 dev_info(&adapter->pdev->dev, "PF still resetting\n");
         
     12         mac->ops.init_hw(hw);
         
     14         spin_unlock_bh(&hw->mbx_lock);
         
     16         if (is_valid_ether_addr(adapter->hw.mac.addr)) {
     17                 eth_hw_addr_set(netdev, adapter->hw.mac.addr);
     18                 memcpy(netdev->perm_addr, adapter->hw.mac.addr,
                               netdev->addr_len);
                }
         
     22         adapter->last_reset = jiffies;
         }
         
         int igbvf_up(struct igbvf_adapter *adapter)

$ perf probe -m /lib/modules/6.14.0-rc3+/kernel/drivers/net/ethernet/intel/igbvf/igbvf.ko igbvf_reset:14
Added new event:
  probe:igbvf_reset_L14 (on igbvf_reset:14 in igbvf)

You can now use it in all perf tools, such as:

        perf record -e probe:igbvf_reset_L14 -aR sleep 1

$ perf probe -m /lib/modules/6.14.0-rc3+/kernel/drivers/net/ethernet/intel/igbvf/igbvf.ko igbvf_reset:16
Added new event:
  probe:igbvf_reset_L16 (on igbvf_reset:16 in igbvf)

They are intended to monitor the effect of spin_unlock_bh().

This is the trace-cmd command line I ran:

$ trace-cmd start -p function -l 'e1000*' -l 'igb*' -l process_one_work -e irq:irq_handler_entry -e probe
  plugin 'function'

The threaded interrupt handler is called right after (during?)
spin_unlock_bh(). I wonder what the 'f' means in the preempt-count
field there.

I am currently working on something else that has a higher priority, so
I don't have time right now to go deeper on that. But feel free to ask
me for any test or trace you may need.

> Sebastian
> 


