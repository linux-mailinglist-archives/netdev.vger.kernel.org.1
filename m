Return-Path: <netdev+bounces-238027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2259EC531CD
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 16:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E205E54398F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FDB33F39C;
	Wed, 12 Nov 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeireNWg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuJAD5LN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA7B33F388
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959061; cv=none; b=pkeOO6WnfXaQWdLc31DKgHm+hQ59mEG7vb2Ae99xVvBX4amq3PrKOv66j+IGyxEV5jZHwYWLqoD/BNv3cBGoCd26o1/2uYgSJ/TlDzmPYDRTve9OKCMR0oxv/tpfG5Wwt/3ZgEs1lQUm8OPJKE4z9195mTvHQZ8iGQHgzzYRffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959061; c=relaxed/simple;
	bh=zMRRdX2owS8FdV/BiqPTU+IIEcG54+CqIM+8HoD1Ms0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVRye/WGy9xbsY3c3vfb8ieujJWf9fDw8X9XgkwlTuzxQL/Z99/9lcQiYvDfbbrMOby3vIVbBLzwa6wRge5JBhRv7oX1Kx3Gf5M9+DHbDSo8Mgwe3+k54Ji/lsQgnEvDqKHl/S5G97RrhNGLVR2s7RL1U+xk7dWby/UKpkQ1CGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeireNWg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VuJAD5LN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762959058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ/SnVy0i2WVmKdjO+8lXLUclnaJKnVKKCK+Fx4B9So=;
	b=EeireNWgogRNwrjOkd3FMlT0WjKZ2fmKTtlsRRetqWuPQ2NZwuKC53P/bZaLL6XMysU3gJ
	JOSkPlBJUE8y4j3ab8FjPKKtKC9OoX85mMQajWsdjBtWVnih3rRO1byDx50y53oVd+Cs6c
	C8JqPZSKwAu/IOt4VoBv1oD4xiGObK8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-fcL3GPnFMpKGI_11NhKnqw-1; Wed, 12 Nov 2025 09:50:55 -0500
X-MC-Unique: fcL3GPnFMpKGI_11NhKnqw-1
X-Mimecast-MFC-AGG-ID: fcL3GPnFMpKGI_11NhKnqw_1762959055
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c5da68e5so547892f8f.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 06:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762959054; x=1763563854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJ/SnVy0i2WVmKdjO+8lXLUclnaJKnVKKCK+Fx4B9So=;
        b=VuJAD5LNRfTxWTKfLAa7aDsbHtoC/EchRMf+Q/NPebSfR5nnxJWsqZTxN2jGWKgpnm
         ONxKy7Qeb/NPfR//2ycVJjkI2qZEWFdOdiPqwvCm50n4bF3F149AyzI/bMKLawetjqpa
         KknIgVswgVn1Uu7G28tjQ/mXI0QqVRrzFhXk2HKvCdxPVS3+OfBZIb3GkZ0bgD9bicyv
         TgK/QoZvK2WPp6UHYnph8NCyrkEmpp4tgex/1YzhReW1fmFG/ZwcavXQ+kLyYTOaAPj4
         ULqTCdsbnN6OEQ4tOgoteTzRnTcFxJZZYjGc2TW20UHBsZDX/jPDuWvTYrDIzd1F9Ua2
         w6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959054; x=1763563854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJ/SnVy0i2WVmKdjO+8lXLUclnaJKnVKKCK+Fx4B9So=;
        b=C/O4W7iTSmMxLsk1XoOOka2yH0xQ0MhFPeJYLPr/Ah3DMguR8JAcnQIPu22LLTt5+0
         CqOo6l0QKDULmJ6B24ah8e3q4tSEFcP0OoecKi6XkAfkgj5jzvqEfwihS8UqiLC9Pt+D
         rO6rF6K+DL4A04+ErfewIEXasB1Ha7Yrocokpy8mqJK487i68o5Udu+0N29kfn4GSAYr
         al1XJW7VpCKLU1vsWq/AgEW4vosUd8BncQYxydRBlW/MiM+gZM9w077oA5cCo8erwKqv
         +nkWiIHHphcFbz1xwknX9QUxW4ojTPwgAcB7BgivuWgzthByTvTqSPrPuGMiD8uqkQCN
         8cPA==
X-Forwarded-Encrypted: i=1; AJvYcCV5vOiDdtwATZVLaOZKMAUi/ENhI4pqDGuYC+vBLZBIStfdeQsIxaJGpXMNdt5qrKZblKW84Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSh90P0hffPzL/gxmta92C+65IzdkNXo46gl6wdr0RVpj3zXld
	7RVSMgne7+7D4vns4tw2k3lxK7VbDFe0XPqbkv1FICK/Hq3bITvalqxxkkOY/QXJY5EeTr/KCs7
	T0Xa1t7TrxFBkJeppZ/6tl7sLBUwIq2QrZt2qJGvW78+BI8mOwg4ExzIQhw==
X-Gm-Gg: ASbGncuu3eDea6oNka4m8yNKfkOSUwq3ffkfp9d+hHsO6hHFTahKHGK2ycjLo1dC3YT
	4rdIIS3dJ58JiWFWfYJWu8hcc9vvu5xz/y5e2ZQnauP6ENSrzs9ACYYH5r6cUUOt+ulAoSQFT2b
	2QNm7MYGOCh/ZgOTj1GV1BN7YDIH91EoIbZ8bgCm0INqTHJY9hs9abx9SKBuyA/MKLWR8lkM8hM
	29xls9EObV1oIYDoPnk3zrAPeZcjC6HwzFLKTnOrmst+RvbgZCDnNiAZN5pcDWtkOLdgxJd9gfv
	3xAxzk1gOmeOkBsiwTGau2TDjU4GC1MpLaHVKzfPa1GvjLXWhGWl2b0fmWP6pFWnjM4U0P83NkP
	76A==
X-Received: by 2002:a05:6000:2891:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-42b4ba75470mr3031645f8f.18.1762959054600;
        Wed, 12 Nov 2025 06:50:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERB5IOiGOtuJUGWUEr7UkS6m3ACPJ8/nI92NfUrVDc35tes2Rnj+8LlolGWnYHhDlrIMnvBQ==
X-Received: by 2002:a05:6000:2891:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-42b4ba75470mr3031587f8f.18.1762959054156;
        Wed, 12 Nov 2025 06:50:54 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33392697f8f.35.2025.11.12.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:50:53 -0800 (PST)
Message-ID: <0944325d-158d-45a4-a1d4-d61e645b07ea@redhat.com>
Date: Wed, 12 Nov 2025 15:50:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 05/14] tcp: L4S ECT(1) identifier and
 NEEDS_ACCECN for CC modules
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "parav@nvidia.com" <parav@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 cheshire <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
 "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
 Vidhi Goel <vidhi_goel@apple.com>
Cc: "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-6-chia-yu.chang@nokia-bell-labs.com>
 <bc1ebcd0-c42c-4b59-a37a-13ee214e90a6@redhat.com>
 <PAXPR07MB7984498C0F152D504B2AEC98A3CFA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984498C0F152D504B2AEC98A3CFA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 12:02 PM, Chia-Yu Chang (Nokia) wrote:
> This bit will be set by congestion control (TCP Prague, which will be submitted after AccECN patch series).
> 
> It is intended to use ECT-1 rather than ECT-0, and we were thinking this flag can be irrespective to AccECN negotiation.
> 
> Shall I put in the Prague patch series?

Yes, please!

/P


