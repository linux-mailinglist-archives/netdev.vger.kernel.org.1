Return-Path: <netdev+bounces-252865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGVLBPCSc2ntxAAAu9opvQ
	(envelope-from <netdev+bounces-252865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:25:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A0377C36
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A2F3029AC3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83B266B67;
	Fri, 23 Jan 2026 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNCmhFTJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A95VLlEc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9376F224234
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181928; cv=none; b=OUycaiGw5Tn4nJmkrnRfmVzmkWKHabl+tI4xosWpewxCEGfctTy+1a6vzM+BpqkrC9PIzKGM3CYMIGs94KYlGBekdknxC9+fQ5FoNq1oZJK27TthQMjiqNSpq2dkNg1aB1EfJAmbmf5umMkDIXYUsaec751DOPLsaEwfDM2y/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181928; c=relaxed/simple;
	bh=TPilFpdJp1Go0cVxzJ2Y8EYCjgED8qeptbTOPq2pfCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWYpKLYWGGoVgQDyVUqWA7y6uqDY2xA7d+zvGY6NumuylPQemRuE/hRymbElvN1suxGfGVvOPNylLkf0a3tY8kIXQlPWAEqXS3zf4tZi7AqiqTZmahRruFcltQBAjYNcpB8aUKrThUOK2/9X/mLe8mvA1tyOj1HNmQqLcy7whAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNCmhFTJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A95VLlEc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769181926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Now7tdOfyzhUbO7RxdUCeN8d0nGZ8UI+KA1797d1YFY=;
	b=eNCmhFTJDobslk7iZUo8+u0DkN4XwEIcJctVf88HTYLLY4F3LRMCZmaxoW1T1thUEMz/gt
	ipb3Thl/thjwY7MS5t0mCoCZsj8CmXHZVOVZUtnEiiKnCAkFPGPi+EkOxGPx096uYfTbxi
	kWBUQXgSV5Smx3FMvoSjZ6nn3PcdPfU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-iCbu55MnMsizRX4l2FZbJQ-1; Fri, 23 Jan 2026 10:25:25 -0500
X-MC-Unique: iCbu55MnMsizRX4l2FZbJQ-1
X-Mimecast-MFC-AGG-ID: iCbu55MnMsizRX4l2FZbJQ_1769181924
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435991d4a3aso1290620f8f.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769181924; x=1769786724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Now7tdOfyzhUbO7RxdUCeN8d0nGZ8UI+KA1797d1YFY=;
        b=A95VLlEcFZN721A2rIGS8UeiLtnrnhI5VbKxn0Bgd00irond9vaejEou45u9741tyH
         ThtMIONpEzlyFqNCQiNJIXuO7cQholHTm4dTWPJiE+gH+nAMatvW2H1JdNqypF8G9Qzg
         /Wc9jE356RG3LQg3XmpFP0P0wtK9XxTSJ5FzRLcnULlcs58kkYewskWS9YGnOcsIqJm/
         Vdh3N73pjKcvoV50yN4/iMONO8DqLVNrHa4lzrjHZO6AM793J4RIAs806Q3qcKzcvFOk
         DcReTTJqSaWvEY6BzGd1Zq0/2al8ZfRKSoaO92EBLexVOPslrJzEz1l5bK4WzVGEbIuu
         TQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769181924; x=1769786724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Now7tdOfyzhUbO7RxdUCeN8d0nGZ8UI+KA1797d1YFY=;
        b=NNQdvmrNOLGGcku34dcXxkuUvgcXYeRz2hAG9B/4+MFASbx+hlFHgcjIBHEfz1AamL
         wdjfrTl7pqrmy4LrIJteerqP3z7xcfB8/QT3EW0OvErRA5KRNf8TqgKIa8vig7NIMo3e
         hxAkaaf6vQkjatZ2tIiGgw/fJij6D/+B3LTLMgwOoViwVDOqntbASji3EoppEqd1fucO
         6FCP5xZ9uFAsoaU35zy818y/j0ZML9Y0pPZ5nc62CRHsZJIfXUWBJUQSHR25cDL/Ha0T
         ZKrRB6SNCn5UJdIaUqWAVgHF2zruokoa2RatFGu0/EsGDoo+t+OR94SoIZfcE7V5zxMC
         Ja+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRM/mRb3xMWu7N1IE+Ud2LWGc2PtZFJKAGPF3qYWLIYrEnp5Vw/YlXXgF1IQb6tQsPxfRBQes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/sE2y56nAvU76ZKnWhpSKGztoCa2j0ARSkcTDi2vcHfO7jS5h
	SJYIZa2hUCe1sHo84aaKbbokdIPuFa6Dd1EnH5r/m1TND9e8/8vPNCzvFwEzdXBXbEQfL5jrCAk
	sHq+toJ9z37FjvaPBaS/MEAYlxGOJVIPyXiH4QtpdcCd/YFVwAJEscdzzHSWrA9k25g==
X-Gm-Gg: AZuq6aL47j1B+yEx3KwJbZX3NcAXjwS/+QraD3lSzGanIFyM7e7LCjOPBFw7lrxKKxQ
	R8WVamfBXKtnH96RZWnYwsMBFQFGr3RoYOsuIEs3lKGTdKF9TvPuWK7NMFROGE4czqIveBUAQyB
	h+XDobFKQBdP//SvZN8WE1g/LiaIHWZMG4hI+YeUXqR1JdXOhm5dkomtD6O1LbUi5DVgKD71zyO
	XjL9R3yKMuGqSBOzvVD5YXm5WEjiavOEgP9007jYsPKxbdj3eoPSbW02wfsjDkUstnBtR2ektJv
	w2wcA6Zzflt3lTSxaqLmy74IB631fwK9IHUwXEiIMNoDau4n5MNbBegrPVUZMOq504kEITauZer
	WIhIhvLF+ijzN
X-Received: by 2002:a05:6000:40cb:b0:430:f790:99d7 with SMTP id ffacd0b85a97d-435b94f5e8cmr3073287f8f.27.1769181923681;
        Fri, 23 Jan 2026 07:25:23 -0800 (PST)
X-Received: by 2002:a05:6000:40cb:b0:430:f790:99d7 with SMTP id ffacd0b85a97d-435b94f5e8cmr3073230f8f.27.1769181923223;
        Fri, 23 Jan 2026 07:25:23 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02ba3sm7442499f8f.2.2026.01.23.07.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 07:25:22 -0800 (PST)
Message-ID: <05b086b3-c82d-4aba-b185-2d39ba968a72@redhat.com>
Date: Fri, 23 Jan 2026 16:25:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Mahdi Faramarzpour <mahdifrmx@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, kshitiz.bartariya@zohomail.in
References: <20260122185357.50922-1-mahdifrmx@gmail.com>
 <willemdebruijn.kernel.1682586fd684e@gmail.com>
 <60ed19a1-97e1-4342-8dfc-a5db684afa6f@redhat.com>
 <willemdebruijn.kernel.2b69585efeb5a@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <willemdebruijn.kernel.2b69585efeb5a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252865-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51A0377C36
X-Rspamd-Action: no action

On 1/23/26 3:41 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> I think that doing the SNMP accounting in __udp_enqueue_schedule_skb()
>> (for `to_drop`), __udp_queue_rcv_skb() and __udpv6_queue_rcv_skb() (for
>> `skb`) is a little confusing and possible error prone in the long run.
>>
>> I'm wondering if something alike the following (completely untested, not
>> even built! just to give the idea) would be better?
> 
> I don't see the error prone issue with the simpler patch.
> But SGTM if you prefer this.
It's not a big deal but if we need to update the UDP MIB someday having
to look in different places could cause missing something.

The code I proposed could be made smaller with something alike the
following (still completely untested), which in turn looks quite alike
what this patch is heading, I guess. So really it's not a big deal.
---
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 1db63db7e5d4..431de8dda0d3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1793,6 +1795,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
struct sk_buff *skb)
 		}
 	}

+	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
 	if (unlikely(to_drop)) {
 		for (nb = 0; to_drop != NULL; nb++) {
 			skb = to_drop;
@@ -1802,10 +1805,9 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
struct sk_buff *skb)
 			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		}
 		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
+		return nb;
 	}

-	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
-
 	return 0;

 drop:
@@ -2345,6 +2347,9 @@ static int __udp_queue_rcv_skb(struct sock *sk,
struct sk_buff *skb)
 	}

 	rc = __udp_enqueue_schedule_skb(sk, skb);
+	if (likely(!rc))
+		return 0;
+
 	if (rc < 0) {
 		int is_udplite = IS_UDPLITE(sk);
 		int drop_reason;
@@ -2365,6 +2370,9 @@ static int __udp_queue_rcv_skb(struct sock *sk,
struct sk_buff *skb)
 		return -1;
 	}

+	/* rc > 0, packets dropped after dequeueing from prod_queue */
+	SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS, rc);
+	SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS, rc);
 	return 0;
 }

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 010b909275dd..df895096669e 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -793,6 +793,9 @@ static int __udpv6_queue_rcv_skb(struct sock *sk,
struct sk_buff *skb)
 	}

 	rc = __udp_enqueue_schedule_skb(sk, skb);
+	if (likely(!rc))
+		return 0;
+
 	if (rc < 0) {
 		int is_udplite = IS_UDPLITE(sk);
 		enum skb_drop_reason drop_reason;
@@ -813,6 +816,9 @@ static int __udpv6_queue_rcv_skb(struct sock *sk,
struct sk_buff *skb)
 		return -1;
 	}

+	/* rc > 0, packets dropped after dequeueing from prod_queue */
+	SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_MEMERRORS, rc);
+	SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_INERRORS, rc);
 	return 0;
 }


