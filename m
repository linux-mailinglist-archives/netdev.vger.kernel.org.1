Return-Path: <netdev+bounces-230756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E1BEEB7D
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF26189A888
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 18:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F0A2EAB93;
	Sun, 19 Oct 2025 18:32:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3062E427C
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760898724; cv=none; b=XOlskh+cXRWmKgRFVJ31QoXlRqdHDv3wsEE0UKWrYL2tWGkdMJFzcs1V8DNIOOXMRcEQb+DVCo8wZXm7RVriRRknIzMm8/eYkkjjtPq/Db/hpDFeIeruphixbehxFwGRBq5Dx1OFj4+r0CUV1gQ14knGmStRP3r4CjNiElHXpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760898724; c=relaxed/simple;
	bh=72m0zZSSb82JYua1OxFLU4EyxYLTN/D0ATUw0+kN+N0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s4rr7Sz5WFiIaBFZxuwYWs4/eD3qcumemO7K13bJxq0MKLo6G8DQL2JexwD34xGgl3hMm86pfFDWFvl4YHqkLqujhu0tlCvXT1AsQpZEcr2LhoW0YHDQACWS00ItlpPbxB2ZB3RQhwiLPEIgdu3sNBp6kNVSqblmAFj281tdSYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e4da7a183so326913639f.1
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 11:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760898722; x=1761503522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1JpKrUXGRSucqL3zjpLuIe+FmrzaoQu2qNfoA2qUqA=;
        b=cP8aw2SBLAIPKEYC1KbFhePc83HpVigjhBsyDOZXLKpIF8sewA8OzPbuVt5SlIgHVQ
         r/kexRfo82efppdf1MiE0OIJpSk0gweixeaNhNmlMiUkOzIk6LWuItv5Ktq5XLaJsVXN
         WWDljHaNq2bVjQE7eFQliFER49uVlw5f5ncpvt9dvMDU1eQ0QFa4fPAwvA1coFlkssLk
         L/e86ItBZNDmqnDE7dqqbBdUU+iXzs3nxoehWRUxzIZqbtphU6CCQXpQe4W7o9zIt70Y
         fiLptROYGsz6rWn0qbJWswiFmT8SNUX+7mD5ma8lvXPA3n4Upi1onzwnEL+8Dbasl8iS
         1PiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW32WC73P7j8H4/jkaYbS3lw9+KyQT98QZ0hBHPMz/8p0r6gC4EyLrkQozKzYLzAHB2YucPFWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+Mu5RUHuBgSrO65Ayq/0vnnm1D5tbGXkDFk802UgjGVZg/WC
	PovJkeOxvLOBMFWxFbcDPAM8NJFyoJ7ymGaIxBkLt76slUC6vnzJ3QbL5RmR2EuChiOIoa6UH5F
	cD7xS5QDRo8apDoOdcvfFYxGdH9H4l8gOkxoUbwfHMTVwvU1PZEEIthNqqzg=
X-Google-Smtp-Source: AGHT+IGiF4GonclwjakcLs6vy+iuC//30bzSsBpQ1jUx4qmr4yl9A22ZJGGAblN4S+WQJyNnw9n/EytFBXMJGY8tG/nh5ttlZE02
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3417:b0:940:53f7:a1c7 with SMTP id
 ca18e2360f4ac-9405406e5e5mr704754939f.5.1760898722327; Sun, 19 Oct 2025
 11:32:02 -0700 (PDT)
Date: Sun, 19 Oct 2025 11:32:02 -0700
In-Reply-To: <1b4aeb68-bf9a-40a1-ab86-a52ef91eb3a4@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f52ea2.050a0220.1be48.0005.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, ssranevjti@gmail.com, 
	steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/key/af_key.c
patch: **** unexpected end of file in patch



Tested on:

commit:         d9043c79 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e21492580000


