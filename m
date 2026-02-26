Return-Path: <netdev+bounces-261341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAr7N65EoGkZhwQAu9opvQ
	(envelope-from <netdev+bounces-261341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:03:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC021A60B9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA6BA31593D7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4466C2E2665;
	Thu, 26 Feb 2026 12:58:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B72DB7A1
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110718; cv=none; b=L6wiedJuCHSAReCnqCSJnPnQewbf9gBtb5Za44aNXGvPd2Ya/8BYncmSr75ya/B685RKs4tfxaV7Q043RpIU7MhnrzvuCFR+TeBwcLl4eUa8PP609drfhdVKbrShuAJQ/74efgz2EGi39DztKGpCdIuu4xrUaxNOzBzfFSf/hIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110718; c=relaxed/simple;
	bh=TiqbeE6FK5tIk/RJQnJ1wxvW8bDjSQKh5wvvtBQbv4g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C5jyDEmGgh+jp/OrZvCpGd2gpDnj2And1esYmDt4VDjLW6sraRrRjq+6tjAsXewimwFORCnM5T2IVjwyObl5s3RbhrjmxATMRutCghbZx3LscKk75KutTZMqc0n2rlbtu8pdOPcSgo3ELdi6vRSo4ahLRyyh32ZivqWVavMGg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679c69b46c6so7366807eaf.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 04:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110716; x=1772715516;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ahVCnuEXR3Y0gW4V9lcm+HW1q/eix0cX0sztaTxYmyk=;
        b=sFxk4irurM6MNKVdwHYjhQGk7LiUByBtvEIeCnHJny84LRIaAH7ijQTcWs+aC9QB2q
         tns+iYDmy0RQ7OiC4A9lkE3aNjFyN2xtOA7exeRUD2QlbHGmcBw7CwU6Yo11siSEJslC
         39kC5GpvmtTcAfKhPJn5PMYVlsaiiypKeKnmW0Z8YAM3tUf2H5GcEi1FV5awPxBknRvM
         pu3Owcxo+NnNDuhJ36axYzvVIVBN1oSFUOW4G8Xie5gOqiklc2w7Kwi+U0y0GwVWKFn3
         rRJ7ZLfxTtrLUW1aJiRmFammjIYaqag5w6MAWRTvVt3CbqoGyx1q9Trg+UdDqxg/v5og
         HztA==
X-Forwarded-Encrypted: i=1; AJvYcCW0QQdmMuvdhXwi4jCDaqbZo9YiWUINp2yiNkwnmWsHCGUwNgLcitGyrIpFRUPPaOFZzgikWRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrhG8U+tOAFXsK16r8a/FYnN6HWqKmoViNl6M1aAV9YNftB56p
	UT8Utfc/9UU0wsVWDBsltpr6Kn36Wb/BMljXP8NwxiDs1KXAvyNz+J59xnEQipxmU4wxJ0Gs5AQ
	SzxOmuxAkvdOCSarB1XuKvpNsegJsgpoGqIG22cSOzIfOCXSdWtt78fG2iIs=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:169e:b0:662:c0f7:bed8 with SMTP id
 006d021491bc7-679ef7fb075mr1712875eaf.12.1772110715794; Thu, 26 Feb 2026
 04:58:35 -0800 (PST)
Date: Thu, 26 Feb 2026 04:58:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a0437b.a00a0220.21906d.00e9.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Feb 2026)
From: syzbot <syzbot+listc25fa2ef6d483674daf7@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261341-lists,netdev=lfdr.de,listc25fa2ef6d483674daf7];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url]
X-Rspamd-Queue-Id: ADC021A60B9
X-Rspamd-Action: no action

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 1 new issues were detected and 2 were fixed.
In total, 15 issues are still open and 194 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4865    Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<2> 906     Yes   BUG: unable to handle kernel paging request in ip_route_output_key_hash_rcu
                  https://syzkaller.appspot.com/bug?extid=334190e097a98a1b81bb
<3> 671     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<4> 311     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<5> 47      No    WARNING in nf_hook_entry_head (2)
                  https://syzkaller.appspot.com/bug?extid=6f6a1d20567a8d6b2a58
<6> 32      Yes   KASAN: use-after-free Read in nf_hook_entry_head
                  https://syzkaller.appspot.com/bug?extid=bb9127e278fa198e110c
<7> 14      Yes   WARNING in __nf_unregister_net_hook (9)
                  https://syzkaller.appspot.com/bug?extid=78ac1e46d2966eb70fda

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

