Return-Path: <netdev+bounces-280817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDLkDfhS6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:12:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C54455601
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FFBB3053CFB
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1317387575;
	Thu, 23 Apr 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiiyr2dP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6472D836D
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776964027; cv=none; b=LTC8ULIJeeF6eW5TbGiaiR8cWQKCCzfkLxTCDsU9gcgrue02NNdJ+XUIZeVHjyu5Ke9Sv/JUqsMD6QRqwNuKRkNQcvBF3AswrOvo8qUVjVlx5zIHnAvPXdS5mfpx0Y9W5itBll0glvx3aS6oFdKVK7UsAwEDq+4Nb9doCCywdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776964027; c=relaxed/simple;
	bh=L9Rbuj9EdDfplgkFvwwoY2hCj8vY3nCor39jhMt5mMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKGEO9u0/TdTb9YtcCVbINyOdx7jc8hy5W3tL0gM/MZC48zCOm2pEiwLG83LUQLpad00ohLs+1UjxLLPHTE14GS2PM8uTe8ZKeIXvbvmgOvM5KArjZtut0JVTBNsOpXhBBdvQ5GS8TA/DHo4MYdGvnvthTsaAPpLpJ9Td+qm4UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiiyr2dP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38e7d983f50so77667301fa.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776964024; x=1777568824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVhi7luVPIHXGaExWTg62swTtsMImvPn5VkFr/s7rfs=;
        b=hiiyr2dPucBZEOw0Z3BL94OX6RdqCra4OiFo/SLz0voK2OzzPyq1gu+rQ36O4YZfg/
         qIKZBsDBlhTb6Rv61W4Pg+WsgdS4fEOHFFu5YXiIT+aBaOOUIZSAksZOuETM5Aylxjhl
         OJwSqkbIgrGHY8DsRldattn/XEd2IwaUwH4DCpllod0vRGDqeIR8bmnlDGyaZy1wc3CA
         A+NKCkiIHtKzSibXL9FaKqMbFOFX+vkYZtR8sxLZeHo/EjPKm3ztX2uoPxs/3lORr5sI
         tLpVDqaRNKyPaAiSEDejv8iPdhskejvTbGFBDpEsIIhE/tD5IuIDyCHtwJ5P6Z7nYJ/j
         tfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776964024; x=1777568824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVhi7luVPIHXGaExWTg62swTtsMImvPn5VkFr/s7rfs=;
        b=Bn76Wr54E3HfuUlxnad0LKjYQKJhy1I9kpMVzjC3yWJO3rYJeqIdwj4KP72iDAeQV0
         jsT1iiwQ+jn1SUdsHr/n5QR2FVSCw/WqZvQF4jpA07El+b3Rs5mGyHJRTiHU6iKmrUW3
         jZBlFxVDByEmsCk50TwSbeXFgy7OvPGMLalGpHySnNWZXDe3A8i2sLQDFfD/EM5oNhdt
         3oVzC4ho76xPNLxH50szwfBbHY8xH+G/qJBDFAuJSOcvdquLMSUs3y84bXCItYGEyniA
         B0oMnFKn6t/MWxveEaEiXMJxFbtIhSPLsGMdMkwRaRBn3OjOwIc6MAOHP0ZXGxgW/fhU
         t/Hg==
X-Forwarded-Encrypted: i=1; AFNElJ+KTantMIcI3zrjEN2H/QYqgWkNIcpAom8Nc/tXANmzjCHyKKBBjg/a2xpOI2sMlzWRusd56OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAi/0AgE6WX7tvg1x8kQX1SaL5VjvsFaDBbu1YTF0rujky9mOQ
	JkTk/7Nq3MWk6WZ50Jv8Z+GfQeLyWJ8UwC1eYa2qR7XknGOZ2Ubh8PMq
X-Gm-Gg: AeBDietjXY2T3WwZ4GgSWeNXmBxYx+DhipkTzJM8RFgYEacwyMhIH9WiCHXcisBc2z3
	OYFnnthh8XTbPfaO5cCha1LFleB6HkMUo9J1ZHpT6MJBQPsFt8dL8xhV2QPrSqCl+m4ftRIObij
	R6HtfpDk04/4gqtPYeFX+OF5ylwlOlTYd7hjN5NnyPlrk1JB3pDHx8lPVNZn43iTc4sWSAjkgsD
	GVQHabiXn8AuvA/nk1ratzpSyf0h+gJ/rlpHKBnypzvvywxoQR0gNaTsmyfVhnql3t92LYxfxV6
	fyRhVkE9BLM/tIvlE8iSkwTVjMRekUfqfzlNy+ApaPbeWEtQVnuN0k6n8sy+4CjecoENKrQWDN7
	TeTgZDIoXRmM8fI4Lcu0EO/jbnBERM/Ks4RN1hLjnYBG5triuXHo8D206+lGZmsys9wntRFMNHU
	UiGmBjo1VXd4S6yhAusGgEPxScsiuZTwQEERATOgWaK8rGc65Xfnngj6FstCsQVYQVAsXnbk83l
	Pct6D9yxfMpoVGGovyFN9elMVc=
X-Received: by 2002:a05:6512:108d:b0:5a4:1add:c583 with SMTP id 2adb3069b0e04-5a41addc69dmr8297159e87.41.1776964024033;
        Thu, 23 Apr 2026 10:07:04 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:d4a1:6868:a5d6:1b91? ([2a02:a03f:a75e:9a00:d4a1:6868:a5d6:1b91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad0fdsm5365303e87.13.2026.04.23.10.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 10:07:03 -0700 (PDT)
Message-ID: <b854af29-34cc-453a-b9bf-a8a286c60807@gmail.com>
Date: Thu, 23 Apr 2026 19:07:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ipv6: Cap TLV scan in ip6_tnl_parse_tlv_enc_lim
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260421202406.717885-1-daniel@iogearbox.net>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260421202406.717885-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280817-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Queue-Id: 94C54455601
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 22:24, Daniel Borkmann wrote:
> Commit 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and
> Destination options") added net.ipv6.max_{hbh,dst}_opts_{cnt,len}
> and applied them in ip6_parse_tlv(), the generic TLV walker
> invoked from ipv6_destopt_rcv() and ipv6_parse_hopopts().
> 
> ip6_tnl_parse_tlv_enc_lim() does not go through ip6_parse_tlv();
> it has its own hand-rolled TLV scanner inside its NEXTHDR_DEST
> branch which looks for IPV6_TLV_TNL_ENCAP_LIMIT. That inner
> loop is bounded only by optlen, which can be up to 2048 bytes.
> Stuffing the Destination Options header with 2046 Pad1 (type=0)
> entries advances the scanner a single byte at a time, yielding
> ~2000 TLV iterations per extension header.
> 
> Reusing max_dst_opts_cnt to bound the TLV iterations, matching
> the semantics from 47d3d7ac656a, would require duplicating
> ip6_parse_tlv() to also validate Pad1/PadN payload. It would
> also mandate enforcing max_dst_opts_len, since otherwise an
> attacker shifts the axis to few options with a giant PadN and
> recovers the original DoS. Allowing up to 8 options before the
> tunnel encapsulation limit TLV is liberal enough; in practice
> encap limit is the first TLV. Thus, go with a hard-coded limit
> IP6_TUNNEL_MAX_DEST_TLVS (8).
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

Thanks, Daniel.

Cheers,
Justin

