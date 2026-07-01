Return-Path: <netdev+bounces-303630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yxUSE9QSRWr56QoAu9opvQ
	(envelope-from <netdev+bounces-303630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:15:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 947AC6EDEEB
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 15:14:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303630-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303630-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B3B33239BEE
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFDB4BC011;
	Wed,  1 Jul 2026 12:32:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B584B8DEB
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 12:32:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909147; cv=none; b=gMvW+h6EiC2Q33/6k6BBwuuAjcPS6SxAZ35x5VqQAm6fFNHjusu2X3q69qAgNi0ucMmHG+5xWlPctOV7u+Tv70dOGZ2oyAYCRRcUkfGtnUKX04+CTu6sYZdSgWnTAnZJnF/qKN4RxZdcTWZc5AV0kwKKZjkz5s2YCvfH4dTvWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909147; c=relaxed/simple;
	bh=C8ae2Wn3IRIgHe995KPxuL6o13/FdExud3bMgQz6wD4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mE/BEhvNJeMySVBxpv/vv2SfXOAv9BHhqAuWTkaJMwp3CHRKuDw/6KXaCd3orBKHOFIjx2Is2XaUAAoQACAMk/qOSQCkbsyu2a+PlhIE5SRTf02o8/5lYKQzwlPZCrmXvDj9IJ+MBdpcpOaAh8x2KlgXrc0+h3VWT5BcDlXml6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6a180a73049so647046eaf.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 05:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782909144; x=1783513944;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=me+E3q06UL+WArmFrq+65FdWO4Z3IexCPtt0ELwjlkE=;
        b=LvarieJ3lhY8DhPQTtxSXkBcgRAXRG91AXBqV2CtH4S/hWV6Wdk+z6RUSM3xHrDHxb
         Ym+LH4nSCAHP6VaPGE1xsi8+UrNuWj9pai3WL9X1mUQFauikZ2HhCPcPlcForv3e/VY6
         RkgNFnRs7c+MnasWui3S3TiEwZD6kvZVRf6rqxsJDTLMDIs3+hEPlapaeN59xBzuJXby
         LdRstlHpEn+aU5z8vcXMLR97VclVI/0w2nFAyLBSyWRY7tRf6eBByKl6szpKzPStxQQZ
         7vtJu0TBXI46zfzAA+cHKCHtqeiuxG84DfXP4lqyuDtz4b5FU70uB5s5ShGdqOgYAtFG
         Nh5A==
X-Forwarded-Encrypted: i=1; AFNElJ+CyzbSkZITrZtDo4Dya/tdX+brOg0Qgl/9ZVdhltEqFaQ6AhrUJXsE0yjtbgboofNvChOZTIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiVx8xqyiUsatucn9JTbRgKaqjuW16VuRNsYYhHt77umpmjvkW
	wYP/+9lDGYNxywGLlTEJoREXT+gElN23LM5svFUAbicu//iX+YB9dc62ExOu3tTtla04dxImG1c
	APcQSZh20FC8cv8HRbLenWgb8eZq95ATPDlrGIfiZxHwBhZ9v/FP719AIcfc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c8e:b0:6a1:9a59:5c5f with SMTP id
 006d021491bc7-6a309b372b9mr715415eaf.46.1782909144391; Wed, 01 Jul 2026
 05:32:24 -0700 (PDT)
Date: Wed, 01 Jul 2026 05:32:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a4508d8.52c20a74.1f8b39.0002.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Jul 2026)
From: syzbot <syzbot+list936a506377afb7f1a7a7@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303630-lists,netdev=lfdr.de,list936a506377afb7f1a7a7];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,googlegroups.com:email,syzkaller.appspotmail.com:from_mime,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 947AC6EDEEB

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 198 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1759    Yes   INFO: task hung in addrconf_dad_work (5)
                  https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
<2> 703     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<3> 137     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<4> 124     Yes   INFO: rcu detected stall in br_handle_frame (6)
                  https://syzkaller.appspot.com/bug?extid=f8850bc3986562f79619
<5> 78      No    INFO: task hung in nfnetlink_rcv_msg (5)
                  https://syzkaller.appspot.com/bug?extid=c4b20b80ee6a7a2f5012
<6> 2       No    WARNING in nf_conntrack_cleanup_net_list (2)
                  https://syzkaller.appspot.com/bug?extid=122256c3e2bf6ec9f928

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

