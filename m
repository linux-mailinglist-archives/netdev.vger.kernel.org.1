Return-Path: <netdev+bounces-236301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C43DC3AAD5
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD8418936E3
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9B1313E38;
	Thu,  6 Nov 2025 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUaY63x1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QykzFlY0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47730CDA4
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429676; cv=none; b=mm2ezvtL+Jehjs5w2wzjQVbOQhN1bGjTlkMOF0Tk43e23Vn6TOi6zNKWy/iTJNil6vcxqjUel9w8r6vLtQOrfn5n//BgiD9kiPXXT2igQW2fduQM87ZVvz4/5CKQInvAXuJY/kJgOLpSiOl16DZsnqGbx4wWq+yzAiuDMGT7eN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429676; c=relaxed/simple;
	bh=D0ESafiFnrAHx1xAZJLjIGxN45DgsIeRyNfJcnFl56Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fJF1auzsVRsA9m3B9ZW0BWTklkoy7203TwecwUS/7f+XkJQ9ix/vNqRmj9AEB4jcAsC1MN7gRn05h76M5nEhmRgg6lKkmENhihUheFkWJM1UGtd6AEEWUE0TphPxV+CzpMMWDm+Oz7DsUchnzFg8wnAuYVwspUmYS5sVlEZNYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUaY63x1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QykzFlY0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762429674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JviuZOYT5VOJubSBo7kcaUm1NAOOfzcTxwXg/1vMe4=;
	b=UUaY63x1cO40/wbCYMQ3MnWBd+yJ9BQtSze8PMeRUOQht3AwVqCdMW3ks+YqsBq+jWkkFi
	KE/m9umDapcOvE7SqvDtTqvMaMG4I2Up9rFSBFitVJVxB19K88+mttfKDLocGJeJbllB/h
	o3kVEcJmW1iYpK0HigSVjVauCPRqfS0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-5EWsAsVVMDiUo_j7Hzw6Kw-1; Thu, 06 Nov 2025 06:47:52 -0500
X-MC-Unique: 5EWsAsVVMDiUo_j7Hzw6Kw-1
X-Mimecast-MFC-AGG-ID: 5EWsAsVVMDiUo_j7Hzw6Kw_1762429672
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c5f1e9faso674599f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762429672; x=1763034472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JviuZOYT5VOJubSBo7kcaUm1NAOOfzcTxwXg/1vMe4=;
        b=QykzFlY0LZCuy3V4UnKJjHEt87nA2uZY8ivl9Bs6bCXUVr0Wtjg/AW8OF41QPjaUY5
         SxQpQm+u7NDV7tYxnmmBBbs9y/ofVzOskLTsMHAIupmjBmEVQslSYEY2m8uDkDrxw05t
         0UwORE/od097juxNbnNi0yt/TBKQvwr2bykKtxT7z3RFaSRvdHtoPvX8j9zDM2DzUvKx
         1v+duEob9eLRj1cHep5PESbsYVFgvD0Wp1RquD+IgNorrZg/En6uH/zqHs7UB5Ta/JRX
         JuWG3OVfMRaeQioyzF8GBxYUlbJT7z8+y4mnaI/EpFa9bs8U4KiQS3TrUTP96l2DVX79
         HX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429672; x=1763034472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JviuZOYT5VOJubSBo7kcaUm1NAOOfzcTxwXg/1vMe4=;
        b=jxvsq/L111DWCjUC+Q1d266Ji5cVIA1hbqv5ekL001VhRtXvWVCzTWB4fjeSfY2uM3
         gl0nZUtXyM+L/bTRL/r6MtUzkGAQiHK7Wyj/Ea0jHdAZz6KpOwxzTSmU9G5Bvg8Vt3x9
         v88TPMVsaOY2/+gP51Kw8cDcAcxqnTLeJ0CQCu6X1RBt3U8z8X9A9fE1IvzXPQYEMb7Y
         Ywl7fTamt+YAMFFIe8FICWhfSjaQ16rYYZsuSq5XLOw+DVfiwG6b01Kl4Fzs1JA4WOTV
         f6mcIBPtLlC7WlHFxzUDDBHIp5t7WYHQKVpCl7B2zMDffaSzK7hLxrjrAvHmHCGWklmo
         yoxw==
X-Forwarded-Encrypted: i=1; AJvYcCUgMrT0o1AYUxnkfI5vIeTAZ4GB2/wZAe654N6MBMSJCQY0LI6lo3hlqalPd1w9CVxDSdamf5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRlVxyht2O2JJVhIw6dJASMuCgSuCHx8SgaY5mxgjiOQ6pkmn2
	P7nE8XeSqUYngMlImLzuvFKMiKItvwgZko6k4VUOc/YYc5SoZfOWIX7n+UO6f91ZAorPCRM1pSJ
	ff47QOtsQ82XBVQBWDL6mfg+ohYOJoYQltjgCj0rBwlmuIZBO+cIGJVPWFw==
X-Gm-Gg: ASbGncuhDCASDpT73UB2KpeJuHgKScJfa7yFw9ehR/BqK9WHSV8SPqUFDPRD5A6LoK+
	yeuJkuGD/I+I4YCNq3j4GMp+DhSl9wLt4bzo7Cv0jvrGuB4wZs8hGaTkgMuFs3E3j0ux1EQgj2R
	8XyZynsLGxToFpLfq19th4v66hLimyIs6YRxMod0mGCKqzNo7+Yq0MswRGCFqNx4lnHK9lUSYrG
	hcvQbkbiio+dFNeHwIZdHltFbhdOb2fvgmQkbW7iwT8uWqgi56mO6FgFImtCHpUo3D2FebZ3Ec2
	karIPagH+5DNSEfOd8i+kXWDAcgUgbey9kVNIFDB4aBWQvEf/skunr3PNc898sCCU7C6y8xqzn0
	qog==
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr6850995f8f.58.1762429671738;
        Thu, 06 Nov 2025 03:47:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyM0CqjbrXAtnYkiBBxwxzEmqQL7alB7xzeOenRekpIf1Zfq6usduu0337jFWK1+wDdZonKw==
X-Received: by 2002:a5d:584a:0:b0:429:d0f0:6dd1 with SMTP id ffacd0b85a97d-429e33396cemr6850974f8f.58.1762429671254;
        Thu, 06 Nov 2025 03:47:51 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49c2fdsm4632849f8f.39.2025.11.06.03.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:47:50 -0800 (PST)
Message-ID: <981dbc10-0833-418e-b389-93e0daee8acf@redhat.com>
Date: Thu, 6 Nov 2025 12:47:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 08/14] tcp: accecn: retransmit downgraded SYN
 in AccECN negotiation
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-9-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-9-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Based on AccECN spec (RFC9768), if the sender of an AccECN SYN
> (the TCP Client) times out before receiving the SYN/ACK, it SHOULD
> attempt to negotiate the use of AccECN at least one more time by
> continuing to set all three TCP ECN flags (AE,CWR,ECE) = (1,1,1) on
> the first retransmitted SYN (using the usual retransmission time-outs).
> 
> If this first retransmission also fails to be acknowledged, in
> deployment scenarios where AccECN path traversal might be problematic,
> the TCP Client SHOULD send subsequent retransmissions of the SYN with
> the three TCP-ECN flags cleared (AE,CWR,ECE) = (0,0,0).
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


