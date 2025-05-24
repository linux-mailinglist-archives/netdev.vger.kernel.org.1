Return-Path: <netdev+bounces-193238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A98AC3199
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 23:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC5A1898E35
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 21:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C5E1F09A3;
	Sat, 24 May 2025 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W/NtO2fU"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3531DF258;
	Sat, 24 May 2025 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748123919; cv=none; b=kgqoFY+h1mzGUgoLah3xflOoOYpHNUZh/oF8IcM2dftgCnOZX9n68lM+Y3HEVJj1wEdppnwKDnKcdp1eit2TlCv/ZNZJM3YWU/yTPKUc2bSKz1T81iyORvRzricjCr+sHRgzbnv+enzY5v9J1flJiGGnlhQ+1WiqveMGaXUGXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748123919; c=relaxed/simple;
	bh=+g34yzjGiPSdQ4qDp1MP/jYDPY9C7JaJWwGyHZ1WTL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vq/bieyhyux1/svwj46oQ56uOSleDcBlHTJkFQ47m8sCa6T/sfZLDn06MJUM/Dc+b4vytv1H4ADhGC8xvjMj5xlLNaIGXRMpeQQL5KyXo18d6bdeRX4ydC89Us4EkzUwlKqqYX1SN8+blDIXMAY5fXdL486k5bEIms83d+/EKoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W/NtO2fU; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <018d7f83-c071-425d-8fc0-bb03957b0ddc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748123913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEgZVe4IfrwNUAVnzW5xcqNB/FmHCoReUmEfokbtmhE=;
	b=W/NtO2fUGHQ2nwOQ/u1SY18ir2tZ9cvb7UUTgTigWuXDFI7p8JrKe8nfBQN/2cwi3+JtYu
	9zix1qKjfiITmbFixb0w9Ya3f6CzSFAIaquM4uK0LEb6hGT/0TGsgXZDku2yfXm65xiO0P
	ssNN1La0L6V2exRN35lXL6NMCsoUxV4=
Date: Sat, 24 May 2025 22:58:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 5/8] gve: Add support to query the nic clock
To: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jeroendb@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, ziweixiao@google.com, pkaligineedi@google.com,
 yyd@google.com, joshwash@google.com, shailend@google.com, linux@treblig.org,
 thostet@google.com, jfraker@google.com, richardcochran@gmail.com,
 jdamato@fastly.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20250522235737.1925605-1-hramamurthy@google.com>
 <20250522235737.1925605-6-hramamurthy@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250522235737.1925605-6-hramamurthy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/05/2025 00:57, Harshitha Ramamurthy wrote:
> From: Kevin Yang <yyd@google.com>
> 
> Query the nic clock and store the results. The timestamp delivered
> in descriptors has a wraparound time of ~4 seconds so 250ms is chosen
> as the sync cadence to provide a balance between performance, and
> drift potential when we do start associating host time and nic time.
> 
> Leverage PTP's aux_work to query the nic clock periodically.
> 
> Signed-off-by: Kevin Yang <yyd@google.com>
> Signed-off-by: John Fraker <jfraker@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

