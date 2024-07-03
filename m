Return-Path: <netdev+bounces-108837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9EC925E6C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9951C23C2B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C30A181CF4;
	Wed,  3 Jul 2024 11:30:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05321822C3
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006205; cv=none; b=eoL9KNU5yCjhvHvq+gOBGrnDbja1TkqfVxSJRi9qjztech5E3d5G0+NDs0WnjdzggCvSqzAN34RNVaA4kx31fCZVAjzyh3Kqyvc6t+RnThZPi6velHdrGR/Ms2FoK1ZJWjuvWY/48PGrlRqx/mYHkioG5X0tqqaRSqH5aXNwbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006205; c=relaxed/simple;
	bh=BfBH17VJtXddypEgWxOTCDyxog3F+1OJeoRSo4XyS88=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XRmlA8hOsbhmi0oH6nDLBMxNoI2mpkPCWuQ2leF+33mAQx9SMF2N62iKTTUQlA6gmJhp0A3QdO7CHDFXWsMnn1FWiUYJxeUqlF1YyAfGjwALwtkwCFTZHbOLcpiP8PE2iH9oHD8RIZBOTbx4FWSxgusHfhYH4CLjLqpuWAeL/Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3d933ce7dso606096639f.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 04:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720006203; x=1720611003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtDOwAyHfaH7yyD0GH2aSXDr9A+JGdnxgQykaBHcXN0=;
        b=AIii9redAYKV1hlZgvoG0drEdGbgxs3ElIHmfcBKqXlslvL14YoG28D0GWFuEQfmPh
         2BusoxCDITkw9NEZPJmwSG7zNXebidoztpjGb2H94bnaxNUDz9bRvNB+rx3A4dPHigvU
         tJmnbU93QgrNBar9CQnBHvQD+l8pR3HmGVoULYSifDBdIrfdZBfziGw8yyLp7hjwBF5H
         V0p0ao5naGhCy8PIC60eH8ilrWZwqdND2AZEa6XNvYcFNbepEuytYcXPE4bup64rmt5X
         hNZegBbwacg2EKfutyJo748fXy63U9/8yFdTovNzxAumXy5xSyxBNBfZuJjIvstCgV/J
         ODzA==
X-Forwarded-Encrypted: i=1; AJvYcCW0YGaxrnADVfKNVfgslhyeXsNqAiW5vreyXlR1qruHyCdbdsF9ghRB3rpD/Dwzjnv/ba2U4joyOhuJFF2rmQ00lTBvjaik
X-Gm-Message-State: AOJu0Yx5CSP4b2IvRLemGmvvpgqhFeN6WAHF+bbUppZs6MR19E2GiM81
	iwlukWdxbOabGseJuQOsZAolhFz9d/aof/8E2WZeO+eEyAIR4vcTuwKczsX5bX0AGHM/jEN4CU0
	Dd1PCvq8WjknwdLuxBfPm27EU7f72SMZ0ukbaQpyfRB3HGvKP82cgXwk=
X-Google-Smtp-Source: AGHT+IEIax5/D/dGA9BMfrVKPEvu7Yt1XPECp25e7JFAWps+K01mgYPk8aNZatnMgXBVhW/z5tyDzrI3AxSBWUzCt8yxku8lQpR7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12c4:b0:488:9082:8dd0 with SMTP id
 8926c6da1cb9f-4bbb6892d94mr1132629173.0.1720006202854; Wed, 03 Jul 2024
 04:30:02 -0700 (PDT)
Date: Wed, 03 Jul 2024 04:30:02 -0700
In-Reply-To: <ZoU1Aa/JJ+60FZla@katalix.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bba661061c5626c5@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/l2tp/l2tp_core.c
Hunk #1 FAILED at 1290.
1 out of 1 hunk FAILED



Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177064e1980000


