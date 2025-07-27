Return-Path: <netdev+bounces-210403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F66B131CB
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 22:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBFD3A85F4
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 20:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291451DD0D4;
	Sun, 27 Jul 2025 20:32:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635A1A83F7
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753648325; cv=none; b=cwy93bBDPNhS3vOlpi0Enb0C846VfBB7QeSNWvVlDFklz3Co5biO36VbxMbIb/L7BBle5Dd/XNv+cFaSzgB5jadKwHXVED47/c9Njp0pFIWin40yxFTvFHIirocH89q4Jrc2ryU39jVmUrjVly/mTxieIo1wf+khLXHI8p3yz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753648325; c=relaxed/simple;
	bh=qKAXajC08QtdZO+u88RUEpQFoL2vBrwjC67UWh4RuxU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bRRfOCu7naggodLQoDudGYUKAMoguaasEJOIkKvzL+vwPDu/6tKy6iYcBy0kRHbS+xZgEJpk61h2xpUNFNVWfQNaBphtlnUBaQAE7SexYem8F01UzSlM50cy59QxTYpeQZ4u1T3E10265CZ+DckzhgFljv81VcVYbFOv3szcwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddd90ca184so37731055ab.0
        for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 13:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753648323; x=1754253123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVZNm5iHyf+ldpfRzaDP+2CJP6KflRVaMuSTT3zfTzI=;
        b=u3DugXANE39mT47vDVaf9NySJ19FkUGLWofQF3mHr55srX8xKvSSsZL6sxlGdbbV1T
         y2BEAGAYOlkR3fcQvseqEJTJXButZ/4tKNmswYJQVqhWXrf08n6QBFJchdhRccfnEvJF
         qpV4FFLlBkmqWnz5lcLBdnNjKVqD3T7N30PGykB6S6jsqqEV8H5nS6r2u8t+d2O3UBMn
         jqvQfKAqn8WXL5ARf46dO6rI3tC8iJjiwgf9Pr5ua9xw8fld067XvZZZEkaw3Guq/iVT
         fC9bj+iUvp/u8fgtbNdfYCV6dLrTH8GCkMrJmBJIoto4K5gW6OjuT02NebtwUFxcYpUq
         JYYg==
X-Forwarded-Encrypted: i=1; AJvYcCW2YTmWnY5f+SrOV1oJZ/mYpa5SSGGNwXwMd+L2382+orq3AIGWsa8oExolTg0mZiRT19ue1QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFdLPTOHzK8rRuaoeO9BdVVDx5mrF8F3BMa03M3qE7MN2dEJ5P
	QHZUvwoHRIekz1Mf2j6qI1+PUTD6u8uRZ7/PP4gmh7N8djSzxwHFiYSpJejNF29NJKkST4Ndf18
	3uX1EYvO/emVapMtj6t7+SI3GfY3fqjlvPbSiLimCgzQvdei9p9T8GwPrwf8=
X-Google-Smtp-Source: AGHT+IGqs2mNZZdeseuYEnh5d+XiBsrOzuoLvpQSrtSyw5bf4JZh36TKNJKETVMUGSS7WfXHh4onGbnoawTR6SHO+Wlv0ECsHv+B
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3385:b0:3dd:d995:30ec with SMTP id
 e9e14a558f8ab-3e3c52bc2e2mr191014375ab.12.1753648322859; Sun, 27 Jul 2025
 13:32:02 -0700 (PDT)
Date: Sun, 27 Jul 2025 13:32:02 -0700
In-Reply-To: <878qk9csvy.fsf@posteo.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68868cc2.a00a0220.b12ec.006a.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in ah6_output
From: syzbot <syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com>
To: charmitro@posteo.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
Tested-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com

Tested on:

commit:         d4017cef net: ipv6: fix buffer overflow in AH output
git tree:       https://github.com/charmitro/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1560a782580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d80adbc1e1d0bde4
dashboard link: https://syzkaller.appspot.com/bug?extid=01b0667934cdceb4451c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

