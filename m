Return-Path: <netdev+bounces-29285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F50F78277E
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17313280E77
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D2E5221;
	Mon, 21 Aug 2023 11:01:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AE4C7D
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 11:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD4EC433C8;
	Mon, 21 Aug 2023 11:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692615710;
	bh=S4a8g3g8apaEmqmUxzFGUGuj/O5FXcWNOgUHgFy7xWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9vbORbijEtOyv7Du8LhvIQliLo8lOQ1y5wTjmlAyaxaokYCa0G0Whh0mHMCVOJ3K
	 wlZMfeaFHkm7tPwD8YwGgKTKYT2NBAaa2zqE92zfcblAboa+NZzIMuc4XmLPh1oLBl
	 Y2iI1EB9uyNgwry18gRk6Rny4tr/4im7sJLk3rtbvY+uKeoAXmewKQJEZKwuQVP4f+
	 mD3NdBap+QixSrrG38nr3j9xRTfvmP+Bn7sHfFzypSHLDtRWfZHy6Dk8+8VVQp+Px0
	 cJvtZZBTQyY5mMUQEZ4XsR5j6gbpAALMjLTiUOTdrTVwb0yENKlr75xkRIbg963CVZ
	 TO+HCXimT1AXQ==
Date: Mon, 21 Aug 2023 14:01:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next] ice: store VF's pci_dev ptr in ice_vf
Message-ID: <20230821110146.GA6583@unreal>
References: <20230816085454.235440-1-przemyslaw.kitszel@intel.com>
 <20230816143148.GX22185@unreal>
 <c1f65aa1-3e20-9e21-1994-1190bf0086b7@intel.com>
 <20230818182059.GZ22185@unreal>
 <12025d38-a5e2-5ddd-721f-c1c083785d22@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12025d38-a5e2-5ddd-721f-c1c083785d22@intel.com>

On Mon, Aug 21, 2023 at 12:48:40PM +0200, Przemek Kitszel wrote:
> On 8/18/23 20:20, Leon Romanovsky wrote:
> > On Fri, Aug 18, 2023 at 02:20:51PM +0200, Przemek Kitszel wrote:
> > > On 8/16/23 16:31, Leon Romanovsky wrote:
> > > > On Wed, Aug 16, 2023 at 04:54:54AM -0400, Przemek Kitszel wrote:
> > > > > Extend struct ice_vf by vfdev.
> > > > > Calculation of vfdev falls more nicely into ice_create_vf_entries().
> > > > > 
> > > > > Caching of vfdev enables simplification of ice_restore_all_vfs_msi_state().
> > > > 
> > > > I see that old code had access to pci_dev * of VF without any locking
> > > > from concurrent PCI core access. How is it protected? How do you make
> > > > sure that vfdev is valid?
> > > > 
> > > > Generally speaking, it is rarely good idea to cache VF pci_dev pointers
> > > > inside driver.
> > > > 
> > > > Thanks
> > > 
> > > Overall, I do agree that ice driver, as a whole, has room for improvement in
> > > terms of synchronization, objects lifetime, and similar.
> > > 
> > > In this particular case, I don't see any reason of PCI reconfiguration
> > > during VF lifetime, but likely I'm missing something?
> > 
> > You are caching VF pointer in PF,
> 
> that's correct that the driver is PF/ice
> 
> > and you are subjected to PF lifetime
> > and not VF lifetime.
> 
> this belongs to struct ice_vf, which should have VF lifetime,
> otherwise it's already at risk

I'm not so sure about it. ICE used to use devm_* API and not explicit
kalloc/kfree calls, it is not clear anymore the lifetime scope of VF
structure.

Thanks

> 
> > 
> > Thanks
> 
> Thank you!

