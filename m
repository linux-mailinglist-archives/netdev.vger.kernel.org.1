Return-Path: <netdev+bounces-234570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5075EC234B9
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 06:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EFF5F34B805
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 05:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9264F2D248E;
	Fri, 31 Oct 2025 05:39:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E25B2D060B
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761889144; cv=none; b=flvrDC6I8UAOk9V+tEAX0k/TO/stnGJECKPuOq2J0028PcHnXHbf90kx/X+stj4T/uoRS6yBOEkRfVUSplGn4O5lZParV/fKKn/R5MVADrIbjvwIWeCK1QSeMGehPG1fK2XgTsq8rvup7ZjKHXAK2fRbpBIT8LW1z8CTPlD96U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761889144; c=relaxed/simple;
	bh=9B4PxnWoGNaVpGuDpPXyKPVllYYYGF3TeYjrkV2rP/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEl0z1flfNTVb0vXxhnNLLy3jrUBoCphx1FsnIDE8zpM1alDvu7oEhU5cfYh3yx1P6NIA2RlcmWnrLwxgVv3GnBObwnzIFQWZvZ2vBPNoB37ERIAHi6DwHU3u+XhGJNzgDWViSRNjDL6pc7E743szpynvRRoK9kNhmFz88yTX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 0C2912C0009F;
	Fri, 31 Oct 2025 06:38:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C5D9E5B97; Fri, 31 Oct 2025 06:38:57 +0100 (CET)
Date: Fri, 31 Oct 2025 06:38:57 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Dave Airlie <airlied@gmail.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: DRM_RAS for CPER Error logging?!
Message-ID: <aQRLccLXfgfoWaIP@wunner.de>
References: <20250929214415.326414-4-rodrigo.vivi@intel.com>
 <aQEVy1qjaDCwL_cc@intel.com>
 <aQN6dqFdrXxLKWlI@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQN6dqFdrXxLKWlI@intel.com>

On Thu, Oct 30, 2025 at 10:47:18AM -0400, Rodrigo Vivi wrote:
> On Tue, Oct 28, 2025 at 03:13:15PM -0400, Rodrigo Vivi wrote:
> > On Mon, Sep 29, 2025 at 05:44:12PM -0400, Rodrigo Vivi wrote:
> > 
> > Hey Dave, Sima, AMD folks, Qualcomm folks,
> 
> + Netlink list and maintainers to get some feedback on the netlink usage
> proposed here.
> 
> Specially to check if there's any concern with CPER blob going through
> netlink or if there's any size limitation or concern.

How large are those blobs?  If the netlink message exceeds PAGE_SIZE
because of the CPER blob, a workaround might be to attach it to the
skb as fragments with skb_add_rx_frag().

Thanks,

Lukas

