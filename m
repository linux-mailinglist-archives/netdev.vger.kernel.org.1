Return-Path: <netdev+bounces-106657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EB917219
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7965E1F2536D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E817DE24;
	Tue, 25 Jun 2024 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTvrtFik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3017D88A;
	Tue, 25 Jun 2024 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345682; cv=none; b=MB5d7Qac8Vx9gV6BGBGhMWqrdzAgppsxqK7aVkCCUlugUuvlkKvNkOjYtjyvms1173V0u5IS1hcyWtfUgcXZqzJflkrJsCRll6CyJOagu+x4NCCrSW1MCI2AcrX53Q5hZovhJUjnSlGrrbnEAUawWEmykIUdkPSlfE9QEJ7BETU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345682; c=relaxed/simple;
	bh=9YN9fi+RGmQ61gc/Yy7uiRwXidehsBVMtZfuJKgiBPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDSejXmyj7THNp/Gm5f6FTaW/Jfq4d6nh6qAg5aP9GJDjuf9b0CXPY1rCsHfHDs+lkCqq85fQZ39tY2a85oagig6z9aisBF+dxP3d7rS+StbFOQbuII/XzMjM2bmieDAaH4E2nXm/SZzWW+w3Ktv5usDzJ6qlF85SQ9j0tSUdTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTvrtFik; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-424ad289949so1401855e9.2;
        Tue, 25 Jun 2024 13:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719345679; x=1719950479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OihNYLWToVLg3DrhxWkLSuZFKz7uS3h2BS33G1TLL6c=;
        b=jTvrtFikJjLZogYrmOIDx7a+cSGLqDanMnBgMePuWqW8AU6VyqWRKMU7tgGQ1CV3Rw
         FPkVuW4OuKPgMu4lnrPIrODFqmS+mBmX7SWmW0e+fdkteE7D3qaoWz4HeqcBjBRD7gSS
         w/G463ydX0YP59fpW0M09t1wQrpEoROOP4IVQ0FixYy/F/ArWKJbFu+SaFj5x8lVCZg0
         CJ8rCn5XxuH0kySUeUdm+Tnux8DdKv6r0ZDS6p5gIv29igWK4+51Dx2COdLH/VkXcOCX
         fS/2tzseOwW8kk5h2r1uEGzYjkydOVhG9cjcaZHh/6lgDtKmHCD09kLRPSZRpVpzXs9q
         0XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719345679; x=1719950479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OihNYLWToVLg3DrhxWkLSuZFKz7uS3h2BS33G1TLL6c=;
        b=qSbi1ApJTXB31BO2T0AEOcxL16QCeDfG9zPGi5yjBzMcuv4GW8d4CedmrH2ykYZqCH
         biChMXHLU566aSgWc8U4LMZWCc6TN9nVpqBMANWu+gb92rhSlWMJZm/oin3syw9lR5Iy
         X3+pc1yUn7mdYaNpYKpfDzpA0MI/2lJlV0eaeb+XTinXdAed6yCkprxxKmJ+7tVCmwZC
         0fB52rO6pTouy7eDpjW4oqvJo8WXfpQ0bgeVTuiSD8BPHAfJ4MIJMySU6wg+QkAOZALE
         n/n4t1ITeklrnTm5ti4bJTQXFe+/E6V7e5qxr3tq9ugKXpzz1absKoD0rZNU1lOPkC+u
         qovA==
X-Forwarded-Encrypted: i=1; AJvYcCXhYyiLbESdjeZleqBC7DY7Ff1N+sXOEzD/rHZb/n99vy4CTNPcnDaIikr6e+4/u8nphtzBouMf/3ciOb7LGoWF6nr1eAHH
X-Gm-Message-State: AOJu0YyhYhJ55FEjxW3YrN3rrYo8JIjrK85Fk4MGPT2mXKhxJubq1jkg
	WajFYoFoYU2rWIwlCnYLTI4sIB1Ltwm0OXbv2x0ZmYpyfG+qBUf5
X-Google-Smtp-Source: AGHT+IGzaRTpv9iWH0+7n8XA/0WsLNF83VWr6i/ycNt83bfgGKXMT8lLxxQNg4KLpKy/K2+iil/UpA==
X-Received: by 2002:a5d:664e:0:b0:360:6faf:53f1 with SMTP id ffacd0b85a97d-366e7a51d25mr6156708f8f.62.1719345678322;
        Tue, 25 Jun 2024 13:01:18 -0700 (PDT)
Received: from [192.168.0.5] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366f973b7e5sm5028044f8f.14.2024.06.25.13.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 13:01:17 -0700 (PDT)
Message-ID: <724b82c2-48a2-4487-8298-47d4a781e897@gmail.com>
Date: Tue, 25 Jun 2024 23:01:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v2 1/2] wwan: core: Add WWAN ADB and MIPC port type
To: Jinjian Song <songjinjian@hotmail.com>,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jinjian Song <jinjian.song@fibocom.com>
References: <20240625084518.10041-1-songjinjian@hotmail.com>
 <SYBP282MB35285A10C24927915FAB42CBBBD52@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <SYBP282MB35285A10C24927915FAB42CBBBD52@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.2024 11:45, Jinjian Song wrote:
> Add new WWAN ports that connect to the device's ADB protocol interface and MTK
> MIPC diagnostic interface.
> 
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

