Return-Path: <netdev+bounces-284760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAVSOxgF+2mbVQMAu9opvQ
	(envelope-from <netdev+bounces-284760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:08:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B9D4D859D
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03482305261E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC943E2779;
	Wed,  6 May 2026 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EIojI86A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44553E2770
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058027; cv=none; b=tlGUElpFqWXtcNbO1VG+NBOKhINc03t7/NUcw8k3SAfVAPl8vSR1hoj2euVNG5rOihl/8EF8YdW+XgsVOLZpe/InIPFHWxljlTtDo7G+IVLR8YlzJsJku+bx+v1AkMgxPZKoXYgk+8f4txX/b3Gf+tO04ob9w5Xc28bHG0c2EgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058027; c=relaxed/simple;
	bh=zogRSKbT2YEyQa6ZwtvKmN1PdpfDg0KGCKvLIqkt8zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/mG/sfAiGkMa95mPkq48377gML9weI2VuuPTR6sBxFjqCyvtiqShDuM8Axgo65BVtGJv7i5Z0NesaeuvX3b31X/lOukpaChjfs0qnVDpqPd6EjkbEM02kgCWKR/O2V7DBPHOf71YGp+ffNJJCPlD+eys16XN/nWZUmzr3NSwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EIojI86A; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso65970305e9.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778058024; x=1778662824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QUYhRXDlYEk80ahGSMbtQqKK9Q8bw4kPq0dgl12UhVI=;
        b=EIojI86AQuKGvtedDuCzFICSPGzX05HOCj/Js+ZdgMAMuRhHZ4rwFxvMZCjTU4+zLF
         G9mJINVdASrBGJj2+HYrm1yqg1hHKzp2ek9JCQJJIg7YAB5P7bRx1QZ0qxqpMFPl61wG
         cNowv9O3UlsoXFfbjJUAoha4592KCvZviuyDX8JuYY/nnrMBlgJOa5EekXpganOA/anv
         Lkdur3AYcUb5l3iy4s/Qd/3ErZQ1J5J88L/wf/UsruEa0Iy9x1/ctiT9CgN384UXgiRG
         EuEwPrjm/+tg/gm0trS72PM0AhW/AkeoLeMZFLDRIKUF5VQYgkaN+hU+o1zWBCkqG3LD
         TJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778058024; x=1778662824;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUYhRXDlYEk80ahGSMbtQqKK9Q8bw4kPq0dgl12UhVI=;
        b=hI3mgF2l2a9TG8sfocaJelTwziJDg/JOrEyFmFAsp0tXxdoBslSrTTsO7FCdu75S9k
         SJYYUN80kdeLz4ei/SDK90sxxTwsqHCJ0XESit+2zCiFiccflkCizc80+De3BH/HjGev
         jDVtQE3TmijDsM+nwW0BTOGUAWOCira9/bgnqo242luFWNaaNkccRJrFhj3hDRAtb6w9
         n3U/bHaC8oBojsmfz43y7Cb64/UBn+i0tt6buQZUzx6CgxffHqoeV4sYys0kYA6YH6cQ
         O7KVUe9h6U1R0TE8HVGN/sQt1zuzsAtNgFB0MGYM5AatvJaJDGRW2Rz89D71BPZNQ6h6
         6vCw==
X-Gm-Message-State: AOJu0YzWeP3bpBMGgCqg0jf0FuUCwxu7N41JKJFetfGF0v9D0sXwzMIj
	nMvqegcKpFUZsvl0WFSiv5kN2/Fs/arK9nNnHfcY29UYmOnTwawoft2uCglCdScRChM/30QQKdb
	oKn+ycbVEV3xOrQ9FqP2FWGT82QK2O0/eU3DnJ11NjqQ37U5mkSY=
X-Gm-Gg: AeBDieuxLdIE5ugI113+QkM6MDK0tF1y9EtrL3g85INhFC2tk5ke6xf6SgKIAoSpSp/
	OQ5Gqg6fGxWpAKDtjBXLje+nm7PKJDNmQ1ViH3ktQvSq5HQP+w2aRH0mXbfsoHiFceYrod6U78K
	PgQfe0xr5mtRosHo3xW8xznExK5JhKe4B1gS8/zzTDe9IJaCnx8s5SJkpbSjbPHFxx8K92qCZVg
	ohb6uK9amCG/1wq1+k0xEU8OHETd1UcuxQoZwAIZEdgr9qMEwPQ7vyzZU8NU96N0xBBjak0B+Ok
	fk8WISxTh873slNBTVa206AMlPzKRsnp8qNlSl4ZIVJm1Wl/S7LoVeHifWXiPO9/jxFRYDATCOu
	1b4dIsePFFL/F+TDQzTaInGZU+pi/bHks1Alp/V8q33q3i33ziKuKggbXRvjm0G5IbD30HHFJ8+
	MX+OtKvNNpYhejyNUiMTEnmT6PTs7NjST4nvQOPKqMnzeEkg43IwmLKC0tXw==
X-Received: by 2002:a05:600c:c082:b0:489:6c22:e081 with SMTP id 5b1f17b1804b1-48e51dd3a1bmr33321355e9.0.1778058023788;
        Wed, 06 May 2026 02:00:23 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:a11f:2463:c7c3:c35c? ([2001:67c:2fbc:1:a11f:2463:c7c3:c35c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530fe317sm17036145e9.4.2026.05.06.02.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 02:00:21 -0700 (PDT)
Message-ID: <9ffc1db1-3b67-453e-ae43-e986fdad3694@openvpn.net>
Date: Wed, 6 May 2026 11:00:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] ovpn: ensure packet delivery happens with BH
 disabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, sd@queasysnail.net,
 davem@davemloft.net, pabeni@redhat.com, ralf@mandelbit.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260504230305.2681646-3-antonio@openvpn.net>
 <20260506010035.1563280-1-kuba@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260506010035.1563280-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F2B9D4D859D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-284760-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:mid]

Hi Jakub

On 06/05/2026 03:00, Jakub Kicinski wrote:
[...]
> This protects the success path, but do the error and drop paths also need
> BH protection?
> 
> If ovpn_decrypt_post() is called in process context for TCP connections, an
> error condition jumps to the drop label:
> 
> ovpn_decrypt_post() {
>          ...
>          if (unlikely(ret < 0))
>                  goto drop;
>          ...
> drop:
>          if (unlikely(skb))
>                  dev_dstats_rx_dropped(peer->ovpn->dev);
>          ...
> }
> 
> Since dev_dstats_rx_dropped() updates the same per-CPU dstats structure
> without disabling bottom halves, could it still be vulnerable to softirq
> preemption and stat corruption?
> 

Actually we were already looking into this.
However, since this needs a separate analysis, I wanted to get this 
fixed in a follow up patch.

Would it be ok to pull this PR as is, so we don't hold back the 
outstanding fixes?

Then we will address the issue highlighted by Sashiko in a new patch.
The problem is similar, but may need to be fixed differently.


Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


