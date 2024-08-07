Return-Path: <netdev+bounces-116551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BDE94ADDB
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 18:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686581F21F26
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FBB12FF72;
	Wed,  7 Aug 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrmDWbuk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C9612FF7B
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047389; cv=none; b=Ws4bOlSlZH8KKC1WaAkQ2Yktt4nctZZh3zRClaHfGNx9E3gDcxT5OVYo6nmYJRevBUGLJWIDf9lpdaiRhiSf7+I5q/FJyY/DcjbZXpSSodw1c3FaQlWbpf1NBTSUeD4ycIG2lxHxEbATZfnZG1DKzTXX7IRIV5Adp7hHiLKUs9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047389; c=relaxed/simple;
	bh=sTFXq9o/Kw6reKXAJIeC0dhguOp+sNVnUSbKN/bGzu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkijrVoHnAI+43ZreYBK4oMjBExxgXF1WeZn+Rllkb0Y4gKhsgOlWTWZ1YYEWqT3UYNH3hpkSM2MYkz3CXJXpMKu8KXXNaIkXc1pQLWJKTsRLecVIUYkc/HXbSdter2sZ/poSSGaL2dbsIixZlWIi3VMMpffA0ZJuSU9bfxHfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrmDWbuk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723047385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fAagdNuIXlb/vJ1xLFkszZv7WfOecHpqqTnZjQT3Wm4=;
	b=VrmDWbukrRzFTfIhzabSwCTsGC2D/+nsMoc/5IImHpKENX7sJhgw0U3NBsMLSsfgGvY2Ly
	vH8XMq4+8rP+v0y92PnlYsv8HOsaxKkC3dh9qFaq09ehtdxIM7Zq1qSrCxSG90MonKR134
	N7LiwkoZqmlNfHP3y8UHzAVP3OMIqUw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-f71GHZWQNLuhs1Fyn0Bu0A-1; Wed,
 07 Aug 2024 12:16:02 -0400
X-MC-Unique: f71GHZWQNLuhs1Fyn0Bu0A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2F7D19560A6;
	Wed,  7 Aug 2024 16:15:53 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.194])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00E9A19560AE;
	Wed,  7 Aug 2024 16:15:53 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9665DA80E8E; Wed,  7 Aug 2024 18:15:50 +0200 (CEST)
Date: Wed, 7 Aug 2024 18:15:50 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: christopher.s.hall@intel.com
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	rodrigo.cadore@l-acoustics.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/5] igc: Ensure the PTM
 cycle is reliably triggered
Message-ID: <ZrOdthE36RQy78fx@calimero.vinschen.de>
Mail-Followup-To: christopher.s.hall@intel.com,
	intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	rodrigo.cadore@l-acoustics.com
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
 <20240807003032.10300-2-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807003032.10300-2-christopher.s.hall@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Christopher,

On Aug  6 17:30, christopher.s.hall@intel.com wrote:
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

It would be great to add the problems encountered with kdump to the
commit message as well, as discussed with Vinicius, wouldn't it?

If you need a description, I can provide one.


Thanks,
Corinna


