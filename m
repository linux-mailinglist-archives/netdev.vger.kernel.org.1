Return-Path: <netdev+bounces-161229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4DEA201A6
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C123A7291
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8931DDC0D;
	Mon, 27 Jan 2025 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hNsyhS4C"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FB1DDC04
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738020217; cv=none; b=FRn2CLuHNxLeJhzfW+CYmljsCUlAJttoChEUjVMONJdqyKvdYKWdaZ8HCsxCqQv2yL+F5YOqoqqWTwHJO/3HppWQWM/310PDRDYF/MYzSqyJ/wX2GfZGqu3xt/U57AAGuUMWtXLsmf5QI2tJq4AJJYzlqb7t8YqmBCqVZVXnBpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738020217; c=relaxed/simple;
	bh=/0r5OlQmqh24c4lsTACgtVV4CG1hUY87TU6fOnfI4oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxs5UadKBffHfdnAxVHgaCuBTpEJ016rjC95v1Ckuu/vtpd4f64uV1KI4Ako0sAbGCdj3hSdfbkpqTNQdCW0wrRXUjUKrM4nD7+0emzsBSLnee6M3KvMQ5ZRLphZwqCdhdHjnukUjNgj451f3U347muwE1fUhaAeWvQrxUjqs+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hNsyhS4C; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a5dcd784-8129-47ef-b386-69f8a625a26c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738020207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iuDUxNIj8dNUJk8IKu3HmkmOLxCYpgxGw7Q2gX3LNGo=;
	b=hNsyhS4CnxyGBVAdk+AffdNXHwj7s085F0gfueCaJVFXmtmAY4CEYLuW6o67hcw4cCNHZr
	KawFl874JFZ6fJeeQN9sHanP8cBWdHcrzhyZfaR1XUU/8H7pVgBrq8mSyWVnHK/C07dy/l
	FDcURGiWKtYisFKUdNXC+7EmKkz4V5E=
Date: Mon, 27 Jan 2025 15:23:22 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/2] net: xdp: Disallow attaching device-bound
 programs in generic mode
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20250127131344.238147-1-toke@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250127131344.238147-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/27/25 5:13 AM, Toke Høiland-Jørgensen wrote:
> Device-bound programs are used to support RX metadata kfuncs. These
> kfuncs are driver-specific and rely on the driver context to read the
> metadata. This means they can't work in generic XDP mode. However, there
> is no check to disallow such programs from being attached in generic
> mode, in which case the metadata kfuncs will be called in an invalid
> context, leading to crashes.
> 
> Fix this by adding a check to disallow attaching device-bound programs
> in generic mode.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


