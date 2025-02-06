Return-Path: <netdev+bounces-163359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF0BA29FC9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FE2188A63D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF846189BBB;
	Thu,  6 Feb 2025 04:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c/ligPbZ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA5AA2D;
	Thu,  6 Feb 2025 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738817269; cv=none; b=d8hwWz3uCfOVZlFrqeO6BwRhcdAdJHJDM0OafMFddNFq3SR85Z/ySp7TKQnU6EiQgOhfzn3o5Iu+9xK7292OzBeGkepzgv/IFYK3pNIk+NaupJoGI038RjPVoYef/t3Qlos1aY6cpPxgFXRp62QB4PUeRX0WF81ZGQqvLl3KA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738817269; c=relaxed/simple;
	bh=zTJMwEQDpyIXC+zI5jGHk1tzEApj3e4XPeD9OYd7Hbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iP0N81v317GbNO2FNDmNi1Sg5j83wwSZylvWWqTdEVASwhhNVUFQu+brtb8HN8IA+wjrfdIDgChLWr1S2nQ6R/yIQhk7scnITZPxIOWH+wtLCisCULkKRVSiO+qUGQ1dPlJnz/S5MA6ibJjpcXdt7sc7TmxWZ/taEssC0OZ6Xh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c/ligPbZ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=lRCb1p6vbOS9wVnuLjOyk+RxFhhCPf08U5liQjx+Ork=;
	b=c/ligPbZKT3ELxH6dvS/O0XMkXlWSsAnBtfcwJn61L88hpVtujagHPm+GK0eEX
	SDyXAwbDirrX/FCPf/YmH51a7nWVliezZm7o0N0JFji0WqwYvGrozBQ4WklgHBpm
	8ThfZuckBNaK3xnd/68qJj2Fag+fSIZE8VI8oovwtvPwk=
Received: from hello.company.local (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBnr_RNOqRnkz4GGw--.7261S2;
	Thu, 06 Feb 2025 12:27:58 +0800 (CST)
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
Date: Thu,  6 Feb 2025 12:27:57 +0800
Message-Id: <20250206042757.3966975-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206040118.77016-1-kuniyu@amazon.com>
References: <20250206040118.77016-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBnr_RNOqRnkz4GGw--.7261S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy5KFyrCry8Ww1rKr1UGFg_yoW8Zr47pa
	y7t3W5JrWkJFnrtF4xtr17Arn0kw4fJ39xAF1DJF17Za1YgF9F9FnrKr1j93yqkr4Iqr15
	trWYka429Fyjva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUx-BtUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbiNgDrIGekLSi1UQAAsf

From: Kuniyuki Iwashima <kuniyu@amazon.com>,
Date: Thu, 6 Feb 2025 13:01:18 +0900
> > The logs from 'netdev/build_allmodconfig_warn' indicate that the patch has
> > given rise to the following warning:
> > 
> >  - ../net/unix/af_unix.c: In function ‘unix_autobind’:
> >  - ../net/unix/af_unix.c:1227:48: warning: ‘sprintf’ writing a terminating nul past the end of the destination [-Wformat-overflow=]
> >  -  1227 |         sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
> >  -       |                                                ^
> >  - ../net/unix/af_unix.c:1227:9: note: ‘sprintf’ output 6 bytes into a destination of size 5
> >  -  1227 |         sprintf(addr->name->sun_path + 1, "%0*x", AUTOBIND_LEN - 1, ordernum);
> >  -       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > It appears that the 'sprintf' call attempts to write a terminating null
> > byte past the end of the 'sun_path' array, potentially causing an overflow.
> > 
> > To address this issue, I am considering the following approach:
> > 
> > 	char orderstring[6];
> > 
> > 	sprintf(orderstring, "%05x", ordernum);
> > 	memcpy(addr->name->sun_path + 1, orderstring, 5);
> > 
> > This would prevent the buffer overflow by using 'memcpy' to safely copy the
> > formatted string into 'sun_path'.
> 
> Finally new hard-coded values are introduced..
> 
> I'm not sure this is worth saving just 10 bytes, which is not excessive,
> vs extra 5 bytes memcpy(), so I'd rather not touch here.
> 
> > 
> > Before proceeding with a patch submission, I wanted to consult with you to
> > see if you have any suggestions for a better or more elegant solution to
> > this problem.
> 
> An elegant option might be add a variant of snprintf without terminating
> string by \0 ?

Thank you very much for your suggestions. It's an elegant solution that
avoids additional overhead and neatly solves the problem. I appreciate your
insight and will incorporate your idea into the updated patch.

Best regards,
Liang Jie


