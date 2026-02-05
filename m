Return-Path: <netdev+bounces-257046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOO2LyBVhGkx2gMAu9opvQ
	(envelope-from <netdev+bounces-257046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:30:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A30CEEFE5B
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 348FE300D146
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7C3624AE;
	Thu,  5 Feb 2026 08:30:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793ED31A7FB
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280203; cv=none; b=crybahRjPaDX0O/lO81Xfka4IyUmrrQhk6FaqKA+Cyat0JRpLSiAtYhQQF3/NCTDgneMegfqQ0kSKkdXXwXF6VOgyWDH2V9kIEPoO7VUCAVsKottrtVmFpFzEVdyjzWq8V+gZbH4Xq+qw3WRwS6TApVZI8rLV0o0YNF7Z5zPIlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280203; c=relaxed/simple;
	bh=uMswa8QgyTDD4PSRzJyW7FHr5n7JVIst00rKkccJkbA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DjTJt2h9pcivB1UsoMRzQpvgInpHyCmoU/6j1jL9CZHbcg0Ycqz6Yf5mgODbU7Bb7dfDv9mbQ9cIlG09xgAkaRqRb8u7ByFP2Mc26KXcalHYMjX4GyTJJ0eRFLT8i/V8v4HNYatAsBEDtotj0FvRuR1Bg9sN1HfwnhC4G+XswcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-3ff59bab16aso3151594fac.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 00:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770280202; x=1770885002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llRsHVUGZUWzlNHdbad61AK1n7j7FSs2B3eJju6Uw+Q=;
        b=UdsHC6K8wp/O4pevUKL9MLIUTUD41wWBtBVF6SztTlxrCcyY7auGsuY7Lmy1pWcYU+
         eijkpemR73rXsPIUWIlIFNMWq0vev2DNndA2xRifkQQ2lnt17Up+3sXNEl27J2RZ3Bg1
         ZZv3YbnSg6uvC1SA39l5mBUNYSTYNCA7ce6zmrrZBPGeNfQAqjZ48RYu3KGvhEErgJJe
         ezpnFhzHw0KNqu1L0B+mE9VhoHQTkC4s6CNIBd+nlNL1gjV9ZRmQ/RAFM3plnwhLNRbT
         aEgld1AEsU3GFBlJfC8qAG5OODvGlk5wXJilyouWnFnWqiIXYA4w8fVL47pR7BR/Qvjp
         ox8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWm2iOy+/QKq2afa+O6/2DLBzZQ+m5+Dvo83zusX8G92DiPxQK22utjqyC6pVYsUjhlhEtqg18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMwAPEoDmy+9ToDlzTtKBDPCDdGaD6apJTCFTp4UPA7PwP1Hrg
	6eDl8fiKf4C9NfXQSKFQLwc/4YszMwT2cec3uoSzckc4gTYtYUzntWHg4xkcNQRAfrIbufriNNI
	rtKCcn0dFKlm94lCW7FkMoFKBGn4+LYc+jb/wy+K+yFPkGkZEwwR/ojnL//g=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1522:b0:663:f65:1c8b with SMTP id
 006d021491bc7-66a229794admr2711424eaf.51.1770280202384; Thu, 05 Feb 2026
 00:30:02 -0800 (PST)
Date: Thu, 05 Feb 2026 00:30:02 -0800
In-Reply-To: <CAGn_ityekaJpFNnaYHS==PcfDdeXY87w50s9VmeiN4r4EyD__g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6984550a.050a0220.3b3015.001b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: refcount bug in __add_used_btf
From: syzbot <syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com>
To: a.s.protopopov@gmail.com, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=b5a1ee0109784fc2];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257046-lists,netdev=lfdr.de,5a0f1995634f7c1dadbf];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org,iogearbox.net,google.com,linux.dev,fomichev.me,googlegroups.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A30CEEFE5B
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com
Tested-by: syzbot+5a0f1995634f7c1dadbf@syzkaller.appspotmail.com

Tested on:

commit:         ea7bf7f2 bpf: Fix a potential use-after-free
git tree:       https://github.com/aspsk/bpf-next.git fix-btf-refcount
console output: https://syzkaller.appspot.com/x/log.txt?x=150eda5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5a1ee0109784fc2
dashboard link: https://syzkaller.appspot.com/bug?extid=5a0f1995634f7c1dadbf
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

