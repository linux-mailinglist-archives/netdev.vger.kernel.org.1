Return-Path: <netdev+bounces-251108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D2D3ABB1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB35030213C3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA637999D;
	Mon, 19 Jan 2026 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mXBS8QWj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71DB3659E9
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832483; cv=none; b=OyKj113ECVUKYE67YgoZDp7nNAuFQKHCJdwmlgMqVuLlgvOwKyucFZ9Uz7GitXBEck6wyWBo7PocvLARVBd1PwDRFKSVSrYnZKu0oJDVod8Ar7ge3DC8nWGvfgWZ4T3xBvg1fP17ZV91cR8mKi1GMqutYVpn4ZS/+Qklc4XAdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832483; c=relaxed/simple;
	bh=6O8j5Xb35ut+mOVJYW0x3in33ZLnFSISNS5PyTbB9q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhAhMyFRVSvg8xWunnN7rhoINgLZus8TB1gq3bSmcoqbTv+qoJMgITI1LZM278XHKpwivNdSLOYT9HzUDyEPUO0qY6Rz01y7k4DAAom+yoGO3RHuHSw+NZWUFPt/24ZK2q7bX9alwIoYu3ED9ZYFBfB99ko+kl41b5Qld0TVCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mXBS8QWj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so5739734a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 06:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832480; x=1769437280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TU2AXntQ3PPGlHkKUhy3gD5Nsu2Le49jAjpZaqjsyqw=;
        b=mXBS8QWjQ37lXKSOY0A+OI9hY//h0tMQH79sDyf6OuK0LlgdfZPecq7bEarhmHEVPi
         QytCnRekqaP+liy3jWZdIe5PO3DZhCQ2nFPqcpMojwCaEpA7+5RkJfsRnEWkSvV+h/HP
         wvT57wOiY0sY2RE50CGVpEbveM+xAYD3fRG0BhHXU225XnN+ucZLroZN0007BjbG75vd
         NhFnjXLDkxsksmgWiEW4nAAPvsgka96ccmOVkdX6oOCE4ZJ9Uo4DxbHeQW7HvpdcS4vX
         xw/f/b4CiNupiAMq2sMc4b8Z7seifysOwALLMpC9DqoPq+LeM36fKYWIptLESYNcMUOo
         VNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832480; x=1769437280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TU2AXntQ3PPGlHkKUhy3gD5Nsu2Le49jAjpZaqjsyqw=;
        b=hsRytC2xptUawy//BAjCcD86LpwyHG0DzEylVST4I0+48yXpywJzpI6nAtsF12LXyo
         EogPyk3Dt2AhhSnWAXngxYJ7SUoJGFa8B7hbDMTjrwMzx3s7Qdb7S6CDhGl0Iy2VO9OA
         lGXDGrmnZBWGhrPhw0eG1391OxE1qv5SDo0AwOswdnBz+lPw5mhAWRb1n7j2qojm46mS
         GMv7e2CJyI+gpsBFWmzQawtzUxv+DJUcSqXDt2rH4oeEUq3q0A4YKu5xmPRdHsWOSS0r
         4oz+hoSldNFWjX5USugfxHvOk4hF6Wv6DaIWMobsvLui2W6ES8NJWJLVCcUPFtcaEnEp
         MLOA==
X-Forwarded-Encrypted: i=1; AJvYcCWAOBXdzucrMQ82o2W7QW3RTgqZXByXOZ41/8SBYt35kSGHR6tkNgUHMe1X7Vdt/2Gp+Q7kWD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0AnrbDX0CDIBEEcjudgaoL84TzmcwikTtQfcQ5VbWFpgssc1h
	DOC+YvTdjUL4t0rIpLJLRYuZCuTUxup688ZT4w5a0dJ5o7muza/7pvpsuBy+AgktJ74=
X-Gm-Gg: AY/fxX6On5X8ZKLrF2pfUCacil4d1nUtH3J2X66uzZf5uMx0Yvql/rZrerxBtf+lPlV
	aQWyI6gfQGpihAK0bYXMExhz3s6XzxTGYzEOBXJ1bHEy/uGWVbRIyWViw1cxR9OcddFjUoGnu1z
	3dG2yOzBP98zG02ICvrkwUJ7SRHQJ7dg9VhvtAnYIcfhS1268w+U9CJNIQIdYqjWef0S0b2cGal
	hzMOdkVsMnfR0V9XIcw8NmkOOUiZSLv2M1RramkiwOT3Lm1VaM6Qx1QzS64O2EXELyTaXRQiiHf
	QZFCEU3+AWYRWIEWuMNnKCoNgVVSt+jfucH6YBbM7Rx3gPliHD1bu9yh/0fOLsGH9juqGxtl1AT
	lOnj3fU+V5bn3iS6QjM2KnoINtouKUJGTq5idm/ihhzxb7fnCnl3NRmyLPOZwrvOsu4RbPgwmd0
	5r5mo1KfkvGx3U5bUGIl9hieMKDMcv/I/3dAUmfsnRPF5GjOkHMjcDWgoYEEb24GfWEoi7dg==
X-Received: by 2002:a17:907:d644:b0:b87:113a:7384 with SMTP id a640c23a62f3a-b8792fc5d9amr976649866b.32.1768832479507;
        Mon, 19 Jan 2026 06:21:19 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a0880dsm1103126966b.57.2026.01.19.06.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:21:18 -0800 (PST)
Message-ID: <5c458312-2949-4dad-a358-1b25163df01f@blackwall.org>
Date: Mon, 19 Jan 2026 16:21:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 06/16] net: Proxy netdev_queue_get_dma_dev for
 leased queues
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-7-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:25, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Extend netdev_queue_get_dma_dev to return the physical device of the
> real rxq for DMA in case the queue was leased. This allows memory
> providers like io_uring zero-copy or devmem to bind to the physically
> leased rxq via virtual devices such as netkit.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   net/core/netdev_queues.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


