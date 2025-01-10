Return-Path: <netdev+bounces-157105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF384A08EE0
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1F6166235
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87420A5E9;
	Fri, 10 Jan 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="MwO3UGQ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF41E32C5
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507554; cv=none; b=uCPVDYeuXHSOuEtedqoRJATwO8yT2ydFTrqZLcqwyrCB0TxeJ7GbgoX6uuNX4L0XplhoIe4c0albElVniol0wadmfT6VWxy9trFjzDf3EWdrGzz6k1s36OTLziJAAyuyluz9FYH2s4hGlrRg+pvqAHFcfwB5n0d0TaZj97mQuiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507554; c=relaxed/simple;
	bh=qXSynCY96TYG7wZ7OASI5Muii12uM+aBd0x+fKz2Q64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fE82IGeDN61HGtSTUi5Nj9IpYJQU/KdKaxt6NAl0Ewh4n36N+UbtF4GXnQa7ywUrNtqOFtGOqQOm2yyhzr6UFlp81VpriavJ/rfd1XlrIKa8Bjiq8UniVTxFd5iGa4hqWQk02S1fzRBJzE/7RBDAM9JuiXCinc5boAxb6RF72K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=MwO3UGQ8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163dc5155fso33488665ad.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 03:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736507552; x=1737112352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUI/Gf/iNdZ2kON6E6PSrhEkMNvEUQIh/sL8yMhLamQ=;
        b=MwO3UGQ8TvdlcnS1Er/wPY9ota4qi9gGOgTNt7g7S6YG1L9H3gqX0ExQeXxKJnXL7X
         XeAWFpsMp3pjyvWra0SCvqOuqk/80Ss1ztp4HN27fDmWYrpuva407XWMh4/xOAEXA3KJ
         WuOh5DzuQ4gbLE0fUUS7YS/+tghLtkvK+s5eGulTypBG7qqUOlAMyYF9c7Z+TLIAXXwW
         UE9+ude3fE3mDWHLqpT9hK6iDDqMJCmdSPQ2vfvJ015wBRsVUBZDs2Tw0Jz3m2fwhswE
         9BT0HSyyEVIF8eiJ9+cOWEtoHXvBzBFnnCNhJrTMzYH6h9prUzxWAnD2O7WOPlgDTkiH
         UdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736507552; x=1737112352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUI/Gf/iNdZ2kON6E6PSrhEkMNvEUQIh/sL8yMhLamQ=;
        b=DwQAiAL42/rQ1D/+rwRauR9pr6ThNvcq07KFovsbZHXxyBVbAV4fVKOfdhi1kniDE5
         ceEtNzpF43L75B/c9hyyS1ThtsVCJW298/lySzJy+cNMg95+7IiY5bdpBvIUvB+tFN1j
         Gwx5OjAshmFnttACzvN1AFQhF0F4FfJoVJFx2Rp29/or5vtxG3QkvjKAyCPPxATGtJxH
         amHMkUBDQEGqaYiTI7NzzooN2pqDeauFyRXe1qVJjUFDvEocxC8mzuVvVpLgq7itkur9
         ptE+KUI5F7A/Q2KJQGFmoSLLlA2nDBU1i9q/Z1bTCjToJyHMiXao8BOTXNJmf8URJUxp
         OTjA==
X-Forwarded-Encrypted: i=1; AJvYcCVoiB3tVPbGA4EK51wjppMRqm9TGG04px0WMt9/h4MaM+ePlNnfBIYx7SKHhGXYn1LLwlV5qSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDxJUrxdE5GKa8flNw+2MFHY57IsGyGoYhJEVhbnowuqidypRG
	RMyPbCXcBjelYAJDgDfJvEI88WN7eIErLZCXckluoIguJAqmaWsz9Qel8u9vg2k=
X-Gm-Gg: ASbGncsbdgg6+VDyWkqUvzt6AQnq179S9ydkDDBdazzzGFvcJOiZXPUo8HmBCK0IdOR
	MNo+wxSwYH+A02m40mo7D7jFnHUqf/iEfXYUt6fVNIy5xtuvFv5B6uFQuhFc1Z/+HXT8liIbJK3
	LdOAdGuK96yR/24pDcoi7OHjgZJFAl+qYCzUZUB4syj3sUhCjYHaGc4Tf+loDpXgpKDukd5JVft
	yiRD3j1B4OfpoOlz+eKy1Wi426V8FP2DxdTB2l6mJKymEo1pQpsXbo8COQg1Lt2iG4=
X-Google-Smtp-Source: AGHT+IFsisJKA6JOrR0eUj5WfV8wXSlwG+ErpDxaHPAWov6uHn2OYu5jltHENp4vvgdoL273AAhZWg==
X-Received: by 2002:a05:6a20:244d:b0:1d9:fbc:457c with SMTP id adf61e73a8af0-1e88d0a4770mr18461822637.36.1736507552500;
        Fri, 10 Jan 2025 03:12:32 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a2cfsm1373935b3a.51.2025.01.10.03.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 03:12:32 -0800 (PST)
Message-ID: <2e015ee6-8a3b-43fb-b119-e1921139c74b@daynix.com>
Date: Fri, 10 Jan 2025 20:12:25 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
 <20250110052246-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250110052246-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/10 19:23, Michael S. Tsirkin wrote:
> On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
>> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> The specification says the device MUST set num_buffers to 1 if
>>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>>
>> Have we agreed on how to fix the spec or not?
>>
>> As I replied in the spec patch, if we just remove this "MUST", it
>> looks like we are all fine?
>>
>> Thanks
> 
> We should replace MUST with SHOULD but it is not all fine,
> ignoring SHOULD is a quality of implementation issue.
> 

Should we really replace it? It would mean that a driver conformant with 
the current specification may not be compatible with a device conformant 
with the future specification.

We are going to fix all implementations known to buggy (QEMU and Linux) 
anyway so I think it's just fine to leave that part of specification as is.

