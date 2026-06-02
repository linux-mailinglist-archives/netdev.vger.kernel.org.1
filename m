Return-Path: <netdev+bounces-294100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFboGv6jHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:35:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 152EC62BA85
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE5C23085EAF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B33E383338;
	Tue,  2 Jun 2026 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LWb2KaeB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1E3655E7
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391898; cv=none; b=n7LMNROeeYlU0y4G4M2/AqoWhCpebOWIz/IF5QpPGsKAkOG6PA+BlCw+oYap1HfNLSUAAoQExRPy2TMsgIQGwbPC3vXJRJ+M3dk1CpvH2WllJYJE/fW79vs1f0IE4SjOxcmWUV4xPBbVIAs+PXhc+JMLT0YhijDwUB/Ba3cXxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391898; c=relaxed/simple;
	bh=FYGX+z1NHS6G0DY02oZQ6hTTBFd4DJcBw8FAvVlqv/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj1d0shyJXvghQ3eBbVEhV0INJ3Bh8yl3+ffikYmQ96uOJcKJtIaX8BSe2x3U3coMl8Qkwv1Mq5jQrEz/wtDXf1g/Xl7o+oScmYviNRgyJC6bPHJSefd/7eL9r/tXe75CZ2xu/oKJW8xr+S76lXtT7F/15GeRtGFEeMxJLLfK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LWb2KaeB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-beb8a08a6c8so405121666b.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 02:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780391895; x=1780996695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8weWZwvlicUS0dvAxblKD1HBMYQh1u5mQ2U5bxBouSc=;
        b=LWb2KaeBuGlQuxF2ygVImG8z4k6CWEfaz8CIF20uqpcIp1Z/93bnC+RGYjgbcyS3DT
         Bpzm6hJMKdWRjIsE50U5MFlQBwL+kknijzd2EJC0arOwnoenhvloVr3CD/Dsa4VcYEBu
         GY4VF1Bl1OppX4jipLsrAg4r1QppX6Ry0lBgZRF9dOA2/gbepWfZgfURLWNmuXVwUoYs
         YaxlUZ+Zfgii3NCsewGG4TRrGe4euGOzb60mmQxXKpVtMk1Wd1CI9dvIna+pKHYCXuUa
         ijTY/DAk5DAWuF+1uq4KEPQdf3TqZfaUWGocJWqxyi24zbd/ufyOHgYbm2r5OBJkOpYu
         /vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780391895; x=1780996695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8weWZwvlicUS0dvAxblKD1HBMYQh1u5mQ2U5bxBouSc=;
        b=nE4EKESvt0PiswewRvideFbKn19A9XBW6LZSn2qD4oE6lsXI/r3bJPbv4kmh0umx1B
         J9SghPNDhhm7L1oxrD6WvHc111g5LRyI515RE55c0Z9kSBCHURVwzBXkRdfC/iP+DN6y
         ItIwiEEE9J2+pYfwqmFgV0PlHkGTisMj98N3TRoxh1VN0w5qi3uLOyqiMOcHuZXb/65N
         uCJBrrRVERuBxo4aRE7upUOWFsf6uRUZlrrhzRwE/lJ4kmQt8tTtDn0QP8pPg+JJRj08
         /y40odYRc0H0ipeXpvAskDC2pdLxYniCUeGZOkBCgIi7joYvuvnIs7nF8R9TzKFVAHEi
         FrOQ==
X-Forwarded-Encrypted: i=1; AFNElJ83csJIkOyZ8zYtVcGOxHT43BJm9UgHIN0YJG5pL7sx9sf6NKgU3jRQ/DP7XF8BXOIq5wPz3n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHrZ9K+tqlNvDVzWHpAPSZqSSLwAkDzCvTdGTF6GJhVh1kwga
	8ODZPP3Ej6izFiNadmNR+KigKCCpE1YDSH3lGNRN4QsrTlljsgyF0Dc/Fygy7LbovuI=
X-Gm-Gg: Acq92OEoSS8PJrB2ucN8fJssra7L/kkW2twVSSEDK9TRKaaUvbglVaV5TE4R7lyEUCi
	mSnPf7LxuMKVPpBJdcEak6iDth0wSzT8Qo+0q2F50RHVBY9yO6cXXVjC0rFu8MCBctAaA9J52hL
	DlduEWSmvLDav2CRk9Hb2HxYqRqm2auWmSfM6dSsCyxq2MnitFcW5J8XLHp78GK6U+T/p9ylait
	kbgE4cyVXoYEQBo6zWBEvjuHl6lgGUcdGbjttS8A+RztzuAZpq6E3Bg8A6RtALrwo7fFJR00x8W
	wmqAax57NMCznHnhGZNPYGu0tlSCbMEmuJK0m3ckPjefsnd4KTmMDyqYaUQVAHXlbY5MsUbK/KE
	O5BvE3zDevGysBLfeuopdv6Y3u68xTc1zn5Nw6wPYR8yLZhZivw+oYESadJjdteCdkBbLVOZX6P
	ZWoXHEQFyRKVKUixeqNtCNKm2g2V/lX+iNKkzKaM4K1iixVT21XnySHw==
X-Received: by 2002:a17:907:9453:b0:bea:5cc7:95a4 with SMTP id a640c23a62f3a-beab03de8a1mr933593866b.0.1780391895233;
        Tue, 02 Jun 2026 02:18:15 -0700 (PDT)
Received: from u94a (27-240-75-84.adsl.fetnet.net. [27.240.75.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd91846f8sm2382956a91.4.2026.06.02.02.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:18:14 -0700 (PDT)
Date: Tue, 2 Jun 2026 17:17:59 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	tamird@kernel.org, eddyz87@gmail.com
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking
 fixes
Message-ID: <ah6dLESn8tHAtxS9@u94a>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
 <ah5pf25fhVH9WuU-@u94a>
 <ah56iBM2P_9hF3_L@u94a>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah56iBM2P_9hF3_L@u94a>
X-Rspamd-Queue-Id: 152EC62BA85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294100-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Jun 02, 2026 at 02:42:35PM +0800, Shung-Hsi Yu wrote:
> On Tue, Jun 02, 2026 at 01:47:01PM +0800, Shung-Hsi Yu wrote:
> ...
> > On Tue, Jun 02, 2026 at 02:03:58AM +0800, Zhenzhong Wu wrote:
> > > Hi BPF maintainers,
> > > 
> > > This RFC backports two BPF verifier scalar range-tracking fixes to 6.1.y.
> > > The series is intended to fix a verifier state-pruning issue where an
> > > impossible scalar path can be kept while the real success path is pruned.
> > > 
> > > This is a verifier scalar range-tracking issue, not a helper-specific
> > > issue.
> > > The visible failure is that the verifier can prune the real success
> > > continuation, which should not be skipped, and keep only an impossible one.
> > ...
> > 
> > This sounds somewhat similar to the issue fixed in "backport of iterator
> > and callback handling fixes" for stable 6.6[1] by @Eduard. Could you try
> > to test on the latest stable 6.6.y as well at see if you can reproduce
> > the issue there?
> ...
> 
> My mistake, the reproducer you had doesn't use iterator or callback, so
> probably not fixed in stable 6.6. I'll take a better look at this later
> this week.

Two more ideas beside testing on latest stable 6.6. 

1. Can you try testing on bpf-next, but with commit d028f87517d6 'bpf:
   make the verifier tracks the "not equal" for regs' reverted? My
   concern is that it is possible that commit d028f87517d6 does not
   address the root cause of incorrect state pruning here.

   If the reproducer _fails_ to reproduce the issue even with commit
   d028f87517d6 reverted, then it is possible that the root cause was
   fixed by another commit further down the line.

2. Have you consider adding your reproducer into BPF selftests? Would be
   very useful to have in stable (though it needs to first land in
   bpf-next first).

> > 1: https://lore.kernel.org/stable/20240125001554.25287-1-eddyz87@gmail.com/
> > 2: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

