Return-Path: <netdev+bounces-155289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44001A01BD8
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 21:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C72D162927
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 20:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9334974068;
	Sun,  5 Jan 2025 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q5rStHMR"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE925949A;
	Sun,  5 Jan 2025 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736110261; cv=none; b=R9/aNYvXD4it7c/xk7m8c7dmKpiAFhFyz0gAMJIgdDNhk5yBYqSRDilFwOYqNiKJ+QeI0sHODioEDH0In/VyxTbEkvDTF0d+xXOHvlqGxhHoRC3w2QJJw9hcKRT52MBIZz8YpOmy/pu7PKb86tzzuMtCB4LxMibn5K+1fCMTpFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736110261; c=relaxed/simple;
	bh=EPse042UUeIfh1/Xk0/Dus/IQzUwU0c9AFKwBDtxl+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5C5mXryfnQuD4pjAYNT7QLWgsdJYiUpdsyMxel5PsXds2EWBdQDXh+ictU+p6j/SCtpZRJjxwERH1iM3YezF1VBk4rdTeHE4AV8zifRMoj8gAELVPaHKFzXlrj4JUsprz4qCvFHxfNeYZNUu7lJNteVdQBODc1+sNSTghgRr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q5rStHMR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=odL/7VRs88UUO8RamaqZ8On3HuXIHSZ9pipNRIAADSk=; b=q5rStHMREdsvCZFXwb5JOyEqwa
	IpBpVDUvAlbl6q/TqsjHRAswsZTXUe2SDe+mb93WoSc7Laqg5aeb9wtPQTYRxtnkLpibrNop6J4ML
	IsyaHs4m62leraKm/7ufXoCZa9DSYvkGtEn/Z/5NSqKBZWXyWtrF88EyU59hQROcu1anASsqyTRTV
	bGOIEOoPgAGG6DxD3dRE8u/RifXASzOcKVXbTH8ItnaANEqY1XEGji+kzOX/zVriTC/QoEhs5RrC7
	BbgF68okKauAMTqHGI38VrAGiQ10DGHbgnu3aYxCfc6U6T9tTJxG/POmHQP/LwSiw62GRZ9KhX5nH
	QJiC22+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUXaK-0000000FkHb-1Wht;
	Sun, 05 Jan 2025 20:50:56 +0000
Date: Sun, 5 Jan 2025 20:50:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Dumazet <edumazet@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net,
	geliang@kernel.org, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, martineau@kernel.org,
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
Message-ID: <20250105205056.GK1977892@ZenIV>
References: <CANn89iKVTgzr8kt2sScrfoSbBSGMtLLqEwmA+WFFYUfV-PS--w@mail.gmail.com>
 <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org>
 <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
 <20250104190010.GF1977892@ZenIV>
 <89c2208c-fe23-43eb-89ef-876e55731a50@kernel.org>
 <20250104202126.GH1977892@ZenIV>
 <CANn89i+GUGLQSFp3a2qwH+zOsR-46CyWevjhAQQMmO5K9tmkUg@mail.gmail.com>
 <20250105112948.GI1977892@ZenIV>
 <CANn89i+L619t94EybXKsGFGQjPS7k-Qra_vXG-AcLJ=oiU2yYQ@mail.gmail.com>
 <20250105195434.GJ1977892@ZenIV>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105195434.GJ1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jan 05, 2025 at 07:54:34PM +0000, Al Viro wrote:

> So I suspect that current->nsproxy->netns shouldn't be used in
> per-netns sysctls for consistency sake (note that it can get more
> serious than just consistency, if you have e.g. a spinlock taken
> in something hanging off current netns to protect access to
> something table->data points to).
> 
> As for the mitigation in fs/proc/proc_sysctl.c... might be useful,
> if it comes with a clear comment about the reasons it's there.

FWIW, looks like we have two such in mptcp (with sysctls next to
those definitely accessing the netns of opener rather than reader/writer),
two in rds (both inconsistent on the write side -
        struct net *net = current->nsproxy->net_ns;
        int err;

        err = proc_dointvec_minmax(ctl, write, buffer, lenp, fpos);
        if (err < 0) {
                pr_warn("Invalid input. Must be >= %d\n",
                        *(int *)(ctl->extra1));
                return err;
        }
        if (write)
                rds_tcp_sysctl_reset(net);
will modify ctl->data, which points to &rtn->{snd,rcv}buf_size, with
rtn == net_generic(net, rds_tcp_netid) and net being for opener's netns
and then call rds_tcp_sysctl_reset(net) with net being the writer's
netns) and 6 in sctp.  At least some of sctp ones are also inconsistent
on the write side; e.g.
static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
                                void *buffer, size_t *lenp, loff_t *ppos)
{
        struct net *net = current->nsproxy->net_ns;
        unsigned int min = *(unsigned int *) ctl->extra1;
        unsigned int max = *(unsigned int *) ctl->extra2;
        struct ctl_table tbl;
        int ret, new_value;

        memset(&tbl, 0, sizeof(struct ctl_table));
        tbl.maxlen = sizeof(unsigned int);

        if (write)
                tbl.data = &new_value;
        else
                tbl.data = &net->sctp.rto_min;

        ret = proc_dointvec(&tbl, write, buffer, lenp, ppos);
        if (write && ret == 0) {
                if (new_value > max || new_value < min)
                        return -EINVAL;

                net->sctp.rto_min = new_value;
        }

        return ret;
}
has max taken from ctl->extra2, which is &net->sctp.rto_max of the
opener's netns, but the value capped by that in stored into
net->sctp.rto_min of *writer's* netns.  So the logics that is supposed
to prevent rto_min > rto_max can be bypassed; no idea how much can that
escalate to, but it's clearly not what the code intends.

So I'd rather document the "don't assume that current->nsproxy->netns will
point to the same netns this ctl is for" and fix those 10 instances - at
least some smell seriously fishy.  It's not just the acct(2) weirdness and
the damage may be worse than an oops...

