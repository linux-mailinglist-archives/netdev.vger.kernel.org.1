Return-Path: <netdev+bounces-258066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YES1Hlkbi2nSPwAAu9opvQ
	(envelope-from <netdev+bounces-258066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:49:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D280011A642
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF1C301CCC4
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A7F3242DF;
	Tue, 10 Feb 2026 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wv/b6HR1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pWilL2Vu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6CD319858
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724182; cv=none; b=N2koOJqKHK7s+Sp3s8FbhnIUQvEL0EAjo4evtoF8In9j/76+O3OFTRNHaqCmpcXitUrnx7l97Rtqqk3tYNt6Lsp2Ki/oQ8WdZMkfW7puG5xsmqQFpZw1CFzq6Dke4iQsIwY5a0ttL7NiIWckNJsbgVf8B+mKKtIor21Ih9sJ/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724182; c=relaxed/simple;
	bh=mrkNb3rbgK7YfxAuoJpWlRE33I+PEErjk6Htu3RLU80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5+3eqzx5qN2GX1jQXB4YDNRV5wvZCGSN5rUExuzwGC01woWV3EoQGTp0Z/TDTRR+g2xqDw2VBk9D4iw2iT9Ikex4sz9tDSn1ta5biBtKOYzcVoqJStmWjacq3YXB/bJcFhcIy9r6TTaK1z9dbpEtuZbkDexMAzKIIKfHObneyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wv/b6HR1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pWilL2Vu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlzQkM6TK6bLR0L/ZsqhZZas3Rl/gzbWwjZgTp29r0s=;
	b=Wv/b6HR1FvQRnJ0KRrubi8HilG+mkKKHpJ2NPdFn3W8+z4DKx3MQb8lMAkJxgTGg/e/dy+
	gCPqhJraLC+fqiCMrn5D8uuZkL1Kz+PRDs4qEgB1EuyGYCVMHy1ZP/rPQhrpWIQz8sHzjV
	+yaCmZ3lvNd1yQCrIWIFdEREnfx6gpI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-8wEtW1kUOJWJ9dYnnegbqw-1; Tue, 10 Feb 2026 06:49:39 -0500
X-MC-Unique: 8wEtW1kUOJWJ9dYnnegbqw-1
X-Mimecast-MFC-AGG-ID: 8wEtW1kUOJWJ9dYnnegbqw_1770724178
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee056e5cfso50491265e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 03:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724178; x=1771328978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlzQkM6TK6bLR0L/ZsqhZZas3Rl/gzbWwjZgTp29r0s=;
        b=pWilL2VuxE4NtQqryo73BE5T0oaGi1a5KO8gKIsRYhQBK56+esUFIH0X6hy59AkZzu
         kBhlW3pTyi+wqu0V6J8Z6bCDItrdUHnYg4+9rWsyibHuI/ysFzG7CK9PbOe498qvYZnP
         W9f5FHYwhbqqLkLvn6Q6vNWf8mfNMZt3U14bIlOUacWOuAp3wWZwmyk+lnBB8vsdo04s
         kSYJNiMK50RAMDba4C4XSdUxovkuhgXvfVpGwse+56znW4zAll2wJM/IDfVHPEdHRj7E
         ecIfTanBCIbCZ4DtGxXrKI3sBuhgmU2SsFXIS7aRzWZf8AdP8PRwbeqrDPNcvr8s8YbJ
         +vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724178; x=1771328978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlzQkM6TK6bLR0L/ZsqhZZas3Rl/gzbWwjZgTp29r0s=;
        b=kJvGCoxCyf8vd/WJ5Lwskk36Kd8iz72Xw0VB2jl+R/OrxYp9/Wzspod0Xl2XdKxWoN
         yIqq6XtARjIujNtUZtg4Zwj92j67n/y3crDB/MH2CZQApCeeRVqBAssaYcOMD1hiiuZN
         bNLF+5QStb3gnU9NagdsFu0B7Gt0LSI2QI21cRRpCR57OLM1Z3Jn+das3GMMB8UrXd1/
         RX8T+NOXeFq07DElIXaWk28QDSV2sMOJ6Q8vkoqoNM9sHstJy+9QBgRbs69wZLAk5Liy
         Eo6S3tnp1us7fDNZu+eDw/gnvCJdEPGJUcUEab2MhgayvyOZZhh92A6VBHwFf+U2xjao
         kN/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFJqz295Ww7gl8rpG4abn4W3FRb1zoDnrOXVunxCo4kAtRD0vEXDoOz2ZWGhQggU8ppiXUxt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbuyElFOt4gri/RiiZWkyi5UhRGz2ywdimUS2ejae65i09IFBz
	5IcCeeiGabs7O/ckKG/j9mGREXLHLomPqHVDv268D89SShkTHZsuYlNqrHm63hWnf501CSD486Y
	4/QVrWNjI40o0PM9okywEwZTpvjjV8zfk5psr4v+qWIy7nmYAYKUcSNFupA==
X-Gm-Gg: AZuq6aJ6JCbMsRYqPLMvRUtREzy6t7drFTKZDNdz/LmbP9KT6WmAViIsDSszdBxmSox
	ug0JHy+lfyERt0QQQAG+JZDSqRH3asomIAIu6MtIH+KoFpmGb8s6CA2FIcn5jyqi4UryE2l2/fa
	4bAfxbQjMm4HvxSLYt3nmq5mAciUQcDt0c7Yzo42UGb7FGuvrNWyEO1FYxSz1n/1nq+TH4hhgyX
	yvajZpoCzRV4cotfNnlX8OvVlmkRMJX5gqrtze6tfLHBKAX1JbirSHjezjezARHsf09/7GPTsDM
	fQ29dGcqB+yFAvFpNLHnYchHfLMtj+TCVe7Jv/PTyOTBvB5nC847EoVcsb0do0YyoOMTlGb89F4
	GdqMTYfK9TAy3Ofdwn7t+TtE=
X-Received: by 2002:a05:600c:8b12:b0:480:4be7:4f53 with SMTP id 5b1f17b1804b1-4835083392dmr29281075e9.31.1770724178299;
        Tue, 10 Feb 2026 03:49:38 -0800 (PST)
X-Received: by 2002:a05:600c:8b12:b0:480:4be7:4f53 with SMTP id 5b1f17b1804b1-4835083392dmr29280795e9.31.1770724177867;
        Tue, 10 Feb 2026 03:49:37 -0800 (PST)
Received: from [192.168.88.32] ([150.228.25.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832040a3cesm190456925e9.3.2026.02.10.03.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 03:49:37 -0800 (PST)
Message-ID: <4d02b8fc-ac17-4fd7-a9dd-bff35c3719e4@redhat.com>
Date: Tue, 10 Feb 2026 12:49:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 11/11] netfilter: nft_set_rbtree: validate
 open interval overlap
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netfilter-devel@vger.kernel.org, pablo@netfilter.org
References: <20260206153048.17570-1-fw@strlen.de>
 <20260206153048.17570-12-fw@strlen.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260206153048.17570-12-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-258066-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D280011A642
X-Rspamd-Action: no action

On 2/6/26 4:30 PM, Florian Westphal wrote:
> @@ -515,6 +553,12 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
>  	    nft_rbtree_interval_end(rbe_ge) && nft_rbtree_interval_end(new))
>  		return -ENOTEMPTY;
>  
> +	/* - start element overlaps an open interval but end element is new:
> +	 *   partial overlap, reported as -ENOEMPTY.

AI noticed a typo above, should be: -ENOTEMPTY.

Given the timeline, a repost will land into the next cycle. I guess it's
better to merge this as-is and eventually follow-up later.

/P


