Return-Path: <netdev+bounces-134532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18DF99A021
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4798C1F22F63
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCAD20B1F3;
	Fri, 11 Oct 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZ2pT1yw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE26F1F942F
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638769; cv=none; b=kUbS6Az5LSirhpOjTC3R/0GoLqxsJS2GD2fL22Nm1sdI4jtQKuZyXoxs9g8HbJIRpN8fF0/eS7/eohuIBqA3MaklVeH5wYWgDhMeOG8PKTka9s38qkINmU2TR4TTaYDHd5jVgQqBBESevfNAdcZUMV+ZdwFOymLYQhFIo8P0mMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638769; c=relaxed/simple;
	bh=yK6yK1u9c5HHCBHS5PJH5htqZkPY2sXMB5dRhxYRYRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrMJ3ZfUZq0gHikE4Cy/MMAmq3lKr/tyThf8jSczUU46En1LG2ixCJEdL9VdICJkEnFA3a1ApzYks5kYAUufAyrXFWAP9XFMrVPA07eWZx+VDigPowPyWc0YRnOkPlGEIWSFF9BqZDcDzz7fjFvpyWJZ1qiT0d2ie5p4qiBL5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZ2pT1yw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728638765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+YWBi/NF4XHbVVKXVfXRgwaxoIBhT12XyixnJaAsUU=;
	b=NZ2pT1ywhu7fe3eiqDGmu8amceKpqgH9euP3c9jdt5ehLUXYu/mXX9UoJFO6Tmi6oPXvGc
	RIl8ZJJgvHFmCYtKXCBiWlA1/egOPtr8mt6Ma8AnoKrmQiPZSwZQeuRKX+2sq9FfJXXt34
	df1LHyo2Nopl8eD6Wk9mLv7GMAMZ2tc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-VevBD9oeMtySLA04I0bPKw-1; Fri,
 11 Oct 2024 05:25:59 -0400
X-MC-Unique: VevBD9oeMtySLA04I0bPKw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6531F1955EE7;
	Fri, 11 Oct 2024 09:25:58 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.193.246])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4CEF19560AA;
	Fri, 11 Oct 2024 09:25:57 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 52DE5A809D6; Fri, 11 Oct 2024 11:25:50 +0200 (CEST)
Date: Fri, 11 Oct 2024 11:25:50 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: christopher.s.hall@intel.com
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 0/5] igc: PTM timeout fix
Message-ID: <ZwjvHhptaNBirnea@calimero.vinschen.de>
Mail-Followup-To: christopher.s.hall@intel.com,
	intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807003032.10300-1-christopher.s.hall@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Christopher,


are you planning a followup to this patch series any tinme soon?


Thanks,
Corinna



On Aug  6 17:30, christopher.s.hall@intel.com wrote:
> From: Christopher S M Hall <christopher.s.hall@intel.com>
> 
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
> Christopher S M Hall (5):
>   igc: Ensure the PTM cycle is reliably triggered
>   igc: Lengthen the hardware retry time to prevent timeouts
>   igc: Move ktime snapshot into PTM retry loop
>   igc: Reduce retry count to a more reasonable number
>   igc: Add lock preventing multiple simultaneous PTM transactions
> 
>  drivers/net/ethernet/intel/igc/igc.h         |   1 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |   3 +-
>  drivers/net/ethernet/intel/igc/igc_ptp.c     | 100 +++++++++++--------
>  3 files changed, 63 insertions(+), 41 deletions(-)
> 
> -- 
> 2.34.1


