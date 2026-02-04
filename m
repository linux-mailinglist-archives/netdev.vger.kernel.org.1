Return-Path: <netdev+bounces-256606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iExjIhb7gmm6gAMAu9opvQ
	(envelope-from <netdev+bounces-256606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:53:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322CE2D8C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1ECC63004D2C
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C89638F23A;
	Wed,  4 Feb 2026 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgSXeK5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB719E98D
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770191636; cv=none; b=ulQ4B+OoMmhlqOpNkQA3UnY/pua2H9N1F9cdB6TJR4OWVHOLJtu0g28RLeaJKvrEBZq1NzVutjikpXURAw38qHXp/iZRbKz7639M6PmovmUmTEugnbYhW/tevj+htFB4f8EW92yEETAojKVHdbJm1GHjYf8u1cEtX6uhXHIDGog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770191636; c=relaxed/simple;
	bh=deSrgkODxQPpr1oSyoric1oNk8vow5CKgaxFEicnd48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xy0RtOtDFG1DvIVDWaPwoKBkFNOWGgwwEA7rk5T/rASNHQTK7z6yGE18xXS7jYzdSYPiNkXiJy7SRoHCVojGuV9m589Q6Nf4FmCDKiA183Lp7Yr++WMMjP1B+ruKzud8DgNrTcHz4+f6slwq3ZC/6Gb1SR34/pBBa0nFd1PxSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgSXeK5r; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b7da62b487so911324eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 23:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770191635; x=1770796435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A6EW3EVViAYvc52ZtU2GD042oNzF8OTzWWfQQFxFBs=;
        b=JgSXeK5rcoIrnFh1lBtTALOZpJgy4YJhNXi5mI3GxoiSL/LiGttuMhs4Cjuy5wtOEs
         d76FrNf8RYU99KfvjHbhEJHt6nqB4cSL/jz5sUe6m5YCkBh0gO+RP8VaagqMdcREn3pT
         Ci/GdqT442qbeZLvjslYKgY+eSudyZ0I3Nhx9PAPxY4b40/ZvOAM5tL4B75uYb+Wsvqr
         rU56X79hleG87axesS6a2CcaxQkN0jsd5kC3/o9jAeoYlfHTy+2X1c102ZDI99P8/adw
         P2I2Nl8uV8x1fTgqTeMifoWysLIazE6PTNWRznFySArhoO6Lz94E66B2kUFoURRqT0wP
         VIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770191635; x=1770796435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5A6EW3EVViAYvc52ZtU2GD042oNzF8OTzWWfQQFxFBs=;
        b=DrC8Kj1rEc65CcO6uLL6jV0U3yZFfzDzVZiYyM3ppXmbHYKkhxi2hluXG4GHuVeid6
         RbA7Z/vj+uQU0nD7jQoMuqvCFZnm/DiDpC4QYbisttACSxocneFJRHgXsUPApeFyQ8Oo
         ygokPHLBhONgtBGVsqNhBeiISHd9li+5N4mWQrx/46JLeryRX7YA4a3ZsRB5/VuH9ffs
         Er+IpxLY8NOUWXNQFv9u49vyfq4ONwwVkKhxObChqeWZubrh3DVkMHMirHtCxWFBZksA
         TO4umoRCoj5vWbRzWe41l+LQu72ys2MVixiaFMVeixpkMWWgcZrCAFnkDE1+YorHsl5T
         3Mkw==
X-Forwarded-Encrypted: i=1; AJvYcCWKqvSjuEmp/f9E65hqvma3x9xyOi1OwiNfe0gVcZoAepD48wz/7K77054jJeznXHTbpgnTMyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALRW5wzKtyvVngFqxDhZpKst2fRn81uLswrHDpGJxAchspNpP
	2UFnVQuiPNM/J5hVEWcf59NC84i/XUEdoGwwARLrBJrBgdQ+9GcrK71/
X-Gm-Gg: AZuq6aKMDMEw/skXexYdg9Q2h8Ang895pMgxNan0hF2iFzT/FVKAiFTn2KA05tQFEoL
	qzFCGQ+4wDFMNNdVKIM6djnkK/zvEbEXzF0JyRL4AYVwKcTZulJAmTb8loH427sJRrf9aqu2Rh2
	V5Zu6fmZIttpv85d0NzKcjSy+JBtaIOxw/GUIvVUR/mb4vXJBAwtVmMWeEz2Lwo43ex9IcKZoiM
	ZqQfKTSztw2JIKmIrnxKNtizSrOmXJyGFLouyoapBbrz9uc96JybpOyY6UcVj53xqg0F9svJ3Y2
	7CR98NQNKwXqQyQ+9zQySQ1baYeHhgPOPcNj8U03Uc4colpU0CwWZ5nRa4eNdVcCuMhjtuyTcU7
	hBM1JLfG1Ou+SHeByJeoA2Ob3yJeOaEp/0/pQNKocgNz3s1QVi7ksaVkfo1VGLA7/ZIszc4ZGWr
	4L4vM=
X-Received: by 2002:a05:7300:e7a1:b0:2b7:ef84:9123 with SMTP id 5a478bee46e88-2b8329d0045mr966879eec.41.1770191634983;
        Tue, 03 Feb 2026 23:53:54 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e12893sm1163577eec.7.2026.02.03.23.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 23:53:54 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: kuniyu@google.com
Cc: brauner@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	realwujing@gmail.com,
	sd@queasysnail.net,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v5] netns: optimize netns cleaning by batching unhash_nsid calls
Date: Wed,  4 Feb 2026 02:53:42 -0500
Message-ID: <20260204075347.3508631-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAAVpQUAcn5kAHE+FniMt-wn1iM3hP9L7L0VhQUzzk130i4X0zw@mail.gmail.com>
References: <CAAVpQUAcn5kAHE+FniMt-wn1iM3hP9L7L0VhQUzzk130i4X0zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256606-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,suse.cz,vger.kernel.org,redhat.com,gmail.com,queasysnail.net,chinatelecom.cn];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3322CE2D8C
X-Rspamd-Action: no action

Hi Kuniyuki,

Thanks for your review and suggestions!

On Tue, 3 Feb 2026 16:20:18 -0800 Kuniyuki Iwashima <kuniyu@google.com> wrote:
> batch and system is a bit unclear, maybe M_dying_net,
> N_alive_net or something ?

Good point. I've updated the terminology in the commit message to 
M_dying_net and N_alive_net for better clarity.

> Also, isn't __peernet2id() also O(N_ids) ?

Yes, you are right. __peernet2id() performs a linear search in the IDR, 
so it is indeed O(N_id). I've corrected the complexity analysis in the 
commit log. This actually makes the batching optimization even more 
valuable.

> Please put this in a hole, maybe after after hash_mix :
>
> $ pahole -C net vmlinux

Updated. I've moved the 'is_dying' flag to the hole after 'hash_mix' 
to avoid increasing the size of struct net.

> No need to move id up.

Fixed. I've scoped the 'id' variable locally within the traversal loop 
to keep it cleaner.

> This can be done unconditionally as the id will never
> be assigned to dying nets.
>
> while (...) {
>     id++;
>
>     if (!net->dying)
>         continue;
>
>     /* do cleanup */
> }

Simplified as suggested. The loop logic is much cleaner now with the 
unconditional increment.

I've sent out v6 with these changes.

v6 link: https://lore.kernel.org/all/20260204074854.3506916-1-realwujing@gmail.com/

Best regards,
Qiliang

