Return-Path: <netdev+bounces-93024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E828B9AFC
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A9C1F23E54
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B3762171;
	Thu,  2 May 2024 12:38:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3302753E27
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653507; cv=none; b=mZVAcmHDrOpwgoFBMwqiK4KpTVa67nXsZIuxULI80H3TjJvwYVYjs4TWghbn9vd0wylYTpL3J5TragSlDQVs7PVGbEubIte8pJqawJBdnMII5cDPVKDq+gwqF7+3jPQQ3kOXWRQhM+n2dhJShUyibey234h9Y8FSGvbfg0AU8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653507; c=relaxed/simple;
	bh=D2nNSFE0GzhFOBu5BVbzRL/gL4zvbHJrs8eRk+GfaAs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jS7CymljQ2Royav4p2twVKnSxjMRmXo0UjtYyrmBA+3ZYodYvmhhKqQk0eXsnGHr8BxZ4q+f23Fs7J7eVmRD5sZvF1NSqSgZIdtwqcKntxMoGLy58gCYV06T/a+B39W2t//0D/EKuKjeqaPRedmP+IM0aiFkz1SXBdd/FwPYQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso889329739f.0
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 05:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714653505; x=1715258305;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/8KyUbi4Pj7yz3Rv0CBXW74l59ObuU0YwVCbxEM8D0=;
        b=Mx1QO8csRCWL4QIGPczbQGXSIheSn3E0RPpNkI3VnMgYrK48B8Rs661vx8CMDn7sJ0
         UaljaVtj+E/oSjKjcntrSrrWPSeTLD2GiCTklLxR9Ya9saKPRQw92k6YU5DRkMKh+yU1
         +wJE43w/BYkzOHkz/x5lnPAqiwqOCUpeTiKN0OJWaZ1MXZXLnZ8vra294NrUCBLPzQ/D
         96jCz6hYlnHVA7n7Sh96IwplP4oWRshR6CWXEchrlY1bmDlP6fbm4Zs6kr7F58zGGfC9
         /0x2ylzS9koDf6B0oSqTTcUP5ds+HZN+ILFxu8I7Ymp3rJtjWH2FmEy522HHcAdPivQj
         +nKg==
X-Forwarded-Encrypted: i=1; AJvYcCWsL3U61J71B/8C/OWwSW5xdScdSYzp5qMNlTqNQ8iv0YFpNXdQ+6z/BhtxiWnC13rO296FCG9rOyGsV9ihrM7s47b6NUpW
X-Gm-Message-State: AOJu0YwkqwXTeCIaGIshkOFXSONWB2CeCCM8wODNQ3ins7/x0TGNN7EM
	k/tWVsBvtoITFEcuRuDoaqp/HqZhTyIa3woaye2eys7uQZf8ASCLx/KIVKt3V2rZH9s36DKgdPb
	51GA/XOJK3+cG7PZitxHhMo6/Y7nAcS7Ho50jcCTRIjBV+uPsuF2krGc=
X-Google-Smtp-Source: AGHT+IEizWOs2nvSEGGx8eJbCmEYpesqO999HC9/7yfeOUOjG3N8S5stcbzSboBiOmCGDOvdbP1z7jEJgbHslwXpAQAPvtUEDpdv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8c1a:b0:488:1050:6a2f with SMTP id
 jl26-20020a0566388c1a00b0048810506a2fmr26697jab.5.1714653505498; Thu, 02 May
 2024 05:38:25 -0700 (PDT)
Date: Thu, 02 May 2024 05:38:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bc267061777e143@google.com>
Subject: [syzbot] Monthly wireguard report (May 2024)
From: syzbot <syzbot+listc4826f4184213affe703@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 2 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 16 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 939     No    KCSAN: data-race in wg_packet_send_staged_packets / wg_packet_send_staged_packets (3)
                  https://syzkaller.appspot.com/bug?extid=6ba34f16b98fe40daef1
<2> 1       No    WARNING in __kthread_bind_mask (2)
                  https://syzkaller.appspot.com/bug?extid=36466e0ea21862240631
<3> 1       No    WARNING in wg_packet_send_staged_packets
                  https://syzkaller.appspot.com/bug?extid=c369d311130fba58211b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

