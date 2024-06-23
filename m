Return-Path: <netdev+bounces-105933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A43913B1B
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BED21F21A0E
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929F218A934;
	Sun, 23 Jun 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dB6L9MQK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C6188CC1
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150282; cv=none; b=Kl1y5iw+erxm040eSyX6P7Jvh7+wcG2mi4DyPuEmRJ8cBCKHN6/rXPfgQ2AO2CZj12o61mEUahu9v+hP4nSfNmp0WSk8M+K/hFIZ/vxxl9poHAyb3wD8XGpB4DAVts1DJvAPQXUyoyu1wwZ95CWyV9gpHdHhKCCn8WL3rM/B+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150282; c=relaxed/simple;
	bh=SyEF3mPeQlo+RKtM1lZCiiRHkvz/G6we80eXB2CMCmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4L4WADOO+uiy7hX8DsUSsvR7gnTmaKTwICUng/DB7agnO1MNj1gj0AwA7/7uLg40JC7bpxPAgW57f6wI/fe37HX8ZXd2iWcWggV9JRx1uJK3b8Y9duX9zASiZbO7KwNsVVmBt1F9WfWb2p4KC0MNTt3rUK6iXk1YIBxSVjhr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dB6L9MQK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fa07e4f44eso10304235ad.2
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719150280; x=1719755080; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Iy31pgzD/xfnAQ+ZZ5Vhlt8srfwkXvh9RHbo/cOv1WA=;
        b=dB6L9MQKIZYW50dAlEfK1WW7/c14rz8/a2wjDDiQMgDZCTmg1Khgm6kJNViR5qWHaM
         +wPxuMYUQvkTk/IS6y+naiM9VX3HiH3HApFeSOHsmXP+p+3YxdFAzln9DZT8fyWTbRJJ
         fIU+EX0AGupj1xhM6jCH+eUiHpS/+SmLdVj7AkXoRpl0HVT9+HIXRr3Ddu8zmOsw1k3Y
         t3+sYm/5+78pOPekZg44kelxiwUYWjxRjek/kEccMgMga4DrREUCESB9/hY+2zYZ0eb6
         BG4qh2Rnf+749QgIPGYh5i6Z7l7wXkQORVndVYjTr92h9jDmc+M/s+sGklymmOe08qkM
         98Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719150280; x=1719755080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iy31pgzD/xfnAQ+ZZ5Vhlt8srfwkXvh9RHbo/cOv1WA=;
        b=o3dE4wnAz3XAUXHKbQYfkktKZiHAgTXJykH5CduWYV7rvfRfYguu507HAz3M6oIA20
         3WmQsZsMqUxbLc2De4Z7ZE63qweyvFNjVZXeDf+PDoS7vv+xSwKLzxhOwaUkDZMbWAt0
         7D+fRRti0LkLCxHrquLJdbbKkZDcdjOwpWJe57wD60h9WeQVE7Q4GfHsnSn+4q+m3TPP
         Q3qIQz2Kc1uwtE8ILDXZGzsdbzxA6zKHMEo4tlF61hhmAZpd1/D0J2wsLjIdOc6ibUzO
         5faGbgmNM9LkHYLhhLV48bYEps5cV4M1JtN1o/fs3CpTTHs9Uo8B0sUvXEYNxfgVazUV
         v2qg==
X-Forwarded-Encrypted: i=1; AJvYcCXeWkyRTKlfm9LYsAmCME/HTzaSIdvw3Tq+zu7bw5w8h+/29/beBuPzeSgGqi15z9iiu2igxpAkydMxd4cZ7xY8QeIzYvpm
X-Gm-Message-State: AOJu0YyUvzGE9ITxyiJdKFQOOXOSANcA58l4bb2islTTuePXJDZCYLuI
	3+3AcurSOLnesw1umjEzUXAcp6ehrXZywX46HeyAXtuj97QIIl2Uq7wFF8D3HQKjFLSakPJ0W/4
	=
X-Google-Smtp-Source: AGHT+IEWGBAaA+9n4CQ1cGOYm2S0J1RVuhAM689jKtTg+X6pdgHcJ0xuxY7rtOkT1rl0335/07l1sA==
X-Received: by 2002:a17:902:6548:b0:1f7:167d:e291 with SMTP id d9443c01a7336-1fa23ef7e87mr23794255ad.47.1719150280014;
        Sun, 23 Jun 2024 06:44:40 -0700 (PDT)
Received: from thinkpad ([220.158.156.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f2690sm45736585ad.40.2024.06.23.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 06:44:39 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:14:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Loic Poulain <loic.poulain@linaro.org>, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, netdev@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2 1/2] bus: mhi: host: Import mux_id item
Message-ID: <20240623134430.GD58184@thinkpad>
References: <20240612093842.359805-1-slark_xiao@163.com>
 <20240612094609.GA58302@thinkpad>
 <87aecf24-cdbb-70d2-a3d1-8d1cacf18401@quicinc.com>
 <20240612145147.GB58302@thinkpad>
 <CAMZdPi-6GPWkj-wu4_mRucRBWXR03eYXu4vgbjtcns6mr0Yk9A@mail.gmail.com>
 <c275ee49-ac59-058c-7482-c8a92338e7a2@quicinc.com>
 <5055db15.37d8.19038cc602c.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5055db15.37d8.19038cc602c.Coremail.slark_xiao@163.com>

On Fri, Jun 21, 2024 at 11:17:16AM +0800, Slark Xiao wrote:
> 
> At 2024-06-14 22:31:03, "Jeffrey Hugo" <quic_jhugo@quicinc.com> wrote:
> >On 6/14/2024 4:17 AM, Loic Poulain wrote:
> >> On Wed, 12 Jun 2024 at 16:51, Manivannan Sadhasivam
> >> <manivannan.sadhasivam@linaro.org> wrote:
> >>>
> >>> On Wed, Jun 12, 2024 at 08:19:13AM -0600, Jeffrey Hugo wrote:
> >>>> On 6/12/2024 3:46 AM, Manivannan Sadhasivam wrote:
> >>>>> On Wed, Jun 12, 2024 at 05:38:42PM +0800, Slark Xiao wrote:
> >>>>>
> >>>>> Subject could be improved:
> >>>>>
> >>>>> bus: mhi: host: Add configurable mux_id for MBIM mode
> >>>>>
> >>>>>> For SDX72 MBIM mode, it starts data mux id from 112 instead of 0.
> >>>>>> This would lead to device can't ping outside successfully.
> >>>>>> Also MBIM side would report "bad packet session (112)".
> >>>>>> So we add a default mux_id value for SDX72. And this value
> >>>>>> would be transferred to wwan mbim side.
> >>>>>>
> >>>>>> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >>>>>> ---
> >>>>>>    drivers/bus/mhi/host/pci_generic.c | 3 +++
> >>>>>>    include/linux/mhi.h                | 2 ++
> >>>>>>    2 files changed, 5 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> >>>>>> index 0b483c7c76a1..9e9adf8320d2 100644
> >>>>>> --- a/drivers/bus/mhi/host/pci_generic.c
> >>>>>> +++ b/drivers/bus/mhi/host/pci_generic.c
> >>>>>> @@ -53,6 +53,7 @@ struct mhi_pci_dev_info {
> >>>>>>            unsigned int dma_data_width;
> >>>>>>            unsigned int mru_default;
> >>>>>>            bool sideband_wake;
> >>>>>> + unsigned int mux_id;
> >>>>>>    };
> >>>>>>    #define MHI_CHANNEL_CONFIG_UL(ch_num, ch_name, el_count, ev_ring) \
> >>>>>> @@ -469,6 +470,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx72_info = {
> >>>>>>            .dma_data_width = 32,
> >>>>>>            .mru_default = 32768,
> >>>>>>            .sideband_wake = false,
> >>>>>> + .mux_id = 112,
> >>>>>>    };
> >>>>>>    static const struct mhi_channel_config mhi_mv3x_channels[] = {
> >>>>>> @@ -1035,6 +1037,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >>>>>>            mhi_cntrl->runtime_get = mhi_pci_runtime_get;
> >>>>>>            mhi_cntrl->runtime_put = mhi_pci_runtime_put;
> >>>>>>            mhi_cntrl->mru = info->mru_default;
> >>>>>> + mhi_cntrl->link_id = info->mux_id;
> >>>>>
> >>>>> Again, 'link_id' is just a WWAN term. Use 'mux_id' here also.
> >>>>
> >>>> Does this really belong in MHI?  If this was DT, I don't think we would put
> >>>> this value in DT, but rather have the driver (MBIM) detect the device and
> >>>> code in the required value.
> >>>>
> >>>
> >>> I believe this is a modem value rather than MHI. But I was OK with keeping it in
> >>> MHI driver since we kind of keep modem specific config.
> >>>
> >>> But if WWAN can detect the device and apply the config, I'm all over it.
> >> 
> >> That would require at least some information from the MHI bus for the
> >> MBIM driver
> >> to make a decision, such as a generic device ID, or quirk flags...
> >
> >I don't see why.
> >
> >The "simple" way to do it would be to have the controller define a 
> >different channel name, and then have the MBIM driver probe on that. 
> >The MBIM driver could attach driver data saying that it needs to have a 
> >specific mux_id.
> >
> >Or, with zero MHI/Controller changes, the MBIM driver could parse the 
> >mhi_device struct, get to the struct device, for the underlying device, 
> >and extract the PCIe Device ID and match that to a white list of known 
> >devices that need this property.
> >
> >I guess if the controller could attach a private void * to the 
> >mhi_device that is opaque to MHI, but allows MBIM to make a decision, 
> >that would be ok.  Such a mechanism would be generic, and extensible to 
> >other usecases of the same "class".
> >
> >-Jeff
> 
> Hi guys,
> This patch mainly refer to the feature of mru setting between mhi and wwan side.
> We ransfer this value to wwan side if we define it in mhi side, otherwise a default
> value would be used in wwan side. Why don't we just align with that?
> 

Well, the problem is that MRU has nothing to do with MHI. I initially thought
that it could fit inside the controller config, but thinking more I agree with
Jeff that this doesn't belong to MHI at all.

At the same time, I also do not want to extract the PCI info from the client
drivers since the underlying transport could change with MHI. So the best
solution I can think of is exposing the modem name in 'mhi_controller_config' so
that the client drivers can do a match.

Please try to implement that.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

