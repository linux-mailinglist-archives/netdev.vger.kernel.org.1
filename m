Return-Path: <netdev+bounces-299829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WpcEH4BBMWo2fgUAu9opvQ
	(envelope-from <netdev+bounces-299829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:28:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E2468F500
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:28:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MkSL+J4j;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299829-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299829-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E06E531305D9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435F435DA76;
	Tue, 16 Jun 2026 12:28:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CED31714A
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:28:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612889; cv=none; b=jMOHAa2FigesnllszNh3H4IKItOK9tFxlI5nM4xc+p1cjZMCf5W1KVu82BRoEKhTs0PubFXnLdLoPLx6kmYrlW0YDnXFcekgnSZPUmqZmRQUsBlxo+AtcKFQbCEawyiNvOg1HY/LFDAXKhIL9xO+s01qWQwtuTjR/7MIKIn/Tzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612889; c=relaxed/simple;
	bh=4ant24vn2jdRTX21sRflYNjD3h7p5KzuvQMevvhFwIo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T+TRdd1bxuXdJms6ZuZQaIYpJvYkR4AIJlMIhSDza9B0NzpDkQmXAZR2SEC6HmGZCjwxDDUdNpRWmOYy/SgUQu2eS6Fdg4k6dtDtsW3tJQAWuW7CCRpskIqFmaNsppXZRmjMA3fpzf9yHc9e/iNchLBBWET4tYI8GUwkkuF3esE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkSL+J4j; arc=none smtp.client-ip=74.125.82.177
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so536287eec.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781612886; x=1782217686; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyGPjaguuOxKf2tsRvxeo5mNta1TX/zd4QKLI95WEYw=;
        b=MkSL+J4js4a+RQXENDWkRsY/bB9uByckzfHnWY9IrC/2e8XrVoLxaGYKu+7/hTQqt6
         Z1ahvjmrX5Bso66affsb/Oa4VRtWI4EyGIh+V7b0qWDjmDv/gSENbILaqrQ5+KhBvIxW
         GPmlFxKgfanqs6DMMZz5I3oF8bVw7i9Q9/qDSp1Amekrz0QiLf9SnxAmUY7WXYJcgcDz
         hv8DYEutdy4ihdxlqOlJQNUDyTozrRS3uuQx+wErJ5pNLcUCdHcFmMkmYXauUv4pzZ5F
         6CH7xWBXwTvti7lXMhkUIW8+gtjPAszF9cleoyDdEpg1PAgvh6jBRN/hKF3+XX/zgud4
         wJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781612886; x=1782217686;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyGPjaguuOxKf2tsRvxeo5mNta1TX/zd4QKLI95WEYw=;
        b=J5gEoOmmc1XBThIA4LTGRFxQmFQi87EbPut827SXGcvuT2ZJ4KURc91zz9oH2CVVMk
         AHhfwVnziuv1sdb38eHL6uFnujM+VSAEM9HeK6PWq8cTz5soiUS0RV06ii5d3f7cvJ7G
         jX0wuPJ1BND4mfav/zArxSt8PDivtgntOCYFagzkWSF3XpNJ6jcrVuptWkjabOtK2LSk
         f9qC//B7inQa8ZeOjtDuRpPn76ZWIt/1tfZ2BhdvEpVX2yQq40YUjK2QiW+/flZrFIi2
         uDaiF+dzRtuTpp0xIWLQGRut63pzLFOqSiqYRLBb0vUvO+J3wGxT9xd2N1XtfT/7jxmo
         /ZpA==
X-Forwarded-Encrypted: i=1; AFNElJ92ZhMhMkopAOjsZpuOEtDYH47OMgby/w0GDf3FriIAzK5YaovEzXvx1QtsjgmOISQJ5WXN8EU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9pCrjfKuiiwSVKOBtD8HhnI9mL/UQUGphWyuzst18W9VqVA/
	2I6GKmIxLKuTyqF2Kp/LbKwu7sMqq8sFNGQML0s86aEESXki7aJWKUAH
X-Gm-Gg: Acq92OHAzbB+wWw68f1ebcCpvYGzLFfUqpt/MHSqY9exrOJzb5E4pJbeDYq4OhO+Trl
	dFWx0ZrVTWWdXfJDS7nWFRVGzlnOuFijnBte5Gj7rHJg/IQAA8Xti4suMVhyfwzPGGtmhBiRmXd
	CDL6Y7p3zoPWCwrfTJfmofhXu3RriXTPNvFuRp7Hg7hTKiYdAnAe9tMYgGTqlzVn1gjQH1wOMbv
	Q6H9DORZikmPnDkHtAikG1gdIVZr3qHPbdfOLj+QWObckRjBAe+GM5IWtT2lQgB0l9HnSAJ+AoR
	5j4tU26zLEm6JdcLJF73u04aumTUAN5zs+80wBQXqdYmZdPkyC5/zwK6j1ULFq5ydTV+2FUg5z5
	JGGZla+FMBK5hz/BEMC2ZZhWWY3zQIqC4H8TKA53SESvvIfVlJMkG2Ccp1Fk6YBf5nqk5UYd3SD
	IwvsKlsLbl+gKiD9kbVRlTuhXbDr/ecRYNClC+FONHQ7+gdsy2nSBvubsRYncr4w==
X-Received: by 2002:a05:7300:7309:b0:304:188d:d0be with SMTP id 5a478bee46e88-3082009b9eemr10717310eec.16.1781612886330;
        Tue, 16 Jun 2026 05:28:06 -0700 (PDT)
Received: from localhost ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb9a2e7sm18658588eec.30.2026.06.16.05.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 05:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 20:28:01 +0800
Message-Id: <DJAH22QT7OQ0.3O6KSPQWOE429@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>, "Jon Maloy"
 <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
Subject: Re: [PATCH net] tipc: fix use-after-free of discoverer in
 tipc_disc_rcv()
From: "Weiming Shi" <bestswngs@gmail.com>
To: "Tung Quang Nguyen" <tung.quang.nguyen@est.tech>, "Weiming Shi"
 <bestswngs@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260610153349.2546041-2-bestswngs@gmail.com>
 <GV1P189MB1988A1CFCAA9214B6F009315C6182@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988A1CFCAA9214B6F009315C6182@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:tung.quang.nguyen@est.tech,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[est.tech,gmail.com];
	TAGGED_FROM(0.00)[bounces-299829-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06E2468F500

On Fri Jun 12, 2026 at 4:53 PM CST, Tung Quang Nguyen wrote:
>>Subject: [PATCH net] tipc: fix use-after-free of discoverer in tipc_disc_=
rcv()
>>
>>bearer_disable() frees b->disc with tipc_disc_delete()'s plain kfree(), b=
ut
>>tipc_disc_rcv() still dereferences b->disc in RX softirq under
>>rcu_read_lock() (tipc_udp_recv -> tipc_rcv -> tipc_disc_rcv).
>>
>>L2 bearers are safe thanks to the synchronize_net() in tipc_disable_l2_me=
dia(),
>>but the UDP bearer defers that call to the
>>cleanup_bearer() workqueue, so the discoverer is freed with no grace
>>period:
>>
>> BUG: KASAN: slab-use-after-free in tipc_disc_rcv (net/tipc/discover.c:14=
9)
>>Read of size 8 at addr ffff88802348b728 by task poc_tipc/184  <IRQ>
>>  tipc_disc_rcv (net/tipc/discover.c:149)
>>  tipc_rcv (net/tipc/node.c:2126)
>>  tipc_udp_recv (net/tipc/udp_media.c:391)
>>  udp_rcv (net/ipv4/udp.c:2643)
>>  ip_local_deliver_finish (net/ipv4/ip_input.c:241)  </IRQ>  Freed by tas=
k 181:
>>  kfree (mm/slub.c:6565)
>>  bearer_disable (net/tipc/bearer.c:418)
>>  tipc_nl_bearer_disable (net/tipc/bearer.c:1001)
>>
>>The bearer is freed with kfree_rcu(); free the discoverer the same way.
>>Add an rcu_head to struct tipc_discoverer and free it and its skb from an=
 RCU
>>callback.
>>
>>Reachable from an unprivileged user namespace: the TIPCv2 genl family is
>>netnsok and its bearer commands have no GENL_ADMIN_PERM. Needs
>>CONFIG_TIPC and CONFIG_TIPC_MEDIA_UDP.
>>
>>Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash
>>values")
>>Reported-by: Xiang Mei <xmei5@asu.edu>
>>Assisted-by: Claude:claude-opus-4-8
>>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>>---
>> net/tipc/discover.c | 13 +++++++++++--
>> 1 file changed, 11 insertions(+), 2 deletions(-)
>>
>>diff --git a/net/tipc/discover.c b/net/tipc/discover.c index
>>3e54d2df5683a..34dbe5ad10e09 100644
>>--- a/net/tipc/discover.c
>>+++ b/net/tipc/discover.c
>>@@ -58,6 +58,7 @@
>>  * @skb: request message to be (repeatedly) sent
>>  * @timer: timer governing period between requests
>>  * @timer_intv: current interval between requests (in ms)
>>+ * @rcu: RCU head for deferred freeing
>>  */
>> struct tipc_discoverer {
>> 	u32 bearer_id;
>>@@ -69,6 +70,7 @@ struct tipc_discoverer {
>> 	struct sk_buff *skb;
>> 	struct timer_list timer;
>> 	unsigned long timer_intv;
>>+	struct rcu_head rcu;
>> };
>>
>> /**
>>@@ -382,6 +384,14 @@ int tipc_disc_create(struct net *net, struct tipc_be=
arer
>>*b,
>> 	return 0;
>> }
>>
>>+static void tipc_disc_free_rcu(struct rcu_head *rp) {
>>+	struct tipc_discoverer *d =3D container_of(rp, struct tipc_discoverer,
>>+rcu);
>
> This line is long (over 80 columns). Please break it into 2 lines (refer =
to linux/Documentation/process/coding-style.rst).
>
>>+
>>+	kfree_skb(d->skb);
>>+	kfree(d);
>>+}
>>+
>> /**
>>  * tipc_disc_delete - destroy object sending periodic link setup request=
s
>>  * @d: ptr to link dest structure
>>@@ -389,8 +399,7 @@ int tipc_disc_create(struct net *net, struct tipc_bea=
rer
>>*b,  void tipc_disc_delete(struct tipc_discoverer *d)  {
>> 	timer_shutdown_sync(&d->timer);
>>-	kfree_skb(d->skb);
>>-	kfree(d);
>>+	call_rcu(&d->rcu, tipc_disc_free_rcu);
>> }
>>
>> /**
>>--
>>2.43.0
>>

Hi,

I=E2=80=99m sorry for taking so long to respond. The v2 version has already=
 been sent.


