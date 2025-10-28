Return-Path: <netdev+bounces-233536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B64C15318
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B625634E7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A962264AA;
	Tue, 28 Oct 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGyFEA+2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC15221D3E8
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661896; cv=none; b=Gs5B7zI3a5hFl+Q+it8wA8YrxBw3fgsatuW4KNW+FiORiyFl582Qj8y5Q75A3gIfu5K2U1QI0JfbGlUzvRMw7ZNMiOUIf/FR2f5qVRJAkrMZLW0LIiYWCqF2a7kU2JIi72iRtq0a+wiJRwuUUiA/xLciSSm/MKuIFoL1VI/wXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661896; c=relaxed/simple;
	bh=lSvM53GFft+J8S+6HgqdJu8eZNoSNRi/6wce+FaPoNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHp1kkrld1uQpngJAkOosoHv2qCkoOZQ2ydwsPcf7M7zHYTuUPsRng+1GlctDo/DQCZNaKj5NBT1foWNwy9iuwnCxeTJX+/8gMviJWFvP91m7a/397bC7iNrKhVeUIJcyqS9pvrAvP8kSk0gKCtkf7Tjk3FKBmh4ji7doxY6JKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGyFEA+2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761661893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73/xPfC9sPKYuWBDNGOrntIS8v774C/e1wt54BijNYE=;
	b=hGyFEA+2qNou4Kab0bzN/De7BVeD2N4vPfemk2obMoAu5zyolB/b6i6x+6650VKtlxkwPd
	gL6gd7w0GEz5P4SAes75p83y8Wnk4rUsCaKGuGhldCzseLsd0f49LybvUZE4GTnfZFOezK
	N3QOnncFGfdzJzFsmGPtYEHbsJ7AGDI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-l_GLKNVBO_auji16ib-lKw-1; Tue, 28 Oct 2025 10:31:32 -0400
X-MC-Unique: l_GLKNVBO_auji16ib-lKw-1
X-Mimecast-MFC-AGG-ID: l_GLKNVBO_auji16ib-lKw_1761661891
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477113a50fcso22268665e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661891; x=1762266691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73/xPfC9sPKYuWBDNGOrntIS8v774C/e1wt54BijNYE=;
        b=QLSWhVV4A+s72o/aezpR0xEYtuu8BNOgEykHWvl6AqCkT2DKPauOcUivYeskir27e6
         UUP1J3M3QMhFmVzvUN8fVg2yxJRZWVeBzv7kH0ZSlLzG3jAen0edtu8EKWGB+/9ypEUa
         Uko8mWaQy2ziSOmL0DWvXKAnMqgUQxDnpJwRBmTamUX25wxT4ngR1suA9Ap6JFvGPkIx
         k8Dp3jFd/1zjsFYo+VHfdv+rtd7SKZIT2UgaNdzshoxC1a6rE7dIi1rqcaSSMHb2esAi
         DRNCncBEUqS5OvYB/Yr1zHx5qABL78dYLfuR/P8XYLPqD4ngQknyA6/jn5RJeJk5+NvO
         dueQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYkZJyuMutSatBCphNiOQ8i/nJJaTkCSRrYWCzRPl03AzNsHT0d3BhFnAcrkbZQ4NZaK65o6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5c2T0FP8+oSs1ksqXmQhvsXvOggSph+iMDwXeLUA0yvuBIVP
	Qs8GyqwvO3WW1fqpbFOWbOQ4iHFnRQPAGPuRyH4hpmXcpPw30sx6Vm3+GKD1Q0ZjRuz23SRm5Bv
	EUCAhXU65t6Nda6UVGYh2uuUG5MbktoJSJdW67sMo3NtXfYR9pcDOiR0V4Q==
X-Gm-Gg: ASbGncu7vAz1IcBTQUzHQml9YizL9gazPp/UMqrZbD8CrWB/YyDpOz6DMTH1Tg5RFzr
	53thSAzVUNB28n9jYtDaksz3jUcFjRwUEPd90WLTRTu5O+U7uhA003OZ14KO2BPCLZYq3kMhbNq
	WIHMufTp9ndBpdl/G42juzuDUhMoOm+x67pFaoa4y1xC4CYN+jWdMrFOCLAAwr4rkaFWf01sVXl
	6a9Ipe+9lywUS6b+HDxZNYQUk/hw6sMOPv5QZqMbxTiPI9qoOlpW+iIoiL7y94ZqlW+IM0xRlQz
	tLJ3+d/BQz1S4+OzpfJ/FDlSrEeMkJ9GJyadlw9SdNTQvmkfzs0CT4xAU1Hd2dXtPl5xRITlosU
	weYSeL/HzHBLpUqM6KNejJ/cAxCMmhV5Wycqt2Ca5QsuR21o=
X-Received: by 2002:a5d:64c3:0:b0:427:928:78a0 with SMTP id ffacd0b85a97d-429a7e9cb6cmr3247925f8f.63.1761661891137;
        Tue, 28 Oct 2025 07:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMOTsGZSXAVq3SjJu/2WS9NseH84hxo6jnqAKfyR6/9FeNPp9QtVjNi6BEGt5SyDkugzoCAA==
X-Received: by 2002:a5d:64c3:0:b0:427:928:78a0 with SMTP id ffacd0b85a97d-429a7e9cb6cmr3247897f8f.63.1761661890726;
        Tue, 28 Oct 2025 07:31:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a94sm24431112f8f.5.2025.10.28.07.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:31:30 -0700 (PDT)
Message-ID: <76598660-8b8e-4fe6-974b-5f3eb431a1ec@redhat.com>
Date: Tue, 28 Oct 2025 15:31:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next, v3] net: mana: Support HW link state events
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Cc: haiyangz@microsoft.com, paulros@microsoft.com, decui@microsoft.com,
 kys@microsoft.com, wei.liu@kernel.org, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, leon@kernel.org, mlevitsk@redhat.com,
 yury.norov@gmail.com, shirazsaleem@microsoft.com, andrew+netdev@lunn.ch,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 3:41 AM, Haiyang Zhang wrote:
> @@ -3243,6 +3278,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  		goto free_indir;
>  	}
>  
> +	netif_carrier_on(ndev);

Why is  the above needed? I thought mana_link_state_handle() should kick
and set the carrier on as needed???

/P


