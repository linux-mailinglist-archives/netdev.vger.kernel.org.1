Return-Path: <netdev+bounces-152449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1919F3FE6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3147A1AB1
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE83D38DD1;
	Tue, 17 Dec 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WmG2Exwe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19463F9D9
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734398600; cv=none; b=BFB1DLFsFEd+zCMz+v48A5jOTFkcTzEKoYEsjFUxFgnOWfT+9mQqXf7ojkpO4ZatcjTmsa2LiV/QwWqP5IqPoSe7VCUgFSezqGlUuO291nHfkCXI+xBpu3n7fxnNnTFxRAVXTt9wPw93Bh1OlzesAF2xuVvWRhfLrhUY9GLnpG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734398600; c=relaxed/simple;
	bh=ANwxoYOx6LaHFFptWf3DC5ruCF6lhH1vDaf1fvdE1e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAuZFaKXvRRIbSZz1suIBZhsJ7Xw3FvQa+7B1/4bWIwKDbFtFtJ7T3b3s94s3xK7XPHVNWo286y/SWV/sF5ARhUyrir5O05W+HQfd8hASxPl2zJ+GJ7nQppQ2uX6vHnrgoyaWQXBbBv8o4Y7txtGrRJ6FRfnIcisUH5RioDP49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WmG2Exwe; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9EB003F7FE
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 01:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1734398595;
	bh=e4oykdNzqp3U/ysHZwf9sZj7W3/zqo027MCN1jhVxxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=WmG2ExweBeYc9j4q8ntu/6PTbphV0nK5EgQsO2fvMBX7u8E0fiyvTDOFsJtGAVon9
	 3pY15wlPq2wcmLwm2uTzxtM3zngF2DNZXujFc3+ceP/eqpQqHaEnE6v5lJL4JILNrU
	 DKeEJIFzb145enIaXV3v38bBf3m3cw/tkR2jHTTAXcRnmJRUUvRabrn54VXZasmhjL
	 5x5rttLxctNPxKMym08B9xQU7NCBd17Tw2E84JILTDtC3ZBbN5IRaZo6+WWPambvBA
	 nE9zjDe6dVcclIqbvhszejXlSVwslCIxV53NK3wtlH2Bsud/PoJxh8oYueoO8OGMpy
	 e0xBVxOas8CDg==
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b35758d690so852418085a.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734398594; x=1735003394;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4oykdNzqp3U/ysHZwf9sZj7W3/zqo027MCN1jhVxxc=;
        b=PYjRcNgQOS7HeJyNNhhimh5elHU77xm1zwk+HKzewkMBpJWVUGxgKyFS1bQgFVi7re
         SJPtCQ1yTXBQOv/9tyzREZEX2VwHyaeSXJTHDEo7hoJ6GjGgRuiupHHwxUUEcVXU4Eru
         vvCmNTd4AobFMopL8z8q5O2vG4F5PuNjuggU6kWflfjpcqLSV+5nBCtswAOabaiHAfYt
         AvgHA48hrzSW3Qg7c4oosHQsx+iTuKq4AdT0OfZPE/ar9JyaSV7tLglJVXlJgpSrJ38T
         BY1gMVzGHbUVJoTid2vn09WJ/JcqrhNTxFCVVQo+tCT/2qrfeC3iOJ3n9z+krVHSBwNl
         tTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU+j97PplwmUFI4yx4UQfPfeuqZ0e6rnHk3YTMudB4GEXy5wt5qiVWCInxvodpyRqB1VEBY9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywak568d0sG0si2a3hyn0vqXz9tR4A0x8nUkK0ye2e8GnftC1Wk
	bqUHM8CP+w1dhknzSfjTE7euitbOiKftbtw30tPmuY6hzosonRVflk3YyQasilw9HvpgFE6RnIV
	z5U+baKT2V1yj3z6iep0HKikzG6V/2DyXYeMaljaFTzy2YpfEohcDZ+9d8CP8eKfGCs+w6A==
X-Gm-Gg: ASbGncsuBy2EdLDY+xdhEHIKW1ukJn7QrhUZWZZx4Nzmp6LV0muKn3KCDsVySIoRk4a
	HzqS38HT5VOomIGB4tzBhpVmCvOQBEfovnEs25dALbwAh1NH+s02vM5wMVDb8NDLWuf5imWB7eP
	x0BrCseddccsJXrj6MhnohlHOuOtvnUuN08srI3FqyT/WUjW76YUiSWrWyb2n+aKDaDObePZKHF
	Z74bTJAakufysQaxGRHYa46gv4lcPDOxF0ZZj7mox8pgwFZmJHIsSVu8OGOXiOF9eLxN6QGG2/L
	OZFl24h6zlUljzf8pH8MowLszU/WCtz1hjs=
X-Received: by 2002:a05:620a:2945:b0:7b6:cc37:cbf1 with SMTP id af79cd13be357-7b8594a4703mr224591185a.23.1734398594460;
        Mon, 16 Dec 2024 17:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJTAJ9XJb5Czh3X9+Wfy9QchOyDmnenuxFZ///v6qAtwPn/ytbeNIDSbXJAtA5rR8LFoKaYQ==
X-Received: by 2002:a05:620a:2945:b0:7b6:cc37:cbf1 with SMTP id af79cd13be357-7b8594a4703mr224588485a.23.1734398594162;
        Mon, 16 Dec 2024 17:23:14 -0800 (PST)
Received: from acelan-precision5470 (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048c9f62sm274358485a.111.2024.12.16.17.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 17:23:12 -0800 (PST)
Date: Tue, 17 Dec 2024 09:23:05 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vitaly Lifshits <vitaly.lifshits@intel.com>
Subject: Re: [PATCH] igc: Return early when failing to read EECD register
Message-ID: <o6u6fr4znqfcznzq47jlqojdf34vdhardfypw3kl5y76pxjk6n@cxcp2mlsv62k>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vitaly Lifshits <vitaly.lifshits@intel.com>
References: <20241216051430.1606770-1-acelan.kao@canonical.com>
 <a1c44976-9e88-4d58-bad8-34fd397ba626@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c44976-9e88-4d58-bad8-34fd397ba626@intel.com>

On Mon, Dec 16, 2024 at 06:53:10AM +0100, Przemek Kitszel wrote:
> On 12/16/24 06:14, Chia-Lin Kao (AceLan) wrote:
> > When booting with a dock connected, the igc driver can get stuck for ~40
> > seconds if PCIe link is lost during initialization.
> > 
> > This happens because the driver access device after EECD register reads
> > return all F's, indicating failed reads. Consequently, hw->hw_addr is set
> > to NULL, which impacts subsequent rd32() reads. This leads to the driver
> > hanging in igc_get_hw_semaphore_i225(), as the invalid hw->hw_addr
> > prevents retrieving the expected value.
> 
> Than you very much for the patch and the analysis!
> 
> > 
> > To address this, a validation check is added for the EECD register read
> > result. If all F's are returned, indicating PCIe link loss, the driver
> > will return -ENXIO immediately. This avoids the 40-second hang and
> 
> It is not clear from the patch what part of the driver will return
> -ENXIO, you have put -ENODEV in the patch, but it's ignored anyway.
I was thinking of using -ENODEV or -ENXIO, and I forgot to generate
the patch again after I changed it to -ENXIO in the commit message.
I'll fix this in v2.
> 
> > significantly improves boot time when using a dock with an igc NIC.
> > 
> > [    0.911913] igc 0000:70:00.0: enabling device (0000 -> 0002)
> > [    0.912386] igc 0000:70:00.0: PTM enabled, 4ns granularity
> > [    1.571098] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
> > [   43.449095] igc_get_hw_semaphore_i225: igc 0000:70:00.0 (unnamed net_device) (uninitialized): Driver can't access device - SMBI bit is set.
> > [   43.449186] igc 0000:70:00.0: probe with driver igc failed with error -13
> > [   46.345701] igc 0000:70:00.0: enabling device (0000 -> 0002)
> > [   46.345777] igc 0000:70:00.0: PTM enabled, 4ns granularity
> > 
> 
> Would be best if you could also attach the sequence after your fix.
Sure

> Please add a Fixes: tag.
I'm not sure which commit should I add Fixes to.

> Please make [PATCH iwl-net] as a subject prefix. Please CC Vitaly.
igc is an ethernet driver, should I also add iwl-net tag?

> (But please also wait a day prior to sending v2 for more feedback).
> 
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > ---
> >   drivers/net/ethernet/intel/igc/igc_base.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
> > index 9fae8bdec2a7..54ce60280765 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_base.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_base.c
> > @@ -68,6 +68,10 @@ static s32 igc_init_nvm_params_base(struct igc_hw *hw)
> 
> This function is used only in igc_get_invariants_base(), which ignores
> the return value you have added. I would expect it to propagate instead.
You are right, looks like the patch fixes the issue accidentally.
Return earlier in igc_get_invariants_base() skipping the rest of the
settings. The part impacts the behavior is nvm->word_size will be 0.
And then in igc_get_hw_semaphore_i225() the timeout value will become
1. So that we won't hang for 40 seconds to wait for the timeout.

This patch is not perfect, I need to figure out another way to address
the issue better.
Please let me know if you got any ideas.
Thanks.
> 
> >   	u32 eecd = rd32(IGC_EECD);
> >   	u16 size;
> > +	/* failed to read reg and got all F's */
> > +	if (!(~eecd))
> > +		return -ENODEV;
> > +
> >   	size = FIELD_GET(IGC_EECD_SIZE_EX_MASK, eecd);
> >   	/* Added to a constant, "size" becomes the left-shift value
> 

