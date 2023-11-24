Return-Path: <netdev+bounces-50973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851107F85A3
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 22:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3371F283980
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129DE3C461;
	Fri, 24 Nov 2023 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhGJ8S6o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88F2E3E1
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 21:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B54C433C8;
	Fri, 24 Nov 2023 21:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700862711;
	bh=86FGqXvNjqQbObQabrirNsZfFzfD518MNwAyD3JGuJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhGJ8S6ohOpaVFUBVCAQTBJAtGcJOSw+DTRjPSUlkjaHcFYOHTVJfxJWx1xpscoGJ
	 u9fVBpoOgj+j+gWAaChUl1T70vUW5KhkFrsYk5INrhfpz251HxHIEBaS3/HeH2Txoj
	 OdTvQa0CwwJSmTHTYvw9eNlFynSFA9U0BxAPgnR5bs8ZP6mwZ6M7g3BTbUeldvzT6i
	 Lp/Rl0Arowbaq1M1nyPOLPMF5+DbTeL2bFjxhaSHy6zr4ELzXp4hA4ew6p16SBew4+
	 D9hQLik878RbTcxGymot2kqBXTsosdmxAnzwmWglBmT+svPn2ga+FRXFxCiCUBpTvd
	 dEaqH9evntL4w==
Date: Fri, 24 Nov 2023 21:51:47 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: remove not needed check in
 rtl_fw_write_firmware
Message-ID: <20231124215147.GF50352@kernel.org>
References: <52f09685-47ba-4cfe-8933-bf641c3d1b1d@gmail.com>
 <20231123145407.GK6339@kernel.org>
 <65832d7e-2880-4883-92b9-033e48c24d25@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65832d7e-2880-4883-92b9-033e48c24d25@gmail.com>

On Thu, Nov 23, 2023 at 04:12:59PM +0100, Heiner Kallweit wrote:
> On 23.11.2023 15:54, Simon Horman wrote:
> > On Thu, Nov 23, 2023 at 10:53:26AM +0100, Heiner Kallweit wrote:
> >> This check can never be true for a firmware file with a correct format.
> >> Existing checks in rtl_fw_data_ok() are sufficient, no problems with
> >> invalid firmware files are known.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  drivers/net/ethernet/realtek/r8169_firmware.c | 3 ---
> >>  1 file changed, 3 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/realtek/r8169_firmware.c b/drivers/net/ethernet/realtek/r8169_firmware.c
> >> index cbc6b846d..ed6e721b1 100644
> >> --- a/drivers/net/ethernet/realtek/r8169_firmware.c
> >> +++ b/drivers/net/ethernet/realtek/r8169_firmware.c
> >> @@ -151,9 +151,6 @@ void rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
> >>  		u32 regno = (action & 0x0fff0000) >> 16;
> >>  		enum rtl_fw_opcode opcode = action >> 28;
> >>  
> >> -		if (!action)
> >> -			break;
> >> -
> > 
> > Hi Heiner,
> > 
> > I could well be wrong, but this does seem to guard against the following case:
> > 
> > 1. data = 0
> > 2. regno = 0
> > 3. opcode = 0 (PHY_READ)
> > 
> > Which does not seem to be checked in rtl_fw_data_ok().
> > 
> > It's unclear to me if there is any value in this guard.
> > 
> Value 0 is used with a special meaning in two places:
> 1. Newer firmwares with some meta data before the actual firmware
>    have first dword 0 to be able to differentiate old and new fw format.
> 2. Typically (not always) fw files in new format have a trailing dword 0.
> 
> A potential problem (as you mention) is that value 0 isn't really a
> sentinel value because reading PHY register 0 is a valid command.
> It's just never used in their firmwares.
> 
> There's no need to guard from reading PHY reg 0. It does no harm.
> I *think* they once added this check to detect end of file.
> But that's not needed because the actual firmware length is
> part of the meta data. Therefore reading data from the firmware
> will stop before reaching the training zero(s).

Thanks for the clarification.
I am happy with this patch (which is now in net-next).

> 
> >>  		switch (opcode) {
> >>  		case PHY_READ:
> >>  			predata = fw_read(tp, regno);
> >> -- 
> >> 2.43.0
> >>
> 

