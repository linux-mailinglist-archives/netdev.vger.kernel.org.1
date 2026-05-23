Return-Path: <netdev+bounces-291102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLtdCnSeEWr1oAYAu9opvQ
	(envelope-from <netdev+bounces-291102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:32:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5DC5BEE5A
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC264301410F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB798399007;
	Sat, 23 May 2026 12:32:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2D5397B06
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779539565; cv=none; b=rl0yg9FT+bgeA+yLcGAdqu5pQ2LaZNsRU4dLPPbzGCCvPG/dRZY+4u/3Ct4A9V2xVlVglCvOwSgFMzTcbenXqRlk2zafPGS2kNU48HrEOIjwzY9phQJIBPZaQMfnN3LYnOW+wz54f4fGhsNbP9V1Jsyo4W+USbc7SQxjJeLC4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779539565; c=relaxed/simple;
	bh=2iMZfBIn5nycdxjdPo0gENzsy2SA4k+QTrMiEs94Li4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tGX75pYl9+iJOQ52PCAll3K1HmUeRafQRB+4cJouRi4LL5conoA4BdTU2/1WOcAMpbNZ5CrvdEy/6uATHXKc0GiTrKsTYhXpO5pVvvjFuegxHa2T8KuVlEGyw/Cabyivko0VZWJF1PgM/hkasIjdnGGC1y+rq8XVaJODMMEXi3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dce1e67fccso13204158a34.2
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779539564; x=1780144364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjN/8bUJHs0WxGi/8da/u/0LPkmLERNRTOj5hPC2Y1I=;
        b=Ki8lfkGGn8iXfBP+HPDQqKp5dz8yBb8khFl0tnYDzQ+j+lPFcRv/Rt9B4w+r5+k9cH
         Q8FLJPwx+uDzNO0GJwHB5C2aKpXkHtxkpsTIGxjCj7vm2yrRY5IlB0IIISQiya+hT31A
         vehSzGuL0e1/m0Gmyg/zmMH1DEH2XWCsaS5b7EiXEIKG1RPN79YUtReo/wULgZoQBM3I
         iyekRZHSP6mSJPFbF+6F2knWTvFkJhneB0QRRnuKofCrC20AlTyhaUkeUdG/bO9fXCuW
         +WOpHr+FFXK2Axnf7nhxnK+F7x5mdkOp1wcogVpDhpa2NRvVODGoIa32yh0ozCJWw7Bs
         pcjw==
X-Forwarded-Encrypted: i=1; AFNElJ/1NoLmrvHGFNeMMnVcc8MqKRI7Yd6L76StsxEC5qxarzMB/LSbB7bUJdbp0k26NFO6JjLOmVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrNxBITTZpJJD/GRvOO3yX+TYTmbqUsNVTziCjOOYc6sEd33q
	ebA6/2BS3ppteU5LvskEeSBubyGez/yUsUDLP+QDoWECYRZSEIYFE19heR3gCp0OWYdNAiX+xYF
	O6IZ7JklmD8W7B3/ABnK0PJRgPvAbkMJZ7vUMXqrQDsy0ArYKPoQbK4xiUF0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:222a:b0:69b:5696:e63f with SMTP id
 006d021491bc7-69d7ebbfcb2mr3321397eaf.24.1779539563773; Sat, 23 May 2026
 05:32:43 -0700 (PDT)
Date: Sat, 23 May 2026 05:32:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a119e6b.170a0220.35b2b7.000c.GAE@google.com>
Subject: [syzbot] Monthly net report (May 2026)
From: syzbot <syzbot+list4c894a328683bccef30a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
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
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-291102-lists,netdev=lfdr.de,list4c894a328683bccef30a];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlegroups.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 6A5DC5BEE5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 8 new issues were detected and 9 were fixed.
In total, 76 issues are still open and 1731 have already been fixed.
There are also 17 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8628    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<2>  440     Yes   INFO: task hung in nsim_destroy (4)
                   https://syzkaller.appspot.com/bug?extid=8141dcbd23a8f857798a
<3>  341     No    possible deadlock in __ipv6_dev_mc_inc
                   https://syzkaller.appspot.com/bug?extid=afbcf622635e98bf40d2
<4>  228     Yes   WARNING in inet_sock_destruct (6)
                   https://syzkaller.appspot.com/bug?extid=5b3b7e51dda1be027b7a
<5>  21      Yes   INFO: rcu detected stall in rescuer_thread (2)
                   https://syzkaller.appspot.com/bug?extid=d5f7a5097c24c7c2dbbb
<6>  4       Yes   WARNING in virtio_transport_send_pkt_info (2)
                   https://syzkaller.appspot.com/bug?extid=28e5f3d207b14bae122a
<7>  2       Yes   memory leak in __vsock_create (2)
                   https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
<8>  2926    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<9>  2062    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
<10> 1704    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

