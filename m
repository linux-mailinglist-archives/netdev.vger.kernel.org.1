Return-Path: <netdev+bounces-28258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C041C77ECB5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 00:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3BE1C211EB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891951AA95;
	Wed, 16 Aug 2023 22:04:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3217ACD
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 22:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7781DC433C9;
	Wed, 16 Aug 2023 22:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692223467;
	bh=txLNeqeIlTzA3c3ZGM7wv254IDWW/apNpSXfcyFRTOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JthmWLJ6BL94doGkxDuRRC2ku3hEgZMa1G0pgVY82nzxLvEwk87TqyHZjaf6h2My1
	 2YgVuBGUDV6JN1i6pASDpzJLS03qElXtzOGXBN2Afvg7/t6ltOjLMVjBBcsmACA2NH
	 y0urXrlaGEDCVSjrarhqfOgDcrwMY1Q6ISDVWMqqiKl4gr0xU6yyg9TMyNoMVy3pKu
	 KFzLxRzqFoeU5G9OZHQkxAf+re20bQXfGN4oiGlcI3YdXYmEqq0lmEtj35hv9Jk+hF
	 6CRSMSU0AUnv90Z647K61Bdg9kLrfRBonwBo7wsoSSSoc13ZWE+cUaU0CfdWA8uFco
	 +/ky0DpFlCdPg==
Date: Wed, 16 Aug 2023 17:04:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net/mlx5: Convert PCI error values to generic errnos
Message-ID: <20230816220425.GA301099@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZN1Da7oOOKQ/FnxI@x130>

On Wed, Aug 16, 2023 at 02:45:15PM -0700, Saeed Mahameed wrote:
> On 14 Aug 17:32, Bjorn Helgaas wrote:
> > On Mon, Aug 14, 2023 at 04:27:20PM +0300, Ilpo Järvinen wrote:
> > > mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
> > > errnos.
> > > 
> > > Convert the PCI specific error values to generic errno using
> > > pcibios_err_to_errno() before returning them.
> > > 
> > > Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
> > > Fixes: 212b4d7251c1 ("net/mlx5: Wait for firmware to enable CRS before pci_restore_state")
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > 
> > > ---
> > > 
> > > Maintainers beware, this will conflict with read+write -> set/clear_word
> > > fixes in pci.git/pcie-rmw. As such, it might be the easiest for Bjorn to
> > > take it instead of net people.
> > 
> > I provisionally rebased and applied it on pci/pcie-rmw.  Take a look
> > and make sure I didn't botch it -- I also found a case in
> > mlx5_check_dev_ids() that looks like it needs the same conversion.
> > 
> > The commit as applied is below.
> > 
> > If networking folks would prefer to take this, let me know and I can
> > drop it.
> 
> I Just took this patch into my mlx5 submission queue and sent it to netdev
> tree, please drop it from your tree.

OK, will do.  Note that this will generate a conflict between netdev
and the PCI tree during the merge window.

Bjorn

