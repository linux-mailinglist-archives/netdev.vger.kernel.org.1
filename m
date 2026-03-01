Return-Path: <netdev+bounces-262372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN9hCC7bo2kNQAUAu9opvQ
	(envelope-from <netdev+bounces-262372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 07:22:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE201CE9A8
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 07:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DFCE300F580
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 06:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713153126BF;
	Sun,  1 Mar 2026 06:22:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E62DC783
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 06:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772346153; cv=none; b=qqx6FhJxO5LwB9rZ1oyTxT56uppNEFeaHgY9r+mSchoYDeiNlOS6WGrjOGposGf3NEHT/Y3h9EeBFsrmpKxjL0svHGESEFe5XPAUL1D4A/FrTdjcYoaDGOKgW2pDJlM+W18wa4eoIxcM2kVkMqeG4qFOPPxzKlR6JaZn+h0ScOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772346153; c=relaxed/simple;
	bh=f1FiQs+aGJ//S8Y94Kii5k1eQ7Z3X8sngnQBQI91bmQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kd+TK19sJHT1mu6QRjTs8CHJJe86I3NqDTPbF3/0MSNyKYo2iAc7sNc+TVzJjMjNljnq+KNwQJhRy10GXXr5zxqAvzIrlnsyn5yLKL0MePxvNyjJFi0ByxJFVVoSg/BH6ANkrK3RI5QT1nHmI1deIK7zyEouylQzC+SPBOsG3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6798747187eso62315929eaf.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772346151; x=1772950951;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCkTIOkqY5tRrpKdFM8F2itNl2AA74quBHKheHKTgHQ=;
        b=BB3xZOkfvOAaRApf5yLR6V3wYTqbRbZpZM2MSLPvmHT2P3Sx9DMGabfFtRQXsjH3K9
         qgNmlFhS3lVwCBBPUV8/UQ1J3EYFQqsqWWiomVDDrhJ70wU2RmuV7eaWxzGdfHEprXVH
         0Slc9epVg9n6f4RyCikFl6q9VKcslodfGlUXg04bZvU2au1fyY3yybL/7x2TbGtQW0Ii
         NyEIcmMKLuxN9ZhPwLbFVk30+fTsU5UIT7oooC824SMJWe/zLwU2cDD3CbmiB7loAjTB
         aQTVjU+1NHh0toMIZFDkdIaLLKhVc7EkX/PynjbH4z4KCXezmRhAeLnfQLkNmpAXQNsc
         pPzg==
X-Forwarded-Encrypted: i=1; AJvYcCVNLKHtQkM/awNJMnFMHdc2646Dxhdfqdv/b8r8qhvUh52GnywCVTnATdBI+xaffG07Z3POVX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzakI9IMQ9qYP9LA4x4KdsyW1KJO6oCgUpl/pcODiykPpblKUXQ
	5hQFz9B3WWpPMYBzXrh05OnhMVhkVwnvXi0UazeiPbwbEAeMKnMNOIQuAdyI5NjMdkcA/IGPgBE
	K3vAaUDzGfsAakXHrQR1A7hbMKru/BM/+WEB8WgBeS0iLG2vuoHY8w29hV+I=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1b10:b0:672:a49f:128e with SMTP id
 006d021491bc7-679fadbb765mr5581714eaf.8.1772346151442; Sat, 28 Feb 2026
 22:22:31 -0800 (PST)
Date: Sat, 28 Feb 2026 22:22:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a3db27.050a0220.3a55be.0053.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Mar 2026)
From: syzbot <syzbot+list618a5750a9ad1341b093@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-262372-lists,netdev=lfdr.de,list618a5750a9ad1341b093];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email]
X-Rspamd-Queue-Id: ACE201CE9A8
X-Rspamd-Action: no action

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 4 new issues were detected and 1 were fixed.
In total, 51 issues are still open and 172 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  26998   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  10549   Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  10251   No    WARNING in kcov_remote_start (6)
                   https://syzkaller.appspot.com/bug?extid=3f51ad7ac3ae57a6fdcc
<4>  6932    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  1226    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  1043    Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<7>  864     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<8>  790     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<9>  691     Yes   WARNING in ieee80211_tx_h_rate_ctrl
                   https://syzkaller.appspot.com/bug?extid=0d516b33238bd97ee864
<10> 354     Yes   WARNING in ieee80211_tx_skb_tid
                   https://syzkaller.appspot.com/bug?extid=8bd4574e8c52c48c2595

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

