Return-Path: <netdev+bounces-289473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLw5JjVsDGo8hQUAu9opvQ
	(envelope-from <netdev+bounces-289473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:57:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1055F5801A2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840D43011132
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553FC35202C;
	Tue, 19 May 2026 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0+6MX7e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="okBYyy/w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A484348C63
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198769; cv=none; b=lBDQc8EPKqm0mf+LvRemQ/genW1Tz1CJHymO/Q4Gy7k/iSMEMiufhm9ko2xlCwzdfZz+Jfamte7a++Tpcd2U3MdsPCin6KEK4539MlDHO3cIB5XtpooD6AAl8AaUD/5x0VIFJgvYG3JNvr/U3eqW5J0V+SETwolP4qeXX/+T3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198769; c=relaxed/simple;
	bh=fjL15eeE1mVymbdxnB9yPyK8yGKH3bFOwg2jMhuJJW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABEXqXA292pV09g3Uv7qullvDEHva4eCbXLpVViTbIKgsl4vcLK7Vrq9t505cDvyjbCS3LQpxNJItRtoXVJotzqYGicW4KINGgExp2uH8HWbzxUWRAjk7usZ4G6fCU32U4Kn6xHx+1VIRCS8mH/VakuVtUAp8EF8OUPwQZn2ZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0+6MX7e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=okBYyy/w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779198766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RqSLbICYs5UslkEJzEG05YeBMZbiw0AEShDLHy5iPQ=;
	b=A0+6MX7emFWwJFoeZnyYOqLwR5BMx3c9NIoJ8Dwd4zSJESXr5JBQorIufMRfQ+rs5cA83w
	cnCHfdiCwQRM/T2REzGU92gW+cvokDAFoQpTUEzF9329pOajdUVb82WZBJT1gumkRrv7Bv
	+cbMV2bGefXRPsLAPU+VMgZ2owQWA7Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-HNy3LDKHO8yixD7JSJDC9g-1; Tue, 19 May 2026 09:52:45 -0400
X-MC-Unique: HNy3LDKHO8yixD7JSJDC9g-1
X-Mimecast-MFC-AGG-ID: HNy3LDKHO8yixD7JSJDC9g_1779198764
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a36715dso2285934f8f.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779198764; x=1779803564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RqSLbICYs5UslkEJzEG05YeBMZbiw0AEShDLHy5iPQ=;
        b=okBYyy/wP528RyFkMUScAmVywBKe+j7wx4XxRmHMzU0tx9rHscN/EDlrycuBWGd6tU
         whtZ+cwtNl+KILf0sI+a1qroqlChyYOOrbCWfFzDzQY1bFnZhLBPNNL5A7WblUmIfdc+
         O2RBTqlZi3A1s80CXqvz6GB2UPvGU1Mjv5ARftYCO41/+khbAoQlnrNs8jx6nso5ApGO
         g7XmFj5hKmt8+ny4WrelaWoTgbPtgOwU322kj+l7TtDkZbuPgTtYJg/MFb/kpUWOta5R
         2HCxQ2O9Jmk/o72aEs/RyPuru0R8L2wIfsZaEdMMhtWcwVSnMmxCxnOn5fR0bq8YDIHc
         RRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198764; x=1779803564;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RqSLbICYs5UslkEJzEG05YeBMZbiw0AEShDLHy5iPQ=;
        b=U1lrVzGIM641LXXv2q9Tw9KHN7p1mrCnxb0LqlqwBJwJoCAu8DHgAed134dWtMFX98
         mgsDhW5zwmyg1enlLP2rRJQBx7eqDB4mBotpjr2xeBgg1TBZZApwcJJjFE0+LvIM8/6X
         xjgbZrYygASMx+cmsZfwcf3NHeglNgjOqwJpKQhahJI5hiCzXOZv17bAdQaM7u2L6w/5
         lmsbXdy5CLPcJ+MX+aCDwG95aSNmrlrK+ea/6jKxqmBlzyJjs2vkaqcQNh95tuYza86C
         Zc0nH9oYYYsvaDD7jYrNFUSBCQlLfn+s/aeLtwITbeS8jXav9PKqZwWWq1d/H7Wby6fJ
         000g==
X-Forwarded-Encrypted: i=1; AFNElJ9DUloOmSzyi4xbuJzmH6VtLcxhjyo0ioo1QKrJdmQzUUwTmrvlOtCsDbmM1VDKfdoK3q2a8ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MkDMgzHUHsA5J8hO98rjYsJttmGXYvPOGFqBk1uiTvNCkmiY
	3L4Qcim1pHsAWb0QA4+1ubpFHAqHvmOg4psGbPtMhWVsid6IYa4/iQfw4WmkpTtL9UqdhGk3n2+
	KYU43VJOgX/Ce7sX6s9CmchYqJg6TcWJOzi++dfpPpKJ8lVLYuQG62LCJJQ==
X-Gm-Gg: Acq92OENfHaPjpynM1CpPquygp89pc3gSDvlcr0618pbUmYH83kBJPOUK83ohrThMmz
	EO63nKzIldV+1jYnc3BGZoXGuSVopYHnfoPbtv2tPRPyTasUXnChWdHgqxzWzItKvKBh3DwDW2N
	geTJd8Ua5coBX7fmpDQVh2yqJ8h883gr/hmesKnqFY6FIrj3r5MdpXZcahbo997zYXaRLk5qsA9
	BRj4yEec/RrFZCN7vcK+9ilb7VHVcLcBgMONV2NW5XAnEvWoStcFxefwP2EOd5LuQQAe8o1mMhp
	UHzFeGObpkP9ZtEIR4CksKUFjMwPbmSlrLdV30lpnd2nUD2S1eDUtEmmdxH+LrQ8qQ9ER5P/93l
	mJPVbIChGTT2zJwy/DNddpaVN5SSCgBWGSYMA7Wy8ZePw4wqGMsM30JA=
X-Received: by 2002:a05:600c:6211:b0:48f:e230:72fc with SMTP id 5b1f17b1804b1-48fe663152cmr309169425e9.33.1779198763812;
        Tue, 19 May 2026 06:52:43 -0700 (PDT)
X-Received: by 2002:a05:600c:6211:b0:48f:e230:72fc with SMTP id 5b1f17b1804b1-48fe663152cmr309168965e9.33.1779198763317;
        Tue, 19 May 2026 06:52:43 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm46328684f8f.28.2026.05.19.06.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 06:52:42 -0700 (PDT)
Message-ID: <d82b01bc-21b8-4d15-a8da-9c2251168f92@redhat.com>
Date: Tue, 19 May 2026 15:52:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: neigh: Rename
 NEIGH_VAR_INTERVAL_PROBE_TIME_MS to NEIGH_VAR_INTERVAL_PROBE_TIME
To: qiu.yutan@zte.com.cn, jiayuan.chen@linux.dev, davem@davemloft.net,
 kuba@kernel.org
Cc: dsahern@kernel.org, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yang.chuan1@zte.com.cn, huang.jian@zte.com.cn, zhou.shizhen@zte.com.cn,
 zhang.dongyu1@zte.com.cn, ye.guojin@zte.com.cn, yang.wei20@zte.com.cn,
 zhang.lin16@zte.com.cn, li.hao40@zte.com.cn
References: <20260515150957697xaYiRGPGH0ylFETfsr80O@zte.com.cn>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260515150957697xaYiRGPGH0ylFETfsr80O@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-289473-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1055F5801A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 9:09 AM, qiu.yutan@zte.com.cn wrote:
> From: Qiu Yutan <qiu.yutan@zte.com.cn>
> During the initialization of arp_tbl, the enumeration constant name
> NEIGH_VAR_INTERVAL_PROBE_TIME_MS in the statement
> arp_tbl.parms.data[NEIGH_VAR_INTERVAL_PROBE_TIME_MS] = 5*HZ does not
> align with its actual meaning (jiffies).
> 
> Using NEIGH_VAR_INTERVAL_PROBE_TIME is a better naming choice.

Please read:

https://elixir.bootlin.com/linux/v7.0.9/source/Documentation/process/maintainer-netdev.rst#L419

I'm sorry, I'm not applying this one.

/P


