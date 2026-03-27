Return-Path: <netdev+bounces-272394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH8PAnwvxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:19:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B21D340487
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2FDD3029A4F
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B643A0B1C;
	Fri, 27 Mar 2026 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="qK59/itL"
X-Original-To: netdev@vger.kernel.org
Received: from proxy25215.mail.163.com (proxy25215.mail.163.com [103.129.252.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEE0308F32
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.252.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774595469; cv=none; b=ARl3fuKLN+l/rpdr0TdKKLoLvbk1N/2Rt+Y3B8KM7TjCxgguy3KG6XAHe9JGYPrEVt/Bq3DBj3SaKhE4HeOit0VbWGghmAsFeCkx9rRP8ry9TlVt8MFKtyb5xuVaWOyk7qDVkJeyHo8mutQKugxigRniA28YRc7yzKB7ZfBH2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774595469; c=relaxed/simple;
	bh=WLyYBDOkzzIib7KF1KV+2xfIxpOUuLqBUvzOftzWATQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwHPsIYaIKklh/a+y2hXcBzFLA21ZYOOdKzNhrow5zcARpnO7bu9Dzmr1HdGSFDM7jAOUUW8W9zfZCtiE9ziWv56PDgYdUUFd2D9AEAjbqIRnGqhVnc90pu5q2tz4OQISirbNND5Jh6K4jchbSjY8b7pLiwVPA0IxeTWuOHsgVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=qK59/itL; arc=none smtp.client-ip=103.129.252.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=mK3Xtv8HvNxzR7EH6GYGKhF/usSkb9yCTOWB4guSYu8=;
	b=qK59/itL7VlT0GDqUffzI8GraLFMSdY7kjPa4V0hbukx+hLZtcmlo46OX36DQn
	VXBgnrppevgbidsQt6LTSGjo8eRbcGCHbIGkp6gV6nwT0pALNPCcBs/44kvAbQ/H
	EHmD2mOxKvW2HGQEc04zu2sGB/jLJ9vt/7thUlue5AF2A=
Received: from [7.247.167.152] (unknown [])
	by gzsmtp3 (Coremail) with UTF8SMTPA id M88vCgD3j+VELMZplDtDAA--.57480S2;
	Fri, 27 Mar 2026 15:05:41 +0800 (CST)
Message-ID: <a39bee2b-7b73-4844-a2fc-475120e3d320@yeah.net>
Date: Fri, 27 Mar 2026 15:05:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/dst: improve dst_ops refcounting with
 per-dst bit
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20260324073750.1500328-1-edumazet@google.com>
 <ac86fb62-d036-47af-b8ed-9d1f4ba2a835@yeah.net>
 <CANn89iL1cex3LK824Wke0URGqRv+fD16vUdM0y=dvdPgPqgdhA@mail.gmail.com>
From: xietangxin <xietangxin@yeah.net>
In-Reply-To: <CANn89iL1cex3LK824Wke0URGqRv+fD16vUdM0y=dvdPgPqgdhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:M88vCgD3j+VELMZplDtDAA--.57480S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1fZF18KF1rAF4kWr45ZFb_yoW5Xr1kpF
	1kZayFyFW5KFs2gFWkZa13W34agan5G3W7Ga4Yka4fJwnIqry8JF4DGryUCFn0yFWY9a90
	9FWUKFyUCF48Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCeHgUUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiIgYoXGnGLEa-cQAA3b
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272394-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yeah.net];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yeah.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B21D340487
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/27/2026 11:51 AM, Eric Dumazet wrote:
> On Tue, Mar 24, 2026 at 8:42 PM xietangxin <xietangxin@yeah.net> wrote:
>>
> 
>> Hi Eric,
>>
>> I tested your patch with my reproduction script, but the UAF still occurs
>> with a warning in dst_entries_destroy() just before the crash.
>>
>> The reason is that for IPv6, dst_entries on the rt6_uncached_list are
>> handled by rt6_uncached_list_flush_dev() during netns destruction,
>> which bypasses dst_dev_put().
>>
>> I tested add changes like dst_dev_put() inside rt6_uncached_list_flush_dev(),
>> the UAF is gone and the dst_entries_destroy warning no longer appears.
> 
> 
> Could you share  the incremental patch you added on top of mine ?
> 
> Thanks.

Hi Eric,

Sure. Here is the incremental patch that I added on top of your patch.

---
diff --git a/include/net/dst.h b/include/net/dst.h
index 793f38452bf4..393cc84b6aa5 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -401,6 +401,7 @@ void dst_init(struct dst_entry *dst, struct dst_ops *ops,
              struct net_device *dev, int initial_obsolete,
              unsigned short flags);
 void dst_dev_put(struct dst_entry *dst);
+void dst_count_dec(struct dst_entry *dst);

 static inline void dst_confirm(struct dst_entry *dst)
 {
diff --git a/net/core/dst.c b/net/core/dst.c
index d1efd3e7c44e..b5c5e04e10c1 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -139,7 +139,7 @@ static void dst_destroy_rcu(struct rcu_head *head)
    dst_destroy(dst);
 }

-static void dst_count_dec(struct dst_entry *dst)
+void dst_count_dec(struct dst_entry *dst)
 {
    struct dst_ops *ops = READ_ONCE(dst->ops);

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 658c0f742e45..9744a8e2fdc8 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -173,6 +173,7 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
            struct inet6_dev *rt_idev = rt->rt6i_idev;
            struct net_device *rt_dev = rt->dst.dev;
            bool handled = false;
+           struct dst_entry *dst = &rt->dst;

            if (rt_idev && rt_idev->dev == dev) {
                rt->rt6i_idev = in6_dev_get(blackhole_netdev);
@@ -181,14 +182,16 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
            }

            if (rt_dev == dev) {
-               rt->dst.dev = blackhole_netdev;
+               dst->dev = blackhole_netdev;
+               dst_count_dec(dst);
+               WRITE_ONCE(dst->ops, dst->ops->template);
                netdev_ref_replace(rt_dev, blackhole_netdev,
-                          &rt->dst.dev_tracker,
+                          &dst->dev_tracker,
                           GFP_ATOMIC);
                handled = true;
            }
            if (handled)
-               list_del_init(&rt->dst.rt_uncached);
+               list_del_init(&dst->rt_uncached);
        }
        spin_unlock_bh(&ul->lock);
    }

-- 
Best regards,
Tangxin Xie


