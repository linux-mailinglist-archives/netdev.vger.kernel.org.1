Return-Path: <netdev+bounces-201861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FDAAEB381
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B032563331
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73BA2957BA;
	Fri, 27 Jun 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AyLWoXb8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DEF293B4F
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018305; cv=none; b=mB1CzOdS5GMr/tkYH2z8N70F+dUdOukKeaKSdLkhQEZ0ua9WQ5wVNnP4jdXLCW1vmakgusb342Ii9phoIkI7rH1oBwbfYsy/NSGKRYrUUO+ALGM/GSJIDHwx/EbW5NdeDHsxGMRUk7naOzktf3G/bu9HpiWti4hO/+TvCT1XIBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018305; c=relaxed/simple;
	bh=ty/ng5pEjOrtOItRfcKL9PO79acEDgujWdERB570E1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=icXiicvOLvaV9ET/CHosb/KTZG60kC1iRi+kmQHKYswb04o2Kkfc8RQy6UL5GPmqqpsK5G9O9IAxWxCwf8AqVS1V7+QQWA35lwMOSDVC+1CT3G3WwklFhUxJOlriHtjJ32ncDcUUT7sZC8n2qDCoMu5EmZlGXpvi5tBlCSG3FXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AyLWoXb8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso3639159a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751018302; x=1751623102; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SLr8Pvh5pBvhiO7nTYaIEvel15ZDd7p3+FgC91icrhA=;
        b=AyLWoXb89/7RHn6DyzQvnV8hyuBYFO7eUxVpPu9f6Vz1ddKQbvE3I2HGujeAyX7S8H
         Tz3LX5qi23758LgaWemu5dOFLswRhmEzVp9eznFOxH0oBPSnTLbJY21drPmpBjahLyMz
         +UOPZ8CtiWXG8M+zo+JkeBN87yvvbNwoA9xijWPH2uLaiZU6Qe4jiuTtabJMBnW/C2tA
         r8NOLYzn5mt7UWJSSohwMzEFuqpzMaecvpprhYPx6Ofid6ZTzG6QxQlkUTos2YuU1znh
         MAFaaqN+WVAv4iYwIu+70CRz2FkzH3AMEmpoNR+iHxoAI9ivubwmTKPhxrieL0S9uYX0
         +f2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751018302; x=1751623102;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLr8Pvh5pBvhiO7nTYaIEvel15ZDd7p3+FgC91icrhA=;
        b=B/D1doR4yNU9WlCuOx81j+j/Ga8OAH0zbx5cUEPmHmQ01osAMazs7Cwzpk4c/oVyLG
         +LoT1v1mMhxtXXi+Pvj3BzU2A8f16evKAkGeufsLaW5z6fXl7XuxEB7caoy2KXBcZ0KM
         m3pFRGHHR2rDrEtaW1e1QKpVsxfGetzlTlsqQz2a9tsSJpWovMv9tLFLxa5TP1goPSKR
         u3FADqLUfhE5U3y7994Q0IxdAo0ihJWnaNHMgGrXFekJ8TzDc4KmIl4HPcyjkk+UEQxX
         U7oCyYngDKKu7zBNcyGWPIJv3PoGO//6jW/jlvaRYL6F52B48THgdbYxexgcO3MefrvF
         eraA==
X-Gm-Message-State: AOJu0Yy621r+zYbWA1xUz2/liP7eDH4HW09JaMuv2/MUtyeFCz3wenzS
	arRATvVqz7vD85+JbiOIujTi3rjNRD2Ka1RLlwq8ATlFDP9xm3G5w7+zbH8udJTYY/fLqmimwpI
	gdYLj
X-Gm-Gg: ASbGncui+b4OPFuJSrfyL4jZjWUYUZlYWAbV41zer5MAUYwtRNQmCLSsqmwqsD03lRR
	43HjIYwXzbgdJlitIO8TJ31fiBvcuz/DbWoymH7yCrdWTbGKSWbZ2NmxzdZDe2VM6Gd34+4D9Ck
	QozwCNOL1cD6EUC1/+gm+l0RmewgfuZ1OBgbI787K+UusFFbBLpkummKRN+VIaVNzOY8xxckggb
	TBp89gAOrCWiEIlyYrsPex/CQcMw75O13YUF0sgRYW/M1h/SJAuEJ6WmROyK3gOx6aNZiGNbBIz
	ZGyDaVMBD1V7VMmmt57JN+pppZOEmRJFZ5dGjQEFRbOl7xLk7IJuiDU=
X-Google-Smtp-Source: AGHT+IFcFRgTBKBXnrSls1yO26rYgRdqYmoCvkj7RB9Y+HPFKUliREpfqyXrU5k37TO2ZGsaAa+pig==
X-Received: by 2002:a05:6402:2743:b0:608:3b9d:a1b with SMTP id 4fb4d7f45d1cf-60c88ddd04emr2231944a12.19.1751018301764;
        Fri, 27 Jun 2025 02:58:21 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:8a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8290d923sm1235137a12.33.2025.06.27.02.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:58:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  "David S. Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Neal Cardwell <ncardwell@google.com>,  Kuniyuki
 Iwashima <kuniyu@google.com>,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com,  Lee Valentine <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next 1/2] tcp: Consider every port when connecting
 with IP_LOCAL_PORT_RANGE
In-Reply-To: <202506270619.Cjd8lmig-lkp@intel.com> (kernel test robot's
	message of "Fri, 27 Jun 2025 07:00:59 +0800")
References: <20250626120247.1255223-1-jakub@cloudflare.com>
	<202506270619.Cjd8lmig-lkp@intel.com>
Date: Fri, 27 Jun 2025 11:58:18 +0200
Message-ID: <87ecv5fqv9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 27, 2025 at 07:00 AM +08, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
>
>>> net/ipv4/inet_hashtables.c:1015:21: warning: unused variable 'sk2' [-Wunused-variable]
>     1015 |         const struct sock *sk2;
>          |                            ^~~
>    1 warning generated.
>
>
> vim +/sk2 +1015 net/ipv4/inet_hashtables.c
>
>   1007	
>   1008	/* True on source address conflict with another socket. False otherwise.
>   1009	 * Caller must hold hashbucket lock for this tb.
>   1010	 */
>   1011	static inline bool check_bound(const struct sock *sk,
>   1012				       const struct inet_bind_bucket *tb)
>   1013	{
>   1014		const struct inet_bind2_bucket *tb2;
>> 1015		const struct sock *sk2;
>   1016	
>   1017		hlist_for_each_entry(tb2, &tb->bhash2, bhash_node) {
>   1018	#if IS_ENABLED(CONFIG_IPV6)
>   1019			if (sk->sk_family == AF_INET6) {
>   1020				if (tb2->addr_type == IPV6_ADDR_ANY ||
>   1021				    ipv6_addr_equal(&tb2->v6_rcv_saddr,
>   1022						    &sk->sk_v6_rcv_saddr))
>   1023					return true;
>   1024				continue;
>   1025			}
>   1026	
>   1027			/* Check for ipv6 non-v6only wildcard sockets */
>   1028			if (tb2->addr_type == IPV6_ADDR_ANY)
>   1029				sk_for_each_bound(sk2, &tb2->owners)
>   1030					if (!sk2->sk_ipv6only)
>   1031						return true;
>   1032	
>   1033			if (tb2->addr_type != IPV6_ADDR_MAPPED)
>   1034				continue;
>   1035	#endif
>   1036			if (tb2->rcv_saddr == INADDR_ANY ||
>   1037			    tb2->rcv_saddr == sk->sk_rcv_saddr)
>   1038				return true;
>   1039		}
>   1040	
>   1041		return false;
>   1042	}
>   1043	

FYI for the reviewers -

Silly mistake. I can move the sk2 declaration inside the branch where we
walk over the v6 wildcard sockets.

Holding off for now to give people a chance to review.

