Return-Path: <netdev+bounces-179688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BDCA7E241
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC29044256F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84141E1E0A;
	Mon,  7 Apr 2025 14:26:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2288C1E1E08
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035964; cv=none; b=h4P0M6+sLHyxa3p0co5vENCQPbxSrxcxOmM2xDnZZ3PMPX6DHBMQ2Rmu1Xx6WjtUsrQ6pnowma4cYMYWKLHi++uhBxurICzMUrsALtykted1Rk0sLQbiWYJF7jE7AEMu1BYb4N9LTTV7HPRQIyXwJGPYc8OMoXQwmzZ2Bshhvcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035964; c=relaxed/simple;
	bh=KV9W6AUrHJdqHLgUBuRoozIFZ9XmFBTpBvPPo4dCfx4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bBH+6YOzDoc6h1DT/yN50sAgBEs1/RblPlRZu0GWhE2AnmbOb1NL/0pIfYYir4bzd3twwwZ8DO7qfyhTJgi85gRuTFA1NbOTk1pqFP6Mpzgjid4mZxVZtljXliZjvZUF/McXvJVAeZfpQjPExUKhchULnwG8oIP4qLvIRvyVzsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d43c0dbe6aso94970925ab.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 07:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744035962; x=1744640762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjUxYvY1YiyC6OoVQvcfUdICOWiC2nlpSbYx2k4dA5E=;
        b=pJ55VzREaXtcglOx7DAbJm3XTNx7TkO1kFjOkht3FL4K1g6qBQM2EMIttKAzPxXinN
         6c60KOtQAgNU0/KFAAEpQJD8wNtldomHmYddfnqaWv1lhkTUkogrm2E1PkiTlPzhqxeJ
         7upkOLZB49yUTEk7KjY3dyq26ZEM5Jlew0teirVmPYCFVhhsmEdcqRR6b8/KbIjMwfUR
         XsnN/NH0CHxyU/hQ88JDkHGtFuoGpsz4IqsSk29dOeOx5FLx1/6g0c6x8xcate6CRb2N
         SUmXAxm6eYIEdyS8EoCYAW7JCGNGdVlDM0moDjwzW+vaRGr9EDYTWQFM8nwkYSTZ3m4Z
         vOCg==
X-Forwarded-Encrypted: i=1; AJvYcCXKtTNCRzo/MoyMDW1xR3F/fsRS72m5ObctOg8jZ8jpKEeV4LKcMCmn9bmJ9BdbmpO05h+QIIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVomDnUeo6VkoijiiPT/s73dt6uixlBB7ve7pzDsX3M1+fQINU
	cy3ufYcjiKi/twlK9HToVsMzkWtIaB7lOSdNxF6TsWIqaksij+3Qf/PoOYR3M5QMi3+dwN0q+rG
	ml06pO6tBa/Oyrp1Dbz0itv81cDz0HX+ykBQdrp+epkA9JNTpp9xu6Xw=
X-Google-Smtp-Source: AGHT+IES1QhFs+V/b6s7CUZ53WUmbrsnVac05k1xT+P7gkYs8jsVm0O6hIaL80/furuc5pXCxzZmBCavcYC6KBxWmpBPEquUvWTB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e91:b0:3d5:8103:1a77 with SMTP id
 e9e14a558f8ab-3d6e3eea919mr161227325ab.1.1744035962257; Mon, 07 Apr 2025
 07:26:02 -0700 (PDT)
Date: Mon, 07 Apr 2025 07:26:02 -0700
In-Reply-To: <20250407140603.91155-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f3e07a.050a0220.396535.0550.GAE@google.com>
Subject: Re: [syzbot] [ppp?] KMSAN: uninit-value in ppp_sync_send (2)
From: syzbot <syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com>
To: andrew@lunn.ch, contact@arnaud-lcm.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://github.com/ArnaudLcm/linux/bounds-checking-txmung: failed to run ["git" "fetch" "--force" "98936a0cc8cd68334b039c881b39b10e6f0d7c99" "bounds-checking-txmung"]: exit status 128
fatal: couldn't find remote ref bounds-checking-txmung



Tested on:

commit:         [unknown 
git tree:       https://github.com/ArnaudLcm/linux bounds-checking-txmung
kernel config:  https://syzkaller.appspot.com/x/.config?x=f20bce78db15972a
dashboard link: https://syzkaller.appspot.com/bug?extid=29fc8991b0ecb186cf40
compiler:       

Note: no patches were applied.

