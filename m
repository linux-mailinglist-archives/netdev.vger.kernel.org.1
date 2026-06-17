Return-Path: <netdev+bounces-300181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3MvdEHikMmp03AUAu9opvQ
	(envelope-from <netdev+bounces-300181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE77B69A36C
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:43:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LLDt+UE0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300181-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300181-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D896316EF97
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58342847B;
	Wed, 17 Jun 2026 13:38:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51164436356
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 13:38:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703535; cv=none; b=IsMy0ts20r/AOXHX88RqGX9uA5wZXQXj+Z7YhD3Xx7EaMxxMvBGS6/Hof8rc7JTJSibUV0eIj5qkwT+KHaxY+Zk/LdBC4IqJPKM/ywWopFwnXTZsvWBbZ8XC9JA415+GpDyjYxVr+p29v546ZyRu8l7J/0KN2ChwivpZ5CO2KDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703535; c=relaxed/simple;
	bh=1rH0E2dnt+5ymmGT2t3/+jFH2iUZPj0k1ZJmb5aUCzE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Xqk8uJL/KvVLRom+z1hpVNcZr22suhSWfZND1IzRrnlJbcJLuVJsILgp7Vhx1Fv7eiuRK4da4ocFOWmV9zFiw1aJG1PbYxleqQGT81M3R2RyIVleB89xBrZ+hEpnsVZXDG2UzHd4NLRmru8JR+OW3yaUVwQW7MQIQHVFDYo+hsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLDt+UE0; arc=none smtp.client-ip=74.125.82.180
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30bd59b6eb9so1065092eec.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781703531; x=1782308331; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rH0E2dnt+5ymmGT2t3/+jFH2iUZPj0k1ZJmb5aUCzE=;
        b=LLDt+UE0YaBv+Ee6PfJfRlCq2XmRkvox3mF5ljxCJUOC3FXsg1P3eC5bcZ3fQkCNPv
         wzxyYnSPXFS26ekllcjtvbPLoA5I0sBgfVhh1vVHY4TEobIxjCCeJd4iTeqWRMfkdUWF
         z+CIV23/xIEa8RKUwDQ9ijo47MJTyq/D9T4gXUylUR3tIcaZ7bHYUIEA/JOv7FTq4mgy
         YFGzPRtdK5F9ww+C/3jtj1Dv1RJzKPv3UDOKBL7yj0T+Gash/4ut5mZ0hqhxCtWawknG
         GY5A7auO0nMV7s4wyHcmkT568Mdjn2PCJia1EmwXiw506Nf6aVP1tiiytgp3Bt0AFwQ8
         soCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781703531; x=1782308331;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rH0E2dnt+5ymmGT2t3/+jFH2iUZPj0k1ZJmb5aUCzE=;
        b=qaP/mdsM9RrUDLrOlhkW6zdIG+jlvhHLV459oXoHjY4DYh8AxEqx1HdDeSG21xzZ74
         VKU/x07oorsdp0HEyEpY7WdY/vpa/es6uXNJXVr3OFJvzasZryaaFB/RrCULJ7im6EKK
         J+Wh6itYSzOsjprgZJneNtKqTrLmcv8t4jzXWZuj9YNgtrl8cv0qVyxydhoDL6gQhM1p
         u6kRuWxmVNoBDbTemJfE84MBMIXp5xmnV97AlUKS3D8koYOEksi0AYCnH6fl7FtS9ZIx
         1xFMX5SQwXmdxzBTB9EEKoFOmNUQn6tVWEOFNB7f+j2Z3QF6pYMRlGccK+4WizSqVAhw
         TDkA==
X-Forwarded-Encrypted: i=1; AFNElJ98Kavza+BDsG1SJ4jsK2LA2qPvINVuKVz5QtFLs3croy/Uz55u4veysUbgBbAHISxGktzhsgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5FWHdzKMBtnMaJmQLWj5Z3hv1ag99JYzYb9LXyegj11ATPP/0
	kRGM9Wm25r9dMugS0J3WH0iMwSgr85MtMbe1eJ0xox9vBZXZA0nfOegt
X-Gm-Gg: AfdE7clRBx2LRSS8nY0CBP+2efoHvSJSi/QZNrRssDej06aNSyzzdHTMJsTRyoEpHXq
	qwlf7CHvkE5oTBvZiV9WXHgs3SKXB94uKydm/jNJXU2f2oDyU+SHkLczJ1SnBZ3XqsvwxJiWAe6
	y1quxb68x1CLqCUMn0IVwYUrhgmfIPJ4S1itZ/5Tt9g5Pz30gNKkM0weeQmPcNtoG4U3D7lJHis
	ed3U3e1YvXg+nG4FdQje1Rg9WlOLPWsTbuix6D2Zg5Q0MkUe7CP38kyvuvzO1yDPZsGRP8oaiK1
	mtIhvlueOsEnvgSKR+D56z1U9rbdLWemXCFipEyFnnRAMshyKK0ME/MkocblFdis8jdjwXnj1Ay
	CEVxlZJ0fRK7uYsilso4QNUaYzYdEUehUlVmQdJzLxUb+2r7PFwFvp8sgdK7OS35BCeqjX6d1fj
	FAhyIphOG4VDNVx7iVaqsOM6CDUvq8SVWnRdieCQ1i
X-Received: by 2002:a05:7300:a508:b0:304:18be:55a5 with SMTP id 5a478bee46e88-30bca0b8b7dmr2085179eec.22.1781703531189;
        Wed, 17 Jun 2026 06:38:51 -0700 (PDT)
Received: from localhost ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ba6b7f840sm10522871eec.19.2026.06.17.06.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 06:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 21:38:46 +0800
Message-Id: <DJBD6SGYRIHX.1IHLCVG9YYTNJ@gmail.com>
Subject: Re: [PATCH net] ipv6: ndisc: fix NULL deref in
 accept_untracked_na()
From: "Weiming Shi" <bestswngs@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Weiming Shi"
 <bestswngs@gmail.com>, "David S . Miller" <davem@davemloft.net>, "David
 Ahern" <dsahern@kernel.org>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Cc: "Simon Horman" <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Xiang Mei" <xmei5@asu.edu>
X-Mailer: aerc 0.21.0
References: <20260617065512.2529757-2-bestswngs@gmail.com>
 <e8ace4ba-31cb-40d7-b288-eeb411f8d0ef@linux.dev>
In-Reply-To: <e8ace4ba-31cb-40d7-b288-eeb411f8d0ef@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300181-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:bestswngs@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,davemloft.net,kernel.org,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE77B69A36C

On Wed Jun 17, 2026 at 4:32 PM CST, Jiayuan Chen wrote:
>
> On 6/17/26 2:55 PM, Weiming Shi wrote:
>> accept_untracked_na() re-fetches the inet6_dev with __in6_dev_get(dev)
>> and dereferences idev->cnf.accept_untracked_na without a NULL check,
>
>
> Does ipv6_rpl_srh_rcv have same problem?

Hi,

Yes, ipv6_rpl_srh_rcv() has the same missing check. It reads
idev->cnf.rpl_seg_enabled right after __in6_dev_get(skb->dev) with no
NULL check, while seg6 and ioam6 in the same file both check it.

But I tried to trigger it and couldn't. With a guard added as an instrument=
,
idev never came back NULL over tens of millions of RPL packets while
flapping the MTU, so I can't say it's actually reachable.

Still, it's the only one of the three without the check. Want me to send
a patch adding it there too, for consistency?

Thanks,
Weiming Shi


