Return-Path: <netdev+bounces-290096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIJgGFQVDmoW6AUAu9opvQ
	(envelope-from <netdev+bounces-290096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB4599396
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B47530041EE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE03603EC;
	Wed, 20 May 2026 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhjSxy3g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnlL/mqq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64634D389
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307858; cv=none; b=lpIb2Q+MDXWHAkb8vwNWViv2NuBgHbn0dWTZ6APTwqVI4yxmn84dYx4QnUVCShBb9L7VZ0x0DtGAuSpC/cOG+JDqNffN1OAcWdrx/k6Yb4xq+DPr+AoBX+X47GOyO5rROAPJdzPaO8X0gxbUvbaqxOZtnnsVtTc915T37SU4FJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307858; c=relaxed/simple;
	bh=ZdMDSum2fLmV8iWDq5qxDcDoz/oZS9PvDRc4JjIsnaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adtZcVlRKR4Hl87tjtFiCCEC5eUMDNgY2NZm/dPIhb1Q/nxOYT1Mi50DZp6nK0uhxXVdxaR0Dcuo34Ix0LhFX3+/hmc56KedlosEZpOo5EnmJZ1dPBFce4m1FWN0h6koGDhR1zwumVg7TLH3Rg8/KeiqDBgZERLjhc5YoWgm9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhjSxy3g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnlL/mqq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779307855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRqywKVS2tXBr8rISaTRKOWRf9iPV3/9Bp/MWNx7rWI=;
	b=EhjSxy3g1wJKppQ3bMHTJ2yvP6gS9VQIOxnPiChqzus/8QFv1kseNdqwBm7RXNWPwF/R2f
	f1voZ6coSvXz6XqtKXaIMB/1NrK+SlydQUUtCqHcaw9tsr8tKKpVGK9W8tfc3NHmvMiqFL
	wAgCYCqp9l26uMlPakoBAX7C6qtH9Oc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-GytYJqQjM7ynBqcK4I6zvw-1; Wed, 20 May 2026 16:10:54 -0400
X-MC-Unique: GytYJqQjM7ynBqcK4I6zvw-1
X-Mimecast-MFC-AGG-ID: GytYJqQjM7ynBqcK4I6zvw_1779307853
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a589c7879so40846545e9.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779307851; x=1779912651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRqywKVS2tXBr8rISaTRKOWRf9iPV3/9Bp/MWNx7rWI=;
        b=cnlL/mqqliKCVyvFXQAsG0x6AIOoWiu53Y9tj/pjQzLwx72SJz5uOsvipr0fU/NchY
         p0W9PpegjvaZYB8zkW9qLx3J9XKvSMjjenz+5MBETwwXECBCfw5Cr3n7B4Im731uHZwR
         9YKS1YL3CTymVM2N6jiVcVCOdZdpvL/OL5W50xf809uN+uxtwzcu7zOsfaVBoRWTILgQ
         Gc7FTtvFo0uqmdjCBEiBqMwICFjCwmbJ1FRRM03KZq0UhwFS6Zx1/KREq6YS9zIccOmd
         HD3EdtUu4JhR1TrzmkXy4J89M7za3ak10mjweNvmL5JmLa4kQw8GuTk531CfbqJ83ReI
         JNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307851; x=1779912651;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRqywKVS2tXBr8rISaTRKOWRf9iPV3/9Bp/MWNx7rWI=;
        b=EbH0C9iwcqMEvp4mWGHvgecw01Eet71GoktHX8M3nUGR9Rc77Px2Gmr7Y6Q/mmCsBY
         E7JlRn66qXALNp/bOAG0drkoF1xr36XFG+HU3KyoAoSqrLzIcqCoBqstvZ+zkjDwiInm
         QmWxV6njAfQ2xdm3jCCOQQjd0jGYz8um4Doz47cGe4tFE3gX8kEOkVEcnpW7jWBv8tRL
         88vZKncINWPLms2jJCqrw1q8Tm6rjdLH5OJjJQKcpLyFR5uarAhQKpx8AxQ/zro+DgFI
         aW/11AITn0jukvOr30MSzjXhnbYad5JpmbjuvGeebmVlvZ8rer5HhaEyrvhcp78XCDBX
         Eq9A==
X-Forwarded-Encrypted: i=1; AFNElJ9yfodwPqxxKO+dOrtDvn1WBhz2iefdZhr8WjiWe5TnF08/C0dYzXfcBna7qTaxlHp7kd6n2+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz/nS/uIGEPCNInaH2DQGg7MFuM8r51DksUljuNB0PX8546a7c
	k4yfXBYq1E7jnDufMdh4AQdq4Rz2NJE9NMvIo32R+koOqT/tXX6wcfcmNMZ8XEW5F4wqc4RGb8h
	ZCMbS0vzCQrh+/5lU2IDPLbzb1N4JZmQSDD7OcmdU/Kluin55S3iXAcVWuLTjpxizIQ==
X-Gm-Gg: Acq92OG9HMMy1lThJFglQNv3cjd7x3cT6YQXaM/FWXmI32u/Db/SWB2C46YzTBHAwm2
	6zkdafVu+PQKCa2g/5Sprf1Yuw0/968r0HkKqIEu6AVSPwv4jzVp9ndo2csC0CJ9+Q+VkQp4e3Q
	CW/jBs/0TYirsaWzsW4lCPGuMSqjKdaoqej3ca+vE06tuQ1EXcTkYPPJZ7zfyuHW0MqgvSSR91s
	yxtbpKzkVybyiJtQRMA5S47sHHXOuWLile2gZVWo50mMshq9gh3FBmi9zX7VgCOYiAwxgmWSRUn
	KmzRAQkWD5M4hX0RxMeZbdx3lj5KcIZVALZDo+fNAFpGj1hQep8OCEIEILbQPygqkHAXFIzSiGS
	OoexJMyI3JvtvftFelSjOiXTctJLIYAzSbqyfiz5YK/l2gf7EkyUjDQpGaA==
X-Received: by 2002:a05:600c:a106:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-49033d0005dmr8570475e9.2.1779307850736;
        Wed, 20 May 2026 13:10:50 -0700 (PDT)
X-Received: by 2002:a05:600c:a106:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-49033d0005dmr8570335e9.2.1779307850176;
        Wed, 20 May 2026 13:10:50 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d3515asm17272095e9.1.2026.05.20.13.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 13:10:48 -0700 (PDT)
Message-ID: <b1ac44bc-bbd6-4f59-828d-74a8d266b90c@redhat.com>
Date: Wed, 20 May 2026 22:10:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: gro: don't merge zcopy skbs
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Huzaifa Sidhpurwala <huzaifas@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>
References: <9f5afc14ea4ecd22c70d6eaf279a94d10fe29448.1779289597.git.sd@queasysnail.net>
 <ag4PGDC8ZjtS9z9C@krikkit>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <ag4PGDC8ZjtS9z9C@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290096-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0ADB4599396
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 9:44 PM, Sabrina Dubroca wrote:
> 2026-05-20, 17:18:37 +0200, Sabrina Dubroca wrote:
>> diff --git a/net/core/gro.c b/net/core/gro.c
>> index 31d21de5b15a..b22fb3ba7061 100644
>> --- a/net/core/gro.c
>> +++ b/net/core/gro.c
>> @@ -109,6 +109,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>>  	if (p->pp_recycle != skb->pp_recycle)
>>  		return -ETOOMANYREFS;
>>  
>> +	if (skb_zcopy(skb) || skb_zcopy(lp))
>> +		return -ETOOMANYREFS;
> 
> Ugh I need holidays...
> 
> lp isn't initialized here. Sorry.

I think everybody prefers to have this patch in tomorrow net PR. Please
post a v3 ASAP, not waiting for the 24h grace period.

Thanks,

Paolo


