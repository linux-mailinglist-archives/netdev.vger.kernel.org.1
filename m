Return-Path: <netdev+bounces-155290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF6A01BF2
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 22:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBD53A287C
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76C1CEE86;
	Sun,  5 Jan 2025 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p3XX0ywc"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840337711F;
	Sun,  5 Jan 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736111523; cv=none; b=OS+6We/vbiiFVWhncpIYtDungpcc2gBerO27zgM6HBHgEutw88NhMXsODrCbZhwwasWGygBwVZ3QywKjwef8xL9oN9qYoLI0XemirHYOgycVSlbzuqM20RfRVHcWh3leXiWp6builtaJqS3J4eTevfpyygheH398lTNOeMMiP74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736111523; c=relaxed/simple;
	bh=ZhWfctKgj3qtiYBCml9s6phLQUjTI8M/o71PsEeqG+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTRoVoKNXhIjlIZp6/t08mZui5f8LfOfylXG3+wg7sBvLiEIhoWE+62iAUgXhhsKF3CZO0b7KkqOP8qcuQdEHZ9H+v/Tb65Fm9nlpaPMRdobtcg5g8Hqs3JRWQ3AepV1v8grdAMNLTR+NtxnoDgtAzYGgZv46d1OqaxHikjlYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=p3XX0ywc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xYbb/ENgYiAn0WyfxBAKuMrqKO3qIsDuoI9BH02tWmM=; b=p3XX0ywcuMGICeez8Wf/eWYfvM
	j4dy75A2cZTmxJGJOuApqRgm+OGJ9mNAJPMqK5rAgWwilnWbDP6PAXuodBmhDZiDwEzJ2/5uQP78y
	Si8VP0cXL9lkQ0NE5mu01Sibfs/p6Nt061Zr1WTfVphQKtyqXS6CtoLrACXwePlPj6RF6l5WYZEn5
	jehDn4ADWEjo94ArKFlbuoYFmfQjavsesixe0Ztd59seKb/GsDUiaG+C/vdqK7dNQUkLteaqdTa7v
	3kKgYGscY76VpErMGU78vg2i5Rw4raMxMdKsN/iY+jjubIYktX+rQbqej54E48KcCES5v4ti0ONGx
	SKJEWhgQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUXug-0000000FlaX-2Coe;
	Sun, 05 Jan 2025 21:11:58 +0000
Date: Sun, 5 Jan 2025 21:11:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eric Dumazet <edumazet@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, davem@davemloft.net,
	geliang@kernel.org, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, martineau@kernel.org,
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mptcp?] general protection fault in proc_scheduler
Message-ID: <20250105211158.GL1977892@ZenIV>
References: <cf187558-63d0-4375-8fb2-2cfa8bb8fa03@kernel.org>
 <CANn89iJEMGYt4YVdGkyb-q81TQU+UBOQaX7jH-2zOqv-4SjZGg@mail.gmail.com>
 <20250104190010.GF1977892@ZenIV>
 <89c2208c-fe23-43eb-89ef-876e55731a50@kernel.org>
 <20250104202126.GH1977892@ZenIV>
 <CANn89i+GUGLQSFp3a2qwH+zOsR-46CyWevjhAQQMmO5K9tmkUg@mail.gmail.com>
 <20250105112948.GI1977892@ZenIV>
 <CANn89i+L619t94EybXKsGFGQjPS7k-Qra_vXG-AcLJ=oiU2yYQ@mail.gmail.com>
 <20250105195434.GJ1977892@ZenIV>
 <20250105205056.GK1977892@ZenIV>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105205056.GK1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jan 05, 2025 at 08:50:56PM +0000, Al Viro wrote:

> has max taken from ctl->extra2, which is &net->sctp.rto_max of the
> opener's netns, but the value capped by that in stored into
> net->sctp.rto_min of *writer's* netns.  So the logics that is supposed
> to prevent rto_min > rto_max can be bypassed; no idea how much can that
> escalate to, but it's clearly not what the code intends.

Speaking of which, the logics that tries to maintain rto_min <= rto_max is
broken in another way.  There's no exclusion in those suckers.  IOW, if
we have set rto_min to 1 and rto_max to 10000, two processes can try to
write 1000 to rto_min and 10 to rto_max resp., with successful validations
done against the original state in both, followed by actual stores.
Result is rto_min == 1000 and rto_max == 10, which is probably not what
one wants there...

IOW, the validation and stores should be atomic; the same goes for another
pair (pf_retrans <= ps_retrans).  Again, I've no idea how severe it is,
but result seems to be at least contrary to expectation of the code
authors...

