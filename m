Return-Path: <netdev+bounces-277419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CJ0II712GlJkAgAu9opvQ
	(envelope-from <netdev+bounces-277419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:05:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 225123D7D9E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06715300D633
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242BD3033FE;
	Fri, 10 Apr 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWiJI2tO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83752E6CAB
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826278; cv=none; b=pWEItRrkBEMhHc7VOetgMQVfOuZ74573esjV77o/mATwVAXntGummlfWHZf3uNGNRnxpC5wavcq98kKeTO7Y+trX/Chpz3tN3Ds9lElhY8BnfzCvfaDz3WFQ43zeRd+vyj5xONeP0N1JNbSrWfH0m+iTRwP1EI5IzGuhL7HK8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826278; c=relaxed/simple;
	bh=1kw6okKUaPDDpqF9rWOA4iTWWmPUs4vgB/yj52WzvVg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RItqdvADHop8KEl9sx5Vbp6I/3Rg5gWItIaqCkdZupecSO2djEjEH2R5cg7PwlzpfW8op46QYGwDwFVJ1KFry4stu4IPPvmPZYHJpwaWUWU/PQ7pQQxuo+BUd8arrV+axcjGZWtUbg8zL4bfZVEOluqhZrB+O2QLEjZbWaZPWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWiJI2tO; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6500040ef83so1539320d50.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775826276; x=1776431076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT7bmyanBC/FWYO1alMxZUz4ZsRuQwbnhu9K2iERy/o=;
        b=OWiJI2tOMwQi33V8hJpIA/y8LYNo1l713reQUDT1dYksj0iVe6WZ8foXskc4k1j2ve
         E1y8T1xtg1Y93YOLx57lDm1lnasGQdxKXfS79jORbbQ09RxUOtDX0bTHM25S6iC/NQgY
         BlyXWZHswUo9ifevfdEw1YdvE5vvMHKdijdz89fTN8zGUORJ3aIDwXjYiHE/tPuOAdXE
         n0/kp1MTl1bXZYdgAxSY0H3Nj2pfNZRqZ8h1gswAyQ5K8bYwLNFXI8UnigRCNcei3NOm
         M4WBShI1fbx8X/iDNVSjPMbtATjtBzXF3/GYr7KMuu7DpOrKJi4lrraQGyVCw7bf3Mk8
         1ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775826276; x=1776431076;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IT7bmyanBC/FWYO1alMxZUz4ZsRuQwbnhu9K2iERy/o=;
        b=e0kOahagUz7of83mrTWujcPW/u9LWdBI+xnBeGm/xKloOwqP1BmopNRWMB+xtt22Ms
         vAoVqo4nZYw1kOZpLCr5lnrCbQJ4p8nnSDbCvKSSDxIfatCrXD5dnB3v3pLogIbmGRY5
         H2V3r4kJ4YMd+EPaN/pUTpFdUoZRH+zoxvaZvcwCpn6XoayTCmkCY1OcjKRrOxjO2R+j
         ScC4gD+z08+tOGAtgbQSwJXYBERIgYoTvmeDur9EHCbMQ+2KfpOsAxto0vc4R9uAgpwb
         +xZSMeU4puSIKeFPMozjeHr/X/imi8kzqAYLCdFbWlZafX0iWgprwf5z9SjvQt9J0+MP
         Stuw==
X-Forwarded-Encrypted: i=1; AJvYcCVKvfC+zrCAJgEYTR9iBEZ2Fiu4QCYMdTrrwSTcYcSS4XRIYe4r+GwcQlq3FrHVygHextwZnZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yV6aA3gSUU1b/tOwqXPHPu5q7D+tr98jbVAw3Pu2Ki5/Xjvi
	fiBT9cFsanaSKH5IETOQKElqHHzxm3nzbWwZL85V8wUD/jOlTU5RN1pD
X-Gm-Gg: AeBDiesKK4aHXoze04NBudQVZQJn7zUt45Dyx+WzxbxTg4qCZLrGV4I3T9YW/wLZ5lj
	h7aajmAGRCYBX37prEpJox5Fjy0Ibchv75H2B8G4U0C27e2NOTKcIWB1DWmLTrfHYot6qZ1HshX
	B//HoggUxlswXh516oWb1Vz+R1LNei61Mhc4gjV2jc3WCeqP+uttO8XEf2nxFiMtMCxiw8y6/+z
	fmZZ05oos0tRuojzXZ7nOenA2NOu3K9knPJqECMbYLJ+2CEPN3IDdVNaqU4AK8+e7IYDHsinPrM
	XkgbndXRxxXhrKz0uEY2obMmlftHtE2B0R2WUTKRYM+Kbe0D1UaJ83jOBGw3qox96akVnQXbKUX
	rK4BiCXto+z+MAGirxcQUfnP3eCAap/xKY8E/QPMZ4utmPF0ADFrHTfdkn8bS5RurZY5YTw5Jsa
	gRGVbt+vTf6bRrejJ9tBnVT7mBkJGvRILOqEuHSr0MCx47O7ZM4Yu+a4ampvjy2ZpDryFxkjJ0o
	cd4
X-Received: by 2002:a05:690e:24d7:b0:650:5316:1756 with SMTP id 956f58d0204a3-65198bdc1f9mr1842843d50.57.1775826271470;
        Fri, 10 Apr 2026 06:04:31 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65197c1cc5bsm1186360d50.16.2026.04.10.06.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 06:04:30 -0700 (PDT)
Date: Fri, 10 Apr 2026 09:04:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gabriel Krisman Bertazi <krisman@suse.de>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 kuniyu@google.com
Cc: horms@kernel.org, 
 netdev@vger.kernel.org, 
 Gabriel Krisman Bertazi <krisman@suse.de>
Message-ID: <willemdebruijn.kernel.242540011e53c@gmail.com>
In-Reply-To: <20260409221532.69090-1-krisman@suse.de>
References: <20260409221532.69090-1-krisman@suse.de>
Subject: Re: [PATCH] udp: Force compute_score to always inline
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277419-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,gmail.com,davemloft.net,kernel.org,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 225123D7D9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Gabriel Krisman Bertazi wrote:
> Back in 2024 I reported a 7-12% regression on an iperf3 UDP loopback
> thoughput test that we traced to the extra overhead of calling
> compute_score on two places, introduced by commit f0ea27e7bfe1 ("udp:
> re-score reuseport groups when connected sockets are present").  At the
> time, I pointed out the overhead was caused by the multiple calls,
> associated with cpu-specific mitigations, and merged commit
> 50aee97d1511 ("udp: Avoid call to compute_score on multiple sites") to
> jump back explicitly, to force the rescore call in a single place.
> 
> Recently though, we got another regression report against a newer distro
> version, which a team colleague traced back to the same root-cause.
> Turns out that once we updated to gcc-13, the compiler got smart enough
> to unroll the loop, undoing my previous mitigation.  Let's bite the
> bullet and __always_inline compute_score on both ipv4 and ipv6 to
> prevent gcc from de-optimizing it again in the future.  These functions
> are only called in two places each, udpX_lib_lookup1 and
> udpX_lib_lookup2, so the extra size shouldn't be a problem and it is hot
> enough to be very visible in profilings.  In fact, with gcc13, forcing
> the inline will prevent gcc from unrolling the fix from commit
> 50aee97d1511, so we don't end up increasing udpX_lib_lookup2 at all.
> 
> I haven't recollected the results myself, as I don't have access to the
> machine at the moment.  But the same colleague reported 4.67%
> inprovement with this patch in the loopback benchmark, solving the
> regression report within noise margins.
> 
> Fixes: 50aee97d1511 ("udp: Avoid call to compute_score on multiple sites")
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

Spotted this a tad late: should the comment udp4_lib_lookup2 be
updated: "compute_score is too long of a function to be inline .."

