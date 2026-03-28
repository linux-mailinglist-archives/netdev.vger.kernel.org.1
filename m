Return-Path: <netdev+bounces-272739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Et9DL15x2k+YAUAu9opvQ
	(envelope-from <netdev+bounces-272739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:48:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 709F234D8BD
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 255C43009CCF
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45A02ED141;
	Sat, 28 Mar 2026 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hsIbeHoA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634FA40DFD1
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680484; cv=none; b=Nf98vCasM7cojB7uWlLoAsiQsTCWbEKoVv9MSPTGGtFb4rtZScYtdy06UI/llJFaJ+S5B7T4MtLPygQfnfoAg3kw8UhDu7F+DzJA/kSvYgun2ZVHt/8srAzdSfX1YpcC+Rh0iF/SXm5yYYVh4FUwPGL/DuxR3h3C9+TiEyDZb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680484; c=relaxed/simple;
	bh=bbvI9iWBsuwbYbUiB414sq68ZB3+ZOIlpKW96dHSPc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVzGUwQ73B47MQKpNTCEbyRZRdWQnUNsRtKOJ/MXtfv2IkKk9c0DeKggjAwqGy/wpZhCJZG0evGxhkqXpqgS8CZFqt1wy9V8ERB36dQOiPR9QhMJGDy/V+KjzUBK+XyTh4Yer9GVKI+q03h5vGymliUAdjI4tbKNDJYEtvGapYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hsIbeHoA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b9b1900bso1652290f8f.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680482; x=1775285282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5O0qXq17JKmnmutbL4tWXncwKTIiaImob3OC0al/I2k=;
        b=hsIbeHoAmW/EINsyoWIylHj5UMMHH0XGlaEQDeVxrcRFSqw+Wfe26eSyH7d1NVvrGg
         CurrKU/TKSy2ILfAPCrWAdmh34N187h9gzbXW7C17sFP0qNvt/3uFn26eESfF5ATw7jD
         XKXeYsIvGfO9H51Gboc3SOalKPz+e+FYjBuqbu0H9dEOwNqym8lYZdMiShMbBVb0+zav
         bP7tHbJ9W6hDilm35X2DgPdtCPro8Eq8BJpzcq2R7IU2HCbFFQsT1l824jJlOw6vIpPX
         qRVQVk6/IT2Xq4HhmKrhIjqfuppJ5+9+7qZnKbCFrkyeIneCkKl07wlcBsHFdtZrVarX
         122Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680482; x=1775285282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O0qXq17JKmnmutbL4tWXncwKTIiaImob3OC0al/I2k=;
        b=DHg7g1gTRjQvmHXtICN54qjxf58/ZjZbab/ayLQcu5UPt/3u8hUp2eIW6pFWyASbot
         lUvvNpJlSl1o2T0B9z/ymCqfu4/J/0Sg3Pa6t1Xad2BY622h1S7aNfMbyh+3V0D/Ju+s
         GpIJ8w12XHGJIzem6N8c/+g9EGCoL19dbU7iBUZctmWpAXrB+qUI//uA6GJ9qSkZ272J
         KfBnXE9x1g+17P2ATZ5iY5m43bH53OubIgsgqfrPmBeqSU2R1XzYpYanBx/6ZxNUQIfY
         X2BkQ0y6ojlLwD3R1FBNRLCWJ7zjQOgnWkcIfK36NIrH4i2ySgvfbY+z0z2Ty7RA91iZ
         ukIA==
X-Forwarded-Encrypted: i=1; AJvYcCXLQH1nXTlu3jhfHvhCeEnrdEGfES4dC69yTpqN65/rs3yGNybqmy7bH7IRPr14DmBAtlE0Zus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFcYGUkDvDZk83jdHuc3jYBlPaWBml+YD+WLtxRsMEAw+Y+aF3
	dSaRaeqyLSrzAPA960saVBwxEIL3UqOnsWVxM8RBBFax2pOUzmZWriHJsy7O8j/wvJg=
X-Gm-Gg: ATEYQzygV31alTQYEc6yQVhg10DX6yH9QniVFa/5ANnQiVWfogPGUlI4+fngVSfPIhS
	rZTnm4PT3iQ/X3fQc4aVXwL7bzmIZK7UC50bvqCn/PnkKcHFqAbZeYt8Xh+b7JWL0o421ZPaFzs
	n+6/N218TuKzJ7Gb4Pf3OBVtELwbL2KYps4l9HgQ9rnUgZ/euSSc1ynyWQ5uePBb7uiQ1r9k7GA
	eO+Z09bCATwG/vSNE8tn+II/CSXpiisLL8Yiyqo9XNhYE4qKQWAzb9g8lfGYpmMXqMhRDok5zFv
	o1O8QQ6Q8cJK653d4z0QYI5jD/rT49uiSgVMLUR3XiVm3BopGsyWpEJ/hP9e+DOQBHLWIdk1DgM
	5vzwF1J6O5LjHrxA+LqAJsJCBOFQ0WqVA5q6/dWP3L/xOeb0Ii4dcs2m+/v63/VTrmYJi5CLD+s
	LVmYmomB9URkAEvkPHbfXxl7eiYDODc4Lgm4ptGGHhnwfLYo/F+KSJKw==
X-Received: by 2002:a5d:4385:0:b0:43c:dc99:771b with SMTP id ffacd0b85a97d-43cdc9977a6mr2793035f8f.43.1774680481761;
        Fri, 27 Mar 2026 23:48:01 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2580168sm3508425f8f.36.2026.03.27.23.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:48:01 -0700 (PDT)
Message-ID: <dfa17232-bc02-415f-8798-6617196d3160@blackwall.org>
Date: Sat, 28 Mar 2026 08:47:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 05/14] net: Slightly simplify
 net_mp_{open,close}_rxq
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-6-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-6-daniel@iogearbox.net>
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
	TAGGED_FROM(0.00)[bounces-272739-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 709F234D8BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 14:10, Daniel Borkmann wrote:
> net_mp_open_rxq is currently not used in the tree as all callers are
> using __net_mp_open_rxq directly, and net_mp_close_rxq is only used
> once while all other locations use __net_mp_close_rxq.
> 
> Consolidate into a single API, netif_mp_{open,close}_rxq, using the
> netif_ prefix to indicate that the caller is responsible for locking.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   include/net/page_pool/memory_provider.h |  8 ++------
>   io_uring/zcrx.c                         |  9 ++++++---
>   net/core/devmem.c                       |  6 +++---
>   net/core/netdev_rx_queue.c              | 23 ++---------------------
>   4 files changed, 13 insertions(+), 33 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


