Return-Path: <netdev+bounces-252685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Kn0CMUuc2mTswAAu9opvQ
	(envelope-from <netdev+bounces-252685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:18:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A2872537
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CCDB302A6D5
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73434405F;
	Fri, 23 Jan 2026 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkBN1Yh9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mr/xdLY0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053D308F2E
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156054; cv=none; b=fi8m3mY5oE4DJiu1viOg2APR2AnR40dRnEvSKjZJITdNJo5zM1Ukf9gwLHJ4o74E1O2qrJrGgffctnY5cISXvnLpV3eC6XciQNJwKvDi6joawN+CKbWDusCKo6Iu6I5TdT3+/xCzYrwJTxk5ZX/cuKde4e4kANnUuBkf4xMLawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156054; c=relaxed/simple;
	bh=DmQW5z8oZn1rOIHFFsFCMso8GAYkWZwW086RWgaAgoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyHTJ2eviUkBNr2i6eDeKIq9gPB6BoeyzxqwCJMrTsg9UV5FXsUgATJPLKLw6Aw/cgDfc8nUTU5588+3or8XcfUQEX7zAhvmZZiM5Xn5V2cfyz3eB1EBkhngTy5yY8hsWqUZTEiQrVQXLrSyY61/v/AtrwUkam7wtH1vTZV8Rkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkBN1Yh9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mr/xdLY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769156051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzEfV1jz0zhOiOT9COdmIzS6u1ujWo47exY0xdd1fnE=;
	b=HkBN1Yh9oMRXXkCYjr+P75U7CCrBKSCvPCvc+rFl/zY6kqh6uhlj3K6VLTjrjWb45XNmcJ
	dTXzBLMarDRCOffQoCnKjlpU3bK7bU8tPkJh5M67Jgf7eQFbw1RbdLMDrlH/2/ySuXv2cV
	6jPYKPDIM+w3H6Do1LPq/cb2zjQB2Pg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-339gvTpRNF2pSMcdlz-Gig-1; Fri, 23 Jan 2026 03:14:09 -0500
X-MC-Unique: 339gvTpRNF2pSMcdlz-Gig-1
X-Mimecast-MFC-AGG-ID: 339gvTpRNF2pSMcdlz-Gig_1769156049
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so14729215e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 00:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769156048; x=1769760848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzEfV1jz0zhOiOT9COdmIzS6u1ujWo47exY0xdd1fnE=;
        b=mr/xdLY0L1TfP2xzXvQ4REi+8Qm2G6DDqvCZZIPYFwIsIGh50FNhP48vRs97qDJUxp
         dwN287rr+UXTDfC0++FSBkC3YuGjntrpO3hmZbK0xBbpTc/rbHBWdfyFRwAtiHYbT/pH
         b7MZbh3+zzQ5CUxZ298sDpVo6BKOPLYyCU3yHnh8CGejzswyWBbfGmv2V4cXX4JpkcQv
         eUu/Aq5/+fvG55wAgoWTBYsckFfkalxrBoLCvQnLuHc8Da2FiJw+TmuyqjsQpszod63B
         FeNvIW5etKU03AegYYHZ3cqr0/j5zo5v5s+UQRkTsziC0Vikxy610Q5xHcX7ZoKbg8H3
         MQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769156048; x=1769760848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzEfV1jz0zhOiOT9COdmIzS6u1ujWo47exY0xdd1fnE=;
        b=lJjIUZP3pFzlv2SVavwCpQu9ScZ50nx6OEHcS2YFH0KF2ggOailUAqeN+nRv1yssTj
         deO+HXcKlTnZCHbl3NMF1EsRSfs2EB+OGQrHHV5SLt5i6vzD7sttyzmMvEpwUiOWuNS5
         n84AC28GseqkMG74Fid3Yw6iU2W8FQ3xzoVPt1y6QUSWNTMSFMgDh4IsmeaLvxeptit5
         1DR/ujT9WCapARWhJOt8KtSbxJ2UEWqGdY+7luNq7vuM35u1cxAyL2DKAqp+m71OwtaH
         Jxqlj69emQFcVif0DUFWgLtAkAaoPHfuWtBpgk+AGEXhFtftkLLQgI31PX07dYfh27Od
         cFew==
X-Forwarded-Encrypted: i=1; AJvYcCUBbF18cfQQCrRe4I8VwQ/EHLqXLMkyjhlToWwhWEsB57HRtKzv0GvSmlOJ/KdeeNEAf2Hr8yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwznTJTV8v31PD+BzVxAeJ0/yKaN5D4qLF9twiR1qgD/OPfBF/3
	CfaMqgv+SC0oSr/ruUXMb3dMUYtgaAW+nklS3FW8hRETWZIEzc+rk9HxNB0dxPRHJzkGGtaMvBc
	AwApm0bZL+ve4kq2OKWcMaG2YONNk2UN2shfzKxxmS/C6v8enFLCajVhrcA==
X-Gm-Gg: AZuq6aJ5kZWXwFCmXJk79mHamUmvHIfan6Pu7oViyrc/ZFPh/RO6AYpRpmDiB8lfigb
	o/Rh7YFQVpaNT9yRUjzQw/sNomYCzZ16KS58d1XnqrIfbFMkjW3uEUgeYolPlY7awDa797gHvqB
	gkvaETV+Hx3vF1iq+qDlsKYi69OrkyiUBNjVGMPH6nPofvaOSJ1lTRnJ7nuh1XD9c871HPG55G2
	jSRZ/GB6chEwsViP/Qd2dl6iXy0TX1pYpm9tu1JVIiF99mOJ97viOuXYVK0w5Z40vbNomjYOmmE
	FTXwKCsmMOjeSVN/evum64Mcq0JjgXjeivsvtb3qi1C0+38FKeS9i3FLbBuaSaHCeCLHvRzZi7k
	hxPfDqI6CgrIQ
X-Received: by 2002:a05:600c:c174:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-4804c95872emr36919635e9.10.1769156048515;
        Fri, 23 Jan 2026 00:14:08 -0800 (PST)
X-Received: by 2002:a05:600c:c174:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-4804c95872emr36919265e9.10.1769156048050;
        Fri, 23 Jan 2026 00:14:08 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85206fsm38711895e9.6.2026.01.23.00.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 00:14:07 -0800 (PST)
Message-ID: <60ed19a1-97e1-4342-8dfc-a5db684afa6f@redhat.com>
Date: Fri, 23 Jan 2026 09:14:06 +0100
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <willemdebruijn.kernel.1682586fd684e@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-252685-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A0A2872537
X-Rspamd-Action: no action

On 1/22/26 10:26 PM, Willem de Bruijn wrote:
> Mahdi Faramarzpour wrote:
>> This commit adds SNMP drop count increment for the packets in
>> per NUMA queues which were introduced in commit b650bf0977d3
>> ("udp: remove busylock and add per NUMA queues"). note that SNMP
>> counters are incremented currently by the caller for skb. And
>> that these skbs on the intermediate queue cannot be counted
>> there so need similar logic in their error path.
>>
>> Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
>> ---
>> v5:
>>   - check if drop counts are non-zero before increasing countrers
>> v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx@gmail.com/
>>   - move all changes to unlikely(to_drop) branch
>> v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gmail.com/
>>   - remove the unreachable UDP_MIB_RCVBUFERRORS code
>> v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@gmail.com/
>>   - change ENOMEM to ENOBUFS
>> v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@gmail.com/
>> ---
>>  net/ipv4/udp.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index ffe074cb5..41cf8f7ab 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -1793,14 +1793,31 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>>  	}
>>  
>>  	if (unlikely(to_drop)) {
>> +		int err_ipv4 = 0;
>> +		int err_ipv6 = 0;
> 
> nit: whitespace between variable definition and code block
> 
>>  		for (nb = 0; to_drop != NULL; nb++) {
>>  			skb = to_drop;
>> +			if (skb->protocol == htons(ETH_P_IP))
>> +				err_ipv4++;
>> +			else
>> +				err_ipv6++;
> 
> No need for separate counters.
> 
> All counters will either update IPv4 or IPv6 stats. Similar to how
> the caller of _udp_enqueue_schedule_sk is either __udp_queue_rcv_skb
> or __udpv6_queue_rcv_skb and chooses the SNMP stat based on that.
> 
> Can check sk_family == PF_INET6 once.

I think that doing the SNMP accounting in __udp_enqueue_schedule_skb()
(for `to_drop`), __udp_queue_rcv_skb() and __udpv6_queue_rcv_skb() (for
`skb`) is a little confusing and possible error prone in the long run.

I'm wondering if something alike the following (completely untested, not
even built! just to give the idea) would be better?

Note that the additional argument in __udp_enqueue_schedule_skb() could
be avoided piggybacking the `to_drop` return argument into the
__udp_enqueue_schedule_skb() return value.

---
diff --git a/include/net/udp.h b/include/net/udp.h
index a061d1b22ddc..673497eb79b7 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -399,7 +399,8 @@ static inline bool udp_sk_bound_dev_eq(const struct
net *net, int bound_dev_if,
 /* net/ipv4/udp.c */
 void udp_destruct_common(struct sock *sk);
 void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len);
-int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb);
+int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb,
+			       struct sk_buff *to_drop);
 void udp_skb_destructor(struct sock *sk, struct sk_buff *skb);
 struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags, int
*off,
 			       int *err);
@@ -411,6 +412,21 @@ static inline struct sk_buff *skb_recv_udp(struct
sock *sk, unsigned int flags,
 	return __skb_recv_udp(sk, flags, &off, err);
 }

+static inline int udp_drop_skbs(struct sock *sk, struct sk_buff *to_drop)
+{
+	struct sk_buff *skb;
+	int nb;
+
+	for (nb = 0; to_drop != NULL; nb++) {
+		skb = to_drop;
+		to_drop = skb->next;
+		skb_mark_not_on_list(skb);
+		sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
+	}
+	numa_drop_add(&udp_sk(sk)->drop_counters, nb);
+	return nb;
+}
+
 enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb);
 bool udp_sk_rx_dst_set(struct sock *sk, struct dst_entry *dst);
 int udp_err(struct sk_buff *, u32);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ee63af0ef42c..0869e115c0d3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1696,14 +1696,15 @@ static int udp_rmem_schedule(struct sock *sk,
int size)
 	return 0;
 }

-int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
+int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb,
+			       struct sk_buff **to_drop)
 {
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 	struct udp_prod_queue *udp_prod_queue;
-	struct sk_buff *next, *to_drop = NULL;
 	struct llist_node *ll_list;
 	unsigned int rmem, rcvbuf;
 	int size, err = -ENOMEM;
+	struct sk_buff *next;
 	int total_size = 0;
 	int q_size = 0;
 	int dropcount;
@@ -1761,8 +1762,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
struct sk_buff *skb)
 		err = udp_rmem_schedule(sk, size);
 		if (unlikely(err)) {
 			/*  Free the skbs outside of locked section. */
-			skb->next = to_drop;
-			to_drop = skb;
+			skb->next = *to_drop;
+			*to_drop = skb;
 			continue;
 		}

@@ -1792,17 +1793,6 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
struct sk_buff *skb)
 		}
 	}

-	if (unlikely(to_drop)) {
-		for (nb = 0; to_drop != NULL; nb++) {
-			skb = to_drop;
-			to_drop = skb->next;
-			skb_mark_not_on_list(skb);
-			/* TODO: update SNMP values. */
-			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
-		}
-		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
-	}
-
 	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);

 	return 0;
@@ -2333,6 +2323,7 @@ void udp_v4_rehash(struct sock *sk)

 static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
+	struct sk_buff *to_drop = NULL;
 	int rc;

 	if (inet_sk(sk)->inet_daddr) {
@@ -2343,7 +2334,13 @@ static int __udp_queue_rcv_skb(struct sock *sk,
struct sk_buff *skb)
 		sk_mark_napi_id_once(sk, skb);
 	}

-	rc = __udp_enqueue_schedule_skb(sk, skb);
+	rc = __udp_enqueue_schedule_skb(sk, skb, &to_drop);
+	if (unlikely(to_drop)) {
+		int cnt = udp_drop_skb_list(sk, to_drop);
+
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS, cnt);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS, cnt);
+	}
 	if (rc < 0) {
 		int is_udplite = IS_UDPLITE(sk);
 		int drop_reason;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 794c13674e8a..5950ec699deb 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -782,6 +782,7 @@ int __udp6_lib_err(struct sk_buff *skb, struct
inet6_skb_parm *opt,

 static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
+	struct sk_buff *to_drop = NULL;
 	int rc;

 	if (!ipv6_addr_any(&sk->sk_v6_daddr)) {
@@ -792,7 +793,13 @@ static int __udpv6_queue_rcv_skb(struct sock *sk,
struct sk_buff *skb)
 		sk_mark_napi_id_once(sk, skb);
 	}

-	rc = __udp_enqueue_schedule_skb(sk, skb);
+	rc = __udp_enqueue_schedule_skb(sk, skb, &to_drop);
+	if (unlikely(to_drop)) {
+		int cnt = udp_drop_skb_list(sk, to_drop);
+
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS, cnt);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS, cnt);
+	}
 	if (rc < 0) {
 		int is_udplite = IS_UDPLITE(sk);
 		enum skb_drop_reason drop_reason;


