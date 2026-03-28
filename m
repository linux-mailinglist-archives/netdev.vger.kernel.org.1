Return-Path: <netdev+bounces-272741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLaHAJN6x2ltYAUAu9opvQ
	(envelope-from <netdev+bounces-272741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:52:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E2F34D8E5
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21BBC3044B80
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03537363C6F;
	Sat, 28 Mar 2026 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JW8Nka5o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59090363C72
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680689; cv=none; b=e/sW69J/fng4rJ69CidkELPMbWD1yUvv3lvJXIOtrW7awkNdGBMYWafSBD+/2vLhLt6IznmynZeayOsJNP02lE1lduULWUfRwt0pm2rPpnveTvoipdz+WPcckePnr00xOB4BCM+k31l7ipuEPi6Djckg41ZzyIsahcAeRxjHj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680689; c=relaxed/simple;
	bh=An4vic6MBd35CZlHJpJvGDwg9ViMF4bVOHaPAyHIEio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXgsbyt2me1+fdEMu5WQk6wP57KJ6TQ+BXN45NWksj1wQ59UwqNx3SBwadXKw5TAiPr6qCTSrPi+aJHA22DkkVNfy6zTAAeatLo8x9vbaaxr9Jw54IQ1qPsQOc4JwFM/jFm7LwWph33zehFqSKK8oE7AMCgyAxJFkOFt4TqLa4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JW8Nka5o; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48538c5956bso27435535e9.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680685; x=1775285485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBJ6xSeU7qVX6wdlPN+g9gXgCJbSsPlI9/YF9B2IXT8=;
        b=JW8Nka5oZs+j15WY8XY4FRNsUDpzFr2sjdBlAwy0HdDznAlF3QDiuva0QEapXgPCVS
         RThvGLdRkvhAmEz75zyIezi25qXVkKWT9JN7xabnE2xpeBxX3rPirEQpCyM8IkGwjFfO
         ErghQ6no3X3uWS9N357GPNLEGTD98NlaDtaTOuAShM4qINA1ab9STbI/Dqt97inQqXX6
         eBFM5zVgccmc4D9HEv1Bu8vIixiTH8cXo6DCBHV8WZbyEXX+O8lMRAecMxMMcKITGg+2
         l1du7eanhWKodDrzXeMvDdcIM5GfKzDJehN+sD3WJ1oV2vHocV3cdlvEP0Wevy24ZnAT
         C6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680685; x=1775285485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBJ6xSeU7qVX6wdlPN+g9gXgCJbSsPlI9/YF9B2IXT8=;
        b=V+Qng+xoP8gD1nONoEGBxucrvRbiPmoMphBzp4BRfMRknQfuiQq9DtnNGNL4e4TafK
         KkkoWMF4zQ4z+3QPi9+eWol9q6q5t777qs9LJ8DFlRDYUf/uwjCzYtN3Kq20REKnjKA0
         QVzZEkmy7aFqcdN9RkRTUhtfil19ZKSqJhtamnZIPUT1ujSgPBYs/pG5b+yboTFYG+DX
         XIp2+F2OyB7F4W+zHnfNwnmpRGyrVuF8aM6vcNMypHj2r09MPoLDN7MR2q58iPf8gqfG
         tS10z5nl97HJ7EZJvl4MekbTBg1oGNz/mVXz+Vb3P2eqkp0t4MJXr92eWFQw3wMFjxWg
         wW4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjC/jJia0amhinn+RM40kz7aGaSAguLaVpnNCFmheMmPCwNlUoS0QbMW2WEtfZCc/FwunQHw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pm+GY6cRdXeK9zmkyu1CxlgDG2FigAZa1PiXmiapoIysCH3B
	8j5CXG5IDnWrZB/Xi+7FIJr4WmNJ2tkC/XJW4HbYATDCPqz55TVl/hkVyz36VyTMFpI=
X-Gm-Gg: ATEYQzzFmwFMYYdSwGopMKfdzKVCM7RaPh4+pSyWXQqU178pcEpMAQEA18rx/FEZko0
	xEG82FKMZSH6uIWZAky3y2+paL6ySo051nsmdzZc58JNp8KNrQS+z6O+rDupX+FGCqwQRMmz4ss
	IEpVQldlLlKTqL+s3LcakcUxXYu6mF0DlDOHyDKgy8Y880S1UhraxL4b6DL4OVnTpSt1IRdpz0w
	X4Ql63AS37O/QMlRSqHF6nZzu+M3Paj7wosiJyoCbYt/OAAGDeLaOdbO606CrPkjnd7fuaDwamF
	w/LAICRICjOaNdvV5enOAbu7/wDlfO9sUtm4j0KdLT2yvq/Ffy1MXRHkxIOcZP70WZ/2q6OZn02
	gfHUgjQYGbVqbVqNLhtoIoaGsj43vUivbZ1eKvnEuK7JFz0v3R4mZAUxaV8/BVCC9S2XGczmmq3
	hs5fGScwSWgZSAl3K9IVqPXXt9qxzPBSdjbeCyI5rBHiIkucaxay2GUQ==
X-Received: by 2002:a05:600c:a418:b0:485:50ac:b8cf with SMTP id 5b1f17b1804b1-48729016ca5mr56244635e9.0.1774680685602;
        Fri, 27 Mar 2026 23:51:25 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c957b9sm205194715e9.8.2026.03.27.23.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:51:25 -0700 (PDT)
Message-ID: <64535bf7-7416-4f5c-9b37-edca8ed57656@blackwall.org>
Date: Sat, 28 Mar 2026 08:51:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 07/14] net: Proxy netdev_queue_get_dma_dev
 for leased queues
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-8-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-8-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272741-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 68E2F34D8E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 14:10, Daniel Borkmann wrote:
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
>   include/net/netdev_queues.h |  3 ++-
>   net/core/netdev_queues.c    | 36 ++++++++++++++++++++++++++++--------
>   2 files changed, 30 insertions(+), 9 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


