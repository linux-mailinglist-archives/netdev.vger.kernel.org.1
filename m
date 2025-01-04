Return-Path: <netdev+bounces-155194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ECEA016A3
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 21:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DC1188436F
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 20:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3EA1D5CE3;
	Sat,  4 Jan 2025 20:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="T/sLkKKO"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D661D5AAD;
	Sat,  4 Jan 2025 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736021359; cv=none; b=MGmrhFWM0H/luhM3I1bkq9qBN/mPz92vMjECO0TQ/Qcenx67CPDWDjR0zZFqzfsVmAWxpKi2kVsFztdkMX4piDYAbNUiX1vvjVOOzreAVXu+C4BNedFyxpHKrkyxraNLWyYZCCz9tAo/g3yzaCGpenxar0qbRCIOVWKQ42+T3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736021359; c=relaxed/simple;
	bh=gPVzcGzPXO3iLkwWDIEk//xw/N/0OLDsXqHp62aMQQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h06wEQ6mvs+OCRCO6M4V/ozDcwh0NqVdJxJ8bYMwHag7KACapslUxiz+HLJJvwDUzwvWH+LHG4dYWNvSaOtYXn4rRlXE7Nv2imnNO4S3rM4HoS5S2ab9XfrVixf1YbI8Ao15YDtCEDEMMXNR1cjkfJuJ9wGaL5wIyD2kIRDbHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=T/sLkKKO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rVx62+cGBdXxpmQn1BCn99jG2TQ01IHShmdvXj0qBdQ=; b=T/sLkKKOwmyMUZL6JXAOF+VljC
	J3R0Zl1acc/FBkXIWVnOZNi0EvMDtEYw5toT15B16hcZH1FuJw84rGMM9Ecre18JzYtrPQiq35bSf
	2b4MBVyc6kAbVmFaozto340D861zy3fLkw8hkmvBn/T1ca3j7w4TIX+fP5HXQ1kuCItsx0fct7ckq
	1d9kse/QB3xPqRwkQALq4nPgUGo9jUxL/Xq3j2FAWhOill8hD5kcBB0tIHu3/jbgtDd+a5pyeJCv0
	YP2UhnKlkidKTOTSdngwosxiVyXrqbYWAP3NRNnWsHWm9NON7mKNO0OHfxWbK3qb3eAkD+SChzwZA
	gr96R8lw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUASP-0000000FSTm-1KX0;
	Sat, 04 Jan 2025 20:09:13 +0000
Date: Sat, 4 Jan 2025 20:09:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Dumazet <edumazet@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net,
	geliang@kernel.org, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, martineau@kernel.org,
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
Message-ID: <20250104200913.GG1977892@ZenIV>
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com>
 <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org>
 <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jan 04, 2025 at 07:53:22PM +0100, Eric Dumazet wrote:
> I do think this is a bug in process accounting, not in networking.
> 
> It might make sense to output a record on a regular file, but probably
> not on any other files.
> 
> diff --git a/kernel/acct.c b/kernel/acct.c
> index 179848ad33e978a557ce695a0d6020aa169177c6..a211305cb930f6860d02de7f45ebd260ae03a604
> 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -495,6 +495,9 @@ static void do_acct_process(struct bsd_acct_struct *acct)
>         const struct cred *orig_cred;
>         struct file *file = acct->file;
> 
> +       if (S_ISREG(file_inode(file)->i_mode))
> +               return;

Wait, what?  OK, that will stop attempts to write there - or to any
other regular file.

If you modify that to
	if (!S_ISREG(...))
you seem to have intended, it won't break the normal behaviour but it
won't help with sysctls.

