Return-Path: <netdev+bounces-76535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D4E86E106
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 13:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C752838D0
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 12:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD33E6E61C;
	Fri,  1 Mar 2024 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVhRMiO3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB36E5E7
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709295967; cv=none; b=DHqfi4NEDNGRO/ZJlxFffz4EQ8Ro/MEs8lnGGITWyfXIsgryyBcoXrsdMugR1nhEUT+QHa+IYT5eFJ5Yyaqh4lR6e2ykkwpjw9xy23B2CJ0Fs5fYK7T6nLYUi6vsxjkKqeXEYOeRKN5q41qX0ndM41CzFJKblgj8vsX/cQu0HmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709295967; c=relaxed/simple;
	bh=DCxEN7tYRiXh61QyHjoT94wXv3D+5boFGgkhPYQVN4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdPKTKLw15BueYSwvuvReLtsuk2Sm1Ha5COt3zRZL8XcgM7w5fgJaDuLvDco+COF38oboVjqp8UuuXeKN1/CEIUqR/7DHZOX0l+t1iTKDFZaCp7+shZnEA2/eY0Fye/5ZU5bR18Cc5UU7Fki8i+XnFhcPrFXyWgjvUKjNML3BW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bVhRMiO3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so1399673a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 04:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709295965; x=1709900765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n4vy0ssj1y9OKJx6whcKaZP2Wd8dgYFve24tfX8P7n0=;
        b=bVhRMiO3ZLYW3MYlRoFjRWBCmUKW6VYrOJo4wExARQEm+Zv3eP24h2l/vMVv2ih2jE
         zr75DkEhQpgQeNKL1WYFBWNkLd9kTiOIMFSP3ngyneKymvMWi/Vgphp4pvjfAe9LoJnc
         VA9EBDpe+nsbcF/S6biTKvkv+22KKCSAT7GCWqXCCt3XM2H/eEUpcbdKIUx8sjK7ik1h
         bwT8zt/0q+lnuc5wwK7Vfz5ceY3V+wqSokQ/4T1zcB4Q4eDnonUVOHXR490MF58LYbAT
         ynmflIMJG8F0oywV5Y+K2bQ44HzuC2ixS1N7rKAOxLCcKihwxGLZyjCp/cW7Qpmn8g7X
         HoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709295965; x=1709900765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4vy0ssj1y9OKJx6whcKaZP2Wd8dgYFve24tfX8P7n0=;
        b=vMi1WKE1KmxUtNwnvzJdpk0WYwbIs9fJcoji2rXaeZv87JmIdU7GR+SHjM4+zLVO7l
         m7dHpKJsbXFrmGgwk+bNdCJyY3G2UzxJtewqD8SX67vXw40wd9MCg0EqN/o4U8zJvE0v
         knQDhclxeRrqXOAEkel/uN9wU9yyiGi5DOQ1iPsrfpN55rPslFsWttdz5O96MVOLgu08
         Lwvn/q56VBB9sPOyZzbDaVtSeXu31BpWxv/YV3IcPUmM7Ic0Z/qJuP89kbwV2KFegeYA
         uCMXTHYFpQpgYT9ZlVUzQBc+sW1GE14WqtHV97YRXGHtC4q5rzTHvjzzJDGzalt/WHC2
         ZDZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyeWWqPVKU1j004fID7J1ImPYDincWhg5BnriSV/aiuSVIlLbeJPuAZaBdNNhtLDcSnLZuF7ASnpPkRBnnrwIVCFDSu5EW
X-Gm-Message-State: AOJu0YytGG8KkO4d/yUG5jLr3Dkd9lWzRz1gH/VU+YqtP/y1UN3EJVdi
	Rf9Kq9lbG8d6h5P+xD5VvDg/BxISbrdLYKCzhlUPBuhIAtH4HX9PD2jMON8tUGV1tamoTp0t4JI
	=
X-Google-Smtp-Source: AGHT+IHDbZOb0MqU0lNgT6Ylu5XAVO9Rkznovko5WeZRWLmmdsVhJISyuzq0BMbPgmlDmT83+wLDug==
X-Received: by 2002:a05:6a20:4327:b0:1a0:6856:d12c with SMTP id h39-20020a056a20432700b001a06856d12cmr1584913pzk.18.1709295965331;
        Fri, 01 Mar 2024 04:26:05 -0800 (PST)
Received: from thinkpad ([2409:40f4:13:3cbc:2484:3780:dcff:ebcf])
        by smtp.gmail.com with ESMTPSA id p12-20020aa7860c000000b006e50e79f155sm2834437pfn.60.2024.03.01.04.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 04:26:04 -0800 (PST)
Date: Fri, 1 Mar 2024 17:55:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	"Kalle Valo (QUIC)" <quic_kvalo@quicinc.com>,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/3] bus: mhi: host: add mhi_power_down_keep_dev()
Message-ID: <20240301122559.GB2401@thinkpad>
References: <20240228022243.17762-1-quic_bqiang@quicinc.com>
 <20240228022243.17762-2-quic_bqiang@quicinc.com>
 <20240229101202.GB2999@thinkpad>
 <531daaa9-cf14-4812-8908-c617bd25bc08@quicinc.com>
 <87le7383nd.fsf@kernel.org>
 <b5b3f46d-ad98-44e5-84e0-7b00fe29ec5a@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5b3f46d-ad98-44e5-84e0-7b00fe29ec5a@quicinc.com>

On Fri, Mar 01, 2024 at 10:04:06AM +0800, Baochen Qiang wrote:
> 
> 
> On 3/1/2024 3:35 AM, Kalle Valo wrote:
> > Baochen Qiang <quic_bqiang@quicinc.com> writes:
> > 
> > > On 2/29/2024 6:12 PM, Manivannan Sadhasivam wrote:
> > > > On Wed, Feb 28, 2024 at 10:22:41AM +0800, Baochen Qiang wrote:
> > > > > ath11k fails to resume:
> > > > > 
> > > > > ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
> > > > > 
> > > > > This happens because when calling mhi_sync_power_up() the MHI subsystem
> > > > > eventually calls device_add() from mhi_create_devices() but the device
> > > > > creation is deferred:
> > > > > 
> > > > > mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
> > > > > 
> > > > > The reason for deferring device creation is explained in dpm_prepare():
> > > > > 
> > > > >           /*
> > > > >            * It is unsafe if probing of devices will happen during suspend or
> > > > >            * hibernation and system behavior will be unpredictable in this case.
> > > > >            * So, let's prohibit device's probing here and defer their probes
> > > > >            * instead. The normal behavior will be restored in dpm_complete().
> > > > >            */
> > > > > 
> > > > > Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not
> > > > > called and thus MHI channels are not prepared:
> > > > > 
> > > > > So what this means that QRTR is not delivering messages and the QMI connection
> > > > > is not working between ath11k and the firmware, resulting a failure in firmware
> > > > > initialization.
> > > > > 
> > > > > To fix this add new function mhi_power_down_keep_dev() which doesn't destroy
> > > > > the devices for channels during power down. This way we avoid probe defer issue
> > > > > and finally can get ath11k hibernation working with the following patches.
> > > > > 
> > > > > Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> > > > > 
> > > > > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> > > > 
> > > > Did Kalle co-author this patch? If so, his Co-developed-by tag should
> > > > be added.
> > > 
> > > Hmm, I'm not sure...  I would like Kalle's thoughts on this.
> > 
> > IIRC I did only some simple cleanup before submitting the patch so I
> > don't think Co-developed-by is justified. I'm also fine with removing my
> > Signed-off-by.
> Thanks Kalle.
> 
> Hi Mani, so according to Kalle's comments, I'd like to keep the patch as is.
> 

No. Either remove his signed off by (as indicated by Kalle) or add a
co-developed-by tag. Keeping just a signed-off-by tag is wrong.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

