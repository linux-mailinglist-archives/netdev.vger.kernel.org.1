Return-Path: <netdev+bounces-119499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F27955EA8
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 21:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58DA1C2098E
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 19:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3214A0B7;
	Sun, 18 Aug 2024 19:19:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F32581
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724008744; cv=none; b=E5lmVFMllt0QORPljXZXYbK1ULOiMhOB52PZQ2nsta4q+LBw3nN4krrMlHUcHI1t9wbdYYyIKbwF4096vbUWhmhGtSVGseWv8YHBcwwqIOtgPdrkyCbPv88oXYndpFlR912vlLCYOKbQbIRFfLLadbuzC8Xtm40i5PyV09eLESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724008744; c=relaxed/simple;
	bh=V6+i9ZHd86Jftzv7iEO/OGkHm+A4Id6bY7y6jhrHVBI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qfX8x4ZYCBMNpZX8SShOLZDGWz9iZoNPxw2NIlj5FuacwLPd6Pvjp+GRMurnRZf3pjTYtpkkzmA09u9/xGwjwF6YXGuzBjUMVmfSl84BHwBN8yhKIo3ZLuupbeBVZIqWpfUWxJC6M5/xxPeqHxzv51XngLeb5KFVoo70GagaNCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3a9f9f5bso37629685ab.1
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 12:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724008742; x=1724613542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOn7k/gf92spm8LI+iLgdIYChmze6niofBQwCBXRuGE=;
        b=mz/K9cC3I3Cs+TdjNgH20PTd1IphRhklSeleOsrMRgB8ysY7TJ83kdvEhcdN5OPrf2
         6AhN8w94WrcQ3tH7rgFlDyZmmwkcEfPa8BvhDuLmySn5sKpqW2bviVXUGmHpy3W/SGfW
         faE4qQ75j9J5qfs8eatoWNWgbqkiROQ4cS9D/d/rDr37ZYDS+W1RNa2pIR6AxdHCNtgt
         420AeLs1E5ncKXM82Y6auHchE7pQqCfZ8unr5wpn6iU7F31319wQsKqio8lXpdhRiqEr
         eQ542SHOEsxXxmwCpAAEBSCWjmW26GSjyV0CcTRDTc5CxPSmKWoc1BvMJzzt7khjuYTM
         C+OA==
X-Forwarded-Encrypted: i=1; AJvYcCUlPukC5ujKcjwZK/LHo3KOM8aWYiEgmZecXDB7iH1LhjTAqgkCzbfcdAGclQbw40Vwhh6yJrAcUhLQujG5D7Q2DkJCkZ4A
X-Gm-Message-State: AOJu0YyxiY0IeBJ1DCsm06sR8cIbFtFVPFF71cB5c3oolzm9wEQCenMb
	y3e5RGNn1neTHNswbj1F3u6VEgaAMqU6AAXiUWbSjV+zrh1Fqb4/BeDu9oXBQLVAfGApfR/3wr6
	OtqjmTCdtBBau17nFHwqVo9FtZLf+QmpcvEV9W3/peIJUoGXvUWl/7pM=
X-Google-Smtp-Source: AGHT+IEet1fM8+b3ovFLzqGlZdbvkZDwMB2WRcSgR9DQgyJRsVgqllfm0eD++outR/I0JQiH4ZYqp+gTlF5cvJ7CXE5gZrbqTXyY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170e:b0:39a:eb4d:23c5 with SMTP id
 e9e14a558f8ab-39d26c36cfamr8712765ab.0.1724008742349; Sun, 18 Aug 2024
 12:19:02 -0700 (PDT)
Date: Sun, 18 Aug 2024 12:19:02 -0700
In-Reply-To: <000000000000612f290618eee3e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad7bab061ffa109d@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in cfg80211_bss_color_notify
From: syzbot <syzbot+d073f255508305ccb3fd@syzkaller.appspotmail.com>
To: angelogioacchino.delregno@collabora.com, davem@davemloft.net, 
	edumazet@google.com, johannes.berg@intel.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, matthias.bgg@gmail.com, 
	michael-cy.lee@mediatek.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4044b23781104801f70c4a4ec3ca090730a161c5
Author: Michael-CY Lee <michael-cy.lee@mediatek.com>
Date:   Fri Jul 5 07:43:46 2024 +0000

    wifi: mac80211: do not check BSS color collision in certain cases

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130f62dd980000
start commit:   f6f25eebe05f Merge branch 'wangxun-fixes'
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=bddb81daac38d475
dashboard link: https://syzkaller.appspot.com/bug?extid=d073f255508305ccb3fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f9ec92980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1595fa84980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: mac80211: do not check BSS color collision in certain cases

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

