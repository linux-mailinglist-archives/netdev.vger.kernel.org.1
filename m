Return-Path: <netdev+bounces-229941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE9BE248D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A16C544DDD
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229372C3244;
	Thu, 16 Oct 2025 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNUMwv3z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C162253B5C
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605353; cv=none; b=a58Nz5dfK2aJkEs0D7YK+twSBH9uSia0px0Rv2zLyBCc3yt9xNuKl+/c6iaiNnx1Wa3oLmkWSKDeRFCqEmXfHvr43rn3lbRF4OnPZ56NToMFIbG0cL4qO5e9tty1k2OywlPqQHdzDoxk2N31cDkPpkJwcdFx8UhAX87GKLq9KQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605353; c=relaxed/simple;
	bh=+AtvyGqwUgALdVZc2SXcYDz/237PjQqovYd5Z7PxSbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RBIy2ReXZGMxhHoNXuKqy8IydaL39qJGhPWWEhE6nUO3RxVRn79qlR60p46gtEdiJ6v7VOXyFtgCuVLVH+MzPo2KfXlGOnQLVJ8qYW9doN903/gowEWgxDX29fX/ZyIQS2kYdRkYehYTYupDr6+MEFwvlCW7pKqQUu+4QkX0ItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNUMwv3z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760605350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GQfxStX9qdjnF8aD6SOVhJPa/g/zUO8yOqhMVk2ON4=;
	b=aNUMwv3zp4/Vi9b6p02yAGuucYNzZt5nohfETo/eSAtJZi41sYpZkKyvmXXWlbEEUWvJDF
	EOFhhdgtuVujtKMft8Ut72fBuhcNTHHzBsG4VWXlTlm/UCxZentH04KxxOUhX2l1E9PD0E
	Cr8SYgalPQRgIhgfisUmq3OH/sArDE0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-K1bbVEIePM2WrnOnExPRtw-1; Thu, 16 Oct 2025 05:02:29 -0400
X-MC-Unique: K1bbVEIePM2WrnOnExPRtw-1
X-Mimecast-MFC-AGG-ID: K1bbVEIePM2WrnOnExPRtw_1760605348
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471001b980eso2921555e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 02:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605348; x=1761210148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GQfxStX9qdjnF8aD6SOVhJPa/g/zUO8yOqhMVk2ON4=;
        b=lIgzOCwY9sTB84F+BSdxwcgH+7WhwdjmTHUudTCdctR799vBY2mcKqC0xCezZNVVg6
         4Dhxu1yn+BcrulHz1lAoBufBjRW0MPpl7MH42ln1iUENAcGdZBsmwpZwwjlvGirUWTQt
         ZIJB4lwn6vcbaZ3J6DNz0iCi5IUyeQl3dUscpn0+lRmQKRp+igoe99DbD5anRRcsktWY
         PAN8Msc0Egc58s9X3L5xQ4efAT+TZ0gFyS/5kk/B629tf9TL8bBq0e972/CA4n9gI3Tg
         n8mjg38MxirG2Z2wNFRn2ClvRv5ywzdzCvwqC3QObYFOjut51ZdnAbV2AFAtpzki7zd0
         zivA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Daj5SzMv4IMD1U2++/m19zEmJRQsDPfVvUZv+yj+1hF5FnqZDTBAxDtnqapyvkwe3mkE49E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvQOkAAHVoNjO328XUCcsspkPaEPMg5LbY3FHBT+NJhNEQaku
	Hyure6uBlQ1xy68w4hgD4185thuG+hFJdGP08ScZXZr8sz6q3tCXbuyEsN/UWSDUXjX+tXsWWfL
	r1zPShqwycgd4j1XpTAi/LnRxZCknvISjTPmw9oHBbWUHpRSotwOH02gHZg==
X-Gm-Gg: ASbGncu1QL9Po2YwV6oJ03kN+tVE45FIv4PVIkzv49A/xNWqkC3WfDP0b5ePyO+SzF9
	a9kVwGnl2LS5V3v1Pfc/E/auyn7gBNT73LXeJB3+8f06EiazqBNx/LYGvoNqJvFdyvOSiE1mCRR
	3qEFfA7Rf0fjK8QXwZiLQjAus1SiwPwK3UJmL2QOWrljsLMKagRZe5J32p0T+vsSgV7pLJwK8tW
	pfpKT2ODv1UFV3PV5K6xsw5bGiSlDScdLtcy9n1b9EdrpgR9D9BgaM5eVRG/a/Qea0fCb3UEYe3
	7PwSiTHlqqOyrMjAdducwVGbMWHor2ObgdUKrxyyOnk3Ji81Dcmv3gKUfZnN0TRSRbYZwltQKLf
	qaJfYjElp4adFxrKDJrTw5P2qvo7hwmXOABCuQ+UN4EX69nU=
X-Received: by 2002:a05:600c:3b08:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-46fa9af364bmr194084385e9.23.1760605348013;
        Thu, 16 Oct 2025 02:02:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBKaKCixlap2LGsrCQoy/ztjbrbjTMc5FWNVc5/WkapPDjvhhGgdyb9Tum59RrTjzgqDuQQw==
X-Received: by 2002:a05:600c:3b08:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-46fa9af364bmr194083915e9.23.1760605347524;
        Thu, 16 Oct 2025 02:02:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444e3fesm14977005e9.15.2025.10.16.02.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 02:02:26 -0700 (PDT)
Message-ID: <4042d1da-a7aa-46c4-87c5-736d74d280a2@redhat.com>
Date: Thu, 16 Oct 2025 11:02:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 05/13] tcp: accecn: handle unexpected AccECN
 negotiation feedback
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013170331.63539-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
> has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) = (1,1,1)
> then receives a SYN/ACK with the currently reserved combination
> (AE,CWR,ECE) = (1,0,1) but it does not have logic specific to such a
> combination, the Client MUST enable AccECN mode as if the SYN/ACK
> confirmed that the Server supported AccECN and as if it fed back that
> the IP-ECN field on the SYN had arrived unchanged.
> 
> This patch fix an incorrect AccECN negoation of commit 3cae34274c79
> ("tcp: accecn: AccECN negotiation").

Minor nit: with my previous feedback I asked a formal fixes tag here.

Yes, we can have fixes tag on net-next.

No need to re-submit just for this.

/P


