Return-Path: <netdev+bounces-243933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27295CAB095
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 03:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3F2D309F82D
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 02:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942CD26B2CE;
	Sun,  7 Dec 2025 02:59:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D280623EA81
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765076364; cv=none; b=aCXQjuaqpwM79pMDVg7LS14PNaQTTP9yRI1H/ABCBs+L7DfzEltN6FLP60hpoBVEX4fPlUOWea63tJgYp2/XcZl9BqflavAhenSj6XK59HdiGZ9YJ5kvEGDrMxkWI1XwzQU0TjpDR0FWPU12xYdcIcDVpCpJQz4kF3C8vcGYnGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765076364; c=relaxed/simple;
	bh=Zi6TiqK/9bDTVw686S7aEtl/nJKTJXZ9ZJtSr7KB93E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=o/rSrKpbG77hywdCiYd8my9Sf4ySt9SgGVMHEGJfGhNXN2BTMM9duvpHmQrtbYtbkflzBIGYS5TINJ266EMRHke4xAQEMZaUWWJmGuub5C2Oge2zJSpxToiMxK7EzW1wt3h9MMJl+vKZbZGD/nTcwXQezJ8i0uvE9yZkgooqNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c72ccd60f5so6115042a34.0
        for <netdev@vger.kernel.org>; Sat, 06 Dec 2025 18:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765076362; x=1765681162;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQV8+a1dqWcIdw9P+ryYbHE2x/xQEpwjDmzgyuk6iFU=;
        b=gk3nw6Abe/G5V2CfL8dkgQWHwM+tyvvygz0oT6E3Ga21+uIti6D2c481TvbnFZNKVV
         UpQozaK9+PtAaxMrRHMTF8C2cPnprvDJHILgsd0t9rmfDgfpZY7QOni/q9vU3h1NIMZK
         qzh2NROPNEU2mHaj0PMpRiW2WyBVpzhA/tE89zo5nT1plaUN+BjfnYCHP3095fd+DMFg
         UC9sOPhyKvWhW0gh6PdO2oWTSEOoLudmasGab5Fj/Tqnt3hBNt72/uXOhcRhiCBzD+mS
         sjQs9BdWGlKgEZz0hwrcee7yz00KwaiXMaiPjBo0iA10cTGxokT4lHD4Q1HbxoGM1a0Z
         FLPw==
X-Forwarded-Encrypted: i=1; AJvYcCW0gXqOAHrhfwSYKphf365nKU+I+/IIryaJ1cSyOqK4OuT5a+7bZgO0COOoQNHlW75vNn9T5P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgL8wkzmpgTuYrEMpFHU0XR3J0s2BKoj1kxThd5Ia2L1LA32tM
	SVsy4+fv3MXXimG6j4A/PwLMJvJK1CCcVRBWF+J8oo0MvemI9CKEeCpkYgPQDRO9h7aOln78+1k
	STgacDWGQccmFiUX/sRkoE/G9h8uMicLzQysKmBnpN5WXnyFBjKKvLQCBHO0=
X-Google-Smtp-Source: AGHT+IG9S6TkrHcKcjbICQQKvbBw/gtdoI66gkXgypJ+l1Jv3IkAtA8JymO0Dj3MxjTH77O6cl1slFlMn0/12Xs8sb9/ERFHFhIB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:200e:b0:659:9a49:9047 with SMTP id
 006d021491bc7-6599a8d51a5mr1554341eaf.18.1765076362030; Sat, 06 Dec 2025
 18:59:22 -0800 (PST)
Date: Sat, 06 Dec 2025 18:59:22 -0800
In-Reply-To: <20251207025807.1674-2-dharanitharan725@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6934ed8a.a70a0220.38f243.003b.GAE@google.com>
Subject: Re: [PATCH] team: fix qom_list corruption by using list_del_init_rcu()
From: syzbot <syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com>
To: dharanitharan725@gmail.com
Cc: dharanitharan725@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

This crash does not have a reproducer. I cannot test it.

>
> Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
> ---
>  drivers/net/team/team_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 4d5c9ae8f221..d6d724b52dbf 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -823,7 +823,8 @@ static void __team_queue_override_port_del(struct team *team,
>  {
>  	if (!port->queue_id)
>  		return;
> -	list_del_rcu(&port->qom_list);
> +	/* Ensure safe repeated deletion */
> +	list_del_init_rcu(&port->qom_list);
>  }
>  
>  static bool team_queue_override_port_has_gt_prio_than(struct team_port *port,
> -- 
> 2.43.0
>

