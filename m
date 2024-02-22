Return-Path: <netdev+bounces-73921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095185F54C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D5FB2341A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79A38F8F;
	Thu, 22 Feb 2024 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY8UBuRa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D838DE2
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596402; cv=none; b=tko0qer6zqUaoq3C5+w3jW+vrdFOyv1ISHe+R9D6GINDibJKcJXtOgkJ1SNFNMR3Lw+k+iKa5q78R2ke6IMFzQ+q1lg9iMCnc0Tu0u8Y+5oEkHFpn7CwTympkAHi4+yq+qdnbSZde9qN+TAhtSRSlw+59ogIwac8UW5ZZ0TA+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596402; c=relaxed/simple;
	bh=wma8/zd9L/F80bbFqZMzZtn8Z7EhIhuKUBPQeKubo7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSFcX7XAu2vgTG7mZ8Qh91CpvTL7LpOHsxoYOHSA9zUjWPCzMAC/IlEByWX5Ry2Axjqhs+vqUHlqHPZalV4Il2tZFlsgyp7ySwbCR/uxumrV0NEdxezxs5akgvvpPZ77gwQEAqYvBsk+Lmlem49a0l0pxOMr4MIe+bvevde7/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GY8UBuRa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso17574271fa.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708596398; x=1709201198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yZ3xjHchp3AkJXHkaPiau7tCOXtpaDhVmiKOh4e1zY8=;
        b=GY8UBuRaQAz0u7+zEziGBTwO5AynBb1tGxv8CGIIF7EZMGq48B7T40F2SfEg5BZhS5
         lxcUXVLehIUjbiU00f1HuiUAqFVRLNbNkUeT6Z9t+T7aZLMO/f7anDCK9cTyhD69w/0S
         yhZLEQG1EyKkGw7jyO4lRO1dMt4lj3KIIyIqRp7Bb+P7OFLokHdkgYKXt9zrI44t5eSY
         FazMiPvmMQs/2ggk+MjG5wpzmUpKJns8KN2CVoiq+ckPvingF7SuK1RVezw36d1QaAB9
         mI8DF0UclbwO7mksh53Tn2vdf4f/qzHUF+MBmp/KMAW08Ds54fYYyzPBPnc8MZ+viymN
         qBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708596398; x=1709201198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ3xjHchp3AkJXHkaPiau7tCOXtpaDhVmiKOh4e1zY8=;
        b=riHsQF9HzahlfcMJsoNjpou1GueUl600VqS8i/ZihAonl4L9Vcpmg6Q4X6C54RNth5
         O5GOGRBYBbTL5tqcMv0rJW3AabIEY2MEJlwc+oKh618jUTTQGwDcNKEEUQy+QXGM16XK
         JlPDPPVfh8xCvjAlw8vpYJfSo4fwQFTrE1MCMtSPVwEB6JzE43FOD3zIzYr0wlnI95fg
         Zk4WTfT6Q4d17Gva1egA5L7prteqyQGbtISs4CVA0jIczY5dx5wyucVHNymuteSZbxYX
         7z5vQeLCD1RTdPBlHEedtrdrzQqmstvUgNi+Nmdd4U2KlQDzvMnT1WVDmJzX5tUPFCIF
         ED8A==
X-Forwarded-Encrypted: i=1; AJvYcCVXWYTOjVUx9nq7cMwblXJ8UyafPyDUpGGI84SEa0DEBuEzETD2DVmppm2Qk4irucXsLeQUfRT58HMffsAbvOYlxf3Gfa0K
X-Gm-Message-State: AOJu0Yx9bDpIVJq9N2CsGLh40QtEFBr/66VF9svGqe/7ry9JQ05XK01y
	K8kHWpRaP6hr0gXZjiWO2DC9lQerO/a8i7hBOuk/8t8BivqoW1x6e4X3nyG6Od4=
X-Google-Smtp-Source: AGHT+IHduEDWw9e+bMAS0zmRHCfKGr2EcCKWNb/RgigSyblelBU+Z4fkXBDfzeu9J991axdmDXgH7g==
X-Received: by 2002:a2e:9dd1:0:b0:2d2:3a06:89b2 with SMTP id x17-20020a2e9dd1000000b002d23a0689b2mr7190824ljj.40.1708596398087;
        Thu, 22 Feb 2024 02:06:38 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id e5-20020a2e9305000000b002d240d69515sm1281513ljh.27.2024.02.22.02.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 02:06:37 -0800 (PST)
Date: Thu, 22 Feb 2024 13:06:34 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Song Yoong Siang <yoong.siang.song@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: stmmac and XDP/ZC issue
Message-ID: <jhykoyfimbjm5mrkc3zsezbv7qy2esz6rpfno6vdn4gcfiqmj2@yb3btajgazgj>
References: <87r0h7wg8u.fsf@kurt.kurt.home>
 <7dnkkpc5rv6bvreaxa7v4sx4kftjvv4vna4zqk4bihfcx5a3nb@suv6nsve6is4>
 <ZdS6d0RNeICJjO+q@boxer>
 <CAKH8qBs+TBRHhx0ZqMABCsGZ8sbXtSZMeFuP73-=hY69Wpfn8g@mail.gmail.com>
 <87ttm25lxw.fsf@kurt.kurt.home>
 <87le7e5g1r.fsf@kurt.kurt.home>
 <ZdYdzmvDSrdz03mb@boxer>
 <6h4rap3pi5v2qnq2goy63sanf7ygzosh3uikjlf6zgygt3rrcc@lyex4jslf5tf>
 <874je0c2x5.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874je0c2x5.fsf@kurt.kurt.home>

On Thu, Feb 22, 2024 at 09:35:02AM +0100, Kurt Kanzenbach wrote:
> On Wed Feb 21 2024, Serge Semin wrote:
> > On Wed, Feb 21, 2024 at 04:59:10PM +0100, Maciej Fijalkowski wrote:
> >> On Wed, Feb 21, 2024 at 10:21:04AM +0100, Kurt Kanzenbach wrote:
> >> > On Wed Feb 21 2024, Kurt Kanzenbach wrote:
> >> > > On Tue Feb 20 2024, Stanislav Fomichev wrote:
> >> > >> On Tue, Feb 20, 2024 at 6:43 AM Maciej Fijalkowski
> >> > >> <maciej.fijalkowski@intel.com> wrote:
> >> > >>>
> >> > >>> On Tue, Feb 20, 2024 at 04:18:54PM +0300, Serge Semin wrote:
> >> > >>> > Hi Kurt
> >> > >>> >
> >> > >>> > On Tue, Feb 20, 2024 at 12:02:25PM +0100, Kurt Kanzenbach wrote:
> >> > >>> > > Hello netdev community,
> >> > >>> > >
> >> > >>> > > after updating to v6.8 kernel I've encountered an issue in the stmmac
> >> > >>> > > driver.
> >> > >>> > >
> >> > >>> > > I have an application which makes use of XDP zero-copy sockets. It works
> >> > >>> > > on v6.7. On v6.8 it results in the stack trace shown below. The program
> >> > >>> > > counter points to:
> >> > >>> > >
> >> > >>> > >  - ./include/net/xdp_sock.h:192 and
> >> > >>> > >  - ./drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2681
> >> > >>> > >
> >> > >>> > > It seems to be caused by the XDP meta data patches. This one in
> >> > >>> > > particular 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC").
> >> > >>> > >
> >> > >>> > > To reproduce:
> >> > >>> > >
> >> > >>> > >  - Hardware: imx93
> >> > >>> > >  - Run ptp4l/phc2sys
> >> > >>> > >  - Configure Qbv, Rx steering, NAPI threading
> >> > >>> > >  - Run my application using XDP/ZC on queue 1
> >> > >>> > >
> >> > >>> > > Any idea what might be the issue here?
> >> > >>> > >
> >> > >>> > > Thanks,
> >> > >>> > > Kurt
> >> > >>> > >
> >> > >>> > > Stack trace:
> >> > >>> > >
> >> > >>> > > |[  169.248150] imx-dwmac 428a0000.ethernet eth1: configured EST
> >> > >>> > > |[  191.820913] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has been switched
> >> > >>> > > |[  226.039166] imx-dwmac 428a0000.ethernet eth1: entered promiscuous mode
> >> > >>> > > |[  226.203262] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-0
> >> > >>> > > |[  226.203753] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-1
> >> > >>> > > |[  226.303337] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_XSK_BUFF_POOL RxQ-1
> >> > >>> > > |[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> >> > >>> > > |[  255.822602] Mem abort info:
> >> > >>> > > |[  255.822604]   ESR = 0x0000000096000044
> >> > >>> > > |[  255.822608]   EC = 0x25: DABT (current EL), IL = 32 bits
> >> > >>> > > |[  255.822613]   SET = 0, FnV = 0
> >> > >>> > > |[  255.822616]   EA = 0, S1PTW = 0
> >> > >>> > > |[  255.822618]   FSC = 0x04: level 0 translation fault
> >> > >>> > > |[  255.822622] Data abort info:
> >> > >>> > > |[  255.822624]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> >> > >>> > > |[  255.822627]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> >> > >>> > > |[  255.822630]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> >> > >>> > > |[  255.822634] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000085fe1000
> >> > >>> > > |[  255.822638] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> >> > >>> > > |[  255.822650] Internal error: Oops: 0000000096000044 [#1] PREEMPT_RT SMP
> >> > >>> > > |[  255.822655] Modules linked in:
> >> > >>> > > |[  255.822660] CPU: 0 PID: 751 Comm: napi/eth1-261 Not tainted 6.8.0-rc4-rt4-00100-g9c63d995ca19 #8
> >> > >>> > > |[  255.822666] Hardware name: NXP i.MX93 11X11 EVK board (DT)
> >> > >>> > > |[  255.822669] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >> > >>> > > |[  255.822674] pc : stmmac_tx_clean.constprop.0+0x848/0xc38
> >> > >>> > > |[  255.822690] lr : stmmac_tx_clean.constprop.0+0x844/0xc38
> >> > >>> > > |[  255.822696] sp : ffff800085ec3bc0
> >> > >>> > > |[  255.822698] x29: ffff800085ec3bc0 x28: ffff000005b609e0 x27: 0000000000000001
> >> > >>> > > |[  255.822706] x26: 0000000000000000 x25: ffff000005b60ae0 x24: 0000000000000001
> >> > >>> > > |[  255.822712] x23: 0000000000000001 x22: ffff000005b649e0 x21: 0000000000000000
> >> > >>> > > |[  255.822719] x20: 0000000000000020 x19: ffff800085291030 x18: 0000000000000000
> >> > >>> > > |[  255.822725] x17: ffff7ffffc51c000 x16: ffff800080000000 x15: 0000000000000008
> >> > >>> > > |[  255.822732] x14: ffff80008369b880 x13: 0000000000000000 x12: 0000000000008507
> >> > >>> > > |[  255.822738] x11: 0000000000000040 x10: 0000000000000a70 x9 : ffff800080e32f84
> >> > >>> > > |[  255.822745] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000003ff0
> >> > >>> > > |[  255.822751] x5 : 0000000000003c40 x4 : ffff000005b60000 x3 : 0000000000000000
> >> > >>> > > |[  255.822757] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> >> > >>> > > |[  255.822764] Call trace:
> >> > >>> > > |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
> >> > >>>
> >> > >>> Shouldn't xsk_tx_metadata_complete() be called only when corresponding
> >> > >>> buf_type is STMMAC_TXBUF_T_XSK_TX?
> >> > >>
> >> > >> +1. I'm assuming Serge isn't enabling it explicitly, so none of the
> >> > >> metadata stuff should trigger in this case.
> >> > >
> >> > > The only other user of xsk_tx_metadata_complete() in mlx5 guards it with
> >> > > xp_tx_metadata_enabled(). Seems like that's missing in stmmac?
> >> > 
> >> > Well, the following patch seems to help:
> >> > 
> >> > commit e85ab4b97b4d6e50036435ac9851b876c221f580
> >> > Author: Kurt Kanzenbach <kurt@linutronix.de>
> >> > Date:   Wed Feb 21 08:18:15 2024 +0100
> >> > 
> >> >     net: stmmac: Complete meta data only when enabled
> >> >     
> >> >     Currently using XDP sockets on stmmac results in a kernel crash:
> >> >     
> >> >     |[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> >> >     |[...]
> >> >     |[  255.822764] Call trace:
> >> >     |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
> >> >     
> >> >     The program counter indicates xsk_tx_metadata_complete(). However, this
> >> >     function shouldn't be called unless metadata is actually enabled.
> >> >     
> >> >     Tested on imx93.
> >> >     
> >> >     Fixes: 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC")
> >> >     Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> >> > 
> >> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> > index 9df27f03a8cb..77c62b26342d 100644
> >> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> > @@ -2678,9 +2678,10 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
> >> >                                         .desc = p,
> >> >                                 };
> >> >  
> >> > -                               xsk_tx_metadata_complete(&tx_q->tx_skbuff_dma[entry].xsk_meta,
> >> > -                                                        &stmmac_xsk_tx_metadata_ops,
> >> > -                                                        &tx_compl);
> >> > +                               if (xp_tx_metadata_enabled(tx_q->xsk_pool))
> >> 
> >
> >> every other usage of tx metadata functions should be wrapped with
> >> xp_tx_metadata_enabled() - can you address other places and send a proper
> >> patch?
> >
> > AFAICS this is the only place. But the change above still isn't enough
> > to fix the problem. In my case XDP zero-copy isn't activated. So
> > xsk_pool isn't allocated and the NULL/~NULL dereference is still
> > persistent due to xp_tx_metadata_enabled() dereferencing the
> > NULL-structure fields. The attached patched fixes the problem in my
> > case.
> 
> Sure about that? In my case without ZC the else path is not executed,
> because skb is set.

Absolutely. Don't know why you haven't got the NULL-dereference bug as
I have. I was able to track the bug up to not having the
stmmac_rx_queue::xsk_pool allocated. Maybe your case is different in a
aspect that the pool had been pre-allocated someway before the ZC was
disabled. Anyway I agree it will be safer to keep the xsk_pool pointer
sanity check as it's done in the rest of the places in the driver.

> 
> >
> > Kurt, are you sure that xp_tx_metadata_enabled() is required in your
> > case?
> 
> Yes, I'm sure it's required, because I do use ZC without using any
> metadata.

Ok.

> 
> > Could you test the attached patch with the xp_tx_metadata_enabled()
> > invocation discarded?
> 
> Well, it works. But, the xp_tx_metadata_enabled() is not discarded in
> the ZC case:
> 
> |RtcRxThread-790     [001] b...3   202.970243: stmmac_tx_clean.constprop.0: huhu from xp_tx_metadata_enabled
> 
> Let's go with your version of the patch. It works without XDP, with XDP
> and XDP/ZC. I'll send it upstream.
> 
> Thanks for the help :).

Thanks for posting the patch. Here is the link for the lore archive:
https://lore.kernel.org/netdev/20240222-stmmac_xdp-v1-1-e8d2d2b79ff0@linutronix.de

-Serge(y)

> 
> Thanks,
> Kurt



