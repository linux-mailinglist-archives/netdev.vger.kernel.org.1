Return-Path: <netdev+bounces-142142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 419DB9BDA4B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0FAB23319
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7439110E3;
	Wed,  6 Nov 2024 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OP8ey3sN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ADDCA5B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852879; cv=none; b=kebOY+ETcTHrQVSYIG3GaNxpoPeDxS6/XXk6LWz0idASjXuco5XUaoSkApeFsip95foZUiJTunUX73GD/21U46Gi+fGv587CPUGIHfo2g7x8YCxiS9BNVrLjbitN3tbVYI8r3e+i0hSCMmmef3+yVDurQDsS4HuQXvB3VLvY0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852879; c=relaxed/simple;
	bh=b6uK7llb5e36CA4wEXAAc0AxUMUzILjII6G0DIJYf6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoR2TELugxbHDCuWl9Nub3LKXrGHMANeewfkPWS7E5M9q/8f8FV+MFkfWTF4jsUUIF2HTbVp1rgs5aNJwXpWAiv1lx1SozipBGx/kKveaC2AH2FqaXlm/P893fWVW3DgOV3wUdoMSE15yDp4fnz0yJkNNkqBrwWYbxgqjPWcMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OP8ey3sN; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d36f7cf765so27932466d6.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 16:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730852875; x=1731457675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPWQa+FTKYMBuDDcOKjxAgUcKitW+kesNp1QCv0e5R0=;
        b=OP8ey3sNOnsjyUzu0634OhEBwtsA1Mijx1spL7BwL0urvph0Rn4KZ/and2vDjFyWBU
         SMLBswJMXGEmpAPdeIElcKW9z50V4g3fmc+2I/u2mWbwtGl6uncw9TXig0p/BOyTSJpl
         5msLR3zjAb5c4WrfjnIBoXIyAtLHLsSdgStDTNwH7FS79UnjAOJeso4729LLF9PbTiiS
         MBkQY4i0GT+BHF102+DDgRqc3Y2RvlPi9L5cO2e6zMdXRU7Rib7dlJHlo2+ceNZu/E9Y
         iTpwDIePfuMgXvBwMPWdgnsWNYz4Im0pcUbkAdqMW/BNj3LN774RN1/GMXDzsuQipocf
         Xl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730852875; x=1731457675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPWQa+FTKYMBuDDcOKjxAgUcKitW+kesNp1QCv0e5R0=;
        b=cATllDPZLjIQoBkLI6yufXdtsuT7x3kaxPDVQ10I87syIE3eiFITsrIqfJTmkCfWy5
         c6bNJxed+F/8NV/MBt8mrEtCwfTxXS//Hd2Po5QhiFjWoGaeJJTBUuwL+ew3uwnGjx01
         56a58XbOdXT0hBg4qnPgSq2PzGYWs5FoKmuCzdlci4SKybnRxQ98om4k0YEyn6f7+oku
         EInS0YbuIclsKrmHYOAZVQnGwFJUzHeonmaIIaILUn3z40klOSgNXtGktVs4eMDzMfGl
         fnOjKq+LjFImTGEp9I5QR0UEGMfA4hY0Ye/2xS+rGpswUBf6c7ZLECHtvyAPGpuNUySn
         UeMg==
X-Forwarded-Encrypted: i=1; AJvYcCUbnJ9WMfrGryexcPgHjyd3fjQJnZ7vHi8EBLSp5X65spM4m5yNnmIGI4szJFpzZwf9/pQjt2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLx4am5LUBAxL4xJaHO1CWCtCiuZNPnWlHXS6yTYw5smY9J3o
	2mg09NA7tjBI/ZUszmIcpFQg9ucUjBoRZIwL/lMI8a65CRpyKH4sw2VGsSreU18=
X-Google-Smtp-Source: AGHT+IHkF61LIO7nneCgEwYCw4dCRD6xpNeXLJfFmTXxxf96FpcaIJmiMVnEV6PRFIp8IFBPbaPz/w==
X-Received: by 2002:a05:6214:3bc5:b0:6ce:26d0:c7b4 with SMTP id 6a1803df08f44-6d35c19bf44mr260048106d6.44.1730852875016;
        Tue, 05 Nov 2024 16:27:55 -0800 (PST)
Received: from ?IPV6:2601:647:4200:9750:314c:a1fc:f04f:2b34? ([2601:647:4200:9750:314c:a1fc:f04f:2b34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b2e3sm66002826d6.81.2024.11.05.16.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 16:27:54 -0800 (PST)
Message-ID: <de982cf0-45f5-46bc-91a7-e0f1d7745686@bytedance.com>
Date: Tue, 5 Nov 2024 16:27:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2 bpf] bpf: Add sk_is_inet and IS_ICSK
 check in tls_sw_has_ctx_tx/rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 stfomichev@gmail.com, netdev@vger.kernel.org
References: <20241030161855.149784-1-zijianzhang@bytedance.com>
 <20241103121546.4b9558aa@kernel.org>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <20241103121546.4b9558aa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/24 12:15 PM, Jakub Kicinski wrote:
> On Wed, 30 Oct 2024 16:18:55 +0000 zijianzhang@bytedance.com wrote:
>> As the introduction of the support for vsock and unix sockets in sockmap,
>> tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be IS_ICSK.
>> vsock and af_unix sockets have vsock_sock and unix_sock instead of
>> inet_connection_sock. For these sockets, tls_get_ctx may return an invalid
>> pointer and cause page fault in function tls_sw_ctx_rx.
> 
> Since it's touching TLS code:
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> 
> I wonder if we should move these helpers to skmsg or such, since only
> bpf uses them.
> 

Agree, skmsg.h seems a better place for these two helpers.

