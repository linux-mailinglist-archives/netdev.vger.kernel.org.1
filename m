Return-Path: <netdev+bounces-213749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF6FB267E2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E428560936
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0842F301015;
	Thu, 14 Aug 2025 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpiq85jB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5969E3002DA;
	Thu, 14 Aug 2025 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178303; cv=none; b=h44Pr7yZhGbiCjiscVBxz9J+jPnNnpEKQ85DxnHeccFUPyGp9xxpGAeKp7lEGk7RHsKk7fWmnLyA6jjxZ4BN7zU/VOIFHZRMPhstjqU3jzuDDavYqLnom3kt9MX6NSRoqODNH0NdRLyjAygB20JgXw4OQMvLokf5xy7xRU69CZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178303; c=relaxed/simple;
	bh=j/CcsfHRI2aria9TYxpiLWaiu8mt9dV8erunuwbsx8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtFSCET9vgstoTzTyMlGDqEjQfinx116XgEaK7UH1H9zmdDTLTJehOtYPFhClToMvYAbk6TfUezHFDq8GvmZnVkTabF9oWbg5RW8Jy6oVSYdcc+KjMuCKUrtPN6dbZxB4rwVKqmia2Iqjvq/AOnmHPw8jI+zpAam1ymiBvRrz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hpiq85jB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso4176385e9.1;
        Thu, 14 Aug 2025 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178300; x=1755783100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SnTc/H7K2rn8Q1SAAT9lTXD6ocPixuR5mNjT5ytBa2c=;
        b=Hpiq85jBGS7xRI6fGQpD1uyyCxerzQx6pnjb5YDNEhSrppCFmHKfTlxbTscq/CU/wR
         Wzgby72RNZoUY1f7v52201iWlxDJkbk5sogQwh5/Q8c5bgGVTbY5X/ow5XaJqZD8HfFn
         M8KKbs0NB0GWK+73Fcl0GZ/EpwUx31H5lKIDtQsUO1pBcG3GiszKBUGzAlVFERC1byix
         qP/keeAaZW8HoOFi6tSmEgU3i3lMZ0y/AWWkoa3WNxnri9b1gVNigwd07o7sTdmoRMn4
         jA+3MokOUZSY7DZjPvfLPxFg8vunKssN0M9apqVW1XVLumKRVwl0f8u5D1ze3H9ELeke
         YX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178300; x=1755783100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnTc/H7K2rn8Q1SAAT9lTXD6ocPixuR5mNjT5ytBa2c=;
        b=g9mkfHVsQU67Wj5nTGq28dTw0OgkMw3bVoDIpRTaf6DeScL5GsY+X3UVtonThbolTM
         dzyUKe8T2xGmhXpLnBeTBfY7Usw5RScDJzYMly6tdS+NkbLpaxEZz4pgB48lYxaLc/aQ
         YxuTIwQHehIMehOci7sObrHljv3ERfl9P+VDbGvQlm5DEGPm0cas3pqD1zfbrscRYEx5
         U/utTVGl3jlwAGeckmT3eQ5jdj/+EZrNp5Ijo7r3WFpuYAH9LFfV7ZG6vhQ15kSYALGC
         lxg9BxQMvykTTKnkvz6mC+DrODrXTLQfhOP+y5WoxWbV2b7ZP2ebwrUCt+7uS5KwtY/z
         i8jA==
X-Forwarded-Encrypted: i=1; AJvYcCVyPwHfssr4UEIZoOwbewJXGGodg8/8Ck8cXaMzdF1UYUN42pPx165Y475yB3TvCJhIlMzv3zuJi8BXzc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn6JKM3pytxgsVpwFUNVLB1d3cry/xS16LUY31ZGk/5rTCULov
	t8AXekZ3A1bI+ivaZeMxoecpukJbrw05AL+Rc8Trike4jDimRyqpkUsk
X-Gm-Gg: ASbGncvbCZgUqSJ5IRCJvUxcfS+5CCcADaTMO2Q8S8chWPCNaug2W7W20z987A40QgJ
	fzps00JwR2k7ZEEmhRuB4//RLV/Z8kCCXDEtz9EMcWB0PcF7QvXcGTj9HEQ+kqO9UuRFQ0FFpUq
	sXtB78oznkN1dnBlHPSdq2SKD8123fSOzpKGYgAgpIFLlgyx5bV8huh1jI4G5YMGk+usbDH9oMZ
	vSw4rbNuTIIgTER9WcB6/K4bsN24B05OnZrGSKylW7SVxmD/roUYz8jiqxs5/aPgWUEpcyt3iez
	dscNFjZXLCwuoz+uwBanRvZcaUKHUWiceXss++Ts1wWE79RoatblqBVkuL4GZltYGSspwSWI0HA
	dxtgbllw3h/tQH74oaeMvc2rJnEXxeEwHaPSH83/y6ZqKhWrVD1SDrbdOxUXsbBkWs6Ob/MOz9b
	vO2PJTWtzteYAErYZWVkyO
X-Google-Smtp-Source: AGHT+IGT1v6PsSiGOBKyeYo5lfqQ2AyWMRlSCO8xLfX8P0Bp+0sQ7LVMZtIR24IrqNYB743nLfqWgQ==
X-Received: by 2002:a05:600c:4f45:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-45a1b5ffabdmr21538895e9.1.1755178298857;
        Thu, 14 Aug 2025 06:31:38 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b910180aebsm11287984f8f.59.2025.08.14.06.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 06:31:38 -0700 (PDT)
Message-ID: <15275726-396a-49d3-af41-f9f2bede0f2a@gmail.com>
Date: Thu, 14 Aug 2025 14:31:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: replace min/max nesting with clamp()
To: Xichao Zhao <zhao.xichao@vivo.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20250812065026.620115-1-zhao.xichao@vivo.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250812065026.620115-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/08/2025 07:50, Xichao Zhao wrote:
> The clamp() macro explicitly expresses the intent of constraining
> a value within bounds.Therefore, replacing min(max(a, b), c) with
> clamp(val, lo, hi) can improve code readability.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

