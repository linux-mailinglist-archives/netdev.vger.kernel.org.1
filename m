Return-Path: <netdev+bounces-37761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412D07B7080
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 20:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E08DB281313
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF13B7AC;
	Tue,  3 Oct 2023 18:06:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B419D2EB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 18:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E6EC433C7;
	Tue,  3 Oct 2023 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696356361;
	bh=0xbl8oPJ28VfWUMRw6Yz+vyVTFd8XM3S/o3cljFLAUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzvIQDpyLhKOrV+qKZrERLdnJp3JNp/+hDIGUk4JD/IH8U2GwD+yS13wpSQ0eNgC0
	 01jVYeFxj9lOgFsQLVb7fib6w2aECQPIvJ64UovpkHOyICpBLGGJvPs19/GTk3CsVi
	 gSW4HhyJCZA3ih3FUD070Z+cY/bJ/wBVQ68tTChoicnKk9fkeZdFS+wz4xxlyeczkX
	 jOM5+fISw/9mjuZ71Efr1PNSGe3GCoHzhH1mtnDLsizyC8yACCV4P1fIHGrZ7qFSm1
	 bcgN7Ngm4WnK9ZHW4WrBSXB5jeozfGUionKg+g/xppZEw6OIy/vs8BXfCskibAlfPG
	 avQRyg/SKj0tg==
Date: Tue, 3 Oct 2023 21:05:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>, Dima Chumak <dchumak@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next V3 1/2] devlink: Support setting port
 function ipsec_crypto cap
Message-ID: <20231003180557.GC51282@unreal>
References: <20231002104349.971927-1-tariqt@nvidia.com>
 <20231002104349.971927-2-tariqt@nvidia.com>
 <0a1ed293-c709-eb93-f534-88d11e450a5f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1ed293-c709-eb93-f534-88d11e450a5f@kernel.org>

On Tue, Oct 03, 2023 at 08:46:51AM -0600, David Ahern wrote:
> On 10/2/23 4:43 AM, Tariq Toukan wrote:
> > From: Dima Chumak <dchumak@nvidia.com>
> > 
> > Support port function commands to enable / disable IPsec crypto
> > offloads, this is used to control the port IPsec device capabilities.
> > 
> > When IPsec crypto capability is disabled for a function of the port
> > (default), function cannot offload IPsec operation. When enabled, IPsec
> > operation can be offloaded by the function of the port.
> > 
> > Enabling IPsec crypto offloads lets the kernel to delegate XFRM state
> > processing and encrypt/decrypt operation to the device hardware.
> > 
> > Example of a PCI VF port which supports IPsec crypto offloads:
> > 
> > $ devlink port show pci/0000:06:00.0/1
> >     pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
> > 	function:
> > 	hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto disable
> > 
> > $ devlink port function set pci/0000:06:00.0/1 ipsec_crypto enable
> > 
> > $ devlink port show pci/0000:06:00.0/1
> >     pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
> > 	function:
> > 	hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto enable
> > 
> 
> Why not just 'ipsec' instead of 'ipsec_crypto'? What value does the
> extra '_crypto' provide?

There are two IPsec offloaded modes: crypto offload and packet offload.
They need to be separated and can operate independently as these modes
per-SA/policy. 

To make it more clear to users, we are using ipsec_crypto to be
explicit.

Thanks

> 
> 
> 

