Return-Path: <netdev+bounces-83926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F7B894E28
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DA61F23892
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191E857894;
	Tue,  2 Apr 2024 09:01:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C705731E
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048472; cv=none; b=ZINOaxfFqfmlLGfu3In1q6k2F8vPFcwN4cgbvECKwV+Bt07x+RoGH+v/tbrnMFbSJNDtGA+LL5f184nR4Y66Y/FAeUHbBfmpjwzEMYpAI91Wmsd4VG0nIhH1Gw/jePWxbSf+/Z6d6BOClryxqNZfocS/MWJ/AbWIQ1STejyGaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048472; c=relaxed/simple;
	bh=pKFwtZTaqrc8nj4olYRMlSYneEQsyW5GpRxBrsnGAMc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=n3Ec3XNts350MVwJX8CUQTAA5f6yn3kqJnNDTQztqOruYIf+FYWX4LejtcKizC/8Wq2ZX7/Rq38LZlJ+tdWGbDCphLFGCCGZiizzGYrgCBw6kCmrGKcvUaBgjAk2kAIgAtJ0cJYGPKtxF4Qok001bpfBK9Go5WmE6j2xJs90Zdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso398275339f.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 02:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048469; x=1712653269;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKFwtZTaqrc8nj4olYRMlSYneEQsyW5GpRxBrsnGAMc=;
        b=MsImGQJvO/+fncPC+jftvRL2tv3vdfszLMtYYrtG0kmcOBDozdqfAwaA2zSL10Wzgf
         qJup9vSh94P6H0TOhWh3QFIf3feY8en7uzb5fdpfqa+jONN3hZf4XKQyiF3AjDPfB6cN
         DwXgKRZpV9dG6XKaTTbCzpiz5vzAQJK6KDxma7Un9JGFmPagMZIHTf+ZS7ZN7oA9UaqS
         zpvVl2SSEpiiBnb9hLocnrb0Alq91U/AkT4LRk8SLVDPzyjMJ+mT6Flcn2Y7hLDNg8RT
         bc6tQVU5TGTmI8Y4caWSYUEbSXWnusEb9xYnvQ5ksDOWPv92sUi3Qh6HrBbdcDflxblo
         nAwA==
X-Forwarded-Encrypted: i=1; AJvYcCVP3W8D7U6oDyfW6HBnHwGYJVO2/WvFEMiCHKjUe5bgT5GSMrXJgiFX1P/XTLbG8M+tcVEAvIHnB2vAHjBlM34Wv9AwCQAI
X-Gm-Message-State: AOJu0YxpmW+stZEdhy/qFv5+760OztVwwUSuNFnxXtEN1LlbyBzrzioq
	Lp1+y3McoqzjGox7oPZ7BVuUh5QyZ4SIx4LPUSZthCjO4w5zorE+Sdmh6UIfFsKwyR9sH7Ahlp+
	+yX7Gh27gy5CHlIRWf5q/fOmQPeUD393QhTrztb8ryqAFVMRiItfbhhU=
X-Google-Smtp-Source: AGHT+IF8E3F4FXRMTBFfB6xAfwhi7CTp7Nr5gYOuq0JjZ2Z7aLBhtOaUiHvu9/q2yRiyU1L6TrbYLDtBs5pPYp8fhgcrHdH2nEc2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2109:b0:47e:c145:c770 with SMTP id
 n9-20020a056638210900b0047ec145c770mr816747jaj.6.1712048469733; Tue, 02 Apr
 2024 02:01:09 -0700 (PDT)
Date: Tue, 02 Apr 2024 02:01:09 -0700
In-Reply-To: <CAGn+7TXh4gzeQ3EktnYQ=TXO_LutRU8iSQ=VbBpPpVX=Cr_UEA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e086c706151958eb@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
From: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>
To: jakub@cloudflare.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr

Can't dup bug to itself.


