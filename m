Return-Path: <netdev+bounces-270924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGzoKdBGwmnvbAQAu9opvQ
	(envelope-from <netdev+bounces-270924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:09:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F343045EC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 09:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CA5C304EF32
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 08:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38753C141E;
	Tue, 24 Mar 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nd/N/cIZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB243ACEF2
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339695; cv=none; b=p/vgpY13So0B6cI1UszUyzjL0nbC9GX58pkA1HgmCBpIuXufUYv0wowVHC+fMpx3GRXgiskQsxOsBlr8AK/p6xVC7mfhvYEca7poBE8Hc8gc8twi8xVEfy+7iBclb2F8d8JbHu0+ZH3KLCowtB16HTz6T18tBOfRmSUq577NHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339695; c=relaxed/simple;
	bh=a0Hq7JBY/yyVd5EppgclAW0QXM78t9KIM3zMxtFXKTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qU+K+0aQQsmIdzNcWk7Jeiy+XHOX5VIGY6MuhRWIIeR/aXIAjFZoykvdSikBNOXQhdWcSwRV1YbgFpk2WOh7Bwj2YiEPYLcHw0iIt9ukCzkUFDXNqkHzskcu5lzWNKh1oFJhPtlZsyQROjB4gz089MxJp+71dVoRsTr7RZ9oSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nd/N/cIZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 636661A2FC2;
	Tue, 24 Mar 2026 08:08:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D6606011D;
	Tue, 24 Mar 2026 08:08:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2415104510B0;
	Tue, 24 Mar 2026 09:07:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774339680; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C9n9jI+Vm/d+FY8zoyyjjBY56nBV5IDRfgK7Hbw73Uo=;
	b=nd/N/cIZqDfy+dpFekmnj0cHEJxACi2YcXLfqfIIfyGZ6ijTYqxqv0KSzHrzlDhyuLeyU5
	DKGVqFsFAONcfd5SLXz6reDbfwJb2exQP7zyvCmcaif8HhqaTuO4SeJsageiU6zntOhLoA
	mBgJ47+f5RduHOmLcq3nZdXqbImv5EwfnUL5rMgzws4OMrUlThkGxwVZWEAtdE+feH/lIc
	77T91rKg8hZelp0+JZzCSrq1QpWCc9ZxH2tI7BWaS1mVWIL7UWP6JbuEksJ2qRTS1mNG3A
	HTIPZhBNETgzgAtI9z9jGXry3wOBfZ2o7AEYhU3Gi80RKs5wtc8sW32OX/48Vg==
Date: Tue, 24 Mar 2026 09:07:52 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Arnd
 Bergmann <arnd@arndb.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 00/10] net: lan966x: add support for PCIe FDMA
Message-ID: <20260324090752.0799acb1@bootlin.com>
In-Reply-To: <20260323194059.jjphkep4teq5rzbc@DEN-DL-M70577.microsemi.net>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
	<20260323155204.0321db13@bootlin.com>
	<20260323172640.2669232d@bootlin.com>
	<20260323194059.jjphkep4teq5rzbc@DEN-DL-M70577.microsemi.net>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,arndb.de,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270924-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47F343045EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel,

On Mon, 23 Mar 2026 20:40:59 +0100
Daniel Machon <daniel.machon@microchip.com> wrote:

> Hi Hervé,
> 
> > Hi Daniel,
> > 
> > On Mon, 23 Mar 2026 15:52:04 +0100
> > Herve Codina <herve.codina@bootlin.com> wrote:
> >   
> > > Hi Daniel,
> > >
> > > On Fri, 20 Mar 2026 16:00:56 +0100
> > > Daniel Machon <daniel.machon@microchip.com> wrote:
> > >  
> > > > When lan966x operates as a PCIe endpoint, the driver currently uses
> > > > register-based I/O for frame injection and extraction. This approach is
> > > > functional but slow, topping out at around 33 Mbps on an Intel x86 host
> > > > with a lan966x PCIe card.
> > > >
> > > > This series adds FDMA (Frame DMA) support for the PCIe path. When
> > > > operating as a PCIe endpoint, the internal FDMA engine on lan966x cannot
> > > > directly access host memory, so DMA buffers are allocated as contiguous
> > > > coherent memory and mapped through the PCIe Address Translation Unit
> > > > (ATU). The ATU provides outbound windows that translate internal FDMA
> > > > addresses to PCIe bus addresses, allowing the FDMA engine to read and
> > > > write host memory. Because the ATU requires contiguous address regions,
> > > > page_pool and normal per-page DMA mappings cannot be used. Instead,
> > > > frames are transferred using memcpy between the ATU-mapped buffers and
> > > > the network stack. With this, throughput increases from ~33 Mbps to ~620
> > > > Mbps for default MTU.
> > > >
> > > > Patches 1-2 prepare the shared FDMA library: patch 1 renames the
> > > > contiguous dataptr helpers for clarity, and patch 2 adds PCIe ATU region
> > > > management and coherent DMA allocation with ATU mapping.
> > > >
> > > > Patches 3-5 refactor the lan966x FDMA code to support both platform and
> > > > PCIe paths: extracting the LLP register write into a helper, exporting
> > > > shared functions, and introducing an ops dispatch table selected at
> > > > probe time.
> > > >
> > > > Patch 6 adds the core PCIe FDMA implementation with RX/TX using
> > > > contiguous ATU-mapped buffers. Patches 7 and 8 extend it with MTU
> > > > change and XDP support respectively.
> > > >
> > > > Patches 9-10 update the lan966x PCI device tree overlay to extend the
> > > > cpu register mapping to cover the ATU register space and add the FDMA
> > > > interrupt.
> > > >  
> > >
> > > Thanks a lot for the series taking care of DMA and ATU in PCIe variants.
> > >
> > > I have tested the whole series on both my ARM and x86 systems.
> > >
> > > Doing a simple wget on my x86 system, I moved from 3.8MB/s to 11.2MB/s and
> > > so the improvement is obvious.
> > >
> > > Tested-by: Herve Codina <herve.codina@bootlin.com>
> > >  
> > 
> > Hum, I think I found an issue.
> > 
> > If I remove the lan966x_pci module (modprobe -r lan966x_pci), and reload
> > it (modprobe lan966x_pci), the board is not working.
> > 
> > The system performs DHCP requests. Those requests are served by my PC (observed
> > with Wireshark) but the system doesn't see those answers. Indeed, he continues
> > to perform DHCP requests.
> > 
> > Looks like the lan966x_pci module removal leaves the board in a bad state.
> > 
> > Without the series applied, DHCP request answers from my PC are seen by the
> > system after any module unloading / reloading.
> > 
> > Do you have any ideas of what could be wrong?
> > 
> > Best regards,
> > Hervé  
> 
> Thanks for testing this!
> 
> As part of my testing I did unload/load the lan966x_switch module to ensure the
> ATU was properly reset and reconfigured, and that seemed to work fine. I must
> admit, I did not try with the lan966x_pci module.
> 
> From what I hear, when you are in the bad state, TX is still working, so it's an
> RX issue. Could be the interrupt is not firing, so the napi poll is not
> scheduled.

Yes, confirmed that the issue is on Rx path. Tx data were received by my PC.

> 
> Anyway, I will have a look at it during the week. Will let you know.
> 

Some more interesting information.

I tested lan966x_pci module unloading and re-loading on my ARM system.

On this system the following traces are present when I reload the lan966x_pci
module. Those traces were not present on my x86 system.

    [  104.715031] ------------[ cut here ]------------
    [  104.719746] Unexpected error: 64, error_type: 1073741824
    [  104.725217] WARNING: drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:558 at lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch], CPU#0: swapper/0/0
    [  104.739119] Modules linked in: lan966x_pci irq_lan966x_oic reset_microchip_sparx5 pinctrl_ocelot lan966x_serdes mdio_mscc_miim lan966x_switch rtc_ds1307 marvell [last unloaded: lan966x_pci]
    [  104.756250] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.0.0-rc1-00010-gfa357f2a6a00 #565 PREEMPT 
    [  104.765743] Hardware name: Marvell Armada 3720 Development Board DB-88F3720-DDR3 (DT)
    [  104.773579] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    [  104.780551] pc : lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch]
    [  104.787046] lr : lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch]
    [  104.793538] sp : ffff800082a7bc00
    [  104.796860] x29: ffff800082a7bc00 x28: ffff8000819abd00 x27: ffff800081a57757
    [  104.804033] x26: ffff8000819a5d88 x25: 0000000000012400 x24: ffff800081a57758
    [  104.811205] x23: 0000000000000038 x22: ffff00000f70ec00 x21: 0000000040000000
    [  104.818376] x20: ffff00000f7a8080 x19: 0000000000000040 x18: 00000000ffffffff
    [  104.825548] x17: ffff7fff9e7d6000 x16: ffff800082a78000 x15: ffff800102a7b837
    [  104.832719] x14: 0000000000000000 x13: 0000000000000000 x12: 3031203a65707974
    [  104.839891] x11: ffff8000819ca758 x10: 0000000000000018 x9 : ffff8000819ca758
    [  104.847062] x8 : 00000000ffffefff x7 : ffff800081a22758 x6 : 00000000fffff000
    [  104.854233] x5 : ffff00001fea1588 x4 : 0000000000000000 x3 : 0000000000000027
    [  104.861404] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff8000819abd00
    [  104.868576] Call trace:
    [  104.871034]  lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch] (P)
    [  104.877531]  __handle_irq_event_percpu+0xa0/0x4c4
    [  104.882261]  handle_irq_event+0x4c/0xf8
    [  104.886117]  handle_level_irq+0xec/0x17c
    [  104.890064]  handle_irq_desc+0x40/0x58
    [  104.893831]  generic_handle_domain_irq+0x18/0x24
    [  104.898467]  lan966x_oic_irq_handler_domain+0x64/0xb0 [irq_lan966x_oic]
    [  104.905105]  lan966x_oic_irq_handler+0x34/0xb4 [irq_lan966x_oic]
    [  104.911131]  handle_irq_desc+0x40/0x58
    [  104.914900]  generic_handle_domain_irq+0x18/0x24
    [  104.919536]  pci_dev_irq_handler+0x1c/0x30 [lan966x_pci]
    [  104.924871]  __handle_irq_event_percpu+0xa0/0x4c4
    [  104.929594]  handle_irq_event+0x4c/0xf8
    [  104.933449]  handle_level_irq+0xec/0x17c
    [  104.937394]  handle_irq_desc+0x40/0x58
    [  104.941162]  generic_handle_domain_irq+0x18/0x24
    [  104.945797]  advk_pcie_irq_handler+0x160/0x390
    [  104.950260]  __handle_irq_event_percpu+0xa0/0x4c4
    [  104.954983]  handle_irq_event+0x4c/0xf8
    [  104.958839]  handle_fasteoi_irq+0x108/0x20c
    [  104.963043]  handle_irq_desc+0x40/0x58
    [  104.966811]  generic_handle_domain_irq+0x18/0x24
    [  104.971447]  gic_handle_irq+0x4c/0x110
    [  104.975214]  call_on_irq_stack+0x30/0x48
    [  104.979156]  do_interrupt_handler+0x80/0x84
    [  104.983360]  el1_interrupt+0x3c/0x60
    [  104.986959]  el1h_64_irq_handler+0x18/0x24
    [  104.991076]  el1h_64_irq+0x6c/0x70
    [  104.994495]  default_idle_call+0x80/0x138 (P)
    [  104.998870]  do_idle+0x220/0x290
    [  105.002121]  cpu_startup_entry+0x34/0x3c
    [  105.006064]  rest_init+0xf8/0x188
    [  105.009398]  start_kernel+0x818/0x8ec
    [  105.013085]  __primary_switched+0x88/0x90
    [  105.017119] irq event stamp: 60740
    [  105.020529] hardirqs last  enabled at (60739): [<ffff800080fb37bc>] default_idle_call+0x7c/0x138
    [  105.029328] hardirqs last disabled at (60740): [<ffff800080fab5c4>] enter_from_kernel_mode+0x10/0x3c
    [  105.038477] softirqs last  enabled at (60728): [<ffff8000800cb774>] handle_softirqs+0x624/0x63c
    [  105.047193] softirqs last disabled at (60711): [<ffff8000800102d8>] __do_softirq+0x14/0x20
    [  105.055471] ---[ end trace 0000000000000000 ]---
    [  105.060274] ------------[ cut here ]------------
    [  105.064963] Unexpected error: 64, error_type: 1073741824
    [  105.070440] WARNING: drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:558 at lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch], CPU#0: swapper/0/0
    ...
    [  105.443891] ------------[ cut here ]------------
    [  105.448536] Unexpected error: 64, error_type: 0
    [  105.453235] WARNING: drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c:558 at lan966x_fdma_irq_handler+0xe0/0x12c [lan966x_switch], CPU#0: swapper/0/0
    ...

And after them my ARM system don't see the answer of a ping command
replied by my PC (I don't use DHCP with my ARM system).

I don't know why those traces are not present on my x86 (config, race
condition, other reason) but anyway, they can help to find some clues
about what's going on.

Of course, feel free to ask me some more tests or anything else I can do
to help on this topic.

Best regards,
Hervé

