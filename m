Return-Path: <netdev+bounces-226901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD659BA6069
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 16:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D85C4C2AEB
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393B32DAFA5;
	Sat, 27 Sep 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mzN4G+s3"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7C18DF89
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758982196; cv=none; b=Dto6IqJsldmrZOw+BuhNeuiJ00OcIch+Rib8OKr31M7db0dgruFfDhoCes+KPHNXaFAlPzeuUa2S4+r2184GiNEuKLv/bmMkp9xSkJtd/aeEO+0cLHymV9ag3ptp3tLQuc/WylhgS9xF6geNMzTRlgiWVIxl6IOuoFlDVEP5eug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758982196; c=relaxed/simple;
	bh=xf/ty7PCwAsM3/FNaDYRNY6KF+bmNphYkWht/YKgbjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPdeic0gHzxPiUF+JvgtnZh/aJBI7pITss1a/+DsTq/ZHyWIi7XcC2qt8PTfVZ8xpdF0oow/EZP1uYNrlz92UNFtcTNvam4zzmgcbgmz4ph0UR4a9kBmj1mWLBDVkgm081fB0GnZw3VMI7Vj1/40rYhfMFFFktJXV5Jph6vvmiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mzN4G+s3; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5cb17e65-bda4-4ec8-90bb-4d8203a51557@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758982182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xf/ty7PCwAsM3/FNaDYRNY6KF+bmNphYkWht/YKgbjc=;
	b=mzN4G+s3deuHSZ0wgAQnmD4P4sDr0ZFNCCE/wMlcNuNXY1V5h94kUb32q8ewz9EyNMgiis
	MGokSc/XuFBPXFOTRjszF0pwg+4LdBv2NbEqJ/0mqembjeTBK7e3OW7ZgzryOUV0QqE1bT
	oALRp23B4kfRN8ePecjgSv3LyAipe9g=
Date: Sat, 27 Sep 2025 15:09:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/3] dpll: add phase-offset-avg-factor device
 attribute to netlink spec
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Chuck Lever <chuck.lever@oracle.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>
References: <20250927084912.2343597-1-ivecera@redhat.com>
 <20250927084912.2343597-2-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250927084912.2343597-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/09/2025 09:49, Ivan Vecera wrote:
> Add dpll device level attribute DPLL_A_PHASE_OFFSET_AVG_FACTOR to allow
> control over a calculation of reported phase offset value. Attribute is
> present, if the driver provides such capability, otherwise attribute
> shall not be present.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

