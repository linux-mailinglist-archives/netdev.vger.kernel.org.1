Return-Path: <netdev+bounces-258222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPNYHvZCjGnYkAAAu9opvQ
	(envelope-from <netdev+bounces-258222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:51:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A35D4122698
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39CFD3019185
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10402353EDD;
	Wed, 11 Feb 2026 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GErlkgF5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFOVYaPG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7F322B9F
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799859; cv=none; b=fIksGUepW0YcY2tOjXJp8cXgfCSGAhZIrC0N8DOwMuQ+Vp+481f1sl07rcQ5AiDcA0+9P4IPM6vixMCG7oCCs3VEBgR+Gn1NADEhSAgBUfNj5LmHKVyY9B87VULTyVB2eBR7989vpH9SKV7FjNla4RxPxJ5PZL5/noAWrM21EcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799859; c=relaxed/simple;
	bh=E7dZn11UnsXXsFzX/ltgj6TrTuL6RFRnhzRJQUZKAYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCHcZ1fODJtQrRUfgMnLEOXPDSiRKPHHhp/vaSqJistwpXXyIkewtAGxlj5Cs0OA1dGQbf7OeXHfc6SPE5asRAnaCVHfA1EKwbqoSnqmq6XCe38pkAAVKVJq2eHA6lVXI+Le9Zt6BgEuq364ZAmAN5LRTOLnVuTC/D9PaMUznWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GErlkgF5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFOVYaPG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770799856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+yV3LiHwvo0TdX0nZb4kx1fDWzSnhxc2PkisRPoz5g=;
	b=GErlkgF50IsBRLrKEEo8/qRM6H9m2t13xiJX1nIBzyx1eqGW4Ge4JnZ56UPPd+MDSR10sU
	w9JYkn6IXFPkpvIS5hAHv0LvrDKPUFsuTPUY2P/aviWaCkYVDRRLmrulwp5zx0I8XLIIJc
	K3mOGtXI/A5htStFKAB/hEpjmvJp4zw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-kc5ocYnmP2Sz-hc7enEwxw-1; Wed, 11 Feb 2026 03:50:55 -0500
X-MC-Unique: kc5ocYnmP2Sz-hc7enEwxw-1
X-Mimecast-MFC-AGG-ID: kc5ocYnmP2Sz-hc7enEwxw_1770799854
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4376761037bso415530f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 00:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770799854; x=1771404654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+yV3LiHwvo0TdX0nZb4kx1fDWzSnhxc2PkisRPoz5g=;
        b=BFOVYaPGOj1wg83jwlQDQAbjj8N39QHrRcjpI9Vmp7pXPTZw36TJDRcySQ4Zutslg3
         0LYmVnpWqX8YpKrI5o4mpXS5WT7h5ITMmGB09d3UuvEhCWK9z5qp3lB12auTJcHcOpxW
         L63gxOZ15LHpGTFhxZKeyCucbbOWtqJwXe8jFatQxsBAzcbm1C67r0tjuFHj8JR30Kvm
         SA8jeXUnVC9u9vjaPbo581odpTNTNdTLAVCzL2kR32POudrYNw1QgbVl069VzpuV6pO8
         /v/Zk6kdDK5+0K6fJYRC3idCFUIbwoqD9+5YfGdFGS0IgcZJAXUdcK2H0/GGr/EoM+vC
         ceIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770799854; x=1771404654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+yV3LiHwvo0TdX0nZb4kx1fDWzSnhxc2PkisRPoz5g=;
        b=NCpxz+2QuVKPX1MvJ5cMXLp3QJlWVn5wbGxO/uqAXW8JRsdZoa+nD/ZVXOWtLv30ZS
         uYVqG4HLyDCIiFag+EFIubUHIJByaRh2eZM14pL1wcfsW86fXexEsG0RX0S1gGL/LHbd
         jgBRy9pgCmHL07vW+wxV0+IG2o6+VikoCcWEmxdJxmU/U83Rk9e+csZwleIVYKWpA21P
         ingd2dJS03VEDJ5F0hE9vnUwHJPa/Wj4OICHAs66eR93ztPuJFzq0e4h2udE2I8AtpET
         hp5jJOHt9BLL/EyB1Rx9b0oQXmyYJf2RtWm8o1E08YCNxVrL7O+l+47A4ErYR+3hDtOR
         Rv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBs2zZTmnbyUv5favDUnwmyJ8+u1u77jAQtO9qADlLfn498AR/hphSeynaAXrKInvBB9gZPOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWs5zYp3B0cfqNvGNQ9URAsJGFj7V24gREYZoH+h/vOPHriNuO
	66GdT4iNkkx7ufV5Nj5ZG1aPxnH6TNR5ZExPCrhGQ1d52JnCRPHQjrFwjWo0GJODn82DNUTn70h
	wpUTemMFGRz3Qx4Yr3tlBLYhPTjmoqMDBY8WNTBGgcy+OnY8bculUpxGOdA==
X-Gm-Gg: AZuq6aLgdPomowGs2TnZ/Kmn30vDjulBCN3zhMp1evmKIN6juZsLtloziug7lDvhjRe
	2h5cndfo4IBxeOoFvLZgNPrmkf9wLWt90p9oI66O6Qo18GzmlATwjBkzov1vwmy/hPiAzFRYobB
	9tbGxQ4mRO+aoaGdmY/rlAc7zcO8WDPTR+DIcc95+AFOBCAfyfRYLWEMUasF6qubbDCO7gZEIQc
	E24hGSa1u8/aED6NVi7Bv9ZoaJjWV7DUL2MrkVFZ+RB6Uvy+1E2PMG0EwqElP2bWwkTvE6mEoqm
	UUzavuyfm3IRbx69ex2XLnuz3IerGM9eybn5wv4Oont1lqKQyhIZHMbUkGUwMSv3pZ56K3sTV3X
	49RiAo/ITAGasTrFP8aHYArxPmw==
X-Received: by 2002:a05:6000:40e1:b0:430:fdc8:8bd6 with SMTP id ffacd0b85a97d-4377a20004dmr8338969f8f.31.1770799854196;
        Wed, 11 Feb 2026 00:50:54 -0800 (PST)
X-Received: by 2002:a05:6000:40e1:b0:430:fdc8:8bd6 with SMTP id ffacd0b85a97d-4377a20004dmr8338919f8f.31.1770799853750;
        Wed, 11 Feb 2026 00:50:53 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc8b9sm2993554f8f.24.2026.02.11.00.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 00:50:53 -0800 (PST)
Message-ID: <36d9d3f0-2a26-4b9c-b6b6-f50610fbaa31@redhat.com>
Date: Wed, 11 Feb 2026 09:50:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/6] net: sched: introduce qdisc-specific drop
 reason tracing
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <177039506239.2258217.7863252279149995024.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258222-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: A35D4122698
X-Rspamd-Action: no action

On 2/6/26 5:24 PM, Jesper Dangaard Brouer wrote:
> Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
> for qdisc layer drop diagnostics with direct qdisc context visibility.
> 
> The new tracepoint includes qdisc handle, parent, kind (name), and
> device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
> for backwards compatibility via kfree_skb_reason().
> 
> Convert FQ, FQ_CoDel, CoDel, SFB, and pfifo_fast to use the new
> infrastructure.
> 
> Reported-by: syzbot+ci335f183b8446659a@syzkaller.appspotmail.com
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  include/net/dropreason-core.h  |   42 ++----------------
>  include/net/dropreason-qdisc.h |   95 ++++++++++++++++++++++++++++++++++++++++

I think it would be useful to add dropreason-qdisc.h to the net/sched
maintainer's entry.

/P


