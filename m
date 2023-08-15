Return-Path: <netdev+bounces-27745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89C977D160
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BDC1C20D3D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF65815AF1;
	Tue, 15 Aug 2023 17:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC067156D9
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 17:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68793C433C8;
	Tue, 15 Aug 2023 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692122003;
	bh=GOak072BFC7ziggrFR1E9dx0zzdh0OfsZQfwC1s5c9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=n7VD8FzJIQvGoiOXutzUdDlv6E+U+upfkoDYtfe90NjhVLE/feuYSIKR107g7/L7w
	 QYN9ItihXlExBQZBS4JVhXyuUJIk8eLARFON1c3CP5i+AOSXeQJbHGxG61yTHhy/R7
	 iTghugWl7Gxdsl00KMiw7pKo1LrsYLD3UhLA1qCEBj/UGypYhEQGwC3WtnwKElWzRi
	 dhDAGIN3//aW5QYslnkkmrCXTlWc5oexK3IVrwr9f0vqYlwTYjdjTTVtZp/VuAOry7
	 KOUYLdT/vSstR9tx9lNWYqg3WjfrIxoc0LKEz/S1XD9MOmYQIFhc0+4DbhdjdQdcJE
	 LDldZfzSTFgxg==
Date: Tue, 15 Aug 2023 12:53:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@mellanox.com>, Netdev <netdev@vger.kernel.org>,
	linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] net/mlx5: Convert PCI error values to generic errnos
Message-ID: <20230815175321.GA232277@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91ccdd4-797-5d8b-d5c9-5fef5742575@linux.intel.com>

On Tue, Aug 15, 2023 at 02:31:05PM +0300, Ilpo Järvinen wrote:
> On Mon, 14 Aug 2023, Bjorn Helgaas wrote:
> > On Mon, Aug 14, 2023 at 04:27:20PM +0300, Ilpo Järvinen wrote:
> > > mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
> > > errnos.
> > > ...

> > > I wonder if these PCIBIOS_* error codes are useful at all?
> > > There's 1:1 mapping into errno values so no information loss if
> > > the functions would just return errnos directly. Perhaps this is
> > > just legacy nobody has bothered to remove? If nobody opposes, I
> > > could take a look at getting rid of them.
> > 
> > I don't think the PCIBIOS error codes are very useful outside of
> > arch/x86.  They're returned by x86 PCIBIOS functions, and I think we
> > still use those calls, but I don't think there's value in exposing the
> > x86 error codes outside arch/x86.  Looks like a big job to clean it up
> > though ;)
> 
> Hmm... Do you mean pci_bios_read/write() in arch/x86/pci/pcbios.c?
> ...Because those functions are already inconsistent even with themselves, 
> returning either -EINVAL or the PCI BIOS error code (or what I assume that 
> masking of result to yield).

I didn't look up the code; I just think we still use those PCIBIOS
calls in some cases, so we need to know how to interpret the error
values returned by the BIOS.  IMHO it would be ideal if those PCIBIOS
errors got converted to Linux errnos before generic code saw them.

Bjorn

