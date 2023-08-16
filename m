Return-Path: <netdev+bounces-28260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D02277ECF3
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 00:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AB61C21238
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D221ADD9;
	Wed, 16 Aug 2023 22:15:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711721ADCA
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 22:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8F6C433C8;
	Wed, 16 Aug 2023 22:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692224141;
	bh=NuhmcN2ER4D9ZDQQ0f+Ag2O5dY5T+kAxo2wMdH+cjD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ce9z3yZ2B9+I+yfh+JHiA3YT2LN7Oj2G9u6cNj5ybvfJRrFi6UhDLWHtvI934k5lb
	 A5KDKjvwVuJFPs0OxJTwhGGfFYzGzAzFT4aIjzg0wB4qG/CiVg9Jja1ZhGwZ0BSm38
	 73x0xzmQR6ZcIQHT3UuCz/1i5Q5DpXseANh2Tt9M3Z1U7uxUMV4M8OysLPjtBk5GJB
	 PVbO54zwoUDlqk918ijdH7l2O3omKEIx376+fD3CWOGAFBTb1KQ1Y9A53/r/Z4GUea
	 aXUJ8W16EwZ59ZCW/vXGr+sK0CGVTS+2iKskUmOg4eP5zWjqtO2K2NvsHrTfqiPXrj
	 tX3lNxn38AyTw==
Date: Wed, 16 Aug 2023 17:15:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net/mlx5: Convert PCI error values to generic errnos
Message-ID: <20230816221538.GA301788@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZN1JsroNi8iKSGNf@x130>

On Wed, Aug 16, 2023 at 03:12:02PM -0700, Saeed Mahameed wrote:
> On 16 Aug 17:04, Bjorn Helgaas wrote:
> > On Wed, Aug 16, 2023 at 02:45:15PM -0700, Saeed Mahameed wrote:
> > > On 14 Aug 17:32, Bjorn Helgaas wrote:
> > > > On Mon, Aug 14, 2023 at 04:27:20PM +0300, Ilpo Järvinen wrote:
> > > > > mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
> > > > > errnos.
> > > > >
> > > > > Convert the PCI specific error values to generic errno using
> > > > > pcibios_err_to_errno() before returning them.
> > > > >
> > > > > Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
> > > > > Fixes: 212b4d7251c1 ("net/mlx5: Wait for firmware to enable CRS before pci_restore_state")
> > > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > >
> > > > > ---
> > > > >
> > > > > Maintainers beware, this will conflict with read+write -> set/clear_word
> > > > > fixes in pci.git/pcie-rmw. As such, it might be the easiest for Bjorn to
> > > > > take it instead of net people.
> > > >
> > > > I provisionally rebased and applied it on pci/pcie-rmw.  Take a look
> > > > and make sure I didn't botch it -- I also found a case in
> > > > mlx5_check_dev_ids() that looks like it needs the same conversion.
> > > >
> > > > The commit as applied is below.
> > > >
> > > > If networking folks would prefer to take this, let me know and I can
> > > > drop it.
> > > 
> > > I Just took this patch into my mlx5 submission queue and sent it to netdev
> > > tree, please drop it from your tree.
> > 
> > OK, will do.  Note that this will generate a conflict between netdev
> > and the PCI tree during the merge window.
> > 
> 
> In such case let me drop it and you submit it, I was worried it will
> conflict with another ongoing feature in mlx5, but I am almost sure it
> won't be ready this cycle, so no reason to panic, you can take the patch to
> the pci tree and I will revise my PR, it's not too late.

OK, I'll keep it, I think that will be easier all around.

Bjorn

