Return-Path: <netdev+bounces-230773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2BFBEF206
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 04:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94C1D4E13F5
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 02:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8FD26C38C;
	Mon, 20 Oct 2025 02:52:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D142A9D
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928727; cv=none; b=Ikm6HUvG+eY1SY4e4CYVNFcj70eKzRl1T7BsaqgYlIFjrqUOInwul/6OHWDSu3I+pxwwpB8zXWHu9qoyaAzhHfzwdm2kDc/JXsCmT8EpbVJQ2gzyySE2hqENP2j5+JejfulMxPXQtmFwCIbquz4re156C08SMooreMPelHDPTi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928727; c=relaxed/simple;
	bh=cgL1OPGYQWyS42XhkvkPJLaPso86wW8QNMkLpnB+/tA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X3eW8YVzhwpC89uGbrBVG8nfYXJY/Aj5zsv22EyMLAJJmfJYGkvh1JmyPPHMR4bgF855pfCyRHDdezKjj1AMrYud8Itg2E+dp3CaprJoYLQNK2cDFzT7tkGv/W9v/NUXgs4Fq4jPqrwsigCYcxSgXFvxqfwjmU2ctIqz0sA4NBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e85344382so615571939f.3
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 19:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928724; x=1761533524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0MxZrYqBouYFSNH+6DGRRUzuaxEdiWXDdcw6vp+X0o=;
        b=xHo4g0otG5PZ3ojT1/07FsHg4S/8F2QDSCwDN35hT0QiDEDMK5KiTe5za9zhg05RFD
         7cr6ZBQH4duPnSSF0qjHjIQeaOYwx4k3rBaxUS0Eo9UUyc9QGg2MeF7I5C0GyICleELF
         rsCkm5MUPDHn4nDrWz/3feeNZfRZC6rSEtNPz/BA3RGiZCMnt/kG5j9lIrTMOOKCqysz
         9KNAIFXiLKyayl6aLSQS/xuR0ThUfTRUT6uF8V7wfVxgbtEHNlH6R5/66F9uk3bYjO1P
         +h/O4zT+07wFScu++gMHRd0+ksIegDqUwu4YzUw6cOGa3T4GaC6oTVJ60lGlnWDbnyP0
         VS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSuUOKgzbaFtOItLmPS3HriQkJCw7N2xL3LhTiWah8OiEmoDeIfWspjcNjJpbZT3bXHJcNfAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsz3FWjLaH9H1Rl30+R824ldIGVHN5jV1GdCyjutfBUuzXUA6Z
	UreIq2zaomgyCgeXXBCIF5ytzrdsuVUx/xqXvnwHcQL+hA0yFdus/y09OuA8WMMy+W3uBWy5TmN
	92Q+5nYk6O5XEFhgu3cM6f/HVowy4dCvR3f6gahbbEBWbjNMrwRO0p7xC4fM=
X-Google-Smtp-Source: AGHT+IGedTH2QBuKvc3J4j2VcD1sXDTZmPkNAKOTJFCFhpdAuVp0IB8uceIkxdPI/HP8xg6ivDmGYdu/Z+BMC9gYXCmXBu/ezTdr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d1b:b0:93f:fca2:e548 with SMTP id
 ca18e2360f4ac-93ffca2eba6mr888267839f.8.1760928724506; Sun, 19 Oct 2025
 19:52:04 -0700 (PDT)
Date: Sun, 19 Oct 2025 19:52:04 -0700
In-Reply-To: <CANNWa05pX3ratdawb2A6AUBocUgYo+EKZeHBZohQWuBC6_W1AA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5a3d4.050a0220.1be48.0007.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	ssrane_b23@ee.vjti.ac.in, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/key/af_key.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7361c864 selftests/bpf: Fix list_del() in arena list
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11031492580000


