Return-Path: <netdev+bounces-306121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id peJREL5sT2oNggIAu9opvQ
	(envelope-from <netdev+bounces-306121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:41:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 963DC72F0FC
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:41:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=bHlLYMlA;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306121-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306121-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D45B302A709
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5093F0747;
	Thu,  9 Jul 2026 09:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E7A3A718D
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 09:41:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590073; cv=none; b=Tyulnuc35qT8vXdrjRZk7tTlnVB+PzdrvNijMhoiTDDbkoyk1aNMq8BWc77DEkrPSwmWh2oN1Tdt8R1AND3ESs0cczjOj5FmJeq6miyKhngajBx6cfgriBqzKLXWwFQ2PiXF2N3Me37uI1rS3B2bskGC012qDS9bOlTQBiFE5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590073; c=relaxed/simple;
	bh=/8dM9Z/CoF2L+7WNN7ITyoWlNjxyJTQlQwpQFvzkRD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8rGYMBzPJrEKlxkZgzAZqCMQFWAM0a850CyKvH8eq0H6xmmHlL7AA1uEvkjJXR529o2MewTS6LLFvvOGxSPVsPtBkM1XrLq2aNvgVgFnUHWg+iJS6SJdftN6xrAyCJTsf//Rc5pQsFUw1SuqnbWAZ+rW3TSMtGO38LjVkKCIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bHlLYMlA; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47d70879764so1149193f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1783590071; x=1784194871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dpTA2UFoD8jIxn6LzSQQQ69wwcU0vV5c/nqe3IqCP2Q=;
        b=bHlLYMlA01yrqUn3lbkHsAWJZqpwk1UZDwK8Bw5YvT6lxRpIp0fpuLQrnCwIPH6lfh
         ovPDY6HKKTQwYLOyk2BKxioyQi/cplgljqxi5Ruoai5QrO2GfBX2V3w3SpvuHtgRsnCG
         G2evJzQRqm4J7HeC0/AuDNfGuPhgdxYj8kogvU09jnds9i6gTmnAR13TS9zm7v3q1l3o
         4fhFmnaDnxeyENix52Yi7W2RmJDLhwLv4ztwhuGJ3SA6OkVmqViUi8oCC1KeBlfxMZOf
         PiwPF3F2YRa2WVzoBX61C+/ydkBUEUb+wth9WphBgpkdBG9kup0JiY30TUpHKN+jIKIZ
         A5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590071; x=1784194871;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dpTA2UFoD8jIxn6LzSQQQ69wwcU0vV5c/nqe3IqCP2Q=;
        b=F3ewENbsTiBfHH/5Y5WkygMU7qe1ou6wm8W3rLse+lPUczcjsGo7sXOKrIwMhd2jaY
         w3F2ebFx9PHdcqXsVavkPaQYqC4IkI+B8cS/Db5wF37LDDzNMzxH6PQVJgnR1F4Cd2Ph
         HMyEOiI/UL93xlvAME5qNCJgaqQa3YJL1U2ZCxYpclTBhMsqhJpkI+emnLF1TtcnFWoe
         4pwmxtiEKfi5qiIOeFTdWBjw2GrSEhqP4roZM5ZR1ucRj7NfeYgEvwyDiHrGdT8Zg9bH
         xFkN3JqnlDi3creRCS9RkUmP7HPDWnolVvwyNDGZmgmZIVUgi7zJ9KoCPjjqMUQFXQpy
         Fvmg==
X-Gm-Message-State: AOJu0YxQWOniWCO8zi1YpJF2ae3sr2x7UBEhj9tB9HVO5eN8lz3cT1u4
	17HAa7vLR7T8jbROjBxqhZc/qjzYIgU3z2UDwIJosxIe1CZT8GRBiuAJimQ8FcM2J8o=
X-Gm-Gg: AfdE7cm7mL3hRdUchvqSCkzJfX3qS10U2j27s1AUZ6LBUP0bkrMq2Vki6Q3TYh4jlM1
	aLgiu20mRKTSugxcwZeiVgvGNFTLTqxC38Gjm/ED+vtMzFOkpI6x0wFQ26Rqk7p1HpHmgGilE3g
	ZD0zIuubd1Zbd7qNgrVwjwrAeMerWtETOlqATUL7fQCqGcRMZgrpBiBlegNfqWzrNsDdzUaPatF
	b+6l5DSpn8ysj50Zck8AiD6kLWIoQlPHAi/mOYN3998uVwrtuUBnDn91Nhvn6p8bpSfSB9muG9H
	zNPhaJtvQJBT/pfxcORBAsjE7VE/IGKb9OsC1pqVHIFYNa1chRpLhnvoWeV8CK3BotjRasPPxKw
	g6oeaPzb4XB9qjQIc0T0kpeyidUNaLQ+4sCEz0cW5UfLDpHpcRrMTVsG3z6ok1A1FAAqKnI2jYa
	nkkjkNGAOHhUwfPPt4KzafFiZAcxcwK9KQD0BPcI2kWG8BJMoSLpzCgA==
X-Received: by 2002:a05:6000:2407:b0:475:f100:3604 with SMTP id ffacd0b85a97d-47df081ba52mr7354428f8f.51.1783590070132;
        Thu, 09 Jul 2026 02:41:10 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm50701835f8f.3.2026.07.09.02.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:41:09 -0700 (PDT)
Message-ID: <b0f45a47-ef6f-43df-9738-67b28df1891d@blackwall.org>
Date: Thu, 9 Jul 2026 12:41:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 nf-next 1/7] bridge: Add filling forward path from
 port to port
Content-Language: en-US, bg
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260707091045.967678-1-ericwouds@gmail.com>
 <20260707091045.967678-2-ericwouds@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260707091045.967678-2-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ericwouds@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:idosch@nvidia.com,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:bridge@lists.linux.dev,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,strlen.de,nwl.cc,nvidia.com,uwaterloo.ca];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306121-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 963DC72F0FC

On 07/07/2026 12:10, Eric Woudstra wrote:
> If a port is passed as argument instead of the master, then:
> 
> At br_fill_forward_path(): find the master and use it to fill the
> forward path.
> 
> At br_vlan_fill_forward_path_pvid(): lookup vlan group from port
> instead.
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>   net/bridge/br_device.c  | 19 ++++++++++++++-----
>   net/bridge/br_private.h |  2 ++
>   net/bridge/br_vlan.c    |  6 +++++-
>   3 files changed, 21 insertions(+), 6 deletions(-)
> 

Just FYI please see my reply [1] to Pablo's email about this patch. I think
there might be a problem that needs to be fixed.

Cheers,
  Nik

[1] https://lore.kernel.org/netdev/b0774436-bc41-462f-820b-6a037b6082bb@blackwall.org/T/#mfbfb071107713d420bf26c060b1b980b270ab172



