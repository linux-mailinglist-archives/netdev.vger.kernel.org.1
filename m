Return-Path: <netdev+bounces-198066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB5DADB241
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B9716A430
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7702BF00A;
	Mon, 16 Jun 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxGD5xgZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9C2BEFE1
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081140; cv=none; b=JlG2wjbJ+AHBECcFVSS2J5hdi8Jfj6+YeEVsL+ywbLLaVK80ZqkDmXlD+SGUVasTRsk11vkkkiJAS4MfIzqaGsp3+ApUE7bAshunJhOmdbfxZ8iXWY7pYXID+t1GdRU9m9/+rpPYeVeCzSY0Z6/5ZbvRDzlMUxPKJ5SKtKponjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081140; c=relaxed/simple;
	bh=Qwlb9f4UqEBo8Fip0+xaWfZ7pxfr82y7AgftVGul4Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klEvB+N2JEMsYRRITveN3+w6yNKBoE535HbQEs04pfNuImRVLCQBATOyW1EtNK3QUu5pjloVYTTL8ZLWwdvj+1HUsHvxQI+Nax2PXXbUmhx24tPFmu1lrrEiytQ8u88yZWRx8raB4G6oItkO9c7LCtwh2nGFpX+09L1ilmv0XBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxGD5xgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38D8C4CEEA;
	Mon, 16 Jun 2025 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750081139;
	bh=Qwlb9f4UqEBo8Fip0+xaWfZ7pxfr82y7AgftVGul4Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxGD5xgZ2OAPCEY43MzurQtcdsohAs6E8OQQPGLU12UEnaLDPKpK9wEcsqL1nkmKA
	 y70soT4ZpPU421g5h7uV1g4oF++179uwujTkh0j4wG94sDM24WVV/NMSQkTZ8arc+y
	 91I25VaIu8VsJ4snUoQE8wBYrblhs7GKpN775skDR58RD7TCG5YLeifHHkJNN6Hfch
	 C7zlz58AVrxamhUHrmJo2cf58Kfv49ZVR0q4ToOh3DRtlZRmei6zRf2EluG0nBzkZf
	 rVULmyOWa+bXwwtubTyPJeLzjnviCiSvHtdurE25j1cC5AaDbI9HMrY0r71fPoNsqL
	 ZxsSm2+Q4Ic8A==
Date: Mon, 16 Jun 2025 14:38:55 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS
 contexts on queue reset
Message-ID: <20250616133855.GA6187@horms.kernel.org>
References: <20250613231841.377988-1-michael.chan@broadcom.com>
 <20250613231841.377988-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613231841.377988-4-michael.chan@broadcom.com>

On Fri, Jun 13, 2025 at 04:18:41PM -0700, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> The commit under the Fixes tag below which updates the VNICs' RSS
> and MRU during .ndo_queue_start(), needs to be extended to cover any
> non-default RSS contexts which have their own VNICs.  Without this
> step, packets that are destined to a non-default RSS context may be
> dropped after .ndo_queue_start().

Hi,

This patch seems to be doing two things:
1. Addressing the bug described above
2. Implementing the optimisation below

As such I think it would be best split into two patches.
And I'd lean towards targeting the optimisation at net-next
since "this scheme is just an improvement".

> 
> We further optimize this scheme by updating the VNIC only if the
> RX ring being restarted is in the RSS table of the VNIC.  Updating
> the VNIC (in particular setting the MRU to 0) will momentarily stop
> all traffic to all rings in the RSS table.  Any VNIC that has the
> RX ring excluded from the RSS table can skip this step and avoid the
> traffic disruption.
> 
> Note that this scheme is just an improvement.  A VNIC with multiple
> rings in the RSS table will still see traffic disruptions to all rings
> in the RSS table when one of the rings is being restarted.  We are
> working on a FW scheme that will improve upon this further.
> 
> Fixes: 5ac066b7b062 ("bnxt_en: Fix queue start to update vnic RSS table")
> Reported-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

...

