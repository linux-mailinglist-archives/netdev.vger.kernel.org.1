Return-Path: <netdev+bounces-175466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D388BA66027
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1445F188D3F3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9912B1FA26C;
	Mon, 17 Mar 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCzoaeJu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8E201278
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245451; cv=none; b=pw405Jvw8KrKZRI7GsZOrwpUd29VwWJ8J84wLnA/kXameYtiPmCaylIwY8Y8zInRstCusgVs/AqFviilGPp9HJWVr8ivRguyDXr83xlih1DfSdOuOtrR3Qewv+7xM+P++4vbuqk7RW/keEubPMsPmHOM9H2StOcVItLCawur4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245451; c=relaxed/simple;
	bh=OoiDlRqg4vyRAgxOAJNm87/M3zZ9sBnLYzT8dcStGps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6RU5V9c6tJwv88F/slG20CCrOPI0d8FAp7eixT2DTLJv4W4/ANyZvlPcx/eNhDYm23GGHK718dM6v6QcGGOKLLmCA8vI2J7vgDiHuGZ0cUzlmp8wvCcnESV6fUPaSsPncbt81S9qLfqfjYczZT0r1nopr7BGmb633AZAaAK9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCzoaeJu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742245448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbwsXMam4KCw7aD09b2qjKYv+IfkBT52U0KqXE3xKYQ=;
	b=BCzoaeJuzV56knt1jrfbLsWeAv/Rz4TxjbYmZa6XIco83eWfETYJWj71BPLZ1AGopsHGls
	w26hu7vUd2afWnB9g9KTeszgk4PKKhUQ+LDQe2AqHLKj4HGGnQY7wWLC8v8uo6AtxzYaYP
	6In9skpU5IFJ9aoMv5DHFQtw12RJTr8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-CDhm5FxlPe2K7hj57kUW5g-1; Mon, 17 Mar 2025 17:04:07 -0400
X-MC-Unique: CDhm5FxlPe2K7hj57kUW5g-1
X-Mimecast-MFC-AGG-ID: CDhm5FxlPe2K7hj57kUW5g_1742245445
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391425471ddso2553719f8f.0
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 14:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742245445; x=1742850245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbwsXMam4KCw7aD09b2qjKYv+IfkBT52U0KqXE3xKYQ=;
        b=ueQcBfTFpjLjFOslwaP3hfsaUtXIw2cbmQh5kBeNc2ij9gawNXRgFqq67ykr4f6yNC
         T+mwg6kSF7cv2ECJ+L16UoZ6iTEzm0YjUzwZBB94haqM+9vY3Emp3SEBf3gvoNsRdDWQ
         S9BhEVjhGOebCFsiYodrTtZfHC8FaCjKpW2HVNHISueSSO3ludGXIfSBJ2+hZbEh+Vrb
         5EmH6bT/CQgfGUMsr0htgYz828nW3RR27XACGtuBv+afggppSTOX2lMkAfhjRX7yav7q
         sHXcRlNVEieH+VM6aXPEP28vx0akTDJ0SwHcLTcODOj9wPbYVhfUNs6qmsxraRqhFlx/
         KKWQ==
X-Gm-Message-State: AOJu0Yy8cEYc/11OtqtlQELznkdaR08QnE4c5C2aa57w+QwUAk+bclus
	SmLuwMfFxVRcUqemwODcBYyZT3P40f+I0stJ3gJzSwE3G+8am+RNmOn/gkrQPRTjhodFKZw6Pgy
	AkIpUlvHHbIPRO3d/yq7HYV6QKVgVcfcG1OuJUrnufLXj+4eqmW/GeQ==
X-Gm-Gg: ASbGnctjkhwbj0pIB7fp3WWFZUKyk49RH0tX+3WlkpB+SxL1bEvqqEgGUoP3M41QbSN
	YjMf5jucNPtgi/KTnjOCGP6281/ijn4hRPQzKtmI31xy7pOawWb6Yt/vllw45nL+5jIaRaUSEjW
	l00jDihCxx/10C7PV0nRRZ+mhp1U91ORq0CYTFmtCnYrmgiGd4cYHNZW/uJcX5ZM+hFFl/Ursew
	N6YKb0gJj3O+xV4rNhsZ9dFJlZBJ0oM8XmBFpneZAS9CUPwutn9rQUA3M48O90B1iF0Rukd0zL5
	114pOh3RF07yq0A2TP82WGF65KPMgTsvCafNOj7JqzRkSQ==
X-Received: by 2002:a5d:648b:0:b0:390:e7c1:59c4 with SMTP id ffacd0b85a97d-3971e2ad603mr16741779f8f.13.1742245445570;
        Mon, 17 Mar 2025 14:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk2wiVA9t3El2hJh8gfCbbFsSl0Bk4VQBu3x4PsYQOkuAVxoNzSqKy1vHCZNIGeDbgank4DQ==
X-Received: by 2002:a5d:648b:0:b0:390:e7c1:59c4 with SMTP id ffacd0b85a97d-3971e2ad603mr16741754f8f.13.1742245445217;
        Mon, 17 Mar 2025 14:04:05 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm16112796f8f.77.2025.03.17.14.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 14:04:04 -0700 (PDT)
Message-ID: <eb1fb79c-d2f6-48bd-82b6-c630ae197a7d@redhat.com>
Date: Mon, 17 Mar 2025 22:04:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 00/12] AccECN protocol preparation patch
 series
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dsahern@gmail.com" <dsahern@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "joel.granados@kernel.org" <joel.granados@kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "horms@kernel.org" <horms@kernel.org>,
 "pablo@netfilter.org" <pablo@netfilter.org>,
 "kadlec@netfilter.org" <kadlec@netfilter.org>,
 "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 "coreteam@netfilter.org" <coreteam@netfilter.org>,
 "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, vidhi_goel <vidhi_goel@apple.com>
References: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
 <174222664074.3797981.10286790754550014794.git-patchwork-notify@kernel.org>
 <PAXPR07MB798499BAC1A21E323687C9CAA3DF2@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB798499BAC1A21E323687C9CAA3DF2@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 5:44 PM, Chia-Yu Chang (Nokia) wrote:
> Hello:
>> This series was applied to netdev/net-next.git (main) by David S. Miller <davem@davemloft.net>:
[...]
>> Here is the summary with links:
>>   - [v7,net-next,01/12] tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
>>     https://git.kernel.org/netdev/net-next/c/149dfb31615e
>>   - [v7,net-next,02/12] tcp: create FLAG_TS_PROGRESS
>>     https://git.kernel.org/netdev/net-next/c/da610e18313b
>>   - [v7,net-next,03/12] tcp: use BIT() macro in include/net/tcp.h
>>     https://git.kernel.org/netdev/net-next/c/0114a91da672
>>   - [v7,net-next,04/12] tcp: extend TCP flags to allow AE bit/ACE field
>>     https://git.kernel.org/netdev/net-next/c/2c2f08d31d2f
>>   - [v7,net-next,05/12] tcp: reorganize SYN ECN code
>>     (no matching commit)
>>   - [v7,net-next,06/12] tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
>>     https://git.kernel.org/netdev/net-next/c/f0db2bca0cf9
>>   - [v7,net-next,07/12] tcp: helpers for ECN mode handling
>>     (no matching commit)
>>   - [v7,net-next,08/12] gso: AccECN support
>>     https://git.kernel.org/netdev/net-next/c/023af5a72ab1
>>   - [v7,net-next,09/12] gro: prevent ACE field corruption & better AccECN handling
>>     https://git.kernel.org/netdev/net-next/c/4e4f7cefb130
>>   - [v7,net-next,10/12] tcp: AccECN support to tcp_add_backlog
>>     https://git.kernel.org/netdev/net-next/c/d722762c4eaa
>>   - [v7,net-next,11/12] tcp: add new TCP_TW_ACK_OOW state and allow ECN bits in TOS
>>     https://git.kernel.org/netdev/net-next/c/4618e195f925
>>   - [v7,net-next,12/12] tcp: Pass flags to __tcp_send_ack
>>     https://git.kernel.org/netdev/net-next/c/9866884ce8ef
>>
>> You are awesome, thank you!
>> --
>> Deet-doot-dot, I am a bot.
>> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> Hello,
> 
> I see two patches are NOT applied in the net-next (05/12 and 07/12) repo.
> So, I would like to ask would it be merged latter on, or shall I include in the next AccECN patch series? Thanks.

Something went wrong at apply time.

AFAICS patch 7 is there with commit 041fb11d518f ("tcp: helpers for ECN
mode handling") while patch got lost somehow. I think it's better if you
repost them, rebased on top of current net-next.

Thanks!

Paolo


