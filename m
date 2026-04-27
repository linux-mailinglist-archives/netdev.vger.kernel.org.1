Return-Path: <netdev+bounces-281322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKJVKTdi72nSAwEAu9opvQ
	(envelope-from <netdev+bounces-281322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:18:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296747347B
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EE193004C6C
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93E3B8D76;
	Mon, 27 Apr 2026 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/iDBXf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66312315D39
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295694; cv=none; b=TtX4exlks5URjvBr2jLO/jYlbsuxt54tQ3cYnVpHJSOmcCHXnukmOgkPZTZc/iMNe3exhyJIbn++Oh9b/7eAfayStMkY/ZN1jiCSCWMGUo3y6xU1C6eQnESpzmaWRtsFb7HX6sZQBM6m0iYdlF0pcJEyw2WJEx4hDMXRxOw1bWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295694; c=relaxed/simple;
	bh=Ei6lFHvF6qfNLxlS24/vAj4Lgjge2SlMTdQK9JbKwLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXwg0jY4HqYme3r8NkYTncPK8iGfiG3C0JFn0ts1oOtkqEsHzeJKPbr7U5pHzoirf723bi5IARn85TzxTiW3GxHQ9NC5sRpWBkzWLVNkjjBvRN/q3Gv9sSRdZYSqF8vAmiWhf7vZ4e6syTMqRaqP/90a6K8trMc9UUqxe3GaLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/iDBXf2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so133690875e9.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777295692; x=1777900492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miAB8sZfD4Z3Ngojp6IXUcFtgXk50B8LNyyjS5vj+JU=;
        b=M/iDBXf2zf8sfNblr+5ZUgbJl2wcrqEKumTRer3Hb700BJZNVbWOLfAooe/78/keH9
         /6x6JMkG/lYqEAF+oTUOGwi4E7J/8bYl98zI35WEJmuWnRbmFeyiRMuOFb/c7Tu0t5Ya
         x2HM5rr5+RMOYzjQKzMSbkdJE87sT5LPPBM19pX6PL5dJ1JB4ModjQIHVEPKsU9fZVg7
         ip14fBEN701C0ExNLRe6CHyZdVL9SfOyLbY6hC1UyKHwQvkjT4qS0vC+gdj/cLVanydz
         nrjRFTmTdQcYswvkfBJWd1MTSLsNGVNlC0VBFM7ZOPFuUHw37F3sIcIwvAnza94dMVjE
         WqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295692; x=1777900492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miAB8sZfD4Z3Ngojp6IXUcFtgXk50B8LNyyjS5vj+JU=;
        b=dPfyfVnouEPOWugOayBuPTTUT38eyF8ohS506daObxZn/uuPIxgYSb/Hq3rfbxNfa+
         Bp9b6MucbitDIIsmm3skeu5JRP07OTQ8hz51W5SifoudRQ6x8tm4UDcGpTuxlzyaPauD
         omGhjxmaa98i8kJBKZuzVGdHE4FBcS40+a1nwJyDFqil0d/qFErp4nbArZwJGL4iZvG7
         jUqOQpXLWi9QldAp2k3JohuUhpjbfF0JBSQdjyTStYD7XxW9zFkZIQ7M6OY92eZcOYhF
         SPZcHeFf+6Ns9tWpTks95ZtLSt5o25ciMaIn6ppQC8qyiiElaGQAgdLvYgFsRHlny6+c
         +eyg==
X-Forwarded-Encrypted: i=1; AFNElJ8uwQgZFQCr5i8YC26/bqhiEs6zQ4rZ0xJz/Tx/gSZd8ZtoenmLWn9dVW3/XQNZJaEPkdHEL5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfUavQB++zHHTjcgh5f93GwK5atb/7TqqOkL10HBNpRNH45bfg
	4iurxnG9/VY7uKl3LIGCa+RZVPbE0ptWilIQjeZWmXYnV6WKOJ0Cy+HD
X-Gm-Gg: AeBDiev+/OOCwZA0ocMTrhV5PqUaUkmgcQyZetNtpvF6CTnTm0BGpxkV+41X5kJXSlK
	hzmsSmUcGHvr+UAz+k3GW5IRUEqSTZ7oz8S4/7sodBHaeRHgW1Rt6oBOxd5Wkt6sYr6+Sw7PbBZ
	mUKmsPCGHdYbW3BwEDn15+RVkTvTh9t1MYWgLVRuUWZWjaR6rZ0KgfxTut1c/bAWQ9OcDSNsqzE
	Hj/RgPMuhkWZPmlWyMEpUwTRCMwwYrjIRGqTEI/G3WedfUthFGrIJTUCp1hz05hIKbK9CCLPj7p
	NBe5JDEuonC2XpGE8draEl+/LuE8CDgKnde0hcdGMfK+4/Amo71Hg0J1jhhaSf0UqXcQVlLJ4Af
	8Js/wiHYSQIj/z3hh1H6c9uDV0EVgezsncS1mR8Jh3t72+2HuTc3YDfzfSpeMZcdZh9rE0oqTEZ
	/2lr6MIJllBG3Rjp0bI70JehpSH6jdwstYOYK2g3f29NnLGX2SBqQoHvKEUjen0il7E6y/Oxa8w
	d4=
X-Received: by 2002:a05:600c:468c:b0:48a:56d5:16f2 with SMTP id 5b1f17b1804b1-48a56d5179amr388087585e9.7.1777295691522;
        Mon, 27 Apr 2026 06:14:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c7a2sm250374995e9.1.2026.04.27.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:14:51 -0700 (PDT)
Date: Mon, 27 Apr 2026 14:14:49 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
 tom@herbertland.com, willemdebruijn.kernel@gmail.com, idosch@nvidia.com,
 justin.iurman@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] ipv6: Implement limits on extension header
 parsing
Message-ID: <20260427141449.4bc90a28@pumpkin>
In-Reply-To: <20260427101318.750730-1-daniel@iogearbox.net>
References: <20260427101318.750730-1-daniel@iogearbox.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1296747347B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-281322-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email]

On Mon, 27 Apr 2026 12:13:18 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

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
>   - icmpv6_rcv
>     - checksum validation
>     - case ICMPV6_DEST_UNREACH
>       - icmpv6_notify
>         - pskb_may_pull()       <- pull inner IPv6 header
>         - ipv6_skip_exthdr()    <- iterates here
>         - pskb_may_pull()
>         - ipprot->err_handler() <- sk lookup
> 
> The per-iteration cost of ipv6_skip_exthdr itself is generally
> light, but skb_header_pointer becomes more costly on reassembled
> packets: the first ~1232 bytes of the inner packet are in the skb's
> linear area, but the remaining ~63KB are in the frag_list where
> skb_copy_bits is needed to read data.
> 
> Add a configurable limit via a new sysctl net.ipv6.max_ext_hdrs_number
> (default 8, minimum 1). All four extension header walking functions
> are bound by this limit. The sysctl is in line with commit 47d3d7ac656a
> ("ipv6: Implement limits on Hop-by-Hop and Destination options").
> As documented, init_net is used to derive max_ext_hdrs_number to
> be consistent given a net cannot always reliably be retrieved.
> 
> Note that the check in ip6_protocol_deliver_rcu() happens right
> before the goto resubmit, such that we don't have to have a test
> for ipv6_ext_hdr() in the fast-path.
> 
> There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
> IPv6 extension headers ordering and occurrence. The latter also
> discusses security implications. As per RFC8200 section 4.1, the
> occurrence rules for extension headers provide a practical upper
> bound, thus 8 was used as the default.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  v2->v3:
>    - Adding IP6SKB_HOPBYHOP coverage (Justin)
>    - I left the limit at 8 w/ sysctl, still feels the better
>      option to me if we can keep the worst-case more tightened
>  v1->v2:
>    - Set the default to 8 (Justin)
>    - Update IETF references (Justin)
>    - Add core path coverage as well (Justin)
...
> @@ -72,7 +74,9 @@ EXPORT_SYMBOL(ipv6_ext_hdr);
>  int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
>  		     __be16 *frag_offp)
>  {
> +	int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
>  	u8 nexthdr = *nexthdrp;
> +	int exthdr_cnt = 0;
>  
>  	*frag_offp = 0;
>  
> @@ -82,6 +86,8 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
>  
>  		if (nexthdr == NEXTHDR_NONE)
>  			return -1;
> +		if (unlikely(exthdr_cnt++ >= exthdr_max))
> +			return -1;

It would be better to decrement the count and error at zero.
		if (unlikely(--exthdr_max < 0))
			return -1;

	David


