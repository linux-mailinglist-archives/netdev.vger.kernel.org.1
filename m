Return-Path: <netdev+bounces-277599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEYJJgd22Wn0pwgAu9opvQ
	(envelope-from <netdev+bounces-277599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:13:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7923DD227
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3797A300D146
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6450E3DF01E;
	Fri, 10 Apr 2026 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0W6gXkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01B3DA5C1
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859143; cv=none; b=bklnSHtzl/Gitd36NzP6M9QLEsjnRGYukzFXsKeRYcaYY8Dt0nPv/IqCDqzrQNwABc8sRMq5f73QCIPVccaSvfHeOvznBxVl3ZTDkCc9Xak6Ap4dJgdFX+EyCs4mwdueVbUxu66p4vGSW37E9BYO+oAvq42PrOxu2iXuvX+Wb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859143; c=relaxed/simple;
	bh=BYCH3vDBRAX3ehfhBG/Wmpxnwa8fywE0iX7ey0b+65E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JETbRIVntEb/BI7dTUebtlbkvJ4WebtcBT5MqEYgXLmXQSh/iblRmViEub13R++FQznKil9aSiEGU28rfGJAi8hXA271eS3JcqUege14uiGN0bLc4XrfY4P7QyYoDsxzwlk/b3kqL9o5tA8Ota60hg34LdYEVr1Xnpq25Tpv6RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0W6gXkC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35842aa350fso4982788a91.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775859142; x=1776463942; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpw2bwte44HnZBACPA5pWBmsdEZ8HQTZb/ioIo17CDE=;
        b=f0W6gXkChhiGamRAXFgiE3PagG2Rmap6I/QgPkhOJcfK4WxU+B9G5oxHtVSm3y/E8p
         zltmYZ5P71sWfSi6jpJMKGMxNw8uzM5QRwiqLyOuqDrf3NSM/xicwqINfkALYvUhxwWo
         KU/MDUNSQXfxfQzPQOWJSRtsDyF2M4zdEpWONRIyn5qQn1U/GYPwngRt9FteDckdq/OX
         C5DjX/CjyP4E6rG8lahJncNA1AsaqBAaIAqhhNg0H8liNMyanJX9DfVvpsMFgajJuIBI
         z6AONRiSnb4lXORTcdausjk4Ot5WCSXkwKtYsnD3JuM2o843j6UpLNXDincUaEObiOdG
         j94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775859142; x=1776463942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpw2bwte44HnZBACPA5pWBmsdEZ8HQTZb/ioIo17CDE=;
        b=Q8OaFiq0VHyKqTJOAQ9sIJYNhXdmBE1Svp4O26sAv9/dD0WqHgKMnLUFjAo3ffp4OS
         8Horw+UnByFgeGj6Bu4uPkJagB2l53CG9JG/Q4E2Fdzh0bMo2zk4+AzqyKVmbdKYx4XR
         r3k5tbqihORhshRwe+kNJJevr/gH6x3LYlTtEXgp12VUDnxHmm5lw6zse8UhcMfJPEwN
         ixEUpxyej6F4vaudppv4ydIQw9taWbqgRjs6Say3LFUtBcuGi1j3r9Z5aN7GdtA+tMEp
         Za4zHwCH7cLXOuPirWKx2tEK1xwBJN7h5wEmpQqVDBlefyESgvaox763tNMlQ2/56HSW
         rHtg==
X-Forwarded-Encrypted: i=1; AJvYcCVEG6YcvPqUlrbHjsPu/rIJs23KPKDkohmjRNRRYbMd5NYV3d3vlG6PzrptzywyjfPg8wjfjCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9fNq/n9V09HMt/bS6zZOYlYLVSWXEt+majxEOfO0o9JhfjPnJ
	jOBqrvHk3f/9o7BalSzjey6FULE/hMkvxMl+RB5LOxhG8ntlXnvTJ/xELtH4WW6HHrIXSRqzvtD
	KEVwJEg==
X-Received: from pjbgd11.prod.google.com ([2002:a17:90b:fcb:b0:35c:e06:8f50])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:270a:b0:359:8de8:1229
 with SMTP id 98e67ed59e1d1-35e428491b4mr5375577a91.21.1775859141438; Fri, 10
 Apr 2026 15:12:21 -0700 (PDT)
Date: Fri, 10 Apr 2026 22:11:47 +0000
In-Reply-To: <20260410145448.38253e3c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410145448.38253e3c@kernel.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410221220.1708137-1-kuniyu@google.com>
Subject: Re: [PATCH net] netrom: do some basic forms of validation on incoming frames
From: Kuniyuki Iwashima <kuniyu@google.com>
To: kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org, 
	horms@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org, 
	workflows@vger.kernel.org, yizhe@darknavy.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277599-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D7923DD227
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 10 Apr 2026 14:54:48 -0700
> On Fri, 10 Apr 2026 14:30:42 -0700 Jakub Kicinski wrote:
> > On Fri, 10 Apr 2026 07:24:36 +0200 Greg Kroah-Hartman wrote:
> > > On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:  
> > > > Or for simplicity we could also be testing against skb_headlen()
> > > > since we don't expect any legit non-linear frames here? Dunno.    
> > > 
> > > I'll be glad to change this either way, your call.  Given that this is
> > > an obsolete protocol that seems to only be a target for drive-by fuzzers
> > > to attack, whatever the simplest thing to do to quiet them up I'll be
> > > glad to implement.
> > > 
> > > Or can we just delete this stuff entirely?  :)  
> > 
> > Yes.
> > 
> > My thinking is to delete hamradio, nfc, atm, caif.. [more to come]
> > Create GH repos which provide them as OOT modules.
> > Hopefully we can convince any existing users to switch to that.
> > 
> > The only thing stopping me is the concern that this is just the softest
> > target and the LLMs will find something else to focus on which we can't
> > delete. I suspect any PCIe driver can be flooded with "aren't you
> > trusting the HW to provide valid responses here?" bullshit.
> > 
> > But hey, let's try. I'll post a patch nuking all of hamradio later
> > today.
> 
> Well, either we "expunge" this code to OOT repos, or we mark it 
> as broken and tell everyone that we don't take security fixes
> for anything that depends on BROKEN. I'd personally rather expunge.

+1 for "expunge" to prevent LLM-based patch flood.

IIRC, we did that recently for one driver only used by OpenWRT ?


> 
> cc: workflows, we can't be the only ones still nursing Linux 2.2 code

