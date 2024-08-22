Return-Path: <netdev+bounces-120887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7615C95B215
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EFF286270
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBECB184547;
	Thu, 22 Aug 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDOBDWzT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBEA184532
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319689; cv=none; b=WvvRoyxyh4wzzRE38WI+XscOuCkVFKt974eGjU+QPOY6PPmbsXbqVxVHbD9eCzZ0uInyyNFnD9777PXo0HWky4UBIBkp89D6qU2+n2h/csjnm1d4rbNuUmAaRII1/BpMJN4e1OcV9Ny0H4xFlBgJN1Q+iSvA2EoINJd7xoZNhrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319689; c=relaxed/simple;
	bh=cY6r/jU8/avfHRQyIYXL7Y+DMAxUzeANfIV0IJt/a/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifb/daS3wEqvUS/y+uKDXkCqLHvFt6uzP5mT3PGM1VfkzZE6WBEW94Yn811BC5NtCdBbdVRZsJR5WAxzNXxzD4I9e6XN2pJA8yaGIqB1LN8Ic/8J37/zWJBG8H4VawmQ2VtK5+D+M57WAWBTdDEeNrPjfcZnLyaLS8Ntkpxu07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDOBDWzT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724319687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GxaRbOawPk+hXNsovHT5RrajZTY216ROkj0B4bPLBc=;
	b=hDOBDWzTBKV80O/rx37EIsyLOkTj0emxPdrj3SIpT1xQXFI0Y9xOEGVSRpIC4EcEDtovQg
	U0oEY0HTXoOjsKGQJ4j38sffyij0K1Tjoua10/j1KY4vVJ/9suM/O6qQNcXSJiSPOl5Orp
	fyz5JOyCik9sKPlijJ+a/6W8lHe9upI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-57564ANWM96BUsKllWb_eg-1; Thu, 22 Aug 2024 05:41:24 -0400
X-MC-Unique: 57564ANWM96BUsKllWb_eg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4280a434147so4423255e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 02:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319683; x=1724924483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GxaRbOawPk+hXNsovHT5RrajZTY216ROkj0B4bPLBc=;
        b=gwRMqiCqZcSxDkzsIkJR/Zq9MPG7qxdZ1H9ozNX6Y1HJFUN//BvQ0xwc7JMwsp2ocM
         4hAF8xc2rY/GiGgi1I2F+Rfk4bBDUv/qCCS6d57CHoWCeP/Ja1hyCXupwA7QTMjeKs1F
         MshKJISw65txSelmWE5vo62T19ogdQ+vWU4n9IVDAWWLOZN0CH0APCrE+lel2IrAaqML
         ie5CnpxeQBgxLHICXA7lTdreJqZS3K/3hnrcntIj5hgNY/800OtLrPp2EdR6VaTFAs0z
         e3kB7TZv4i0voAZee93HYAYQp9H6jCaFODFoWghnIAgQg/r5k8PDD8vtJ55L/SAZHRE3
         czSg==
X-Forwarded-Encrypted: i=1; AJvYcCWRoDq6jwYN9bmQ+YItrJqLrKxTdt7atTvMki1YfKIGRFFQt1ksPJ2hmZe/ustaBvtODm+Jyy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDn0KduIfJuan51HYLV8YB8BCWakN6BzagvBWWlFGKsNeBpLOv
	w87HnIkuIDwt/430ela5p11ozhmF7BNc+DwKmQz0TE+D0Mp7ZEd52geiE6+Z5+q5zDskMkTL+CU
	2403pbO2XLvHzOpl7Al5KstYrkmDiYBwYnl+yA4/1S//Hdlk4PbEt7A==
X-Received: by 2002:a05:600c:3507:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-42abf087a08mr29874545e9.25.1724319682902;
        Thu, 22 Aug 2024 02:41:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPysy9GdHmVDHIcKOKf6nja9boOBhVjLAX+pq9YVi6t00mJ/VAwAU2zEsYf3FkSq3cJaFEuw==
X-Received: by 2002:a05:600c:3507:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-42abf087a08mr29874395e9.25.1724319682281;
        Thu, 22 Aug 2024 02:41:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e093sm18449745e9.7.2024.08.22.02.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:41:21 -0700 (PDT)
Message-ID: <f6befca6-4f89-4d9c-b3eb-68e80da5c285@redhat.com>
Date: Thu, 22 Aug 2024 11:41:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] tc: adjust network header after 2nd vlan
 push
To: Boris Sukholitko <boris.sukholitko@broadcom.com>, netdev@vger.kernel.org,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Pravin B Shelar <pshelar@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Mina Almasry <almasrymina@google.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 David Howells <dhowells@redhat.com>, Liang Chen <liangchen.linux@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Ido Schimmel <idosch@idosch.org>
Cc: Ilya Lifshits <ilya.lifshits@broadcom.com>
References: <20240819110609.101250-1-boris.sukholitko@broadcom.com>
 <20240819110609.101250-2-boris.sukholitko@broadcom.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240819110609.101250-2-boris.sukholitko@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 13:06, Boris Sukholitko wrote:
> diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> index 22f4b1e8ade9..9e2dbde3cc29 100644
> --- a/net/sched/act_vlan.c
> +++ b/net/sched/act_vlan.c
> @@ -96,6 +96,7 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
>   	if (skb_at_tc_ingress(skb))
>   		skb_pull_rcsum(skb, skb->mac_len);
>   
> +	skb_reset_mac_header(skb);

This should be:
	 skb_reset_mac_len(skb);
right?

I'm baffled by the fact that the self-tests looks still happy?!?

Thanks,

Paolo


