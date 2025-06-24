Return-Path: <netdev+bounces-200698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD92AE68F0
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643133B44E2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C90291894;
	Tue, 24 Jun 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxJyNGr3"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC62BF3FB;
	Tue, 24 Jun 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775482; cv=none; b=KD1eFM1ZpOKUTnVRe2uSeXv0DXt7AwdFhEDZq7fuIKPR/fbkQ3+9Pz6HkNFD1/I6tsPoROPbncTJs3C8Jic7etqpxtAKEJit+o3LraWTsKMVWwqZ/Suw5+kE3lT0bsycmUSafzNxbEWZ2p/cubYwWP8vR19XPMJ3LAkTw1CxSvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775482; c=relaxed/simple;
	bh=j+ytvJqs29JdtPQp6GtZV7bE8aZ/4cjCkXLPdp7rCXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N63NziM+raDSx5FajXxhWvV+bjLTcWoCCQ7rZIcKvFuK9jmut6BLlaDMUmPGTMqYwtKN5axDNr/lTqJmqOw1iYrm60ru/KTwq7MlhZINhzhA9GhlO7RsCre4mo5FUMwXmuE1B2KLUrVRN5FaH+FCFWsNBviKlGH1jAqm3MrE26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qxJyNGr3; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 374CF7A00AA;
	Tue, 24 Jun 2025 10:31:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Jun 2025 10:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750775479; x=1750861879; bh=j+ytvJqs29JdtPQp6GtZV7bE8aZ/4cjCkXL
	Pdp7rCXM=; b=qxJyNGr3AcRMQOgbEyQohxv5gHIopDglcfhTM1hADsafJ+p249A
	+lbRJW+R/qA+Yk4x1E8af/h4x78Jmpowa5GULh3p5PAaYfrDoM5ZnAI0bU5cgKlD
	LzwQlhetTr3GXZFY7pWgvfPpejk3G25RyoQAJroze1N70yHjCcPw7AaqBW9VCs3c
	9yHk/MoDZyRmWbqqwawnnWg1FnSYd8suOCwJAUd6tlIPnnVcnFsjcglFza2w3MKv
	Bm3jz1m3CkkOv6b9coMK0X+7c/W0DAnkM15L0U8V6Dr+7kGzKd1ijGeP9zYKdE1X
	iFOrah0mUF8A+pGGpR+0Xhx3WLNPtKVQ/Xg==
X-ME-Sender: <xms:trZaaGW4xIvMvYMVrs5i3NsWE7DVg3Jzc-zlVDUbYHiJUWyc64HMMw>
    <xme:trZaaCldfxskvsJmvH1rVfHHDSF1H8CAwMmR74v3gOEY4VXBNv0mWd1gmJ-8iHkzi
    dE_QOkbNpp9XAI>
X-ME-Received: <xmr:trZaaKbYGYpnSD0Mc7dPTh4fE0qRe7qSuHhL_iQorqcUmYZLn4JiDPrRuzxwdwgQntPPXJAGUzonmBJbkmFv8NXJakSgBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepfigrnhhglhhirghnghejgeeshhhurgifvghirdgtohhmpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegv
    ughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughsrghhvghrnh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihuvghhrghisghinhhgsehhuhgrfigv
    ihdrtghomhdprhgtphhtthhopeiihhgrnhhgtghhrghnghiihhhonhhgsehhuhgrfigvih
    drtghomh
X-ME-Proxy: <xmx:trZaaNXOkfeqHJ7wY2m65Yn1dsjIbL4Dpg6H2y_PkjigieUPkPCi8g>
    <xmx:trZaaAkziAehmhkn-CHrzMnXf57gvk6JcG6O28oIZXClRPpfEn9huQ>
    <xmx:trZaaCdtCu7u_7NGosu76FGg1F_hNDdOAQ3M80l-x4-t_rDFIOtAUQ>
    <xmx:trZaaCEVE52XGX2LbM-WB2h5uKhnivjc5aoSqNUxAwPfFXSWjfIPyA>
    <xmx:t7ZaaN-m4cAx5Jj3tugZVMvpU7Zc6yv9UYFDj0W9ukF3rZ467CaBi7zi>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 10:31:17 -0400 (EDT)
Date: Tue, 24 Jun 2025 17:31:15 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: add sysctl ndisc_debug
Message-ID: <aFq2s3SnM1lzuGHb@shredder>
References: <20250624125115.3926152-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624125115.3926152-1-wangliang74@huawei.com>

On Tue, Jun 24, 2025 at 08:51:15PM +0800, Wang Liang wrote:
> Ipv6 ndisc uses ND_PRINTK to print logs. However it only works when
> ND_DEBUG was set in the compilation phase. This patch adds sysctl
> ndisc_debug, so we can change the print switch when system is running and
> get ipv6 ndisc log to debug.

Is there a good reason to do this instead of using dynamic debug? Note
that we will never be able to remove this sysctl.

Users of vanilla kernels can only see the messages printed with 'val'
being 0 or 1. Maybe convert them to call net_{err,warn}_ratelimited()
instead of ND_PRINTK() and convert the rest to net_dbg_ratelimited() so
that users will be able to enable / disable them during runtime via the
dynamic debug interface?

