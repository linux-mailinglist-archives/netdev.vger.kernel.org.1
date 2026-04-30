Return-Path: <netdev+bounces-282953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDRWJ/+J82md4wEAu9opvQ
	(envelope-from <netdev+bounces-282953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:57:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3E4A61D7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E59BC3045227
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC663630BC;
	Thu, 30 Apr 2026 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcUOXv5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221833F59E
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567985; cv=none; b=thhidPuVh0E2nDhzCz8wUCOymedIO0s0obQTosuv1pws2TzrWpJPN937Ae5YlGNsW8Olig6vDZ/a0nb1B9HIFnEobcNvTK+rom9o1YZW8BEYqOKvjxkxcN+FYF66QXrNZpt2qWIweamsBZXGoaSb/F4RPwmrZCreTFWTAZVHO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567985; c=relaxed/simple;
	bh=hpc0+j8qQVGUO/3r9nmAxsW9qovOQD6S7vAvwp15dUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mn+ab+GqhgPv09Z4C6ebHf9Vi9D9W0doIv0gsKrnq416a1EOMGgYBlzcaqxJAFHyEu1UciQ+xdeDCLY6MgERsHQ5vvqZRenHVJ498tOuA8v8lucj3HcPE6jcJ47PP7lkMBXwxoMNo/qMBuCD2d2gSOWFQXVSl/QBWQ9twTMB8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcUOXv5F; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso10451045e9.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777567982; x=1778172782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1pcptk2e5u2glsE+MYjDFmD/YtP16cwWWCKG0NNbpQ=;
        b=OcUOXv5FaTVnu7B+7kWQKJSK2lpLuHtpJfv1grpfS0Bb4BOl0lpsPesKMqa9q6fSe2
         vToQ9kZcdPr34Xkq/J0jFw4TlaKrk8urjy8+XcTOBSWLjHq7ikhqD41f2wvC4YmC5XYA
         gJ1l9jMXovQLxM07MF+HSgww7N9t9bKHHwfUnVXcbIcxsDZPsUqHznWL7yuDdZSlDvc/
         TifnobBm3p9OhktjO4GtN7wJ5c/Dmk9YOpjD32sIw6lEk4+Nis67la9MxyMmkdDElgXg
         b2o7waNxtuHqYn/RT3cs+Up1J9Ru2oA+JNPm/rN6VdNqVHEnUoGjmuAgvy3QDOTsKcOz
         GFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777567982; x=1778172782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1pcptk2e5u2glsE+MYjDFmD/YtP16cwWWCKG0NNbpQ=;
        b=b8bWyij7lW4vj8QQgMWIUiTaWeX7HfA0WskPZ0Qgmz2tfpHxHk4MA8Z7hA/ne6GY8T
         8n24XwN8eT6r33+64QdGqA5Ptp0Ob+N6fQgMPLi5BApQC5C7B5Ca1h5pPYumeo3I2Uvx
         oK78acGYNBJyzlmk0EEfjztbHFNlbTcj82Z9sRfJp/Y1+zgo1XKdDMsmDAJ1bhwlhWXp
         AAiyKqiSKC1HpjThFXik5GeRNNL37JUEYF4M7JgvjOFN/O96lmiJ+iejm2b4xyh17jX7
         PibFL4mc462m6dqCFOC4mxSvt/zJY9udQb0cmhzvCn1Ar87qM09J72NpofZDv7kI6VLJ
         CAeQ==
X-Forwarded-Encrypted: i=1; AFNElJ83tH7tOmWBKZupwo9vRR6x22F1DJ5bJ+p2zO7DJiI7C+c27+5uwVxqgdesY5eM2/wKj92jBys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTGDzK3o4KPhJHuvmGRdubzmljo4ZGB2AJCUEC4PP911BgbZ2U
	1HCpi7dCATWLtd+n619Vvnm8xgwhcULbTP3ojAINvcW0TVH2Z/rXwThv
X-Gm-Gg: AeBDievKmWXd0RHGmnuWL+8BNo7L1Nhe8/qsXP/OgDpHsvDCoj441LqCLwTeIALpd4i
	HWxHl0kgrqgmg48DNqxeeYM8+pXERkZr0qH8Fh/LnwQnl2/gBHX/vllEpVjApvoRwvHDK6mTjA1
	MQ05Vqy1jW5rC/UjgiNqIDMws8Mq4gJzTFizGViIdTIQ7OIcq4hQmI1uyfFHmXfwF19avc2t/tB
	EQyvgpwd3eV4QRAGzdJ4KaJ/zYFT3bZpF5aMOI2ute4KR6P4xhm55tjMo5GERSAx7WnbTgTjNO0
	B7aYkfSVbBFwKpWYZpd71wVTtdgT/GdM0dtziWsC3Q5VJfLaYNynMkOnOM8e6VyLB+f8EcYzKX/
	ESuJqEGVMG6qcsyJ49BmdCmIHTYk6OK/4IHKNME6qgdb30BJMtoG3tG/g9GL5+GO6pcgtoMNh/+
	Os0T9iAoLT4C1kcIELyz7q/yyrnX2jk85Y/PzCYXFSYtBecoI0mCEF8wHGto0DRB7LamZncf8gp
	uI0QsrVlxEcpg==
X-Received: by 2002:a05:600c:5254:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-48a8445f451mr64741095e9.25.1777567982097;
        Thu, 30 Apr 2026 09:53:02 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7cb7:f99a:652:c20a? ([2a02:a03f:a75e:9a00:7cb7:f99a:652:c20a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm125299595e9.9.2026.04.30.09.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 09:53:01 -0700 (PDT)
Message-ID: <aab80118-d87d-453f-a260-9a34748b4536@gmail.com>
Date: Thu, 30 Apr 2026 18:53:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] ipv6: Implement limits on extension header parsing
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260429154648.809751-1-daniel@iogearbox.net>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260429154648.809751-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F1C3E4A61D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-282953-lists,netdev=lfdr.de];
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

On 4/29/26 17:46, Daniel Borkmann wrote:
> ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
> protocol_deliver_rcu}() iterate over IPv6 extension headers until they
> find a non-extension-header protocol or run out of packet data. The
> loops have no iteration counter, relying solely on the packet length
> to bound them. For a crafted packet with 8-byte extension headers
> filling a 64KB jumbogram, this means a worst case of up to ~8k
> iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
> for example, is used where it parses the inner quoted packet inside
> an incoming ICMPv6 error:
> 
>    - icmpv6_rcv
>      - checksum validation
>      - case ICMPV6_DEST_UNREACH
>        - icmpv6_notify
>          - pskb_may_pull()       <- pull inner IPv6 header
>          - ipv6_skip_exthdr()    <- iterates here
>          - pskb_may_pull()
>          - ipprot->err_handler() <- sk lookup
> 
> The per-iteration cost of ipv6_skip_exthdr itself is generally
> light, but skb_header_pointer becomes more costly on reassembled
> packets: the first ~1232 bytes of the inner packet are in the skb's
> linear area, but the remaining ~63KB are in the frag_list where
> skb_copy_bits is needed to read data.
> 
> Initially, the idea was to add a configurable limit via a new
> sysctl knob with default 8, in line with knobs from commit
> 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and Destination
> options"), but two reasons eventually argued against it:
> 
> - It adds to UAPI that needs to be maintained forever, and
>    upcoming work is restricting extension header ordering anyway,
>    leaving little reason for another sysctl knob
> - exthdrs_core.c is always built-in even when CONFIG_IPV6=n,
>    where struct net has no .ipv6 member, so the read site would
>    need an ifdef'd fallback to a constant anyway
> 
> Therefore, just use a constant (IP6_MAX_EXT_HDRS_CNT). All four
> extension header walking functions are now bound by this limit.
> 
> Note that the check in ip6_protocol_deliver_rcu() happens right
> before the goto resubmit, such that we don't have to have a test
> for ipv6_ext_hdr() in the fast-path.
> 
> There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
> IPv6 extension headers ordering and occurrence. The latter also
> discusses security implications. As per RFC8200 section 4.1, the
> occurrence rules for extension headers provide a practical upper
> bound which is 8. In order to be conservative, let's define
> IP6_MAX_EXT_HDRS_CNT as 12 to leave enough room for quirky setups.
> In the unlikely event that this is still not enough, then we might
> need to reconsider a sysctl.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

Thanks for your patience, Daniel!

Cheers,
Justin

