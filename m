Return-Path: <netdev+bounces-234895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8511C28F05
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 13:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0878C4E5852
	for <lists+netdev@lfdr.de>; Sun,  2 Nov 2025 12:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762B02D94BC;
	Sun,  2 Nov 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew1P6w8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E92C2356
	for <netdev@vger.kernel.org>; Sun,  2 Nov 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762085693; cv=none; b=EO+70bxuuFz3bfDUc9WxpR9NTmryymhxFjNMiFVleucvOPY6XXWRA+vDHM6Bt4gkihByyjeZBd4E3BlRtEdO7r3b+SZVEk+BAr7ja4ehghA4wi6Qqv6GK5vKEKtVKa7Mphe7vvnpEwMpc2jdZ/R9RCYnYgzP4/2T6nSoxt5fkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762085693; c=relaxed/simple;
	bh=LMNeTSPwxETdBy0HzCt2lQzCrYmDYnoVXAlFu6pBI0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayAxqQ7SmcLh0h8a0KuiaTHaRiOV15+lNM62QCA2b2BlqsshmNPktH1DTPuCEkgnelmLbc1vgnAOgjmLXplivxB0p/vnk6YW3iE9YvGgtddBuPUWfNOsDPnAxmHa3b+Z1s27Ah8w7r1X94JkfU/sgx2DeJlsPMHmv8GIk5COlWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew1P6w8W; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47728f914a4so17890925e9.1
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 04:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762085690; x=1762690490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTHylYesgJBra3YugE8dFYJP8cm0/3QzxwX2tCmUu3A=;
        b=Ew1P6w8Wlypkp1BDo883I9Z3CaApYqjQpMNSAVAqsiG59AOtFCa+JGFdgdScdR1UHV
         xn7hWp36cVtEgbpok062AJwkKJRJOkEbezdk4/eTVPZh+68DM5eed98FwW4D5cWUl1Mg
         DWS4WwddQglE+FU6GC2T7LWq7whMQRvqjkzEqipBsWjspG8z8v1jE6XLUGijiAfuI86g
         6uUSAz+XTIUOHh/ZBnlxWPCrkfVj3QqYQE6uoaQ5kUm8SfQ/SgjQIL+OeD5tkcEb+TkP
         6eQ/w+TWCZqUZFOvSk0Xf3n21SVfKYrpr+ZtzlLWS6JxH5Fj5JeBsksMsiqYb3Sd0C1N
         sXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762085690; x=1762690490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTHylYesgJBra3YugE8dFYJP8cm0/3QzxwX2tCmUu3A=;
        b=cqEn424gdlxlGQwmWJhXQHotwKLKP1Otfm/pELU0XBjiREGXPWKs/ECpW2qKeY6COd
         qQcTGDCpR8Z0HwBZHgKVr0Jbka8evxW4PWKUxmxLiPT5nu9BfuNZPEAJBbhqUKZ3GVZz
         WJJGyfO2eO2GeoPt9R8DmCWM2AHZ2dSKF8IFfWFHcyJNc/xnkHVMLiDyyrkInt2M1lBZ
         Itss+qNTiStOiNixoO90wVVesVHGSYfFWdNQ88LvD+4Xlj7SeZvJ4mcgbAK/5Kd0y6xx
         gZc/o3MWpneQB/mlmY2YiUxrvoQWlfQgZesRqBq3E7Kv2VR6LudwSXGRiGz45JmfNevf
         pUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKt+2LBAT59CdKFRB68guQfYSePLF0rvGoBgsaaOX9urk9znW7Dj5yXEgcC0n4TeQxQP3q7JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQA3aJyoi3/urvoLut1r5A/YstyzHcqY4hHxTxBRQ46ll0ovg
	+yWDo/GFmVz+vwnJ9C6ndrgvsyN9nEm/TB1PaLLGTQwQwGqyB+wQvfKZ
X-Gm-Gg: ASbGnct4hP8q62Ba0pKC57MSfXf8WY97k0S8wW07US399FYHeRTsICjzeSz8uI19f2E
	RqBstgvI8RpKgQ/CtH7cb84/bzCSwrYTiEQ7SrO8yGhC+LZY1wND6vwbszd4j5fpNibDm1zZkMS
	6xIOFdsGqr+Ou6ApZcQSrGSIZXnyIbxHyr2Vl51xhht6vP1fK7XBDlAY14LQfCPS2NS8CrRp5MO
	IQsdPB0H9dPCIqZO87odXPiADN2AXKSUQuQs35JE2X38TlM82xXRJ7srdrSJ/kwa+MJSZ88M8+S
	5T+vanEetiWDcCZnOvkCMrEoNpBDG/3FNbUx9Yn4ftVkXzi+iYxdUFtr24aM8pG/p4r7Po+Hyc5
	dXKevg5iuN5J8fq0scs1NdBm5jgkorhgiKtHJU284N7EQX2p+hKSPH9IoPUEJ07GVuKXJZq3QsB
	sUvG5tmrG+V8FCxFIzKDB0SPZlZze9jr/D
X-Google-Smtp-Source: AGHT+IH1p6Ca+IRbV9+qKgOA2mVZT+HdAJKOwMyPbywz/Oxjd+UMOv1XaOrufqQeUV4NaEMHxeB90w==
X-Received: by 2002:a05:600c:3e07:b0:471:a96:d1b6 with SMTP id 5b1f17b1804b1-4773b1f9db7mr62398135e9.7.1762085690093;
        Sun, 02 Nov 2025 04:14:50 -0800 (PST)
Received: from [10.221.203.8] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c102dfd2sm14345862f8f.0.2025.11.02.04.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 04:14:49 -0800 (PST)
Message-ID: <4d9a2c4c-373a-4ab5-af8d-474212e21762@gmail.com>
Date: Sun, 2 Nov 2025 14:14:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/6] net/mlx5e: Convert to new hwtstamp_get/set
 interface
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
 <1761819910-1011051-7-git-send-email-tariqt@nvidia.com>
 <20251031164208.7917f929@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20251031164208.7917f929@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/11/2025 1:42, Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 12:25:10 +0200 Tariq Toukan wrote:
>> -		err = mlx5e_hwstamp_config_no_ptp_rx(priv,
>> -						     config.rx_filter != HWTSTAMP_FILTER_NONE);
>> +		err = mlx5e_hwstamp_config_no_ptp_rx(
>> +			priv, config->rx_filter != HWTSTAMP_FILTER_NONE);
> 
> FWIW I think this formatting is even worse than going over 80 :(
> 

I'm trying to minimize checkpatch warnings while preserving code 
readability.

IIRC, clang-format produces such open ended code lines, so I thought 
this would be more acceptable.

In any case, I don't mind going with the over 80 option next time.


