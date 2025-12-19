Return-Path: <netdev+bounces-245492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F8CCCF15B
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96C82301140B
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92292D7DDF;
	Fri, 19 Dec 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhZQTdSw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4rtei6E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35015221F12
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135369; cv=none; b=m/XP0IljtVZNdBm8konbC+MnydH7Cv2vbmkWZAO5pyooDpEyVCGnAfoUEvnQVTES3iJlJdAf7c/nsHc8mQihPCVeNVZC6/Q+/byxuBTUTAlry8IJ0gZlsSRH//M3eG7XFld6TD64jAFwgtAjHvA4BofCKQ1F2tJ1NNug23o2uoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135369; c=relaxed/simple;
	bh=0yATwB01TFt/wQCHC804x0H6IbpC3LjdC/VK8/8pC7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXAzMpjQ1hFayHSgf+c42NrsORiDcwfbDd8CpyqEoOi0U5HtFBKPmm2COkOdY0JGq4J1PbYs6RSyq9VhLCWfL2I3tv20BPBFsevNYnZ2gK/atzXlvpqZNfWCTjUEBHRhkJMiA5Cwa05D7/X0qKWOYPMIpi6NBXufDWpIyEA6wvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhZQTdSw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4rtei6E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766135367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Om6/72JV9hfGA/7FLAPjcSWYj9oKZvBkTHrUaiBphM=;
	b=UhZQTdSwcZ9adac5wEmF5/XdiwRGBAVMa4xn/F6eAJXKMmttgp7GVaRk7qc8tA8+wMju99
	k76zdm38Tkzdq63BzhjabV+t5GkXTseDrhJKDnegQxoTCFt0wn2pafiT7FrPYId6o8YAR+
	8mAMktHbeCw/Yl81DbCiBURCEv186OY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-VMJHq5OsNf-brgiLZX58xw-1; Fri, 19 Dec 2025 04:09:25 -0500
X-MC-Unique: VMJHq5OsNf-brgiLZX58xw-1
X-Mimecast-MFC-AGG-ID: VMJHq5OsNf-brgiLZX58xw_1766135364
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-37fe032750aso9007221fa.1
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 01:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766135364; x=1766740164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Om6/72JV9hfGA/7FLAPjcSWYj9oKZvBkTHrUaiBphM=;
        b=J4rtei6EUgQmrfMscnGj0yT+RFTd/2hR6DXi3JtCzFIgDVBi70JqOGC3QbvKFlbaCG
         IbF5sET1DowcI47eNJ+SyjeTy1b9tJOy7zDZ7hNTsO4Ds/vcb373w8AEmRyTcXM0oPkl
         AuZJXrYNyUvTbG6aZM1rkpNapcD6Z7KNIHbQ8wJY7ywrRWshfGvMVZxpsuQ3psN8EKhy
         /7zo1dp+g7tfancoC7i2ZWByqAd2uR/tpIvlXlRc74ukc+iRF0DLdVk99jw10JUbmUUv
         5czbjaKS2f02i8nTg8zuFp8SUrxOxJT4xypyZnFAMb/Mcl24AHm1R5BWG5g/3XBXZ55z
         luXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766135364; x=1766740164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Om6/72JV9hfGA/7FLAPjcSWYj9oKZvBkTHrUaiBphM=;
        b=bVw0TKgjJeDJrQRvdTlmyp+e0vBZ7ZDUzi58o7FaIgHFuB8eFApp0HplNHyZ/TxQ5x
         VlzkqdvFHxzQV7Wr0wKLVU0smZUD6FoQcPIvtF1lB686MO17Tv83TMO31umYIMz/9FDi
         laS0OD/P0+erAAX09H/PTxfdvq/ki/QvPPY9YDPcfmwMyxXWulixAAnT3DMX5fos/jh5
         n/FGBCngLOHTtxJu/GNdr+LtdVb+QoO2073sVIQJw10Cbf9SVoywDdbucHdHZNN+WC/q
         3gfQ47zrYY6EM0y5wxgSFjAc7c0n0SCL94tRyKtGBeBsQ84y4gGv9M432IYruOk9f+g9
         gViw==
X-Forwarded-Encrypted: i=1; AJvYcCVwekMjC5ibaaVQyMW5d1tzSP98xzyeICpAe8felHa45JOLUO48Q/Ny2ZMGXFCf1oCz/7y5WFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO4J/p4c2tHN4m8IsyYLnkZbYAnaevHqtR9j5X9u2hujvLExS/
	tGUi/TF+R0g2usT6CD2oczcJRq3H5HRbF3G++oMvvFSD66SxrcxQ7738xmmy7n+EzV5y3HeRhzh
	STjHWL5VRuufVoCJh8vfpmel3+tluqNuy3cK/gaTvYPf153eHCLitzcKrXYD0wbWVxA==
X-Gm-Gg: AY/fxX70i8aR+De1YiWqp1/UbVCnBP3du/uNB7allTuHZz2fX6zaXlQWpn6BNHkuosn
	R3WJE4rlJPBtDdFJQnIoVMNRnSGw4hXxgCHH3BsNLnf9WY9OkIxavxyHwutp3BM+c2WQhq82hnk
	JzPRvOLHYBukqJkV4yqxJnGq2Fhe0vPS818kEfsxNH7H8X1MmUqvUFd2Hmi4h8GKC+y02zrLcYc
	V50Kg0K0gQutZ6hX8798t/UaXCxaGe5N/H54RGy8NSDxbPJsqjCIgjnfCMIU/yxRQtPxfW2ATPt
	nAe9/lVcv5nY0wGupmv45zfCSDkq3H4K3JHZzE+pwDXkZ680adHlhoZpKVXMgAROnWmH2rM++rx
	h7fyVHD0iA0L2
X-Received: by 2002:a05:651c:110d:b0:37f:d7eb:15ce with SMTP id 38308e7fff4ca-3812084e9c9mr6206831fa.18.1766135363652;
        Fri, 19 Dec 2025 01:09:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOHKupkXY6JdkumSJGECsgvNJ/mF/3IBCldRikCxb80MSF0D+ZFew9zj5JSimCQjivA2qIDQ==
X-Received: by 2002:a05:600c:6749:b0:471:665:e688 with SMTP id 5b1f17b1804b1-47d18be89d5mr26503065e9.17.1766135043549;
        Fri, 19 Dec 2025 01:04:03 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm85354455e9.4.2025.12.19.01.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 01:04:03 -0800 (PST)
Message-ID: <e1f053a7-791d-4433-b7ba-ea17a03ddfa7@redhat.com>
Date: Fri, 19 Dec 2025 10:04:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Add LE Channel Sounding HCI
 Command/event structures
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: anubhavg@qti.qualcomm.com, mohamull@qti.qualcomm.com,
 hbandi@qti.qualcomm.com, Simon Horman <horms@kernel.org>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251217112523.2671279-1-naga.akella@oss.qualcomm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251217112523.2671279-1-naga.akella@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/25 12:25 PM, Naga Bhavani Akella wrote:
> 1. Implement LE Event Mask to include events required for
>    LE Channel Sounding
> 2. Enable Channel Sounding feature bit in the
>    LE Host Supported Features command
> 3. Define HCI command and event structures necessary for
>    LE Channel Sounding functionality
> 
> Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>

FYI, Jakub enabled automated AI review on the netdev CI, and the bot
found something suspicious in this patch, see:

https://netdev-ai.bots.linux.dev/ai-review.html?id=999e331e-1161-4eec-ad26-fafc3fea6cfd

I'm blindly forwarding the info, please have a look and evaluate it. Any
feedback in case of false positive would be useful!

Thanks,

Paolo


