Return-Path: <netdev+bounces-121620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F9F95DBEA
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 07:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C12831D1
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 05:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C08A176ADE;
	Sat, 24 Aug 2024 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lMdEzPXJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D7176AD3;
	Sat, 24 Aug 2024 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476722; cv=none; b=ThKb3iB5g4RYSWCucqCWiF5vSPOfxUGxj2rg4WezwgSwg/xEcThhQkdKFAgB9FnAYgNIrWdLzy0Sbd9avtbFZI/GqTiv1su+FpLtDIXf1fO3F4vcuo3W5XSFXWk8rTEtpfwdxtP2UoiVovUxtYyk+/x71J/NnS5bsMIbMHVUeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476722; c=relaxed/simple;
	bh=hHJWgBKuXeOe69Vvf7RycK3XWP+D8pPN+ddJcTti9Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spMbLOwotv5SMm3Zh+Uvuc8U9MWpLA/v6zioFqWazRYt7OC9qn91RENmvn0mvQ9q5q5tJdwDRMqx5p7NhTmqBtTDrnp+qKrwqfq9QHJ2Uz0cLI6pzyrcRzH4m/QOU4Bqv26SZE67RDINgdbQDwZDhYyBpCPhNxFmm0gPN6Wbc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lMdEzPXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5745FC32781;
	Sat, 24 Aug 2024 05:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476721;
	bh=hHJWgBKuXeOe69Vvf7RycK3XWP+D8pPN+ddJcTti9Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lMdEzPXJ3ErOh4jITECetrp/R42VAGfE03OHLPx+XdSTrPqzsWNmXvcxlis72e2mA
	 fOgeDaQTHMZxcNce61oZ8aIsZvL4YPA7EJK438t8vUwyTs/7EhTGbT3ZgARilcyAm3
	 w2CXgMR8zOcVAKyJgTuUW1iKsBnBYGQkpj1BotSA=
Date: Sat, 24 Aug 2024 11:29:50 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Timur Tabi <timur@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 4/4] net: qcom/emac: Prevent device_find_child() from
 modifying caller's match data
Message-ID: <2024082415-platform-shriek-2810@gregkh>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-4-8316b87b8ff9@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-const_dfc_prepare-v2-4-8316b87b8ff9@quicinc.com>

On Thu, Aug 15, 2024 at 10:58:05PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> To prepare for constifying the following old driver core API:
> 
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> to new:
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> The new API does not allow its match function (*match)() to modify
> caller's match data @*data, but emac_sgmii_acpi_match() as the old
> API's match function indeed modifies relevant match data, so it is not
> suitable for the new API any more, fixed by implementing a equivalent
> emac_device_find_child() instead of the old API usage.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/net/ethernet/qualcomm/emac/emac-sgmii.c | 36 +++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)

Can you rewrite this based on the cxl change to make it a bit more less
of a "wrap the logic in yet another layer" type of change like this one
is?

thanks,

greg k-h

