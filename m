Return-Path: <netdev+bounces-295134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3RWTB9FFIWpaCQEAu9opvQ
	(envelope-from <netdev+bounces-295134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:30:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7BB63E8C2
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:30:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=VjCjt4Fk;
	dkim=pass header.d=redhat.com header.s=google header.b=CxkjhJzw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295134-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295134-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9379301022E
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1F37C90F;
	Thu,  4 Jun 2026 09:15:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B62594B9
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 09:15:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564536; cv=none; b=pK2hcpYPP5yX56W56W17uzEOWtRZp9tL+HqpwoMmp3kTQakjMW6rBcQOw/zeQhIZS+nJd1KZsozZ+kP/Dfswur/xQDGcb0395N7x+mcaffUphnD/mBR2An2hNawv9ElF4+seNXhU6muwmpf0PAxB79+Qvr1PTXxXLXu9J/qjmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564536; c=relaxed/simple;
	bh=wsr9lRmy+9GHB+KZJernDtnANvnDAYWV+AVYa6tMfCg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b9LVOPSNjeU38VMc+B+1FnACQcAcMX2mLDskECZn/16QnsgzGiS1TnA4F1DW0ItIbITa2u4aba9hC8MYbyU4qqJBJ5GLmLnFrpuLfa8H5oTw9+9Ku6LgGSkBDfqkFeDCoUaW5hSbwZxKAM54CssdqYD4vfOxT0aWnxa3FMpPj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjCjt4Fk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxkjhJzw; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780564533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=goPcdb5xw4qHAjfQje1ZQDCpey1L+feZyrp7b4X8Yhs=;
	b=VjCjt4Fk1Nk2TM3mfYw686kGLyQcFCS3HwPN5zAE5D7Wer5Va/elhMMG2Zc1Gpv+YTvhQN
	fXP5Dq5Tbkl2KiVPB5ySF2Ho/JjwhKmwNLzqs5NhbBf3H8fN/310FO+kFwJJZsbe5n6G/2
	jqV+8Gz5ZoED+EYypTQi9oi/2IV/0uk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-VGJkHV_KNxGMIrKV9I-wBg-1; Thu, 04 Jun 2026 05:15:32 -0400
X-MC-Unique: VGJkHV_KNxGMIrKV9I-wBg-1
X-Mimecast-MFC-AGG-ID: VGJkHV_KNxGMIrKV9I-wBg_1780564531
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b79e6b94so3430975e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780564531; x=1781169331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=goPcdb5xw4qHAjfQje1ZQDCpey1L+feZyrp7b4X8Yhs=;
        b=CxkjhJzwVHPGY/RIoBteT0WvFtT/umFmxtHEOfRPya8lgKOxpLHuNrfMY5Yy58QZXI
         RhOvoyyJA9jDcC0XJT9erTc1MVus71oyJIpADx6hJoIY7m2nNvQKJKvUkKq5iQKpOxXh
         QbDqTgILipiEwxeLBFV1mc3I835RwdhBF/1mtrFKn/EacFOveQeZ/T8HTpNPqdADXCol
         U+UukMr21jE8SbizyXNa9JKtujChc+EtW3UOxbQ+jrV1UElECJ14h5TDxMECdyrrQGF8
         q3szQtGdzaYWXMpXLtFvrDtTdL8XghBwjMJGjPQk0ZSX+a977DIQfeAw/q+aCOVQWfJ6
         pVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780564531; x=1781169331;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goPcdb5xw4qHAjfQje1ZQDCpey1L+feZyrp7b4X8Yhs=;
        b=RQkRr6aTTwitPEoFPh0E7pwiTjWbuiB0TyNwe0zUTegW7YF+k9+YwwsY2biQilCaMy
         cPNwV2bwDP0z8NbhkSk2Aoio5M0f1XfmmJ9AfhrxywZkqHhOL+ReLm2gXPXu8DWN1dwS
         IG8P9v1sUaNKdlg8A5VxqRuqm89QuWwYDTiF05I53z6EfYj9hEDYtBNkkev6Tc7H+V0E
         A9B/SpGvq+uvkTuzgm0kvfUavDIkG3IPsTYjWak2mmbL265V4SjDA8vfHcAiwC7wo+8K
         tw0O0Yfg/efPT8tfD5m2Zss8HxFSjWnb6Ei0iLtnwm1MSNMlUswoQw82bnDLkCOpOUxs
         yCCg==
X-Forwarded-Encrypted: i=1; AFNElJ/i1ZVzbW/1qywZJ91sKHhBFIAcc7PpTrJfzV8iv5osi4EO6XvZlERHBUn3iN9ZVWTYqcrbKeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA64OZxGZl3zkJCKxTU/PJ9Gna2UKCC+9TtpT7b9dUQ3SkyFF8
	YvqIJDcR6+Nq9TQIzvNRmN13GaxpUr8EGtj9WAdWZjv9vBqo2/9TYDyF1DRvzq9sXCD8gS9i5Px
	Zm+0khqIWbwwVSU5Lr0iPaC+VUL4omNt0mp+7c8qz4pajRJZiHfgQQ2WqtGdw0QDA1A==
X-Gm-Gg: Acq92OHWL1UORdOsR7QL3B3guxFhXZ5ZUbIImNodgCCav1/QUTdcYJPutyd/m7h6lKO
	qPWaOvmrRuA7AgzjhR+tfa1pSZnpqOhQWS+7d7QV85CoVo/iObVWoJL2RJ5prTxjyX5oDo2eAEU
	YHlYop7TLj23lL2EeQF+lSduUk2olNcZj0RZvZjPr/RdiMUEOdFLgblqL1R38+G/UnNW1r10uHB
	bWP75x6iYU7kZ0CFsJ07HMU3lGylGCnHArsVFjwtTAoIdLm5Jk9ZsNa2T50TVKd7/bvfdR9nJlW
	+qCVMvL+5D7xPLAmpsvkGI79xg5iSkMXpdnkU2pg2bpiAIRNtHPteKQyBliH6lG9JXZMQrsEpKM
	zA+LC1jOKDKIi+rLqi6foeAEEMq69Nt4gkszgrkidGcbMXmGkGvEsMDGwJWuKeET2oE0=
X-Received: by 2002:a05:600c:810c:b0:490:47e3:929a with SMTP id 5b1f17b1804b1-490b5e7961fmr119685435e9.6.1780564531467;
        Thu, 04 Jun 2026 02:15:31 -0700 (PDT)
X-Received: by 2002:a05:600c:810c:b0:490:47e3:929a with SMTP id 5b1f17b1804b1-490b5e7961fmr119684795e9.6.1780564531011;
        Thu, 04 Jun 2026 02:15:31 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b59f0sm65255285e9.2.2026.06.04.02.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 02:15:30 -0700 (PDT)
Message-ID: <bcffe05b-c10c-4a27-b260-e6ae872c795e@redhat.com>
Date: Thu, 4 Jun 2026 11:15:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ipv4: igmp: annotate data-races around
 in_dev->mc_count
From: Paolo Abeni <pabeni@redhat.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260531030705.3754389-1-yuyanghuang@google.com>
 <20260531030705.3754389-2-yuyanghuang@google.com>
 <95adff35-ee56-49d3-8567-382ac17810b3@redhat.com>
Content-Language: en-US
In-Reply-To: <95adff35-ee56-49d3-8567-382ac17810b3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295134-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B7BB63E8C2

On 6/4/26 11:11 AM, Paolo Abeni wrote:
> On 5/31/26 5:07 AM, Yuyang Huang wrote:
>> @@ -1922,7 +1923,7 @@ void ip_mc_destroy_dev(struct in_device *in_dev)
>>  
>>  	while ((i = rtnl_dereference(in_dev->mc_list)) != NULL) {
>>  		in_dev->mc_list = i->next_rcu;
>> -		in_dev->mc_count--;
>> +		WRITE_ONCE(in_dev->mc_count, in_dev->mc_count - 1);
>>  		ip_mc_clear_src(i);
>>  		ip_ma_put(i);
> 
> The patch LGTM,
But it does not apply cleanly to net. Please rebase and report, adding
the target tree (`net`) and a revision number (`v2`) in the subj prefix.

/P


