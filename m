Return-Path: <netdev+bounces-102479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F699032E5
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624732807B1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 06:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615CF171099;
	Tue, 11 Jun 2024 06:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E51EA8F
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088099; cv=none; b=TGl+pNGyTTXWslhwk+uhSijDS7bvnfOvIdhea56pUC9oTzTAopeZ4FH7ENSAH73QX5MsV9Wp8RNdCI5G3Nb3FhaRcFY4XMn3XuvmucZP0E2TP2JjenzgkoUEC5XSHYkhfuoWWfEplDUenzIlOSTFF4oDsPr196qP1yGnt80rAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088099; c=relaxed/simple;
	bh=uskY9MnjTKR/krka3YZBq0QHtE/FoUdLGC9SIxB7kWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFrTm6ni8CTjIbfMMGtgxUfnCf+oCbP4jFJJ9lnE8rHPwxxbjcHlfmyKqdqhuQx493etQlZ8ujemr1tzbYInTiiRf50SEWg1r5qi1gh8B3FJx9PqXs0F7Ida0msLgdNgfcZGVBhW79vREiOIhpiZ4Ig1VO1LMPyVX0Vm5leA+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0211F67373; Tue, 11 Jun 2024 08:41:33 +0200 (CEST)
Date: Tue, 11 Jun 2024 08:41:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>,
	Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240611064132.GA6727@lst.de>
References: <20240529160053.111531-1-aaptel@nvidia.com> <20240530183906.4534c029@kernel.org> <20240531061142.GB17723@lst.de> <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me> <20240610122939.GA21899@lst.de> <9a03d3bf-c48f-4758-9d7f-a5e7920ec68f@grimberg.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a03d3bf-c48f-4758-9d7f-a5e7920ec68f@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 10, 2024 at 05:30:34PM +0300, Sagi Grimberg wrote:
>> efficient header splitting in the NIC, either hard coded or even
>> better downloadable using something like eBPF.
>
> From what I understand, this is what this offload is trying to do. It uses
> the nvme command_id similar to how the read_stag is used in iwarp,
> it tracks the NVMe/TCP pdus to split pdus from data transfers, and maps
> the command_id to an internal MR for dma purposes.
>
> What I think you don't like about this is the interface that the offload 
> exposes
> to the TCP ulp driver (nvme-tcp in our case)?

I don't see why a memory registration is needed at all.

The by far biggest painpoint when doing storage protocols (including
file systems) over IP based storage is the data copy on the receive
path because the payload is not aligned to a page boundary.

So we need to figure out a way that is as stateless as possible that
allows aligning the actual data payload on a page boundary in an
otherwise normal IP receive path.

