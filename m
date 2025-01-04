Return-Path: <netdev+bounces-155191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCFAA01679
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 20:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9073A1766
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC8D1D5CCD;
	Sat,  4 Jan 2025 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YJ3bebBj"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280131D5176;
	Sat,  4 Jan 2025 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736017222; cv=none; b=B8lQZmHno5cHPlJ5W2y1PHlnUl1OnGVBpgfgE7QkMmtGyROZNtbCfKPocMaOOw/n3jKAivogXbwggcPYORaKC+oR5HyBJMYL5crROgI1f9q2Nzztv4ibZJsN8hGooTWcOLGWZxIvzJoy5BEymm+i2Y55fn+REovDm0qGMqehGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736017222; c=relaxed/simple;
	bh=azMUElIL4ozgZWTo19r4vYf8SzAi34HT9oXi2E3UfME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHPEDX46j+GpNXOtEx4KzNDUD3zTGtD0y1l9j6SXPClpNcbOj5putJKZbES3MwEUkbB80W8S+webDFFuLkbKd0qikOpyYUfjz2rtSXhGHt/bw262+iaRRBx1qUnd9LX3h3tYLzLFN0yfixP1M9jO0Wsg5Fos6x/flpvPwoQ2plc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YJ3bebBj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JKpzDmnENFeI1B+KTvPKI71GqeywiAuHZ4V3QFdTjHw=; b=YJ3bebBjavw8feTJrOM0njke15
	iyeSUuWWWtLBUvIDgSagMR8CYccMdSUPhobMZ1/WzdrskWFd8d2nfTFwGZ16aPOGAlWgip3rEpDX4
	dxWETb5H9/WmyUdieQPsCDrk9UELc3NLFOHW8FiLbAnDJHe6gM5LfHNcDQds02GwkpgTqoSI/jsdg
	Ltg0TC8JaCbtPyiY28VB7uE69M5IMwzcFmresutEXXieN+VI++gyEdgG7EDJxq+0NKD5qR8kbn/Xm
	Zl2uKu4sYMIIi4Dur8lwFMnf/9OMfNsiwlKiGA0IVJStfg3o6pRkUhfMlpEM1cReHx+wC6GPpFtJA
	OYO/oeKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tU9Na-0000000FRmN-0nhv;
	Sat, 04 Jan 2025 19:00:10 +0000
Date: Sat, 4 Jan 2025 19:00:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Dumazet <edumazet@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net,
	geliang@kernel.org, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, martineau@kernel.org,
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
Message-ID: <20250104190010.GF1977892@ZenIV>
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

... won't help, since the file in question *is* a regular file.  IOW, it's
a wrong predicate here.

