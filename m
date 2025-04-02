Return-Path: <netdev+bounces-178763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 296AAA78CA1
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA0816FBFC
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8BC214810;
	Wed,  2 Apr 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTgpdK+B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59A53BE
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743590827; cv=none; b=hFwGxbIAA1A6dMP2Kd/ZwgUswHO2FYt3mGfNlUdLr0+CsbG6PJVsEAd4kFhimnbNt0z0V8wAJRVeThM+qLmDA8ksnzJwsZS78IPLzI8MQbBGK1cZWfosB/mGZgbi3vELwnlI/DgzqZU3+/Y5dk5KHahF8eKGsc0Zd7q9Htn0Ygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743590827; c=relaxed/simple;
	bh=0a+SffDhckWdTT+/Mtaarfhb4eWEN041VfkiOT7ftig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaPLZD2kp7CvxQsWtXtlkKgpMn0tPpmZH3135QPrvOtu0vIM5hD19CQbTPzOfqQLYq6ZDcIn+JCTxb27dunrcI90Az+BqMHr9BMYyQP3jpfux/vJ5h+EU/cKUV1XGQNHDOfapk7c7/4zYUw1C9RZTLN/CvXuMRFElij6OgwUTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTgpdK+B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743590825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ypu8JjwQ7LGF38JD3wHnehscjaJly8YMFDiK1em5sIw=;
	b=WTgpdK+BkkfzUjZzjG7EI1EgrwpbpdYcz4eZAHIkraKcRF9LQGUHOJ0fRSodLF+EZJoR94
	DMPS434aMvl70F1M02a6UHwY8xyiZhEtNv/NDGeKfbtMKit7P0ws0Ot8tepha207RzK0lr
	VMyrm+JnX1y3rXNtY47Zfi70Silh3HY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-TKmhR-jAPDK1jkstwgn0Ag-1; Wed,
 02 Apr 2025 06:47:01 -0400
X-MC-Unique: TKmhR-jAPDK1jkstwgn0Ag-1
X-Mimecast-MFC-AGG-ID: TKmhR-jAPDK1jkstwgn0Ag_1743590820
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B5531801A12;
	Wed,  2 Apr 2025 10:46:59 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.22.80.96])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B457319560AD;
	Wed,  2 Apr 2025 10:46:58 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 48D59A8098D; Wed, 02 Apr 2025 12:46:56 +0200 (CEST)
Date: Wed, 2 Apr 2025 12:46:56 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Anthony Nguyen <anthony.l.nguyen@intel.com>, david.zage@intel.com,
	vinicius.gomes@intel.com, rodrigo.cadore@l-acoustics.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Christopher S M Hall <christopher.s.hall@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v4 1/6] igc: fix PTM cycle
 trigger logic
Message-ID: <Z-0VoDTYP9HsSrsJ@calimero.vinschen.de>
Mail-Followup-To: Jacob Keller <jacob.e.keller@intel.com>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>, david.zage@intel.com,
	vinicius.gomes@intel.com, rodrigo.cadore@l-acoustics.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Christopher S M Hall <christopher.s.hall@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
References: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
 <20250401-jk-igc-ptm-fixes-v4-v4-1-c0efb82bbf85@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401-jk-igc-ptm-fixes-v4-v4-1-c0efb82bbf85@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Apr  1 16:35, Jacob Keller wrote:
> From: Christopher S M Hall <christopher.s.hall@intel.com>
> 
> Writing to clear the PTM status 'valid' bit while the PTM cycle is
> triggered results in unreliable PTM operation. To fix this, clear the
> PTM 'trigger' and status after each PTM transaction.
> 
> The issue can be reproduced with the following:
> 
> $ sudo phc2sys -R 1000 -O 0 -i tsn0 -m
> 
> Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
> quickly reproduce the issue.
> 
> PHC2SYS exits with:
> 
> "ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
>   fails
> 
> This patch also fixes a hang in igc_probe() when loading the igc
> driver in the kdump kernel on systems supporting PTM.
> 
> The igc driver running in the base kernel enables PTM trigger in
> igc_probe().  Therefore the driver is always in PTM trigger mode,
> except in brief periods when manually triggering a PTM cycle.
> 
> When a crash occurs, the NIC is reset while PTM trigger is enabled.
> Due to a hardware problem, the NIC is subsequently in a bad busmaster
> state and doesn't handle register reads/writes.  When running
> igc_probe() in the kdump kernel, the first register access to a NIC
> register hangs driver probing and ultimately breaks kdump.
> 
> With this patch, igc has PTM trigger disabled most of the time,
> and the trigger is only enabled for very brief (10 - 100 us) periods
> when manually triggering a PTM cycle.  Chances that a crash occurs
> during a PTM trigger are not 0, but extremly reduced.
> 
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
> Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
> Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
> Reviewed-by: Corinna Vinschen <vinschen@redhat.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Tested-by: Corinna Vinschen <vinschen@redhat.com>


