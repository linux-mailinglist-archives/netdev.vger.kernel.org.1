Return-Path: <netdev+bounces-144993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3539C90DB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DBAB6083C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007C418C014;
	Thu, 14 Nov 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IqxRfw4t"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A3517BEB7
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601299; cv=none; b=PkGArP19nAfWzVzgl0slpBnE08mgss9HuVNz52CGqQKp8GdI4W6VHE0uG5HxSyRElub03rx0YM9GpvLeWnljcWtzvJZUIi2fIAhFWaVFOA57t07dse+hehRj6e2TH1lkGFTRESbTuM/59IkLGW2HHC7qAgbUMUEfRCNiT4uGk2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601299; c=relaxed/simple;
	bh=HnGRFh0HiIz5eQKZCCkmIHgbqvVSCi1Bz+4s6YLUdhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZoNr5F/z1grd5mo87enY7QyRq2CwHwd66D8t1FmQGz2j8UlTPkeqqT1FxVp/a+thhAeDjM2iFvyBLG6V1fom0xRquLmXylKghs2ywr/Duh+dt7Rd7Q30YwkCKsJIbXG2WXkVuhkC/4Vr/dS37UGtwuBDD72BhOWnDIR/FraGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IqxRfw4t; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <15f1d59a-c1e3-424b-99fd-f2fa602532af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731601295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlyzKV6e4XPPS/cv0TkUkspPKwaDligjDub2HyX5ibM=;
	b=IqxRfw4tuxbm3JBbDE+kmxX0E/rV3zab7UkTCWDF3DKGXeyeedijSGl5DAyDawVRM3NQXi
	DJAQaQVE5CrmtnoKbk5C6jV+8GjMOpG4qu1Qldgshl8t0cJe7cr0XhoCSSf1i+L8E4Je2/
	RRODWok4NHsqRJGyx7l8OIhlPIJ9WUs=
Date: Thu, 14 Nov 2024 16:21:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 4/7] enic: Allocate arrays in enic struct
 based on VIC config
To: Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
 <20241113-remove_vic_resource_limits-v4-4-a34cf8570c67@cisco.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-4-a34cf8570c67@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 23:56, Nelson Escobar wrote:
> Allocate wq, rq, cq, intr, and napi arrays based on the number of
> resources configured in the VIC.
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

