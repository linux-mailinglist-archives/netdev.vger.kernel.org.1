Return-Path: <netdev+bounces-77560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7858722F9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9AA287739
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC63127B68;
	Tue,  5 Mar 2024 15:39:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170B7127B58;
	Tue,  5 Mar 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653150; cv=none; b=R3MiR/xUDxKpHbrxebgNkkSJb3bAmzm3GDP068vl4O3+Cdr5VBS+KWM2OhZGBgFtp6txIlS6C9hrVQM0Ojs8NvlK4/F3dM2PCV6PVLq+MQJ4UElAo/Cfbh7qMm6bgEX0osFfETh3km2tumuzh3MxrAr3t/28zS71EwBmLVno1tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653150; c=relaxed/simple;
	bh=BaWF9e3OkLvVaDKSKCD2UZE8oWvNbIrWZQvNULYC7tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh1n8iqyTUkQl+0CdTsnbnubdtoD1GikLohl25vbP8XcnbVZ+GJ4xySllUyobih5WslDxW0h03Ar1veoNeq6PvEwoYEzDG9zlXaUB3vz9XyXUj7o9+n2dNquRtkGlll2koOYSVQeN/taKEIqZMbLjq+Bvi5SdmhWFOkVzP+3zuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.33.11] (port=47632 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rhWsg-00E3ER-VP; Tue, 05 Mar 2024 16:39:04 +0100
Date: Tue, 5 Mar 2024 16:39:02 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Breno Leitao <leitao@debian.org>
Cc: Harald Welte <laforge@gnumonks.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	horms@kernel.org, dsahern@kernel.org,
	"open list:GTP (GPRS Tunneling Protocol)" <osmocom-net-gprs@lists.osmocom.org>
Subject: Re: [PATCH net-next 2/3] net: gtp: Remove generic .ndo_get_stats64
Message-ID: <Zec8ln0UnRO9UNrm@calendula>
References: <20240305121524.2254533-1-leitao@debian.org>
 <20240305121524.2254533-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240305121524.2254533-2-leitao@debian.org>
X-Spam-Score: -1.9 (-)

On Tue, Mar 05, 2024 at 04:15:22AM -0800, Breno Leitao wrote:
> Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
> configured") moved the callback to dev_get_tstats64() to net core, so,
> unless the driver is doing some custom stats collection, it does not
> need to set .ndo_get_stats64.
> 
> Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
> doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
> function pointer.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

