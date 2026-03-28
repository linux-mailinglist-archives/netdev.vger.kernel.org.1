Return-Path: <netdev+bounces-272740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bHIOB3N6x2ltYAUAu9opvQ
	(envelope-from <netdev+bounces-272740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:51:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 602EE34D8CF
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23A7B30315FA
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700033624BE;
	Sat, 28 Mar 2026 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="iwAezTs+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38535F5E7
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680662; cv=none; b=YaXLy52Vzh/CtZ70k7+JER08zMBn9tw/EVsv3XtMxhied1F0NHvG+3aCzuBIjL3YS9iQZeuWl+AtpnyiNWB9vUJe75Ardc/oD1KNUjUxjh7f6xRHU2tt9X3xO6COmVQjUr+Ljr7LqweeLs7TSyaSX/sCrTjhSM+WoBkqGZWdLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680662; c=relaxed/simple;
	bh=5nUtOQF5bU3GOvnc3XVqEe5GlPyNotb9va2tBz32Fxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSjRI2viImAr0+F4kjoFdXQdDOi27kqUCrO2dNq93RVDirbT3orXtTY/UhRF/jIlLrIkOvPs3MgXTd/GtGFtnVD7v3QyFXTfseCBRej/qBD5sh9ZpOnhZom0bERANdw8/2eg84cRPxmlOGHXdqHxfROTJVsf1KFd5/K+FqEDRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=iwAezTs+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b611274bso1490405f8f.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680659; x=1775285459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TsZAatCd9ykKoBaN7oQj9bzWiijKhSau8vkhJp8rYUQ=;
        b=iwAezTs+XzKIMDnQWWUYp3rPH5wQmC1aq7eeu8M3IPRX3RUosSbsBKJpJA40wYQp/8
         /YYTZlRBsgruPE/TG1vnzXXLN5x2X3GQTBY5HjMxJ+LSfqD04pkIIJmtExaqeE4MY1LZ
         IcmFRROGFh7mFDuioSqybYxX6axwJiatZnWonD7zFUJMuOTj/VjAucODwq5v9QIC+AxT
         hRV9gXFmFjcdDcTyoB3KMRNk3fSB8HJbmSYsSr9XunHPBnlR8hq8HmEqWsqiAUnxE8hp
         yRfqn/5rBY7sFbvTaijEnB08QXRMuwqp/Oi9zUIiLTR8AJUvByzuO3PYXaGe8FiKjMLd
         X4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680659; x=1775285459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsZAatCd9ykKoBaN7oQj9bzWiijKhSau8vkhJp8rYUQ=;
        b=ZDrd/LJpaARStA8G4EOrWNckaenA2wVBcJu7ilhtYKTAI4PhzHF4DoKGlehykGAt1g
         IgpHX2LW7RY/cHN0zydxV5h4UzGqdwACUnl+y8SXzikA1fzU21Bhw2ly1kNb1Wmiaf5Z
         NCwjrXTgLDMNQ6vXSkM+0+lSRDzhyyNVTQxTo9VAbW0g6UDCIiDGE2a4aH+waUKc3QBv
         fr3Pg6d54ofjb4O9WsmlQRKHTMbteABdwbPlTCWVs3Cy2sYy4bXLgpYSaq5Y+eFO1+Pb
         i0VmaTEkphGRKNAM0WoqqZLuoGgRQ2YtEetk+zG1cZwVKdaGAR/asea9r2L0XXiaLB09
         NC2w==
X-Forwarded-Encrypted: i=1; AJvYcCWcvy61+N2A90qI//2bDcgityauUX5Vaex9RSnHvMwrC/1VfL4oqji3pYtUx5eRxPnAGqtKjk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8AxJSRyZt0Il3gJBrkb3urKOBO77FvY8Hs+4bwvfQdQfpTFr
	j7ywfEz5H36HNPtu/RPgPA+R1/1qPSPWKXEL9VKF+Hk0D+w06076z8MfWtfG66GYqBs=
X-Gm-Gg: ATEYQzwhsCjV3nNHquNL7F5P4Hg6+vtGuarQl9l418zHQphPMQPar4hr/CzRqfg0iFg
	iAnFp6TY0qnfmehE0jO7MQIRKlA0hJiDzUmq7zFffLGzRxmqvfQTwc3mCpt/Nie6UVK3sQhsC75
	nZo4nEYF+cOL4yKa4heVVHPxnEOzIDruyR50i2T5IrpTdPoGwGU+11kMm05c+f2D1usyZufkj5L
	pJsHE/e4cgd/PWhcwtPF9AdylmgCbZ0DFnEzVYxbc7rOMduXo5Gfn/t+v2hMsfuvKP0v8A98tnw
	Lpn3YS4PeB5O6HitnXcgiRjePVpdbFtPuwx81oXoyH5K2dzMEeLHWbmQ11/mPLh7vwkg4n1x/og
	NKXD/FeaZm42d2FqTFzYYJIGTzX4gQEgRFkiNo+crGFdbqY1QCl/OUSZ4rA1c057pJss355ToNE
	7A/E6dpAB5etL1ViE1v4ioLOGIu17l24Nao5TL3qIXwmsynmAszjSQ+w==
X-Received: by 2002:a05:6000:4023:b0:43b:5765:96a9 with SMTP id ffacd0b85a97d-43b9e9fadecmr8160332f8f.24.1774680659550;
        Fri, 27 Mar 2026 23:50:59 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2580194sm2632392f8f.37.2026.03.27.23.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:50:59 -0700 (PDT)
Message-ID: <9e78ceca-78b8-4d54-93d7-2d6658d44290@blackwall.org>
Date: Sat, 28 Mar 2026 08:50:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 06/14] net: Proxy netif_mp_{open,close}_rxq
 for leased queues
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-7-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272740-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:email,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,iogearbox.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 602EE34D8CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 14:10, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> When a process in a container wants to setup a memory provider, it will
> use the virtual netdev and a leased rxq, and call netif_mp_{open,close}_rxq
> to try and restart the queue. At this point, proxy the queue restart on
> the real rxq in the physical netdev.
> 
> For memory providers (io_uring zero-copy rx and devmem), it causes the
> real rxq in the physical netdev to be filled from a memory provider that
> has DMA mapped memory from a process within a container.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   net/core/dev.h             |  2 +
>   net/core/netdev_rx_queue.c | 93 +++++++++++++++++++++++++++++++-------
>   2 files changed, 78 insertions(+), 17 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


