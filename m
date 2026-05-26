Return-Path: <netdev+bounces-291641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNNdM691FWrCVAcAu9opvQ
	(envelope-from <netdev+bounces-291641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:27:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3235D42CA
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F5AD302A2E5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B7A3DCD83;
	Tue, 26 May 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3faCngs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rb1YXpzq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6423CF699
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790969; cv=none; b=n4VsRZG0JIJBhWcK+manCSpaI/sDeGRnPBU4Rra3DfHjclTapXBYy6lfRjQMKWdIQop5mU9xyr89tE7lCY5KfFFh7IpycrVJiFME82LOZSOf7N2CaInl905VmbMcY+wmqUl/em8g0uTzvO8MOodydVR9Ql5fDWR2QExFsS9Cohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790969; c=relaxed/simple;
	bh=hwh3B6/puad1rCmOYcUBON3492pPHvci/7pX365vmes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CteHMUS91UF975a8UyFhYPTtqyu0oMRCZYaFBjwXnRzPK+CZobJ1E0zRqBOcFOK9MGT2eKqsGaz7w9POrTiftRcfn/NvasvdmIwL5lyIBV4xeHzFuy1iMfB2J1rh7UrIcHhsgyZktvGM6vxax2xuNwZDUNhHOGGIasR7QB8BX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3faCngs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rb1YXpzq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779790967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fy2dkBwbMAseBkbcRQehUKk5GPec6RoU2Jo6UlJsQ8k=;
	b=G3faCngsrkqeQqSqWUofxs4afb7JgUHT886+OEwfZROkVtO6EELVLunMKY2rT8FxHwrHvZ
	T/so7zKq2BMASDCorOby2cpg13JWf1e7FeU+RROAigqTiybIHtayqZvXIVksfNbsmAHYoK
	5EPutZCHtIjgtAKx7mqAZi0+tt5rORE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-fm_wIiioNZ-uCZoaFRH5Sw-1; Tue, 26 May 2026 06:22:46 -0400
X-MC-Unique: fm_wIiioNZ-uCZoaFRH5Sw-1
X-Mimecast-MFC-AGG-ID: fm_wIiioNZ-uCZoaFRH5Sw_1779790965
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48feb0298d7so83986465e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779790965; x=1780395765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fy2dkBwbMAseBkbcRQehUKk5GPec6RoU2Jo6UlJsQ8k=;
        b=Rb1YXpzqCUE2RoDCacVzBV7bJxQfzV0FtPcXKgB59fQFQP+njPKcEAiWuhERoJcHef
         HTw0DIDT7uAwzNLymtUb8PFGWxhdmW/t9Ts8P+dFUdNQNhBhdYY+ziTCOHMOsEbclZkA
         ZwTe2vixWi6suaQA9K6znSZ4BrqqQ/xBwP+UCk1SeNCZhw9AeMw1/QYUEwsmOsNlxo+x
         1CUV2iUATX/mI8OyBPdEJb7wfwFidfmspNdXcXBMV0auNWOLFUHk6ToKGum3UDVuCkkm
         00P1jD6AWUCdJCCXdVUJGaaemtC8Jq84E1CKY3f2CjJbWQXA90M2PExSC6Tmmjv4BqS3
         Q3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779790965; x=1780395765;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fy2dkBwbMAseBkbcRQehUKk5GPec6RoU2Jo6UlJsQ8k=;
        b=b9ykzemDEFGT52wXFRW10ahHgnyfX36FhxVa4VmJ77cZ81rSZRM3PL0ttRkwwSyxZh
         I8rijkc3APDj9wagiWgd0+mNYeFer34zBkaoiuXIGy/1kDvn2uEi6eywOIMo5/+AUPQl
         7fwdebN0PiV1oo5caP8NAv67cXih41f5XPjruXi9jD89FiaRN0tSaq0uzm3JxwvDI4FK
         DbEMqnILmb2OVh/iZIEVKv/XRqh15Yji4t6fvZNme+BdfnomCRftlzsiMn1KV1jyEy4o
         Kkc9bnue6W4G6EBS9j/gYAs/UoFkU51NPnnHEb9X9/LfmDcu69WjR/RFElxySLN6H2FG
         lyMQ==
X-Forwarded-Encrypted: i=1; AFNElJ//ZYAqKdbNnQK663CdrzEKwSSUuS/lBus/FUbdutcPdc6G7t3EBt2TGubw8NOAmi4HhuB3yTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9XhZJXQ9TaAB6Po7dPGeVlpfKpF3UpSoEnlEfYlIA7VpKwTG
	LKWP5cDs5QIaTGyzRghNhYcdhq4Ni/V6lrYkNavKuIVWnOUUHMb8PjFbka/SQy83BpzXJRZVVMw
	yQs6C+ZJFHbdkLrdw1vcH3qLXj1ikTSgbQc63ugSTc5xJEWXZ6D5UKmst6oVHUzPj/A==
X-Gm-Gg: Acq92OGLN4vB1YH+h2ernHHbrZsPVhgvDKeW8YSusLIfmftChuHOBv11ROwJcUsiiAg
	YJFQtaAaywrMoD+Tq373H5DFYWnsO6EFiGJlpzD1legh1oHqCSAXmWTdCmR37IgbgEEFVlDxwAo
	w+1j6BOK+OnUuAKNHvJ5R6rVNqCuJvRUKdPR/OVoCNKB14/uOr8h8sI2tQtu54ZS9c4U10+4WQh
	wqABA0c+KhzGp3tA+lh8h2k1lX6NJoYzFEYdXquN9S5utYQQh2xkoCE5WX1+2rVEw5JCE0Ahb5V
	bi6GbgpgKXXK9Cx4wpVvXy+hWoKQ4zSVBgXkOvBUcQcR3O3s+2HeEclw2TgMiaFg5pyJxEuacDL
	zjWaZ9dqk8CqfhdDKJkhwkMKtcqbpXg29U1W8l3fi5ji8cerb7FHKjL+P6A==
X-Received: by 2002:a05:600c:46c6:b0:490:4927:3777 with SMTP id 5b1f17b1804b1-490492738a4mr258449335e9.2.1779790964923;
        Tue, 26 May 2026 03:22:44 -0700 (PDT)
X-Received: by 2002:a05:600c:46c6:b0:490:4927:3777 with SMTP id 5b1f17b1804b1-490492738a4mr258448765e9.2.1779790964516;
        Tue, 26 May 2026 03:22:44 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527dbf3sm300099625e9.6.2026.05.26.03.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 03:22:44 -0700 (PDT)
Message-ID: <6e6a0129-ad37-486d-83e3-8914509b76b7@redhat.com>
Date: Tue, 26 May 2026 12:22:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] Remove unused support for crypto tfm cloning
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Dmitry Safonov <0x7f454c46@gmail.com>
References: <20260522053028.91165-1-ebiggers@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260522053028.91165-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,zx2c4.com,gondor.apana.org.au,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291641-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2E3235D42CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 7:30 AM, Eric Biggers wrote:
> This series is targeting net-next because it depends on
> "net/tcp: Remove tcp_sigpool".  So far no commits in cryptodev conflict
> with this, so I suggest that this be taken through net-next for 7.2.

Makes sense, and series LGTM, but waiting a bit for an explicit ack from
Herbert.

/P


