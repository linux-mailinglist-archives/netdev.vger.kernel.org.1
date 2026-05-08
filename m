Return-Path: <netdev+bounces-285968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B5kHl9I/mkrowAAu9opvQ
	(envelope-from <netdev+bounces-285968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:32:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 833694FB82A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B82DE301073E
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 20:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D657E37B00F;
	Fri,  8 May 2026 20:32:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7430B3451CC
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272344; cv=none; b=IGoxkjggwTjF95B1UFAcAi9IqRWBclFJC0qdLtKlpKm0F7xib5Glfb68oBdqyYFNB/XzxzWCMEy2K08R9EJzwu8NmdjGoKuEqLH6Ri6uvQX3ROt4elQawT8cph63OC6ZlJBYizH/ZJ0ECZE2MTD1EPaIoJIcF5Md2CbcmxYlLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272344; c=relaxed/simple;
	bh=GWGjr37DgmOItQTJe0m6xQN4vFJPRIPcML91E8GPXL4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a5w9F8j+Evywq0zZBeT8wj7blbCDgspFMfaZKxa8FwM9eOVPnLr5XLVy+vQUAi/6lxiME3AqxoBbyFEyBaj1CbeAoK+8P5adfzou9UtbgIqnYwTEfxmvN+Tx54jzy4mZGnXGGj4Km7Qk/45vtJcLYRRkrJPH4z34RfSOlUWcIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-42c0b246c18so2649644fac.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 13:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778272342; x=1778877142;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Miwg42UgQH85cv2eBhd+OoEV5K7I6N9DVajlWc2+OPs=;
        b=hX//xWer50W7VlSBXdL2b3qlseTzaoQEENERdNXK9V+h9m/s9q2Qvq1wM2hr3SdvXK
         1TCkMHhaotu+71VMilrJ43G2j0HYvbdiee1oOU5e0SEPErm8hCK5DgWVxUJ52pyG3WGu
         ErlHwoX8s01HpIs/aYwpnrmKy21KvCk51pcBtNlJ92nioiXxjj7gQ9uR6ELw8swCyPAg
         5T3th00rTjA9bDB5tC4rJgSpOieB19JK9ZlTWnmIz9zhEpNaiaubU3x9rbVYh4Vuywxo
         D6Qq9kNEEYjYY1nuGY5jgsiOEFFJ0qDhzLTjl/Mqt7xFlCeQUqGNbjbX7qMx+UUBNUrh
         IEmg==
X-Forwarded-Encrypted: i=1; AFNElJ/q6D4/G7r8ZdlMJbN+1eSq8pIfEYSYndkbisg9jmZDCZ7oGlpjJBX8wRK0bD31SvRtqdsL4yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+OmLzGehDy19J0jVFG241trFOghWbW9ws3oLft3/thMSiz/x
	8Uh7LBFA1YLETnwjewCc9XbTfO8U+UIIetcAWAwYFeXZg1A+jZTa6AwftXfNNiPg3ix8cuiZF2e
	qrGGoA/FLANxfn5c3JIOopQiDZZQOFw+OyPKUfxnIK+9hoF71vyObg/2ypcg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1893:b0:694:9bdb:596b with SMTP id
 006d021491bc7-69998cbcb26mr7653901eaf.17.1778272342443; Fri, 08 May 2026
 13:32:22 -0700 (PDT)
Date: Fri, 08 May 2026 13:32:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69fe4856.050a0220.1036b8.0000.GAE@google.com>
Subject: [syzbot] Monthly bridge report (May 2026)
From: syzbot <syzbot+list124a596351a8114b500f@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, idosch@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 833694FB82A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285968-lists,netdev=lfdr.de,list124a596351a8114b500f];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello bridge maintainers/developers,

This is a 31-day syzbot report for the bridge subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bridge

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 42 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 70      Yes   INFO: rcu detected stall in br_handle_frame (6)
                  https://syzkaller.appspot.com/bug?extid=f8850bc3986562f79619
<2> 28      No    KASAN: use-after-free Read in qdisc_pkt_len_segs_init
                  https://syzkaller.appspot.com/bug?extid=83181a31faf9455499c5
<3> 8       Yes   WARNING in nf_ct_bridge_post
                  https://syzkaller.appspot.com/bug?extid=a8ba738fe2db6b4bb27f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

