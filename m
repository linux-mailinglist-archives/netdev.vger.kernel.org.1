Return-Path: <netdev+bounces-99401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAC68D4C31
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685E5B21E0B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF817CA10;
	Thu, 30 May 2024 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUPmX3Bo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68AD176183
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074080; cv=none; b=NLOE86WYQbvJ1YkHrWdgEbAgMGxVJLPXFY5Qp8qLMZHEs1hwtCAwVSOlUDCJ5WJMsIRJ+u8LND2Re5iJHxJ18F1wwk0tmZjbszABtd8mth8S1nmHo+XRHaxnYO+ogVooin88jCS0GQLmZ1FGIvbFKOL6S4S1YdtVWvaw/8KiclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074080; c=relaxed/simple;
	bh=QbG0ygvFhemxwXbo8UH3vbamKCGJA+4BeTD1i2CVlnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWBvcNMTfPri7T0RTCpjgyXpb5oAfibQzInbX0cMoaeQMk9ccBdZESvWw628XP1rwciuKFchUXl/ef9W5DNy8wveWG3PA7jbMOwReSz59jIL8y22dNDThNfBZK6OZVeaW/T7ISh0yPh7Z2b0NGt3bY3S9igH0zbiWrmgTw24Xw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUPmX3Bo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717074077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qH6bqXZWDj2VvkhQa8r0x2CDiDZr/N+uYFn9yj//1U=;
	b=SUPmX3Boid0aCkLSE0OcFa2/VBaqH9YQC+AVmccm8luvoMxM63+HPyABQaVo+BtAM0bFf2
	XiFun5xzFzqblZ2tvIZG/dYlht9woF4GrBAZLbbR4fYXaFnSpVjDlQUgEvA7dexiPzgSGU
	XnONP7m7R3OrZ0TfG6XZ725eJV6qhTI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-BwJVtxVQMuuvxk086aqKLw-1; Thu, 30 May 2024 09:01:07 -0400
X-MC-Unique: BwJVtxVQMuuvxk086aqKLw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43fe0f3bfd6so8076621cf.3
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 06:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074063; x=1717678863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qH6bqXZWDj2VvkhQa8r0x2CDiDZr/N+uYFn9yj//1U=;
        b=R1tsGr28aAPiK65CBTs4Qd4ev/+uBHcr/aei+9nakeqSjuj1gyR5svcVMZzkCXRuVd
         JT9OKSMBL54kwe/TghgInaVP1HXin7TDP9GdGDL+CIoHesFlav74/KxUcY87CemufZCG
         zvZtkSC6LbQ6IRN0bNobVp6Mz7fHLIXdLkCrzDIlukv1O8NE14ZPR3J+T8238X5UVOAd
         s7Y0gnjZCosUNWYMWJvgtI4WvXOunmU8ZtlBCwd/GdrCRj8k5iPcjth5QVv5JmLSMedZ
         pbO+HnKdX+CpW88xRBj1c54o933s6sWNwOPSjyp2c9dn8hZLUg8HbjXN56CL4X2q6ouN
         WqYg==
X-Forwarded-Encrypted: i=1; AJvYcCW8weBXtDCSMcvqsocOKAFL/Bue+Hy9B6NCIYmO0p0Fo8WhyOFt0VVCpUnHjjymBvbDj+p61gxNdPwbrnuBQO92bCyWpy/i
X-Gm-Message-State: AOJu0YwAdI/O0h7R62Q/dCUAGFbNC/krQLorwa/kB2VMelBjv0wR3cR5
	jc8VnJ2bL6RRYVZHVvU4tSZjOm9mp3LkiigkrhFqo87jgazof0UbLbVg2v33J85dJQ46gRbh+2x
	9UAV0OSkaGrcuxjElAnuTCbHbEhdZCYc1ezh5qv16gCrVmDrp8ZAEYQ==
X-Received: by 2002:a05:622a:83:b0:43e:3d8b:b6b9 with SMTP id d75a77b69052e-43fe930e9e0mr21742321cf.44.1717074062389;
        Thu, 30 May 2024 06:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmqMkYgzTY+K+MR+AsBjg7npPdMxiUXyD3C6fsmskBzvTeam+eNVGfcssNbpZMomvAfvLBqQ==
X-Received: by 2002:a05:622a:83:b0:43e:3d8b:b6b9 with SMTP id d75a77b69052e-43fe930e9e0mr21741561cf.44.1717074061340;
        Thu, 30 May 2024 06:01:01 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18b0e3bsm65135651cf.68.2024.05.30.06.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:01:00 -0700 (PDT)
Date: Thu, 30 May 2024 08:00:58 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
	Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Jochen Henneberg <jh@henneberg-systemdesign.com>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: dwmac-qcom-ethqos: Configure host DMA width
Message-ID: <busrdvbjh7eigqgpgwl4k5tergt263gfjcpti7jutdyk37cnse@iotdvflbsca6>
References: <20240529-configure_ethernet_host_dma_width-v1-1-3f2707851adf@quicinc.com>
 <7w5bibuejmd5kg3ssozaql4urews26kpj57zvsaoq2pva3vrlo@agfxwq5i65pc>
 <d8ad4e59-5725-4a7d-a2ad-ce5d92553525@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ad4e59-5725-4a7d-a2ad-ce5d92553525@lunn.ch>

On Thu, May 30, 2024 at 12:22:52AM GMT, Andrew Lunn wrote:
> On Wed, May 29, 2024 at 03:50:28PM -0500, Andrew Halaney wrote:
> > $Subject should be have [PATCH net] since this targets the net tree:
> > 
> > https://docs.kernel.org/process/maintainer-netdev.html
> > 
> > On Wed, May 29, 2024 at 11:39:04AM GMT, Sagar Cheluvegowda wrote:
> > > Fixes: 070246e4674b ("net: stmmac: Fix for mismatched host/device DMA address width")
> > > Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> 
> > Also, I think the Fixes: here would be for adding support for this SoC
> > in the driver, not what's listed? Might make more sense after you have a
> > proper body though.
> 
> This is a tricky one. 
> 
> Fixes: 070246e4674b ("net: stmmac: Fix for mismatched host/device DMA
> address width") is when support for different DMA address widths was
> added. This fix cannot easily be back ported past that.
> 
> 070246e4674b first appears in v6.3-rc4.
> 
> dwmac-qcom-ethqos.c first appears in v5.1-rc1. However, Qualcomm did
> not start hacking on it until v6.7-rc6. It is unclear to me without a
> deep dive when Qualcomm actually started using this driver.
> 
> We might actually be looking at this the wrong way, and should in fact
> be looking at when a DT patch was added that made use of the driver,
> not the driver itself. If it was not used, it cannot be broken....
> 

I should have been more specific, sorry.

I think this should be:

    Fixes: 8c4d92e82d500 ("net: stmmac: dwmac-qcom-ethqos: add support for emac4 on sa8775p platforms")

Which appears after 070246e4674b ("net: stmmac: Fix for mismatched host/device DMA address width").

Reason being that specifically Sagar's patch is indicating that for the
SoC's/compatibles that currently use emac_v4_0_0_data structure, the DMA
address width needs to be specified.

If we were modifying structs that were added prior to 070246e4674b then
I agree, but at least the change as is I think could indicate the above
Fixes.

Thanks,
Andrew


