Return-Path: <netdev+bounces-228976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC75EBD6B32
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2260F18A8125
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B312E06ED;
	Mon, 13 Oct 2025 23:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881792DBF5E
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396886; cv=none; b=HmxHksYNkUZWjV/i9BkjmRK6cP8Vl6JdT0pPZhqRhC1KQESMC/hqb47m7xPglusTemA02CgdsD0uWF/kCbCuo0waSLRhMdNlsf38pa2OM4pvmOZW2k0Vc+WD/TvAxmVv1IL3ZoHGQgguqzWbOYZpCGKVhe2yCJyiPO2iMKUT3x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396886; c=relaxed/simple;
	bh=zBkQ478+K36LSAkcSZveJY7rGORBRmRQ/doT42pp2j0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NpOqAIXVTr/zTrHpjX8eYP5iIcu/lJr/TOv0DvVSiDHhghavct/rrfOGWEQt3R9i7n/MqeDWCdk/ZjiZlDL3eXQ3dsQxw/f9AMIod7xrKOVpuGTczJXuiigCjxxh1QvbrLcKDdNZVc97Usq/CRtObeuO/CLHkbuE37NZy9FQjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-927b19c5023so1091209539f.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 16:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760396883; x=1761001683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pib7/Bm8IHc8byFCcc/QM6HccOi/uWbIhJOPyumbLsM=;
        b=X9aJshA8KTyEzZw6Dv4c/pcy9ROxQqWkOpf2NNIzJDyZl012osa9wESy09QUyQetjq
         JSrTfZOmAqt/Nv+98FDJn7SgOP9qmRerZ+gRc7rpFyQwr6jSluHSs0uLPGo+dEpiuaxD
         afW2q+eIvJMbxhiGUkCIkuwQ/h4fbcvr++YCIh4M/k1QqiM0MeCLjxwYHfNKEcSUbu8o
         wkal/ZBPxO92eRC3CjUte2HDbhWSc2bE/4PE6VJ9doawNEJgTxLi/LHzTSnwgLP8f7Ji
         0yUAkHuJ9CYINS7y9ob3OYibI59wCHqqxa1bbSibum+buyk27fTVpsfms5VuSI2F6RiN
         LJPg==
X-Forwarded-Encrypted: i=1; AJvYcCW23Ysjx14NV5FCCHth+E4NO6qz3qTZVjJ3yytE531AOlYseL4uZAty1IPSFsk1ybP+dZDLIyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfS2S3++pTOZlyBzTL+dVaBJnRtQIOsmQPFG8c8LoSmNTBy8SC
	ItxczFrNZj4zu6UIfUvYuo4LT99mKRlUT4zeZkKaPaI9UiCxmfTpAkCEthudBVnWCQk8npxsdTB
	YlZ1a3to56mEAfD+5PB0NjZprEHGmV8cdDd8g+Hx+YZ73fMc7fpGBJCflrwk=
X-Google-Smtp-Source: AGHT+IF1JY+z/v2LYh/2NcQyC5wDhxLgFoy4Ufrd207fFcOMHaNDZZlrf0z4nqfVA1AG7+lmvnD5+3o4f/29P8RdKW0td0sULMwm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1648:b0:420:f97:7446 with SMTP id
 e9e14a558f8ab-42f8742055dmr208018735ab.22.1760396883666; Mon, 13 Oct 2025
 16:08:03 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:08:03 -0700
In-Reply-To: <CANn89iKbof0PsFsPgdhMFeizu9uEkgmqWSQggDQ8EXA5jfxMRg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed8653.050a0220.91a22.01f2.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (4)
From: syzbot <syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/ipv4/udp.c
patch: **** unexpected end of file in patch



Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=999eb23467f83f9bf9bf
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a479e2580000


