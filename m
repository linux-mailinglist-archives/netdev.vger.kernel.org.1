Return-Path: <netdev+bounces-125503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF6F96D687
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFC91C250E1
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9320F1991D6;
	Thu,  5 Sep 2024 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi05vV5m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB01991D3
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533884; cv=none; b=dr4s4fAAN3YOJK5NK1f5yS0a/Zk7OcbOJnnSfJ0Loqn19eUuQwvK6vB3Ljg2NuVMAf/OT9aAvFjgFyrBTH2+ev3enM+gU6NH1s7kf26KVpPjOiE8v1X3uCSazay5V+KsZcYlKT9Hujow06Gp8wCVDZTtoEG8S1moO7la1O02jUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533884; c=relaxed/simple;
	bh=vbhSjlahF+YbtKx5np12W8znIMdw9X52H2/MWGJ/1wM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EzhpMiQgYUxJLRsb/aNpwWinIABsbpLAj9FsMOs4wqOMdAgrThLm1I9vO9weeB91LC0kdCTgtlgfPG54Dq6q7wgcSXsK3sdfjUzHRBftzw8RJkpeso95oCGZCm2BhM17W+vpumEcBG37lEzwOZLw9llsIvyuiKYhQzjD7QoYKHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi05vV5m; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a1acb51a7so72994266b.2
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 03:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725533881; x=1726138681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbhSjlahF+YbtKx5np12W8znIMdw9X52H2/MWGJ/1wM=;
        b=bi05vV5mxKSRHfIhV+6mt+4K7ZxfqUtmitKQH0gMu7SZ1ZW95FlTOGV5kKRgUVXYaq
         zRoYrISgafXcf/Q6O5gPoFP+WVccUXOQGRZ9S/7f+mOFXQeuZT3YvL3XTMlkzXAnpYGE
         gvdBPm9keQIN9Ip05YAP84tKCs17pRHNUEeUEYCvgCL9aV+sNzNX6RskjnwuQ0z4snf6
         iPmro1+44upbeOdKAYW6NR21Bjsjsi0fEoSm30tH11h678o48HTQYHeKmUk60uQ+pECF
         tl0V55PW20Cf6/cloClaS3BOsGATfhBm96swui6fQjy1oicif+eghDhNFwiQLFkQ24I2
         Yswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533881; x=1726138681;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbhSjlahF+YbtKx5np12W8znIMdw9X52H2/MWGJ/1wM=;
        b=bt0/2CTmYLZNwltnItPhbLFWfVYunusmaKlu1fe/N6H3ZYYXIVh6GZVDEJcZa4P2VD
         dz3fhJmAkc+FA2XkcxzZKCLzUmQD+BKjbkjZ3ZB8NPePk+kVvTUglpdl5ssaJs64WKD1
         X6iU62gN+zVhCfd8AQpDl/CvsBmkIz9JQpI4TG4DeriABIRFVeDTB8Jdsq3SqBthPJdG
         xgHbmjNeByHmm6at60nFMTXL7jTTYNiqLRaqZ+BQ8uVLNhWR3pIXph1vzWYfi8IgpbK2
         yRlY0myd8UE7U5n6kUqo8trlvPkKJqU3RZW3sciS9hnt79zBnvNfFIn+Gevs6Ap6Sy3f
         Qq/A==
X-Forwarded-Encrypted: i=1; AJvYcCW4togFNOTsKsvg4d2lwkz6AMz9wcYEUN519iI8z9YPfHZUtrxqEsoKg92jwjzap6LD9cUzxP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbdohNUQS4UP1ZtL88GrExpj4bVGCUY9fZKk9WXEVLoDYdsiyH
	yxt5bClgKN8kMQLeJDTr9uInXpzx7l4/qOtq+0Vfejp6TfVtOg1s
X-Google-Smtp-Source: AGHT+IG+s2k5A6qHYs4dq/rGUfEL55V/PaHQRef68n6uRu65SJXtEJoToQlrHA4kC3bGyjWP2YkNYQ==
X-Received: by 2002:a17:907:918c:b0:a8a:7501:de21 with SMTP id a640c23a62f3a-a8a7501e0f3mr70135666b.12.1725533881133;
        Thu, 05 Sep 2024 03:58:01 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a61fc350asm122770766b.19.2024.09.05.03.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:58:00 -0700 (PDT)
Subject: Re: [PATCH net-next 2/6] sfc: implement basic per-queue stats
To: Jakub Kicinski <kuba@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
 <54cf35ea0d5c0ec46e0717a6181daaa2419ca91e.1724852597.git.ecree.xilinx@gmail.com>
 <20240828174114.412e4126@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <f7da4b25-234b-8393-66c8-6adb66ebaaf8@gmail.com>
Date: Thu, 5 Sep 2024 11:57:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240828174114.412e4126@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 29/08/2024 01:41, Jakub Kicinski wrote:
> IOW let's not count dedicated XDP queues here at all, if we can.

But they should still go in base_stats, like other not-core
 queues, right?

