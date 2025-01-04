Return-Path: <netdev+bounces-155195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603F6A016AE
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 21:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233AF163319
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDAC1CEAC9;
	Sat,  4 Jan 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KNmqr+SG"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89A414375D;
	Sat,  4 Jan 2025 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736022091; cv=none; b=L14W0MGuw/FFDKvXIPdNatmvjSBoSPheNvZrhXakgVDS82BS7Z91xMjE9MP2egnz4Ny0Q7ENxM0dVBLZpNx3dK3QQz4qA7b+yCBqmrRnhoqi+xPr2aowykGEAG/eo1kp3+AbbZ7sDR8H6Eg1DbH7yg/hr0ODl/hI2hYfpUQ03cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736022091; c=relaxed/simple;
	bh=rfAkhAT/flUeJOemt0s1Zfa3+ZByOWShxvrRDXG6+M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUaYTvWnG4JzWOXYPR9BgvzZW31qbidv1XjY/NI37mN1p74v4f655GBkK4M1s5Xy76vHlkg53+yMo5npR52jsdQ5lkCyYaSYVYpeL9NQEukkjzep4XvHAv9Ls/lnCJjEBop6Ypx6grb11YEsS/Kr2d738ppoOSzG5ppzjJmAt7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KNmqr+SG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w9oUiFmqul/r3wOotMT6uDwy2H7wyiDNPmva6iRvnLQ=; b=KNmqr+SGfhihMgd5OqIJwtoo/u
	GW1rpz9GR2ts42vhbgMNNloKUJHp+vsa5xEGFyHpiYIs3uzOLNJsJY9oy90pklAdV5P+XZVDArf3C
	1SG64OCamGLMJKHhtJwCa2UB/U0yYsp/tLebbPy98sFFRKkTmr6yg9PCnX6HF4WBI4P5yE9/IUipj
	+2PJFA6IgQMckqU2E4U+IpJ5uVb5YwGbTTU5CJHexSLuqs30KxxkFgywp8Erstst+QJO2ECA4BaEd
	g4Fe2ZxxgwUgYkzH4WaW8ZSkdIC8TodOG52RUqVyMjNbzX1/UoVBKJR24KX6+7HIPDRF9temU9Jaq
	617H3f5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUAeE-0000000FSc2-3EKs;
	Sat, 04 Jan 2025 20:21:26 +0000
Date: Sat, 4 Jan 2025 20:21:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
	geliang@kernel.org, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, martineau@kernel.org,
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
Message-ID: <20250104202126.GH1977892@ZenIV>
References: <67769ecb.050a0220.3a8527.003f.GAE@google.com>
 <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org>
 <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
 <20250104190010.GF1977892@ZenIV>
 <89c2208c-fe23-43eb-89ef-876e55731a50@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89c2208c-fe23-43eb-89ef-876e55731a50@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jan 04, 2025 at 08:11:49PM +0100, Matthieu Baerts wrote:
> >> +       if (S_ISREG(file_inode(file)->i_mode))
		^^^^^^^^^
> >> +               return;
> > 
> > ... won't help, since the file in question *is* a regular file.  IOW, it's
> > a wrong predicate here.
> 
> On my side, it looks like I'm not able to reproduce the issue with this
> patch. Without it, it is very easy to reproduce it. (But I don't know if
> there are other consequences that would avoid the issue to happen: when
> looking at the logs, with the patch, I don't have heaps of "Process
> accounting resumed" messages that I had before.)

Unsurprisingly so, since it rejects all regular files due to a typo;
fix that and you'll see that the oops is still there.

The real issue (and the one that affects more than just this scenario) is
the use of current->nsproxy->net to get to the damn thing.

Why not something like
static int proc_scheduler(const struct ctl_table *ctl, int write,
                          void *buffer, size_t *lenp, loff_t *ppos)
{
	char (*data)[MPTCP_SCHED_NAME_MAX] = table->data;
        char val[MPTCP_SCHED_NAME_MAX];
        struct ctl_table tbl = {
                .data = val,
                .maxlen = MPTCP_SCHED_NAME_MAX,
        };
        int ret;

        strscpy(val, *data, MPTCP_SCHED_NAME_MAX);

        ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
        if (write && ret == 0) {
		rcu_read_lock();
		sched = mptcp_sched_find(val);
		if (sched)
			strscpy(*data, val, MPTCP_SCHED_NAME_MAX);
		else
			ret = -ENOENT;
		rcu_read_unlock();
        }
        return ret;
}

seeing that the data object you really want to access is
mptcp_get_pernet(net)->scheduler and you have that pointer
stored in table->data at the registration time?

