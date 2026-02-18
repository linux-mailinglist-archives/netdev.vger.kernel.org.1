Return-Path: <netdev+bounces-259310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAtCO9S8lWntUQIAu9opvQ
	(envelope-from <netdev+bounces-259310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 14:21:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53668156909
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 14:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9458301951B
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5112BEC45;
	Wed, 18 Feb 2026 13:21:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0029E114
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771420882; cv=none; b=NiZEfVZtO/lpMZ6BZ/EUyNyeTKMwJXcMx80RHAGHYYMGUxBYpILEscLsORYNHDHPFErRoxRuDdjzGLc3Bpo5MLfxO2YCdJlQLFGMRWLO0UVLuMMhg+yqMEM3/h7WdvgVBnb0pjX+AUMpXUmx72qb8hXPsrPkCEw+k0RObatSipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771420882; c=relaxed/simple;
	bh=4Dn0UKUm73Olelcz49EZhrlfjDGw9M/DcH8jEvOJiFw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KNTGkcylntGYv6kWA94NmcWVbK8kE4vjPDuLhXN8Q3Dz0y9ZMLsKMQwVqsXjdY0kkt+gHRmPsTBvUPDJXBuudh1acAhSDXW2qOYvO9YNU+no0PaxQMKCp47J/bWnbjUZnjAeIepMnJT2qdb9Xr5vPW50Yd/IjpkTSah6BcyLD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d194b631d6so58823896a34.0
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 05:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771420880; x=1772025680;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5s1PrBwjWJkBDhrHp6GlKuEWF8QNwEUz0W27JeFQmLs=;
        b=WZ+ZsDTFSTH0DrvxgGztYYKKTQu846BOyBV06X4JRx4mukQCNH800KUDfwfZaQrmbx
         aEL9gRKgNQbmHruDJpESlFZhiLGv6DZciecnr80YzLrDXSemW/A0BX8lTnVDHNfqCqHo
         r3Nq/nlKe/RM5c1N0Lat5DoRDns7spbk2qAbSo53I0ORY9U+vzjhaTAfIQcnFOOKhlrb
         dsV3TUjzLclooH9nkK+CiMZlOMwg1KZD2uvl3t4cIvAZOylmnH9xCjVpm9nvrW9Uy3Q/
         3HtM3gfzqFuLx9p+v8wdafNDqzqnYpAmwMhgzL3APY3mXuGbZO2oAtzalAD/PeuZs/Me
         1Z0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGA+1vI95QPMaTAhazobs5U1jpIOzSKI+I/5IfXafbhb5tpozCksAEjIROWPf1mhG0XA63Jo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDY0c9xYWTgRCpI/Osg2on+0gbNukr4lJA9d6Kw34oBWHzmZpf
	KcmiZ3d5QzCoy3f9zA5ul6rBbN7SjrerM/HeE2e3PEkYtF8QNvetlZlnNJiobSlU3ZYgdDrTq27
	GjjPbgcFAxSV9CjntQDwB3a+/L1u5U/Yp9XpGnYNcGu3zqaGWW2RbpeKC6Ik=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4411:b0:679:871c:b309 with SMTP id
 006d021491bc7-679a71b9ec0mr792547eaf.3.1771420879866; Wed, 18 Feb 2026
 05:21:19 -0800 (PST)
Date: Wed, 18 Feb 2026 05:21:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6995bccf.050a0220.2eeac1.0153.GAE@google.com>
Subject: [syzbot] Monthly net report (Feb 2026)
From: syzbot <syzbot+list5f277c8c913b6bc12aa1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
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
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email,syzkaller.appspot.com:url];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259310-lists,netdev=lfdr.de,list5f277c8c913b6bc12aa1];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: 53668156909
X-Rspamd-Action: no action

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 7 new issues were detected and 14 were fixed.
In total, 89 issues are still open and 1693 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8343    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<2>  3466    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<3>  2905    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<4>  2551    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<5>  2077    Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<6>  1967    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
<7>  1639    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
<8>  1055    Yes   possible deadlock in hsr_dev_xmit (2)
                   https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
<9>  977     Yes   INFO: task hung in tls_sk_proto_close
                   https://syzkaller.appspot.com/bug?extid=ca1345cca66556f3d79b
<10> 872     Yes   WARNING in nsim_fib_event_nb
                   https://syzkaller.appspot.com/bug?extid=a259a17220263c2d73fc

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

