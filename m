Return-Path: <netdev+bounces-98676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D58D20A7
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C551F23A63
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4F9171641;
	Tue, 28 May 2024 15:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990D616C456
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910988; cv=none; b=RhaghLBuTJfwesDNEsaklX6pP0SkxSXy3cdMptKloAVloEUI9pcQPOurkKvytdmwQUxla9zHNAYVNC8Iha+BkKPjiqmFU+YrFiOJFqR8h+PHu129eHMgIMAkhkUGncO3JYRqHTmmJGZer/uad7c2zCQYnfW+dqMlaMYUrr/9rkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910988; c=relaxed/simple;
	bh=m8dWd36Ko5UDIOAVZmfQHf6AlSQP+P/87X28TrM1dbY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sQsPKXffMaOoxlfyk3oGh5OAo8y8k05VPHlkmGj0vcgXY4tyk9/+DHc2dZRO/e12NVBMd/6Yog7ku0D56jqmArTXxXWc5y4k7iLi8C1d1r/m6NMOi2tqHT1sdq+3SRRRRoh8DzcnRjeosUUldFLBbcIDCOjp/ET0u/DY0/tIm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36db4c1ecb3so8570655ab.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716910987; x=1717515787;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nJ84aBxOyzJElxkt3YSTP+R595rZEalfyLp50ct0ww=;
        b=i8e05dPhJLFc4ZUU14UbhArU2Zf80iWfryC5ANQeQrM0AAP1ahqfr2eNLuqxRIKPFN
         H8Myg4ybXfEedNeoRBKCqN1or4fa8Xp3EcVH9idRb6TlRn625uHgIS/+2m1mhsOGx86Y
         N9WMeEkpmRCEPAx00d6ftCuY+6ebBiGeVms1UDuDX1PhToUp6hI+zNARk0+i65SITxIK
         ddSpMQyhvCNTUYfKZ0blQgrZZCTF3Ixp+pzu1x+h7K7i3LiLEHzO3P81oRMFN7zIrN2n
         iI8jNTPvawNqrFV/NPmVblbhtpQhj56sHlWTv9A1cUw/TuHDZdVog+DdMGXzthtM5K11
         id6g==
X-Forwarded-Encrypted: i=1; AJvYcCVD4OKf4lICTz2Bi6qf2QUk8ydqMxiOxXNpNSqNtUSHcYa63LbSjTNCfGbJsa9Wuqd1c+FJr4CAA3EMJPgbWcwdy6E5YeI7
X-Gm-Message-State: AOJu0Yzg6hZpWMfvq2VaQe11aPIWD2PbvzPGvtZsAyyIWb4O4KfaBdZh
	8mpr/gs3NgDi72fbVsyZKc8z5PMlk72AMCdLSXKTdUYfHuRV/6H7rLkjPMmUYMSvLdnfX/xxkI9
	V8M7CyWdKNOFjH3hqlfR0Z1KOD63t0JW0boq3Ynm5WiJISO6oSdAP6SM=
X-Google-Smtp-Source: AGHT+IGJI9lXHPZA8JwJDsjj+KjBSOmd5bkDiFOW4CNG5zofWCPnuDcrlXDGggYYJ0uAbsXHw+XC/qMi5KS21910t4aXvkFEN+dz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c566:0:b0:36c:5228:462 with SMTP id
 e9e14a558f8ab-3737b31cb5fmr9012235ab.3.1716910986931; Tue, 28 May 2024
 08:43:06 -0700 (PDT)
Date: Tue, 28 May 2024 08:43:06 -0700
In-Reply-To: <ZlXAFvEdT96k5iAQ@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cc41d0619857dd4@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
From: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org, 
	osalvador@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mm/hugetlb.c:5772:51: error: expected ';' at end of declaration
mm/hugetlb.c:5782:4: error: expected expression


Tested on:

commit:         4b3529ed Merge tag 'for-netdev' of https://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c8c38a980000


