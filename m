Return-Path: <netdev+bounces-108988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBB1926701
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4AE1C22197
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7C1849C0;
	Wed,  3 Jul 2024 17:23:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14060183097
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027385; cv=none; b=MFqFAH/2YncIhssHE+6L8VVbsg2If+eGqnNN4F3lIq7r99W+Suk33LdRdpjqR2HyEZCK8EDh8PVpiZVHHt55ZLwdSKBTCA7BcXg2t7imQA0ueoTH6fndwYw1N+FDxBqwforXKOLIdzmJMqA2y4BbOKDslpgK8007+uySU4At+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027385; c=relaxed/simple;
	bh=iDWqXvabKOgAqW3p3Iu5skUj2Zz2es1nqz12xkhpFQk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BFFOIWHog6Z1R7D816JJSPlXTlNUdKwTymbIc1MUEeJfl0ttrB/M0JUiNs+jNZKScR9dzKwkQUolsltDRE0Au9mAyipiipl1N6RJLV0hrA+CcRXeg3uBiGJhOyHE9482JhDJG4K6jHLQtae7XN1nOkHOf9LG99OhlEf8xvHA8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3737b3ae019so59906855ab.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 10:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027383; x=1720632183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l11yEPDvI5YCrjj0DcoJuCs1C0g24MwZOXs8ZbcH3Vw=;
        b=kaTuXWvJXBBfzHm23FAwvoM+sexJ+fO1u6GgHf3biqdlmkb2AkJBlpad++6wMHjpWh
         z1dnZiYm4VjzMS+CjJx7wfsWVaDASRj6m4XWUNyc88oWZAeLiDjxVNXuvspH+EAmRTwX
         yD+MD8268HKpKBFukwKxCfd9z/+vwlNZzagL/l7dsUm/ZBYUyv+1WsgSIjIyjlJQEJcf
         1QQWFfrylpQ93L8sXhhi+FUaoDTODkNE0Zfa4nT+aOl4UksJ2A+v/fMUYDjMVIeDvmXz
         QRirGYzfz48wrkJjLi0tw0V8FqIbLf+R5+K0fEpNyRx8RXDTN2BpLDMznPkU84kbJSe6
         jhSg==
X-Forwarded-Encrypted: i=1; AJvYcCXPRNBcK8s4H0fHF39pMHGph3seDTs1vmjT8HWAYr8h+B7hVZDGBAV7lAHPkkUS54VUTqHY2jPJ6CW/DigH8oM04fcQaKOX
X-Gm-Message-State: AOJu0Yw4EdqB73IomBxC6+NFHPkVqtVVJHvquoOhEFAzpe8qrU4dx+di
	HYrRsJRzLIpVnzTEi8oyHvvQDoZAqcmYFt1RnMHcMbUcsKhyrX+Qmy0LW4gUz0BH++Dg4Mos12Y
	XzKVBiY0iP2Aknz5ifsWWK7JGY2Zc11gWv4ZoHtsXtD2/DLicxiVVFJI=
X-Google-Smtp-Source: AGHT+IGutl/H9tCG8cVtkfDGWkkjm4xSkPq4+cOkWdmH355BT6OaM3Wi7YwSczwmC9gXLNyJlbz7EAnROzEEPgaGhTZcvnpOpGvj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cb88:0:b0:375:ae47:ba62 with SMTP id
 e9e14a558f8ab-37cd0448fa7mr2316875ab.1.1720027383240; Wed, 03 Jul 2024
 10:23:03 -0700 (PDT)
Date: Wed, 03 Jul 2024 10:23:03 -0700
In-Reply-To: <ZoV+N1lcTs1ztvay@katalix.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002eadd0061c5b15c6@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com

Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10eb109e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101379c1980000

Note: testing is done by a robot and is best-effort only.

