Return-Path: <netdev+bounces-180170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E548A7FD92
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F282416DBBA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041126A0B3;
	Tue,  8 Apr 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVrGzplw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F926A0A6
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109836; cv=none; b=dIk0f7gQudOnOzMh2XihrJ85hJwEL5lc7+yRdVOfHjy9UtgZ7DRhnymabNFRojx91vuOYjeUFvoxWdqzGUxZ25+0jXumMtmbZs4os0618SIONxvqSmHafwVn2ZhnI39yEkKxLAxjmJjYCUj0K+WTgFRqFrRLxRz7glrBYgLyRJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109836; c=relaxed/simple;
	bh=o93kT3HUr6PSKVXUdV14Bgz9/0yB1U6VVEQHCXqgg2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4ZuunB7Es0QpR21cuEDTvsxOUceENoF6SyKrc/QltlRfmoiLvftLU6IEVEvp4bOo0BXdyeRn8CoiERcgb43kiZs9vLjWhEwA5t0dxqKJuQeEgC8NZz8JLyUC1SzFvUtl1kv+rq9zb/mCW3a8MxZ2fghYWQkK8iiZXcpxn7EWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVrGzplw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744109833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WiB8QLkLLCMptXLpQ+Fs8eV4CmtpBvO8mQtuoLcCE5Q=;
	b=PVrGzplwvnQhUU5vbiWq1Gft93ial6P4TdhYZAt/2CrIszeRSG2Vs+pF7IY/wGKW9Qk7r1
	4b5B+skN9wPD8xa9R+sQ2x/ba+ZSVkxEVHVL1azImMYmc1dKE3jXukJNgfN+INtnhAxs9r
	QDLTriK3qNUjk6awUzDWaQwZIqbe13Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-d6l6WB3cMYW7gsKptLVdRg-1; Tue, 08 Apr 2025 06:57:10 -0400
X-MC-Unique: d6l6WB3cMYW7gsKptLVdRg-1
X-Mimecast-MFC-AGG-ID: d6l6WB3cMYW7gsKptLVdRg_1744109829
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394c489babso26830105e9.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 03:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744109829; x=1744714629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiB8QLkLLCMptXLpQ+Fs8eV4CmtpBvO8mQtuoLcCE5Q=;
        b=b4GNCIbbJ2ohaD94klEbIx1QRB4WGtVzW89Virze4/kuz4pVfcf8MJr6+7RRUY7tKk
         cDpjtVYlu0g62DRbkSO1og6l3J8LqUoxAowcRAqLscDKVRjGPkevW4xhNw06MEHkZz5f
         9CfwM5oHz92urfO9zXIz2e32axTew5iBUfsizON/Mskr9P+PGFPZLrzROTczxfdLtgcR
         +tpQ3OHT5nK+AQe/CeqFnbpICUNGIGX8zEulLky3Y1ul8W2zjXuixILHqBNh3DLlUsYu
         Tx2CIK57DS3b7NBPrt9VzaPQ+eu7lhp39qLRJy85YlWZkk7xgG8H56kyvsIm5H4eM2Sw
         KOXw==
X-Forwarded-Encrypted: i=1; AJvYcCWaZHp05JpXCvXGzuXcoD4X7QARLUb0sC08ZH6eqdx1YZVJ1iJku2jHR6dUGCRBDC8zUuKAf5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZqxgxr/VNcuOb2Bd/kVKn2iwMdxxtA1lK+pW+B0NzGblHTSY
	dg7VqsuTW+/p7Gs959SbnJ67nQv6xOZobcNT4py0O06f+XqsdlzH1tma+YTaBBY3WZDXRr7pJ6+
	8XKEtwHNy7JLrl5jtU+o6xzCOcv92a0Cwb1DgiF0oDLA45+hp4sabNA==
X-Gm-Gg: ASbGncsTj7CG1ihorEBxcDTK40Eq2SpH9votgLCZM4pGmVfrmNG/VjLx7En2CgJLLTX
	lfN6hfRBqMRrXa/cd+T3b18gu6SpBRn+x2NkpoW16N/OqR0wvA1qy8W11xDS+98FUmarw2YBL9B
	sxCs7vzOULxkfEaqcesmwqsQWH543hPFToLDEq9M32t4ng31x+5xnH3prvykC64MR1BZmQ72AJ1
	yEAHFx7AXhjSONDOpsrxya08eAK7ZMMSz3KlliIPrrazqvtD6EcQvcKyeQdxz/zWHFMxfdG+DRh
	tfxTTPomPOj9iCVXZz7yjv4wQkty9eBrDM35PuOIGCY=
X-Received: by 2002:a05:600c:3b94:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-43f0ab8c6d2mr41519755e9.13.1744109829436;
        Tue, 08 Apr 2025 03:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHucF/g2LzNPlKjjAwHyVa6MKKp0vRxRscl5LXt0EXHIloC4uTn5GNaY61HCGJgRWXZ/jCvhA==
X-Received: by 2002:a05:600c:3b94:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-43f0ab8c6d2mr41519505e9.13.1744109829064;
        Tue, 08 Apr 2025 03:57:09 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b6321sm14290396f8f.44.2025.04.08.03.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 03:57:08 -0700 (PDT)
Message-ID: <c4b1219d-a42d-4339-93aa-89987cc6ad2f@redhat.com>
Date: Tue, 8 Apr 2025 12:57:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: mptcp: add comment for getaddrinfo
To: zhenwei pi <pizhenwei@bytedance.com>, Geliang Tang <geliang@kernel.org>,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Cc: matttbe@kernel.org, martineau@kernel.org, viktor.soderqvist@est.tech,
 zhenwei pi <zhenwei.pi@linux.dev>
References: <20250407085122.1203489-1-pizhenwei@bytedance.com>
 <ae367fb7158e2f1c284a4acaea86f96a7a95b0c4.camel@kernel.org>
 <0de20ab7-9f1c-4a13-a8d2-295f94161c4e@bytedance.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0de20ab7-9f1c-4a13-a8d2-295f94161c4e@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/8/25 5:09 AM, zhenwei pi wrote:
> On 4/8/25 09:43, Geliang Tang wrote:
>> On Mon, 2025-04-07 at 16:51 +0800, zhenwei pi wrote:
>>> mptcp_connect.c is a startup tutorial of MPTCP programming, however
>>> there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
>>> getaddrinfo MPTCP support.
>>>
>>> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
>>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>>> ---
>>>   tools/testing/selftests/net/mptcp/mptcp_connect.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> index c83a8b47bbdf..6b9031273964 100644
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>>> @@ -179,6 +179,18 @@ static void xgetnameinfo(const struct sockaddr
>>> *addr, socklen_t addrlen,
>>>   	}
>>>   }
>>>   
>>> +/* There is a lack of MPTCP support from glibc, these code leads
>>> error:
>>> + *	struct addrinfo hints = {
>>> + *		.ai_protocol = IPPROTO_MPTCP,
>>> + *		...
>>> + *	};
>>> + *	err = getaddrinfo(node, service, &hints, res);
>>> + *	...
>>> + * So using IPPROTO_TCP to resolve, and use TCP/MPTCP to create
>>> socket.
>>> + *
>>> + * glibc starts to support MPTCP since v2.42.
>>> + * Link:
>>> https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82
>>
>> Thanks for adding getaddrinfo mptcp support to glibc. I think we should
>> not only add a comment for getaddrinfo mptcp here, but also add an
>> example of using it in mptcp_connect.c. I will work with you to
>> implement this example in v2.

While at that, please also clean-up the tag area: only a single SoB is
required. If you submit using a different mail address WRT the SoB tag,
you should add a 'From: ' header. See
Documentation/process/submitting-patches.rst for the details.

Thanks,

Paolo


