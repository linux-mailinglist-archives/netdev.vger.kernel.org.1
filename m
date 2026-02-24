Return-Path: <netdev+bounces-260484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GwQI/iOnWkXQgQAu9opvQ
	(envelope-from <netdev+bounces-260484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:43:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5B21867AE
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 987B53091CBC
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E8037FF74;
	Tue, 24 Feb 2026 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="w6VWVP5C"
X-Original-To: netdev@vger.kernel.org
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333C37FF64
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933327; cv=none; b=AgLoo9cY6d+c1bLIWxZzFi24NobgmkcvMUGwcYpE8rNpiJievuTFQPGUByywHOx9/D86avCsItkb1lN2z46xMbvrefsf2QzwpV9mD2+QaaGHsmPX7R0rirroGAC/62hCx+2EzqXRQrZ5HZNio4cerdOjarzzIlubOH7P3QZVu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933327; c=relaxed/simple;
	bh=Bxi5QgIwEumJBR9mBS1nAGWNGBM1z+WQmnsvg1R8Uug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o19OR6fhuIsYTjmcKlZGZKuSAtJRWsjdBtSfwvO67Uw1iB4S0qX5owOOagFBEWMzQjX9mXDeusSuIG131SGK+Zmq3GJA+umIUxoBD1rE1KimzmoJRUOUz0LD41TXxHp7FW78xlY4vS5AgY8vJPYop4Xh7F5dzXEfXbWzRU8/qaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=w6VWVP5C; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1771933324;
	bh=vKpV8kbp5EdB5q1YeOi5Q7adWrbZtA4GTCv3TJge4Mc=;
	h=From:Subject:Date:Message-ID;
	b=w6VWVP5Crq+fE9Z6ZIQHnh1W/CSufaOThKaXYfsuR5pBOa3dOXgkGXWNIzme6IG6r
	 OzoJjaQiG8TQclDQK/7y95xnaOgZ6VBhv0VSOyVMxglXyu6/YOXeS6ViUTxv8XDBj4
	 WRAwLN78GapG8rhmfxWgXNz820ag687faVyoCerw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 699D8E62000062FD; Tue, 24 Feb 2026 19:41:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3029456685127
X-SMAIL-UIID: EF938662E18D4A2A81F96A33E0037E48-20260224-194125-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+179fc225724092b8b2b2@syzkaller.appspotmail.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH net] dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()
Date: Tue, 24 Feb 2026 19:41:12 +0800
Message-ID: <20260224114113.344-1-hdanton@sina.com>
In-Reply-To: <20260112103825.3810713-1-edumazet@google.com> (raw)
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260484-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[sina.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,179fc225724092b8b2b2];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sina.com:mid,sina.com:dkim]
X-Rspamd-Queue-Id: 6D5B21867AE
X-Rspamd-Action: no action

On Mon, 12 Jan 2026 10:38:25 +0000 Eric Dumazet wrote:
> syzbot was able to crash the kernel in rt6_uncached_list_flush_dev()
> in an interesting way [1]
> 
> Crash happens in list_del_init()/INIT_LIST_HEAD() while writing
> list->prev, while the prior write on list->next went well.
> 
> static inline void INIT_LIST_HEAD(struct list_head *list)
> {
> 	WRITE_ONCE(list->next, list); // This went well
> 	WRITE_ONCE(list->prev, list); // Crash, @list has been freed.
> }
> 
> Issue here is that rt6_uncached_list_del() did not attempt to lock
> ul->lock, as list_empty(&rt->dst.rt_uncached) returned
> true because the WRITE_ONCE(list->next, list) happened on the other CPU.
> 
> We might use list_del_init_careful() and list_empty_careful(),
> or make sure rt6_uncached_list_del() always grabs the spinlock
> whenever rt->dst.rt_uncached_list has been set.
> 
> A similar fix is neeed for IPv4.
> 
FYI list corruption in dst_destroy() [1] happened after this fix.


[1] Subject: Re: [syzbot] [kernel?] INFO: task hung in restrict_one_thread_callback
https://lore.kernel.org/lkml/699d155f.050a0220.247d23.0377.GAE@google.com/

