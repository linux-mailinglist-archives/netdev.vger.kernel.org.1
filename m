Return-Path: <netdev+bounces-179676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EC0A7E169
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739403B620C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA211DC04A;
	Mon,  7 Apr 2025 14:17:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF017AE11
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035436; cv=none; b=lvJZoYo1t2vD31O6nb8sI30B8DV/gCTqP0qXQs55eUQtI0gsGpkNTgiyCdIrm0vVcb8eEi/19vVI7ENK04RFeb35poh+4YcqMSB+d6utbgBM9t1LpFtWZ4V208lmgbscwN0RhfLkodGxq4NFBKbpMq2EoMN/OogZ6UadF3uwUVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035436; c=relaxed/simple;
	bh=u7xBi8y8quGJVDkuhH0qHYxgViZkg+uXeLe/8fr0ctU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=sMW7Ud1CYedk6mOb/SIGwF7Scb595afev/OQ+ZaLR2iWjJkFReJyAbc0BpADfeNDJ9I2f7LvwKisSV0hAREr6z5YXKkKFdn5xQuCkqQV145pjJBHzWklKKH2YY5Vkyyb0Tqe3y1RwSMJAvQk9F/fMPhn8xRJYKZhaTp/rMH9fsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b4ee2e69bso489367439f.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 07:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744035432; x=1744640232;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uaNP5LiQosFTE3+99qu/GfFM+fsc9WqdSZxMpRvfLk=;
        b=eakfcoz5GIv2/Nt+eghHC7MQgngT95m6qCRjZYLrwDjOjMoej9rtS3zdozqX3r2FwX
         Ev7g3TpM22WNqxi9k/O5VORmSqORB8LwrVqES1UUZEZqIwXSWdS6rqP8nxgwF8GqkrE1
         criQATqdK6QgVzZJPm56bofJqQwVRVN3jqfdCusvTNockc/Q5g1MxTtJsTl9Da4B/nKZ
         9WNZH9osfDW7SYjuytli1u1zsaSAxXvr5gD6wa76PIyXNGRywRNoJ9Er9Gw7fL1tdJp2
         0tWX1jF6oM+QriGI04T5nggguhSWRnpFDNKXdeQwI4ettVzV2bA2rdW3KkbendLjTkYN
         i/SA==
X-Forwarded-Encrypted: i=1; AJvYcCWxJ69Agbpr6mSJqAmDh+6dvYOcNID7J1OB9oL0816VsS50On/Atc908mS7/dzUCsMxqv2lShw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwusOGfSNIm7Ro6BKZKRMQHBRsee3cMSNcTM4s72B69l6O//AQM
	bAvszaCvF1uAmUK3AUMXUqB3pskjCKdPBzdOPZhMNTK7bW2LlQBnjVVoL0n4/DV/LxUya+kCiYU
	He+w7DgphPOnJWmJjxkFdSd3pI3nbTzH9/04oOjrksFhxwmI703ga33o=
X-Google-Smtp-Source: AGHT+IE4CIzkVeo6NDC8dq8GCEK3Bm8+KBaaoCschs0czWHzY8PZIOmO1Z5AnKypOkUFkYMIyeOFb/wYjaRSjp0Bia06IV0yyJEQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4401:10b0:3d4:6ff4:261e with SMTP id
 e9e14a558f8ab-3d6e3e67eacmr87122795ab.0.1744035432461; Mon, 07 Apr 2025
 07:17:12 -0700 (PDT)
Date: Mon, 07 Apr 2025 07:17:12 -0700
In-Reply-To: <20250407141705.92770-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f3de68.050a0220.396535.054f.GAE@google.com>
Subject: Re: [syzbot]
From: syzbot <syzbot+29fc8991b0ecb186cf40@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com
Cc: andrew@lunn.ch, contact@arnaud-lcm.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> Author: contact@arnaud-lcm.com
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

want either no args or 2 args (repo, branch), got 5

>
> diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
> index 644e99fc3623..520d895acc60 100644
> --- a/drivers/net/ppp/ppp_synctty.c
> +++ b/drivers/net/ppp/ppp_synctty.c
> @@ -506,6 +506,11 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *skb)
>  	unsigned char *data;
>  	int islcp;
>  
> +	/* Ensure we can safely access protocol field and LCP code */
> +	if (!skb || !pskb_may_pull(skb, 3)) {
> +		kfree_skb(skb);
> +		return NULL;
> +	}
>  	data  = skb->data;
>  	proto = get_unaligned_be16(data);

