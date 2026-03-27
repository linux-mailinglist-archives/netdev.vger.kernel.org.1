Return-Path: <netdev+bounces-272507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGTfCP9pxmmkJwUAu9opvQ
	(envelope-from <netdev+bounces-272507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:29:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C1D34372B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 536D7300EFA5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716843DC4D6;
	Fri, 27 Mar 2026 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmJskaCV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9kZ3okS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D5E3DB64B
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774610920; cv=none; b=sZqL4/Mj1TrfetrwanXCmvd5HMEZUU8Knku5PtsXlF2v3rxVSifB6fu0v/Ybno5gTZAgmwfjqy1zT/ZZe/8pBJPUBK1U751YL1Ktg0LukJwCIua9rDRnaKxRrxYPbl3GkPLOOFKurr027YCwU3nuF/R9qdghXH+9eXGbffbe5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774610920; c=relaxed/simple;
	bh=Ck111UDeVadOse75OIQ+igc8a37rMR7wmP8xvfAbPoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq7H34WwWJzkUY1TQd/t7eHV/rk8fwCX253oYgEoiiUvMbvDRd3WApcmTYMvt4bRaI2vzNGoEAlPO/sJ4JAv4oXSpn6Sq0xZZV73xIrqaZlIFd9smrbxGDgFHsGUadNXp6J3lgc213B41atD3iiVtPOAvgOIn5UmD8M+qRgZUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmJskaCV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9kZ3okS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774610916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPoRKAikqi9O5TMw7pTEWsw013Li/e5d6u/ewbLWq1k=;
	b=AmJskaCVcoid7FYTIgvBOjnHWbQAT3rEdM0aV6pmF9SA7MfxdIwbQTvgg+9JdYb2lYXs4u
	+aovb8v3nPegidLRsAByvW8jzh27iPopHF/yG18LxQB7nyYozCv3TxPugLshi1yY5MKb5K
	5Zsbb28KDMHiUWcqhlGov7rWNylusQo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-l9JwG9S7NtqBWHLZE8PCaQ-1; Fri, 27 Mar 2026 07:28:35 -0400
X-MC-Unique: l9JwG9S7NtqBWHLZE8PCaQ-1
X-Mimecast-MFC-AGG-ID: l9JwG9S7NtqBWHLZE8PCaQ_1774610914
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so24672875e9.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 04:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774610914; x=1775215714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aPoRKAikqi9O5TMw7pTEWsw013Li/e5d6u/ewbLWq1k=;
        b=X9kZ3okSmP+94AQpa0D4jb1sA8N+Qqv+88v2GM+zcIA5vE0T2tWWwyMwU5E5hOJQe2
         iNihua/ypd0iH9CD+SMf5Cg1V7jhddNRN0bLDTZivx3USC1biH8SFZL+H1xtpuFL96R8
         Atrf0pqVo9EnixIZzOJoyrZaKLvObOprv5M4wqW5jJAjFiqlpOjXM77urKmoxSU5BMDU
         HKZS0Ao0gDh5DUHUbq+sThstZhsYjeQWHxmdN6psi/Ogxqu4i4fs/qnq/gOdn9BeA4NL
         1LrqFOfVY0ETE9C/Lbt5oEHEvavIQToiTNfvWqS5N8UR4VNhB3rEY0mv6lQ5H+OLL0np
         9gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774610914; x=1775215714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPoRKAikqi9O5TMw7pTEWsw013Li/e5d6u/ewbLWq1k=;
        b=fh51thnQsKSoJJgxYaNy7oJcyBw/hN2u7QBw7+89TBOBT52wsIefUFQEZEWSG5nn56
         n5Q+LMShZfsgiJFH5AL2uDiXPHJuuc2tKqh9IvDxKWB/IFXTi6z8owLf9qz5ImjUrKV8
         cA24Hol8aHajQ4f9kXLC7/YqCWE9lwxYonJeosnqEWLBC6z/7gJegppXesDqpe7abmsy
         jn0RkiSEsgG0Ljwf1TNb51cOTLgw9PlqDzLE+DL+0dS3mFXJmEvCO4n4GfHEDYwdl9u4
         BbILo7IuCbBcd1nXPzzk9KIc5yLAca+69N2xNCKHDRiW7EDieJ8kpqBHnjkJU7zE1vG5
         QKfg==
X-Forwarded-Encrypted: i=1; AJvYcCXF6crKL4Y6ffXVsXkYB3ZmeryaqwO0XKAQIawUSNnbu9TbengTVzXan3qIL6ikAPWp5WeesyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJ1a2fQZ53NG3Jtc7igMhdTm2YxdbfsMAN6u6E4wv15rO6aej
	q6TSx24uqA1O9Pbnu6Sla7CHpRPZPhqe+H3652m50w4qcmWtGTr13Bxofq7sOC3pxFujhheRyjj
	vtD4WKgOeJM9MkGK35csK0wNxy5uWtvIdkXBgiDxs/DndXNLXYLXA4t2zzQ==
X-Gm-Gg: ATEYQzxl6YOJ+YX+m9vMgiRbt58xe+xjW13EvlzYRvJYa5P+V/Yy68suHfclwGlT4pz
	1ELJs69NWwH45vV0OAV7Hpj56g8ZZuwiMdbgXFwap3gTl6KxmNBoylMvnMqF4JUKJFq6VUwavFp
	sQpStw+sL9IiJ0Qn9Tjw6VxGZKh8+0LQ8UaN18IQkHoiNnKxTfBRPHlZJWJgFjNeJNeagmO7Y8c
	7dRQyKCC13wymdm6AD0YqpDCWGi1d1YaBbj87lbE2EzFmCfTxMqeUhjTg0X2bFHH4GVfUJerF5I
	6kfWxAlMd9DPtJfThKlVNOQgxu/d3JPXLs8ExZwHiZOdf/ocqExRxjuHUsoa7rrbBgLVaScKvKP
	WREybTRu8gnsQ2GXCJIuNln13FNqOifE5rn7KlY6MwusAk1PsvRBHp1BMRWxMwdscj3qX9TZ/Kg
	==
X-Received: by 2002:a05:600c:6094:b0:486:fd71:e609 with SMTP id 5b1f17b1804b1-48727f1fc05mr31217275e9.25.1774610914018;
        Fri, 27 Mar 2026 04:28:34 -0700 (PDT)
X-Received: by 2002:a05:600c:6094:b0:486:fd71:e609 with SMTP id 5b1f17b1804b1-48727f1fc05mr31216875e9.25.1774610913538;
        Fri, 27 Mar 2026 04:28:33 -0700 (PDT)
Received: from debian (2a01cb05923c9a002e69015071700bd3.ipv6.abo.wanadoo.fr. [2a01:cb05:923c:9a00:2e69:150:7170:bd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722be47a4sm134780515e9.0.2026.03.27.04.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 04:28:32 -0700 (PDT)
Date: Fri, 27 Mar 2026 12:28:30 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH net-next v4] selftests: net: add tests for PPP
Message-ID: <acZp3gRUqVIbw9yb@debian>
References: <20260326021642.29170-1-dqfext@gmail.com>
 <20260326081304.xKa7-s_1@linutronix.de>
 <CALW65jYdzn_rZWa2zwYd5J+Gd=kyaGMsVFyX0fMJfKfgULMO6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALW65jYdzn_rZWa2zwYd5J+Gd=kyaGMsVFyX0fMJfKfgULMO6w@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272507-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnault@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 79C1D34372B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 04:26:23PM +0800, Qingfang Deng wrote:
> Hi Sebastian,
> 
> On Thu, Mar 26, 2026 at 4:13 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2026-03-26 10:16:24 [+0800], Qingfang Deng wrote:
> > > Add ping and iperf3 tests for ppp_async.c and pppoe.c.
> >
> > Oh thank you for doing this.
> > I haven't look in detail but this cover the "invalid loop" cases that
> > ppp tries to catch?
> 
> By "invalid loop", do you mean transmit recursion?
> https://lore.kernel.org/all/20250715150806.700536-2-bigeasy@linutronix.de/
> 
> AFAIK, this can only happen with PPTP or L2TP, which were not included
> in this patch.

The problem was originally reproduced using L2TP, indeed. But I guess
that it could also be reproduced with PPPoE by using a UDP tunnel
device like VXLAN (like sending a packet through a PPP interface,
handled by PPPoE, running on top of a VXLAN device, that routes the UDP
encapsulated packet back to the original PPP interface).

> Add Cc: Guillaume Nault
> 
> 
> Regards,
> Qingfang
> 


