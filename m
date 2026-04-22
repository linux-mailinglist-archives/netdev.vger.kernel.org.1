Return-Path: <netdev+bounces-280358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPVFLx6Q6GmpMQIAu9opvQ
	(envelope-from <netdev+bounces-280358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:08:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B1443C3E
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 955EF30185BA
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA22E3C2777;
	Wed, 22 Apr 2026 09:08:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D43C1969
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848918; cv=none; b=skoE1rDYbTnhIqPT5WPUuyXezv6PXhdn6Yek09UawR7kofthTeHswtxPUWK3FrQvpcu5KfRGhkE8qQIyXoQbSHyY2zufhfmz18O9b8nfG/qb4/4wBpVkJe7AGsTCTGhPG4xDwi1EUdU9gvHCRSHF6Vit9ucojLYWkyyYEMdxxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848918; c=relaxed/simple;
	bh=ci4Y0n1rv087m2Y1JSXYceDbibXT+0vtYgXS+1CRuYE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C0udLJNTUxYbQSE1WdpAHoYXTwpP/NtVP7Wv9w5dKrYGWo0etNinBxmM647JOLsSmtYHNHHphVBCulknHGvzOlGugUGSeCTPtcMH84o+4Gd29mjpcjhhkt33lGNRznopOvtxzObEtIr0qobqXcevAoWG54P5/5O5NfgjR6MA94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-42467c9547bso4484415fac.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 02:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776848916; x=1777453716;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4PjCc5VcY5hByNV5cEGk/kXKEUzMT29U0LekpTGfKs=;
        b=NY94nuuLDAOZF4/ACzPmprEY1tIsQ89Eotwpqmgd+IR+Dm5bHoVFfdUuH6COHLB93W
         2FAK0ukeRINHtdVG9dYCz7XXQARHCeBK1YgbkH+MSCFCRH0vTlwSzyJ3Ly4lk/nWqJtK
         +k8cbx7V9Hxef/gVRtv8yCncdLTnJJs7ilwTnYd3qp0pvk7au1ngs9qNW/BosqfvJqDf
         JpaEbHYa0FYDOVP2JEvwqiVUMz8SwmhXQHDoc/FpKhysmcPGwnXsiUZkWx3RuAaKNFcS
         3iFPSdDdfuwe1FOf9tiQ5WtvakN7mY4SA7Zr6nkaBahyv27wBSWSqnVv03a2BiHmA/8f
         D8LA==
X-Forwarded-Encrypted: i=1; AFNElJ85OUNiPWt9rEyPNzaPMeTejrhLlhFz+zLh6svg1Raef5g5TPwWOB/TwLQIK0Y2cZ1CPOUhd1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfu9gCbnnE46ZUsXPYkkXpUv2EF0E6oBDvKfTUXJdguW6n/xpc
	TrNrnNkXtdD29DmL1bTRcm0qUnf+ynG4RdDWlEF7MGdS2QxB5sCiHMsaCrJeU7TSzVlJEiSt0M5
	BdxFCHD3yPog9VMprdYzOU4c/AbTx4RyTHEdqVHEJja89Ecved72Mpepguwo=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2916:b0:694:9910:f77e with SMTP id
 006d021491bc7-6949910f852mr3539035eaf.4.1776848915765; Wed, 22 Apr 2026
 02:08:35 -0700 (PDT)
Date: Wed, 22 Apr 2026 02:08:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e89013.a00a0220.17a17.002b.GAE@google.com>
Subject: [syzbot] Monthly net report (Apr 2026)
From: syzbot <syzbot+listacaa5400174a98951554@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-280358-lists,netdev=lfdr.de,listacaa5400174a98951554];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,goo.gl:url]
X-Rspamd-Queue-Id: 448B1443C3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 9 new issues were detected and 5 were fixed.
In total, 94 issues are still open and 1720 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8561    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<2>  3513    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<3>  3170    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<4>  2914    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<5>  2111    Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<6>  2008    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
<7>  1675    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
<8>  1312    Yes   possible deadlock in hsr_dev_xmit (2)
                   https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
<9>  663     Yes   INFO: task hung in tun_chr_close (5)
                   https://syzkaller.appspot.com/bug?extid=b0ae8f1abf7d891e0426
<10> 632     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

