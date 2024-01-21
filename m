Return-Path: <netdev+bounces-64484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536BB8354FF
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 10:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E51C20BED
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A3364A6;
	Sun, 21 Jan 2024 09:29:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E461368
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705829364; cv=none; b=EGw52P6WHqeDQ86LND8IhVWgron7G7UPdA/sbXdkKzeWf5cRRh5GmVll95N3AW3L1ylBBG4FApEmtkZpIwv1u2V89N7Y4V4TOyXmFISMHrWvm+LOcarh6q79/IsXxHQJ2NIX8NV5c4HR+GuHDaAnN7kZo+yI/cLWNydwzAvgDV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705829364; c=relaxed/simple;
	bh=sTfLcsA3jUDr1CPgvwAjBzs4ReQ+kwD4OUkG80+O6oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MdavM90bOlBnopssjEG0QuQG8vP5w0Y9064bweOLiJ1saSi8osKtezGkTHo9JBbpOluq7Y1p/lN4ah8YUxoJf7ImPD87cCkgA8qZg4lA9HOTeY8Lqv9e6vz1z9zXWNBHJWlHGp7me+IIAnE3AoaSSb/AUxcOtuLCfYADeJZaFts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-pzhuW_2aMgGwB7Hugaxrvw-1; Sun, 21 Jan 2024 04:29:11 -0500
X-MC-Unique: pzhuW_2aMgGwB7Hugaxrvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F3E585A58B;
	Sun, 21 Jan 2024 09:29:11 +0000 (UTC)
Received: from hog (unknown [10.39.192.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A1B061C05E0E;
	Sun, 21 Jan 2024 09:29:09 +0000 (UTC)
Date: Sun, 21 Jan 2024 10:29:08 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v2 2/2] net: macsec: Only require headroom/tailroom
 from offload implementer if .mdo_insert_tx_tag is implemented
Message-ID: <Zazj5KI7BZPnLoc2@hog>
References: <20240118191811.50271-1-rrameshbabu@nvidia.com>
 <20240118191811.50271-2-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240118191811.50271-2-rrameshbabu@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-01-18, 11:18:07 -0800, Rahul Rameshbabu wrote:
> A number of MACsec offload implementers do not implement
> .mdo_insert_tx_tag. These implementers also do not specify the needed
> headroom/tailroom and depend on the default in the core MACsec stack.

FWIW, I had the same concern when Radu submitted these changes, and he
answered that the extra room was only needed for SW, not for offload:
https://lore.kernel.org/all/a5ef22bc-2457-5eef-7cff-529711c5c242@oss.nxp.co=
m/

I'm not really objecting to this patch, but is it fixing a bug? If so,
it would be useful to describe the problem you're seeing in the commit
message for this change.

Does your driver require the default headroom/tailroom?

> Fixes: a73d8779d61a ("net: macsec: introduce mdo_insert_tx_tag")
> Cc: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

--=20
Sabrina


