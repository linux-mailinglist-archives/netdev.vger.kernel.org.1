Return-Path: <netdev+bounces-162936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A88A28806
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645F63ABB5E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BA5230D13;
	Wed,  5 Feb 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CcmkXnBI"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B67122B8B0;
	Wed,  5 Feb 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751155; cv=none; b=tjyzFWZ04Caoa62WM1b8//vL/ZUPn1LamkKRACPTE9tfNHnVq5h+dhAvpEjblAlcB7dk80svmXqXhkSgS+69k1zvdVqz3tqxbZhgH1M9FteqJFuM21/hWDwXSn3CzSoHzXRZr3llDaH38R07NjXp9wSMarYS34nN6hLJDje09/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751155; c=relaxed/simple;
	bh=uTikdtqcwI70CYjt1eBAl6OBhR7bcW+BJKotwkv0YMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsED5G3SmMFJ/X31gbIjfxGfuJ1jbmqUY2SZ8dL53D6aJj8wT/x4SGvo5Rbwb7rhBgBMb9DsD2rihLZgQDqMsKXkRSYABXqK+bMiXxKG+hR4QJa1E4xnA/pyQl8WeNczlPlPHkdBtbIwlK9ef7um9dQS6egVp5evzVA9+dCmf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CcmkXnBI; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=CeLAvSZweSdrpa/u3kDJ87mrxAvNI6bzP9fmmM0QN+c=;
	b=CcmkXnBIzXBWq2qG4vmjOV4VHbVi11/CUvr2RxMrE07MBQO9niwbAPhSO6m0hK
	Ywx7SNPkQktVKBok01PGxGwJcEdDO3ke9aDzRTb6Xf41kng/gWTF6HA5QxBdiEbo
	rM/LW26hHFRDWFYE7H+ZiapntEMYpOAdPXEmzvJJ0WVWo=
Received: from hello.company.local (unknown [111.205.82.7])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXxtnAOKNnOb6iMw--.46599S2;
	Wed, 05 Feb 2025 18:09:05 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: kuniyu@amazon.com
Cc: buaajxlj@163.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	liangjie@lixiang.com,
	linux-kernel@vger.kernel.org,
	mhal@rbox.co,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] af_unix: Refine UNIX domain sockets autobind identifier length
Date: Wed,  5 Feb 2025 18:09:04 +0800
Message-Id: <20250205100904.2534565-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205082841.94701-1-kuniyu@amazon.com>
References: <20250205082841.94701-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAXxtnAOKNnOb6iMw--.46599S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr47CrWUKFW5Kr13uF4kZwb_yoW7AF4kpF
	WFk3Z0vrWkJrsrWr1Iqa18Arsayw4rt3W7CryDGF1IkFsIgryI9F1DKF10934Dur48tw1S
	qr4jgFy29FyDArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUIksDUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbiNhbqIGejLVKpngAAsm

On Wed, 5 Feb 2025 17:28:41 +0900, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> From: Liang Jie <buaajxlj@163.com>
> Date: Wed,  5 Feb 2025 14:06:53 +0800
> > From: Liang Jie <liangjie@lixiang.com>
> > 
> > Refines autobind identifier length for UNIX domain sockets, addressing
> > issues of memory waste and code readability.
> > 
> > The previous implementation in the unix_autobind function of UNIX domain
> > sockets used hardcoded values such as 16, 6, and 5 for memory allocation
> > and setting the length of the autobind identifier, which was not only
> > inflexible but also led to reduced code clarity. Additionally, allocating
> > 16 bytes of memory for the autobind path was excessive, given that only 6
> > bytes were ultimately used.
> > 
> > To mitigate these issues, introduces the following changes:
> >  - A new macro AUTOBIND_LEN is defined to clearly represent the total
> >    length of the autobind identifier, which improves code readability and
> >    maintainability. It is set to 6 bytes to accommodate the unique autobind
> >    process identifier.
> >  - Memory allocation for the autobind path is now precisely based on
> >    AUTOBIND_LEN, thereby preventing memory waste.
> >  - The sprintf() function call is updated to dynamically format the
> >    autobind identifier according to the defined length, further enhancing
> >    code consistency and readability.
> > 
> > The modifications result in a leaner memory footprint and elevated code
> > quality, ensuring that the functional aspect of autobind behavior in UNIX
> > domain sockets remains intact.
> > 
> > Signed-off-by: Liang Jie <liangjie@lixiang.com>
> > ---
> >  net/unix/af_unix.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 34945de1fb1f..5dcc55f2e3a1 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -1186,6 +1186,13 @@ static struct sock *unix_find_other(struct net *net,
> >  	return sk;
> >  }
> >  
> > +/*
> > + * Define the total length of the autobind identifier for UNIX domain sockets.
> > + * - The first byte distinguishes abstract sockets from filesystem-based sockets.
> 
> Now it's called pathname socket, but I think we don't need a comment here.
> We already have enough comment/doc in other places and the man page.
> 
> $ man 7 unix
> ...
> The address consists of a null byte followed by 5 bytes in the character set [0-9a-f].
> 
> 
> > + * - The subsequent five bytes store a unique identifier for the autobinding process.
> > + */
> > +#define AUTOBIND_LEN 6
> 
> UNIX_AUTOBIND_LEN
> 
> 
> > +
> >  static int unix_autobind(struct sock *sk)
> >  {
> >  	struct unix_sock *u = unix_sk(sk);
> > @@ -1204,11 +1211,11 @@ static int unix_autobind(struct sock *sk)
> >  
> >  	err = -ENOMEM;
> >  	addr = kzalloc(sizeof(*addr) +
> > -		       offsetof(struct sockaddr_un, sun_path) + 16, GFP_KERNEL);
> > +		       offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN, GFP_KERNEL);
> >  	if (!addr)
> >  		goto out;
> >  
> > -	addr->len = offsetof(struct sockaddr_un, sun_path) + 6;
> > +	addr->len = offsetof(struct sockaddr_un, sun_path) + AUTOBIND_LEN;
> >  	addr->name->sun_family = AF_UNIX;
> >  	refcount_set(&addr->refcnt, 1);
> >  
> > @@ -1217,7 +1224,7 @@ static int unix_autobind(struct sock *sk)
> >  	lastnum = ordernum & 0xFFFFF;
> >  retry:
> >  	ordernum = (ordernum + 1) & 0xFFFFF;
> > -	sprintf(addr->name->sun_path + 1, "%05x", ordernum);
> > +	sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
> 
> I feel %05 is easier to read.  Note that man page mentions 5 bytes.
> 
> 1 is also hard-coded here, but I don't think we should write
> 
> sprintf(addr->name->sun_path + UNIX_ABSTRACT_NAME_OFFSET,
>         "%0*x", UNIX_AUTOBIND_LEN - 1, ordernum)
> 

Hi Kuniyuki,

Thank you very much for your suggestions. I will incorporate them and
submit [PATCH v2] accordingly.

The logs from 'netdev/build_allmodconfig_warn' indicate that the patch has
given rise to the following warning:

 - ../net/unix/af_unix.c: In function ‘unix_autobind’:
 - ../net/unix/af_unix.c:1227:48: warning: ‘sprintf’ writing a terminating nul past the end of the destination [-Wformat-overflow=]
 -  1227 |         sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
 -       |                                                ^
 - ../net/unix/af_unix.c:1227:9: note: ‘sprintf’ output 6 bytes into a destination of size 5
 -  1227 |         sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
 -       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It appears that the 'sprintf' call attempts to write a terminating null
byte past the end of the 'sun_path' array, potentially causing an overflow.

To address this issue, I am considering the following approach:

	char orderstring[6];

	sprintf(orderstring, "%05x", ordernum);
	memcpy(addr->name->sun_path + 1, orderstring, 5);

This would prevent the buffer overflow by using 'memcpy' to safely copy the
formatted string into 'sun_path'.

Before proceeding with a patch submission, I wanted to consult with you to
see if you have any suggestions for a better or more elegant solution to
this problem.

Thank you for your time and assistance. I look forward to your guidance on
this matter.

Best regards,
Liang Jie

> 
> >  
> >  	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
> >  	unix_table_double_lock(net, old_hash, new_hash);
> > -- 
> > 2.25.1


