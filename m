Return-Path: <netdev+bounces-29940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691B37854AE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7B21C20C64
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6715AD2A;
	Wed, 23 Aug 2023 09:55:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BABA946
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 09:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C5FC433C8;
	Wed, 23 Aug 2023 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692784510;
	bh=374eqabuLD5eZtLmI9aX1HGOmzU8xfpSHRjCB9fqxSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPJ59HFn9aOZHGfmcupSI9/idOeQTnJA/Cnp/LpHRBpLqREKi9fJFqTe85zZI2+3B
	 2EB17ooMpxuZeujjaf7/gStxLs1MfLQ375Lr1+KQ5JvyS6Uo+55yGu0aTn0+tKl9tu
	 LoRg5kXtKU5LsWKvTiLheQ1atK8XnDI55J4PV8qsiUvpxXZORXuzge0tmAhin3i+n8
	 t4NCHQ9T8EzM7QVghb4zIr6F1G/SRuUgQ09QVaoGO8ufC68ShVXNQ8oGvaZ7JD7fUx
	 MQlgBx6SqQ3P+HRCOiQvtFs6aSjSqszNHkWlB9KmY5n5ho9WQ9RUm/RNO4zasLwjes
	 uVLLum77b8+Bg==
Date: Wed, 23 Aug 2023 12:55:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-next] ice: store VF's pci_dev ptr in ice_vf
Message-ID: <20230823095505.GQ6029@unreal>
References: <20230816085454.235440-1-przemyslaw.kitszel@intel.com>
 <20230816143148.GX22185@unreal>
 <c1f65aa1-3e20-9e21-1994-1190bf0086b7@intel.com>
 <20230818182059.GZ22185@unreal>
 <12025d38-a5e2-5ddd-721f-c1c083785d22@intel.com>
 <20230821110146.GA6583@unreal>
 <CO1PR11MB5089F6E24C2570F710191DE7D61FA@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB5089F6E24C2570F710191DE7D61FA@CO1PR11MB5089.namprd11.prod.outlook.com>

On Tue, Aug 22, 2023 at 08:46:46PM +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Monday, August 21, 2023 4:02 AM
> > To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Brandeburg, Jesse
> > <jesse.brandeburg@intel.com>; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org; Polchlopek, Mateusz <mateusz.polchlopek@intel.com>;
> > Keller, Jacob E <jacob.e.keller@intel.com>
> > Subject: Re: [PATCH iwl-next] ice: store VF's pci_dev ptr in ice_vf
> > 
> > On Mon, Aug 21, 2023 at 12:48:40PM +0200, Przemek Kitszel wrote:
> > > On 8/18/23 20:20, Leon Romanovsky wrote:
> > > > On Fri, Aug 18, 2023 at 02:20:51PM +0200, Przemek Kitszel wrote:
> > > > > On 8/16/23 16:31, Leon Romanovsky wrote:
> > > > > > On Wed, Aug 16, 2023 at 04:54:54AM -0400, Przemek Kitszel wrote:
> > > > > > > Extend struct ice_vf by vfdev.
> > > > > > > Calculation of vfdev falls more nicely into ice_create_vf_entries().
> > > > > > >
> > > > > > > Caching of vfdev enables simplification of
> > ice_restore_all_vfs_msi_state().
> > > > > >
> > > > > > I see that old code had access to pci_dev * of VF without any locking
> > > > > > from concurrent PCI core access. How is it protected? How do you make
> > > > > > sure that vfdev is valid?
> > > > > >
> > > > > > Generally speaking, it is rarely good idea to cache VF pci_dev pointers
> > > > > > inside driver.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Overall, I do agree that ice driver, as a whole, has room for improvement in
> > > > > terms of synchronization, objects lifetime, and similar.
> > > > >
> > > > > In this particular case, I don't see any reason of PCI reconfiguration
> > > > > during VF lifetime, but likely I'm missing something?
> > > >
> > > > You are caching VF pointer in PF,
> > >
> > > that's correct that the driver is PF/ice
> > >
> > > > and you are subjected to PF lifetime
> > > > and not VF lifetime.
> > >
> > > this belongs to struct ice_vf, which should have VF lifetime,
> > > otherwise it's already at risk
> > 
> > I'm not so sure about it. ICE used to use devm_* API and not explicit
> > kalloc/kfree calls, it is not clear anymore the lifetime scope of VF
> > structure.
> > 
> > Thanks
> > 
> 
> The ice_vf structure is now reference counted with a kref, and is created when VFs are added, and removed when the VF is removed.

Ohh, great, thanks

> 
> Thanks,
> Jake
> 
> 

