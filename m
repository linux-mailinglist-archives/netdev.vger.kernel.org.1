Return-Path: <netdev+bounces-140445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6589B67D7
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407071C21CFD
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 15:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF841EB9F4;
	Wed, 30 Oct 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="CGdL8b7y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1F1F4711
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302205; cv=none; b=oj+Hd1Or7FuT1/8ljwoMfULlAzWEuTOwzgS/rdRqneYjvyJ1oqqy5Y9ZANBkEadPXlRMc0UUjmw7Dufgn1yZpHWUxw7wsiJUDcT9Z6/fk/Mjfxi+84dU1yTBLD1xJyaTDlzEFGZaBt9ocJzLmbnmor67ZqzX9qOsiMHHSe9Gweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302205; c=relaxed/simple;
	bh=5CYlU13wxN3pMieiMaGbP1AuRi6+Brw0TcF0hZyJdpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAv+3CTdKD6UMOs1PJZ0kuD/ykddjNKhhAMDJ8IuAbupJBvviqHbPGJ0F+FBEyA3loRnWXMgCAZhRQGkx+ZSE4RwXY6M8/UQJTgI3/u2AT5yoGybrcjE1aqno37jxUAQZvwvwwGT5PBQgi+8DrAbnESmNJj4HiGoOhxZrnYgyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=CGdL8b7y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f84907caso7494748e87.3
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730302201; x=1730907001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KT1Rl3kTS58mylbtqpSpuZe6eBpuGZzkCTqOtOlKpe0=;
        b=CGdL8b7yfXNVvX9FLsLD7yqG5XX+vZe/51T4JlIMd69G0vJh9mrbzJlH+hJHsBedmf
         Stgp2iE+7xmiK5Xk8mv/KpHgb4+ZmkPfXd82K2k8J14i8eH9AnXg1+/Ig9hFywmzQj5p
         zlQdjHo4vt8oERakHsgkWvRMByu34YecTjuMmLUf1MQZLDQk+U/8AD54eL2GRXFjKZJh
         0chM5OuSq8y+q3G2RvUqL3WQ+sghaXJ0XZ/xgYDhPiHAZFAdHmWfaZw9G88Wt2F/37L7
         TEhfSTaxPgBRn8Re6v4gGG11GrgQSumTMaA1kTL02r3x5LrUPf2+dsOQxvn3FHSdIKX6
         O87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302201; x=1730907001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KT1Rl3kTS58mylbtqpSpuZe6eBpuGZzkCTqOtOlKpe0=;
        b=Zy4lnDAt667ngyg3UXZFi8J6LSV+jMH23Qtvs6T8+mc5zSpXSonbfKsYziQApT7NhT
         w0FM7+dix4whxaZgfuQ/EY+sNSLAgSfHHxdWKJ+U1e+AvhZulWHeeocYRXfgFjDwAJFd
         krTXagH8dgNeGc6kaL/Wa3FFd4QoPmVOrCkuvQRf+8ovDjDBNdaSHQkXfChB0+6p+1ts
         lQSz9zZShs+ue5CHSy53i0b5VTu6VC8lt4kp+xldSPqIU3g71uyZszwDJXc2bDeStuhk
         GK7ObzrRadstc4oHqi3NmX+AZCePJLFmQ608VeAqlquXyzROI0zjEdqCQDLQED5ZVZsD
         oBJg==
X-Forwarded-Encrypted: i=1; AJvYcCU8s/pbyq10B4Ji9fYd4nPqJPq3Xp9NwoGqaMcFkOsKmvi8GHzmQf+H6KLp7saciaFhPHBWzGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ViR+vKKffTNPzhScbTXF/fCFG1FV+56vWDcBDZRqhJIC7wS7
	eBNWiSsSz5v+EuZDPSrxnM7MRIr4fK1WGwpEe7sLmFzygpGM59k3gteNS1No3gagvNxGzSUOxjK
	X
X-Google-Smtp-Source: AGHT+IF06FD68FGsb9Am/OuTmp644K/y7BVoCARZwD3jKU00IF7Zto5FTyTr2w98MzrHnInXUu2BBw==
X-Received: by 2002:a05:6512:6801:b0:53c:7652:6c9e with SMTP id 2adb3069b0e04-53c76526f55mr872653e87.53.1730302200793;
        Wed, 30 Oct 2024 08:30:00 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd98e7aesm24889075e9.35.2024.10.30.08.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 08:30:00 -0700 (PDT)
Message-ID: <f4efc424-6505-4e20-a9f2-14e973281921@blackwall.org>
Date: Wed, 30 Oct 2024 17:29:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute] bridge: dump mcast querier state
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: entwicklung@pengutronix.de, bridge@lists.linux-foundation.org
References: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 10:46, Fabian Pfitzner wrote:
> Kernel support for dumping the multicast querier state was added in this
> commit [1]. As some people might be interested to get this information
> from userspace, this commit implements the necessary changes to show it
> via
> 
> ip -d link show [dev]
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> v1->v2: refactor code
> 
>  ip/iplink_bridge.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

For the second time(!), please CC maintainers because it's very easy to
miss a patch. In addition to maintainers, please CC reviewers of previous
versions as well.

Thank you,
 Nik


