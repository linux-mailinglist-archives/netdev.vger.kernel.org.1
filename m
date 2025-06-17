Return-Path: <netdev+bounces-198509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EF1ADC7B3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC1E3A3DB1
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA762DBF56;
	Tue, 17 Jun 2025 10:11:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164AA2DBF49
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155073; cv=none; b=scSlqJeFxBGhP94zToDmMuek3GlE04UAEou8k2chms2M6GlUrMfERXM8JjNtxUruDNuUceWT6ALmPv+WXDUOIPqTCp7iaDjFPSaE7tzvPCz88+ngJmuMXBcqrHQlPBGw012S/YSieEkI5CYx87URBGVP2xVqMrlHF3MXhcCd3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155073; c=relaxed/simple;
	bh=q89/whoFUSh/lpgn1D+A7Xy7nFLWAWNcFH75xlrf9Ec=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=UgJC8lstlUzeYDrXLICvebH8VgsS+cbAIQZlFjhVzRkNgjnrjPmcsounSwdBnqGFSnMJnlLil/fdrOXe5/NlMaaL/ENdegNYqVfv5xo59qqUoxYmdYNB5KJnJt5UXPY1Yiu7rtaAHKK0MvROdhj6Rbgvr23rnw3qo5BeUDX82HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddc9e145daso88441065ab.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 03:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750155071; x=1750759871;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bU8jxuypBIeCipDGMKJZV00Yh3TyA52Eh4b2Ss+Z56U=;
        b=BdWh0sPmVUSfGH1pOqbO6DMZgqqpDCkdyERUHUXC15oRz80NbVPqvbaMWkGVvSM+ew
         uKMIf5hSqo6OwOEcepW/DZQ4SQ/xpsd/WOzL+aI49yfu4SXNx0el4umO6B1IXBZLdpq8
         yvmglVcbqKCDttQSFxBmEEHRuyXl/az8QrWqQJm12J0Q5ofTKADYvZxIXqTXhBCiDaka
         RaP/EnxbVcf9j9fM6S4GfHyYRg/s3wpLiSQaCzO9BItt6n+tMjgTV88Vxsv4KT7QahOp
         mjWuoT8fj1xBVgm/jgyQzSi4CCU5Qqi0aoFuNptrRcDjhwcoEUtx6UNETt0y7H/3zocg
         uJgA==
X-Forwarded-Encrypted: i=1; AJvYcCWPEnB+XEgdLeu2Pfm81vlxQPqS8+K1BtRS2eh5jbdowLU+vyfsDN3tauv7XDTVV5zjfpk0Upc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nqrBCDFQCIH8bcFAnUIAWqRENgxvMr4z7aV23kHWc+gntog9
	EQstFFi6rPVFWtaFtTD9Wc99+d23BNfcWv5QOPUXsOti6gMTdG3gRIWkBHqeQiZ8wsyYt2topZ/
	KbgYolgYW/tW3qFftHdxx5AGf7bdkjctRoS3te/lGHZtYwM9MpXHxNJJY9Dc=
X-Google-Smtp-Source: AGHT+IEcCVAuVhXLIiMMU25iSD04Qh+NI7iBsDqlJl72My7Y3XEKENaQPgfJwdK/fzx40DevEcMi0Zu5FU0pLhHXfc7HwwSSTdIY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e0a:b0:3de:1200:219f with SMTP id
 e9e14a558f8ab-3de12002a2fmr76370115ab.22.1750155071350; Tue, 17 Jun 2025
 03:11:11 -0700 (PDT)
Date: Tue, 17 Jun 2025 03:11:11 -0700
In-Reply-To: <67fa81579ed1e4bf289235863eb5728b243a58ba.camel@sipsolutions.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68513f3f.050a0220.2608ac.0018.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in rfkill_global_led_trigger_worker
 (3)
From: syzbot <syzbot+50499e163bfa302dfe7b@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net
Cc: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On Fri, 2024-07-19 at 06:15 -0700, syzbot wrote:
>> 
>> dashboard link: https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
>
> #syz dup: INFO: task hung in rfkill_unregister (3)
> #syz set label: nfc
>
> johannes

Command #2:
The specified label "label" is unknown.
Please use one of the supported labels.

The following labels are suported:
missing-backport, no-reminders, prio: {low, normal, high}, subsystems: {.. see below ..}
The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?all=true


