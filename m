Return-Path: <netdev+bounces-173165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DBDA57994
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 10:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1926D172763
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 09:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B818C32C;
	Sat,  8 Mar 2025 09:46:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC20DDC1
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741427164; cv=none; b=ta9rrsHBVmGJbQUzOJOVSkU/krlUC50X+NiuaSZI/3I+XdfTmla0ASXGeI45PZuP9hHp2wJnxYYWy0O85bdhLWPPB253vzGRMS2r5RieePv00ptD5KD3q8C+IvDvlA0v6AO7VbfWEjLmoH6jE9k8gSfOVeINrVzIQnBCmgy8/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741427164; c=relaxed/simple;
	bh=FVlLejdFDbutlkTC1Y2NNLbITDrvuNqRxT+XMWiQ0dY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XpNU6kPSTgWXk452HVaJpuefzGURmPPf8bxN9NLBMhMpQn7X0MUrmKTWZs6MWd+KwU5wiv+VuYSvv947/U3Xyn0BmfhrrtMmJFZ/+tCAJOtoDkDmrzHiKh093vSICtrAVMN+3xYGXV2ENRMg5x5zHDRdO3imgsjtFet4bU5qHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2a6b4b2d4so49043055ab.2
        for <netdev@vger.kernel.org>; Sat, 08 Mar 2025 01:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741427161; x=1742031961;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nfAMxlt7hl4XrwSsiM1sMw4spJ1nfH3roCq3hk1GYYM=;
        b=Gi4mcPRpdt7UN5s6R/WusI8YAAPTy4goqwzwGzIrACsN3GXigtpqi5c6xwF6lzF1Mz
         eShCfA82l0q4Qc/v8/buAQyRPxQ/mRY4bP6OVQdaSWYHzGQqxaX76X/ANLxcnUFzwlSL
         8g/DXc/lxWZdr7/LsvN7+Exzbq0OrO4ZjAZnjILLOoQpOvKh0yCa0E0mTj0jJVtSrflX
         yN3Fi4rlCk5lbSBsncqkXP+fzPgIriPrLIlGf1mCiknIXZDlHf+nQkmnOrSdp7x0zE/D
         uPAw/cODGDDHNcu/7Rh3bDX2/ztPLlI0U2yX0cX3Cy55sbIJTl7ZNUxRBqxf3VI1tYX2
         VhGA==
X-Forwarded-Encrypted: i=1; AJvYcCVhPnn/M2JuDzKDKbWiIsk+matnExJ2UsxXLgQ4ReEszHgEWgZeqewCaixd1RTfjq23Tai0zy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPELrhz9d+ZgidauLAso8K5KtLWhiVZWf4wWlGChtF/DlTmPhG
	U9MiTGTWIcCRGzPT+gq4M+w0FYpNvu21oQhpGnMAxdwFzg28A5HRltq3VV4HXAduqoO3umg+E9i
	0e5SUSEdAIwqSBVxtC3kaSZIZ/Qt/Xhp802Vm6TRUdgjPBEv6Y79+rQg=
X-Google-Smtp-Source: AGHT+IHvMAYa79194kZw/IW34l/QUa46VgEuUlYlL9gdZcDd8ttqdUVAXZ3b263TFEj87ZhuXJ63fOR+Blft5SPVzovxf1cuCVe+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c549:0:b0:3d4:2306:a875 with SMTP id
 e9e14a558f8ab-3d4418a5d9cmr72973195ab.8.1741427161648; Sat, 08 Mar 2025
 01:46:01 -0800 (PST)
Date: Sat, 08 Mar 2025 01:46:01 -0800
In-Reply-To: <67012223.050a0220.49194.04be.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cc11d9.050a0220.24a339.0090.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in regdb_fw_cb (2)
From: syzbot <syzbot+aff8125319e0457b4a25@syzkaller.appspotmail.com>
To: bsegall@google.com, davem@davemloft.net, dietmar.eggemann@arm.com, 
	edumazet@google.com, johannes@sipsolutions.net, juri.lelli@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 66951e4860d3c688bfa550ea4a19635b57e00eca
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon Jan 13 12:50:11 2025 +0000

    sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d29878580000
start commit:   e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b5201b91035a876
dashboard link: https://syzkaller.appspot.com/bug?extid=aff8125319e0457b4a25
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1561539f980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

