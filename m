Return-Path: <netdev+bounces-280786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCjvFRU16mk+xAIAu9opvQ
	(envelope-from <netdev+bounces-280786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:04:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC845412B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C49300D6AB
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD99E34A783;
	Thu, 23 Apr 2026 14:59:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580133246E8
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956389; cv=none; b=tTLJMOIxpXDE0KRa/Bht3QYar8pSd48UNKTgBZhyYg8dvdtlWy1mNWYJH7I2c5hBpSB9VK5ZUzLgr9OoCRGWvprl35wvgI/JAbUOtew1/7MkC1aBpjdyrEEuNLp+yxEDlWfqtvQ/yp9i86hVCUi0u7fAzfMZSQ9goiOjZW1SAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956389; c=relaxed/simple;
	bh=If6Mb/S1ZsOVfgxtDmu/wCQJemWSEhglJAFELaq7rbc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Q/I/y+p84lRjQ2t4re8TG0mFKsYZmBQ5HruK2j9nGm6BLZr9bB5drSoa6g6Lv9KsO7TQ66KDZVAZ6B//PsGVPiTo/U7rOPzLx45rCbnLlFcAgG2GpeeTXrFWPEQmO+XqHP3JsVPiUQCZMznXIYiTZ8RbOgCe5h6Izwh5J6+RcPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dbbb806e10so13877162a34.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776956387; x=1777561187;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1NlAwgaAPzBKKSxBGbiIQ9c9bd/h88zyiSOgY7aTWA=;
        b=IPpJL+uVa1Gck1/Sq3D1hlo5ri2s3emIlPdDfGZxk7F8eqPnHtTVbOVvzuBodOyu1+
         8Zjrfe7LVDnD6WlD+51E6bIOo4B2J+dHIfraua4bimx/hUEf90lEpjQ0/X5qBdz+0YG3
         VwKROgH4sPcTV0ahuZ6WPsbCXwUipwqrC4exmIC8+bwSzcovrWZ1i2vTl7d9v4rEeK6+
         HIuBVmJ1A6xfARlVowZCeyxlt+017PX4Qm0wkrMmnBbvsxGw9O4B/ulGOZtuLBxiMOg1
         M4DXGtBQDfb/dv5h0Gfb1x01tx8NmSgulkNhtbSAaRGJD+v5HyYqC/O+Vzff/jEoRbg/
         JtLg==
X-Forwarded-Encrypted: i=1; AFNElJ+xE5eUkVl3ig4/zcweGNVkpv0eE1dJexU5wgjVFWVarEtHUs1gJfrTzeolbfu7UscwZfIZCrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnG720ZZnCI2RkYiGhZSD9ztCBo0jVImlmmxiGrELUJSUglZyL
	G0rufruBcHDxrB75GkuDkBTV7c3akduP7z5dxKblbOe5EFL4nEmtm5zZ3eBde1HFZ7da3xRPEAA
	XU/MEDDAPFR/ZnJr3AYJohlEt0k4AKMKjz2U5aVO9sCrNJia6HRA1wtSMxtE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b02:b0:694:92fe:54f2 with SMTP id
 006d021491bc7-69492fe5782mr8923231eaf.56.1776956387278; Thu, 23 Apr 2026
 07:59:47 -0700 (PDT)
Date: Thu, 23 Apr 2026 07:59:47 -0700
In-Reply-To: <willemdebruijn.kernel.28284ffff84dc@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ea33e3.a00a0220.9259.002a.GAE@google.com>
Subject: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make_skb() when queue
 is empty
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: willemdebruijn.kernel@gmail.com
Cc: 25181214217@stu.xidian.edu.cn, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [4.94 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[stu.xidian.edu.cn,davemloft.net,kernel.org,google.com,vger.kernel.org,redhat.com,queasysnail.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-280786-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,xidian.edu.cn:email]
X-Rspamd-Queue-Id: 14CC845412B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Mingyu Wang wrote:
>> During fuzzing with failslab enabled, a memory leak was observed in the
>> IPv6 UDP send path.
>> 
>> The root cause resides in __ip6_make_skb(). In extremely rare cases
>> (such as fault injection or specific empty payload conditions),
>
> Can you elaborate on this? Which fault injection lets
> __ip6_append_data succeed without writing data?
>
>> __ip6_append_data() may succeed but leave the socket's write queue
>> empty.
>> 
>> When __ip6_make_skb() is subsequently called, __skb_dequeue(queue)
>> returns NULL. The previous logic handled this by executing a 'goto out;',
>> which completely bypassed the call to ip6_cork_release(cork).
>> 
>> Since the 'cork' structure actively holds a reference to the routing
>> entry (dst_entry) and potentially other allocated options, skipping
>> the release cleanly leaks these resources.
>> 
>> Fix this by introducing an 'out_cork_release' label and jumping to it
>> when skb is NULL, ensuring the cork state is always properly cleaned up.
>> The now-unused 'out' label is also removed to prevent compiler warnings.
>> 
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
> I think this is 
>
> Fixes: 6422398c2ab0 ("ipv6: introduce ipv6_make_skb")
>
>> Reported-by: syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
>> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


