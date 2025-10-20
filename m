Return-Path: <netdev+bounces-230992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46735BF3304
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 21:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12A944F8089
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98782D8DD6;
	Mon, 20 Oct 2025 19:23:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0C22FDE8
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988185; cv=none; b=NPyRkVH0oKuySxvI0Nq/+cUtjoSWqaKE9FKt50I29Pp4QXAzyASePitkdz5zXEqxA6ZidmYocI7/Sipt09+AJwdoSXtczdyIIlUx2ZYq2rJiHw382gvbrYCQfhpPesfBRdSaYSyqvc/QN3DjskgngkNze2QgC6t+vRY9QPttNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988185; c=relaxed/simple;
	bh=B0v7xqzbrARLzoXePEoiMvAUbWMeteOyLqaDChJa7Bk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s3DHw5Jrm61x6LNxyZ2MqX6r8AUgfuJONLcF5srRVWUqLKE6fI/Dm6Cu57v8A7lgASlOx4UuUY8MX2T0mNXTC1yiRZ+hFSqv6sneSmJODiKBsgokKGTz43RjtEhITu9YC2dGMBSS9Yj6KTfzHnKBMz0t8a67tPgnx5a5R0j633U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e86696bd9so286894539f.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 12:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988183; x=1761592983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx5+jMfXS8QttnO51LCTqUVXKqKMLZYlDxYkmZC2KJ0=;
        b=vijsrWBT6/tlkU3K+nBvZOI8DlyzTqG5ZfDWHhR7a3KPiigqZuLF4hOWkPE/MbP03o
         2zNn0BQQEndvyLKsxIs1TNdKIJvtLx6OBMC1GVm4ptxsbrvrpsyJtADvQVl4rojTD+ij
         OVmrEc4Emo/U4kAoNghmSekO42mRtx966G98zd89TqhuwGrvMPyN3xQ0f2wxuKAqj+pT
         qDnlkwqwWwUFeBf81bJA8o/LwHBnJfRgK0Gegm0uRr60C76NDyg4JdpegHzimZLcPEaM
         Rn7njPVieJAMtqVCPgVHs6u+2ayNeeqzc/QCd4bUw4XGipM/BQddLaNGWrm2C017LtkB
         RbSg==
X-Forwarded-Encrypted: i=1; AJvYcCWUG7JhnEEtW7QvWDH6xm0m3Wsk2vKfR4yIZ9V5VeUKeh1KLbAy/6DWoU+O4HZ4aU6tCwJtt/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Zol6jV7c1YD/LssZBKuxdeODdwFmGtVnc1y1MKH+HPrZY3jo
	zSwBsIiGKmVJbrxP85gzri68JwZwcLqrSoqigFs4qFtE4VPSBqwE1BIhWoN0UYvWilgNrFodxBB
	v875mWmkraQprOLs4Mk7z1YqCBDYf/4v2PlOPN63pVKborqhbbDLlppm9rN8=
X-Google-Smtp-Source: AGHT+IFiF2OvAuC5QiClzfK5zQLICkuwY9oBGpgO4Iv+mjNYaRXnNM8sd6VyjYsy7j6YhUc3a3RsitQ70ua24+lFfcnUI0x44h/n
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c2:b0:936:eded:d78a with SMTP id
 ca18e2360f4ac-93e762b3ac7mr2214491539f.6.1760988183172; Mon, 20 Oct 2025
 12:23:03 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:23:03 -0700
In-Reply-To: <66f49736.050a0220.211276.0036.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f68c17.050a0220.91a22.0450.GAE@google.com>
Subject: Re: [syzbot] [wireguard?] INFO: task hung in wg_netns_pre_exit (5)
From: syzbot <syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, andrew@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	davem@davemloft.net, edumazet@google.com, hpa@zytor.com, jason@zx2c4.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	wireguard@lists.zx2c4.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d4dfc5700e867b22ab94f960f9a9972696a637d5
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Tue Mar 19 23:38:49 2024 +0000

    bpf: pass whole link instead of prog when triggering raw tracepoint

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ccbc58580000
start commit:   88224095b4e5 Merge branch 'net-dsa-lantiq_gswip-clean-up-a..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=142cbc58580000
console output: https://syzkaller.appspot.com/x/log.txt?x=102cbc58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=913caf94397d1b8d
dashboard link: https://syzkaller.appspot.com/bug?extid=f2fbf7478a35a94c8b7c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10796b04580000

Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Fixes: d4dfc5700e86 ("bpf: pass whole link instead of prog when triggering raw tracepoint")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

