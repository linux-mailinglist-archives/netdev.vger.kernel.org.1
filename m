Return-Path: <netdev+bounces-268536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIPsCWAruWmVtQEAu9opvQ
	(envelope-from <netdev+bounces-268536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:22:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D40492A7CA3
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3641B3012D2C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138424501B;
	Tue, 17 Mar 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5LPgby9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="boE0qCem"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64833A0B0B
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742942; cv=none; b=aHaLaFFAmXkzrqqejvOvaTjEDYUygsKx9nQSjIPN8yavFBJXGSK7UA2mfzqAZrjfkzSN2Av+F+5VMmT3H+fhGZJfxC+UfsKBkMi7d5YY0t4R2xIXjJrLa37yasW0iASAU53U6nLSQcGyecC5LH+iJJ42D2EGbsrfo+VENwq8c3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742942; c=relaxed/simple;
	bh=wISKzO8YYy6+ifEqLTA939MgZNUacc8a4N9O/jVzjnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5FSRahSKNxiZ6e1FBZKjHnPbi1jd61hQOl3gisuIcCnZ4e7fh+/kEPJWc9JsisSF8j46CT0LItHc7sThrLVtJnP/6tL5LtaCuUD9YH2htjAIVdApCouc+0e/1Vf26bSAzFI4smjlAZjLG1+DmQ8pQd/xVy+AXIpyst+5gVYojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5LPgby9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=boE0qCem; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773742939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkKqNdfObEjNjonM4AldEKRrXa7M2P0exxocTG871CA=;
	b=I5LPgby9VNRs13jYEeTV6MV0WlNMiSom57xfKyooQPOmx4K9WCivPUTRBZ8PFpANVom9me
	cFFdZ4RDRaU/sAFzA5BBHCT6xTqrkV//FyPXsEzKO0ovGcRAZjbJuKBTHC3xqS2Qvli/vc
	3LjC6wOg5YjH4+bOmqVa9uM3mJw8vUM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-sUvfQDmEOB2nrPt7KlNmWA-1; Tue, 17 Mar 2026 06:22:18 -0400
X-MC-Unique: sUvfQDmEOB2nrPt7KlNmWA-1
X-Mimecast-MFC-AGG-ID: sUvfQDmEOB2nrPt7KlNmWA_1773742937
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b4e102d77so252087f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773742937; x=1774347737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkKqNdfObEjNjonM4AldEKRrXa7M2P0exxocTG871CA=;
        b=boE0qCemjt9OVMfJ7hhEtgZfAOeST0QHRpgqwvJ9ji+QAdkmxRuAfFKabICHc+MQtm
         QddA1JMxXcVAeym0R10TcsrYUzPZajAQVVATdvh2jiuoxQ0ujqNSd4FgmKLcSFF/yUhD
         +1rLsjjLcaDKB1gQwMWxwu+BvJjti8i6xu35mU5ZZWOospFA3WaQptG31CXXbqJ81T9I
         ArXeCMoB2y7Y7bih65BGRpq+JWm7FbDnfQ4LehFdmtAbLd2uQcliGycAK1JuEcVhnqez
         U/PjOmcPFs8fHrUJmnhJbWa8oDfDBH9yW1W7CLvB5zknI1VYAG86BdQ7B7GGOCrh9qUL
         fOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773742937; x=1774347737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkKqNdfObEjNjonM4AldEKRrXa7M2P0exxocTG871CA=;
        b=VGAYFGFAsk0RvE5Y/HBPr8JDmzXM+HfxJ1Vh0Kz1JkiMvtiWZmnziFWY9yNrQMlz/j
         ulD15q1Mf1u3jtn8fhh/F+BI+a3yDab4YXDJMpZguQUszOszDlPQj6CpgIz/4X5z6GZm
         tIZFOUB0s5nlIJh9KMn75YtZx6SinF5gWS+tDtLyraNr3Dfm8a0Vj1Srv1ko9zK5mQGh
         o0a/Ern6O28aBV3ZsS9HtIMri3Zy4GfvOHTJ9LxOwdHVKN41Aea2w8vcDm/W/SwSyekP
         L7xQAOzPR1AqBJ6F4g9onN1vhlXMLlLEeDNHvMlLajl1yEAEUZAJABdfV5VrBng+op/f
         +zFg==
X-Gm-Message-State: AOJu0Yx+ZoDy7eIptC0muLjZS/fej3DuTd5rfKcTbyZmeH6vB9DKee4O
	ZDU9eKMMSb51ql5z6BAynd0/RLSknLHzGZeEA2BQQDe8EOuZyqAjyrmEGxAw+dgWFimCFXmT+xS
	ih/M+SOysVOS34A2U77CFmdBH9EHyprc2Rv3H7IVVUj5TfNKbiLzzIooDtg==
X-Gm-Gg: ATEYQzz3Kr70zFWk9tMoi8xDPeI4uiV6pRgaWAdl/8iquhlC7/XrBaPFcCcp9Ob00uJ
	OVErPlouoJezLhygsOWHJtXyAWrEFBcHWwJmNhQz0y6kRjOLmLCdk+cLzLHAkRnmKjWGmvmM+Kh
	HOvCEA1QYn8C1/bTdRAJMUTF1gXLIRUaItKrc+dY/CXeRrLVo7qf9/H22CvFAzEwZgBaqxMmvKg
	+DARY70iXzKtaTYruahU/5/X9H+CmVlH/YvKOTe9Hhjqq3sTU4idpo0CLINmWQq9d86qTc6xkIj
	6pec8xq9yd+irAjlGABE1ctcDy4rEqtL9qJ8iZ1F7M1rP3OLuIKgrBKQTvvGSeiCZE1mZM8nRZL
	DMjfG4GDzTREjgRGkVrAQADqABmv/AoNBQtvIzfy4OKIWYxhI+p9d3m8=
X-Received: by 2002:a5d:5d0d:0:b0:43b:5003:e300 with SMTP id ffacd0b85a97d-43b5003e420mr1053825f8f.43.1773742936943;
        Tue, 17 Mar 2026 03:22:16 -0700 (PDT)
X-Received: by 2002:a5d:5d0d:0:b0:43b:5003:e300 with SMTP id ffacd0b85a97d-43b5003e420mr1053763f8f.43.1773742936399;
        Tue, 17 Mar 2026 03:22:16 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1abf84sm44889410f8f.14.2026.03.17.03.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 03:22:15 -0700 (PDT)
Message-ID: <0a25f57e-fe08-4fe9-9722-e1c6adb81e91@redhat.com>
Date: Tue, 17 Mar 2026 11:22:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: use skb_header_pointer() only for DODGY TCPv4
 GSO skbs
To: Guoyu Su <yss2813483011xxl@gmail.com>, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
References: <20260310174841.5f5671c5@kernel.org>
 <20260312104351.185370-1-yss2813483011xxl@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260312104351.185370-1-yss2813483011xxl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,google.com,davemloft.net,kernel.org];
	TAGGED_FROM(0.00)[bounces-268536-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D40492A7CA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 11:43 AM, Guoyu Su wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 14a83f2035b9..f3340d7dd87c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3805,10 +3805,21 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  	 * segmentation-offloads.rst).
>  	 */
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
> -		struct iphdr *iph = skb->encapsulation ?
> -				    inner_ip_hdr(skb) : ip_hdr(skb);
> +		int nhoff = skb->encapsulation ?
> +			    skb_inner_network_offset(skb) :
> +			    skb_network_offset(skb);
> +		const struct iphdr *iph;
>  
> -		if (!(iph->frag_off & htons(IP_DF)))
> +		if (unlikely(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY)) {
> +			struct iphdr _iph;
> +
> +			iph = nhoff < 0 ? NULL :
> +			      skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
> +		} else {
> +			iph = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
> +		}
> +
> +		if (!iph || !(iph->frag_off & htons(IP_DF)))
>  			features &= ~dev->mangleid_features;

AI review noted the following:

Does this code use `_iph` after it goes out of scope?

The stack-local variable `_iph` is declared inside the
`if (unlikely(...SKB_GSO_DODGY))` block, but `iph` (which may point to
`&_iph` when skb_header_pointer() copies the header) is dereferenced via
`iph->frag_off` after that block's closing brace, where `_iph` is out of
scope.

When skb_header_pointer() needs to copy the IP header from paged
fragments (the exact scenario this patch targets for DODGY packets from
AF_PACKET or HSR), it returns `&_iph`. The subsequent access to
`iph->frag_off` then reads from a dead stack variable.

All other skb_header_pointer() usage patterns in the kernel declare the
buffer at the same scope as the pointer usage. For example, in
qdisc_pkt_len_segs_init():

  static int qdisc_pkt_len_segs_init(struct sk_buff *skb)
  {
  	const struct skb_shared_info *shinfo = skb_shinfo(skb);
  	unsigned int hdr_len, mss = shinfo->gso_size;
  	u16 gso_segs = shinfo->gso_segs;
  	const struct iphdr *iph;
  	struct iphdr _iph;  // <-- buffer declared in same scope as usage
  	int pkt_len;
  	...
  	iph = skb_header_pointer(skb, skb_network_offset(skb),
  				 sizeof(_iph), &_iph);
  	...
  	if (iph->protocol != IPPROTO_TCP && iph->protocol != IPPROTO_UDP)
  		return -EINVAL;

Should `struct iphdr _iph;` be moved to the outer block, next to the
`const struct iphdr *iph;` declaration?



