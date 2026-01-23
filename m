Return-Path: <netdev+bounces-252857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNO2IqWIc2krxAAAu9opvQ
	(envelope-from <netdev+bounces-252857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:41:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A63E7730E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9E54302351D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB46314B96;
	Fri, 23 Jan 2026 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoD5M9KH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354E314B79
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179292; cv=none; b=doT7FxbWYvatrd/ZAjYROi/0vjWf8pkVyAw9Y8lHqikYXROP3f1CjiI2tR5WexirgQ1+5AmUjb+6MucpHFU3jGMbnytlRBKrhZi5glcxUd5Oqr8sA7/DeNc6kP93lOqERyZWMjE2xmmXKLQ5KdLbzeTDrLGWuWo2h63SMTO8Kzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179292; c=relaxed/simple;
	bh=fa+rfYUwFHtqWND/Vxtof569Hvv9rD5dqqXoUgVdCtw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=spX6ZnJJPDvi6++Q3Rxk3TC7YdODQHH+fn5sV+oqG4Lk9CHnPFkf8lFhHcDLgK/JW2BmWLRRfNQ0S/eSbKYSpU8Vf1++cl2QJ48UKcJkyIZjQ4b05ficWQ+z9RVQr3HcCfeIhEGifug862khY046zNm6LGmaMtvO/7LRbLymd5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoD5M9KH; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7927b1620ddso33635427b3.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 06:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769179289; x=1769784089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMisBMn9c1037wzo/MoCj3XHLoFHlezRkhC9TUGbZg4=;
        b=QoD5M9KHT1a0VQupQoI806U/MnS7Phs4Fk419hjAOVSpliGgajTLnZiWqbue1Bam7x
         cz5dGicS5j9Q/WeKXQubV82RQuj+4IjYUHxDaUWZoSd0j2MVHH090ilQexSDdU+ks6Ia
         VOJ7AzfCSLNntQupYdBmiwFaTMu/Zzbs4RF2bdHU+DdM/vQ2eV2BQlVvrhvkh9qB+QLp
         SY4LoAYOIzHnWbXsacWyhHBkxzROb9w97lIDYGWJxJASiaIocMlaU9bEbduLnLMKtSJk
         L7bQ+lEOJmVzVZ838Xo6/xGyFfer7XNgRdCakgpxoCZ5kREjqpiBM6eZnw4WuWZEcVru
         QKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769179289; x=1769784089;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMisBMn9c1037wzo/MoCj3XHLoFHlezRkhC9TUGbZg4=;
        b=Coz9lPK5Xdfg+kBnvPkeHzzADmObZ6pNaccE6GF7TfclNQkWWWEQsAozPtwB6bwtZJ
         WZTwhR2J7j9K0Wy1iTrdpF4rIItdrNZLEjn58t5lDFCjJoUVnxChHEr4JOQrGC3VGKbq
         qxgpddmnS3P67i6taVS62e/YYSfAHM6u4EcoiswdoMn/BBh8GwGm4se5w3eJKz1rff9f
         FxHe1iTAgxckf6320vBoFs73jwF+p70+Fo7pWhw/cxyhz4+XQNvGEAwmGvFDlEUjwdqS
         HlKc7SaSPSleBq5XbQiuzRt/PJxAMvVlE+16+Ixm72J//KXyAS2s1+RsThFim2xrnxlS
         wIAw==
X-Forwarded-Encrypted: i=1; AJvYcCV2GOM0AzmAUvIExzP+f9Be7bGXAijt9rUob/ia8lJAXUm3t1WpQtqpCjVHSS7ndJB1icm691Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9RortGRUR4cGGxWq6B6hssdQSoQlcbcD639iev8GNi2BpQYRF
	eJO54R73Jft0/qvjjbNvhBaUYDe/SuvqauMEU3rK+2I3IylhtMs0pzJ6
X-Gm-Gg: AZuq6aJ3y2MSkSEuVimT6H7ZUBIDbTGu2DADD630h+pmAMTmRAxQOIPHOcTeyixRpSI
	WwxKfWlJhm/RNM+n+rzZ3LZaHdXyiNxN8ovOmK8r4GfcDkdFIn/Im2eDXBKNUwQyon4CcGQfLKo
	LEZ1A5/q0wVcZfZU2nm2u9ryt5KVr5dJerYaf77/Nq6UqymXtoYc6h7JsUd141fMiJPe3WiCvv8
	2Ta3WVhCVk0oK6Z0Esvc1rin9v36MzUgGWi/0h7/kSs+JgHg5eTARZ0oaN3TdaoV32tJn75fH2c
	4Dcodvj4RrLmdTmyPdp/NiXifTMEIr9qhgtM09BFV6pYeEf6PvB2T18Fh+NGBSgjALmpi8GCoHJ
	n4kKyhTN3b/xtlajg/ZqGGi9aELCyPnPq2Xf71d9ivJbXMmagPk95mi9JQLBhYKqXcBAW4KsTYP
	06K23tNLGhXmBSatB3eR/QO7y8qlbd7c1VwouU+veSKC6qoNmchTOQ3HgLbF8o4UCUMgDn0A==
X-Received: by 2002:a05:690c:6f81:b0:78f:b75d:62f4 with SMTP id 00721157ae682-7942a8c9a48mr52845487b3.34.1769179289562;
        Fri, 23 Jan 2026 06:41:29 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943af1443dsm11331087b3.2.2026.01.23.06.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:41:28 -0800 (PST)
Date: Fri, 23 Jan 2026 09:41:27 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Mahdi Faramarzpour <mahdifrmx@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 kshitiz.bartariya@zohomail.in
Message-ID: <willemdebruijn.kernel.2b69585efeb5a@gmail.com>
In-Reply-To: <60ed19a1-97e1-4342-8dfc-a5db684afa6f@redhat.com>
References: <20260122185357.50922-1-mahdifrmx@gmail.com>
 <willemdebruijn.kernel.1682586fd684e@gmail.com>
 <60ed19a1-97e1-4342-8dfc-a5db684afa6f@redhat.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252857-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A63E7730E
X-Rspamd-Action: no action

Paolo Abeni wrote:
> On 1/22/26 10:26 PM, Willem de Bruijn wrote:
> > Mahdi Faramarzpour wrote:
> >> This commit adds SNMP drop count increment for the packets in
> >> per NUMA queues which were introduced in commit b650bf0977d3
> >> ("udp: remove busylock and add per NUMA queues"). note that SNMP
> >> counters are incremented currently by the caller for skb. And
> >> that these skbs on the intermediate queue cannot be counted
> >> there so need similar logic in their error path.
> >>
> >> Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> >> ---
> >> v5:
> >>   - check if drop counts are non-zero before increasing countrers
> >> v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx@gmail.com/
> >>   - move all changes to unlikely(to_drop) branch
> >> v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gmail.com/
> >>   - remove the unreachable UDP_MIB_RCVBUFERRORS code
> >> v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@gmail.com/
> >>   - change ENOMEM to ENOBUFS
> >> v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@gmail.com/
> >> ---
> >>  net/ipv4/udp.c | 19 ++++++++++++++++++-
> >>  1 file changed, 18 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> >> index ffe074cb5..41cf8f7ab 100644
> >> --- a/net/ipv4/udp.c
> >> +++ b/net/ipv4/udp.c
> >> @@ -1793,14 +1793,31 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
> >>  	}
> >>  
> >>  	if (unlikely(to_drop)) {
> >> +		int err_ipv4 = 0;
> >> +		int err_ipv6 = 0;
> > 
> > nit: whitespace between variable definition and code block
> > 
> >>  		for (nb = 0; to_drop != NULL; nb++) {
> >>  			skb = to_drop;
> >> +			if (skb->protocol == htons(ETH_P_IP))
> >> +				err_ipv4++;
> >> +			else
> >> +				err_ipv6++;
> > 
> > No need for separate counters.
> > 
> > All counters will either update IPv4 or IPv6 stats. Similar to how
> > the caller of _udp_enqueue_schedule_sk is either __udp_queue_rcv_skb
> > or __udpv6_queue_rcv_skb and chooses the SNMP stat based on that.
> > 
> > Can check sk_family == PF_INET6 once.
> 
> I think that doing the SNMP accounting in __udp_enqueue_schedule_skb()
> (for `to_drop`), __udp_queue_rcv_skb() and __udpv6_queue_rcv_skb() (for
> `skb`) is a little confusing and possible error prone in the long run.
> 
> I'm wondering if something alike the following (completely untested, not
> even built! just to give the idea) would be better?

I don't see the error prone issue with the simpler patch.
But SGTM if you prefer this.
 
> Note that the additional argument in __udp_enqueue_schedule_skb() could
> be avoided piggybacking the `to_drop` return argument into the
> __udp_enqueue_schedule_skb() return value.

