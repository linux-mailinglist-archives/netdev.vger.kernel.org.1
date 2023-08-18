Return-Path: <netdev+bounces-28923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6A77812C6
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7725F282457
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5681B7CC;
	Fri, 18 Aug 2023 18:21:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5163A0
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884BBC433CA;
	Fri, 18 Aug 2023 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692382864;
	bh=5fxqgQEkZHL6btJ4/Au0C0GLYzcSoQRp1lYvf5OMydU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuQYz5if+ijqMRJwbHBOnMHfraDlqs9NUUkc1TnPej4p5XJgz1qSzQzZJGocMaYWV
	 j6Q4bZww5+8VBScmlvzqoV+aNUVxK90By8eOgRY6Uh5YBbPtjh9rjV5+AjY20VuLPV
	 6UPAPgGebVn5YtbloV1ZgIUoyotS8hxCZFYc81m6BDKPmnbGwvr0qHyf6qAPZ3z5Yq
	 MrKoAnqEKhmDQlyAnuQZN8R4R6L4WT0rQmWvOkU7V5Kz0RIOKgoCsWziTvWZOEF+Ty
	 kPmQ07HrdgGM9ysbz2xXxqpDvUA2agamctMdAZ6DtDWnY5rhdE72HU+SmDlKkjGfU+
	 b35pI6Fpp5edg==
Date: Fri, 18 Aug 2023 21:20:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next] ice: store VF's pci_dev ptr in ice_vf
Message-ID: <20230818182059.GZ22185@unreal>
References: <20230816085454.235440-1-przemyslaw.kitszel@intel.com>
 <20230816143148.GX22185@unreal>
 <c1f65aa1-3e20-9e21-1994-1190bf0086b7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f65aa1-3e20-9e21-1994-1190bf0086b7@intel.com>

On Fri, Aug 18, 2023 at 02:20:51PM +0200, Przemek Kitszel wrote:
> On 8/16/23 16:31, Leon Romanovsky wrote:
> > On Wed, Aug 16, 2023 at 04:54:54AM -0400, Przemek Kitszel wrote:
> > > Extend struct ice_vf by vfdev.
> > > Calculation of vfdev falls more nicely into ice_create_vf_entries().
> > > 
> > > Caching of vfdev enables simplification of ice_restore_all_vfs_msi_state().
> > 
> > I see that old code had access to pci_dev * of VF without any locking
> > from concurrent PCI core access. How is it protected? How do you make
> > sure that vfdev is valid?
> > 
> > Generally speaking, it is rarely good idea to cache VF pci_dev pointers
> > inside driver.
> > 
> > Thanks
> 
> Overall, I do agree that ice driver, as a whole, has room for improvement in
> terms of synchronization, objects lifetime, and similar.
> 
> In this particular case, I don't see any reason of PCI reconfiguration
> during VF lifetime, but likely I'm missing something?

You are caching VF pointer in PF, and you are subjected to PF lifetime
and not VF lifetime.

Thanks

