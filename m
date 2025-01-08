Return-Path: <netdev+bounces-156217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79DA05949
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555933A56C7
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F71F3D53;
	Wed,  8 Jan 2025 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuUxwvON"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD619D090
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736334645; cv=none; b=Y+8zQzhR4CyFZpFYIowc+Rb9q2meGxsbgAcvpl7AVHbIHWVsSyHq92ESp1zA2wxjWXMenEEdQDXM8FZl8S+bUVSaBp48UZEHxQFdWtt4DOtaGxqp0s0hyStpzufKe4pIbQuHps1uBU+FWB5H+xi1AU2yhqnT+GMLXAU1WGVkrOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736334645; c=relaxed/simple;
	bh=3qXV4cEhkpbY5EgvfPZabthnfnPSV0RxEgIDWFwj1X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocqeyrUkGcLhNtFms/cEL1yPm6cx+oQlr4KUll4Hhe2roGpkmjMCNwbm1EP78Va1npjqrUIWA+3Tx5jJ6C0PNNIPbfK1j9I8e3sqRffjMDSKJ8+HSPNEq6X/h3OgJnfzkTFGo/ymTnv6wkEtkO677FdXmp8QbSqdGVN78KuC9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuUxwvON; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736334643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BVGzhzb3Wo/2RwksroARoL775dNH8DrEF/alpc05ZL0=;
	b=XuUxwvONeH3NjUOzwSTEGqfzQnoeRCADrRxfBRpnl3nHeRWw5ZE92RIprapv0kCUhEB2MB
	zk2NmzwKrM6+1AHJHGQ53ASpjjMn+KX7kDou1OMOdE6D6DsM0w1xVz/M8SKFAlHpIgaMSi
	WzOfSt3OJXlrEO+tS+fI7JIirfFH5Q0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-0mr9kQuENeWRtXIsaKSd9Q-1; Wed,
 08 Jan 2025 06:10:39 -0500
X-MC-Unique: 0mr9kQuENeWRtXIsaKSd9Q-1
X-Mimecast-MFC-AGG-ID: 0mr9kQuENeWRtXIsaKSd9Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8283E19560B3;
	Wed,  8 Jan 2025 11:10:38 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.193.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28A81195608D;
	Wed,  8 Jan 2025 11:10:38 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B1EEBA805BC; Wed,  8 Jan 2025 12:10:35 +0100 (CET)
Date: Wed, 8 Jan 2025 12:10:35 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Christopher S M Hall <christopher.s.hall@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
Subject: Re: [PATCH iwl-net v3 0/6] igc: Fix PTM timeout
Message-ID: <Z35dK7V_OITEoi71@calimero.vinschen.de>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Christopher,

is there any new development in terms of this issue?


Thanks,
Corinna


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
> 
> 
> Changelog:
> 
> v1 -> v2: -Removed patch modifying PTM retry loop count
>       	  -Moved PTM mutex initialization from igc_reset() to igc_ptp_init()
> 	   called once in igc_probe()
> v2 -> v3: -Added mutex_destroy() to clean up PTM lock
> 	  -Added missing checks for PTP enabled flag called from igc_main.c
> 	  -Cleanup PTP module if probe fails
> 	  -Wrap all access to PTM registers with PTM lock/unlock
> 
> Christopher S M Hall (6):
>   igc: Ensure the PTM cycle is reliably triggered
>   igc: Lengthen the hardware retry time to prevent timeouts
>   igc: Move ktime snapshot into PTM retry loop
>   igc: Handle the IGC_PTP_ENABLED flag correctly
>   igc: Cleanup PTP module if probe fails
>   igc: Add lock preventing multiple simultaneous PTM transactions
> 
>  drivers/net/ethernet/intel/igc/igc.h         |   1 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |   3 +-
>  drivers/net/ethernet/intel/igc/igc_main.c    |   1 +
>  drivers/net/ethernet/intel/igc/igc_ptp.c     | 113 ++++++++++++-------
>  4 files changed, 78 insertions(+), 40 deletions(-)
> 
> -- 
> 2.34.1


