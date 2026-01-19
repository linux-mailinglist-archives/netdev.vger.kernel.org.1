Return-Path: <netdev+bounces-251000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E67ECD3A175
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 778FB313E9D7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C05C33B96B;
	Mon, 19 Jan 2026 08:19:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D69332EB9
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810767; cv=none; b=uoQ2JvCKvAOk6mw8xmQ7mvBZmJyG0mw++qELVEPqxb9vwFx/2K8R0ShbKZFfmu/lzpNoE0a/DPcB16MlZnFj0t9uga2GR3gC7A2PUwLWtn0rSreeQexUeFboSC9t2TzRElreQfzsx8QRdGl4wcJK9f68t8TP/9W4aHu7vW0wDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810767; c=relaxed/simple;
	bh=Jb3FKv07DCzw86c6lQOtvV9wn5Qbc0cIexkfIx/2GCQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ac63Bp3a4q/jZO5Rq3QH7UXrNjBeq6WQtiR1/5oJFeEv86yRCxufltDIO92otFNCm6g1kYo5Re71N7mJL6W16MwD3t47WnC4Zlj1XIGQG40mNRxrY1tum5rP2OlQOG0y7XnNpOw5S8fOrfJEJ5yJ1ijYy5Bz2pcmlYcsLukCmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7cfd3cbaeedso7636661a34.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 00:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768810765; x=1769415565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ni2tG3D0/GMousFMArbvuVSn5vpRnsJtfyimarHsdLU=;
        b=gK7b+14XKoiQBjCbVW2C8WhPZjSUfzt46Mlt1EqNr7rHMI3Rc80NjISpbKMWVfW4WM
         VckP5spbcNAfjUMdTYCItfsUxwRI0b7vUDCH+KO+jJLSOlMcqa7AmnL55oGtDZxiMVJO
         CpymMwemfQeUXruEAIOCRBVgtlsfaq3QaiW2plkHvoEAdSzDP4YRplgLaq6m7gjQosPR
         rQx0PdN6yD2PSjgoZZrSpm/a72B5v4U2y3jMeox3p9BDjI8urnq2qpnQLjHlRLKUCmNY
         NAKAEezMMygjpRGPQTTtqtf3aKBGLsMJoQWFJZYofNHv3ZIYx1FgRzfLrnxA9pFVC87w
         H/rA==
X-Forwarded-Encrypted: i=1; AJvYcCXSszegfhs6qgHrn2hEH5a9AXfS6lnAQl3zSoOrbn7edBoR0jt8YfcG+wkfn4Latsky/p4LO5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjcFhYY0wCaVwvA5hec7GnvzgrgQ328XvYp449Jg+FK+uAKXAO
	PZtsh+5HTg1thxDzrkiFvRsuJ2aNO/uLh8onGdq2+Hmi3du+p/ytPEoHiM+Kl273a9aEd0NuQc5
	vVOCfaFIgNuUxWL2WceHnBmNZAVa9i38Xot4Kk+W7H5F1wyabckmq7MPzHVg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:997:b0:65f:5c88:67a8 with SMTP id
 006d021491bc7-66117a3a2dbmr3962051eaf.74.1768810764914; Mon, 19 Jan 2026
 00:19:24 -0800 (PST)
Date: Mon, 19 Jan 2026 00:19:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696de90c.a70a0220.34546f.0435.GAE@google.com>
Subject: [syzbot] Monthly bridge report (Jan 2026)
From: syzbot <syzbot+list1e4b7a4bd5a6b9f5fd40@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, idosch@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bridge maintainers/developers,

This is a 31-day syzbot report for the bridge subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bridge

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 39 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 52      Yes   INFO: rcu detected stall in br_handle_frame (6)
                  https://syzkaller.appspot.com/bug?extid=f8850bc3986562f79619
<2> 5       No    KMSAN: uninit-value in netif_skb_features (4)
                  https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
<3> 1       No    WARNING in br_nf_local_in (2)
                  https://syzkaller.appspot.com/bug?extid=9c5dd93a81a3f39325c2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

