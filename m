Return-Path: <netdev+bounces-273518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MzbGPKBy2kKIgYAu9opvQ
	(envelope-from <netdev+bounces-273518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:12:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC71365DEB
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6362307BF19
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF23D9DCF;
	Tue, 31 Mar 2026 08:06:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A53D75C8
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944401; cv=none; b=uCxhYn5sYG0iM/47ETfN0Llv6Q15iV2anflzOUuUEJLBQ9FUky3p9mY+bzlp+8/QtvESmiKKUIQBpoebbGu4ew14aJeABsez9wAwjMhQF6TiuHUdbEE95eBHsDBmlzZ5neMnMGocerYSTL5HTthTvzF4LwOfosZSWNAq5nKJwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944401; c=relaxed/simple;
	bh=ZEOfx2P2tDjUoMAmpGpl9uqKVP/t0uKbYj/II9oLpto=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RLRkaVplBj9xuJ20gzvQruEIMuw3ZzWkx9dfFLLWtLc+lNtp4uVQJBVCP3l8J8uJac3WTrw1azYTQZMA5IrOn/2TsrxJK7iTjuczsYYqzvZsxuxEE6+OhH+vOjuYqT63oNcIcgZwvuoggqeuX6Nf3xTYfvvORV1xLI5i31y6TtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-41555e51e94so7117536fac.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774944392; x=1775549192;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFnKf8MiHQguXzk0RvM50fspz8lhbT4zdhO0NczJ0+4=;
        b=kRC1J4NZx5zMLnfDLr2CLtdaeNw84KO5KmJrm8WwQvNGZP0O/dU9rAlT8jbLlTGWSL
         yzu3SUtlVE3k5Gmad/dKzDq8iwsSc2J4tTdf3oTX/M6lc2ae/53cvwSGprzqfO3tqXng
         4cj9A81tgBmvZpt9BNdoIoyw+Mun1SejquLMJf+v7YzTU4uwhTFulQbDYm5mdyMFmTDv
         0MZjt2JhG8oNbq/SsvBE1e3pB49CdcU8TOykqBWT+PNEZpxAcaTl3DwphYJt5QjbJzAP
         HlSaZMl+TgEfGa0bEk1Zw7eLFmZryqNzHnahE4D119zeiCeF96G55hWWdy4Q+mTAKTI3
         U8LA==
X-Forwarded-Encrypted: i=1; AJvYcCWhDm2UNuEJyrfZ6a+dGJUVDz74DsMO+bOspJhr2k+EUTZQ0bpvhAGcuyYuBgsG/SvXCp8bZL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWeB3Gs3RwL4TlVbwI2PKnYtczvjy76VTlwOjCwlpe6ARDwO7g
	5QfAKh6+Vy6ttahcWAygMegPOF2rV0TZ3wL6G+PBs74FAK64VoOc8FUAxtzWkykfv8qtdcfPA9s
	fWVXr1puSQpq6hG7cnrVLUUGWR6PllNeH6stN2x2fZ71xv9cIPPLtV1hnjU4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2290:b0:67e:212:8254 with SMTP id
 006d021491bc7-67e1870131amr7705094eaf.46.1774944392084; Tue, 31 Mar 2026
 01:06:32 -0700 (PDT)
Date: Tue, 31 Mar 2026 01:06:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cb8088.a70a0220.128fd0.0048.GAE@google.com>
Subject: [syzbot] Monthly hams report (Mar 2026)
From: syzbot <syzbot+list434e3950c21d666d1105@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273518-lists,netdev=lfdr.de,list434e3950c21d666d1105];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,syzkaller.appspot.com:url,goo.gl:url]
X-Rspamd-Queue-Id: ADC71365DEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 1 new issues were detected and 1 were fixed.
In total, 16 issues are still open and 47 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  15241   Yes   possible deadlock in nr_rt_device_down (3)
                   https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2>  7582    Yes   possible deadlock in nr_rt_ioctl (2)
                   https://syzkaller.appspot.com/bug?extid=14afda08dc3484d5db82
<3>  3507    Yes   WARNING: ODEBUG bug in handle_softirqs
                   https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
<4>  1053    Yes   possible deadlock in nr_remove_neigh (2)
                   https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<5>  672     Yes   WARNING: ODEBUG bug in __run_timers (3)
                   https://syzkaller.appspot.com/bug?extid=7287222a6d88bdb559a7
<6>  169     Yes   possible deadlock in nr_del_node (2)
                   https://syzkaller.appspot.com/bug?extid=6eb7834837cf6a8db75b
<7>  25      Yes   WARNING: refcount bug in ax25_setsockopt
                   https://syzkaller.appspot.com/bug?extid=0ee4da32f91ae2a3f015
<8>  24      Yes   KASAN: slab-use-after-free Read in nr_rt_ioctl
                   https://syzkaller.appspot.com/bug?extid=df52f4216bf7b4d768e7
<9>  16      No    KASAN: slab-use-after-free Read in rose_t0timer_expiry
                   https://syzkaller.appspot.com/bug?extid=44cccec2c6a4501f6a45
<10> 12      Yes   KASAN: slab-use-after-free Read in ax25_find_cb
                   https://syzkaller.appspot.com/bug?extid=caa052a0958a9146870d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

