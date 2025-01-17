Return-Path: <netdev+bounces-159301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B0A1505D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502F23A5EED
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB731FF1C3;
	Fri, 17 Jan 2025 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJ9lbKs8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247825A627
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120000; cv=none; b=HEkS+6kbi46cXfxLfrEKDPnBSaPZ0CtAbHv3+ucQpCx9hnF2AGVwzIDcq7V0oQG1HBY/JF0icggcpkpIwLWLZs6L+0omzeY+1ykOJVKp8LIDU6fuhWdOgpEjxXydORZSZ84mq/h7GfRvg/E/UBvR2LHMah32SvYzqi9C1Gg90Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120000; c=relaxed/simple;
	bh=5hrHI4tvyKGzcE04uCoclEOaXVYOD9n2OJ8uELCswXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryiFhe1dnD7AzxLs9VAgEQGlLWv3wJ/YhHxYJOZACqzkrSZ8LIbl8ruCKKLO7pV6imxXtbs7rObURnV9/sljPNe4qxTvAzjYT8qUcIpznabQyo2syPiUoc+KiV6OE76+2aATL+5YfPpmOz9Wy8q1R8GpCwApz1t668KVu0DHFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJ9lbKs8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737119997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMt7H4uJupL0n7CmNDQGQgqsD0sjSTEnlM24sJ8421I=;
	b=YJ9lbKs8pwAPL6tspj8O7mXfQCaF/tL0j51TROSOHgToScw2ufvgTuJXkKXhSX0Sor7iv1
	ZaDhC06a1nNRY04XrO8n5rrcFQ94sm2Dtk5qdxPDa/RzL3w8Xn4xtD1+KslENvvLUF3P5Q
	siQJ5FIphusermgSqX9y7WH74vrYxhk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-4YfPpel6PlyvLf1pr5dEYQ-1; Fri,
 17 Jan 2025 08:19:56 -0500
X-MC-Unique: 4YfPpel6PlyvLf1pr5dEYQ-1
X-Mimecast-MFC-AGG-ID: 4YfPpel6PlyvLf1pr5dEYQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13E32195606B;
	Fri, 17 Jan 2025 13:19:53 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.120])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D8F719560BF;
	Fri, 17 Jan 2025 13:19:46 +0000 (UTC)
Date: Fri, 17 Jan 2025 10:19:44 -0300
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
Message-ID: <givxfwonfer5kgowuxuz4bezxkhri4ottnmlmh3duhan3viznb@ic5sscp2twit>
References: <20241204114229.21452-1-wander@redhat.com>
 <20250107135106.WWrtBMXY@linutronix.de>
 <taea3z7nof4szjir2azxsjtbouymqxyy4draa3hz35zbacqeeq@t3uidpha64k7>
 <20250108102532.VWnKWvoo@linutronix.de>
 <CAAq0SUnoS45Fctkzj4t4OxT=9qm9Bg8zu79=S3DUL_jcoLbC-A@mail.gmail.com>
 <20250109174512.At7ZERjU@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109174512.At7ZERjU@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Jan 09, 2025 at 06:45:12PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-01-09 13:46:47 [-0300], Wander Lairson Costa wrote:
> > > If the issue is indeed the use of threaded interrupts then the fix
> > > should not be limited to be PREEMPT_RT only.
> > >
> > Although I was not aware of this scenario, the patch should work for it as well,
> > as I am forcing it to run in interrupt context. I will test it to confirm.

I tested with the stock kernel with threadirqs and the problem does show up.
Applying the patches the issue is gone.

> 
> If I remember correctly there were "ifdef preempt_rt" things in it.

That exists only to handle the case in which part in which the ISR needs to
partially run in thread context (because the piece of code calling kmalloc),
so I need an sleeping lock for that. For non-PREEMPT_RT, we don't have this
constrain.

> 
> > > > > - What causes the failure? I see you reworked into two parts to behave
> > > > >   similar to what happens without threaded interrupts. There is still no
> > > > >   explanation for it. Is there a timing limit or was there another
> > > > >   register operation which removed the mailbox message?
> > > > >
> > > >
> > > > I explained the root cause of the issue in the last commit. Maybe I should
> > > > have added the explanation to the cover letter as well.  Anyway, here is a
> > > > partial verbatim copy of it:
> > > >
> > > > "During testing of SR-IOV, Red Hat QE encountered an issue where the
> > > > ip link up command intermittently fails for the igbvf interfaces when
> > > > using the PREEMPT_RT variant. Investigation revealed that
> > > > e1000_write_posted_mbx returns an error due to the lack of an ACK
> > > > from e1000_poll_for_ack.
> > >
> > > That ACK would have come if it would poll longer?

No, the poll happens while preemption is disabled.

> > >
> > No, the service wouldn't be serviced while polling.

s/service/interrupt/. Since we can't sleep at this context, there is
no way to wait for an event.

> 
> Hmm. 


> 
> > > > The underlying issue arises from the fact that IRQs are threaded by
> > > > default under PREEMPT_RT. While the exact hardware details are not
> > > > available, it appears that the IRQ handled by igb_msix_other must
> > > > be processed before e1000_poll_for_ack times out. However,
> > > > e1000_write_posted_mbx is called with preemption disabled, leading
> > > > to a scenario where the IRQ is serviced only after the failure of
> > > > e1000_write_posted_mbx."
> > >
> > > Where is this disabled preemption coming from? This should be one of the
> > > ops.write_posted() calls, right? I've been looking around and don't see
> > > anything obvious.
> > 
> > I don't remember if I found the answer by looking at the code or by
> > looking at the ftrace flags.
> > I am currently on sick leave with covid. I can check it when I come back.
> 
> Don't worry, get better first. I'm kind of off myself. I'm not sure if I
> have the hardware needed to setup so I can look at it…
> 

The reason of why you didn't find is because the interrupt in the igb
driver is triggered inside the igbvf code. igbvf_reset() calls
spin_lock_bh() [1], although in the cases I found it was already called
with preemption disabled from process_one_work() (workqueue) and netlink_sendmsg().

Here is an ftrace log for the failure case:

kworker/-86      0...1    85.381866: function:                   igbvf_reset
kworker/-86      0...2    85.381866: function:                      e1000_reset_hw_vf
kworker/-86      0...2    85.381867: function:                         e1000_check_for_rst_vf
kworker/-86      0...2    85.381868: function:                         e1000_write_posted_mbx
kworker/-86      0...2    85.381868: function:                            e1000_write_mbx_vf
kworker/-86      0...2    85.381870: function:                            e1000_check_for_ack_vf // repeats for 2000 lines
...
kworker/-86      0.N.2    86.393782: function:                         e1000_read_posted_mbx
kworker/-86      0.N.2    86.398606: function:                      e1000_init_hw_vf
kworker/-86      0.N.2    86.398606: function:                         e1000_rar_set_vf
kworker/-86      0.N.2    86.398606: function:                            e1000_write_posted_mbx
irq/65-e-1287    0d..1    86.398609: function:             igb_msix_other
irq/65-e-1287    0d..1    86.398609: function:                igb_rd32
irq/65-e-1287    0d..2    86.398610: function:                igb_check_for_rst
irq/65-e-1287    0d..2    86.398610: function:                igb_check_for_rst_pf
irq/65-e-1287    0d..2    86.398610: function:                   igb_rd32
irq/65-e-1287    0d..2    86.398611: function:                igb_check_for_msg
irq/65-e-1287    0d..2    86.398611: function:                igb_check_for_msg_pf
irq/65-e-1287    0d..2    86.398611: function:                   igb_rd32
irq/65-e-1287    0d..2    86.398612: function:                igb_rcv_msg_from_vf
irq/65-e-1287    0d..2    86.398612: function:                   igb_read_mbx
irq/65-e-1287    0d..2    86.398612: function:                   igb_read_mbx_pf
irq/65-e-1287    0d..2    86.398612: function:                      igb_obtain_mbx_lock_pf
irq/65-e-1287    0d..2    86.398612: function:                         igb_rd32

Notice the interrupt handler only executes after e1000_write_posted()
returns. And here it is for the sucessful case:

      ip-5603    0...1  1884.710747: function:             igbvf_reset
      ip-5603    0...2  1884.710754: function:                e1000_reset_hw_vf
      ip-5603    0...2  1884.710755: function:                   e1000_check_for_rst_vf
      ip-5603    0...2  1884.710756: function:                   e1000_write_posted_mbx
      ip-5603    0...2  1884.710756: function:                      e1000_write_mbx_vf
      ip-5603    0...2  1884.710758: function:                      e1000_check_for_ack_vf
      ip-5603    0d.h2  1884.710760: function:             igb_msix_other
      ip-5603    0d.h2  1884.710760: function:                igb_rd32
      ip-5603    0d.h3  1884.710761: function:                igb_check_for_rst
      ip-5603    0d.h3  1884.710761: function:                igb_check_for_rst_pf
      ip-5603    0d.h3  1884.710761: function:                   igb_rd32
      ip-5603    0d.h3  1884.710762: function:                igb_check_for_msg
      ip-5603    0d.h3  1884.710762: function:                igb_check_for_msg_pf
      ip-5603    0d.h3  1884.710762: function:                   igb_rd32
      ip-5603    0d.h3  1884.710763: function:                igb_rcv_msg_from_vf
      ip-5603    0d.h3  1884.710763: function:                   igb_read_mbx
      ip-5603    0d.h3  1884.710763: function:                   igb_read_mbx_pf
      ip-5603    0d.h3  1884.710763: function:                      igb_obtain_mbx_lock_pf
      ip-5603    0d.h3  1884.710763: function:                         igb_rd32

The ISR executes immediately fater e1000_write_mbx_vf().

[1] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/net/ethernet/intel/igbvf/netdev.c#L1522

> Sebastian
> 


