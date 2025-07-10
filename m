Return-Path: <netdev+bounces-205975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98251B01002
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 02:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E20B1888400
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5C7307AD3;
	Thu, 10 Jul 2025 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEY/ZBhs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60AD29ACDE;
	Thu, 10 Jul 2025 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191933; cv=none; b=NVArzqkhbqyyA+lnS0HFkMeIpG1DD0S2+okKdPyxyyYpa0obWxXQ0AtXOr+2Ntg3c4/8rnPFWfqgVNuqRczIDrFPdJpzekIKPDGpuufRy+9mjzUVBE1R9llUBHaPK1E10EkpEznYGxP34bYKz0MaxpToRe0PVDGaHcfQrERDsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191933; c=relaxed/simple;
	bh=RZSiQFQ5CJhU/h0mQJuZBqy5Y/7NgeYrUN8qKuNGZaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCzSRk1kbeK/4y05Aw0WudUjF0bnujMTlP6oNPHvLcA/gP89I5iKWUkMi1oatf8cuybuupV05abFvUSShqUWNmkNgoqNfPc61xVK2ez/6pz6p989O0fAxw7KCPc0yFbLCR0VCszYSvKtIckF8SAWMXJLNT4XbrFA8lsCLERUt68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEY/ZBhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37E5C4CEE3;
	Thu, 10 Jul 2025 23:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752191933;
	bh=RZSiQFQ5CJhU/h0mQJuZBqy5Y/7NgeYrUN8qKuNGZaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LEY/ZBhsaDpXenP21NMpx/v0+GdIHZP9qq9rcGq2t9XFbjm0DCSeVg/OP/j+KFDuu
	 pLeuPg9fW/WQmiVRfAG/xwR0KitIoLbBTC+xJcj7MgQFrAqTQX4Qleugflp04piT0t
	 9a+1uquoUkghyvYfix+SAtquNSpkwsnS4938SK+Ptg6cMTtMbm46w1mbyRniOsQ+Hr
	 MAbPeSmLgAAATN+WIFgvc/b3phu3mDCF8tEv+babk1Uyg4sV8axpK6cCJQwT8pLDbL
	 pFkzjcxZKkYh1Pk0Qcao5jxlna3CdJovmJlWsRLNHcqZ7DaFQ4AUxXbdZrA2Sp9KkJ
	 nOzF8zO051G3A==
Date: Thu, 10 Jul 2025 16:58:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "almasrymina@google.com"
 <almasrymina@google.com>, "asml.silence@gmail.com"
 <asml.silence@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Message-ID: <20250710165851.7c86ba84@kernel.org>
In-Reply-To: <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
	<20250702172433.1738947-2-dtatulea@nvidia.com>
	<20250702113208.5adafe79@kernel.org>
	<c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
	<20250702135329.76dbd878@kernel.org>
	<CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 11:58:50 +0000 Parav Pandit wrote:
> > In my head subfunctions are a way of configuring a PCIe PASID ergo they
> > _only_ make sense in context of DMA.  
> SF DMA is on the parent PCI device.
> 
> SIOV_R2 will have its own PCI RID which is ratified or getting ratified.
> When its done, SF (as SIOV_R2 device) instantiation can be extended
> with its own PCI RID. At that point they can be mapped to a VM.

AFAIU every PCIe transaction for a queue with a PASID assigned
should have a PASID prefix. Why is a different RID necessary?
CPUs can't select IOMMU context based on RID+PASID?

