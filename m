Return-Path: <netdev+bounces-189997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D76AB4D58
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4E13B107E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BA11E5B94;
	Tue, 13 May 2025 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KT19qt8M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4E17578
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122721; cv=none; b=HkYlHqX+bpstGcOocX4NUkKYR41wA62egQT3RTQNCFHpT5unBNxul1Ernue52Q/0QaAvlUxBpYgwE5jpac60tkxPmcM1lK7Ch8SH2Kn2IJDs9pUHzqQgjzSrsvsJcaIx/JzESiXEjU2wq3QPC1/zbCtd5aUcxvnWIMO20Twu8Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122721; c=relaxed/simple;
	bh=dw3FVy+H762QqDQsfacm0G0fKYchZgBVutw0hAyGS9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbZWA7I6Kq1lKm4Jzzlto9l31xVc1Cf1kI+ZcqRxuvjJg/Lu5s68jZ9fF9Rr2U79JznmTDjVxR19UqkAbF2nqtRg194zKcs7OoRMArgSdrVZannJQF1t7bzqPlDswERVlmTPFi7xMzx79Wx6HBQBLuYNFkUYzSurvGlWOogP+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KT19qt8M; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad243b49ef1so506542266b.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747122717; x=1747727517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1TX1iutNKhXIHzfeoAKnwSGb48GGyl8Gt7n1ZLZwuO8=;
        b=KT19qt8MtUsZtDnCjew0+6aywl9WcjaoRmiWXhsm3+sVQUhO+KbPBIUUAYhPDLBmsP
         12SbJokoIevsn1bIoKwmnfsCFpARFuMcxfmcu+oBlVSE8nwOiDc7GqgASvB6Z8YsYwGN
         okmkB1PXCxvJxrOeLiwrtifzNlQowjrVyZ3fpLIaZJ2LGJkc8BPnzTew+G8ivGGP1PL+
         iL3eR42DqekwXfz9JMYxCIXbuDo9U5GVSTMiA+IX3yrXzNsUWTmSUPhCe/m5nGtY6SbS
         3LmL+KbgHa60hrSeqYhXa8dYhdj2gn90rUvkey45SK7R4k5coQCh5o8//PIc4WtHDz1X
         7i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122717; x=1747727517;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TX1iutNKhXIHzfeoAKnwSGb48GGyl8Gt7n1ZLZwuO8=;
        b=YKDW2HjMvNMJysL6Wi5k7G+Yfc5WxFkDoQMOR23uQumliYl6TSHK7URCotLD8gGoYJ
         gG38a7vSId1n4F/Fgh5IDx+dZI1gYrBIJ8s2xCiyl2HqGIfmSMTqNYnwgWCBeD3rgBA8
         GQ7Pm+kF1mfGJkRqW+5fw0QvX4OeOao96j1KL1zWi/+eBMbv7LbxuV73Y7PwMQMXS5oH
         u0AKL83fTO7Sk1Ul0Fv6w9croSFYfM8p1ImJaBQSVw76vynTww8cX18kJdC8D4dP7Dii
         gK8Ojcy+1fuwSAecP4+sbA+Yf97cbQkDvXK+0KhduGWIwHZRREEKukRZkBraf12SmESH
         TKBg==
X-Forwarded-Encrypted: i=1; AJvYcCUSD+/XOf2Uj8BVRo99a21hRkBsn7g7nzpr96GWqeWWdiwXWX0ea73KdMuoAebsIPj61HtNKUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylBfoGzp7EZMwquLGVrst0u6zjFiaC0FpGuax+B3e3oltA8k+t
	a4kQRkh0GayYdp3/TFcPrINmXWJG6i9GvNBpa1YnrEkliDQbZ85nEK5aL5VBFWf4utxk5DtT5gb
	xqq+bCLkr+prX6NADXQ1KXDBrKr3G7vpdjB/p9j+IpSUytcY=
X-Gm-Gg: ASbGncvkB/Pc+yuwhODTtFJ0WPGnq9bkcRAB0er11nLjt9kpaa3iMFGmUq37FWv/ZFU
	6diawDQyAylfhiydYJcX/NS+P//GHeAP67y4A+QjAA5XPxqwFoi8DvpkWPglY1kqAr7OgXCWTo5
	2Q4I86/i6cjLfTiLJaiS8uig2HFHCF9pvxWn/6rtM2BMivhfeJLu6vmZr5OeVJbJx83q91ckcm8
	WKPvuFxTb9GtkvkhCVX4XSBviuVsgqBW0ufg+PEDrh1ufwmldTczHZaMzI8saO7LQ+3+3bUSeAt
	Ex3EYVGCRzAPLsU1mb3r5dprI8iVJ3yLzfmZg7RBMdGegk+BuVxMBlF5qpePeFIC/E0dRFhVZT9
	Ej3aaTAgpu9QjeA==
X-Google-Smtp-Source: AGHT+IHc+hhHW2iEohZqRA0QrpSyuiQQzccXFgWZ8Yf8qDE9AHyJ/5p84AEvdeTVe/tppDDOtUwOSw==
X-Received: by 2002:a17:906:6a22:b0:ad1:8d47:f5a1 with SMTP id a640c23a62f3a-ad2187d9ff9mr1431407966b.0.1747122716800;
        Tue, 13 May 2025 00:51:56 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:29cc:1144:33c3:cb9c? ([2001:67c:2fbc:1:29cc:1144:33c3:cb9c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21934d4d0sm736193266b.73.2025.05.13.00.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 00:51:56 -0700 (PDT)
Message-ID: <effc10de-e7a9-4721-84ee-caafcf9aedb8@openvpn.net>
Date: Tue, 13 May 2025 09:51:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] ovpn: set skb->ignore_df = 1 before
 sending IPv6 packets out
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Gert Doering <gert@greenie.muc.de>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-4-antonio@openvpn.net>
 <fc07f58e-488e-490e-a33f-50f09163a0fb@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <fc07f58e-488e-490e-a33f-50f09163a0fb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2025 09:37, Paolo Abeni wrote:
> On 5/9/25 4:26 PM, Antonio Quartulli wrote:
>> IPv6 user packets (sent over the tunnel) may be larger than
>> the outgoing interface MTU after encapsulation.
>> When this happens ovpn should allow the kernel to fragment
>> them because they are "locally generated".
>>
>> To achieve the above, we must set skb->ignore_df = 1
>> so that ip6_fragment() can be made aware of this decision.
> 
> Why the above applies only to IPv6? AFAICS the same could happen even
> for IPv4.

For IPv4 we have the 'df=0' param that is passed to 
udp_tunnel_xmit_skb(), which basically leads to the same result.

Originally (in some old version of the original ovpn submission) I had 
skb->ignore_df=1 in the common path, but then it was removed when 
Sabrina highlighted the df param.

However, we overlooked that there is no such param/logic for IPv6, hence 
we need the explicit ignore_df=1 for IPv6.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


