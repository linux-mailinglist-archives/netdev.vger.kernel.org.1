Return-Path: <netdev+bounces-171843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE5A4F10F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D37F189889C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 23:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B20A27814F;
	Tue,  4 Mar 2025 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARVok8VD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056451FBC94
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741129222; cv=none; b=pPg2D5dj/3eWuRwkP4U9fODl+RxowBiBH/0r8YqRSzcP1tAF9nJV15d127trz3jj15O1nJLYhGK917D3b2XDwqXp7KaTcGyYdMGFtF+MZ9BYjpcktcFRQmPKFUJn243WaDmY5sGc+U/TOcuhOh46P3aKeL1FUuisxnHCcGw581Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741129222; c=relaxed/simple;
	bh=4ucjx1b2Sybp1Z83hFOV4nNCrIMjt0hVHN2OZsb1awA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRDUnX7dNQGHb4S5YDxRckIbWiE1C7XR10SYOlNcfhmtv6mv3vd2b3ufTmkcr1507EAjQMiEpS0zd9MqKdhqJ1GQYPXmgcCfXYJa3kDbwlGsjLC+YoANRN58cTqQC63iacCUYvh5eqnh8ROTsmOERsieIbeWu31+ltDrIS5goWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARVok8VD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13865C4CEEC;
	Tue,  4 Mar 2025 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741129221;
	bh=4ucjx1b2Sybp1Z83hFOV4nNCrIMjt0hVHN2OZsb1awA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ARVok8VD/EJ1FEYJB9aMJL5FpUqXwcsrFc5p1G7rGQtSjC6RD3LfTdDB6vObuu/Xl
	 5SwT63OtLRwcd/8RwQRdp81vW4bC7eKKcyGgOQY9QoKScHJGugZ4zsFggSp0tUxIZ4
	 5BNCRVjnC77H+rtPk2ZThM2aYE5QV4ct94223PFz8z4XIBGU4D7IDTETF8Iao+8asz
	 6M/LsTRhfx6hMPVHozaeUR8v2BpDrc9yVy5BAEeM0Yff0RY4HL6YOTi70dTDvATMkv
	 S6m8/P59s3NcuG6Rs7+SZ2hJAMMWKizURq98iPjKRrwwkF74SrxSyiV2Enofqwz3r4
	 Jhd330/iDyUAQ==
Date: Tue, 4 Mar 2025 15:00:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Richard Cochran" <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed
 Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel"
 <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky, Evgeny"
 <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski,
 Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v8 net-next 0/5] PHC support in ENA driver
Message-ID: <20250304150019.129a0182@kernel.org>
In-Reply-To: <20250304190504.3743-1-darinzon@amazon.com>
References: <20250304190504.3743-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 21:04:59 +0200 David Arinzon wrote:
> Changes in v8:
> - Create a sysfs entry for each PHC stat

coccicheck says:

drivers/net/ethernet/amazon/ena/ena_sysfs.c:80:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
drivers/net/ethernet/amazon/ena/ena_sysfs.c:61:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
drivers/net/ethernet/amazon/ena/ena_sysfs.c:125:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
drivers/net/ethernet/amazon/ena/ena_sysfs.c:95:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
drivers/net/ethernet/amazon/ena/ena_sysfs.c:110:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
-- 
pw-bot: cr

