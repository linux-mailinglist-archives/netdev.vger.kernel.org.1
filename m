Return-Path: <netdev+bounces-212840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD14B223A9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60FA504BD0
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D252EA168;
	Tue, 12 Aug 2025 09:48:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3F2EA161
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992088; cv=none; b=RpZ9M0eGr/6qjoQwTTQa2hP0XDeJn04B6+0S3OaJJeUveePN+vTqN9cLnEXwRrtboo0rBfrBefXPmuaZLRBd4CQ4rpEX2f+T10r+H9GkFoG2Cca48aWqavat/0g4cut7kuZWb862SiQG3bwo8SKAuve/5JKedE6Y/E24Ownygok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992088; c=relaxed/simple;
	bh=tgMF8HuU+iL/6Y55dy6ba5v8RvxSKr6oTJYUTWCzqHs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kIz5OBWoIEyR7ABhy4MRM855flKGMRvdFoUGEW0z0rGdvD3qkvJvJiAQ8v+63dBNKbXsj+pWpwls49O/dBn0Q+fKHleFfQBoRO72mr/momOUBHDyTsrKOY7FZSWOU2kDT4g7Eu3t/ukh8XVNi3rgbwP/RA0qU6rZGrRatv61CLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86463467dddso534016139f.3
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 02:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992086; x=1755596886;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23s4cMMxaWk/6h2mIsslFjC/yj0rjYz/dHBx5jBiKdk=;
        b=JcADegOtDJHkmsRAGiIrgFt6mzPYN3s58KJlW4yS0cTZO8h1PbsSkE93dbm6IrDee2
         0TemoXwnHxI3UM2gFijW7PMuOqNxEaudYxOI2IZXip4Q93qJnn9RBkSnpSnIE21RLaFT
         d1OXU/VzPH9U2m92QOqQI906xeRN3RISbm8FwASrGk97oUr/73H9RWGenRmTouUcoUP8
         qvj4f5tWNhHfxHH/DI07mn6qNwUue91pY0/N6mt64b3g2WJ71ATSR13NoeHYNskAoMkp
         nDjTVLq7c4gXteuTHazXNVewYuyy8IT8WGbSXJexz/KfKyd3LPiWyXDXR+PBG4w3KFAj
         ucHg==
X-Forwarded-Encrypted: i=1; AJvYcCWJl0duZHMSPcYTnPz+k5LT4KioMaqsucLdXtIiBOZ53b1aeBT4oSFiIXJtbM6F2vcpO1Ck464=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+x74tIiqfMgC3+xPsIZu0v6Ze4L5FKk55zmKYB/b7MwIlB2a
	GVFf1v/tRoeyWa5r2TH5WkUhuRxsdmz+f2I2HGbz5aOUiPp692bJA7LusFzfZ8YKviSkhBufgdX
	T8Nvc+pQ3N9CpMEJfJB8sgIi1Bk1/9hP/kIQw5syjIqmwfLSmtHlpsbsffm8=
X-Google-Smtp-Source: AGHT+IG3SLQLj7KxZZEj1GNTliTbrGRu9ikWa+/cuwM6xZfm+k+wklil9CcAWSa+9Q7XgA8ywVi7c7dtP5+lK+hEKORoB3z1DYwc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1546:b0:881:8979:93f4 with SMTP id
 ca18e2360f4ac-883f127fca5mr3181687939f.14.1754992085862; Tue, 12 Aug 2025
 02:48:05 -0700 (PDT)
Date: Tue, 12 Aug 2025 02:48:05 -0700
In-Reply-To: <20250812052537-mutt-send-email-mst@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b0dd5.050a0220.7f033.0119.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
From: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
Tested-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com

Tested on:

commit:         8ca76151 vsock/virtio: Rename virtio_vsock_skb_rx_put()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15d54af0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84141250092a114f
dashboard link: https://syzkaller.appspot.com/bug?extid=b4d960daf7a3c7c2b7b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

