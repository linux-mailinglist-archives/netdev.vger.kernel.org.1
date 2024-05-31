Return-Path: <netdev+bounces-99647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4007B8D5A58
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A541C220A2
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BA07CF3A;
	Fri, 31 May 2024 06:11:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6118756E
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135908; cv=none; b=PZd+lryNq7LO+MMlz/ZoJU3WckQSODeIw5qzqnZbMizjzOSysmVPhoQov1UgI6sfelVYzErDvDWcrdFYyfKovtSSSVKUPnIFIuWRqE/JjqJYuZ/y7XRQS3eUGF+H9WUXfswg+ii2l+lhDBu/t16tHku6tXbUHWKvWrs5vZPBTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135908; c=relaxed/simple;
	bh=AmasDR+otOnl56tQPz85WAEVuHqLctJDiw0lgDk98bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWmda7bwjuBmnX10l/qgZvIhX03quCOppxRBz+KbHZkykpzsHyLxcLj21qWjQgIZqBPgbmjybabddYwsWEUwdGmI3emtXz7u4FkdYfTyWblTJE9DSSDK2k9XEsn9sOSPno+XTX0Ht3ezmFLM1Tzuh4usV1byZmGBWVUOBLkTi40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F19E768BFE; Fri, 31 May 2024 08:11:42 +0200 (CEST)
Date: Fri, 31 May 2024 08:11:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de,
	kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com,
	davem@davemloft.net
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240531061142.GB17723@lst.de>
References: <20240529160053.111531-1-aaptel@nvidia.com> <20240530183906.4534c029@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530183906.4534c029@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

FYI, I still absolutely detest this code.  I know people want to
avoid the page copy for NVMe over TCP (or any TCP based storage
protocols for that matter), but having these weird vendors specific
hooks all the way up into the application protocol are just horrible.

IETF has standardized a generic data placement protocol, which is
part of iWarp.  Even if folks don't like RDMA it exists to solve
exactly these kinds of problems of data placement.   And if we can't
arse folks into standard data placement methods we at least need it
vendor independent and without hooks into the actual protocol
driver.


