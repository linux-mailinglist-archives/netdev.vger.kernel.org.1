Return-Path: <netdev+bounces-232066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE05DC008C1
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63178359574
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB2D3074AA;
	Thu, 23 Oct 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoIEKFsf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4A26B75B
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216193; cv=none; b=awubmukDresZZgbpY51VN5BFPZTw+PCmKzGRT8i7/g0aRLOJerkZ8kytGobu98At1PkeiSnh3Ot9pgTcof2xCNdgZ44HQjvn42u7OLIiZOBVz/F7Smy232RWjDCKhguTEx+yKZF/+iENpNxj/4njd8nlLcE7+rRCSj40hkyH4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216193; c=relaxed/simple;
	bh=PSq4rzHsTZYmnPW7B8CFsP6cGQe5nHJwDQGMbKTQhlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfvDfRrn4Hp3Ze51t/3si78qvtFi91Z5kO8WFGU3ZWqXZG2E/XO3p5/v6rfL/rPy/TPDdQ44GloQcVwrUr/IwKzPV+vtjKRXpSeGlo3mb4kSleQC4poXCbm3I6Q3KndQb+bXXMfI3yjJU/uf6784vaAv9ErmWMVq4sp3atfYcYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoIEKFsf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761216191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2itfR4P5vWlnhxtQmgFjh+n2XUI3sGLIeHL7uzBaLr4=;
	b=OoIEKFsfd+wa7B+3LKuT7Q0VDVLEau24H/nFiTTaihE2RSoFazJwaS6triRv7xv7Oc/TZO
	U2daQW1JguY6pXSTfmXJ5DOkurcHrTfb9rkLxPECpIsd9fJIwJwstMKeFx59SDbQH//3Fp
	kvHWhVLZ/AcWrTw4kt+sln/4kutVJgk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-uj9YtKNiOHKckV_AnrPzVA-1; Thu, 23 Oct 2025 06:43:09 -0400
X-MC-Unique: uj9YtKNiOHKckV_AnrPzVA-1
X-Mimecast-MFC-AGG-ID: uj9YtKNiOHKckV_AnrPzVA_1761216189
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42700099ff5so419287f8f.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 03:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216188; x=1761820988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2itfR4P5vWlnhxtQmgFjh+n2XUI3sGLIeHL7uzBaLr4=;
        b=WtTqqgYcaVuAaEZxo0BSXrZSBymMZ+0ZkMzHMlj2ulHfXDYanD8DSBrovnxTJuLEMo
         RFw76wJn6M5bZjT5EyZ7mYHxl/UCqd7ZXCBECn/hsgQD7F2rkWE040zPt0Q+Jbphv9hJ
         L7oV46AD3QfMDbRMWgG2LekMWigvbukObgkvgaYBl5d8lLYi14KhrJA0bSCVpH8ckNNW
         VOBwk4vj6Ul1F4K16kG49EN9e+EQAwL12KmvwDuqmh1RCkM+A+WhuuZwRK0CZwcYqocw
         Ixs5IbymdeA5GKIJxinIqoWi4fF+ma68vlhpgo5Qzs4ouamfBMbQwLi6RRI+sEtHJ8Bn
         GJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8xGH1Qoe9AxTQXhwSaAy7gQQY4r8jt4fxqr2VNG+ezZwCekcAmnJ480Sh8/TD/I63n4TaAWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+SsfrbsvZ/qxaj3aaBst+RVjIO/0xjnvOpzv6rIr08uwMdmt
	806j617RK10CBPVPwJ2/Ld41WWvlap8u3TKYNuu/gJ49b31wZ92zH/+5/ovSoZBapin6w9HJGQH
	98+TR9AChun2lQftZOUQZAHnkOR3l8cmzEQvQB27n4Mx9TYT+Q9LQYlAX8A==
X-Gm-Gg: ASbGncsrZLYgyTGfEzhfMD/gP9K5pS1x+Eq2MJYYRrXV1i0+SqRbBM/wX5vrdLIvxX7
	f06fcReKTMt4wGLRMydC6maDGS0YM55CQjHemlxSnrvA5eRiVC3UOCuniD7Uz+awinfjK1du+kJ
	zSnAwlOhyjZYzUzCmrHlKECA47G7dwRzqbMGxTPU46/h4j9MmHNkEvOnj8J3a0gPVVMDLlRCG0b
	yQZPZVHxTEChdbDTIUHS6iHYu2dl3AXv0akuOElN//a2h+lPFOynhnUPWNwImsju53H/U7SZWLI
	3nnZPPoSOzLf0TramC9BeYvaCsR1OganZ9qCvAJj33E5/dtRL+K83mVS1Xnxf/4qpTuegVPNEFJ
	kzvHbffb0YkW13FInOpMpf9Kwrnoatx1zyd09LXOiBFytDSY=
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47117925171mr243744015e9.34.1761216188620;
        Thu, 23 Oct 2025 03:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeZ82VrSnvpK1c3qyzIXLRxmMNdmjxKL2P/cuqpRB9ovXOV8FGWqUSGpOdh0UCletrBUBh+w==
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47117925171mr243743745e9.34.1761216188204;
        Thu, 23 Oct 2025 03:43:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae92067sm31140865e9.4.2025.10.23.03.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:43:07 -0700 (PDT)
Message-ID: <268ee657-903a-4271-9e17-fcf1dc79b92c@redhat.com>
Date: Thu, 23 Oct 2025 12:43:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-1-kees@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020212639.1223484-1-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:26 PM, Kees Cook wrote:
> Add flexible sockaddr structure to support addresses longer than the
> traditional 14-byte struct sockaddr::sa_data limitation without
> requiring the full 128-byte sa_data of struct sockaddr_storage. This
> allows the network APIs to pass around a pointer to an object that
> isn't lying to the compiler about how big it is, but must be accompanied
> by its actual size as an additional parameter.
> 
> It's possible we may way to migrate to including the size with the
> struct in the future, e.g.:
> 
> struct sockaddr_unspec {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };

Side note: sockaddr_unspec is possibly not the optimal name, as
AF_UNSPEC has a specific meaning/semantic.

Name-wise, I think 'sockaddr_sized' would be better, but I agree with
David the struct may cause unaligned access problems.

/P


