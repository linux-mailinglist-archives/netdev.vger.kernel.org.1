Return-Path: <netdev+bounces-285358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBsrF+ui/Gn2SAAAu9opvQ
	(envelope-from <netdev+bounces-285358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:34:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFBA4EA449
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D7EC300F5F1
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A918402B9B;
	Thu,  7 May 2026 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AstMe03e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eahzJnwx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339973C062C
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164455; cv=none; b=oGH2qazyD/6ENM9a2u5KaJlhO/27zKa/FGYwZicmLJnwtGi4TF5QaQ3Pg2IqzAEeCkmZEz49W6hH/BzKhY0JXLlSu60uvopHhCjMM8nMxUl/5+T1j+5HUB4GrE6Zy91raRvbCiF7+YutlqYqrygxuKpd0g2yJJf6lLnnFm9qI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164455; c=relaxed/simple;
	bh=REMXR87aQf+FeEBUtnHfLNXYS9O6phyTNdtm6aANwSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfAGt87VI2Gq14Pp8Ze69qZC8V/dACY7oY9aTyPQCzKjHSTiBCWqdi81E/nDrqfctGf+jhLlxzVdYtoQrY8WJUr9KvKmBQTmN59gtyWZVcmSN8+kW0qeI2RDdUHuR1zUD6AKSu6TDHxPiZgPnC10rrkke0QGCMcsOUD7kKznkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AstMe03e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eahzJnwx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778164453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfqPv4kAzqZ0NRYAwjXSQgvfmomJWQGhAYSphsjCSpg=;
	b=AstMe03e8JTl0GFguTD/Xms+rIswXvyoYbDTvuN+q2esLDWTVmovbKPz7aEz0gku3T7PNe
	yWm55irlT2Aq41mrOQ42Tbc7F7/4H+SIIAPvi72Pk52UcP5OJ6YIRZouKlGRPGvPTDsydr
	+r0GIzS9fxiH8wcWXtF8DrTvQSnFEuI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-e08v1sBZPRWpBCd3ozaNFQ-1; Thu, 07 May 2026 10:34:11 -0400
X-MC-Unique: e08v1sBZPRWpBCd3ozaNFQ-1
X-Mimecast-MFC-AGG-ID: e08v1sBZPRWpBCd3ozaNFQ_1778164450
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5a7437b4ff9so1127656e87.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778164450; x=1778769250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfqPv4kAzqZ0NRYAwjXSQgvfmomJWQGhAYSphsjCSpg=;
        b=eahzJnwx6U4GSR2lErHWzM8JmrbIvVRjds9r6QBA3nzOUZrSouWzsZpK4kloZYmZMq
         jOVIwJFCtL97QF0JrBtuoKX/sQX114lHAfSo5dYPcwZkQZOfETAZ9BWTf408KhV2goKJ
         7YJ6Y0l9TwLpFUtkX8YgwHeQlbJ7c21R8LI6WPH5StR2VJ0jJUBRGyiRDv9gTdjxGVYU
         +PUEa5SAqgpE+FzUADOOmapWbg/3QAdraaLIHeVwzuG4oaincaAFS4EijG67LIeAHJbw
         xTs8nbhVn7yzepeqmj8oUdGZsp6Ev+J4i/evi2IYR1fuAE0DEOFjjmymTi3TUxE6COj8
         NerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778164450; x=1778769250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfqPv4kAzqZ0NRYAwjXSQgvfmomJWQGhAYSphsjCSpg=;
        b=J3wOiyawW40RFJH4rHcy1d+8QKfjlpJK+RAuCnZIIGh1Izm4UcHIpbaM4UOc8qdzea
         MRmu5o6EtCMHTi7ok8geNXr6Sk06QPkV91KJH4mcsa2Ue0F1AbQZEWMdtcacaRvot14Y
         EnhrUQsrZ/PWk/PSlU0vP4tun4eHWadXEmTfN3xVI+fVCxl+Rof+96rbEJDF40j5ka4n
         AFJ1LBzJRvhqBc/vgBlfszi1FcunXwBzGpUCpfM4GNVAk3M/jLCSuOxFsBa7m06Qw3FO
         WuMKg0vwHVcF88JtAdmdhftnrRaDvSex8BG+bh335J0NIWYwDvoep4G/LWBFO+c1S7W7
         qRRg==
X-Forwarded-Encrypted: i=1; AFNElJ9eb6SqwqDhgg5Bgy08K13IHQs40sO9wHmaWnljHLyOkLU/uSy2eVu4jKWg/5SKkjXdyhvyXDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF49xpQuprZtJvYuf0lJwP7A++Gba3bfl5/bc89ffudBDN6rpg
	QyvMAciflsMtruV8EPBlGq2XZJCZBincwsH2NZ1U3aMGggVsz/7U05ZCPqE57S1eCFFmqJpqiQE
	wQYkiJFhqYHBPK+8QU8LKjgFHsSCVYqV30jbAo2n/hjrsfPHSeNOzCrJbNQ==
X-Gm-Gg: AeBDiet+9x+Mh8uPS+Bla8qITW3lka4O8zlmKBP8XO7wEKNadx9OC6L+BvqH6jTeqH7
	Ay00mhXrDgUPh0F4Q7yzullrkDY6ujbZRs4hUWjOrMBEhqJh3GyDd9SYVqXQ7C4X/2RdXmMYazj
	SA94AQLRaMZiutXjOUlhSZt2fSUU6zMtSxaOtBVJo7p1p8d98wGmEPA823m6oNAVDyOt0pK0tqN
	Ku5vnbizO6rfyI8MF7h0kAgM9LSedJzhGELG8jFiuiu/AkYWDQahkGFoZgi1KYkQf11kccIBVzq
	tJUYnrGXZEiyDJZqYTKNRsLpDW4cALktsr4dVvWK58Fq0iNCyq0zybVEyRBm2l9lD0UujpfsCYT
	moDRAzyB7YepRqFThiZ/7QSrJsZbmfxrFdudqPD8DNv0IZlY2tTjduZXE2Dve8LEv0g==
X-Received: by 2002:a05:6512:124a:b0:5a8:5eda:a0c9 with SMTP id 2adb3069b0e04-5a899bcd989mr1036584e87.18.1778164450070;
        Thu, 07 May 2026 07:34:10 -0700 (PDT)
X-Received: by 2002:a05:6512:124a:b0:5a8:5eda:a0c9 with SMTP id 2adb3069b0e04-5a899bcd989mr1036561e87.18.1778164449286;
        Thu, 07 May 2026 07:34:09 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a886d248a5sm1671466e87.56.2026.05.07.07.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 07:34:08 -0700 (PDT)
Message-ID: <8f2f7f2e-6aa2-4e5b-b52d-0025b2525579@redhat.com>
Date: Thu, 7 May 2026 16:34:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: Simon Schippers <simon@schippers-hamm.de>, hawk@kernel.org,
 netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-4-hawk@kernel.org>
 <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ee275aa6-af27-4dac-9afa-da88abde312b@schippers-hamm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1DFBA4EA449
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
	FREEMAIL_CC(0.00)[cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285358-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 8:54 AM, Simon Schippers wrote:
> On 5/5/26 15:21, hawk@kernel.org wrote:
>> @@ -928,9 +968,13 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>>  			}
>>  		} else {
>>  			/* ndo_start_xmit */
>> -			struct sk_buff *skb = ptr;
>> +			bool bql_charged = veth_ptr_is_bql(ptr);
>> +			struct sk_buff *skb = veth_ptr_to_skb(ptr);
>>  
>>  			stats->xdp_bytes += skb->len;
>> +			if (peer_txq && bql_charged)
>> +				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
> 
> In the discussion with Jonas [1], I left a comment explaining why I think
> this doesn’t work.
> 
> I still think first that adding an option to modify the hard-coded
> VETH_RING_SIZE is the way to go.
> 
> Thanks!
> 
> [1] Link: https://lore.kernel.org/netdev/e8cdba04-aa9a-45c6-9807-8274b62920df@tu-dortmund.de/
In the above discussion a 20% regression is reported, which IMHO can't
be ignored. Still the tput figures in the data are extremely low,
something is possibly off?!? I would expect a few Mpps with pktgen on
top of veth, while the reported data is ~20-30Kpps.

/P


