Return-Path: <netdev+bounces-279904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJIbDm155mkHxAEAu9opvQ
	(envelope-from <netdev+bounces-279904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:07:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 903E643328F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 21:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1B9C303A107
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD383A758C;
	Mon, 20 Apr 2026 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtmI+/pI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC3383C7C
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711780; cv=none; b=gBh8VUacZC/vsEh9JbP0zh/2aEbGGH9n7ZVSApEXvUDUHsh3q7RghDXtqtnF2MxdNgoBiQ60kFYo8gO+eoc1RFzy7nplaU/w6NoGnvb4NZT7Q2GGTuvDcmi/g3XoFGG4tfWddJu3BkmIdif4ONGdZ/URwoOosL6LznkpPHyzHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711780; c=relaxed/simple;
	bh=gDW+UqMClfGLo+WdeMypawSnkwG8D7oGaoBZ3MCNExw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+cRZe71zgCFRxx607g36+f2XnqZB7EbRiw9Swtm7MU/YxbtDGDq92ZPO1DF27G97am919Fyuc/2LKgOakr62KXl6rQqauqFc8D+9pcCZ7Bobuwhy8PCNC239Ze1aAn0HjFo/Cq7fsW7oWatxlPqjKCG7lYWb4sU9MooZdIozU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtmI+/pI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48374014a77so44193495e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776711777; x=1777316577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N65t9jImbyCGiHKfgsqjeriV0Rsv4zHSWcdJpEICw7c=;
        b=dtmI+/pInlCCbIq3KwApvUgqncnj+XsrcbVz7nDv3PPZm8+Yb7BJTQX8Qih53Fw4oh
         YzI7c8GJhDMzJGt4peeKK0TKL9Ig8QvupwXM6sN1TzqLRYQgaqQ0BWjfUimPphL4MNss
         MOjZON1LETxjXMLbz8Wk4xXdvTbj9kMPZ2hlIvzr7kkUXColJFwmHVMuXqARzgLLUZpN
         fAJiD0Ji9wAEPSJTkVN419fAw8Nh5WZT095Mv1hY7nNsM3kmyK9TP9wWuQl1aet7d806
         vbi546WDCyXDNCP5694Cnlc59OAS1Q1HgF/1JiMcc0Ekf3siH8eQ654ySxnK3G5sqbWj
         tw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776711777; x=1777316577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N65t9jImbyCGiHKfgsqjeriV0Rsv4zHSWcdJpEICw7c=;
        b=Paa32+JxzeUs1OD9eSLJIxe/FSJJNNCZYp35V6hc0SMQgjqHQ8kUxBzW5k9orp0yZs
         UVMH98HPVDmd2GZxSrAoy5zUJOEhTn1kjcdJKWLoUb11rNpnGZTx0EG2WASvaNaNEp5J
         dYVPScMQ+aDhkSiZnTFpEmiJvlHAofIVhvTmuXiudW8FpIcLUdMuJmzJAvg78Moy++9+
         S/18iEEQ1KnG4Le63mYK/RJvDQY8b4NLWit69SDnTM0nIzhWQGxxl683vURD45Vgbt+1
         Tbo1d1b4+4mda4qGEL/N4o4Ko2xsvAyiFGaaufsNNFFhTFykJVYY8VniHQDnvLqbFPBf
         TRjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mZCJLueFq+GqZBHCiBgp81qv8lJc7TKKreMVkFbi0SJ8HakoDVpaG86jUvButJBy7Z1lZQ64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY98no0OozmPWGqyaUaPlxXhPNPFyRjSkR0y5/TqUiN/2TS3qD
	b5PPf9IDpviaDwCr01urGEix49mFg9ELje9rzusbqlijB/5hY6L82imX
X-Gm-Gg: AeBDietZT4rFqHOO/X5Tc6sMOghAc1UDDSIXVUCa7sp5F8kqYOohLm2gaxbPi0aTPK4
	5jb1AL7MSt3lNei0Otfm1kgYGTx5vDZsFMmHhEVqvX8P7Q7Vh9BKswrgS6bRXzoQjg78chDOb3Y
	QwtXTcsImsimQT8Tpo41EZIPugbd/yw5ErYnxi2PIK6eslh6BWBwmn8EH/10St3hSZ1vWt8qJI4
	8E/Ydno4r/gVk6yb85Om9VtnRnPWdAeVwmr7pd2XcRBikaFtl0LVNCS+oi4UlZKjdWlkwGKLMNi
	wwpbI39FToqV2/40darR+O+F4hUjU6NoWeB9KAhp9Xo+rP8XWGBZ3loItLG4n0ETGX5nB/DSN9C
	HPRjvWPDuIqruTeWWAqTYxv2hiI3vGPos7wHdrz5OsCk24gGgqPEYz2MPksYF57YFKsw263Tg38
	rT6MCURgJP6FjRZ4RDGxSt0IFdW/fNEMOPKwkRbQg/tOU1KIZLgu+EWLRfAUy7am/LNM8FsWVnI
	lIwMiTqhJBKLOYs
X-Received: by 2002:a05:600c:348b:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-4895040c025mr56054525e9.9.1776711776741;
        Mon, 20 Apr 2026 12:02:56 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:98a0:d751:7986:3f62? ([2a02:a03f:a75e:9a00:98a0:d751:7986:3f62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc177dafsm378108875e9.4.2026.04.20.12.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 12:02:56 -0700 (PDT)
Message-ID: <b44de581-9f41-4804-afb1-72c491d9443a@gmail.com>
Date: Mon, 20 Apr 2026 21:02:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
To: David Carlier <devnexen@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte
 <laforge@gnumonks.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Weiming Shi <bestswngs@gmail.com>, osmocom-net-gprs@lists.osmocom.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260417055408.4667-1-devnexen@gmail.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260417055408.4667-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279904-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,netfilter.org,gnumonks.org,lunn.ch,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lists.osmocom.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 903E643328F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 07:54, David Carlier wrote:
> gtp_genl_send_echo_req() runs as a generic netlink doit handler in
> process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
> which eventually invokes iptunnel_xmit() — that uses __this_cpu_inc/dec
> on softnet_data.xmit.recursion to track the tunnel xmit recursion level.
> 
> Without local_bh_disable(), the task may migrate between
> dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
> per-CPU counter pairing. The result is stale or negative recursion
> levels that can later produce false-positive
> SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.
> 
> The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
> the data path runs under ndo_start_xmit and the echo response handlers
> run from the UDP encap rx softirq, both with BH already disabled.
> 
> Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
> commit 2cd7e6971fc2 ("sctp: disable BH before calling
> udp_tunnel_xmit_skb()").

Why not fix iptunnel_xmit() directly, rather than fixing all possible 
callers? Basically, jut like we did for lwtunnel_{output|xmit}(). The 
advantage would be that we no longer have to worry about BHs in the 
callers, and BHs would only be disabled when necessary.

