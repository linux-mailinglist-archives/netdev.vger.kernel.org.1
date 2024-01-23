Return-Path: <netdev+bounces-64954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9668386A0
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 06:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656B42860A5
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 05:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68BA23CA;
	Tue, 23 Jan 2024 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvdFL6uZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8C23BC;
	Tue, 23 Jan 2024 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986840; cv=none; b=g3y8cxjWYVdySk4LsbkxCRRw/jpwK72jqMQTBYY609swycPlzvVsJtR3PuASDGsSH7Z9BHUGVUOLphV0iyopTx5OGKR5P0rgEJqrb34HlXoQFPgjwCpneiJodmSCpxVArufoDL0JymAxCLO90iEE7WtKUM/5LxCyny8KTT8DgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986840; c=relaxed/simple;
	bh=fhmV7bfExKQCEsgl/PnFRTNkgnpRk+9YQUz/pKgzL8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipOq84AlHQIcoujDmaEnDSk+PMT29wmizz3LcvSHh78TBI+s15087em7Aizh9TVwLm3/OoIb0ic8QVbbaVFMLf4ja/9ACV9x2T3tT4++ZAXYsaNbegpGMP4HD4pPkNCWGg3N+heP1h/asL0xTXIsnOSDEqwCMTzizIb/zOY8OzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvdFL6uZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15931C433C7;
	Tue, 23 Jan 2024 05:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705986840;
	bh=fhmV7bfExKQCEsgl/PnFRTNkgnpRk+9YQUz/pKgzL8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PvdFL6uZA96KnHROnwXgqGmiOAil8xiYb4hg5rF8NE7xKj3EnivlGfutsjBfhhiDo
	 Oj7G6X1QYRQa9W20YVCrl0V4v6UsCCH3sRHwip3/7xq3UOyo9vUt45gRjNBVKeT/Nv
	 lPz/Bohz3MKgTGbyLfkpsD9PrwNcf7ttDO+4XzyUAkCF79hMhcLzBm92JknvtD2pUc
	 +81hfufL/dpycsHHImIXBuzZ0jAjsMQ+dvr90HKqIZVYI4pbvztETGbCSusd+NVlC1
	 /ZlN/q/b+5Wm4psovMVfNGrs/tnSNzYYQcfXydNCOq+hJhOfrenwcTovYRYPMhN12W
	 P5sXF0ECH1Yfg==
Date: Mon, 22 Jan 2024 21:13:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aahil Awatramani <aahila@google.com>
Cc: David Dillow <dave@thedillows.org>, Mahesh Bandewar
 <maheshb@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] bonding: Add independent control state
 machine
Message-ID: <20240122211357.767d4edd@kernel.org>
In-Reply-To: <20240122175810.1942504-2-aahila@google.com>
References: <20240122175810.1942504-1-aahila@google.com>
	<20240122175810.1942504-2-aahila@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 17:58:10 +0000 Aahil Awatramani wrote:
> +static inline void __disable_distributing_port(struct port *port)

The compiler will know what to inline, please drop the "inline"
use in C sources in this patch. It just hides unused function
warnings and serves no real purpose.
-- 
pw-bot: cr

