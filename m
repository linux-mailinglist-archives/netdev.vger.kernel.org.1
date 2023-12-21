Return-Path: <netdev+bounces-59425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1FE81ACC1
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8241C1C238E5
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 02:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83A187E;
	Thu, 21 Dec 2023 02:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq+yfvac"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D563D90
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 02:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e39ac39bcso466354e87.3
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 18:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703126900; x=1703731700; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tEhsainjpksKyhl1gepWZ5GtNrvneHJYb5uwH5U700A=;
        b=Oq+yfvacMztQxZaWJTEMmWgOyCPDgMBXgpqLXtDYKUVD0kAUJeUmNj55+UmHn747K4
         HMHCMGmqbkPVyl/tKaCeM8LeZ+hVBm0i+SmjdPBYTfeMIhmljUcR3t7JQov92Mh5NsDQ
         B+DFnFYfRgnGg/wPPUFgLD/+wySiNoGLjf98OYHSXrlHFNl6eobX01+18igydokTubGe
         QGsUJu7QEZWUjWM8djUFVLzfN705LT4ybb/j3aP0JRzTeTBDqYCSiLsDdMw9WsOvyMn4
         zQ+GDebs6iG2SD4T78tJE8zo8/Qu9ppz5M8ypTBerMJFHs+Q2qYFy9SbcQjO76FQD0li
         MAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703126900; x=1703731700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEhsainjpksKyhl1gepWZ5GtNrvneHJYb5uwH5U700A=;
        b=OnQjJucc87L7hvl2u/SZALWTloP5TmYxHx3iJa4AeYErx6dKF3NjGr2k6IFepVxzI7
         cCkJ6SiQ1hhtw990B4Y128DgDetDkdu6cW1/amDvdjm5d/ekvEy5BikdtXhyubOZYF4M
         TuSImLpCgoscCUGf57U8Ax8NE8kBuG0fCTa6Sd5QloELq0vE4LbXvdINwdsp6Cw0/TLo
         D7D1yuDGQAjkO//lohg7ny//VFmXhlJgKdxMv2zLRBBlU1WcZm/4lgFGp34oPCP7Rk3J
         L8wiumNBm8f4vzd2g+4jtdtPrknYnM7UeyYFxlNq0nnzFARzEU4yTHJm32W0wy+WFJsc
         AIIw==
X-Gm-Message-State: AOJu0YyO2pxeVGyLknE71l0PZNQmufv2Bnm0Csde1ufNxDM/UEu7p9Hu
	3jQQP187MifO4nM9ef2PCf8=
X-Google-Smtp-Source: AGHT+IHb9Nu3WBKaZ+/mYs07DLdLt2WQWGEF/KrGVLHqNygxhuqOxHDW2AtRRmMX4T+RcgpjKktB0A==
X-Received: by 2002:ac2:5b0f:0:b0:50e:5623:d8 with SMTP id v15-20020ac25b0f000000b0050e562300d8mr360728lfn.197.1703126900167;
        Wed, 20 Dec 2023 18:48:20 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id h1-20020ac25961000000b0050e22bed716sm133475lfp.196.2023.12.20.18.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 18:48:19 -0800 (PST)
Date: Thu, 21 Dec 2023 05:48:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Household Cang <canghousehold@aol.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, 
	"rk.code@outlook.com" <rk.code@outlook.com>, "sashal@kernel.org" <sashal@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>, 
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: RK3658 DSA Port to MT7531 TCP Checksum Offload Issue
Message-ID: <m3clft2k7umjtny546ot3ayebattksibty3yyttpffvdixl65p@7dpqsr5nisbk>
References: <2069419566.3127127.1703101273945.ref@mail.yahoo.com>
 <2069419566.3127127.1703101273945@mail.yahoo.com>
 <4108ff0c-7f5e-444c-90e3-1ec339d043a6@intel.com>
 <1969249613.3172645.1703107503559@mail.yahoo.com>
 <779092239.3209937.1703118406743@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <779092239.3209937.1703118406743@mail.yahoo.com>

On Thu, Dec 21, 2023 at 12:26:46AM +0000, Household Cang wrote:
> Sorry, did not realize someone prefers to use plaintext email. Will resend in plaintext.
> 
> 
> On Wednesday, December 20, 2023 at 04:25:03 PM EST, Household Cang <canghousehold@aol.com> wrote: 
> 
> 
> Thanks.
> I will add the appropriate maintainers to the list.
> 
> Btw, during my investigation, the issue is very reminiscent of https://www.intel.com/content/www/us/en/download/19174/disabling-tcp-ipv6-checksum-offload-capability-with-intel-1-10-gbe-controllers.html, with Nokia ONT used by Verizon. It seems the ONT was appending bits at the end of the packet it processes to cause a checksum mismatch. I have yet to confirm with Verizon engineering.
> 
> -----
> For my issue, to undo the stmmac patches, then re-compile is a very tedious feat, especially it is a kernel jump from 6.1.1 to 6.6.0.
> I have yet to conclude whether it is due to the stmmac driver or the MT7531 driver.
> 
> I read MT7531's datasheet and it appears the chip does not handle TCP checksum offloading.
> So it may more likely point to stmmac is unable to handle something extra appended by MT7531 during the passage from DSA ports to the CPU port.
> 
> For the stmmac maintainers, could they point me to any specific patches that change the behavior of TCP checksum offloading, in the past year/9 months or so?

Please find this
https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
and this thread
https://lore.kernel.org/netdev/20231218162326.173127-1-romain.gantois@bootlin.com/
for the discussion about the DSA+COE-problem recently discovered.

-Serge(y)

> 
> Thanks.
> Lucas.
> 
> 
> 
> 
>  On Wednesday, December 20, 2023 at 04:00:50 PM EST, Jacob Keller <jacob.e.keller@intel.com> wrote:
> 
> 
> On 12/20/2023 11:41 AM, Household Cang wrote:
> > Dear all,
> > I applied Linux kernel 6.6.0 (yesterday) from 6.1.1 (snapshot from October of 2022), and suddenly the RK3568 is not reachable via SSH.An investigation shows the issue is restricted to stmmac-0:00 (SoC GMAC0, eth1), connected to DSA switch MT7531, and on TCP connections only. TCP connection captured in wireshark shows all retransmissions.
> > Running ethtool -K eth1 (GMAC0 to MT7531 CPU port) rx off tx off fixes the TCP connection issue.t> Issue is not exhibited on eth0 directly exposed to RTL8211F PHY without passing through the DSA switch. TCP checksum offloading remains ON on eth0.eth0 and eth1 using stmmac. eth1 using mt7530-mdio to drive 4 DSA ports (lan0-3).
> 
> > Whether this issue is due to changes in the stmmac driver or the mt7530-mdio driver, or a combination of both?Is MT7531BE capable of handling TCP checksum offloading?For GMAC1 (eth0), the GMAC seems to handle the tcp-checksum offloading.For GMAC0 (eth1), I don't know whether MT7531 is capable of handling tcp-checksum as well?
> > OR, could it be the something changed in stmmac driver that fails to account that frames coming from the DSA switch will bear extra tags?
> > Thanks.Lucas.
> > Excuse me if this is not the correct forum, but please do point me to the correct one...
> 
> Sounds like you might want to report this the stmmac folks, which
> according to MAINTAINERS would be:
> 
> STMMAC ETHERNET DRIVER
> M:      Alexandre Torgue <alexandre.torgue@foss.st.com>
> M:      Jose Abreu <joabreu@synopsys.com>
> L:      netdev@vger.kernel.org
> S:      Supported
> W:      http://www.stlinux.com
> F:      Documentation/networking/device_drivers/ethernet/stmicro/
> F:      drivers/net/ethernet/stmicro/stmmac/
> 
> 
> If you have some experience building the kernel you could also try git
> bisect to see if you could identify when it stopped working.
> 
> Hope this helps.
> 
> 
> Thanks,
> 
> Jake
> 
> 
> 
> 

