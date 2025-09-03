Return-Path: <netdev+bounces-219551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE1FB41DC4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5907D548E84
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BA83009FF;
	Wed,  3 Sep 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eU6u4n5D"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB542F8BC8
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900314; cv=none; b=razAz0xXkgynog//SA6CSzU+6LQKke/YLNPZ4haZJtIVyMvp9x2zpUHlR6sNH5mcoFJAzr3JssyXdkbMURj5UdFs9jFcDps51+rX/L2wKiB1H+HC3o25XzlOfPpOWRcDlaVeJBhGjk3Jq/XgL2gDli7mKRgouvHHxgmCO1K5558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900314; c=relaxed/simple;
	bh=vjZCdrKe6hOD7Yv2fX2UA7ueGYqP1Vng6fVS60zb4HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Da5rVDkBB+hZlQrEc69MfMuBfiCLfc7OA+j7hvbiPcUWlkE0NPWz6xyzmSQm1ENYVAh9reMQlMAU5uvx+5W4wlBE5ii+wu6rUjU2fU1pp2Hql0OD2Y5QmFyUoNyUDhVqEMNIzVtB0csMIxfzu6jj1Ot/CTTVfj0BySvlqoz1neU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eU6u4n5D; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b6a40fe0-09da-4b84-aa8d-0dcebf15d822@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756900309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oOpPo9rfvuietfnhT1ULTm8FPMp1Hb2NvfdmaZ4rz/4=;
	b=eU6u4n5D518nrFJjvI6lafeqMMKUYLzLVrYB3+xgupfmh/X7LVNdLvhcvR/8zFsknTxK7B
	eaKPOr333gO2RZ30g1V/GPhcMrbIFZzLccPLY9CRU6EKrSIbXe4PzJlKA2uPYoYQdqoZW0
	Gr7Z8CnpnCyrV2C0ivepnscuhs6dDqw=
Date: Wed, 3 Sep 2025 19:51:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] inet: Avoid established lookup missing active sk
To: Eric Dumazet <edumazet@google.com>
Cc: kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
 kernelxing@tencent.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20250903024406.2418362-1-xuanqiang.luo@linux.dev>
 <CANn89i+XH95h4UANWpR-39LSRkvM3LL=_pRL0+6fp6dwTZxn_g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <CANn89i+XH95h4UANWpR-39LSRkvM3LL=_pRL0+6fp6dwTZxn_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/3 14:40, Eric Dumazet 写道:
> On Tue, Sep 2, 2025 at 7:46 PM Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> Since the lookup of sk in ehash is lockless, when one CPU is performing a
>> lookup while another CPU is executing delete and insert operations
>> (deleting reqsk and inserting sk), the lookup CPU may miss either of
>> them, if sk cannot be found, an RST may be sent.
>>
>> The call trace map is drawn as follows:
>>     CPU 0                           CPU 1
>>     -----                           -----
>>                                  spin_lock()
>>                                  sk_nulls_del_node_init_rcu(osk)
>> __inet_lookup_established()
>>                                  __sk_nulls_add_node_rcu(sk, list)
>>                                  spin_unlock()
>>
>> We can try using spin_lock()/spin_unlock() to wait for ehash updates
>> (ensuring all deletions and insertions are completed) after a failed
>> lookup in ehash, then lookup sk again after the update. Since the sk
>> expected to be found is unlikely to encounter the aforementioned scenario
>> multiple times consecutively, we only need one update.
> No need for a lock really...
> - add the new node (with a temporary 'wrong' nulls value),
> - delete the old node
> - replace the nulls value by the expected one.
>
Hi Eric, May I ask if your main purpose is to add a temporary 'wrong' 
nulls to trigger a re-lookup in the lookup, until the real new sk is 
successfully replaced, like the following code (rough code)?

Thanks
Xuanqiang

--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -526,6 +526,8 @@ struct sock *__inet_lookup_established(const struct net *net,
       * not the expected one, we must restart lookup.
       * We probably met an item that was moved to another chain.
       */
+
+    /* Here, temporary NULL values cause a re-lookup. */
      if (get_nulls_value(node) != slot)
          goto begin;
  out:
@@ -684,7 +686,34 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
  
      spin_lock(lock);
      if (osk) {
+        struct hlist_nulls_node *i, *last = NULL, *n = &sk->sk_nulls_node;
          WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
+
+        /* find the last node in the list */
+        for (i = list->first; !is_a_nulls(i); i = i->next)
+            last = i;
+
+        if (last) {
+            /* save the original nulls values  */
+            i = last->next;
+
+            /* 1. add the temporary 'wrong' nulls value */
+            rcu_assign_pointer(hlist_nulls_next_rcu(last),
+                       (struct hlist_nulls_node *)NULLS_MARKER(NULL));
+
+            /* 2. delete the old node */
+            ret = sk_nulls_del_node_init_rcu(osk);
+
+            /* 3. add the new node */
+            if (ret) {
+                WRITE_ONCE(n->next, i);
+                n->pprev = &last->next;
+                rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
+            } else {
+                rcu_assign_pointer(hlist_nulls_next_rcu(last), i);
+            }
+            goto unlock;
+        }
          ret = sk_nulls_del_node_init_rcu(osk);
      } else if (found_dup_sk) {
          *found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
@@ -695,6 +724,7 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
      if (ret)
          __sk_nulls_add_node_rcu(sk, list);
  
+unlock:
      spin_unlock(lock);
  
      return ret;


