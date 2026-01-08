Return-Path: <netdev+bounces-248059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EB7D04345
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B644303134B
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3799497B13;
	Thu,  8 Jan 2026 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeCBiu6K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0EB5tUq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190D4984B6
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873912; cv=none; b=GdPLjLS+bIei7jNtsrU5P07I90egQQb6/mA8ET9bqk5dU/NA9M5tWLdve+E1wz5Dm3CFt2cZXuqcJ76lcPzqPw2u3kVg85uL0eEjb0JVlY5V6mHCeYAnlxBYR2aRhGxQSJaaBfBriJgSu6PuX3bpG0SNecBwx4vDwlVPq+seFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873912; c=relaxed/simple;
	bh=Flh5gm/FG6f2h7+d4LlYOxc+wsoA1WupGU+z5tvQXn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OSG2w5gyAMYXfrU0nTb+tPUpuuIilWuHkSfc0UamW0NojHmRGhlv3vLcsYphAZqwi2K4gINSaFg+GMcqtvN0eok52rN5XIURVQGRyGnb65w+TEagJbwpOHJDkdqFaOk9UHWo2gRxa5/8VJe6w6k0Y0HOXfHHG8zg0YBW3DX/1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeCBiu6K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0EB5tUq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767873907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Flh5gm/FG6f2h7+d4LlYOxc+wsoA1WupGU+z5tvQXn4=;
	b=TeCBiu6KuT+jvEFoO6KnAOfRwVFn3oXgMIIf2STTuffzattE39Dkj4kXepVd8hTPwS5ADJ
	mOWviDjRMNaAOEoAKhoCefY4Z5y0vMDwSmefLCLdMgmjR+4fI0iEBXCv8lPuM/io//DVUZ
	NpoT+gHv/g3iCnPzIqVCXiBWb3y+Kyc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-9z-tl263O5GTqtDy2AW7GA-1; Thu, 08 Jan 2026 07:05:05 -0500
X-MC-Unique: 9z-tl263O5GTqtDy2AW7GA-1
X-Mimecast-MFC-AGG-ID: 9z-tl263O5GTqtDy2AW7GA_1767873904
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d3c4468d8so21227515e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 04:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767873904; x=1768478704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Flh5gm/FG6f2h7+d4LlYOxc+wsoA1WupGU+z5tvQXn4=;
        b=P0EB5tUq4gEPbQC8HFtAZIwPhtjivVywhg5mmDspsKEbQaSC/gQpJyyKK5wFGyWw2L
         07vwoad/3AOiZ2lVzMvR1pO1Neja3nunwK4QhIrY5bACcofo+d9Eyxn2fmH8i0rHhtr2
         +gN9vbo0QEtstBCtwY0IhqDmtogQGYds4puZcBDlzJKio7HOz6i6sZkjbKiuZb2cCn+L
         IVqVsjsrelFzg4txGT8ePwrN3yjM12kkjuzGqDrAyuvN15oRPreHd1yctO+wzW9dZk2k
         pF3behY8G/tY4QmNO+DLPOvJMkczbM3RChQmEVECJPx63iSzS1diTlQOkRMT4uhlOCJw
         M2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767873904; x=1768478704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Flh5gm/FG6f2h7+d4LlYOxc+wsoA1WupGU+z5tvQXn4=;
        b=aTHjm8BnQCXeNQRkW080O9cZ5nZkIqK6+5MXvvSi1tELvrq9emB+pDiEGvta6qh84A
         8yRwS1rWjEbjw3QKASH7CDg8U42CTE0TyxWxhY6TBZLLGV0F4wDeoBVT194OUGtewmqF
         dDrK/FJ2yehMYrTTteKfpm5VpCEqqfqWClZhRFx80/NVVw9DhTp4lUDxv0/8RFSuFjNd
         fWAqp3axQRoYh5PuNw+vxlsiAsInDyBY2/MAmL/+XiFoOZcZRjXjAvHsJdKz0iGsVn60
         w7fYFXDRQZbpFv8QccU192OrcZbU7uHWkBX/L9tV9SMKktoDyM/lyOrj0PUxNY+QnVvZ
         IzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMPCggzQCc3OLwBvhzASCV43PlUHy5qxWzBXDJT99Po19O+LfGhF1x0Ljh5hnaQe7TFJht4EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZt4RpQbLsJYWTv3Yc4EqOWPWf3h7H85ubkrrd2zGewHXWZyTl
	H7HjOifWHWtLQCVUPn7mMHEETzNsWKcOPOifltvrwq0p3HDVO3GHd+AAOKFXn/Rl7S/BJmvwCCj
	645VCBgEk5QR6WVSRADfVQjhAtNQWQL8nucFq17rcmSZCc5rTMX1ZgiIzFA==
X-Gm-Gg: AY/fxX7S2FevbD0Q8l1fLaLQvqH0I8rAtZon2Evg6B5ckCIKGN9/uHD/n4egDDU+eyI
	6Nfmy20Obfk8NOBP+9s/uP5Wj4H24s4GL79FGu3HrDgNLOd1uPY6kRqhLMCcZIQEYOjhZrmVhna
	ketHMK/7f1Ylmj8eBs02qdrqTfPl3BSdW7a7qEnyO4xk04tFXKG5RRaA+smgKXqUPco8N3QwMr1
	Bt0JZezO1cx4LfnfawIrk4g+Fgf5D/twS/mpp9ZBrJAQ2VIOKmJdaVJ38hJDTUlMshJg4dCs1jN
	BmRKJxe5H19f8/DlCXwMdehsdYkkFZpxq2HXuxKc4Ie1dHDACCkpVQFYnv32oGLkVpwfFB54vBI
	nHh6affmNNBtGtA==
X-Received: by 2002:a05:600c:4447:b0:477:3e0b:c0e3 with SMTP id 5b1f17b1804b1-47d84b3b8b9mr66671975e9.32.1767873903891;
        Thu, 08 Jan 2026 04:05:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyd3EobR8+CtqNLr1SJNq4aJtqIFnG4hdPC4+x+J4mPj7mFR2jjmxPx+hGX2qRU6Jn66CAIQ==
X-Received: by 2002:a05:600c:4447:b0:477:3e0b:c0e3 with SMTP id 5b1f17b1804b1-47d84b3b8b9mr66671435e9.32.1767873903307;
        Thu, 08 Jan 2026 04:05:03 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8662ffaasm36179535e9.6.2026.01.08.04.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 04:05:02 -0800 (PST)
Message-ID: <9d64dd7e-273b-4627-ba0c-a3c8aab2dcb1@redhat.com>
Date: Thu, 8 Jan 2026 13:05:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling series
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
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
 <56f6f3dd-14a8-44e9-a13d-eeb0a27d81d2@redhat.com>
 <PAXPR07MB798456B62DBAC92A9F5915DAA385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB798456B62DBAC92A9F5915DAA385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/26 9:47 AM, Chia-Yu Chang (Nokia) wrote:
> Regarding the packetdrill cases for AccECN, shall I can include in this patch series (v8) or is it suggested to submit them in a standalone series?

IMHO can be in a separate series, mainly because this one is already
quite big.

/P


