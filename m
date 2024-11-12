Return-Path: <netdev+bounces-144148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A219C5C1A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C21A2826B6
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A5C2022F6;
	Tue, 12 Nov 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtNGWWyX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441402022CB
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425997; cv=none; b=NLkX9iwrbtGv2NwEhPksGACpNGUJMEbhOMuugr8xmvKzKu62e/dzm60xEkeHp2FycxrmM+/7rV+eaLtWMkYxFKdAiw9mSAwsFMFt1pGI0tzhAH2+rZLG3mGAuhbhKH3IZNw3x9eT17pmOUDq4iTakupAKZAnqiT/U43PY+RWmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425997; c=relaxed/simple;
	bh=9Jy0+1aVwHE0Ay2fyDM5dF9xZ6v9CPRpC7jsyy/euz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaIu3i54mXckS6zkGO0DwUm4qJsXe2+eIpqLyVHMQyhemKGSjFfT5gw+OqBHdVM3xhQlPBme2cpudNfwRb1SD0tHvh33TPF4TgT4F6JQsfj5L4BMBTyxFuUQ3Uqw127t0gtAY4BYvcqgH6GOVVmV9NMXTnyZSuI5tnzDOn41udc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MtNGWWyX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731425994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COWxCBk/xn+lK69v98IsMcjt5CTY0uE+IGQAJjbnHp0=;
	b=MtNGWWyX3cQLUtPOPz3iCqq5OmkBKhiAkkQ3HixLEqHEXGErifSKf10PjTm7CLuw2HUSeh
	Dth3XX9+DBbEC7Upy13g/oGSeczQiPzpzELgCJIS4Q65c9lTcEDwWtrqTWei8QT84m3tNe
	UspH0rebqRb5ZdX8e0IxS5fdrAE76c8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-BLH5ZvVuMKyH4KDX32kVTg-1; Tue,
 12 Nov 2024 10:39:48 -0500
X-MC-Unique: BLH5ZvVuMKyH4KDX32kVTg-1
X-Mimecast-MFC-AGG-ID: BLH5ZvVuMKyH4KDX32kVTg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 702141955F43;
	Tue, 12 Nov 2024 15:39:47 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.193.40])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EE271955F3C;
	Tue, 12 Nov 2024 15:39:47 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A9E71A806B7; Tue, 12 Nov 2024 16:39:44 +0100 (CET)
Date: Tue, 12 Nov 2024 16:39:44 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Christopher S M Hall <christopher.s.hall@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
Subject: Re: [PATCH iwl-net v3 0/6] igc: Fix PTM timeout
Message-ID: <ZzN2wIg6qE3_gAm4@calimero.vinschen.de>
Mail-Followup-To: Christopher S M Hall <christopher.s.hall@intel.com>,
	intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
References: <20241106184722.17230-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106184722.17230-1-christopher.s.hall@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Chris,

On Nov  6 18:47, Christopher S M Hall wrote:
> There have been sporadic reports of PTM timeouts using i225/i226 devices
> 
> These timeouts have been root caused to:
> 
> 1) Manipulating the PTM status register while PTM is enabled and triggered
> 2) The hardware retrying too quickly when an inappropriate response is
>    received from the upstream device
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
> Additional problem description tested by:
> Corinna Vinschen <vinschen@redhat.com>
> 
>   This patch also fixes a hang in igc_probe() when loading the igc
>   driver in the kdump kernel on systems supporting PTM.
> 
>   The igc driver running in the base kernel enables PTM trigger in
>   igc_probe().  Therefore the driver is always in PTM trigger mode,
>   except in brief periods when manually triggering a PTM cycle.
> 
>   When a crash occurs, the NIC is reset while PTM trigger is enabled.
>   Due to a hardware problem, the NIC is subsequently in a bad busmaster
>   state and doesn't handle register reads/writes.  When running
>   igc_probe() in the kdump kernel, the first register access to a NIC
>   register hangs driver probing and ultimately breaks kdump.
> 
>   With this patch, igc has PTM trigger disabled most of the time,
>   and the trigger is only enabled for very brief (10 - 100 us) periods
>   when manually triggering a PTM cycle.  Chances that a crash occurs
>   during a PTM trigger are not zero, but extremly reduced.

The patchset looks good to me, but I don't see that this description
will make it into the commit message of patch 1.  Was that intended?

Other than that...

Reviewed-by: Corinna Vinschen <vinschen@redhat.com>


Thanks,
Corinna


