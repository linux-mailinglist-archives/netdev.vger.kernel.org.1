Return-Path: <netdev+bounces-242723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 122EAC94338
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B12654E24C1
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E75219319;
	Sat, 29 Nov 2025 16:23:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D417A30A
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764433386; cv=none; b=cbwhy5iUeC464hOEe6mJ0cyOCTxWFPE/0YNDStcbtRbfeqDGCby0MomtE9xgyUlyZc2irA8mG00H+oP+2l3TCb91PesXeSkB/waBIfPEj4rnQkLkNyuVMi0FyAoLBF7FG82XtDt8j7I+K9gyAEJdQzbqdXDY/81ZEfn/168dhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764433386; c=relaxed/simple;
	bh=XdjbRADUzDDyvzNgtubJRsrcenu8LV9i+OgRjb+klhg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RaRifLrRDSc0zcwEyUV5F/BZVKDCAd92+Ur8CaSXAUGGe8NGYmOnJHdmTYxQqlXybP2nAqaX6IEzhzIju4IJDoN1RXt0OXfzVjAhRLCF2uES2IYOd3Y2ab0j0hOqr2x0jub+YTKbSziEOudcdfo6lHjeIUPfs6NKsqV+TQzkaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433689014feso20146385ab.1
        for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 08:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764433384; x=1765038184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IcghO2uCA7J4DCOp7m8p2vu9gnbZb2YxRfMOhoPkRM=;
        b=AvcFU/Uhl73BMLAw9pzYr28SrNOjjmO3mvGm/59MzF1e61WmqDKWesxYoSTtXgF8R2
         ehdJ39XD46yB2V7TepWGu/J011MdhVMwawun8yF0y2q5P5NnxpSVzomlh9+Uv7k+zhgn
         W/1YprAqIRUr4DRBONyS5SUuRBRZ9ZVfHt3946ln0O7rEOM7fBoIqxRv5IqM2LUvDo8E
         ZDELZPHDHqCtAluXqzMH9/jrasEp9mJN6BRQtnBzXWcAvnIWsUoPVGf4SW5GG8WJgSm/
         IRl7uHS0r2YedWdxODJfvgUmvJ58UFpBm1zOiQ50KpnLg29OP6yXVvZv9wgR+pHkUH1h
         TiJg==
X-Forwarded-Encrypted: i=1; AJvYcCV75x/2WxdmJWGcxLjJYYqPRYvzAl87MkE3kluLhgXqWfVn/fH1PhN8mlVp8hzxwKTKIHMHoBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2P3rjCNPwQdTaEPOPonmklTF5d8ARC2Uv1Nr6nuJboY2vq5d6
	e5KNH2Z1eRKm3zD80sgVpC58fdan9jXdRuu+0/lCRf3kq8uQTW8OOyVWysutul7yg8R80LleXQe
	v/ISZDJE/01fD5sudhxawh9FGtr/P1N69NMLguG02gU+8xo0jrr235H4yymo=
X-Google-Smtp-Source: AGHT+IEAAmYtUl5nkXxIrh25xbJWP1OTSXwdBgA6TyYXxULPPIe886Q0kbifYD6OdQwwI73GKyvYNGEXl+J+EQ+qhJNADus5Sfed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:308d:b0:433:3487:ea22 with SMTP id
 e9e14a558f8ab-435b985e4dfmr204400455ab.13.1764433384189; Sat, 29 Nov 2025
 08:23:04 -0800 (PST)
Date: Sat, 29 Nov 2025 08:23:04 -0800
In-Reply-To: <c732819e-3871-46c8-aaee-ca2ba75a28d1@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692b1de8.050a0220.2ffa18.0010.GAE@google.com>
Subject: Re: [syzbot] [batman?] KMSAN: uninit-value in skb_clone
From: syzbot <syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ssranevjti@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
Tested-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com

Tested on:

commit:         19eef1d9 afs: Fix uninit var in afs_alloc_anon_key()
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171ed0c2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1db0fea040c2a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=2fa344348a579b779e05
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a94112580000

Note: testing is done by a robot and is best-effort only.

