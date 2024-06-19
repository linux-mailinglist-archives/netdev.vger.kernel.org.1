Return-Path: <netdev+bounces-104979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F6690F5D6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23D7283BF8
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB47E155346;
	Wed, 19 Jun 2024 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="IHkpaH0F"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E4320F
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820928; cv=none; b=kv8nQrOAXEEeafvMHd26VTkcKZi+EzvCY+1eUjcptVEFHVdMJZoI11UvnkuOYwWt+y+HKs5hjrb/S/n8ig2/KrY4n8NlOmXyoLw1VPunF1VESBv9OYdsv1lDKEE3vBEtEEXzN2DMclI26lzDE8OpDUgdEe4AuRWJ+sODhnEta/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820928; c=relaxed/simple;
	bh=EsaodKkEk1PnzHG0dvc/ur1WSpN9L9axyQJtFhQ9QIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SklcaVhl0Ep9V+rRrcBoMMQCPRjRvHB2jy4NBXIIuaGdbjFo9O+igpiRA48wEI65BFckkaJ8I1OM1na6qkyPZBRxAJtSXiJP5I0aDlvtkv49f29JRNcrU6aQ7tROuFkpdCKjbuw9nohZMGudjioac7VjM9tv6TBJ/Y279vuk+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=IHkpaH0F; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sJzpg-002FaM-4o; Wed, 19 Jun 2024 20:14:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=BKNeD/PPkNYrjk+2Z9+eyWLbx+kXVSZpgWTjBmnmMK4=; b=IHkpaH0F77FXbCcMsL00Rwg3CF
	aR5BdeVM992lKMkphLgJXG/0A3+YqfJCuu0N1Wbdn6syY6K/zoJEPF0TInG6lHOB+Ibepewk+YmQi
	fsMBGbbklaxW7OWrIGOTZvUbKGZGqddxArBI4BIBVvnwhn6KMvBaB7Gy9u0iVGDtpEVvdCY7vh4ok
	L/ggUbpakQtfkAyh13Xvf7Go51b5XlMMDFlSitM4umPfSe4jx6bkbTzO9fcvGRhuuSKa2k07uwFIQ
	frOFpgC6jbEMzJQW22AqlVpskS1yJpBeXy7iLnwE7jO+8hBbPp6fR9OiYRRMHWkozHyXCGBmUMAoe
	mRBq0EWA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sJzpZ-0007Yk-Vf; Wed, 19 Jun 2024 20:14:50 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sJzpZ-00DWQI-8I; Wed, 19 Jun 2024 20:14:49 +0200
Message-ID: <17997c8f-bba1-4597-85c7-5d76de63a7a7@rbox.co>
Date: Wed, 19 Jun 2024 20:14:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under
 unix_state_lock() for truly disconencted peer.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <4b894ffd-9fe2-4c15-a901-6765ab538a01@rbox.co>
 <20240617182146.62299-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240617182146.62299-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/24 20:21, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Mon, 17 Jun 2024 01:28:52 +0200
>> (...)
>> Another AF_UNIX sockmap issue is with OOB. When OOB packet is sent, skb is
>> added to recv queue, but also u->oob_skb is set. Here's the problem: when
>> this skb goes through bpf_sk_redirect_map() and is moved between socks,
>> oob_skb remains set on the original sock.
> 
> Good catch!
> 
>>
>> [   23.688994] WARNING: CPU: 2 PID: 993 at net/unix/garbage.c:351 unix_collect_queue+0x6c/0xb0
>> [   23.689019] CPU: 2 PID: 993 Comm: kworker/u32:13 Not tainted 6.10.0-rc2+ #137
>> [   23.689021] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
>> [   23.689024] Workqueue: events_unbound __unix_gc
>> [   23.689027] RIP: 0010:unix_collect_queue+0x6c/0xb0
>>
>> I wanted to write a patch, but then I realized I'm not sure what's the
>> expected behaviour. Should the oob_skb setting follow to the skb's new sock
>> or should it be dropped (similarly to what is happening today with
>> scm_fp_list, i.e. redirect strips inflights)?
> 
> The former will require large refactoring as we need to check if the
> redirect happens for BPF_F_INGRESS and if the redirected sk is also
> SOCK_STREAM etc.
> 
> So, I'd go with the latter.  Probably we can check if skb is u->oob_skb
> and drop OOB data and retry next in unix_stream_read_skb(), and forbid
> MSG_OOB in unix_bpf_recvmsg().
> (...)

Yeah, sounds reasonable. I'm just not sure I understand the retry part. For
each skb_queue_tail() there's one ->sk_data_ready() (which does
->read_skb()). Why bother with a retry?

This is what I was thinking:

 static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
+	struct unix_sock *u = unix_sk(sk);
+	struct sk_buff *skb;
+	int err;
+
 	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED))
 		return -ENOTCONN;
 
-	return unix_read_skb(sk, recv_actor);
+	mutex_lock(&u->iolock);
+	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	if (skb) {
+		bool drop = false;
+
+		spin_lock(&sk->sk_receive_queue.lock);
+		if (skb == u->oob_skb) {
+			WRITE_ONCE(u->oob_skb, NULL);
+			drop = true;
+		}
+		spin_unlock(&sk->sk_receive_queue.lock);
+
+		if (drop) {
+			WARN_ON_ONCE(skb_unref(skb));
+			kfree_skb(skb);
+			skb = NULL;
+			err = 0;
+		}
+	}
+#endif
+
+	mutex_unlock(&u->iolock);
+	return skb ? recv_actor(sk, skb) : err;
 }

