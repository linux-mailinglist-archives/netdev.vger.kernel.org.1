Return-Path: <netdev+bounces-254382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A+1IGFJemkp5AEAu9opvQ
	(envelope-from <netdev+bounces-254382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:37:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D8BA7032
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89A483019FE6
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A192F3C37;
	Wed, 28 Jan 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVN+Dj7M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1C23D7CF;
	Wed, 28 Jan 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621852; cv=none; b=ReQHOTubko4iAhYJm7XXvkv8pdDZeJfrTPwhWhkpkMIVG8L/XX7RcHMerXq+ZOLFq50C7Ray0q2Yc+ifY432fYPDAu+cL87Dc88dNzhHsuiEx1q6FtfceMuD8pDmTYeT5QbHCyLPzQ6OKykNfaWf3ULnshiofDcRPMyLvMWLhlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621852; c=relaxed/simple;
	bh=dPWJLUX+E5arRKPqAAl005CIEzPSi/GQ4NP5PfhUX0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNScsjHotj1EWOtHdliCYlxYzR112Hq182/ST2E2E6qHOaSMXN5E3MSVA+8Ps/+mRYv06Qv1U05nzZrXCWfg+BkoUhi+LNGjrrlmN6jSXKI4q0HKSszf1jUbODvlLz9qvqilCSb/QetgeXF9Bi33OVs5qVpmMj74yorLmpKmWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVN+Dj7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53F7C4CEF1;
	Wed, 28 Jan 2026 17:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769621852;
	bh=dPWJLUX+E5arRKPqAAl005CIEzPSi/GQ4NP5PfhUX0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVN+Dj7MQ76/SsLr0Llr/J0BJdYUydK/TqMvzASv5tzRovg14PwvBmmFLyvuPTbQY
	 1OGt7J7Ad8LTFGHU56bN1yeeFmJeB54eMWlZsAhH8up/7GwIUR6OmJ3obJnDdQXfkA
	 qNRp1iLLledv1ZhcyeqVZWZg3x10za7iIPxhAkdk+ESgfbiWDou4xvzaIAQDgVCIph
	 qGLso9Ke5M3qQthAQZOGBhIL4boWOEl557Bu5lK9USRFCyXnQvU+OZl4Zo6XiAC8xD
	 jak+hh+ORU4FjR0TU9e4L6qAjeDNgSBabgT+OJ09bIY+L/A5fboX20feJ5YCdq6Xwf
	 k1MRIXVduRhag==
Date: Wed, 28 Jan 2026 17:37:28 +0000
From: Simon Horman <horms@kernel.org>
To: Henry Zhang <henryzhangjcle@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org,
	syzbot+c6e7bcea7ffb7ff46acb@syzkaller.appspotmail.com,
	Henry Zhang <zeri@umich.edu>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] mISDN: Fix data race in timer handling
Message-ID: <aXpJWC8daHd329w9@horms.kernel.org>
References: <20260127071927.1520272-1-zeri@umich.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127071927.1520272-1-zeri@umich.edu>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254382-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,c6e7bcea7ffb7ff46acb];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[umich.edu:email,horms.kernel.org:mid,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1D8BA7032
X-Rspamd-Action: no action

+ Eric

On Tue, Jan 27, 2026 at 02:19:27AM -0500, Henry Zhang wrote:
> KCSAN reported a data race where misdn_add_timer() writes dev->work
> while mISDN_read() reads it without holding the spinlock:
> 
> write to 0xffff88812d848280 of 4 bytes by task 10864 on cpu 1:
>  misdn_add_timer drivers/isdn/mISDN/timerdev.c:175 [inline]
> ...
> 
> read to 0xffff88812d848280 of 4 bytes by task 10857 on cpu 0:
>  mISDN_read+0x1f2/0x470 drivers/isdn/mISDN/timerdev.c:112
> ...
> 
> dev->work is read locklessly in wait_event_interruptible() and
> mISDN_poll(). In mISDN_read(), the result is rechecked under dev->lock.
> In mISDN_poll(), a stale value may cause a spurious EPOLLIN or a missed
> wake, but wake_up_interruptible() will correct this. In both cases, the
> race is benign, so we can annotate these with READ_ONCE/WRITE_ONCE.
> 
> Reported-by: syzbot+c6e7bcea7ffb7ff46acb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c6e7bcea7ffb7ff46acb
> 
> Signed-off-by: Henry Zhang <zeri@umich.edu>

Hi Henry,

This appears to already be addressed by
commit 8175dbf174d4 ("mISDN: annotate data-race around dev->work")

-- 
pw-bot: cr

