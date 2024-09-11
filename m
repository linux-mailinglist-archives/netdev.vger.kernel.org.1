Return-Path: <netdev+bounces-127261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ECC974C7A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D2FB20F1F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF90E14A4C9;
	Wed, 11 Sep 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEEb50lc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD822143878;
	Wed, 11 Sep 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042907; cv=none; b=jBaVAfCShqkt12oZe89mMsjvTG8dg5BCeK5nN2D/xiqBktcdParGBHNilWdOcVKk+1lZurvoJyGqZipddU1VNKabvJ48fotG5Yx3GD9wPUxR7WNgeHtMi0DR/MkXXyGgOYrXs7KjoczR+bq/xeooKWC2fIsm34CqvzaUTqSKip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042907; c=relaxed/simple;
	bh=d9CWkENHYECimcCbv2Nzyo7IuDqs8fs5iCgcTQ1TaBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8ICvCDy/pgxcrI+aAR6HZFOWidDnnbBqb5SKDf61sDRmf/mnywytE+QlLbjYKlbMDxMyEWyHB6BhGo8/Poh9dS4UYEr1RwFyvTOSPaOgpyh3ItzIa+C3clvTpTWneUzWxjdKmXkrhY+zA5eGPPtCKmgENDuWJPCJV5MOQeBuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEEb50lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C168C4CEC5;
	Wed, 11 Sep 2024 08:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726042907;
	bh=d9CWkENHYECimcCbv2Nzyo7IuDqs8fs5iCgcTQ1TaBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rEEb50lcAVIJ9JW+AO5gZKSU35/2LW/DZyBcLvVVPyNMoBn8seX5VYnngPNZh5HwQ
	 F2AoQwNVp1VmLmQmaPojWfEFPCtigb9IaIftEfQUvReVHrAetnZAV8SvTr76TkaKyM
	 oE39prU0u0/l5j5kDqCRYeiq5HL7/0wfWulrnTCvsPr+57kNNUNFPktbdBo/Tr9aAJ
	 ANonIlnq20kycEzN97nGcRSGdJ90e7usr5kJg/aBcF8FWFMbROa8hcZHjfBprUIeJs
	 SAKy9ViDlsdrdxKi9YXFLb1EipOCea9Hs1mcOQTEPA71oW1f6yUg7S24meJqg1fSTp
	 OChWbYvzEw8Bw==
Date: Wed, 11 Sep 2024 09:21:42 +0100
From: Simon Horman <horms@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Jeongjun Park <aha310510@gmail.com>,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	ricardo@marliere.net, m-karicheri2@ti.com,
	n.zhandarovich@fintech.ru, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+02a42d9b1bd395cbcab4@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+c229849f5b6c82eba3c2@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: hsr: prevent NULL pointer dereference in
 hsr_proxy_announce()
Message-ID: <20240911082142.GA678243@kernel.org>
References: <20240907190341.162289-1-aha310510@gmail.com>
 <20240909105822.16362339@wsk>
 <20240910191517.0eeaa132@kernel.org>
 <20240911100007.31d600fc@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911100007.31d600fc@wsk>

+ Edward Adam Davis, syzbot+c229849f5b6c82eba3c2

On Wed, Sep 11, 2024 at 10:00:07AM +0200, Lukasz Majewski wrote:
> Hi Jakub,
> 
> > On Mon, 9 Sep 2024 10:58:22 +0200 Lukasz Majewski wrote:
> > > > In the function hsr_proxy_annouance() added in the previous
> > > > commit 5f703ce5c981 ("net: hsr: Send supervisory frames to HSR
> > > > network with ProxyNodeTable data"), the return value of the
> > > > hsr_port_get_hsr() function is not checked to be a NULL pointer,
> > > > which causes a NULL pointer dereference.    
> > > 
> > > Thank you for your patch.
> > > 
> > > The code in hsr_proxy_announcement() is _only_ executed (the timer
> > > is configured to trigger this function) when hsr->redbox is set,
> > > which means that somebody has called earlier iproute2 command:
> > > 
> > > ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink
> > > lan3 supervision 45 version 1  
> > 
> > Are you trying to say the patch is correct or incorrect?
> 
> I'm just trying to explain that this code (i.e.
> hsr_proxy_announcement()) shall NOT be trigger if the interlink port is
> not configured.
> 
> Nonetheless the patch is correct - as it was pointed out that the return
> value is not checked.
> 
> > The structs have no refcounting - should the timers be deleted with
> > _sync() inside hsr_check_announce()?
> 
> The timers don't need to be conditionally enabled (and removed) as we
> discussed it previously (as they only do useful work when they are
> configured and almost take no resources when declared during the
> driver probe).
> 
> Anyway:
> 
> Acked-by: Lukasz Majewski <lukma@denx.de>

Thanks,

Like Jakub I was a little confused about the intent of your previous
comment, but it is clear now.

It seems that along the way the patch got marked as rejected, presumably on
the basis of earlier discussion in this thread. But that seems
inappropriate now, so let me see if this will bring it back under
consideration.

pw-bot: under-review

For reference, the same change was also submitted as:
- [PATCH net] net: hsr: Fix null-ptr-deref in hsr_proxy_announce
  https://lore.kernel.org/all/tencent_CF67CC46D7D2DBC677898AEEFBAECD0CAB06@qq.com/

I will attempt to somehow mark that as a duplicate in patchwork.

It also seems that there are duplicate syzbot reports for this problem [1][2]
I will also attempt to mark [2] as a duplicate of [1].

[1] https://syzkaller.appspot.com/bug?extid=02a42d9b1bd395cbcab4
[2] https://syzkaller.appspot.com/bug?extid=c229849f5b6c82eba3c2

