Return-Path: <netdev+bounces-258862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJF4NUMDk2nF0wEAu9opvQ
	(envelope-from <netdev+bounces-258862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 12:45:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C6143160
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 12:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B964A3006163
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3E530276A;
	Mon, 16 Feb 2026 11:45:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24852FFFA3
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242304; cv=none; b=HbDD5E/t1x/ALMEVJx6Yxl2E4csx25CzbsmiPOZ1TIM9L7kHKcW/tEomlzY28YiWyTsM913tU2nwLRFCOIJBeiOsTEDNA6m+zXpX0Z4JcxklJi+eTHSMU0yzfuocA4RDv4dkjLrEm77Ai62HBZzQhaSAfrgQI6MfVqhgRy6IiUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242304; c=relaxed/simple;
	bh=DyZ6LMk57bxYJee4R91AcONEWqjgrW4erYBKdeRzSKo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SjYcuSvCERLK8n3g4MesZ/JUxmom08jdb33KE9Ay82HtpPZ/mpMRr+PFjE0XHzpVE5Ooq7Nx8fe094gafMY0MJdyrufgvh+nM17jDOvCTxRXS6OvcWgFUeqmdJ1gLzxmAaAxKL40+CS2eEZhezQtDkJmcueuWFHbVY65xqY1LWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-663019e3e05so10694287eaf.3
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 03:45:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771242303; x=1771847103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Kt05WshqleUgRxisl8SwriN4Sg1SnjRJ5kERyays7Q=;
        b=lTWunsZZrMMotzutS167UJ6HvSnSHywVMD0tb5df+5GRPwOCJHAjgwAAwbbrGdyvWg
         R3dxRGOKx3RQy60vTt43hDSOWG1SPudZ+Qk47oyqArj9by83LeDknWX6zq9XK0gsISKW
         OfZkiOvE4l5tORfLXo/LmBWHJtx5aXCZsk3z8zlVzw8fTF0GPeOZJcOtrN9NFKEJYElI
         1kDhfwQjIo+7PIlswTPtXDFFd6l+DzkeXkZ1xWqJ3UFXSlM7K+AbjsjT5gqkCST+91eF
         zCG4lnIfvyVDCKCrhfVTqydsZ0bOTeTNacLc0SWqlLKzcRneUNFnmnZXqlxPmyeXtCD4
         dEEw==
X-Forwarded-Encrypted: i=1; AJvYcCVXmxudPCZE32BZtO418IdE+MuW4w/ZhuudihDDJlu3oeHs/vw6OC1bTbGuK5V68vUpg76QN3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUyx2gp/Vuu6ieOtTWbQ8F1qJqpmQ5y/2CydORszS2d1Y5Bpa
	UhZ6TtJjIkuoE5BzsI9RsmC8MSdoiHrvZuEu0hPqJHV8w2XhR/ZkD/KwggjbTD5V1EiwZvfRdo2
	MTS/BgF+MMpphdfKsB/658jibLx3xWnxzOa3buCH5R1mhRZepS1bji6zTD+o=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ac7:b0:673:ed80:c7aa with SMTP id
 006d021491bc7-67855ebb082mr4254197eaf.0.1771242302919; Mon, 16 Feb 2026
 03:45:02 -0800 (PST)
Date: Mon, 16 Feb 2026 03:45:02 -0800
In-Reply-To: <ae86f151-0480-45f2-870e-7378e1607058@suse.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6993033e.a70a0220.2c38d7.00eb.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in inet6_getname
From: syzbot <syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	fmancera@suse.de, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258862-lists,netdev=lfdr.de,5efae91f60932839f0a5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 7D0C6143160
X-Rspamd-Action: no action

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/rds/tcp_listen.c
Hunk #1 FAILED at 59.
1 out of 1 hunk FAILED



Tested on:

commit:         37a93dd5 Merge tag 'net-next-7.0' of git://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c36acc86fd56a9d
dashboard link: https://syzkaller.appspot.com/bug?extid=5efae91f60932839f0a5
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14aef15a580000


