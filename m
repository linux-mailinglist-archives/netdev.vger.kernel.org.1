Return-Path: <netdev+bounces-233673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72339C1737E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2108D4FB1F9
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76A357719;
	Tue, 28 Oct 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="pQssramd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5E3570D5
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691320; cv=none; b=Kf57bEb5RVwUfsVWtsmb8HAouK8+xTMysiUgjQEiakJ5bUotKWQI6rAjraOdF7unc/kpPs3CebtdwGDWHcCABzE/+3/wG6jfy+y1k3qKD5ffHVdSyCeSE4lvy4IUx3nyGRNUdrxMfAksQEdVZIA1MsvBeGUckWhEpkJr7a3F1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691320; c=relaxed/simple;
	bh=83BsrsHd9DtHXIvdniBfXhWCcsdNkwUdX9oNRcxQWWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMyZehMPQNSp9EX0GZtTKMEz2VzsM1VUP3EVtfk5wRzlgM0TKgA2PPm7X8lnAyWlWyip8Cz63FVNxjEur9FlgBHSv+lJEq5ucxuxY1bSNLrBhp+R0Qx8TMQQeLG7hqfqtlyrpNWKClYombI5k3ozZTSVkUgcYyABLRtFBMgykOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=pQssramd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33d962c0e9aso378221a91.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761691318; x=1762296118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhdhypFJDWIT7pOJW2kZUfFCC11WfHBrz2Nq1/pPCBQ=;
        b=pQssramdldvU+onZlFa28wD8JgrFRyeL3IrR/aJioO0jQ/255UX+naCkWP+mX9SqSQ
         +lNHcB25t1k0zI6/t/Pf0bDAdJDU3yLYWGk9PZt81kEuqQzvVz9AqpYv9tWprH80XZg4
         tgbycR2DBtSxkOmP2S5zqdv1PRovgJnoBRcTWXjeR/cCf3DRVO0loEr/Pf+DwR3tXpPk
         qFvE6tqVKouzNXjQg0DBTo20YnThIB2znsMA6rBgQBuUkXdThGYPN1X2S+SQl+AndbdZ
         QV/G39u8Lpl4i5iWxmtfAU58xOulFG1LfwkNGA/j91blo9ZckOWAZlmtwrQv99878dfa
         YFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761691318; x=1762296118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhdhypFJDWIT7pOJW2kZUfFCC11WfHBrz2Nq1/pPCBQ=;
        b=nHC4b7sPvCmuQjTuWngzMjpkkx6dhTurCJN5VZKXVmO7DQXlVD94yx2wj9HtuJnl6/
         SeFWDNkCIFWPhn5lgZtrh9vC8eU6Q/y+RFOpIaB+CFUSnZIHps/ZDB6phcKTgh2Ox1yK
         KB1b/ZdE+dDpCjZEkHC2WFkCkNLpmaZBOBG+1KDDjlu0vFD6bK8MVCXB6ZB2erMBntYb
         8ahIC9kfAdFrM3gOv1yqoealgd8NK5rTZ4i8RTIXsLJlnPx61oM13q5tgUV9TuTGrHso
         Hc3gOqggbXGtge07g3NbCB9KwYpA1TPFNV2oW3eOnjlKqRKcG+2le9VkNP8UJ/fyExe0
         8iCg==
X-Gm-Message-State: AOJu0Yxsjc5EFCFQqUZY1po2DAOMmK/XbxBunYa5HzFKhUJ0VGvCDVEJ
	dqHZn5jLiUmFJHFr7VGhTa4gDSoQSg33ACZC8+a4nZsFdEMiFJSVevzjHcolHGAnpJRZdijt2Eb
	2VHHwBSw=
X-Gm-Gg: ASbGnctwlheMeF4gjWdiv63FRHU3Uu11OTPkx0hNx3HSUGENfsPj2DHmryby95VAYZ0
	vg0L+ARs5UGg+5CJ/+GjBEe3d3ePG3IV6gKwCO/OYeX8Q8O6cnagAKj4QvEaCPCmhdn5Vxtx1Yn
	ScI2QvZ2BcQR/T6FhkV3W57qVqbF/ktGGuZn6JUNDXVI7T+XTLHVI4ufdgvB4ondMDCsM1NKDXm
	7Tt4li+7MGJn8YYn7G6sj6t23BPkaovpbv28/wJcsmyGynjeUMa0B5gHoj+keaxfEV9xygkpCAP
	siyHlITdtPEZXy+GsLm6AVYe2278Fg0GM67ETOrcmSo6bjcELPlcOEI9bFLGo1H50CajBzD6Dt2
	qzGsTYqYPE1VROKSS5t3Dc16zZyUYBiTb8FWF/9KVmtB0Fnu25LBDAQQ7V9keiP9jTTQMmufWkx
	1ccHDJy+GK+9evRlEfRzyiQPKQ9yesiqnKKkLB8qyWj8LNDIgqpKkTGQ0/CoBxY/ixiFiO
X-Google-Smtp-Source: AGHT+IG0iE584jRlKe5lISrbNMv41T1x67kLdkM9KYyyXjy+vROKVbk6iFfK4oAYQFvskuvGDu3KNw==
X-Received: by 2002:a17:90b:134c:b0:32e:72bd:6d5a with SMTP id 98e67ed59e1d1-3403963d448mr861274a91.1.1761691317762;
        Tue, 28 Oct 2025 15:41:57 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::5:1375])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81b40fsm13255992a91.16.2025.10.28.15.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 15:41:57 -0700 (PDT)
Message-ID: <2f2333fb-707a-4d21-a32d-776489ddc343@davidwei.uk>
Date: Tue, 28 Oct 2025 15:41:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-3-daniel@iogearbox.net>
 <20251023192842.31a2efc0@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251023192842.31a2efc0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-23 19:28, Jakub Kicinski wrote:
> On Mon, 20 Oct 2025 18:23:42 +0200 Daniel Borkmann wrote:
>> +void netdev_rx_queue_peer(struct net_device *src_dev,
>> +			  struct netdev_rx_queue *src_rxq,
>> +			  struct netdev_rx_queue *dst_rxq)
>> +{
>> +	netdev_assert_locked(src_dev);
>> +	netdev_assert_locked(dst_rxq->dev);
>> +
>> +	netdev_hold(src_dev, &src_rxq->dev_tracker, GFP_KERNEL);
> 
> Isn't ->dev_tracker already used by sysfs?

You're right, it is. Can netdevice_tracker not be shared?

> 
> Are you handling the underlying device going away?

Ah, good point, no we're not handling that right now. Reading the code
and intuitively, it doesn't look like holding the netdev refc will
prevent something like unplugging the device...

I take it an unregistration notifier e.g. xsk_notifier() is the way to
handle it?

> 
>> +	__netdev_rx_queue_peer(src_rxq, dst_rxq);
>> +}

