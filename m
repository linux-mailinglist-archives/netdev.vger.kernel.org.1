Return-Path: <netdev+bounces-282040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGNlImL18GkPbgEAu9opvQ
	(envelope-from <netdev+bounces-282040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:58:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DB748A481
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8051E3012BD4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4EF44DB6D;
	Tue, 28 Apr 2026 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7TrEoSY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3E451051
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399128; cv=none; b=RnMpNjrQVDkHMSQmzmqthr98s2AK3kZfF3PPiYWCGx8EANEWqZMc1xpNjc2lYRW6lSVpTobm2o7Zx5zeJz+nQpWa2M9gJBTT9KSdUtQ1SRmNl+DL1n/9VSvGnyapFntDBg9ol0xoxMzuz30ZzoJ9t4yZDjZGO+Ai8yPA+dIyeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399128; c=relaxed/simple;
	bh=JOjoVt4Lgh68EyEiaiatcAz3a++vf2+eaG4VRs++pJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUB3y32e3R46SNR04/H8NAx124ihzcW1XsBTJygh1RllXyARCLt/ac8prYrlFXTE3TlQvQ433b0QLZJQaoW2DH7zM7NSm/pdmag7qZ0Xe8AN9tagEpBi/zcKIHNvlRwN20l0zVrl8tqp2g2vnBhkzLl3BpcawMjE57JkUsglcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7TrEoSY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso749365e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777399123; x=1778003923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQJhq1Qpy4nRLUftl6gEQQVvLmvOYEMFoTgSKttUIl8=;
        b=S7TrEoSYTo4jd5A8CV+WsBML7NMYec2erlxMd4xCtcY2+JautPXFv/VFEjjwV3C6xM
         8Hx/D1X1XYBGVyAOZ6Gxi+yG0LTTQ9ekXc8vpejnK/qimCnfP2RBFzdINYwOYWRWlnYQ
         24uPRd96SfLxgjPPu3qkrHRLHBdiLERUyYyYFBxcnF8WoyYRE1Rhx/iCQQBR5YgAV47/
         w2MYYtHYIlRykfN5zzV7kdJ2gNiHj3j6L0D7HwXqFYaD1ui5AYPVIS2fueKv3it5bltv
         EJIFH00sh/zvJYPGNvF/yCJ7JrRChLXj2mnQOCXBrYBtM7tk7TqpJ2OTUu83HgrGFDUk
         Urfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777399123; x=1778003923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQJhq1Qpy4nRLUftl6gEQQVvLmvOYEMFoTgSKttUIl8=;
        b=XbJJdufES+/srxSBLm3BW/OhrPRhrkULGxIrP8CnEaCn/7fL5fF02MayyRZL4lLSA5
         +6c4FQkzUI/J+y9s53p9q0tPbMSZalZlAlqSpaxAYAaCEi0bt5NNNxLVLtH0nbssM48X
         l2bY+26G0MNfURuYOcOBriiSmnwi93nRwtedPEtZkFXgN3x4e0/Lm8Npv6UiAmIUbfLV
         k/UPbKFV+UxfF85604Vkvxagi3oXucwYGVwg22LaOB6BJ+DaOsIwJ36OGcrUL3W/lJl5
         i66myp3W9B7BKei3+a6m7mhyF3ZGl8vY1V497OcGDbLJtHBc2BnEx3xiznLJaZYkvTpU
         8utQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ESSkWA7WJjSWQnwhR6M7A6yh8uuDkD6artHxjs0Zw9apWywf4LNnzcbD8XiJBXmdAPSUmRxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZDqU+AP5DHm/vFPtBGxDYM2mIAT/lKwVMMfcoXMafLMeGLlji
	G/faV2JHr06DvVcCTEEfgZiAbu9fwldOGh53DOrK3ErZCiFZCXfzIrSV
X-Gm-Gg: AeBDieuaStVl8OLR1D49WkVauoidh26X8anGRm86U5BQdEWRAgYPTfe+wlM5IZFnpLf
	DX5onEE1zlyBabA8p3+b6w0XDnZs+bJ1GndfW6rZygsx3UC33ixbrRi1WmWbOdqJTDuqyb9Evbn
	9I8eVNbZocR97q/+ZZ3bpyee9Lmj1JJqtGSXycbhLh21Qciy+Rt0MRee6T0OES/aVvfmadtNGJx
	mJCP7cX/S8FHuo6VxuxA8Ij/7j4ax8k/W5kC+sua5B63t2812fjajdRarQtjQMtGIs3pchGkSvl
	o4lBTCfEi0VahmUBB5KEcV6H6qsumyp43hC8hOevGiVyqH4vSD8vTXLdqGvS5Mv6N1vXnSHLn/C
	eunF6PFMyxl4W+zdafPUpXsbMVD9j5seO+u6slQVShM0ZHZBVko2nz+xaa9ssBT7usieYWsYRu+
	GM8YrX1CwhSb+lDz1AArFKcL0f7H4Q2AOK3M81uAz+k9tmnxOP44sN2JwkA5z2FzmFOFgIswoGC
	CSN3TWKg5d6VyA7
X-Received: by 2002:a05:600c:a08b:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48a78a536acmr51578585e9.14.1777399123205;
        Tue, 28 Apr 2026 10:58:43 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:2419:61a4:ae0d:bc43? ([2a02:a03f:a75e:9a00:2419:61a4:ae0d:bc43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b8c2e5asm4396415e9.1.2026.04.28.10.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 10:58:42 -0700 (PDT)
Message-ID: <4497a340-b48e-4615-81eb-90ebc7a0b5d2@gmail.com>
Date: Tue, 28 Apr 2026 19:58:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] ipv6: Implement limits on extension header parsing
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260428153749.785611-1-daniel@iogearbox.net>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260428153749.785611-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 28DB748A481
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282040-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iana.org:url,iogearbox.net:email]

On 4/28/26 17:37, Daniel Borkmann wrote:
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
> IP6_MAX_EXT_HDRS_CNT as 4x that to leave enough room for quirky
> setups. In the unlikely event that this is still not enough, then
> we might need to reconsider a sysctl.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

FWIW, I prefer v4 over v3. I didn't like the idea of a new sysctl for 
several reasons I already mentioned. So, thanks for this new version, 
Daniel.

However, I can't help but think 8 would pose absolutely no problem. I 
would be very surprised to see someone complain. We're choosing 32 over 
8 to be extra safe, at the price of security. RFC8200 provides the 
following ordered list which is recommended for senders (without 
normative language, though, which was a mistake):

       Hop-by-Hop Options header
       Destination Options header
       Routing header
       Fragment header
       Authentication header
       Encapsulating Security Payload header
       Destination Options header

So this is the maximum you can have theoretically***, although you 
wouldn't for instance use the Authentication header with ESP. I'm not 
even talking about ordering or specific number of occurrences here, just 
the total number of Extension Headers in a packet (as your patch does). 
It's also worth mentioning that it's highly unlikely to see someone use 
them all at the same time (in production, of course). This is why I 
still think that 8 is safe too, and would provide security as expected.

***well, you also have 3 others [1] (Mobility Header, Host Identity 
Protocol, Shim6 Protocol), but they're not widely used (not to say 
dead). And they would probably not be used with other Extension Headers 
anyway, as they are not specified to be present with a layer-4 in most 
cases.

  [1] 
https://www.iana.org/assignments/ipv6-parameters/ipv6-parameters.xhtml#extension-header

