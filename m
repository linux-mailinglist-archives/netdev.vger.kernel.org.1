Return-Path: <netdev+bounces-276157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJUqJlhq1Wm96AcAu9opvQ
	(envelope-from <netdev+bounces-276157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:34:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF2D3B48FC
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08AA63025167
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 20:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26163379EC8;
	Tue,  7 Apr 2026 20:34:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D8379987
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594063; cv=none; b=R6aBsUh0AwT01L5SGwEF1ik3YA1C5Y828GQqFV7S9E7lIutfXIFA1oJjTqMzcJVTa7dPDxC8NxM+86GpScjVLa637wQrhZ8+xaaPAI11oKcd5l66jfbYhUJxVkM2CFIX2cB99fP+6jNBJE5RSPO1fsBAitaoFy7Qe9X6Dp0DA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594063; c=relaxed/simple;
	bh=6Bo5O4wjOvfespRG69h38xEuBe2KDMojnp31XXMMUjc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MSA1mAw0OFT1aTplXauhoVNJhO+F0K8FcyJgn5AL1/g3e3Kc98cVQBn/l682teMduZ/wpbgWiyT82Ee9Ah1KZoeARFBS9M3pRDMaDBSiS9BMUhi+o6VdwtOmiqfk0FH0kMHpoG0+YFSEh3NRo21Esf8fc/nw4PjQg0EFgPETTbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-68721a878d7so5261393eaf.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 13:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775594061; x=1776198861;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqhH+wOtUGFzN3Xk5wQwyxXo/QUBD7oxMNbXKdmBYh8=;
        b=EF8PJg7aC1/Im/PIZCDSh8/ocFVIBTGLBxgjUO0vwgvnZHFlBiMYI149XEvBwEE7Zs
         nRMB5/DQ6DyJgr7yMd8Ouz6JrURt6a17Mr9nSBVmeEsNmj6gN+lWVj1WtCrS/N48GiqG
         /mcvcgOGbNAN7QYqz1mTnDpTtYXoSyQJZ8up/LwJmoJ3oyG4qYoDSFdgCa7tzzVSPBdm
         UgQkZ0qp5N3+Ty2qENfJTcier/sSUZyRH5Llqk8IlEwXjKDhc2SuBTd3Nti8ST/kysOH
         a79S7px0+2QNuS3P7h3mK2PzzscllAWrlQ9sVPfVIViTiv86vGM8NTtHtzH7TuI0wMzn
         rYcA==
X-Forwarded-Encrypted: i=1; AJvYcCXllgCt63J9i83krkrBs67aMvxxYBLyfFpsxgwyJndmDBoUcNvqY45nxcN8aHXGTi+bMY8Iq3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG7l9O8LTOTHaQk6wVCCtul/owesBT7OOC5/hr/QjbFTeC4Uo7
	6u/YpfLP9v6eTZO5Atro0lT+D5x14671rcpQgfChsCTSFeE/GCzNuVsEoNzPLd8p7gbOEm1A7cJ
	xK+1K2Q33zJRcEgZPf3Z1z15WFcG4qehmZmVpt4o9IaWHnSAm1aNmxPHTIf8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:160b:b0:685:ad2:60a0 with SMTP id
 006d021491bc7-6850ad262bcmr5899602eaf.50.1775594060831; Tue, 07 Apr 2026
 13:34:20 -0700 (PDT)
Date: Tue, 07 Apr 2026 13:34:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d56a4c.050a0220.3030df.0003.GAE@google.com>
Subject: [syzbot] Monthly bridge report (Apr 2026)
From: syzbot <syzbot+list9bd0d81129c98c197ee0@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, idosch@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276157-lists,netdev=lfdr.de,list9bd0d81129c98c197ee0];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 1DF2D3B48FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello bridge maintainers/developers,

This is a 31-day syzbot report for the bridge subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bridge

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 42 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 59      Yes   possible deadlock in br_multicast_rcv (3)
                  https://syzkaller.appspot.com/bug?extid=d7b7f1412c02134efa6d
<2> 6       Yes   WARNING in nf_ct_bridge_post
                  https://syzkaller.appspot.com/bug?extid=a8ba738fe2db6b4bb27f
<3> 2       Yes   INFO: task hung in br_ioctl_stub (2)
                  https://syzkaller.appspot.com/bug?extid=6bdeba54c73aa6a6219d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

