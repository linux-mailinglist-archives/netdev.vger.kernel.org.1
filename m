Return-Path: <netdev+bounces-282484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDB9FWlr8mkMrAEAu9opvQ
	(envelope-from <netdev+bounces-282484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:34:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7FA49A2D5
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A3230B9E88
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5D539BFFA;
	Wed, 29 Apr 2026 20:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94033346A1C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494760; cv=none; b=JW/DP4b2Pjl/XduES0+gAmtZSx7DbpoYpGn1r4h/a1ZKks929YWG/ymtlSeQNv/pz2GvixgjAPCrPfghVRNQPzFKdKG0DeqwRCqmhcSA+SV6BGXARE8Gn4mB7K8PjzA0Oub0SIk0YpjPWh2ALjO+NyFzgDkwalEXDwBQuCSpbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494760; c=relaxed/simple;
	bh=xiRXsiO3W/9uU8aPNFezc3qHFbf+yUCJnyeh4Fk9QcQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=igmp10ZNNE4BgTGl4zmDhyIj7oqTyHZQyeyG3bnzaQFfMkIir6O+/eg0wY4iPOVfLSmhDXbxn7AiYwF/jZm8QPRkyam58lPNziyZj7NXA6SP46pdWV48VGDeXeF0Fd0F2Dz90EdztywKRQCLTigo3A83aqT4sGMKUTx9Pgn6B90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-696307c7ee0so371489eaf.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777494757; x=1778099557;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJOViW9ZqXgJfTCarUw22NKpcmj3qAVWjjSA+y5d1Jw=;
        b=XMcIrsHiRg2h29E3/dCpsJ+7Vfjzy8sfq9/fDLBs3UGTJkJRO/coWVWRW9s098a6zA
         Cyq83gL54Y9FHr6iP2rOLH/EZ04EXpvqdjkICrF7DBMpJTBpzlXROylVl+wE+pjETA6b
         VG8h+VlPNv95qmwiEU9qdqZBfl+zpRtQFeQ1K7l7K1FyznGVrE0HHRAbEcO+ZlF7Fh7f
         FSsxagDfnYBzZ793N3uIao3NdPttVlYz9UhB3FJdAjJOkJ+zSwipJ3caXJdDy5uNL5O9
         6jcrY4VMSI1Jp+jxUsg55sLnIuyTDNYELUVH9hCnfkAJfhV2E5BUhb6ttKgrJTmDbMNX
         +L5w==
X-Forwarded-Encrypted: i=1; AFNElJ+ThlxMa9zlZEVioHCEQx4MAzAYVGbA9ySVzN7rmzwdeDHumIXqJ4IJeP2O610xFlYSzKwb2ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWTuZhnxujVx1h0plB7/qvZsamGBSwHVhSHR5gEk/3A/NzLpf
	3YdTZd8H9LO38NwQ8kQ9V4HjdvhwbtbM7pUFzHWx80Fsw1YXmbaFbY55QRuqnSb4Ngi4FCqxtjV
	LBWn6gHxUloD0Gx6M+K7tPAfgMa9a3VmP0WQZXTYGHJwAPxWtvcZso2qTEes=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a8:b0:694:8683:3860 with SMTP id
 006d021491bc7-6967a625551mr83622eaf.48.1777494757575; Wed, 29 Apr 2026
 13:32:37 -0700 (PDT)
Date: Wed, 29 Apr 2026 13:32:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f26ae5.170a0220.3c4978.000b.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Apr 2026)
From: syzbot <syzbot+list6f39c4e3ba0bb706b158@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9F7FA49A2D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,bootlin.com,datenfreihafen.org,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-282484-lists,netdev=lfdr.de,list6f39c4e3ba0bb706b158];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.625];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 460     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 366     Yes   WARNING in lowpan_xmit (2)
                  https://syzkaller.appspot.com/bug?extid=5b74e0e96f12e3728ec8
<3> 55      Yes   WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

