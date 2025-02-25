Return-Path: <netdev+bounces-169482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE57DA442AB
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AB71890720
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313EB269CEB;
	Tue, 25 Feb 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dV+gF3aB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047926AAAF
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493296; cv=none; b=RduNl2YGbBityIIcvVIDxRus4U0Ieoj+PRiwbFPtMPLSxcHMwgLOPPc8LswAVkNq3C9MAyXZU+cPGVsp0n1lI8glyrQ9jz08NHodvbX2yCCOvWfTAlYGd5f6RlVbmDr+vfeDiU4Is1VeRnAsGoJOA3a4Vw6WVgY1mH0q7RlNjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493296; c=relaxed/simple;
	bh=JOzSXnruxMx8fo4ynquuHZbCjEVyeQDk3Gw08yi3rfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdGBYj7GOFB4E6+kdhXf/CpTLjtc8o3CaJaFu5jlXnPNZydODy2E014LiXrWBVvi6WUw+sbOUteUrzfUl3jmvIi1dgYOqhrDad8MbaVoqFaR4FKvzP/7E2ZeMTdheSC5APTE3A1mor6KniTaw2brEn+5oEL3oQa6Cp5jSHrieIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dV+gF3aB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740493293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFFVttm850UqVz1pmb+AlnJQK6y1OGWuLBvoqE/ivD0=;
	b=dV+gF3aBJG2ObjJtIOteRp5o4ZeAAdcEKWswESee9ZMQmGHBUaahzzAvaGbeDOp5nEvgMS
	yxigvz2BdKIrv3feZK9uw/ziY+BM2BRNPAMbzrRQzSoNbao8v6JweV1l/2DhQ6xb2pjIi7
	JzGOCritUGnPMlHVwgTaJeMHu1uAWP4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-lJ7chyTIMxOKi4vA3H2voQ-1; Tue, 25 Feb 2025 09:21:31 -0500
X-MC-Unique: lJ7chyTIMxOKi4vA3H2voQ-1
X-Mimecast-MFC-AGG-ID: lJ7chyTIMxOKi4vA3H2voQ_1740493290
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f45a86efdso2907431f8f.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 06:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493290; x=1741098090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFFVttm850UqVz1pmb+AlnJQK6y1OGWuLBvoqE/ivD0=;
        b=uIazgkTDUjyHH0L5nJnU7aKtxfl8JfAakGxFC1jRJKgYqocwbC3J6L0paapt10kVDK
         bpyF5oHSee/XYlOp9WTpmCsfDl+GfY3GqoGnb/LJxyVDFF1wqPcDIDyMZu4Utj+GtvRV
         RMC4g6wHH5GAFtH9LGsb1Z1WTDyZ1TD5tYlW4BuJiVg8lpI3U3+A7Byb0SWqkwjdmNAx
         yqdKAD/KtTZ4L3FzEwdTp7P4iexOaVC7xQgyO0ihLpdq7TDzrEGMfulHLZ3XKsjEWuY7
         LAeW+nmvSOxjL4gkDC0egutIXbVjTsO9X3ulZ8ajXk+5h/1+54JpRt57hvw87rE19u7R
         7W7w==
X-Forwarded-Encrypted: i=1; AJvYcCX7G9Fygl9Nyr3pbCCr9ws5kWtzZxqpj+H0Oa1oCr3WZNs0H37njGgozTwTnOFeh5ZI0u08MJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9NfRTINgnzrQhuaJzJlCGympVaphWBuX41Bo/2Tx7xjPY8rK
	mE6NqYG5YbWV11TD5ixZbiOIHWdBUv0xZkt9c78bH2PlmpULlR6UscfXCVFKGORGNR3u0t715tN
	qJoAmX0KeIptU6JBH8zY1ITUT2uKiqi8IiRIukT12lCrSAISFqDZkmA==
X-Gm-Gg: ASbGnctMbfi50crUd3/M89g8rl1SvvlwHGSB8Dm8JbSgle2gAB/hzl3oCZrNaaiJdp4
	99LxYpnw+x+6F+PwI1P7EF0qqs9kQdOD6yarmar9mD9vrxBhs5UxE7pj3XcqUm8eUJONzT7SybE
	u3vHBf0FD7t0aJjxJHeUP2ya7Hc8btYC0EhCmkBhvRtIj/4O/d2Xy5dfQ8lKlo8pMZKQXUbLUce
	pLy6gS2G+dgCmIdkgOeUGnToPPUZw7p/jJn9VFkHbShXWMPFidtdl74xUfnkxBBx1IeMSB4bm7A
X-Received: by 2002:a05:6000:401e:b0:38f:210b:693f with SMTP id ffacd0b85a97d-38f6f0ae79cmr12378083f8f.52.1740493290279;
        Tue, 25 Feb 2025 06:21:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPzWsgH9v1k2HVPYkFXNJ3hhFz69OOLf5Yi+p9svSln8YhJs1OVyxaR00ASzjgQujycgWCZQ==
X-Received: by 2002:a05:6000:401e:b0:38f:210b:693f with SMTP id ffacd0b85a97d-38f6f0ae79cmr12378040f8f.52.1740493289721;
        Tue, 25 Feb 2025 06:21:29 -0800 (PST)
Received: from redhat.com ([2.52.7.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cb08sm2423039f8f.29.2025.02.25.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:21:29 -0800 (PST)
Date: Tue, 25 Feb 2025 09:21:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Peter Hilber <quic_philber@quicinc.com>,
	Jason Wang <jasowang@redhat.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	"Ridoux, Julien" <ridouxj@amazon.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Parav Pandit <parav@nvidia.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] virtio_rtc: Add PTP clocks
Message-ID: <20250225092115-mutt-send-email-mst@kernel.org>
References: <20250219193306.1045-1-quic_philber@quicinc.com>
 <20250219193306.1045-3-quic_philber@quicinc.com>
 <20250224175618.GG1615191@kernel.org>
 <vhlhes7wepjrtfo6qsnw5tmtvw6pdt2tfi4woqdejlit5ruczj@4cs2yvffhx74>
 <20250225141240.GW1615191@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225141240.GW1615191@kernel.org>

On Tue, Feb 25, 2025 at 02:12:40PM +0000, Simon Horman wrote:
> On Tue, Feb 25, 2025 at 12:28:24PM +0100, Peter Hilber wrote:
> > On Mon, Feb 24, 2025 at 05:56:18PM +0000, Simon Horman wrote:
> > > On Wed, Feb 19, 2025 at 08:32:57PM +0100, Peter Hilber wrote:
> > > 
> > > ...
> > > 
> > > > +/**
> > > > + * viortc_ptp_gettimex64() - PTP clock gettimex64 op
> > > > + *
> > > 
> > > Hi Peter,
> > > 
> > > Tooling recognises this as a kernel doc, and complains
> > > that there is no documentation present for the function's
> > > parameters: ptp, ts, and sts.
> > > 
> > > Flagged by W=1 builds.
> > > 
> > 
> > Thanks, I will change the offending documentation to non kernel-doc. I
> > was not aware that these warnings are always considered a problem.
> 
> Likewise, thanks.
> 
> I guess it depends on the subsystem. And perhaps this is fine for virtio.
> But for Networking at large the rule of thumb is not to add new warnings.

Nope.


