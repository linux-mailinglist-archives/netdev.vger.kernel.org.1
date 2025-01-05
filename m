Return-Path: <netdev+bounces-155266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A91C1A01939
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 12:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7B3188370A
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB461474CF;
	Sun,  5 Jan 2025 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="K4FE0h0C"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA0182D0;
	Sun,  5 Jan 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736076595; cv=none; b=B2SkvxDCslltMAhbHyXedMXRpqgRlZ8BN22xlc8PPnwUPHJ/0RJ747hCXwhzxgmZu1kYw9EsaslNFycot3YZG0N87PeQpctbx0Hpo99R7n/fPNybbML3dJYATABgZ8gvzgSoIs9fI+s/umoa5tda1HuFOSBI56ALo3sVCtmyJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736076595; c=relaxed/simple;
	bh=jQc97fg4KojjI1la88iIuV/bPNMe7W7Ss02Ow8E+fjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpV7kIEolO7yvVrMia1ow7Ixz5GiZ57QbjF5Y8FRv46dBq8yXBOJeGdtoS8ugsCSQsUgoYozUZ20KtRC80uyZplzn5wHZxIS8PM7S+dlwiWtix5+RlAJ8+oH/6wc3JlotXDE2YzGUiJPRpV4/7xfeh/IM6rOjE1ZtQYEzym6KKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=K4FE0h0C; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jQc97fg4KojjI1la88iIuV/bPNMe7W7Ss02Ow8E+fjw=; b=K4FE0h0C/K++e0AjhiWXif8i8D
	n45dASdKMtxeWVP1iu/nhtVVvIMj3QaxC2cse6qFRSJFEaOaBMonimfLSLA0octEb9zui4iuPP9Kz
	3ecLW/bcS98vYfI+OH0VEuRMfhbrAnmr5iQS3hnT7gl7Y9ug8CSfo4LOE9p0f7yM/mewksCFBmIXv
	DAJM9Q+vGeOJd53zs6ACpBnijBYU41dEeDFDvF5yNIArUWWHFuMuHkoxXitPB80ib1bOj6ZXXe7wc
	Aj7gy90UdHkgbYHlshQyEGLcxU7+xWu+qwCGzAqevMaJ4xzqTpUEvxxxmMAcODLErloUpkoqZVtEU
	SrYeTPQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUOpI-0000000FckR-3OjF;
	Sun, 05 Jan 2025 11:29:48 +0000
Date: Sun, 5 Jan 2025 11:29:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Dumazet <edumazet@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net,
	geliang@kernel.org, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, martineau@kernel.org,
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
Message-ID: <20250105112948.GI1977892@ZenIV>
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com>
 <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org>
 <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
 <20250104190010.GF1977892@ZenIV>
 <89c2208c-fe23-43eb-89ef-876e55731a50@kernel.org>
 <20250104202126.GH1977892@ZenIV>
 <CANn89i+GUGLQSFp3a2qwH+zOsR-46CyWevjhAQQMmO5K9tmkUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+GUGLQSFp3a2qwH+zOsR-46CyWevjhAQQMmO5K9tmkUg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jan 05, 2025 at 09:32:36AM +0100, Eric Dumazet wrote:

> According to grep, we have many other places directly reading
> current->nsproxy->net_ns
> For instance in net/sctp/sysctl.c
> Should we change them all ?

Depends - do you want their contents match the netns of opener (as,
AFAICS, for ipv4 sysctls) or that of the reader?

