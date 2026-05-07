Return-Path: <netdev+bounces-285330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOiuNCeT/Gn3RQAAu9opvQ
	(envelope-from <netdev+bounces-285330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:27:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9881C4E939A
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 340B730A6DD9
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3943F7878;
	Thu,  7 May 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEN+jsJK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IiiG5P0H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F323F074F
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160113; cv=none; b=dMXv6Ug6iwcT5bDT58JT2Td8uhOhsAZNMrivgkzMPdO8Z+prtQu3pb6HsmfBAVSbtgEEodrASnuLalxuhSxkBQNlEwEc5XJGpuqVyOEjiZFE+qvqVt3mS9AgNMXDcgxpg1C7X9DoJRPLLE6CryOHq66EQYxhU9p5upR/udwbWak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160113; c=relaxed/simple;
	bh=AzN9iJ/2PC2bJY/nNv5V/vSdE5sX7BktLp2vGiXYbxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dgo5oXvYgJV8JuxVCyEgfmYkmSz2F7/gi5uAgIaatL6TFp+k4y8xDaGvh1/qspsJOXDjbhYDQGHKqkzKoynxwvcjD6OSDj/vSeQ9pDw95nXqBu6Fx6rID4jrIo78JmZbgV4Zv4oSWjBzpys0ZK0ISI5bloLNCyo0Z7mKn85IrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEN+jsJK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IiiG5P0H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778160109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NA3uYduQ4Jm26gU9caKxlD3akBOvEc2T3FZacK7c4rY=;
	b=cEN+jsJKF8+8IFRI9k/622k3sNprZayEKQxZTi69REp0VsVe2N7GBeO4fpsyWJQB0ZwNNj
	6ZdWJ3YrFxFd5YAO1MPy2L0yIuzHKlh/yromTBGYIfMMOY8lt6RE432ZzKC9DYzRpE7+m5
	+fLMOnZso/SOhVR+QvMx5oCg4zkSJVU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-N0N86JMIMiCX89bl__htQg-1; Thu, 07 May 2026 09:21:47 -0400
X-MC-Unique: N0N86JMIMiCX89bl__htQg-1
X-Mimecast-MFC-AGG-ID: N0N86JMIMiCX89bl__htQg_1778160106
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d0889c1ecso6138935e9.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778160106; x=1778764906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NA3uYduQ4Jm26gU9caKxlD3akBOvEc2T3FZacK7c4rY=;
        b=IiiG5P0HdULlxQnCkMNzQd+zcpmCUqPwU4yiNtOiZt6vO4E1xAnr8j19ZVvwf9SOMg
         ejqGNyByZaOnQNXr4fRTvG8xglaxjFR8+rA/AoEz8zNOq5mCCtEcdctB8L0tviW9yP5o
         0gpgKXtFyJCUnb1ZbBdIGQM7GOVDO8OhtNzlH0NbIPpDQTbGoSYcnXDzgE91VYCuC/J2
         uZtZg0juB6wkbej9W8HYYhRy4MJUWmOUGzHeuYMtq+KyHMNaGpM9VY/p4iIM4lNkaPrN
         ePwpMbfnPCnvm/Uj2pcIPZZAItHvrtCVyBQthulRQyOx3DnVtSrrHLjfdXxq5c4sEnGL
         T+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778160106; x=1778764906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NA3uYduQ4Jm26gU9caKxlD3akBOvEc2T3FZacK7c4rY=;
        b=Sn6wRqeTIRur66kOvFiCii0dmYMcjwWXTQ6G1G150AyUoHxvkdqsIWnkqSgkGdw+Gb
         HLVE0IzeVUnmUsNiLbBd2YonS9Kcm0gs3KaWUa8EsnU4XaZiI4D/htnRRJuNeyoyR8lw
         8RdULv3mZI7epCxtQtExxGGfXNtbYb3lS/o4tf+dJvPicvFLIFwjsvk7tRfjukhCpeuw
         i9t65Bw/lcjnKzayZ5HwJ3ptcrUGCo+QcwCqp9BcTAQ9HDv6UFyAG90LESyFd49wAxle
         +JEnHqhy9n8WNHQ5GCCsaSoYHavL9GO5snwOZK8XhnR3aH0IyXWgs0/lV88IrJ3qvUR6
         b6kw==
X-Forwarded-Encrypted: i=1; AFNElJ8RAM8V6nt4aFIUhQo/taPgxilM0TrWwBMQ96znXjSYYz/6ZlrbbQu5QclYb/zeJqo2c9gbnxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyod8CMx71MrfEGqUoqJysBJIZ9sFLmLJ5/4511qEbvPG94dAR/
	GLHow1tbsoaRE9yGsedDPX+r/3FuD2XF3QIih2+nm0unICAc7XkmJ7Ke5m5k/dIIsgOZdyj/Jjj
	HZz3SXXAbLUH9gzGH186/UlaJjr8Mb5Vvrn9ExQVPJntDWruYW2Kak3a3xQ==
X-Gm-Gg: AeBDievGgkMspDtrZBSb0ZKWYw/M9cuFtPkUr/gD9Y9oGwQfAzn2pgJC70WR2R2Jirs
	rr1vJkyjcL9ccHGtqM+rVuVd7Sy9Zgdn2AkkZ0zTQ7VjxXygNq70wxuqBWPsPtWSGm5zSYGj0Ql
	se4m1bmRQIZ9r+S41oKNsFbGgU4tV3UX8P2Q8EQqsWhj9j83cyAzmSXO8u/pd7cnStMLjKIgGas
	rVJthfeoozEbSxIEhjTqyVOSuLMSdM8CzHM4Q2Nu4tDr4IPEmXHcoCCIjjkKtahTtcaajdxlWOi
	HIjHlkT/e/tzmyCuK2bYerZDKR3TN7J/18WvZl+0dRIRanze5jQAG80hZgUOeoUuXtdCp/grIyW
	zn66NH4oCvrMm+JkKHvJD0/LaQwJd/e4w4eLudx4Y16rMBF4b8kJSnOSCXbm4Aym/xJmbinx1h8
	68
X-Received: by 2002:a05:600c:15d1:b0:48d:112c:f582 with SMTP id 5b1f17b1804b1-48e51e1e415mr72915565e9.11.1778160105868;
        Thu, 07 May 2026 06:21:45 -0700 (PDT)
X-Received: by 2002:a05:600c:15d1:b0:48d:112c:f582 with SMTP id 5b1f17b1804b1-48e51e1e415mr72914835e9.11.1778160105311;
        Thu, 07 May 2026 06:21:45 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e59b74277sm82568905e9.3.2026.05.07.06.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 06:21:44 -0700 (PDT)
Message-ID: <4e9b5728-1a8b-466b-900a-935e5647a623@redhat.com>
Date: Thu, 7 May 2026 15:21:42 +0200
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
X-Rspamd-Queue-Id: 9881C4E939A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cloudflare.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285330-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 8:54 AM, Simon Schippers wrote:
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
Isn't the veth_poll() (towards the end of the function) a more natural
place to issue completion events?

/P


