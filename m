Return-Path: <netdev+bounces-219415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB00B412A8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 04:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A57F3ADC85
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A21258CE9;
	Wed,  3 Sep 2025 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw/RlPXD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDEA22DF86
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868328; cv=none; b=e6qkWdySPcaRjyRITWWDlb9DZ15k8iQtKB4CdFuRFHDtYnDIfx/VnXIj7Zqb+VGW9ok3VIYRXdV1q61Qm+lVaxZciIbGAVyNYe4mKd42iSHtAd7a5qnwJd2axRtXB9rlQMOoEB503pAWnNBL2tNFbUOvt9F66DCVDnVLL3woeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868328; c=relaxed/simple;
	bh=VGcNUXm4BCj06x05BkioascIbUe0RH0WdZ4ZXtFoTWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBwbv4UsEl3vmURe/uWKlW2bNc6R8KD5Db6dmwEMm8e/Jc4ydNKLwGVyd68js8KfMHTdqw+uM2+Y8SCFmbWMyFtw7y7z7HPtCCw/MMZm/NhUIS1UsLMpWD3DrdC0R1CrKnaf3s8Skg9hZq7VHFB11Puu5TuECV7b1pCQl5Z54QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw/RlPXD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-722e079fa1aso4768556d6.3
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 19:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756868326; x=1757473126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqQvrNMu5W6VqEiquX50hZ/GbZBKYNXJ/sI3yX6P9Cc=;
        b=bw/RlPXDnbXzIu9jrkHnbb+3GfW7dESErtkZw5SUAVXMew20iiPLFPw92qeZcRK8Jp
         pNZVxnSM5dkcJ6aK+uAkKSDgkDP0+0Utk6dl1N7QQDxyS0af8N/WrLjyLvmivjW9Q5Qk
         b/nay3C3/Zj9kzRUwP8G6E6R6JlK/+EW9wtYQLUkDroKO5uf5CjLGDU1ZFbwvH+rC5xo
         5Achj9bnWsppN6Cx9WSZ3s9i30gGWYpIWT4y6k8ZBq6PYywO2fqbp0l4EG2dq/1FtaNI
         jrdNP3Jv5+YEp38n5hlbc8xCN3rrZ6UB7364XKG2PWT0NoxcgK+kjCfFf/yXmpmR/dnI
         EQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756868326; x=1757473126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqQvrNMu5W6VqEiquX50hZ/GbZBKYNXJ/sI3yX6P9Cc=;
        b=GQ/vVq0sBQx6o7SoyuqpZDOiYffLDjLamyPWxIPouzNRYFChmB4PZnju9cFujjtx3W
         PM+449rg59kFyMejcKBWpzotWjh5KyfApQE7sQwEwJxCH7c9LVPhrfdV8uq1AMtAzu0u
         9rjVh2claRBGMKagQVbExY8XRxV9WOCtHXZAZy5YXrn4vfjRpcirfq1CTXHOBqDcy+8E
         ousQKkX0ZJg0dLMKIUc0kOdEenWl3ntbjvpPPCI8HUqsFas8NgGCMEsQo7YCsY68SXOb
         7jdpMwFRS8Vqeim2iy/yTZuXpjRn9O7aZnvYGkUzKvuUOH6kYd5FVMiyK6bEvhIQUfKk
         wxWg==
X-Forwarded-Encrypted: i=1; AJvYcCX7ma2b5N1rq5+cPePX2Zyqm42jekMXN+vp3/vA54HkC8nr3OWoCRbSFZIAbjRHI59uHma6bEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDFsF5nspSvQ2iDZjSOO+DHyxQnLZkTy3dmZ/q88Bn2cfJzsTt
	VBBWlKHJz8jJBHI4rKHZ+wYOC9xkFbBkwU9JldgY69SH6U8mOQq5vHRf
X-Gm-Gg: ASbGnctvem5oBgmJvo2SSIBTWHWzSJhh4ZISKk5D6i1DL+vCdQIpf5dP2hcIyzLfogI
	9LE6lOm+BsxpWROtHZbbxRGEKz6L6FsVMlqIdlHIaV/MOBEkJMtktJE9p/IBpKUE0yEVYxw01+h
	AtyYr4mSBk3dzV1YyMmCgXgHHcvNjrS8UpiIhc1TC6JoKkEMejEDw7JlV9ZMkFPEdw3Q/1SFh2G
	fIb3BtnEtz8jLOIrkGFbz3qNmTJnokNHQUGdyWcPr47cI+EPmlWW3bBJcWa+4VPQFMCcHV8aSmi
	oETuLYesqgedUPunldVg8P+goF0k1AK6ZntPbZZqm56jsDhLlFHwrm0jXxFZU8dXodwEtfOEAek
	1b8oIPPfaFCeo3qyC+qFiWuWvs7pSaaIu2wS2
X-Google-Smtp-Source: AGHT+IEIP/HfR4YnNv8ROXYf63GxplutrgeFYf/elDBTp1n4/Q5Faj9ckD4kR4B4uZMLjPb1z9EYsg==
X-Received: by 2002:a05:6214:176b:b0:721:a9d7:297a with SMTP id 6a1803df08f44-721a9d72b9emr41289756d6.7.1756868326007;
        Tue, 02 Sep 2025 19:58:46 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11c1::11a5? ([2620:10d:c091:400::5:693b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b682faa7sm22399256d6.66.2025.09.02.19.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 19:58:45 -0700 (PDT)
Message-ID: <a30deb61-92e9-445e-a3c0-5ba9dab52b72@gmail.com>
Date: Tue, 2 Sep 2025 22:58:44 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 08/19] net: psp: add socket security
 association code
To: Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
 <20250828162953.2707727-9-daniel.zahka@gmail.com>
 <c282cd8e-96c5-41ab-a97b-945cc33141ac@redhat.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <c282cd8e-96c5-41ab-a97b-945cc33141ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/25 6:43 AM, Paolo Abeni wrote:
> On 8/28/25 6:29 PM, Daniel Zahka wrote:
>> +int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
>> +				struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	struct socket *socket;
>> +	struct psp_dev *psd;
>> +	struct nlattr *id;
>> +	int fd, err;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_ASSOC_SOCK_FD))
>> +		return -EINVAL;
>> +
>> +	fd = nla_get_u32(info->attrs[PSP_A_ASSOC_SOCK_FD]);
>> +	socket = sockfd_lookup(fd, &err);
>> +	if (!socket)
>> +		return err;
>> +
>> +	if (!sk_is_tcp(socket->sk)) {
>> +		NL_SET_ERR_MSG_ATTR(info->extack,
>> +				    info->attrs[PSP_A_ASSOC_SOCK_FD],
>> +				    "Unsupported socket family and type");
>> +		err = -EOPNOTSUPP;
>> +		goto err_sock_put;
>> +	}
> It's not clear to me if a family check is required here. AFAICS the RX
> path is contrained to IPv6 only, as per spec, but the TX (NIC) allows
> even IPv4.
>
> What happens if the psp assoc is bound to an IPv4 socket? What if in
> case of ADDRFORM?

PSP transport mode with IPv4 as the l3 header is permitted by the spec. 
You are right that the series only really supports IPv6 as it is now, 
given how psp_dev_rcv() and psp_dev_encapsulate() are implemented. I 
will update both of these functions to support IPv4 in the next version.

I am a fairly ignorant to how IPV6_ADDRFORM works. Will this still be an 
issue if IPv4 is fully supported, or do we need to disallow this sockopt 
on psp sockets?

