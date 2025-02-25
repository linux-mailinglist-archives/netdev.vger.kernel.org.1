Return-Path: <netdev+bounces-169477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9A3A44245
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FD13B251E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF46D269AE6;
	Tue, 25 Feb 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YswEwNQX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8526BD86;
	Tue, 25 Feb 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492766; cv=none; b=AU6M58bs5YZ9i3415Szrv0nOXqhyJx7IOxXxAhRGWF4ci/yXXibFwzHYy2tOUFRtu8zfyVt+w8wu7v/gHJLqvvadOTgp0035M2xVKNJtIVfXK3azqD/ZMgq2AHFl9DKNODBkgplGi9hLdzjzxEbvRXbsQYrC3WzLbPq/ZMm2BHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492766; c=relaxed/simple;
	bh=NvPo81FgstGDBOyxIosqUZAVbYXZ9CECqX5dl0H62K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJZX+ryE+oEldedbhapZdiGygqZUCDiNzNRxSlz3adSS6J95ZJINYnak84LWxzlAEhtAJiQfmbFbA2HCBrgH+ExGgqHB9R2FOwK5bV8fBrEMJV2HQWMHw4WygJ2CXyWphWqqlHbFUzyUGxOZ0x7o3+PnrnSejoH3VGEdlnUyxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YswEwNQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F6BC4CEDD;
	Tue, 25 Feb 2025 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740492766;
	bh=NvPo81FgstGDBOyxIosqUZAVbYXZ9CECqX5dl0H62K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YswEwNQXXiAVsklxtmnsq1gmjEwPcFkl54hj3TF2KOeanFvDwzWBvFsewuBjG5+Iu
	 t3+DMfZErX5AtZpMP2AtiVvJH/8SEmSzubXoaxm6AYfEFE/fwA5N7V9NWA2FLbyYdY
	 HXmV33AInxprc0f6FMyT1BhyznknK+ToHqXQXzvInVlJz826iSy0KD3igFPWXtFrjk
	 RXSujMAxqr1i8o6BHYUiMIaeakcaSyQXpJqkf9Lj1aUGFUIkK3GuYXaQBlLMmd63Ts
	 TTDfniP3euhytiCkv/eOUsHMmyksWyuvGnXp6+i2XQGn7OxXPXM/1X4OPqhXjxi3xS
	 SfMKyUCqhlQHQ==
Date: Tue, 25 Feb 2025 14:12:40 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Hilber <quic_philber@quicinc.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
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
Message-ID: <20250225141240.GW1615191@kernel.org>
References: <20250219193306.1045-1-quic_philber@quicinc.com>
 <20250219193306.1045-3-quic_philber@quicinc.com>
 <20250224175618.GG1615191@kernel.org>
 <vhlhes7wepjrtfo6qsnw5tmtvw6pdt2tfi4woqdejlit5ruczj@4cs2yvffhx74>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vhlhes7wepjrtfo6qsnw5tmtvw6pdt2tfi4woqdejlit5ruczj@4cs2yvffhx74>

On Tue, Feb 25, 2025 at 12:28:24PM +0100, Peter Hilber wrote:
> On Mon, Feb 24, 2025 at 05:56:18PM +0000, Simon Horman wrote:
> > On Wed, Feb 19, 2025 at 08:32:57PM +0100, Peter Hilber wrote:
> > 
> > ...
> > 
> > > +/**
> > > + * viortc_ptp_gettimex64() - PTP clock gettimex64 op
> > > + *
> > 
> > Hi Peter,
> > 
> > Tooling recognises this as a kernel doc, and complains
> > that there is no documentation present for the function's
> > parameters: ptp, ts, and sts.
> > 
> > Flagged by W=1 builds.
> > 
> 
> Thanks, I will change the offending documentation to non kernel-doc. I
> was not aware that these warnings are always considered a problem.

Likewise, thanks.

I guess it depends on the subsystem. And perhaps this is fine for virtio.
But for Networking at large the rule of thumb is not to add new warnings.

