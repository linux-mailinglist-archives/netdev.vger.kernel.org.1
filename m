Return-Path: <netdev+bounces-29081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75F781917
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3D42819DB
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0C646B9;
	Sat, 19 Aug 2023 10:50:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF6A51
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AB7C433C8;
	Sat, 19 Aug 2023 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1692442210;
	bh=UOf0VrNbj7jijgQLUEJOQOBTWQ8bE2tlLoIK1cWZfF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kei/cEnCzd9vylrM81C/pPpoNImWO9ct/BfmNbABJtoIAiUdlMrA6QirCewN8nGsl
	 E+/EyT5QuE5r/CU3d6rHBMKoRtj1M4beqjlpX4igDLY31/WCHuJE9cep162hACy+zA
	 MkHvny2Q8i8kBUce3Avd2yXp9bzBiQ31Ho3RWg+I=
Date: Sat, 19 Aug 2023 12:50:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Evan Quan <evan.quan@amd.com>, Andrew Lunn <andrew@lunn.ch>,
	rafael@kernel.org, lenb@kernel.org, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alexander.deucher@amd.com, rdunlap@infradead.org,
	quic_jjohnson@quicinc.com, horms@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Message-ID: <2023081919-mockup-bootleg-bdb9@gregkh>
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
 <2023081806-rounding-distract-b695@gregkh>
 <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>

On Fri, Aug 18, 2023 at 05:49:14PM -0500, Limonciello, Mario wrote:
> 
> 
> On 8/18/2023 4:24 PM, Greg KH wrote:
> > On Fri, Aug 18, 2023 at 11:26:11AM +0800, Evan Quan wrote:
> > >   drivers/base/Makefile                         |   1 +
> > >   drivers/base/wbrf.c                           | 280 ++++++++++++++++++
> > 
> > Why is a wifi-specific thing going into drivers/base/?
> > 
> > confused,
> > 
> > greg k-h
> 
> The original problem statement was at a high level 'there can be
> interference between different devices operating at high frequencies'. The
> original patches introduced some ACPI library code that enabled a mitigated
> for this interference between mac80211 devices and amdgpu devices.
> 
> Andrew Lunn wanted to see something more generic, so the series has morphed
> into base code for things to advertise frequencies in use and other things
> to listen to frequencies in use and react.
> 
> The idea is supposed to be that if the platform knows that these mitigations
> are needed then the producers send the frequencies in use, consumers react
> to them.  The AMD implementation of getting this info from the platform
> plugs into the base code (patch 2).
> 
> If users don't want this behavior they can turn it off on kernel command
> line.
> 
> If the platform doesn't know mitigations are needed but user wants to turn
> them on anyway they can turn it on kernel command line.

That's all fine, I don't object to that at all.  But bus/device-specific
stuff should NOT be in drivers/base/ if at all possible (yes, we do have
some exceptions with hypervisor.c and memory and cpu stuff) but for a
frequency thing like this, why can't it live with the other
wifi/frequency code in drivers/net/wireless/?

In other words, what's the benefit to having me be the maintainer of
this, someone who knows nothing about this subsystem, other than you
passing off that work to me?  :)

thanks,

greg k-h

