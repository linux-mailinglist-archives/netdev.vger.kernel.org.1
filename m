Return-Path: <netdev+bounces-168944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C0FA41A5D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 11:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBDB1887E00
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB2124A05B;
	Mon, 24 Feb 2025 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlKJjgca"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF224A062
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391767; cv=none; b=jMEW2txpQe7U1EtjX9hMujyiRLj2QqEEjRulSU9ApEp4wp+4aYtUEI+ZHtPk/faVCQopewTzjgPJlBieWssbLJGu/uTBYMFusM51ldRjFDRBgRXsxOT9OWEfCwQ9PQkUfddOK2CbwnlWjTFku5UmY+hCrvTixgZLdFgn8raL1tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391767; c=relaxed/simple;
	bh=OWyKa8ptHkaxnDRPZ9/w8sCzsrhha62MtGM3wPrXjdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZ6U6c9vELVBkbiQJkXqmxB4mUr5PT1E4FIo4rvXvsAkJ0VfVJ2vqG5IHU7MRwhK2Bgx009aiGzeOeanSYLgzUFHUhc3I+4qaMMatcHgsJ4ArylizYQ+wkVUqT+YcrmiPJGLMpOhNfxmMwIffhSncv7/Qm+7RSg/H6NaxFGfyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlKJjgca; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740391765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiAHvV/pLQygl1IHlcIkR9ngI2lLMS2rvadb1azQMOs=;
	b=OlKJjgcaUzk4V9OBk03nOPznNgUxHiL0vVuKw8ZIn3EB0fo1HZcO5/iVBQ2GU6MckIYbS0
	HfgeEIL1O/vltMUM4kq/9ZgEs2HVAdkNy4g9FmUjV88GjVYhpgdyBLpyACdcKrvMOOiYjw
	z19fcvmFhddVLddZQ6DXE1w4d5LWASQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-SiDfiuoXPliZNpmxoipK_A-1; Mon, 24 Feb 2025 05:09:21 -0500
X-MC-Unique: SiDfiuoXPliZNpmxoipK_A-1
X-Mimecast-MFC-AGG-ID: SiDfiuoXPliZNpmxoipK_A_1740391760
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f255d44acso1782475f8f.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 02:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391760; x=1740996560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiAHvV/pLQygl1IHlcIkR9ngI2lLMS2rvadb1azQMOs=;
        b=dQlPNdS5Jh46c+fVAxHfUhOYGJfEXqgsY/Q3humBzlrUoFlOzNZJE24NZWp7kzx7Lz
         F9JVyfBXoL++TwBlpw+qXR3DrfPodDRedu+0GS0T9pEdxaIdPBCOKHybgcenxHea0lIe
         b6UcmSxtqqN6onSZ3S/cRMEZuLXFh4GKS1ztHuYzZq/Yj8RG6hYuSAnGvYoaeP0z4Ezr
         vsyvlLWPk1mQEHdzuFfsJCxSHvJ+T0/UzqU6q+49hpY0JyFnFGRTj1Ih6hgYnP2DNPXA
         rvioWlXHvaYdpaVF2DwkR04wQ4WFoVWV2FtO4HW964H3vew1jPL4Nug6/TDNdVC+q+ql
         x2pw==
X-Forwarded-Encrypted: i=1; AJvYcCXOX+qzUQ5FtJzhfIflAp+I/YrVlXjfe2JGN/lO9u6xstPDGXtZH3bs1jssUwdaKFBNYvTjG2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUQZQcwlS778jQxbCA5xznZ6fXVgNoWcyBv34WovdY+YPoddS
	Uh9YXmu241ckkoVgUWKJqxNDvz96T6uiyak7BA9XmS7H4EQQgV7Sazmk3B1ffERNKY+raGXo9V/
	twFsc0X+ZOwwtTwlwF8gBdUnQ+SmJEAbrdj2l4zVzb7pGqkdHit0CyQ==
X-Gm-Gg: ASbGnctgAtw/HdOyXY51JvDEhLbDVaLonOoRxrEw9RUJX5Uk/5hDsIkk7wId29E6m8Y
	QlkZG5dbnERAlomsnoHykhLIwFGo0FqD3nPXYZ+iu8HqXS6WbfIYxqmN/vnOvwDvcoILaHOnxdE
	J+ZmUWGSrgFz0HR83lRUOauqbwjEXyq+tjmec3VCLtykcrg2bKLqM/CjF64Y4cU0g0rMG4L/X6H
	oH7YGPPGot7kOSufPZ4PgnCldDG64+5P8fG+hnoGpTRCIaxCPW6U+ofga9faFoEzqzJGQjaxTt1
	r19T5FtDCA9FVEV6Unr4xfv6s7VzPaCf/WiBLmbhvKw=
X-Received: by 2002:adf:f3c9:0:b0:38f:2b59:3f78 with SMTP id ffacd0b85a97d-38f6f0ac5a3mr8457412f8f.45.1740391759658;
        Mon, 24 Feb 2025 02:09:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7eusrm5SqCT8mF5AbrGxULnH9g0Ag6sQkU6il6PYpOhUlbaMjBtTXltIszKDNSUXqGotYsA==
X-Received: by 2002:adf:f3c9:0:b0:38f:2b59:3f78 with SMTP id ffacd0b85a97d-38f6f0ac5a3mr8457385f8f.45.1740391759262;
        Mon, 24 Feb 2025 02:09:19 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b030b2c8sm101817405e9.25.2025.02.24.02.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 02:09:18 -0800 (PST)
Message-ID: <9ef28d50-dad0-4dc6-8a6d-b3f82521fba1@redhat.com>
Date: Mon, 24 Feb 2025 11:09:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
To: Krister Johansen <kjlx@templeofstupid.com>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
References: <20250221222146.GA1896@templeofstupid.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221222146.GA1896@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/21/25 11:21 PM, Krister Johansen wrote:
> If multiple connection requests attempt to create an implicit mptcp
> endpoint in parallel, more than one caller may end up in
> mptcp_pm_nl_append_new_local_addr because none found the address in
> local_addr_list during their call to mptcp_pm_nl_get_local_id.  In this
> case, the concurrent new_local_addr calls may delete the address entry
> created by the previous caller.  These deletes use synchronize_rcu, but
> this is not permitted in some of the contexts where this function may be
> called.  During packet recv, the caller may be in a rcu read critical
> section and have preemption disabled.
> 
> An example stack:
> 
>    BUG: scheduling while atomic: swapper/2/0/0x00000302
> 
>    Call Trace:
>    <IRQ>
>    dump_stack_lvl+0x76/0xa0
>    dump_stack+0x10/0x20
>    __schedule_bug+0x64/0x80
>    schedule_debug.constprop.0+0xdb/0x130
>    __schedule+0x69/0x6a0
>    schedule+0x33/0x110
>    schedule_timeout+0x157/0x170
>    wait_for_completion+0x88/0x150
>    __wait_rcu_gp+0x150/0x160
>    synchronize_rcu+0x12d/0x140
>    mptcp_pm_nl_append_new_local_addr+0x1bd/0x280
>    mptcp_pm_nl_get_local_id+0x121/0x160
>    mptcp_pm_get_local_id+0x9d/0xe0
>    subflow_check_req+0x1a8/0x460
>    subflow_v4_route_req+0xb5/0x110
>    tcp_conn_request+0x3a4/0xd00
>    subflow_v4_conn_request+0x42/0xa0
>    tcp_rcv_state_process+0x1e3/0x7e0
>    tcp_v4_do_rcv+0xd3/0x2a0
>    tcp_v4_rcv+0xbb8/0xbf0
>    ip_protocol_deliver_rcu+0x3c/0x210
>    ip_local_deliver_finish+0x77/0xa0
>    ip_local_deliver+0x6e/0x120
>    ip_sublist_rcv_finish+0x6f/0x80
>    ip_sublist_rcv+0x178/0x230
>    ip_list_rcv+0x102/0x140
>    __netif_receive_skb_list_core+0x22d/0x250
>    netif_receive_skb_list_internal+0x1a3/0x2d0
>    napi_complete_done+0x74/0x1c0
>    igb_poll+0x6c/0xe0 [igb]
>    __napi_poll+0x30/0x200
>    net_rx_action+0x181/0x2e0
>    handle_softirqs+0xd8/0x340
>    __irq_exit_rcu+0xd9/0x100
>    irq_exit_rcu+0xe/0x20
>    common_interrupt+0xa4/0xb0
>    </IRQ>
> 
> This problem seems particularly prevalent if the user advertises an
> endpoint that has a different external vs internal address.  In the case
> where the external address is advertised and multiple connections
> already exist, multiple subflow SYNs arrive in parallel which tends to
> trigger the race during creation of the first local_addr_list entries
> which have the internal address instead.
> 
> Fix this problem by switching mptcp_pm_nl_append_new_local_addr to use
> call_rcu .  As part of plumbing this up, make
> __mptcp_pm_release_addr_entry take a rcu_head which is used by all
> callers regardless of cleanup method.
> 
> Cc: stable@vger.kernel.org
> Fixes: d045b9eb95a9 ("mptcp: introduce implicit endpoints")
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>

The proposed patch looks functionally correct to me, but I think it
would be better to avoid adding new fields to mptcp_pm_addr_entry, if
not strictly needed.

What about the following? (completely untested!). When inplicit
endpoints creations race one with each other, we don't need to replace
the existing one, we could simply use it.

That would additionally prevent an implicit endpoint created from a
subflow from overriding the flags set by a racing user-space endpoint add.

If that works/fits you feel free to take/use it.
---
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 572d160edca3..dcb27b479824 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -977,7 +977,7 @@ static void __mptcp_pm_release_addr_entry(struct
mptcp_pm_addr_entry *entry)

 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id)
+					     bool needs_id, bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -1017,6 +1017,12 @@ static int
mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 			if (entry->addr.id)
 				goto out;

+			if (!replace) {
+				kfree(entry);
+				ret = cur->addr.id;
+				goto out;
+			}
+
 			pernet->addrs--;
 			entry->addr.id = cur->addr.id;
 			list_del_rcu(&cur->list);
@@ -1165,7 +1171,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock
*msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
 	if (ret < 0)
 		kfree(entry);

@@ -1433,7 +1439,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb,
struct genl_info *info)
 		}
 	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info));
+						!mptcp_pm_has_addr_attr_id(attr, info),
+						true);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d",
ret);
 		goto out_free;



