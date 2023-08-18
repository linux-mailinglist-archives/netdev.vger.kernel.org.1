Return-Path: <netdev+bounces-28706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2999780513
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 06:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADA51C2152C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 04:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA67B11CA7;
	Fri, 18 Aug 2023 04:20:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723B8478
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 04:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEADDC433C8;
	Fri, 18 Aug 2023 04:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692332404;
	bh=hD/1Id2eN+ldgf7KbCidk7uUSIBHbkkWIHhq3KwMC+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STgyJ20Kx1ZtOKzG+zDpHVd6QtrwdP+XACSmwuCKtUDrtc0dIuI7oY3oIQyPW1RF+
	 wHptwW9tMyDfyduIGyQp4da4+61TOjb9FccKp03G355pXzsp9uvnUlOK1wmqD2MOmG
	 GTRSvSvNC5ZylK0MNI1UYFS4dvDqq5d9yQo4bEC9VdBQjIKBw+Id4DBx0pxTG1AQRu
	 JUn+Xlx8ZFU8UH5blNtpdF2jrxsHseRvLSZJCgOUgBuOxq3gm1lyqFR5+LjafAcfTA
	 dkyQ4br2hiWS3WkROoI+pypdt7gDmm8b0UzQT2JnahY9/rjeTlgFpGCaCj03JNV2E9
	 vpQ4T3P4d1H8w==
Date: Fri, 18 Aug 2023 07:19:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Dima Chumak <dchumak@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 0/8] devlink: Add port function attributes
Message-ID: <20230818041959.GX22185@unreal>
References: <cover.1692262560.git.leonro@nvidia.com>
 <20230817200725.20589529@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817200725.20589529@kernel.org>

On Thu, Aug 17, 2023 at 08:07:25PM -0700, Jakub Kicinski wrote:
> On Thu, 17 Aug 2023 12:11:22 +0300 Leon Romanovsky wrote:
> > Introduce hypervisor-level control knobs to set the functionality of PCI
> > VF devices passed through to guests. The administrator of a hypervisor
> > host may choose to change the settings of a port function from the
> > defaults configured by the device firmware.
> > 
> > The software stack has two types of IPsec offload - crypto and packet.
> > Specifically, the ip xfrm command has sub-commands for "state" and
> > "policy" that have an "offload" parameter. With ip xfrm state, both
> > crypto and packet offload types are supported, while ip xfrm policy can
> > only be offloaded in packet mode.
> > 
> > The series introduces two new boolean attributes of a port function:
> > ipsec_crypto and ipsec_packet. The goal is to provide a similar level of
> > granularity for controlling VF IPsec offload capabilities, which would
> > be aligned with the software model. This will allow users to decide if
> > they want both types of offload enabled for a VF, just one of them, or
> > none at all (which is the default).
> > 
> > At a high level, the difference between the two knobs is that with
> > ipsec_crypto, only XFRM state can be offloaded. Specifically, only the
> > crypto operation (Encrypt/Decrypt) is offloaded. With ipsec_packet, both
> > XFRM state and policy can be offloaded. Furthermore, in addition to
> > crypto operation offload, IPsec encapsulation is also offloaded. For
> > XFRM state, choosing between crypto and packet offload types is
> > possible. From the HW perspective, different resources may be required
> > for each offload type.
> 
> What's going on with all the outstanding nVidia patches?!
> The expectation is 1 series per vendor / driver. Let's say
> 2 if there are core changes. You had 5 outstanding today.

I sent only three security related series, two of three were already reviewed
and waiting to be applied [1,2]. This third series is only one which touches core.

It is very strange to expect 1 series per vendor/driver without taking
into account the size of that driver and the amount of upstream work
involvement from that vendor.

Thanks

[1] https://patchwork.kernel.org/project/netdevbpf/list/?series=774239&state=*
[2] https://patchwork.kernel.org/project/netdevbpf/list/?series=775702

> 
> I'm tossing this out.
> -- 
> pw-bot: defer

