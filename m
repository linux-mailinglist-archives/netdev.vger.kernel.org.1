Return-Path: <netdev+bounces-81956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8573A88BE71
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B709F1C3826D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F378B5C904;
	Tue, 26 Mar 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gepqmo3q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68D4C3DE
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446714; cv=none; b=ouhc5XMRkpxb/i1UE3GJ9Y0B/lln4ezXVv5QrzOKCwnqa+ykK4pbKeNzkJeS/d2LhqoX+VB6T5HVkvXqo56uDmBRaX/cyapztu+xBF+Z8TeiQgKgWYbukc5ikclE/5saLywih1LuxPpq0udijFbJoXcIQiSmhqBsUHe2zm3KE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446714; c=relaxed/simple;
	bh=CE7ITyuj87TK4KOe5aJ19HHnjugOPpX0zeU0QH5pGmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCFmFo1hfaSRDncQl+64FWYCorlTq4wfaxiWWuGJGEznn5QRw219O5y+im/j2CXOWxJ7dmj0AnFcNxaQUzLT5aDgXgQrxXqtTTQt5C4NB1JM/yxRvWFvkrGEbffUvvXaPhrARXBWsTwwhXP3iHOXfKHV7bymorrdBBENzTyiV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gepqmo3q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711446712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsgIHZ6t47RKFF+C8jcAgd5UADfhu+shQ4EaON+pya0=;
	b=Gepqmo3qkB9JQBA1QRcymcDiNlVtIkCFggoA3tnjgYUCHrxgj9gUom3aQzTL1uy0IFODO+
	C5YCgcvzyGBmf/gI/pCjXztYW0OCVwhM9jFeFhlSciRXiMTB+LZGZ6fuhLKVwOJSwLJwvy
	4YWVZzvXgOa0WDN3FktCwiUM8PxO7lw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-IgCT65hGNAKssCJkJ7K1nw-1; Tue,
 26 Mar 2024 05:51:48 -0400
X-MC-Unique: IgCT65hGNAKssCJkJ7K1nw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBA1D382C463;
	Tue, 26 Mar 2024 09:51:47 +0000 (UTC)
Received: from [10.43.2.69] (cera.brq.redhat.com [10.43.2.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C7C8F40438B7;
	Tue, 26 Mar 2024 09:51:45 +0000 (UTC)
Message-ID: <65b02586-1322-4eb3-b46d-36cf4bf6a3bf@redhat.com>
Date: Tue, 26 Mar 2024 10:51:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/3] ice: lighter locking
 for PTP time reading
To: Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org
Cc: Jiri Pirko <jiri@resnulli.us>,
 "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20240325232039.76836-1-mschmidt@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20240325232039.76836-1-mschmidt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2



On 26. 03. 24 0:20, Michal Schmidt wrote:
> This series removes the use of the heavy-weight PTP hardware semaphore
> in the gettimex64 path. Instead, serialization of access to the time
> register is done using a host-side spinlock. The timer hardware is
> shared between PFs on the PCI adapter, so the spinlock must be shared
> between ice_pf instances too.
> 
> Replacing the PTP hardware semaphore entirely with a mutex is also
> possible and you can see it done in my git branch[1], but I am not
> posting those patches yet to keep the scope of this series limited.
> 
> [1] https://gitlab.com/mschmidt2/linux/-/commits/ice-ptp-host-side-lock-10
> 
> v4:
>   - Patch 1: Use named GENMASK macros and FIELD_PREP.
> 
> v3:
>   - Longer variable name ("a" -> "adapter").
>   - Propagate xarray error in ice_adapter_get with ERR_PTR.
>   - Added kernel-doc comments for ice_adapter_{get,put}.
> 
> v2:
>   - Patch 1: Rely on xarray's own lock. (Suggested by Jiri Pirko)
>   - Patch 2: Do not use *_irqsave with ptp_gltsyn_time_lock, as it's used
>     only in process contexts.
> 
> 
> Michal Schmidt (3):
>    ice: add ice_adapter for shared data across PFs on the same NIC
>    ice: avoid the PTP hardware semaphore in gettimex64 path
>    ice: fold ice_ptp_read_time into ice_ptp_gettimex64
> 
>   drivers/net/ethernet/intel/ice/Makefile      |   3 +-
>   drivers/net/ethernet/intel/ice/ice.h         |   2 +
>   drivers/net/ethernet/intel/ice/ice_adapter.c | 116 +++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_adapter.h |  28 +++++
>   drivers/net/ethernet/intel/ice/ice_main.c    |   8 ++
>   drivers/net/ethernet/intel/ice/ice_ptp.c     |  33 +-----
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |   3 +
>   7 files changed, 163 insertions(+), 30 deletions(-)
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
>   create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h
> 
Reviewed-by: Ivan Vecera <ivecera@redhat.com>


