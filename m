Return-Path: <netdev+bounces-294406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id InBPMf0/H2qdjAAAu9opvQ
	(envelope-from <netdev+bounces-294406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:41:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60181631D2D
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:41:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294406-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294406-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E01330A714B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6833C37BE7C;
	Tue,  2 Jun 2026 20:32:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7107322C6D
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:32:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432350; cv=none; b=cVcMQclFPAdAfaofQP5MqoZhev335Gw4AEYgqU48VpacIYUz3vXmSVFi5b+/PXDNwYhMsskRg4z60JcW8uqvu6Ka8A5Cnclb9TQ0loUgDt0N+/dSLZsUu1QXn8qK504pCPhxFccMd98BKyS/19RZyiwcX+M4MFpVyJwG6DZG15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432350; c=relaxed/simple;
	bh=D451K68YXi0VVvO2lWp+kSDvSLOugmI2bwM3iQUmO3w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pu9J2yjo5TsizFT3xwbC2fSGXlxo8GNwIPnjvdexhrQ/Ysmb/YyHO9VIg+6IFxRYfTJYtWbns/RkSfP3WaMxsT/9aBi9CUsGSPfA31zIUljUXju66v5hbgpw24vdzTtxGKAdm74UTyknNZqaLnl7lsbLlesYxY4Pbcu4jUWY/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6cb279950so3572170a34.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 13:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780432348; x=1781037148;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YL5nMlPraDN24Z7ecvcmfheTXvHmW6igzkP+gzLkuKc=;
        b=bQqGozdScuRBFMFBYvu/VWjS5bx9SVFIk0/kuFFoKbWRLKEikiR5hbX5OOoaMXP9vW
         DCLiWOJ7L1MzShr7GQWQvry0keRxtIr+vU3320bXNcXY6nL838B2mRNz1rv431o32zLQ
         Q/wCcAZ3/5Iv3svvPKKRh7ZHGQwNcpcFmYMXHrBpC2K3hqE629rtXjjcsy0QEdubvlrE
         zHnRA3rYWGjqH738h7zpqn0F0Rh9GnrVALx6p66ncwKh59a5X46ocxD01gA8jioKlb3m
         5Ge9PR0VzT/3xppGtzZh55Z26W2cyJG74UsvMWB2gaaj3vkMCpaTTGg714G6N/ocvCq1
         X1JQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Vtfak6Y1s7cuHihsAljj+oNh8gqQSmaHMk/J3TN4Ht4uFkOhPNs+j3N6lvjugu21tSxmPUPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbuGkdDE+kLRujAfPjQ4ycNC9r8Seni66g6nnifDghd+SBycnY
	gRFDkRPpHN4o6FlDAFe8n5CdKEfwg6jvJaB4OmqoZihBU/+sCyJhIzWVrANyloDBkS57aVXXdS8
	izW04Kd6SgwT9JZTmIpKA7+pySL0OCSWgwTtx7MINnSxTmjL/xLfeNG1B0SE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4d87:b0:69e:35a5:136e with SMTP id
 006d021491bc7-69e47ecb87cmr326459eaf.24.1780432347870; Tue, 02 Jun 2026
 13:32:27 -0700 (PDT)
Date: Tue, 02 Jun 2026 13:32:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1f3ddb.7b89b7e1.205e57.000b.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Jun 2026)
From: syzbot <syzbot+list14f4c43fd705908896b8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294406-lists,netdev=lfdr.de,list14f4c43fd705908896b8];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspotmail.com:from_mime,vger.kernel.org:from_smtp,googlegroups.com:email,goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60181631D2D

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 1 new issues were detected and 1 were fixed.
In total, 31 issues are still open and 176 have already been fixed.
There are also 17 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6959    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<2>  1127    Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<3>  628     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<4>  316     Yes   INFO: task hung in ath9k_hif_usb_firmware_cb (3)
                   https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640
<5>  48      No    WARNING in cfg80211_switch_netns
                   https://syzkaller.appspot.com/bug?extid=3515319a302224e081b4
<6>  39      Yes   WARNING: ODEBUG bug in ieee80211_led_exit (2)
                   https://syzkaller.appspot.com/bug?extid=e84ecca6d1fa09a9b3d9
<7>  38      Yes   KASAN: stack-out-of-bounds Write in carl9170_handle_command_response
                   https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
<8>  34      Yes   INFO: task hung in nl80211_pre_doit (3)
                   https://syzkaller.appspot.com/bug?extid=da14e8c0ada830335981
<9>  19      Yes   WARNING in __cfg80211_bss_update (2)
                   https://syzkaller.appspot.com/bug?extid=1a797e1c81be78a2ace7
<10> 954     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

