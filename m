Return-Path: <netdev+bounces-126237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5337497033E
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 18:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7078F1C20FBF
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D38161311;
	Sat,  7 Sep 2024 16:57:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D122E634
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725728227; cv=none; b=Z/orYo6+GYfP+XjWWIMtuz0GBvzVq0kYLcodn45jGfENVhqRvGVF23z7Kxz9q70mg9d7EIWOIOeVL9Snx2WwZA0ZMTbgMU+4+IkpgF+jooki7f4dOlJSZNQactL43JpjF8g8d/udBo6UwqCIVKwCEHOnKrQkULfN9AC7am20A/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725728227; c=relaxed/simple;
	bh=ZtMU8w1tloWwxYw7AMQBvYsJJPEwFKU8fUMe+ZaWDOw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qm7RE6HC6ILXzpqb1le6s8LL47AMHwLm3GoMJ1Nk8WeH4o94cMmsKMw0NGFrmNoelriI0AqMANkMG5s2cNtI+iHvBAzu/zDKCL8c7ZXnFpuxMHqcXTM5/ShwwjHQKVUf50ZpaLXl/TWymJE5kgIZ4xH2TfIs8UmBS+g/Rk0m/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d5537a659so57969905ab.1
        for <netdev@vger.kernel.org>; Sat, 07 Sep 2024 09:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725728225; x=1726333025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqioQfI0jRHJ+2HyBzWQTOPsbbuKbvskWBDUXI7NhPA=;
        b=gtPuOIfLySK9IBBHRi1XIfpzPydwrV5W3O4Ww7IfHlmHfL5bFaxfar3BmcSLtJDHhV
         On1OsUlU7nXXcdEeEclLGYaAx2w01VUJ4V+NszUvWil+JrAbzN+Xu2IId5KBd6LYchzG
         WSlok7poH4q3DZajr9/VNDKcYFCJO6R5hytMqHe0bwLhVGCuQ2GQ38gULPr2XuVlk+oq
         i5ymcG5NzldFIsEBptQBHj825cQmV6+s9U0xiChG4QD14+5zkacNrdkcCF5PF/B051AV
         /sGPhnquhxHelB3n6xV5JpGd6Qr9EIcpnBpyt/2DfoIIvmcY5FTodvxZAZoZX9c1GcQW
         nYHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVThYHgdl9f/UxT2yhJbgEnCpkN5FiN6ITE/ZvanPVPCA4S17f8lv8LjNH8I3Tjo5hJi7ci2BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQ80eSGl56bikMr/iClZiaKitfl3NlLUd6YyB/lwXY22xaiI3
	D2GPHHIu1htkPexJbYKw51ogVpDgSv+FUg0gKPg7tOGOx2XUPLcdQt/kC+bQALZZTZD4DDKzJ9r
	jI5ofItan4jx/DJrL3iq4JWSgGledhc4oPsdA0ny6qeqiEid0XVrfaUQ=
X-Google-Smtp-Source: AGHT+IF8SgqIXPoeZdJvxIHF/R0WhiGyZdPrZBifF5WpHod7Lg5TLFK+P/zj4no5/G7TG7yVMkfnczv8rs8e36L7Y2XEMzVhfdtl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:3a0:4646:8a7d with SMTP id
 e9e14a558f8ab-3a04f10e30fmr2545425ab.5.1725728224995; Sat, 07 Sep 2024
 09:57:04 -0700 (PDT)
Date: Sat, 07 Sep 2024 09:57:04 -0700
In-Reply-To: <00000000000031c6c50610660f17@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4819606218a69a2@google.com>
Subject: Re: [syzbot] [net?] [s390?] possible deadlock in smc_release
From: syzbot <syzbot+621fd56ba002faba6392@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, aha310510@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, edumazet@google.com, guwen@linux.alibaba.com, 
	jaka@linux.ibm.com, johannes.berg@intel.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	nico.escande@gmail.com, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b7d7f11a291830fdf69d3301075dd0fb347ced84
Author: Nicolas Escande <nico.escande@gmail.com>
Date:   Tue May 28 14:26:05 2024 +0000

    wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1536189f980000
start commit:   5f76499fb541 tsnep: Add link down PHY loopback support
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc36d99546fe9035
dashboard link: https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ad7bc3e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1461e9a7e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

