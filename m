Return-Path: <netdev+bounces-280785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBr/A7Y26mmhxAIAu9opvQ
	(envelope-from <netdev+bounces-280785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:11:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E3245421C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40750300119E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702BA32D438;
	Thu, 23 Apr 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjbgXX4S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C67E221F20
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956389; cv=none; b=e3gWRmKfOBxIuKt9e3mAJbjCvNSNlH+E1Z+5ncqCD0j8c3OnC+czMp3JXc4GBmy01Ek8kibD0SWyRKrFcQxRsVUgM/nptvIzpA7D+lsQafkqBgVg33NBe7VrTXbyWnPHoZTOYp1jbmyBe/Cp695TWUyyAPeRUYKLhdbgMPZtvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956389; c=relaxed/simple;
	bh=0/Y3NkugThl7usHxQCRDSzltdlI1vD0mtZfLD7QQqvI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cOa0cbDekaJ0ZQPNlIP2UuUBAU+NdGMigHOjmMx7rsLl6rDpQ5IIXu/XljWvqvfgvIPzi/4q/NJIVJwj0XhjrgBQFUgX/XZZMJg++5KY/WgfmT49wXjibK455NDa6SW95NpY2FagoHRMqbGl71Qoel1jr67SO5nBOtYaoj7yNJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjbgXX4S; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6501c4857b2so5666145d50.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776956387; x=1777561187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUE05i+pPgw2ZW2Bsazu/9Y1/N4pPdRcSZWFm4Kxm1A=;
        b=jjbgXX4Sr9LACNNBJce1AN+dGDSN5l+Cz7CVKev36l2wUdmycQwOqrWybwzEPKdFA5
         SSbscxLs26l0Xues4EFG2sjzTQHXVN4F6WE9VhT4Vw6C9qlqJ2/4dYGq4/CugMdufOQT
         mYgvanXIcjFzgrc/DPX5uSF43VbyRJiWGU6KklhF5JshPSIimfj3nThv5jUvVSsLDQ3K
         gw/pYK3zl1Sj97Z3sdCgQN+AeT+TrJXYoAlBNBwpwAQi4+NlTQToAQ7aRESh3TaTHONl
         xv84AssO78Q8oJAlVhC568fGfMptAFPX1ZPOIJCwAayJrsJMUboc6xz4bNmaK97WAQCI
         X6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956387; x=1777561187;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUE05i+pPgw2ZW2Bsazu/9Y1/N4pPdRcSZWFm4Kxm1A=;
        b=AXObDhVsd9iH3dKHzLiNLObRmqK/sf4237/3jFW7mWX/f2QDWTCh950mu5YQReDl25
         TCVKzThWH4trh7X8klY+YKijf24YC/FzIoO6axL8/ox1Tn0LtSFJzdwgw9uUIpNETWpa
         gokhD+6gKIfr2jLJPhHUt9U807cCx6V4BnKoulWr9rMYO7f/vWXZ8i5Wm4qK6GJ65Veq
         Yzt/8ZGTYU9ERvrM+WBVF0im6IImywIAgMRBUIGYP9fOSlal5bbghDTRsISUKRbcCfUU
         RwrNHIohE2umjqHmwWqfAKUnxIPVzYvJVGLsmrDFqRuyPbUhrTpzHZr3kNwMh5+SoDCh
         pGlQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LPEWUsH1Zg21aFctGOeGWPf0Y6Ey2j1XvtyGL0k/r3zQHno3+5pp0HHn6mpdomHNgolqtseM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpC2R7e7sYVcL1Ob92EMllAulKSCTaCuWnX7PU2gwdXgfuvW0
	jkP0Ss22nEV3KzrlebCjLsVwl4S0m9Kr7RgKFj9o9ug+QC7TrG07yrVG
X-Gm-Gg: AeBDiesySNuojzTxUL49+6yer5eT2BhuTfhILGI2dCzMWDbmIL8BPp3QlEPCckgZ4jB
	g9/MffM+Tp6x3J+GxwByNu7TEFhgWvZv8oufCaZRgm7y2kmAoZ4MUEsNZd5AFpXYXCC1qFEHjh6
	V11A0ssZXKdy0qqT2FCEOqrUTjiBZ4dyn+fQ8fMdMXdQR1tpnJxvDePfLvqXLQ/PVNtlTdMNL//
	v7ULoIPflhqTsPWUJsjga4IeluUgWFF++ycyyq92glUgrRLLsIe2/1S9WeW+Y7ZHGhmGoa3L6DL
	CBJbrTP7BYHq1QQecrtlYkuf+3qMRYVLhgsYqDhXn536r5fbJojWq6P9k/2EFxj0iorIbWD+lo1
	ShMgUJW71iDGdhEvt4JHyTHM2q3GTXUKVGT6vkZ4eQIu+5x0JRxUG7DdRIe9J2pRqcstPxo8e6d
	fDlmB6ToLQolExrQ78pwCIPUTB2O3sqRY3CszoSUFi8NtgKbslB+a37Fm4dRWDOqs07389Kvgpd
	gUlO0FGh73UC0c=
X-Received: by 2002:a05:690e:13ca:b0:64a:d479:bfbe with SMTP id 956f58d0204a3-653107e1fffmr25373381d50.11.1776956386648;
        Thu, 23 Apr 2026 07:59:46 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65441e82f54sm3509511d50.14.2026.04.23.07.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 07:59:46 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:59:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: sd@queasysnail.net, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mingyu Wang <25181214217@stu.xidian.edu.cn>, 
 syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
Message-ID: <willemdebruijn.kernel.28284ffff84dc@gmail.com>
In-Reply-To: <20260423082233.514056-1-25181214217@stu.xidian.edu.cn>
References: <20260423082233.514056-1-25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make_skb() when queue
 is empty
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280785-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[stu.xidian.edu.cn,gmail.com,davemloft.net,kernel.org,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:server fail];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,e5d6936b9f4545fd88ab];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 22E3245421C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mingyu Wang wrote:
> During fuzzing with failslab enabled, a memory leak was observed in the
> IPv6 UDP send path.
> 
> The root cause resides in __ip6_make_skb(). In extremely rare cases
> (such as fault injection or specific empty payload conditions),

Can you elaborate on this? Which fault injection lets
__ip6_append_data succeed without writing data?

> __ip6_append_data() may succeed but leave the socket's write queue
> empty.
> 
> When __ip6_make_skb() is subsequently called, __skb_dequeue(queue)
> returns NULL. The previous logic handled this by executing a 'goto out;',
> which completely bypassed the call to ip6_cork_release(cork).
> 
> Since the 'cork' structure actively holds a reference to the routing
> entry (dst_entry) and potentially other allocated options, skipping
> the release cleanly leaks these resources.
> 
> Fix this by introducing an 'out_cork_release' label and jumping to it
> when skb is NULL, ensuring the cork state is always properly cleaned up.
> The now-unused 'out' label is also removed to prevent compiler warnings.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

I think this is 

Fixes: 6422398c2ab0 ("ipv6: introduce ipv6_make_skb")

> Reported-by: syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

