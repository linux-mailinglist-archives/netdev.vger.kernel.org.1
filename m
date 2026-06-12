Return-Path: <netdev+bounces-298466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7DfYIxeoK2odBgQAu9opvQ
	(envelope-from <netdev+bounces-298466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:32:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808C5676EE1
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:32:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=NhbVEeJ0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298466-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298466-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42666300AD92
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A19D381AF9;
	Fri, 12 Jun 2026 06:32:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35217372076
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:32:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245950; cv=none; b=Yh0JM3Kojj/oqD3/9Ujq388StNcsGokArvFRi7JLoscO3tAsLDbo3Uto2iXSH+U6VEEqlYF/gQusCQnDwP8jYlOb/cZqvnVq5jmSEHM29dMU8DcQ5kBrrCTKer0AKrdNQtcR4ZkmYW7r2au0m63QzzvocEw8za3wJT2iMFPiD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245950; c=relaxed/simple;
	bh=FvWSchUqR2dcliEuXBwiVbHUgGM54jMe5CV9nwyt8b4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BZBo+FVmvHt2Vie2U5V3OW7v+m0xAdRpS3qit4UPWGSzZ71kW/TyJpY0QJF+eDYhj3mN69LHNWbFcRNY0WD990SCwcuIWHnD2gCR5zCp7Jfs2L9S4Y4e4WzQMqO9dk1Grr3zozNFcyqfQKdUIgXoHRs8PDShgMgZKclE6nTMpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhbVEeJ0; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2a4babe45so3981965ad.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781245948; x=1781850748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k9bT+FGeGqFiR60jxcDWRz8+0RtnvReJ5AlgbQzV5Lw=;
        b=NhbVEeJ04lvl07LR2FsybpeFdoH2ZHoHgAnc9TkRjCRAQurZlUlq5knlcUshdWciie
         jqPWZW2ZyYQwqjL40TMRZV3JWDjucOBZkNxeVeCHxdLXlCxb+o69JUNwy9dURf9Ialpm
         3PgFHwRnyFqyFJDRNkU25Bmeu0CExQFIz0MEAgr69ZpIbHWnxcgAqqu+41J5gSymLKcp
         wU64w4mgqRtZclicMOJcmqMo54ol/nzflCf5SR6Xj0y7GmVqWDgKNz6O0YaPWvNl/Y+0
         pEqi5hu3fZ1P3BMrrzzenBnFKJEbJqZOaLkX4RmOlbPbxsIXE6AtD0WbeONGO1vIjh01
         OWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245948; x=1781850748;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9bT+FGeGqFiR60jxcDWRz8+0RtnvReJ5AlgbQzV5Lw=;
        b=iI+3qtJb1cD2+xBgebCtyRWfbS4QE3SqQP+WVSVo6uLcGgMntxNPCMq6cW/N7dMicE
         59M6u+Lk4ep26xVXiBt7kr/x4PsmPH/54FfXafmzaQfU8ogW/cknxMSATe2VuzXddP9t
         aRwRTHb3eV+KlltvDpatbLjmcLQCOM5DntcMYgE01w5U2QJnqfeh+ZJjs0WNPSGG316q
         X0i0ODNxfTV+3DLGFFZcYaR+ZXwV4XqoUCcP9Wmy9l+yPhEj15G/v3i6Hu/z9RCIeqoz
         NoghwOUSxbMnNLl+lFJEEB8bIgzSPtnMKQChBDQOfn6uos8uNVyKfAqQg8HikaN19dM6
         st0A==
X-Forwarded-Encrypted: i=1; AFNElJ9P9QieEktATJYJ5xBZuVhiFp38AfUAyQLBFjFbCMMyCJlj0nOgCEW7cezDqcANp5qo0SS03Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFt4A1Suvt5pTDQQppEmvaCaNul414LJcdZNm9BZtZtAkvKf4
	uud9wmJ1dZ14DMDIq8fyXaeppFbNh6OFjl5McEWF2DM5IRmtw3MYJFL8AqzC7XPGQ15AocLeSE2
	iT/Hnug==
X-Received: from plbjx8.prod.google.com ([2002:a17:903:1388:b0:2bc:c1af:322f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c401:b0:2c1:6020:7398
 with SMTP id d9443c01a7336-2c410fbec97mr18160395ad.12.1781245948192; Thu, 11
 Jun 2026 23:32:28 -0700 (PDT)
Date: Fri, 12 Jun 2026 06:32:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612063225.455191-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/5] ipv4: fib: Remove RTNL in fib_net_exit_batch().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298466-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 808C5676EE1

Currently, we flush all IPv4 routes at ->exit_batch() during
netns dismantle, which requires an extra RTNL.

IPv4 routes are not added from the fast path unlike IPv6, so
we can flush routes before default_device_exit_batch().

However, there is implicit ordering between ip_fib_net_exit()
and default_device_exit_batch().

This series detangles it and moves ip_fib_net_exit() to
 ->exit_rtnl() to save the RTNL dance.

The same change for IPv6 will need more work.


Kuniyuki Iwashima (5):
  ipv4: fib: Flush all fib_info in fib_table_flush() during netns
    dismantle.
  ipv4: fib: Call fib_proc_exit() and nl_fib_lookup_exit() at
    ->pre_exit().
  ipv4: fib: Free net->ipv4.{fib_table_hash,notifier_ops} without RTNL.
  ipv4: fib: Avoid calling fib_trie_table() in fib_new_table() for dying
    net.
  ipv4: fib: Convert fib_net_exit_batch() to ->exit_rtnl().

 net/ipv4/fib_frontend.c | 37 ++++++++++++++++++-------------------
 net/ipv4/fib_trie.c     | 10 ++--------
 2 files changed, 20 insertions(+), 27 deletions(-)

-- 
2.54.0.1136.gdb2ca164c4-goog


