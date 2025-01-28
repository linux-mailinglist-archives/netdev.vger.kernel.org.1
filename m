Return-Path: <netdev+bounces-161330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4904AA20B37
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7A4188690D
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AE319CCEC;
	Tue, 28 Jan 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="QDFzw3Gk"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20918DF86
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070327; cv=none; b=XgAS1p6AQPyD1SvWvv0CTE+FyZLSowtDt2sMJbnibea5DfqGhk8lbWILg/d7H1kOCIZrAEVC2F+H1tDfojOtDueddMd42xdj8iseGomHZCTdxs3sjed0FEj74M7HJ5WfAKktAOZImhMS+TUy4chBCiVD54GZz6ZzHDv6Gx9fSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070327; c=relaxed/simple;
	bh=pgtp7zbZPfZCAbjewlZsI4ONlDWFOfxNfS/QBBjkAro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKGNZZ71sD+lfPqZkzXTIwDabDEVQbnu4hl/88AQA45FHPpPhY3LgX6PNW6Ky8C/kf0hjSW6vTuHTvITZTHBhysbMM+wR2MjOea3Jrs5MpZb+wgwABTfyay/+EpkQjybC7Yz+BzhGP+/EOaueWuWGeAXh/UFK/vOVlBPN7i8sa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=QDFzw3Gk; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tclUE-002fMp-Ek; Tue, 28 Jan 2025 14:18:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=LSIj9otuYuCraAa3CWrGffqoTmrlw184SfLPV41234g=; b=QDFzw3GklOzccAcroYylx5mbBL
	53DscyCOzKJD3/k4c4PXPci/9gK0MPeIEhnFGJXMXdGw2sn2S2TRgHV/mXXYGnuySLLOa9vVIBPvJ
	FnEUNoA3Oi+34lBIGsbiqlodojcrPDMtj1bOSklWn4hTffkOpKKFgyhWzp1yQ3n64JrtSaJ2hHVYX
	cBmvZ8WyV9OW/Um+Rkm1ikA7ZK3cGpLAFyUS91rmFhcKTRhgQVHaWHgIQXrX+HyL0trvBDshV4BLn
	4GWjBbQSRmSr8LnBoafWB3XDND4BoVTdvblHk8k1sPZKPViD/aX19qSjZRaSYgsm/oCfEFRRE2o0z
	Mc4UeJwg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tclUD-00075f-KT; Tue, 28 Jan 2025 14:18:37 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tclTy-000nUi-NK; Tue, 28 Jan 2025 14:18:22 +0100
Message-ID: <6b65a0ef-bf1e-4e5f-b097-69495987b957@rbox.co>
Date: Tue, 28 Jan 2025 14:18:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/6] vsock: Transport reassignment and error
 handling issues
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 Andy King <acking@vmware.com>, netdev@vger.kernel.org
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <20250127134939.78613534@kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20250127134939.78613534@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 22:49, Jakub Kicinski wrote:
> On Tue, 21 Jan 2025 15:44:01 +0100 Michal Luczaj wrote:
>> Series deals with two issues:
>> - socket reference count imbalance due to an unforgiving transport release
>>   (triggered by transport reassignment);
>> - unintentional API feature, a failing connect() making the socket
>>   impossible to use for any subsequent connect() attempts.
> 
> Looks like the merge window merges made this series no longer apply.
> Could you rebase & repost?

Sure, there it is:
https://lore.kernel.org/netdev/20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co/


