Return-Path: <netdev+bounces-175205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A036A6453B
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20678162CCB
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2BF21D3F6;
	Mon, 17 Mar 2025 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3H1ktej"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8EC21D3E8
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199830; cv=none; b=sRjCtWTwdlrLg33rpV8W7oF9rOP1NHPw7adTWDOOGM+2TR+dv7cJdZcdxu0nZlhwR35F76m2TzBW/jMWG4mPo0v54JW2Wk8Q8w50Vhn+p4ctuEtmeOGyMdWGHMZcWCyvbJhXcMRW7TwYT4q6LONpNx6gMA6LXTY0wxK/WctDP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199830; c=relaxed/simple;
	bh=6F6vk/bCuTRFj9sHasYFtzBPnP8c9sLQfBUMl+1ThkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tArJA8Nw5smm1+B6X/NHbbaZ7IR/xGk3+bjTolEt1fQ0eSQjy9wKyloG8AVQV1+Et7mCU2CI9NUzR3aIt8H60hXKGraN2sGHAKyG1AA2k+tmWbWsX517VHfifZ/S3Cm5jFEqG3mAMAfO/82+ukz1ErWHmx9gCBSITVjCdy003UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3H1ktej; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742199828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC5lK1FxM1eWQXOh9AroE9tnp2td4VImfPnxc4mu+rg=;
	b=T3H1ktejRD0Vh4sK7aDZUzpjaMS6nV/QZlHsgMGOhKwzEOcZyEmPPXxLsqEWE0kvvJNao1
	GQjq2qyskoAOvH0vUjUQdkF6YA/l7stQRNnnNv9H1Ucs+EBRVN4tNaYlBz5nZELtZiDJ61
	VGj5psdB1Ws2uXfqA6vvTstPhiMrijU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-WCQgMQznMPiHVYmsc8V2-Q-1; Mon, 17 Mar 2025 04:23:46 -0400
X-MC-Unique: WCQgMQznMPiHVYmsc8V2-Q-1
X-Mimecast-MFC-AGG-ID: WCQgMQznMPiHVYmsc8V2-Q_1742199825
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so10475785e9.3
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 01:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742199825; x=1742804625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rC5lK1FxM1eWQXOh9AroE9tnp2td4VImfPnxc4mu+rg=;
        b=N//lpulsaYs/c9eW5MVyRrqSZC36HfPhQLyzedKCC+mRT5be4YPIpqYcB9FDIPyWlZ
         7izuZs1lHVWrX+ViaISMD94c8k2Jzyp+7s9ZeiPzXRAnWTjU/T7iZ7SYcMCf792PSAC9
         QC84DcGh+rVu8QUys+KSKVY0er38dy6DJ38J2d4ewRWZ2t5ats+mOObKxodIR6h/BglJ
         dJ+20x7xSeX/wG1odpedb5KRPYG7kJhQIuBTIWM65a2/JSEoxeKInaApZoBF7Kofo+ED
         CzUKH98Mo4EyHrO/xIDaIuRVhNXVPRMW94mm2w1ZPysA/Aiy4bsSINrPPlufhhv0wxTS
         w+KA==
X-Gm-Message-State: AOJu0Yx8CLAFUpQ0GtjEtV4p7EQ5nNlgYws/TWsdYtt+qgztHtQd8HUl
	lVpFg5r4rPPre/r7lrH+sJNP84ItYmolsvFYpvsy68qWd/9S/NrcKNNpz06lixjjkl5UFnUmVSf
	0wKGdzHm/do/3DdO+PznXKIk7oDdMLhv3yvPed3325Y02n0b3UuNL/A==
X-Gm-Gg: ASbGncsgVxRrbEj0iF5FdaEoyNIGO4eLygMeGSAbakH0RtuvHDRDl6tNuMcLRHZ2EPh
	cvxAp8UCxT55uQV/iHtkV9BoCJFOnPIoYPW2ie7FrlyDS+lzeChQ4jispQxRomaBpkOdLBMHEpl
	zaaa88tyjaCnCMvEq6vnby3qZ7vhZi18nxdM77O66sbAi33Kp36eMFjxYFGrRLFrT91ijdG3Ona
	VRJe2TFhhU3Aa77jEdOluabpjMlyzB0P+2kBIndgemj3oBJr3GGxN5lXb0x38PNNy1qBEZA64o+
	4lmwy7SSJfLPbxSZWLNH19AwbOPZsnEBLdl2AuvTokeVmg==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr109892895e9.28.1742199825095;
        Mon, 17 Mar 2025 01:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvXGGv6tXY3ajGLLrOXr011xmJAYRLTHi8JZasNx5okT9lH6f9KisDDn8lGridr/hz5ZTMqg==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr109892625e9.28.1742199824734;
        Mon, 17 Mar 2025 01:23:44 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010de59sm96734785e9.33.2025.03.17.01.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:23:44 -0700 (PDT)
Message-ID: <981a871f-e0c0-4741-8e7e-4a4e5d93541d@redhat.com>
Date: Mon, 17 Mar 2025 09:23:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] selftest/bpf: Add test for AF_VSOCK connect()
 racing sockmap update
To: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co>
 <20250316-vsock-trans-signal-race-v3-2-17a6862277c9@rbox.co>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250316-vsock-trans-signal-race-v3-2-17a6862277c9@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 11:45 PM, Michal Luczaj wrote:
> Racing signal-interrupted connect() and sockmap update may result in an
> unconnected (and missing vsock transport) socket in a sockmap.
> 
> Test spends 2 seconds attempting to reach WARN_ON_ONCE().
> 
> connect
>   / state = SS_CONNECTED /
>                                 sock_map_update_elem
>   if signal_pending
>     state = SS_UNCONNECTED
> 
> connect
>   transport = NULL
>                                 vsock_bpf_recvmsg
>                                   WARN_ON_ONCE(!vsk->transport)
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

This is apparently causing some bpf self-test failure. (Timeout? the
self-test failure output is not clear to me.)

Could you please have a look?

Thanks!

Paolo


