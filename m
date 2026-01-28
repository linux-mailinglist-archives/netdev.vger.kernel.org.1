Return-Path: <netdev+bounces-254141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YODjEla+eWnoygEAu9opvQ
	(envelope-from <netdev+bounces-254141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:44:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B899DD58
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB17630041D3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EC3324B2D;
	Wed, 28 Jan 2026 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="El/IZcUt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gt+bxbDh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD2221FB6
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769586258; cv=none; b=K7Bqo/lw/In6w/hJRlA7VpBxPJCsuKBaBdBgeRf4MWXudtjdVMe4BF65ZJtJU02EEfHYgEEeilCuLmFFJ47D8JPa9S6jUe351eLR0TqVHJDU2bTaFIbbnm45kpLwQJbQncUkQdEwprsfWF6U6X52ei5bunzmseqNWU+SMr/sMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769586258; c=relaxed/simple;
	bh=1sqaxyg9uUfww2vS/d6/pDwRt5NvTGwpHUEkBH22Jkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psljwDfs7D5pu6kPJDYvCJiRpq73+Fk/jm//VT7b/FJjZpgXxEVNnAg3ZWiU4HkuXWli7/hDk2TefUKOxdtEZntCo0rJAigCLpB1KDf1gTUbPN7o/AIh/bwfECozBuhnIzuDlESI9xIbda7CK95m1cmqNXPcriK0IGCXAuMHBIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=El/IZcUt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gt+bxbDh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769586256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2r8/rRraCmZGhd+qX9Y3lCkPKausqhtTQk0k54UGaw=;
	b=El/IZcUtD91Bl1jAyhnfs1beUMx2BFkZSdEqGlfrJd/1tPzbprbzI021VMrNAcjQg2UX37
	64Qx1vYIceGOyYqaJJI1hYBEYw8APwFo3x853wwATJm/0nF1dNpZCf9KTlYqpjHt+7MwwX
	orl91IOhSMk1ZBH/p4EgdL3r7zlGdWU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-UkqN4jP8O3iHxN5PQmzYCA-1; Wed, 28 Jan 2026 02:44:14 -0500
X-MC-Unique: UkqN4jP8O3iHxN5PQmzYCA-1
X-Mimecast-MFC-AGG-ID: UkqN4jP8O3iHxN5PQmzYCA_1769586254
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48070c21420so1066595e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 23:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769586253; x=1770191053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2r8/rRraCmZGhd+qX9Y3lCkPKausqhtTQk0k54UGaw=;
        b=gt+bxbDh5U2i8qh8qd5iT8lTAuLyg1777UtIw/jUElitPWiQV7XztvS7FqeBz8tc1H
         B26eYiAYsC753cKcSNkTD3fPVbeVyto2evz5ubqqnaxkl0/MHlL85QJU3jqMsgDEUZCc
         q0BbCqHDW/p6b8d0EhxKRJdW7xP6RSIeevn5B1oZcqyNj4VK6aI+/DkMnS41NRPnnEN/
         oOjO5aQIkJmMNFDseo6TfMoH2c+Wlp/qyRrgl7ZgoGU4B7IAZAvoCra+Z2APo4f7Xk70
         QkwcgSLOr+NSIOK5oVBtG05OJAFAQLJVm2h51sNt1IjLaPrYYBROCq/ajQMCObLPVCdz
         JFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769586253; x=1770191053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2r8/rRraCmZGhd+qX9Y3lCkPKausqhtTQk0k54UGaw=;
        b=I2sXu1Ggkb5XjqbPBmf7lcVexg2nir3TPnAWn+dJkwH9yix5EdgbGBV4F2rH2KFkUK
         jyc8TQ9EW6p6sgP4gKQpJhUZ+TkUVQICcRGg9jJRTc6pAo26fS/qbjd6kJtjHEYS92ZB
         nVqXhtrxiiT4cTirBPtPJEgArUF+VoDmCYTP7eVoy0T3ao9Q5kqHdkIFE3ndrt5qAfWn
         1meZGR1i3ha0E6Kohy5hWoPXcikCG+FxYClsez7IRpMNVDOX7cZMzjyshc6cxVEd79tj
         byNOOPiOdhpQaLi+7tT/hVdqzs4LCoRI6AfJcFRSP82tb5JjKqZ986GPjmgqJfOf8uWQ
         BWRw==
X-Forwarded-Encrypted: i=1; AJvYcCVxHOIxybDjdzN+uIMXU42Lqj9Cog6ydFv7tLEM2gLjeRIf5Fo0HeeJnarSHRerY4VKX1l/00A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYAvsqLOooqK3M7P18Okzp7dClR0TY+9V1TM+lPrPOef7xvzke
	FtqioAHCHEsJIwf2o5e+1ymU5z1ezHkn6f3UxOZW6MVqWAMXcya3ZXk6xYBzWz+CoGQLCBvWec/
	pPxm2n5Hqs30RlBRXSHOCTvEv1MncCFHxzcq7rqJK6AxiGZTgoyRYJE0ysA==
X-Gm-Gg: AZuq6aJfbhiCE2gmSx80IhDNM6rWRc8j1FIh7UCRQSr7HicCAgVy5Ks/fpcH9Ifmub6
	hft/1Z1cko5EsxlUC5YxEb/RxOTLU0JGLulaeJhKmW0yF8FGZsFzcPyWVBQ7GWE5nowgnnha+Ct
	STd0NndnW0o79vpKJyI5de+RbbE7P+DardkBut3SY2zjewHQ/8CMI+Z2/6cgR+mJeoRbYj18itA
	ISyD3zTYm/gu+z+XBPvggzRBJZbBJezBmwy/RQVkolIAAOI5NZIqle38IbhDAPTCrFneixLOjRl
	J0bR8ArZJjD3C00WrPaMFFmhjgKPSjnGyJJ5azD9erYCQ93EJlECVUPQ/E1SDaL7kl97YSqQqQQ
	GUp3/6rSloKUs
X-Received: by 2002:a05:600c:5742:b0:47e:e0b3:2437 with SMTP id 5b1f17b1804b1-48069e24623mr37363475e9.5.1769586253600;
        Tue, 27 Jan 2026 23:44:13 -0800 (PST)
X-Received: by 2002:a05:600c:5742:b0:47e:e0b3:2437 with SMTP id 5b1f17b1804b1-48069e24623mr37363235e9.5.1769586253131;
        Tue, 27 Jan 2026 23:44:13 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c428basm116931625e9.12.2026.01.27.23.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 23:44:12 -0800 (PST)
Message-ID: <13f7664e-af7e-4c78-ba0c-b58b3ab59075@redhat.com>
Date: Wed, 28 Jan 2026 08:44:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
To: Jakub Kicinski <kuba@kernel.org>, chia-yu.chang@nokia-bell-labs.com
Cc: edumazet@google.com, parav@nvidia.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
 <20260123100721.42451-11-chia-yu.chang@nokia-bell-labs.com>
 <20260127120957.76e52cc5@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260127120957.76e52cc5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254141-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ietf.org:url,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: B7B899DD58
X-Rspamd-Action: no action

On 1/27/26 9:09 PM, Jakub Kicinski wrote:
> On Fri, 23 Jan 2026 11:07:16 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
>> Based on specification:
>>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
>>
>> Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
>> AccECN mode MUST NOT set ECT on any packet for the rest of the connection,
>> if it has received or sent at least one valid SYN or Acceptable SYN/ACK
>> with (AE,CWR,ECE) = (0,0,0) during the handshake.
>>
>> In addition, a host in AccECN mode that is feeding back the IP-ECN
>> field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
>> latest valid SYN or acceptable SYN/ACK to arrive.
> 
> FWIW this series is marked as Changes Requested in patchwork. 
> I don't think I did that, IDK why it's in that state :S

I was me. I went over the AI feedback and it looked legit and relevant
to me: AFAICS the listener socket status is wrongly updated instead of
the request socket and likely corrupted.

I was sure I sent the feedback email before updating the series status,
but I see it did not land anywhere - PEBKAC here, I'm sorry.

/P


