Return-Path: <netdev+bounces-28019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA177DEFC
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417A81C20F78
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6339DF57;
	Wed, 16 Aug 2023 10:39:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FBD538
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 10:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3381C433C9;
	Wed, 16 Aug 2023 10:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692182386;
	bh=MRetp+mthtTQGmL7T5j+BczQX/Vw3Rtm3ObQfcDoZKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbCijEa/eJnCOWqRy8VzF7KKp7w1o8thAmGC3Df3i6mtXA+9pkIeIFsehrwYVYjhO
	 5LRfEONyqLbWetbGQUFCRLY/HqGxpkHw2MCrAfxaYfVSOpbCLmf6FZrckPjN3ro6Sx
	 /1fJvtu4kVrrdCq7kDp3PfL5Adseg+Nke0EL8mHs49BgrdC8OGTlZLmVKvXOG317MK
	 VI9RtFOVrAdZN4tFHH1eGpvgJ4zt0v3nGO4OJT7Gf7XcxJ2GQK/B3h+hzUy2+m/1Z9
	 UbahnBNQY7PTBc/xPFEpFwGyvwkmXY8w3CNfXqDkRd18STsd84G2ucMyL6h7zs6Ld6
	 pURRKuYHxIB0w==
Date: Wed, 16 Aug 2023 13:39:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, liwei391@huawei.com,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH net-next] pds_core: remove redundant pci_clear_master()
Message-ID: <20230816103941.GW22185@unreal>
References: <20230816013802.2985145-1-liaoyu15@huawei.com>
 <20230816063820.GV22185@unreal>
 <c232243d-0c5a-c253-5e3b-81be2479b776@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c232243d-0c5a-c253-5e3b-81be2479b776@huawei.com>

On Wed, Aug 16, 2023 at 05:39:33PM +0800, Yu Liao wrote:
> On 2023/8/16 14:38, Leon Romanovsky wrote:
> > On Wed, Aug 16, 2023 at 09:38:02AM +0800, Yu Liao wrote:
> >> pci_disable_device() involves disabling PCI bus-mastering. So remove
> >> redundant pci_clear_master().
> > 
> > I would say that this commit message needs to be more descriptive and
> > explain why pci_disable_device() will actually disable PCI in these
> > flows.
> > 
> > According to the doc and code:
> >   2263  * Note we don't actually disable the device until all callers of 
> >   2264  * pci_enable_device() have called pci_disable_device().
> > 
> > Thanks
> > 
> Thank you for the review. My bad, I didn't describe it clearly in commit
> message. I will send the v2 version and add the following explanation:
> 
> do_pci_disable_device() disable PCI bus-mastering as following:
> static void do_pci_disable_device(struct pci_dev *dev)
> {
> 		u16 pci_command;
> 
> 		pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> 		if (pci_command & PCI_COMMAND_MASTER) {
> 				pci_command &= ~PCI_COMMAND_MASTER;
> 				pci_write_config_word(dev, PCI_COMMAND, pci_command);
> 		}
> 
> 		pcibios_disable_device(dev);
> }
> And pci_disable_device() sets dev->is_busmaster to 0.
> 
> So for pci_dev that has called pci_enable_device(), pci_disable_device()
> involves disabling PCI bus-mastering. Remove redundant pci_clear_master() in
> the following places:
> - In error path 'err_out_clear_master' of pdsc_probe(), pci_enable_device()
> has already been called.
> - In pdsc_remove(), pci_enable_device() has already been called in pdsc_probe().

All that you need to add is a sentence that pci_enable_device() is
called only once before calling to pci_disable_device() and such
pci_clear_master() is not needed.

Thanks

