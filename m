Return-Path: <netdev+bounces-213789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69013B26A4A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0CDAA2A07
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77127205ABA;
	Thu, 14 Aug 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw5i2eLp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0041F8AC8
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183026; cv=none; b=Ubw1hHC3APJb4xKD5TJh1//npnJGWuzPim8+bXa/KfD19yMikPl7bTloPzVR3WJciJMU1jGUbd4Uyy3mjSnkJ9S8rzpV/oprNowRqS2UyXvTCCGL4JvwzXyyHT7af7avuWQQgiuQFYsoSeX8XiYI8CG9ZZgCklyOEaogmKeEE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183026; c=relaxed/simple;
	bh=eVQgdWittB1A1eRdvrgYGjzFM/V7ftpJLsC2BFnyyTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrCdsYbvt1BwGu1UL+kQbw8HEG+gMiV++L/ptlozldWPvIYlT3kAo/HovvvA+L8BaeNjBTQFsvysgGo/AHug1j6eT12e/JvmreqxWNcPJW0tuZWGRav3e0IqXZjgjEf8l9JeLUl6npUweYsH/bjmPhY4xbZ6fkbo+oAQULzjbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uw5i2eLp; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109bcceb9so10346311cf.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 07:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755183024; x=1755787824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEPflc75uW9weWnSJOxL+wqyI+gsL7Ya3HCYLtQBm2M=;
        b=Uw5i2eLpAdnL1ahYKaayq5joL3kPVCvBMYYGA8Wh2wGqgweKllXBZVJJEkvftIGBCU
         ObSUhcpXzDEr6USCKd8eD13gp1RTGxt9ZRrJ6POujguFz2x9hev81wDpHleUAQuLwUnf
         EuTAzIPvxV0i6nQmcmt4Zp87pSKxgF1jwywXHtSVTJ+u2ez/waDK8f7QI6jwDZ78qr1C
         TKQyWtfkAiZLdCTiIviEeFwHopyTO1NpTr3TH441s8OrMYBRDCwyMEnoYiQDsBYzqZT8
         JJncIhpWru5VVLaGXX245H20MybfaqZzXLP4VG78TZ++B4Et75NznUe0VTwA5bMqd210
         nDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183024; x=1755787824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEPflc75uW9weWnSJOxL+wqyI+gsL7Ya3HCYLtQBm2M=;
        b=X0LqBQOAKgZe0q0hJDC8Lho8eqhYG1GcThywGUlm/6G4l8x3fyC4MhEWLUnwMSKrvh
         3BRYT09Sz7aj2qfuOC2jFuv2TkndpLqMeexRgA5SB0jLCpDFtX1kvd2zuiZa8mseq+J2
         h4MT2jUzi+plJEs3WMmR5wUVylLe32AZxFkrUctcqU2f+vFSjVLLxmHs/VJ5nktENrlQ
         eP3O6BkK/EEBvAdVPk09zTPn5ChLwRKzLAGLLrSC+6saGQ9kfWKENh66EENTnJ4iQ+VH
         3CDVM+AJjoULBprTmmmIKu1Q/vk1KlPYuqWBf5wcneTpY62R5xEecP6YkyWd11IVy4+Z
         fchw==
X-Forwarded-Encrypted: i=1; AJvYcCWHWJ8xAiyBhMefBXY4abF0AMF/oeD52xqFrHRe1w3NOmF8gsI690fDQgelhu86kjHnmUUyhBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQ63/iTCEra0UFB3I5Lu3v9xUoZnjOiqEnRhO7exCu+ZB7lj8
	Z8qmJRRSFJNrLRk+CwqC9vTByal1lDbMbKm3DNmLS7oISpUtM7egvKqF
X-Gm-Gg: ASbGncuEa3zH5H/T4lh/BqqCvhd/L8U/yw1Xa1My3hwlEoctr+l9FOUcaZBi4dEwsa9
	m6PVXmmbDQ5h8rzSHaYVof+4aFxY8vgDrZz3Mi3EWx2l9J23ZjxZaR8+2+zlV2QoAnR64rXdPJF
	KrpMVXwC7Mm3P88O//A52cu9sOvnuBTCQB2kMvGwfGhIKxX2/oilpmqXbRTk7hqwxebuFd4CL3E
	/F88X+NrwXKYsUGy2dLOp89dunR3eUtSLoD7aHBdukwX32SOrMQdMEKV22tq7EQITdXqARI4ixg
	X7eg1ws0RKm5cCrRC3KB0tcvZ1EyAv8efFTw/hE1oy5S9cr2sMlvtuMYqHVBJBsWkwV/mpmlHS3
	NQ1zDP/LDK84vi1cOTzwWKnshgQ1mUWAbqRzH1nv5T2hoJOU8hO8t51tkjhPjcatjTxBJu8G64b
	1x
X-Google-Smtp-Source: AGHT+IFRgsrLloXlVJhDbtD5vBQiv1HIZsinKsr1dLeyeKpzbfv/re44ywiAuviqkQV+7Tt9aEn5qA==
X-Received: by 2002:ac8:7c56:0:b0:4b0:6a0d:bbdc with SMTP id d75a77b69052e-4b10aabcb1amr37173851cf.15.1755183023553;
        Thu, 14 Aug 2025 07:50:23 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b067e71186sm162116021cf.17.2025.08.14.07.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:50:22 -0700 (PDT)
Message-ID: <d78db534-b472-47c4-829d-83384b537ea2@gmail.com>
Date: Thu, 14 Aug 2025 10:50:21 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 09/19] net: psp: update the TCP MSS to reflect
 PSP packet overhead
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
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-10-daniel.zahka@gmail.com>
 <a6635ce0-a27f-4a3b-845a-7c25f8b58452@redhat.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <a6635ce0-a27f-4a3b-845a-7c25f8b58452@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/14/25 9:58 AM, Paolo Abeni wrote:
> On 8/12/25 2:29 AM, Daniel Zahka wrote:
>> @@ -236,6 +237,10 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
>>   	tcp_write_collapse_fence(sk);
>>   	pas->upgrade_seq = tcp_sk(sk)->rcv_nxt;
>>   
>> +	icsk = inet_csk(sk);
>> +	icsk->icsk_ext_hdr_len += psp_sk_overhead(sk);
> I'm likely lost, but AFAICS the user-space can successfully call
> multiple times psp_sock_assoc_set_tx() on the same socket, increasing
> icsk->icsk_ext_hdr_len in an unbounded way.

If it were possible to execute the code you have highlighted more than 
once per socket, that would be a bug. This should not be possible 
because of the preceding checks in the function i.e.

     if (pas->tx.spi) {
         NL_SET_ERR_MSG(extack, "Tx key already set");
         err = -EBUSY;
         goto exit_unlock;
     }

