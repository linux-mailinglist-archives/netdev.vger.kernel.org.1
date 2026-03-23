Return-Path: <netdev+bounces-270452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHYvLAMRwWk7QQQAu9opvQ
	(envelope-from <netdev+bounces-270452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:08:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D552EFB28
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71D373007514
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B689389105;
	Mon, 23 Mar 2026 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ2Uqeqe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65ED387355
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260466; cv=none; b=R+KI3pwSnQVcfve+eCt263Zl2rsv8DA7xXVIGGfNwCNWIYoHSorMWKxZfITH/NPIyik72vhqu7tp9bJwPCJ3m6YwlJoKeT3bjqULoREECLBSaarXziVCWAkyPPlC1Za7wGkjyzLnYPGGefalw/AW3tcOQ47Q+1+0E++D2WLEmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260466; c=relaxed/simple;
	bh=RnRb67aJhdoobL1+yb0yapx9lDUKuhEUuKOiHww21fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJVgYr//7W0qRq4w2HR/yHJ6dRlrz5whnYGVL6jRmcstDpAvexmKgxI0BBteUz3sXbsRYorgoojnh9vt2CZfM85YRF7eDX2lmjCnGnt7aDmJToGKzou6BErUX6DrKHoEnPlIpoWyxXqg4/anXXtb4DIYpXZDOFsx15yZAsItHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ2Uqeqe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ab1c8fdc40so6199755ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774260465; x=1774865265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBCaYQ3+29u4BDSGOatWgxwGuWOYqXGWhcJNvSTcfMc=;
        b=LQ2Uqeqekyp7rLBBCIGkqnnHN9mSUNk1mFQTjXHlcOK0DdcwgsKXPuYYQAjMLj+fd6
         popuuzJXmOwCTS2k7ZXLpWGRBcQVX0TPl/WJj6XbxrjsOszEO852PO/C1jMg9HXdEDLy
         2D5oTdH/SYbO/n0jnoMXPsH8S2eBBiNuY6Po6+Apv/oEJLfMdqCVFnBNd7vqvUe0xI6/
         gIiLbdKGwHqVt9HIfxiccvVz24k82vnYKsEwzBTDiquWN4seAoY57pxzhigUaiptImrz
         ES2PBM96FHMfju0bgcQUhhggwiSYamDXiZVWct7fG5r2+/etoPR8kKlcv3No/q5LZ7u3
         NzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774260465; x=1774865265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dBCaYQ3+29u4BDSGOatWgxwGuWOYqXGWhcJNvSTcfMc=;
        b=YQgiGUKDh/9NBK+y/Xf8OVlWQ7rHMd5bgdWaZtn11mFrTYkARRaKh7sOV0FMlsKxrM
         l0PRLXViTimGbxstUK2ss5Yy9a4jZzrclRqXr0sOQMuaEJv4Qru1NFwMrvSHk5e5eJW1
         5f3tNNXZHsoa/onYvjEz5sNO+BCnt23dg6pI8zgCUqnSHyGsGkU1cvCKiEPAh1eptlwF
         HCLn2Krre9KG2GNfqeRSWm19ayibWCMnktLVKx7xZEtZWibULIiZrYwTZ5/U5IvBg/Ms
         EFjRgF16j4NMrTZyAtDD5DnjGs2wx0xHgK9Y8cGvr1a9fAAJ1s9wip4o09/5gMaiqX2T
         uRVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9HUU5bhgWPvif+FWh9UE/Pi4NqYRQQMJFXWlbiX7EaRNscpUTPlf4bDp6Mpoo2VxmGzIdW/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhtJysQQ9uh2wDMZa6D2aaRulFxpU1zC2ResFGL9UW0PRIiqO
	rU+gqHrrb3i0u/5jQaW1uExpTSVAr2zen4ZNMIA0xVSfHT3/vHiRTn94
X-Gm-Gg: ATEYQzyj7EUExwV/6qBERSI/VEmszY0MYcRe/oixSm121MCV3a49EUbnbw3jsjuo8y5
	HngNJRFJN4Idv7qQgy3bIWwTFpPmGcqgcH7yzSzSrj1sz/yl4VAl8Dsp0XXbQAVUcCrXaQSWuXM
	f8DQY2qJJmrEBzk5eIJL/DrNrJon5tp3NCDddo6prxDHwAzGP3WSaY4zyS5TTTigib1BfYB5PlM
	3o1g1SGSM+ue4la7Q9ylQVSvKgqgIXdxZmxT3Dbrv2W+M3JqBMp1q13W5H7gFsMKdpdCWNMOF8i
	i4zc0qvL4RCZioJvFpyyLlMZfxYk9c5kN8HWkXpN95dsIlDbld1nYZs7WjcMUW0Q8pzba6nuLQk
	1zqf3IEYvnadvZtBxgJ70wKW7QuDsbIOQjwGWipxnacf6gpgBC0H9C0ISRz89H+lD3y1SYP2mI6
	GLuuHeHjT0qQAUuRj3pksWiFIuSi5QRKkM
X-Received: by 2002:a17:903:22d1:b0:2b0:59c4:e9d7 with SMTP id d9443c01a7336-2b0826d3f68mr73507385ad.1.1774260464884;
        Mon, 23 Mar 2026 03:07:44 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354bcf0sm108757965ad.33.2026.03.23.03.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:07:44 -0700 (PDT)
From: sunichi <sunyiqixm@gmail.com>
To: razor@blackwall.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	gnault@redhat.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	leitao@debian.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sunyiqixm@gmail.com
Subject: Re: [PATCH] net/mpls: fix missing NULL check in mpls_valid_fib_dump_req
Date: Mon, 23 Mar 2026 18:07:21 +0800
Message-Id: <20260323100721.1950677-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <acD_RwWEHSO0HGrg@debil>
References: <acD_RwWEHSO0HGrg@debil>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270452-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,debian.org,vger.kernel.org,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[sunyiqixm@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller:email]
X-Rspamd-Queue-Id: 51D552EFB28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 at 16:52, Nikolay Aleksandrov <razor@blackwall.org>
wrote:
> On Mon, Mar 23, 2026 at 03:15:15PM +0800, sunichi wrote:
> > The attribute tb[RTA_OIF] is dereferenced without verifying if it is
NULL.
> > If this attribute is missing in the user netlink message, it will cause
a
> > NULL pointer dereference and kernel panic.
> >
> > Add the necessary check before using the pointer to prevent the crash.
> >
> > Signed-off-by: sunichi <sunyiqixm@gmail.com>
> > ---
> > net/mpls/af_mpls.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> > index d5417688f69e..28bbea30aae3 100644
> > --- a/net/mpls/af_mpls.c
> > +++ b/net/mpls/af_mpls.c
> > @@ -2174,6 +2174,8 @@ static int mpls_valid_fib_dump_req(struct net *net,
const struct nlmsghdr *nlh,
> > int ifindex
> >
> > if (i == RTA_OIF) {
> > + if (!tb[i])
> > + return -EINVAL;
> > ifindex = nla_get_u32(tb[i]);
> > filter->dev = dev_get_by_index_rcu(net, ifindex);
> > if (!filter->dev)
> > --
> > 2.34.1
> >
>
> Why necessary ? Did you actually test and see any problem?

Yes, I've triggered null-ptr-derefer.

```
root@syzkaller:~# ./mpls-dos
[   12.591512] BUG: kernel NULL pointer dereference, address:
0000000000000004
[   12.591817] #PF: supervisor read access in kernel mode
[   12.591924] #PF: error_code(0x0000) - not-present page
[   12.592052] PGD 1041c9067 P4D 1041c9067 PUD 102273067 PMD 0
[   12.592371] Oops: Oops: 0000 [#1] SMP NOPTI
[   12.592860] CPU: 1 UID: 0 PID: 167 Comm: mpls-dos Not tainted 7.0.0-rc4
#12 PREEMPT(lazy)
[   12.593051] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.15.0-1 04/01/2014
[   12.593305] RIP: 0010:mpls_valid_fib_dump_req+0xdf/0x1f0
[   12.593710] Code: ......
[   12.594032] RSP: 0018:ffffc9000035b908 EFLAGS: 00000246
[   12.594149] RAX: 0000000000000000 RBX: 0000000000000004 RCX:
0000000000000000
[   12.594277] RDX: ffffc9000035bab8 RSI: 0000000000000000 RDI:
ffffffff834bfd80
[   12.594393] RBP: 0000000000000005 R08: 0000000000000003 R09:
0000000000000000
[   12.594507] R10: ffffc9000035b908 R11: ffffc9000035b908 R12:
ffffffff834bfd80
[   12.594623] R13: ffffc9000035bab8 R14: ffffc9000035ba48 R15:
ffff888102114330
[   12.594778] FS:  000000002f71d3c0(0000) GS:ffff8881b88fc000(0000)
knlGS:0000000000000000
[   12.594916] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.595014] CR2: 0000000000000004 CR3: 00000001020b2000 CR4:
00000000000006f0
[   12.595283] Call Trace:
[   12.596008]  <TASK>
[   12.596308]  mpls_dump_routes+0x167/0x1e0
[   12.596471]  netlink_dump+0x156/0x450
```

> RTA_OIF is parsed as NLA_U32 according to rtm_mpls_policy and
> nla_for_each_attr walks over all attributes in the msg which
> means it is set and we must have at least that many bytes
> available for the attribute. So how can it be NULL?

Yes, NULL can pass the check, so you can see tb[i]-null-check
everywhere in the kernel.

