Return-Path: <netdev+bounces-73765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6885E46D
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F61C20433
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CDC5B5D1;
	Wed, 21 Feb 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT69GaZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0971C839EA
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536035; cv=none; b=g5aXEr+nMKuIP5pVtQHbIfryNO+XtqaZsaT64FTWja5Nayne676Q+5oAnocrFiPeqRbmNXl3Mr/iFrCSrpgg/f6ovuQD1HbBJJXP7z9m1IA+t6DtfJ7UPqdL3ZsU7+y2F/Q89R4eGjYrm03De2sG08syffv960G6mAg77BAz8WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536035; c=relaxed/simple;
	bh=t+aiUts/XX87SveeS8nDNXtoWCAGQ61dBHpye3DuY+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+ugP5qg0OMJRkDZ7g4YcUd8GLlIL8rxaxM+gQGg+XIhqposUVFMkzXctzSVvknWlue0O0dAzI0Hy2gOk5Uh3Zda7LAh8zpLWqb5z/Z2P8bAZX097P3zRWbXDBoIh5cM8+S7Eb2HWaWvbweZ2rxa2MV0A15bFB1wEJom9qzFTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT69GaZQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512b13bf764so4539031e87.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708536031; x=1709140831; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uB+R2eAFivDUgfiI97E35wz3zcabJogaERQJBBqwxVA=;
        b=kT69GaZQwJFgD26wCNKwlF3NSt9d+hwmIFZy33RLn8EWH8NK+UyJekGX9xJkyrSS/N
         ww0c61dYCwES/wH3eq3CVwMqPXFBfYzADZlPMsy74F7+QTBnlS1+BgFx3MF7B2fQDq8e
         ZEw1tlrA+TcPYFvEYAt4Pf2OHf5/nFq1z8RtBRSfeG9+KMpNffVsg5tSt3O3IRmPE7WX
         sDrB8XMNipQjcpoYv7o9NCFU32Y/bZRI/q1kS0HnSUWmYQdgwWkFqORbXdFjrNpL4rqG
         YgP+iaeGqXI4anKwswahmo1wqckUzSvAK3lVfcOZKkpv1S/7xvIqoFPEd7qvsBxEvFIV
         HoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708536031; x=1709140831;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uB+R2eAFivDUgfiI97E35wz3zcabJogaERQJBBqwxVA=;
        b=VzzHEisexTJ18qjf4Gz6UqUNR/DMQKHaAFk4HFb50gr8Z/UyPoXvXmMWfrL5YzotHa
         zMvhKO/cqJEgz+V98rJxTaySwA0apVNQrXTl6lFB+U86P/xsovyiRVXXg5isLwOwyWX0
         EEKx3KlguUAfvcDQZSRivTTO/JQBMi4G9TDfZhwtQk+mzaGSikweuIzP012w2L/GjBQJ
         tvEvLyYkJIATk+HDp67rAh9CnFWwUctbEWqL4HrLCzulScuE/fpB/nAfrBC6xI8brAjr
         r0cnIzC+m9z0Nui4jhi7KWffAN947Rmj7/Y5x8YMAiGLlfBznmOAlklGk8nc8iwznfEs
         OW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1/+Hwn0fKZInyFjxQ/4HjerIz8bEhN2snIXOgX8ksLqpPMzErkyYofYmgzHQq/Zm4UYEhxYs8fxgMexpwoLPpV+DErt9h
X-Gm-Message-State: AOJu0YzpCitZ9vEA5/b71DlCekCOW8pX96+jnHUz5iJWCQGmp/nNCpRC
	eKkzPil+XX9i6UOOg5j4ny+O38KyDucr7iCQOq75acMfP88qTPsB
X-Google-Smtp-Source: AGHT+IHJKkcAaWBcnNUweMUxuRYpiGI1Ygurjk1bcqi99Lhk/9hGmAagnxqXMTgizEg8yB0wsakaNA==
X-Received: by 2002:a05:6512:acc:b0:512:a980:719f with SMTP id n12-20020a0565120acc00b00512a980719fmr11440050lfu.69.1708536030642;
        Wed, 21 Feb 2024 09:20:30 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id s17-20020a197711000000b00512d632d905sm233386lfc.110.2024.02.21.09.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:20:30 -0800 (PST)
Date: Wed, 21 Feb 2024 20:20:27 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Kurt Kanzenbach <kurt@linutronix.de>
Cc: Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Song Yoong Siang <yoong.siang.song@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: stmmac and XDP/ZC issue
Message-ID: <6h4rap3pi5v2qnq2goy63sanf7ygzosh3uikjlf6zgygt3rrcc@lyex4jslf5tf>
References: <87r0h7wg8u.fsf@kurt.kurt.home>
 <7dnkkpc5rv6bvreaxa7v4sx4kftjvv4vna4zqk4bihfcx5a3nb@suv6nsve6is4>
 <ZdS6d0RNeICJjO+q@boxer>
 <CAKH8qBs+TBRHhx0ZqMABCsGZ8sbXtSZMeFuP73-=hY69Wpfn8g@mail.gmail.com>
 <87ttm25lxw.fsf@kurt.kurt.home>
 <87le7e5g1r.fsf@kurt.kurt.home>
 <ZdYdzmvDSrdz03mb@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="i6ujsqkpuuntuxm5"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdYdzmvDSrdz03mb@boxer>


--i6ujsqkpuuntuxm5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 21, 2024 at 04:59:10PM +0100, Maciej Fijalkowski wrote:
> On Wed, Feb 21, 2024 at 10:21:04AM +0100, Kurt Kanzenbach wrote:
> > On Wed Feb 21 2024, Kurt Kanzenbach wrote:
> > > On Tue Feb 20 2024, Stanislav Fomichev wrote:
> > >> On Tue, Feb 20, 2024 at 6:43 AM Maciej Fijalkowski
> > >> <maciej.fijalkowski@intel.com> wrote:
> > >>>
> > >>> On Tue, Feb 20, 2024 at 04:18:54PM +0300, Serge Semin wrote:
> > >>> > Hi Kurt
> > >>> >
> > >>> > On Tue, Feb 20, 2024 at 12:02:25PM +0100, Kurt Kanzenbach wrote:
> > >>> > > Hello netdev community,
> > >>> > >
> > >>> > > after updating to v6.8 kernel I've encountered an issue in the stmmac
> > >>> > > driver.
> > >>> > >
> > >>> > > I have an application which makes use of XDP zero-copy sockets. It works
> > >>> > > on v6.7. On v6.8 it results in the stack trace shown below. The program
> > >>> > > counter points to:
> > >>> > >
> > >>> > >  - ./include/net/xdp_sock.h:192 and
> > >>> > >  - ./drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2681
> > >>> > >
> > >>> > > It seems to be caused by the XDP meta data patches. This one in
> > >>> > > particular 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC").
> > >>> > >
> > >>> > > To reproduce:
> > >>> > >
> > >>> > >  - Hardware: imx93
> > >>> > >  - Run ptp4l/phc2sys
> > >>> > >  - Configure Qbv, Rx steering, NAPI threading
> > >>> > >  - Run my application using XDP/ZC on queue 1
> > >>> > >
> > >>> > > Any idea what might be the issue here?
> > >>> > >
> > >>> > > Thanks,
> > >>> > > Kurt
> > >>> > >
> > >>> > > Stack trace:
> > >>> > >
> > >>> > > |[  169.248150] imx-dwmac 428a0000.ethernet eth1: configured EST
> > >>> > > |[  191.820913] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has been switched
> > >>> > > |[  226.039166] imx-dwmac 428a0000.ethernet eth1: entered promiscuous mode
> > >>> > > |[  226.203262] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-0
> > >>> > > |[  226.203753] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-1
> > >>> > > |[  226.303337] imx-dwmac 428a0000.ethernet eth1: Register MEM_TYPE_XSK_BUFF_POOL RxQ-1
> > >>> > > |[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> > >>> > > |[  255.822602] Mem abort info:
> > >>> > > |[  255.822604]   ESR = 0x0000000096000044
> > >>> > > |[  255.822608]   EC = 0x25: DABT (current EL), IL = 32 bits
> > >>> > > |[  255.822613]   SET = 0, FnV = 0
> > >>> > > |[  255.822616]   EA = 0, S1PTW = 0
> > >>> > > |[  255.822618]   FSC = 0x04: level 0 translation fault
> > >>> > > |[  255.822622] Data abort info:
> > >>> > > |[  255.822624]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> > >>> > > |[  255.822627]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> > >>> > > |[  255.822630]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > >>> > > |[  255.822634] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000085fe1000
> > >>> > > |[  255.822638] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> > >>> > > |[  255.822650] Internal error: Oops: 0000000096000044 [#1] PREEMPT_RT SMP
> > >>> > > |[  255.822655] Modules linked in:
> > >>> > > |[  255.822660] CPU: 0 PID: 751 Comm: napi/eth1-261 Not tainted 6.8.0-rc4-rt4-00100-g9c63d995ca19 #8
> > >>> > > |[  255.822666] Hardware name: NXP i.MX93 11X11 EVK board (DT)
> > >>> > > |[  255.822669] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > >>> > > |[  255.822674] pc : stmmac_tx_clean.constprop.0+0x848/0xc38
> > >>> > > |[  255.822690] lr : stmmac_tx_clean.constprop.0+0x844/0xc38
> > >>> > > |[  255.822696] sp : ffff800085ec3bc0
> > >>> > > |[  255.822698] x29: ffff800085ec3bc0 x28: ffff000005b609e0 x27: 0000000000000001
> > >>> > > |[  255.822706] x26: 0000000000000000 x25: ffff000005b60ae0 x24: 0000000000000001
> > >>> > > |[  255.822712] x23: 0000000000000001 x22: ffff000005b649e0 x21: 0000000000000000
> > >>> > > |[  255.822719] x20: 0000000000000020 x19: ffff800085291030 x18: 0000000000000000
> > >>> > > |[  255.822725] x17: ffff7ffffc51c000 x16: ffff800080000000 x15: 0000000000000008
> > >>> > > |[  255.822732] x14: ffff80008369b880 x13: 0000000000000000 x12: 0000000000008507
> > >>> > > |[  255.822738] x11: 0000000000000040 x10: 0000000000000a70 x9 : ffff800080e32f84
> > >>> > > |[  255.822745] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000003ff0
> > >>> > > |[  255.822751] x5 : 0000000000003c40 x4 : ffff000005b60000 x3 : 0000000000000000
> > >>> > > |[  255.822757] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> > >>> > > |[  255.822764] Call trace:
> > >>> > > |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
> > >>>
> > >>> Shouldn't xsk_tx_metadata_complete() be called only when corresponding
> > >>> buf_type is STMMAC_TXBUF_T_XSK_TX?
> > >>
> > >> +1. I'm assuming Serge isn't enabling it explicitly, so none of the
> > >> metadata stuff should trigger in this case.
> > >
> > > The only other user of xsk_tx_metadata_complete() in mlx5 guards it with
> > > xp_tx_metadata_enabled(). Seems like that's missing in stmmac?
> > 
> > Well, the following patch seems to help:
> > 
> > commit e85ab4b97b4d6e50036435ac9851b876c221f580
> > Author: Kurt Kanzenbach <kurt@linutronix.de>
> > Date:   Wed Feb 21 08:18:15 2024 +0100
> > 
> >     net: stmmac: Complete meta data only when enabled
> >     
> >     Currently using XDP sockets on stmmac results in a kernel crash:
> >     
> >     |[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> >     |[...]
> >     |[  255.822764] Call trace:
> >     |[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38
> >     
> >     The program counter indicates xsk_tx_metadata_complete(). However, this
> >     function shouldn't be called unless metadata is actually enabled.
> >     
> >     Tested on imx93.
> >     
> >     Fixes: 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC")
> >     Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 9df27f03a8cb..77c62b26342d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -2678,9 +2678,10 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
> >                                         .desc = p,
> >                                 };
> >  
> > -                               xsk_tx_metadata_complete(&tx_q->tx_skbuff_dma[entry].xsk_meta,
> > -                                                        &stmmac_xsk_tx_metadata_ops,
> > -                                                        &tx_compl);
> > +                               if (xp_tx_metadata_enabled(tx_q->xsk_pool))
> 

> every other usage of tx metadata functions should be wrapped with
> xp_tx_metadata_enabled() - can you address other places and send a proper
> patch?

AFAICS this is the only place. But the change above still isn't enough
to fix the problem. In my case XDP zero-copy isn't activated. So
xsk_pool isn't allocated and the NULL/~NULL dereference is still
persistent due to xp_tx_metadata_enabled() dereferencing the
NULL-structure fields. The attached patched fixes the problem in my
case.

Kurt, are you sure that xp_tx_metadata_enabled() is required in your
case? Could you test the attached patch with the
xp_tx_metadata_enabled() invocation discarded?

Maciej, do we need xp_tx_metadata_enabled() guarding the
xsk_tx_metadata_complete() call even if the problem is fixed without
it?

-Serge(y)

> 
> > +                                       xsk_tx_metadata_complete(&tx_q->tx_skbuff_dma[entry].xsk_meta,
> > +                                                                &stmmac_xsk_tx_metadata_ops,
> > +                                                                &tx_compl);
> >                         }
> >                 }
> 
> 

--i6ujsqkpuuntuxm5
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-stmmac-Complete-meta-data-only-when-enabled.patch"

From fffab4a5d012875ff6e842901e5bb7db00d9d0ed Mon Sep 17 00:00:00 2001
From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Wed, 21 Feb 2024 17:24:25 +0300
Subject: [PATCH] net: stmmac: Complete meta data only when enabled

Currently using XDP sockets on stmmac results in a kernel crash:

|[  255.822584] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
|[...]
|[  255.822764] Call trace:
|[  255.822766]  stmmac_tx_clean.constprop.0+0x848/0xc38

The program counter indicates xsk_tx_metadata_complete(). However, this
function shouldn't be called unless metadata is actually enabled.

Tested on imx93.

Fixes: 1347b419318d ("net: stmmac: Add Tx HWTS support to XDP ZC")
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8000fa256dfc..f6c86478a820 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2634,7 +2634,8 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 			}
 			if (skb) {
 				stmmac_get_tx_hwtstamp(priv, p, skb);
-			} else {
+			} else if (tx_q->xsk_pool &&
+				   xp_tx_metadata_enabled(tx_q->xsk_pool)) {
 				struct stmmac_xsk_tx_complete tx_compl = {
 					.priv = priv,
 					.desc = p,
-- 
2.43.0


--i6ujsqkpuuntuxm5--

