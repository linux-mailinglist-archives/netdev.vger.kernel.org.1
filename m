Return-Path: <netdev+bounces-137108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1339A464C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC121F242CF
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37C204013;
	Fri, 18 Oct 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="sZGQoEts"
X-Original-To: netdev@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA6202F71
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277728; cv=none; b=biP5PACDnCquEVsKftyaK/88yCgg8lAWfZXf1UXOD56efugOfPXyy0qO4pDOVJrxN41LHkfcYtU7kQfutiXItjDzJIFh4+xYaQNY9Z91/jqoTPIcS3fquJe82SNRdYLcWFGhz6430JwaIzswVeSIksC9FodQEMUj5J6s1BJ004E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277728; c=relaxed/simple;
	bh=FyxG8L0kTeJMBvFZ2TqpR7bCfzlRoydYJ1KvWJsuPAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emOWlrWZi0MFI+9SaJI4ObIeF50XmtTWUwA3uStG+EF+CvVqCy4CiIY/391r1rJVBDL3g02UC3pVRp+gDpWu3r3tBUc5ctAiAh8QnIlBisc5XPrlENnnc8H76Xeh0fGommq7Yz+ClpFrW/5VhVs8AB3TjlmoihG/KuwGi/CIHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=sZGQoEts; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id 1pKptBKJ0qvuo1s88tuTQE; Fri, 18 Oct 2024 18:55:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1s86t6cFpGNqB1s87t6kGa; Fri, 18 Oct 2024 18:55:19 +0000
X-Authority-Analysis: v=2.4 cv=cqidkU4i c=1 sm=1 tr=0 ts=6712af17
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=1cCw6Q031rO_cLs8eM8A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KrrHr3IraN34Z7RX5pMYVY2PbGjQrd0P+774MqXGDuM=; b=sZGQoEtsG0vy1dYKYMPwugisEF
	6RFiB5MLfeCqdEgdeLf6elPw+zhdYUUFYR7g2xW7vi6MIQvzvngqrEHhEKC1yHicB+fqEKOsh2HYK
	zdyy/Cv6DxRnSNE7mdCF0KJKfkDRalzdRGW3AGAx91xeMnX36z59pq+9b9jDaUKiaxowEoSEW+6HB
	RGqUzVywxRLkD/4HbdA7eStG/bze7zndB8rWKS902vb1aGeoLxIC7DXv6RAdwal1S2OP286Qf5+Eq
	cLg5LZQQKACAOHMTnjyx6fOMbl52j32doIYDiQeXbXHEaRDhbLFL2TPS8frIVVE1hrWKuLBHk1m9h
	41rQWJ3g==;
Received: from [201.172.173.7] (port=46946 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t1s84-001YNE-32;
	Fri, 18 Oct 2024 13:55:16 -0500
Message-ID: <7bef8129-55b4-40e4-80c2-d319b8d6c251@embeddedor.com>
Date: Fri, 18 Oct 2024 12:55:10 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5][next] uapi: net: arp: Avoid
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <cover.1729037131.git.gustavoars@kernel.org>
 <f04e61e1c69991559f5589080462320bf772499d.1729037131.git.gustavoars@kernel.org>
 <ac2ea738-09fb-4d03-b91c-d54bcfb893c6@lunn.ch>
 <202410160942.000495E@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202410160942.000495E@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t1s84-001YNE-32
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.7]:46946
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIv/rnccsWrQzLqG8/cJas91WBR9v8E6LXbHMACYvNm5Bbkt6b/npavcfCO4++oya5b/F3meBo2P/0q0t0gsZ6iugwx+W67qO8CM6VQkDOFnhRyW7sd2
 ojkhFmwLSTAjUKc9yo0Ij/sQLymbRezMqPxT9W0q+aKw998hTYDI6wa6y46W93fylrFaUufel+7Zi1osrMQhhfBhyLf6gWjr4Mk=


>> These are clearly UAPI files. It would be good to state in the commit
>> message why this is a safe change, at the source level.

Yes, I'll update it!

> 
> I think we can avoid complicating UAPI by doing something like this in
> include/uapi/linux/socket.h:
> 
> #ifdef __KERNEL__
> #define __kernel_sockaddr_legacy        sockaddr_legacy
> #else
> #define __kernel_sockaddr_legacy        sockaddr
> #endif
> 
> And then the UAPI changes can use __kernel_sockaddr_legacy and userspace
> will resolve to sockaddr (unchanged), and the kernel internals will
> resolve to sockaddr_legacy (fixing the warnings).

Here are a couple of test patches (Don't mind the changelog text):

https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=testing/wfamnae-next20241015-2&id=c3b631a5036cbf45b3308d563bf74a518490f3e6
https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=testing/wfamnae-next20241015-2&id=66db096a530b95ce0ac33f9fdec66401ec5f2204

__kernel_sockaddr_legacy seems a bit too long, but at the same time
it makes it quite clear what's going on.

Thanks
--
Gustavo

