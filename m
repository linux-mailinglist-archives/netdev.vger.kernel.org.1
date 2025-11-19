Return-Path: <netdev+bounces-239926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF15C6E0AF
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A15C73869CE
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3034D90C;
	Wed, 19 Nov 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJtshzyH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDWdNlvm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C4C34321B
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549015; cv=none; b=aJGeaDRqNnE7Tc9Z1fDvDVaMZ1N9L41uwRT0is/r6EiJLaodJVWV7TC7fjW8i4du6AVa5zCGpUwiJY01M/DIM8yjv7LtcOS8m26AB1N+45lDCcN/xwTn6tOZ5S6baI0rrqdoQVCspCQy2bqvsh9E20OZeaHLJxWrU/dTync26ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549015; c=relaxed/simple;
	bh=ls8bqSOh5paIrQgIWm7KUHizx2alUb9qbX99d7lJac0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Ple2Odl8aRXyaqkTLMSlayUWRltdQRCw25l8+pPwdifo7z0nheVqOjZzfYibXCuW3PgHrdJ2UnBN17er1CcWusg1jFDYW9SyGf7VoGFITgkvtFDGRYMHLoe42uor8aRNdZ6E4yl5I8haBdaOk9coCNXe+Zf4MUdLm+gbjuPRE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJtshzyH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDWdNlvm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763549012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZS3DJl+rfsKCgk3N3Is+kJs1Pfw50XKBZca3nELkm98=;
	b=jJtshzyHlvYV2u7iuNHsFVIgkUSKspgrv4R7eAFKsd/ZJ19hJHYqoxoPNXD3PwSJO7bWGT
	2wxA7rbHHx7uYCULBz05E8Zg/WgMdh2j8lybwSRElJzshPzgGcB5N/XSO3fMEVv58hS5ii
	yOZkltNURFgUbcOhCmKnAMUep3WadW4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-LrrskK9GOFCImoDKxZxmlQ-1; Wed, 19 Nov 2025 05:43:31 -0500
X-MC-Unique: LrrskK9GOFCImoDKxZxmlQ-1
X-Mimecast-MFC-AGG-ID: LrrskK9GOFCImoDKxZxmlQ_1763549010
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so19200615e9.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763549010; x=1764153810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZS3DJl+rfsKCgk3N3Is+kJs1Pfw50XKBZca3nELkm98=;
        b=MDWdNlvmNcMCm6tkIH8gZ1l9VyeGCELkkCc2LcZeimoUE+EnfG5psKehsmCdxTYX2W
         u6ZIhESbsLBatUE8ZKRF1JI7Zz+HIYEr5+20ekO1pP+Sh+xCZEKrL/lOE4JjBY3ixBNO
         Y4bZuwzB2jKaHdkecrD+U+w4OjmeIwPe6Z7pRJBjHJVJXRtFsbcRixwRnQDkQPlM0C7o
         938zFN41HVChgML+i498njELwKPrgDsdQHPWIYBUFEJhkQ90LeHG2+xnQW5oqR4uuKlI
         s0wwysd3DFboZMQ465CZcv5wlXmeIKCArYwHX8Pshoht5Hz3BHQGOxx5n2unajCGoejc
         8y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763549010; x=1764153810;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS3DJl+rfsKCgk3N3Is+kJs1Pfw50XKBZca3nELkm98=;
        b=UeJUuDlEHmKFVbNIunkKoVcaT2jGT3Ojmzpop5fPZSG7hF7LL43QskFW5TxO2x02Kp
         72FSdWQj0A9cbmWQ+4AUGL8jIjKReqZREz0/qgJlDsYqChDMth7kTA5wGnGWnSJ5NSNF
         V7hL1GhJMijGhhsRXAjx6/VUKPspq/VO6AzqT/5i4Vzy4K2vtDYe2y2TKqaE8V++sCUi
         PON+lTK6a941h94iARUlCQdV7EFKahW+IO52u4rDt69DV431To+XlXV2l65GkpvxnU1k
         b3n4M4h2Cq6HQNnym8ZpX4qUQTSFslltxFnEM4H34VyGUd123zoKQzSxkCNQFKkdZh/j
         Exyg==
X-Forwarded-Encrypted: i=1; AJvYcCXtusNFnDqls5P5c27mk0o/b/iD4WyB52ZN2AzMwCL4uhl4i072MQpHwhhAjK0QaFVlI4vCFqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPqeusxVtLke1zndZzlnUjYidJqBA+if9diLTWD8IdAFTDDwB
	gONrNneJZLiMhkBXSifiZH3H8HXhLT+AVa6ntrNTUghredUZ+Cy6PHjoFc3H5NpFKGIT04lW1NO
	kbgF69dTNwyrg4ccQ7qjq9vV7cGNBD1m84OSuPc9vZTlQexLyH2lU4BUyMQ==
X-Gm-Gg: ASbGnctg5yq2FVmM20Chd4wZrp5Z/uG+e/08gcCSwBYioDYMZ097EvPxUC2LTJUYR8w
	sRKnwyMIS0HQ2+L7r8rKJ/3RKmmluzN+EwnvmMkN3VXTi+TpimzN1xndo+4xCSEHQffHrKbgt/p
	y8AKwC5/wLnqWodynKLnMkitN+IA/h84RA8gcv6/kfLrrISc2orZeU7R+gem7tZmUQBdBTH/m+X
	/MuQvkvax7U+VvX1sZtZJjoMUnSbYJc9izJOYiYiDuTLmlEpxG9eVmXUjmLs7nwvtLpr9LcBP+/
	6box2yh/CUrGOg99u3i0plIvB3VPKirmNDKcb/6q1GpZQCBWbPXTBejxSgWclJbCeis2Bf2SUHF
	0j8PcyG1pnGxt
X-Received: by 2002:a05:600c:c4b8:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-477b198b88bmr18033285e9.10.1763549009792;
        Wed, 19 Nov 2025 02:43:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9VgMfr9TLL8O8BdB9euFkQ+122gpF3n9fR5oFdXmPTT7jiqyq2kRGJT8397RGEwGwHWuazw==
X-Received: by 2002:a05:600c:c4b8:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-477b198b88bmr18032805e9.10.1763549009317;
        Wed, 19 Nov 2025 02:43:29 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1041defsm39874685e9.15.2025.11.19.02.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 02:43:28 -0800 (PST)
Message-ID: <da8a7137-dba2-46be-b528-6806b11204db@redhat.com>
Date: Wed, 19 Nov 2025 11:43:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
From: Paolo Abeni <pabeni@redhat.com>
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
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
 <d87782d4-567d-4753-8435-fd52cd5b88da@redhat.com>
 <PAXPR07MB79842DF3D2028BB3366F0AF6A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <6d4aad6e-ebe0-4c52-a8a4-9ed38ca50774@redhat.com>
Content-Language: en-US
In-Reply-To: <6d4aad6e-ebe0-4c52-a8a4-9ed38ca50774@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 11:40 AM, Paolo Abeni wrote:
> On 11/19/25 11:24 AM, Chia-Yu Chang (Nokia) wrote:
>> I was thinking to totally remove ECN from Rx path, 
> 
> ??? do you mean you intend to remove the existing virtio_net ECN
> support? I guess/hope I misread the above.
> 
> Note that removing features from virtio_net is an extreme pain at best,
> and more probably simply impossible - see the UFO removal history.
> 
> Please clarify, thanks!

Note that my comment on this patch is focusing only on clarity: you are
updating a comment for such goal: the new comment need to be clear and
consistent. The proposed text was not; a better/more consistent one will
be ok for me.

Thanks,

Paolo


