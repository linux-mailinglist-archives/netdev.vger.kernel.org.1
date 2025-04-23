Return-Path: <netdev+bounces-185240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A177FA99705
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B704A1CC5
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1735528CF4F;
	Wed, 23 Apr 2025 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pac8NCA+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A8A28D859
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430627; cv=none; b=kKLh8fO2dK3j0lA+NLE5k6d+5m2R0NYRPM9EzJ6Y2CXwUUoWlVcoSoF3F8cu7QuK2SZLoTdFXg5LKZxhK6GNCVcg2wAAYlaNn+iv2Nvrt9rO4El3x7gieqLjLvonQ4ojDaAApv1UP7zIChRVvIqbwBiw1JSeCehRT/6iAh/GeP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430627; c=relaxed/simple;
	bh=udEC8KVvK2JE9VheTB+Nm2ayPzlvx+qWsWrMsKKePuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uz2z1LA/Vw8g+kCZyDVaJtFguDnLrsfdFg45el56Bx/tJD4sG8E1XFaF0xJJrAYi6dSjYc5BIa3pBGKx32zPCp/iVKZhZKBqhY9GhKxSYUVpBT/G2CJjGemckZYpkrF61u3GF+uETOc45lvgpsSCIWN6RQ6qqz/xJR1MvAS//ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pac8NCA+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-739525d4e12so48451b3a.3
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745430624; x=1746035424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CvMoPw1g4u1/f5fDBCoSlBv3h4siazlq/6qHKrBbOms=;
        b=Pac8NCA+PwT8EZXXmclbjR/NBBO5/gagX6i5fGkZeCuqaoIAy+zFP/UKXIhU/vOBHD
         1B6Nhm5hglQwp6KOeVvWOn6vLjFpypXavRTxFgp+bzpLq51Rwz93KPLK+JIDkjhvtBsY
         rAcdZ3AEOjqG0zdYGzj3Borr/H028heD0JZBTmdvD5B2F/9jWl7iE2JxzaupdTxklQRZ
         pMYgzP8GYcTikMJVlsqb92qiKy6G8QggiQpa3lXzfaOvfNlA1cjEnYJYY/HIrnIR0XWx
         RYiChhe3JSCa/2EdF4+4rqp8hQtcW4ZvioSClf9+VTf9WDQVDblqkOpTXF/MTM+Qlx2y
         /hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430624; x=1746035424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvMoPw1g4u1/f5fDBCoSlBv3h4siazlq/6qHKrBbOms=;
        b=lamooIkv5qxSqH0cVzf2lhN8+RQpfkTlF3jcejVVWLXLuqJjoN8vxiVuHw7Q1Awzxm
         xhnn42e1vquHC5cExPDUvPq1kUau6Iznvoks+I+65Gi/+n8DTc4FjUyhbUVlrdDnojOD
         SavOshxDuEQUFPvu8LyEEffh3nQVY+EyBFHZmVlIPCCKcnIVpopWIjJWdgdiHRZbhGyC
         NzkJiEC/kUM/4LVT6EdRzSIQO8aDNSoU2aBkwLaaeiZnAjS7vuZYlQTaS+j+bGbH/fCj
         Y4IqEmG9Kk4nZuS95bXbznGWSJzd5ttWHZUMNNXhUfrsIbpKsAhVRbUpId7jo7EVm7CP
         BzPA==
X-Forwarded-Encrypted: i=1; AJvYcCWho1WVoyt7asWqV1xlvc1dCbffkdeyQom0vrinxHSGMc7fsF5qg8do0PHm4Y8Rz12+UF6/bCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSClQDX5ApohyIwZnlj0uwDzvjnSa23qfLwPXrIr5+rD+779H0
	SHI5a79svGprsHGLcL/7z+5EtvHRZ4hPUrROD+rbBc6bseGV0f0xytpXeD+yaw==
X-Gm-Gg: ASbGncuQvFpQ7JmHRKXqnQqJGydUO0AVnaOqvODG7oSBslt4BBEIoHx9P82JjcTItqT
	a0bvQfR1r0Yh7t9tQ45rsWMegPK5e+Gttv+wM5L+ep+Sfct9ZvPMDfPiU573MqNQmu46xwppf6s
	5tLnW20LzR/WBjFHiiXLiTl9Ro+oz84Q/a7pd82dWJmTukoobrau7hxHsvJK5dXM3Ty1TKLf6gm
	OMG9YGNYcB7Shw+dDkPoykP8+T2PIlDfFH4W/QT7BOMXS/9tWg1CQU4ZS021kTclOewBCH7ehf0
	WgcdkDv7Zsl8GW3AeskjR2U+F4EuiJeO2ssGSN9gZYmxyQv6s6A=
X-Google-Smtp-Source: AGHT+IHv+pp08oNpqH+o0Xz0nz+oDLweVTppPqhTTNxEODtBzVYScthcq/irSX3DBpAdC9igBxAldw==
X-Received: by 2002:a05:6a00:e12:b0:736:3c6a:be02 with SMTP id d2e1a72fcca58-73e21bce323mr456638b3a.11.1745430624531;
        Wed, 23 Apr 2025 10:50:24 -0700 (PDT)
Received: from thinkpad ([120.60.139.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfae99f4sm10818976b3a.168.2025.04.23.10.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:50:23 -0700 (PDT)
Date: Wed, 23 Apr 2025 23:20:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
Message-ID: <pvj33d5cp5cvy4oq4zvb5twqicps563b4hzzkbuqg7kafirjdx@am4bhsod4ycz>
References: <20250415095335.506266-2-cassel@kernel.org>
 <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com>
 <Z_-7I26WVApG98Ej@ryzen>
 <276986c2-7dbe-33e5-3c11-ba8b2b2083a2@oss.qualcomm.com>
 <Z__U2O2xetryAK_E@ryzen>
 <jikqc7fz4nmwd3ol4f2uazcjc3zgtbtzcrudhsccmvfm3pjbfk@mkcj6gnkrljj>
 <74a498d0-343f-46f1-ad95-2651d960d657@gmail.com>
 <9e9854d5-1722-40f2-b343-97cf9b23a977@gmail.com>
 <817cf0ff-5ecd-f6b1-d9b9-cf6b2473ed23@oss.qualcomm.com>
 <302ad2e6-e42f-4579-8a99-0ca72fccf24a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <302ad2e6-e42f-4579-8a99-0ca72fccf24a@gmail.com>

On Sun, Apr 20, 2025 at 08:25:19AM +0200, Heiner Kallweit wrote:
> On 20.04.2025 01:18, Krishna Chaitanya Chundru wrote:
> > 
> > On 4/19/2025 3:48 PM, Heiner Kallweit wrote:
> >> On 18.04.2025 23:52, Heiner Kallweit wrote:
> >>> On 18.04.2025 19:19, Manivannan Sadhasivam wrote:
> >>>> On Wed, Apr 16, 2025 at 06:03:36PM +0200, Niklas Cassel wrote:
> >>>>> Hello Krishna Chaitanya,
> >>>>>
> >>>>> On Wed, Apr 16, 2025 at 09:15:19PM +0530, Krishna Chaitanya Chundru wrote:
> >>>>>> On 4/16/2025 7:43 PM, Niklas Cassel wrote:
> >>>>>>>
> >>>>>>> So perhaps we should hold off with this patch.
> >>>>>>>
> >>>>>> I disagree on this, it might be causing issue with net driver, but we
> >>>>>> might face some other issues as explained above if we don't call
> >>>>>> pci_stop_root_bus().
> >>>>>
> >>>>> When I wrote hold off with this patch, I meant the patch in $subject,
> >>>>> not your patch.
> >>>>>
> >>>>>
> >>>>> When it comes to your patch, I think that the commit log needs to explain
> >>>>> why it is so special.
> >>>>>
> >>>>> Because AFAICT, all other PCIe controller drivers call pci_stop_root_bus()
> >>>>> in the .remove() callback, not in the .shutdown() callback.
> >>>>>
> >>>>
> >>>> And this driver is special because, it has no 'remove()' callback as it
> >>>> implements an irqchip controller. So we have to shutdown the devices cleanly in
> >>>> the 'shutdown' callback.
> >>>>
> >>> Doing proper cleanup in a first place is responsibility of the respective bus
> >>> devices (in their shutdown() callback).
> >>>
> >>> Calling pci_stop_root_bus() in the pci controllers shutdown() causes the bus
> >>> devices to be removed, hence their remove() is called. Typically devices
> >>> don't expect that remove() is called after shutdown(). This may cause issues
> >>> if e.g. shutdown() sets a device to D3cold. remove() won't expect that device
> >>> is inaccessible.
> >>>
> > Lets say controller driver in the shut down callback keeps PCIe device
> > state in D3cold without removing PCIe devices. Then the PCIe client
> > drivers which are not registered with the shutdown callback assumes PCIe
> > link is still accessible and initiates some transfers or there may be
> > on ongoing transfers also which can result in some system errors like
> > soc error etc which can hang the device.
> > 
> I'd consider a bus device driver behaving this way as broken.
> IMO device drivers should ensure that device is quiesced on shutdown.
> As you highlight this case, do you have specific examples?
> Maybe we should focus on fixing such bus device drivers first.
> 

Hi,

I was the author of the patch that Krishna submitted and I tend to agree that it
is indeed a bad idea of remove devices during shutdown(). The prime motive of
the patch is to properly shutdown the devices during poweroff/reboot scenarios.
So the removal of devices is rather unintended.

> I'd be interested in the PCI maintainers point of view, that's why I added
> Bjorn to the discussion.
> 
> > The patch which I submitted in the qcom pcie controller, removes the
> > PCIe devices first before turning off the PCIe link. All this
> > info needs to be in the commit text, I will update it in the next
> > version.
> >>> Another issue is with devices being wake-up sources. If wake-up is enabled,
> >>> then devices configure the wake-up in their shutdown() callback. Calling
> >>> remove() afterwards may reverse parts of the wake-up configuration.
> >>> And I'd expect that most wakeup-capable device disable wakeup in the
> >>> remove() callback. So there's a good chance that the proposed change breaks
> >>> wake-up.
> >>>
> > After shutdown, the system will restart right why we need to enable wakeup in shutdown as after restart it will be like fresh boot to system
> > Correct me if I was wrong here.
> > 
> > I want to understand, why shutdown of the PCIe endpoint drivers in this
> > case rtl18169 shutdown will be called before PCIe controller shutdown,
> > AFAIK, the shutdown execution order will be same as probe order.
> > 
> See following comment in device_shutdown():
> "Walk the devices list backward, shutting down each in turn."
> 

Yes, indeed!

@krishna: We may need to reuse the code in dw_pcie_suspend_noirq() for
transitioning the devices into D3Cold and Link into L2/L3. And please drop
the call to dw_pcie_host_deinit().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

