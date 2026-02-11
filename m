Return-Path: <netdev+bounces-258221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aERMFgJCjGm/kAAAu9opvQ
	(envelope-from <netdev+bounces-258221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:46:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F34FE1225D4
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4654630178BB
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A6E34FF77;
	Wed, 11 Feb 2026 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CC5aTaJW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dC13Ilnt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337623446AF
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799614; cv=none; b=ibfp+sudyZBZtWiQU5U+RW5Il/0KyCi6tgG8KYgYDEG0AmYK5Pd0M55iObODcZ5/dGqYCEp72d5UrXKOiMxgkl6+Ey7+L543vh4DzrSynNCXNe0m+fLbIJ/YE+6gTHCyOzWVinrKydkh5efXq7mNHPSYwLhNWbpWnM2JahZBs3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799614; c=relaxed/simple;
	bh=+6vukVA0/H10G5i+xywqgG4wJ1OTLqt6f510aloB/C4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qYAanCS9+d73SJFiA0pRkP0UljgpNgAHIpoob5w8YZgERJ/UgBKUrBqjZHGwdP1qhamcg0CtNbMGL3RId9KePHuonEl3CwEw36BP0FaRZ4owvVBh7Y6hWD/zBbId3OxA6eklVI9uClpRb6zcrI99RK71q+wCvrIi0mzz5coKT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CC5aTaJW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dC13Ilnt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770799612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2NUfxY3dgOQc6Up8CPv860MldCejLy3p2EwnH2qBy8=;
	b=CC5aTaJW9cuDyF0YrxfDfYMy+Rhlj7jXNnVoigelOF4J5x0Ez+A/UeEK18woIroKHcCsyT
	eXnG723BXdR68/6jwFFlP1KB5ZOcE9dJ/4OsBY5s9OeHeU5pUu5/COEXqBH3lKGHqPviAw
	mfAlqAG4NBmz60BVGX+kQgwOgiSaE2Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-iBSoLd7nNe6oSGhaNgQ1MA-1; Wed, 11 Feb 2026 03:46:51 -0500
X-MC-Unique: iBSoLd7nNe6oSGhaNgQ1MA-1
X-Mimecast-MFC-AGG-ID: iBSoLd7nNe6oSGhaNgQ1MA_1770799610
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee056e5cfso57645745e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 00:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770799610; x=1771404410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z2NUfxY3dgOQc6Up8CPv860MldCejLy3p2EwnH2qBy8=;
        b=dC13Ilnt8g763AzwB7o6onZdzHwNh5j//lrgNQ4MqU90G8nooxIj5TimZkkoJCoW1a
         AVpfbN9lJAIG2imlxH04+lyr7cPztW9flzJaI7qKt6Z7kLRGyccDEU7ExnAlcpJnWtv5
         bcevmQ1Uz+oIGmHmTQ+FIZ1Hn2j07XUIiTyW1NOnNtfYmGM+L9Ak1AnZaDf7lre13B4G
         ne18ZiaNgLp97azNIpDJFQrZXL4vTzr/GhainO8SfMO5ODzDLxNLY+Q4bMPz3b9GIhW8
         ZWq358GyWcgfjo6VJDeFw3pJGF5pfKmeNJyIKra9o47q16wwpo9R1EtIydLo8a2gGPo7
         Qbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770799610; x=1771404410;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2NUfxY3dgOQc6Up8CPv860MldCejLy3p2EwnH2qBy8=;
        b=FEZtn5xCAT0BRHN9DMktmgIigCK0DPfp8a3qRjvTH4BRqFK0HlKpeA1r000qF9OjbS
         NH/aZXgcM2/8uJJzS6pZf726Ni4ulfH1b2paj0ZrLPSE5UEeKLAWXK7J4rDQMGafxMdS
         +KCCobn8ULb0p2ukPM+NpwO4E5OWdqxSDrlBvw8Ua7rp2IAXCF5uGW7Ou1d92uetP/7m
         D8uzYpHqdbF7XM1NpLfw5YFImFQPVydcfBm539BFKGhboJ/nTHQNLLhKzk/x2zTlkYqj
         o2nBV8PpGLlFWSmJAJscAmXWq5CmXrE1FVs7TdZe1lv8dlPlPS8E5DIEPqJfauStMYOa
         1tkg==
X-Forwarded-Encrypted: i=1; AJvYcCXWDlBCx5n33pTVv0poguz4DJATqgxOaktXqT/IaVUFXgbrgmgLQkXdQ4OWZ+Fk/es94AU9kmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwneQKfEL7FFNWnKh90DfbBDcsGSjki4Ial5sjtmVuOHcTrMCCW
	inRWCVDEdtkuQBfi/qlYkmYA+ch+r3bbr+EYRpHnnugvm0he0n4arcFNunZQitJKm7DKOLsa5yE
	rx2uaE3Jck3tmeanFAWs5sNeAN3pIfn2tu1F7yEIWYbreKsUotlwQAF78Iw==
X-Gm-Gg: AZuq6aKgUQ0vfCjed3iTUfUXb8GqEtA8pEl9ysjYGpbKqDAyTVX+QPjNDLjrRBermDL
	qUizGXjF0x0uV1hNMEBVgNmcyMTNNUBK9V5TIMcx6KEVNBGxHNSHYOCpcp+ZApUL1VVmWNXBu5D
	dZskCl8JNMrNcMHDqI8NFSYbAaOkXuTlxKv8MsxeAhISWZv9rGFNvoACsadDUX8lci3ampXLLRu
	1fi0FGiDDas7Aa46SfzrWJyiTgfF+J1HRqzOLzpOaO5k1y2tmdhxp6D7o71GNK3DdV4nkmdyrAw
	OMd94pWkDsudFdeKQSJ7l5jBqK/EX5VG9SwRsHhVCjLZ12PlpyKm0MCbcJ9xoKrUK7ZzBQRgJ4b
	lm8x2Qvi5RFmgKInEh89Pn6Sh8A==
X-Received: by 2002:a5d:5e01:0:b0:436:3267:3ed4 with SMTP id ffacd0b85a97d-43784548a6amr1674576f8f.17.1770799609675;
        Wed, 11 Feb 2026 00:46:49 -0800 (PST)
X-Received: by 2002:a5d:5e01:0:b0:436:3267:3ed4 with SMTP id ffacd0b85a97d-43784548a6amr1674542f8f.17.1770799609237;
        Wed, 11 Feb 2026 00:46:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d310c6sm3305848f8f.2.2026.02.11.00.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 00:46:48 -0800 (PST)
Message-ID: <dda23104-3ca9-4f81-aa79-b0517a9cc5a2@redhat.com>
Date: Wed, 11 Feb 2026 09:46:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] net: sched: introduce qdisc-specific drop
 reason tracing
From: Paolo Abeni <pabeni@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, atenart@redhat.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039506239.2258217.7863252279149995024.stgit@firesoul>
 <f1827414-b6c4-47de-827a-9f9f4c796cf8@redhat.com>
Content-Language: en-US
In-Reply-To: <f1827414-b6c4-47de-827a-9f9f4c796cf8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258221-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,toke.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F34FE1225D4
X-Rspamd-Action: no action

On 2/11/26 9:36 AM, Paolo Abeni wrote:
> On 2/6/26 5:24 PM, Jesper Dangaard Brouer wrote:
>> @@ -593,7 +591,7 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
>>  	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
>>  		if (!q->drop_early && must_drop(sch, q, skb)) {
>>  			drop_and_retry(q, skb, sch,
>> -				       SKB_DROP_REASON_QDISC_CONGESTED);
>> +				       QDISC_DROP_CONGESTED);
> 
> An explicit cast is needed above to avoid compiler warning (or you can
> change drop_and_retry() signature).

I see that the type confusion issues are handled for good by later
patches in the series, but I still think it would be better to avoid
introducing them with explicit casts as needed (removed by later patches).

> Also a few lines below there is another drop_and_retry() calls that is
> not converted.

I see it's handled by a later patch. I guess it would be useful to
mention such fact in the commit message.

Thanks,

Paolo


