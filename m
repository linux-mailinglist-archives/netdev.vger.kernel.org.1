Return-Path: <netdev+bounces-249445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E53D1939E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D607930057D8
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 13:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF983921D6;
	Tue, 13 Jan 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6fyNfHq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bp3GF83q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C673904ED
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312275; cv=none; b=ed2pbHhsR2gz966ocFVI4s8CRM26dqZZo8oanJVyLmnYuBotl5JQJk40zOD/9QACYfNTXPgSgo97lk0a55jYkqvVy1h42s94OPdx+sbvNbUyo5iSU+nhGwHld9XetVDOqwI0FWtCkEfCe/MsxxfW8nERtvpbj75bN6KNgu3Q9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312275; c=relaxed/simple;
	bh=6zhlSPe5qUEBfjygTEoPgVh6sWVTlvmzPHm6Wg1NL+c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=LcM4gkTH5une0yc9OW28PGTPmUiRujPsk66TZWFsj8/dZDI4lRhXk2R1XV+JXMO4UyoyEx0kf5CxlFcE7qRwKEd5G0Bya3FhRaZI/LLhcuX6m8HxM7BZP8/R1StkpfsIBVC2tHuekQeDs2wtnqBarM/IfXsU3qdOeRyP1yqoL9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6fyNfHq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bp3GF83q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768312272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=At1/RjF4BFbFijfNRrqORa/7Mn+9eCaQU6qFZBnQ7YQ=;
	b=G6fyNfHqe62k+dN8dQNkBd44RX7BpNIuTToQTsXK+5hhPw8g1zTJ515iWCNSR1LNRs7syr
	53yvNl22nZ2+Fpfwrf1JhGdG7wCIl0AQ0zSsg4I3I4giYreqrxAK4Qfg49agxwOoA4TzOT
	gRtFpVgbaPrMYOCZNrk1EnJ6e734QQw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-w71Sao3sPv6Wq9xBxomm7w-1; Tue, 13 Jan 2026 08:51:11 -0500
X-MC-Unique: w71Sao3sPv6Wq9xBxomm7w-1
X-Mimecast-MFC-AGG-ID: w71Sao3sPv6Wq9xBxomm7w_1768312270
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so3104425e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 05:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768312270; x=1768917070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At1/RjF4BFbFijfNRrqORa/7Mn+9eCaQU6qFZBnQ7YQ=;
        b=bp3GF83qST7EEk3ekG58WzKWOLyjFAfleif5dSVwIU8Kk3fO7oIJBh+2ol4e7u2Ntm
         7EmrG0bMLzROnwHl/d1AcrFNN1w0stjKUYnkiQZcjPhmvaChZn26CeKn3T4fodYqU5bI
         Cg406q9a0ts5eh3Y2n6IjmN5LPtYpXEUN3+9x/R3/ZfaQ01Njb0ylE3mi8z8Upxv9a8D
         xZafLlUngXZcscQI5OmnU/xiDldEaXeyO1dg3RYFE/pFa6r9JFKycUhwFVwpDXsdYard
         tR86dYH686/1XvF/6xNh5qTrGHewz/BDyQ1eRZ4UDb4boa7VcF1YEWofpGJwB9q2cGBS
         o7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768312270; x=1768917070;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=At1/RjF4BFbFijfNRrqORa/7Mn+9eCaQU6qFZBnQ7YQ=;
        b=dMyU35QlzYRUPwXz3EAEpVCyYHBvuHeU70Jioz9BoTgj/vaPoneUWJLZjpAMj07NJH
         OK3XUamhMu7lgcjxR9yK/pQv5gph9hL767dJu7Q4c1GCO+ZRVr9i5ctlCIhLzoqvBAhj
         oKKWMb+8nDpNsZBBZfk7pFHTZvSPUEp2XFQhHXbLy7lyOgmz7VjLtwwqioRLN8UdWknS
         1Mwesyq1ooFqSLQwtFKQgBqKxCrVgI0XnM/uvPc4ELVF4ObvDcOGhAY8IADepIgqW2FW
         Xj4ZS12XkFDHu5t6B0gPskJR5hzk/W6k4W3kR1brgZHiKmOlsc+eY99TrP6SO/Vixj1r
         dtnA==
X-Forwarded-Encrypted: i=1; AJvYcCWParCclX72Qw1q7AZ29FZxelZo8AMFFRzOPfZHmNmGRUEUUeZ4rkHtuGcpN5OrDC9aPDQdVos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhvhWbSiNHGh4cvARCFe2z521HilAs2t7+18nj329FJcHea/fG
	KxjTnhUFWsCNeo4FJXRpfetT1EF33RSJ5AmdmWTqKYAC2lR2rAwJuQdBojJjrm4wVl+CL5sGSz9
	syKc+Why8oiQwl4kwoE+xik6JPNYJzX0AOjzile/M5V3GZpGh8hs+UiidxQ==
X-Gm-Gg: AY/fxX6+VlgpTQGWHRkk96DQdBqxHnCviKqRnCcUTsilw+MYSWynEsxQzjWp2HZo3XW
	S78znim9+G1YAM9aBVAEVH9jOxYJeS+Ha7zIZK9OMgEpri30A/m3Sb/qzTZWkMH5X0iL13NZ99t
	ZNyasph41YqolvaDLA731yjH3Bp0ibS02U8MTlo1aB7Qp2uOYZc5OUIW59cuGEcVL8IiXWQXW5F
	i+wap/CxaPdAVUIjhk9a19eu84AyWyBAvNhYo14MONbm/EA6zyx55gmSoRnTbhFXAZlVXXVqMC9
	jwp3wZfyIfggIFG4neaOABgQp/+NCw/AkK7C/B0bod5lLQj4CXqO5ulZNd9CnRcd7K7gLl2tJs6
	Z6TxB1SiOMlsg
X-Received: by 2002:a05:6000:2311:b0:42f:b707:56dd with SMTP id ffacd0b85a97d-432c37c878bmr26291378f8f.33.1768312270138;
        Tue, 13 Jan 2026 05:51:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkbP1FJI0V1i3sSDIXcExPcMPatHpMa0BvIzsnUTw/n20jc5hh9jpvC5m1xo48QSSilby1tw==
X-Received: by 2002:a05:6000:2311:b0:42f:b707:56dd with SMTP id ffacd0b85a97d-432c37c878bmr26291345f8f.33.1768312269684;
        Tue, 13 Jan 2026 05:51:09 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16d2sm45791078f8f.13.2026.01.13.05.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 05:51:09 -0800 (PST)
Message-ID: <55e12beb-758c-4f82-992e-e07c9c300d4b@redhat.com>
Date: Tue, 13 Jan 2026 14:51:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: gso: do not include jumbogram HBH
 header in seglen calculation
From: Paolo Abeni <pabeni@redhat.com>
To: Mariusz Klimek <maklimek97@gmail.com>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>
References: <20260106095243.15105-1-maklimek97@gmail.com>
 <20260106095243.15105-2-maklimek97@gmail.com>
 <a9dcc27d-521e-44b0-b399-c353ef50077a@redhat.com>
Content-Language: en-US
In-Reply-To: <a9dcc27d-521e-44b0-b399-c353ef50077a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 9:40 AM, Paolo Abeni wrote:
> On 1/6/26 10:52 AM, Mariusz Klimek wrote:
>> @@ -177,8 +178,13 @@ static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
>>   */
>>  static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
>>  {
>> -	unsigned int hdr_len = skb_transport_header(skb) -
>> -			       skb_network_header(skb);
>> +	unsigned int off = skb_network_offset(skb) + sizeof(struct ipv6hdr);
>> +	unsigned int hdr_len = skb_network_header_len(skb);
>> +
>> +	/* Jumbogram HBH header is removed upon segmentation. */
>> +	if (skb_protocol(skb, true) == htons(ETH_P_IPV6) &&
>> +	    skb->len - off > IPV6_MAXPLEN)
>> +		hdr_len -= sizeof(struct hop_jumbo_hdr);
> 
> IIRC there is some ongoing discussion about introducing big tcp support
> for virtio. Perhaps a DEBUG_NET_WARN_ON_ONCE(SKB_GSO_DODGY) could help
> keeping this check updated at due time?
> 
> @Jason: could you please double check if I'm off WRT virtio support for
> big TCP?

Reconsidering the above, I think the mentioned check could be added
separately, if and when virtio big TCP will come to life.

/P


