Return-Path: <netdev+bounces-107116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0292D919E71
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 06:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73371F24ED1
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 04:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D501BC58;
	Thu, 27 Jun 2024 04:59:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE517550
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 04:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719464344; cv=none; b=r4x3mdWnhgnrlygtyh39WTTcygsIhp6x5+YY8uFPg9ey1SwM042A95EzMMoHX/g1kjtahg8l039IZp+WAXob5hozQKHosiCGorJs/Xf6jFvC9bxo4eefmKNXeeln39ZtVd9YVFgKaw2VZ+ND5reC/lg06VmsXskYlXF/EA/ISZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719464344; c=relaxed/simple;
	bh=IkQsrKKUn8XRTQXTllxQe4gYZgzHBsRviOw2r7w+Krc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jLKeoCWX/8joDSysqKvQ/dg/RXugJVt9NxcYdXmce0hpl4wY9opM975DWdweSk4uWb2wPhHoic3dufJg5tm7gchI/jZRt5IJzR/eL/xGPJwQ6um9uHg2zEAJsEJZ75Utjfe41i+mG94AaM39CrcgGzJs1fJmV/1tRFy3OHH62ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37715aeede6so36883735ab.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 21:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719464342; x=1720069142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VsPizNXofWfwb6ytZE6j9YZ3mxWUXsZqX+k1ZKLAz0=;
        b=qAMlKAuqXupyoP9HYY0mluIQ05f4oyHKLEmoylPYAexmHup2bZ+sjfBHCI2JVzJi0b
         DCrZyK4YNEAUaKMVbNYv729Djsxule32gSUJN6gI/y4qslucnOHdMFqBI2GXoa5N8zrI
         zoDVxJ/J7WJQx0rt5TvUKEQajbaf7RA7uWk3gA+HsFtkffNMwgmRaI1ZleCYR3QXMGBx
         tUsvrAsvWVDWNllpZey9KIFrSLDG7hK+I8kmZoDo3OCvkoSygamodRWzVzm/9JxWd87X
         1covOr623qDFHSh7QDOL21Cp57qYd+mLImb65z15xso7c0OeHkZQJgOawbxljq/CIg76
         1+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXXJgMj0+BO3AN8kwH9yjLI28ZcdrdamvWUVrp5I30skMtHyz+CCEBu6yZ8dUt4gyfxqfBslRNeOhsvW7pwLZKgZeJTFdTT
X-Gm-Message-State: AOJu0YyO1fgnQiLJPcdHnVWDo3XmO+vCXDpYe6AaPBFNkcFJhkmbNSRd
	Mylw9XLf1aa11l/k65o4QTGgWen4qoL2i6AgMIAqac0Qpd1/40TMoXHPKCHK9AckD3bBu8QUfQ4
	2Q7ypg8QED4Z6VP2L8ESy1Lk8SoHiDhoMsfFKS1ZwN4E0oDlLhHCmClU=
X-Google-Smtp-Source: AGHT+IHTP9IvArud6LUgveR74LtuG4oMDICVLPPXWnHbW3sLJ/xx54WkI0jfqyPCq8oqZx96CD1XBK9MWwBFCOLfAWpwaE9vRkKL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:15c5:b0:375:da97:f21a with SMTP id
 e9e14a558f8ab-3763f6e1665mr12436205ab.3.1719464342366; Wed, 26 Jun 2024
 21:59:02 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:59:02 -0700
In-Reply-To: <0000000000006293f0061bca5cea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054b7cc061bd7fdeb@google.com>
Subject: Re: [syzbot] [net?] general protection fault in coalesce_fill_reply
From: syzbot <syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com>
To: brett.creeley@amd.com, davem@davemloft.net, drivers@pensando.io, 
	edumazet@google.com, hengqi@linux.alibaba.com, horms@kernel.org, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, shannon.nelson@amd.com, 
	syzkaller-bugs@googlegroups.com, vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 55a3982ec721dabd5a4c2f16bfb03deb032e45c2
Author: Shannon Nelson <shannon.nelson@amd.com>
Date:   Wed Jun 19 00:32:55 2024 +0000

    ionic: check for queue deadline in doorbell_napi_work

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fc181a980000
start commit:   50b70845fc5c Merge branch 'add-ethernet-driver-for-tehuti-..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15fc181a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=e77327e34cdc8c36b7d3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1599901a980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1429e301980000

Reported-by: syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
Fixes: 55a3982ec721 ("ionic: check for queue deadline in doorbell_napi_work")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

