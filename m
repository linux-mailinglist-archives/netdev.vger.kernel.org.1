Return-Path: <netdev+bounces-116909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8F194C0CE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5474F1C21CF4
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC518CC1F;
	Thu,  8 Aug 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fghCr6m2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3005C8D1
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130233; cv=none; b=meE4N6cOj3HtGJQ1WzJOfDXia7A2Ce0ZsLmiPM6PmrpJUHcd9xlrYiI61VJ8t/XTlXS8oV32dB/rzcp8XpWEA2gF4QsDObTUosTUxONyidl4d6b/XzQ7A9Xwq8JY7S7EMq5+0Ng27CtmzdBOkqZIf/47YL56ORGsWkYwj/zsQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130233; c=relaxed/simple;
	bh=vV9w6HEWwk7t0+GoWgSF+eH67hrMU7LuFNtG3eLLxJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFJ6lbtMNm64SBur3114nOYLKqXuv0GEqxT68WWYAzb/dXSImKYxY9jFKlpBgM6J/wttyeVvp8AZkbWc+D0ZN7ArL9hg8dg9aNVAX+WIPZb1BPhkzWcFJuHJPl4eGpTPn/ElbkVZjX+kEbNVJm4sJ05nG9dyII4fn5A0YyQFOpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fghCr6m2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723130230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdq6trebGNt7E0YMFXGWf2a0ZxVyJ2hGnRvJSAqzzTE=;
	b=fghCr6m2e1Wt42XFRJm5qeF9oLsstGlEujOkyWR5hCbfK5zM65GTeJZfxscQrHsbXfwABS
	4yyE6Y8Y6CSoyssCrLlHcpPS8JAqB1LMDKz+bJb6wCayItOVdCPSKKTn1XAvDHf+iYbRnk
	2b06ilNWpEnialGNYgqdk6DZ0fakS7g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-lsdEXsXPNUihbfJf9ZPKoQ-1; Thu,
 08 Aug 2024 11:17:07 -0400
X-MC-Unique: lsdEXsXPNUihbfJf9ZPKoQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8B59195421D;
	Thu,  8 Aug 2024 15:17:05 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84D6F300018D;
	Thu,  8 Aug 2024 15:17:05 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 12D6DA80E94; Thu,  8 Aug 2024 17:17:03 +0200 (CEST)
Date: Thu, 8 Aug 2024 17:17:03 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: christopher.s.hall@intel.com
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 5/5] igc: Add lock
 preventing multiple simultaneous PTM transactions
Message-ID: <ZrThb-Agj9IW-xZi@calimero.vinschen.de>
Mail-Followup-To: christopher.s.hall@intel.com,
	intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
 <20240807003032.10300-6-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807003032.10300-6-christopher.s.hall@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Christopher,

On Aug  6 17:30, christopher.s.hall@intel.com wrote:
> From: Christopher S M Hall <christopher.s.hall@intel.com>
> 
> Add a mutex around the PTM transaction to prevent multiple transactors
> 
> Multiple processes try to initiate a PTM transaction, one or all may
> fail. This can be reproduced by running two instances of the
> following:

I saw a former version of the patch which additionally added a mutex
lock/unlock in igc_ptp_reset() just before calling igc_ptm_trigger().
Is it safe to skip that?  igc_ptp_reset() is called from igc_reset()
which in turn is called from quite a few places.


Thanks,
Corinna


