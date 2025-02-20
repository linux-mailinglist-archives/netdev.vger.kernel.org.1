Return-Path: <netdev+bounces-168031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE36A3D2A2
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1C81784D4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D801E9B01;
	Thu, 20 Feb 2025 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzsMRm4X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175F1E5B9F
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037843; cv=none; b=U7xJLAThNZ2V4DMzRGp/RbAGVfpoxgR0KRuJx6WFMowNxLu3KP/N7CnVQxuN6XNyFDhPOVzLDs0rcLmCCxUrY0eJfHczV1j/9C84lbiiGW3KYVftBdwU4kcU4FjvCgy90neOl2AEzrZF+591QG8co1zHQ5B2m2qbLcSyzPc7hcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037843; c=relaxed/simple;
	bh=8bW2YSdy1OJyn/FIkYV5qBmOPGJkHbh8jmBJ8DjbYAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRBA2CS2VDkIchBHr7yg4xP3WFQq7NByfwRkqQwOfQBrZFnOcHBfky40YT52PseBkU2X7HDHDTja6X1ioXD7JdH73QjAr4eOTNTJpKyAqkMtOqRZ/6mELRk9ct3fZ+BPB7kJclQEKOfQzG3datjesy0HIVFQDY3pxM088tOvYVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzsMRm4X; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220f4dd756eso10624755ad.3
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740037841; x=1740642641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UV17Nt5yQKcSGgNfItNKNUGGyGE4aHh1b+X0vkMI1kU=;
        b=JzsMRm4X90FmdBCfGSNoiaMZWYmWTrjf4i1YCNQcWTUBsmu70emqwO6rxC+QU8EiHC
         KN/gRGHAmwZggT+6tlgAP47XF6nAz7S6eSV0X9KhkRNRe13LhSNFszLsBR24DP8D8Idr
         LNcwn11H3+7DTb45849hQjuVTdvgebx4B3Orjbsx8YUGyD54W1CtzvqVHsiyNHfPMOjf
         yRgkyvYRvRNRzFKL6hIoPXcCss8rpVXqiXPBdQkiu4QXTuPAX6hm/cLnyLVUSm4yWJo3
         LfkLxhH5CC8K2O5uXLC5j7c496HM3HYVNKPLCQ+AsXxwLoiEpmnYnGWLIw70TYoYZ6eD
         e95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740037841; x=1740642641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UV17Nt5yQKcSGgNfItNKNUGGyGE4aHh1b+X0vkMI1kU=;
        b=k4YYYz9t+zc8gFUZKYAn6/kjH1k4Z/2ZghJZrQD45LiMm4JsozGAaD2hpqRGoECbQz
         IDsS+HbtEz1dM7fZ2MVsDoBF5V0DoHZ9Ycb+jH1cEfaAf3RO02Ikx1EfXmtQ/XTqY5OU
         3ffcHRB273JPiqyu1x2/FKSKOaFQ+RCJFY414HfCn6PD/R+HHjhhIsbWy/nYNq39X3cm
         LLFU/eyxNM4ZaHHF7w2xD2Zap0jiNSsPwRo8iR83Y2CncfPqPLXzuqzItr1slQobw/ex
         RFOZ3lk3GHGTvNo9Sa2joW0IqGKo3t/ujbl0j5IZpxicwSs5GDxfswUO2fDnugDOWSfb
         jPvA==
X-Forwarded-Encrypted: i=1; AJvYcCUpYUW1bqTKbCIbB44G/q44DXh7eOkcnd4XdiH0VyzN/atzn3FjIiIvXVMTFefqEYc9Znh942Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhgBq+03iK0C3C6ZsDHv2khJPRsAINBGZyGOnUY3Prew63zNp
	G8MOtF8yz/BVLeKBYj+rDr1rltPQiwURfhw+J6w0HIOFNajbRexXrzKGX7hLLg==
X-Gm-Gg: ASbGncvDgx3luG97GMRA+TLf/JZlOLJseMSymJkGrzVgbIFB/q6qBi+wi04HoCbJ2Qe
	tNUM0/HfR2Kkz2/pBt1znPWHl0vdNUCdLEifRC0hKgXXUzi4yyQ95PcpT+6fqBkPPYTVL7yrCay
	wNlZQBES0sHLdZUb5WVW9zIlu0x66sz0WnZHu+sKkQme9yEozLRz5dbmrfOXx9g5xImk8VdOejX
	xEYES8vyB+YECW/fGPAQH3OBsjO/jKct8HP1Pc0hg+oMpDPBrBGFWteT+10iPygIK1Gi2NPle07
	hIrDdKKNd/BB2HFTmf/hpPXnAQ==
X-Google-Smtp-Source: AGHT+IFSN9+iiUzXPMS/UScQ00TgdpnN4eGzxEYaWLUw7fx9CjEDSYnibRHaiiO0jYuYJiu+yQKyaA==
X-Received: by 2002:a05:6a00:2e82:b0:730:9567:c3d5 with SMTP id d2e1a72fcca58-7326177cbccmr34361814b3a.4.1740037841234;
        Wed, 19 Feb 2025 23:50:41 -0800 (PST)
Received: from thinkpad ([120.60.70.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73258b985c9sm10741321b3a.84.2025.02.19.23.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:50:40 -0800 (PST)
Date: Thu, 20 Feb 2025 13:20:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johan Hovold <johan@kernel.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	kernel@collabora.com, ath11k@lists.infradead.org,
	jjohnson@kernel.org
Subject: Re: [BUG REPORT] MHI's resume from hibernate is broken
Message-ID: <20250220075034.unsd5cq7xkip2by6@thinkpad>
References: <59c036b6-a3d6-403b-8bb0-566a17f72abc@collabora.com>
 <20250214070447.scs6lpytjtecz3ko@thinkpad>
 <1cd4a1ed-f4e7-4c7b-a19f-f79afddbe310@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cd4a1ed-f4e7-4c7b-a19f-f79afddbe310@collabora.com>

On Mon, Feb 17, 2025 at 07:35:50PM +0500, Muhammad Usama Anjum wrote:
> On 2/14/25 12:04 PM, Manivannan Sadhasivam wrote:
> > Hi,
> Thank you so much for replying.
> 
> > 
> > + ath11k list and Jeff
> > 
> > On Tue, Feb 11, 2025 at 01:15:55PM +0500, Muhammad Usama Anjum wrote:
> >> Hi,
> >>
> >> I've been digging in the MHI code to find the reason behind broken
> >> resume from hibernation for MHI. The same resume function is used
> >> for both resume from suspend and resume from hibernation. The resume
> >> from suspend works fine because at resume time the state of MHI is 
> >> MHI_STATE_M3. On the other hand, the state is MHI_STATE_RESET when
> >> we resume from hibernation.
> >>
> >> It seems resume from MHI_STATE_RESET state isn't correctly supported.
> >> The channel state is MHI_CH_STATE_ENABLED at this point. We get error
> >> while switching channel state from MHI_CH_STATE_ENABLE to
> >> MHI_CH_STATE_RUNNING. Hence, channel state change fails and later mhi
> >> resume fails as well. 
> >>
> >> I've put some debug prints to understand the issue. These may be
> >> helpful:
> >>
> >> [  669.032683] mhi_update_channel_state: switch to MHI_CH_STATE_TYPE_START[2] channel state not possible cuzof channel current state[1]. mhi state: [0] Return -EINVAL
> >> [  669.032685] mhi_prepare_channel: mhi_update_channel_state to MHI_CH_STATE_TYPE_START[2] returned -22
> >> [  669.032693] qcom_mhi_qrtr mhi0_IPCR: failed to prepare for autoqueue transfer -22
> >>
> > 
> > Thanks for the report!
> > 
> > Could you please enable the MHI and ath11k debug logs and share the full dmesg
> > to help us understand the issue better?
> The ath11k debug was already enabled. CONFIG_MHI_BUS_DEBUG wasn't enabled. 

Sorry for not being clear. I asked you to enable the dev_dbg() logs in the MHI
driver. But it is not required. See below.

> I've
> enabled it and now the hibernate is working without any issue. It is very strange
> how can CONFIG_MHI_BUS_DEBUG make any difference. I don't have much background on
> how it is helping.
> 

Probably some timing issue. But enabling the MHI debug logs could also hide the
issue. So you should disable the CONFIG_MHI_BUS_DEBUG option and collect the MHI
trace logs that we recently added.

Hope it will shed some light.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

