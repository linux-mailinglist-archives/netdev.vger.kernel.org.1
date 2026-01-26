Return-Path: <netdev+bounces-253569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEK8K0m2d2nKkQEAu9opvQ
	(envelope-from <netdev+bounces-253569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:45:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9D38C2D5
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6E3A301877D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFDD245031;
	Mon, 26 Jan 2026 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXrxGeME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA461A9F9F
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453126; cv=none; b=ZzFo/Lk+fDZpckz/HjUvmQDJrAieuOnkBEx8TI0wLEdVriJDQkLwOdFuEbQQ2PWpf4atAxBxU6utRR6sR15QO2efAYinWryvvsweKcxouNhIVskbHejcOhRvHSLBap5q05D3qr3O5MOZD3mAec2oGjFW6tNHtWIHvjoPxxviPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453126; c=relaxed/simple;
	bh=idn99UPqC0nF9uZDjKf0+iVfU/oqm91JSUXz9Edt4Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtZ5EkoCUC25g2NmZg3eHF/S+Z5DVUcLj9bO36BkfES4RVZCYfgmq67VM1+H7X9CIEfLOSybsIv8alhyWt5etnW8YyM0z2wN6UR2zj3znNqybFAQjicx8hqNxrONM9uBgjBoOyZeMDwN2hK5SYjChy2TmfMT0JZKE4+VDMtho+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXrxGeME; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6493937c208so4369991d50.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 10:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769453124; x=1770057924; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LzUUHM37iqxpGKoml5d9xTIQ0EByiMn/P+sNGyQg1IY=;
        b=eXrxGeMEXsjtWZ7u4xag9aNbizPGsfEfHTeHM2cN9OQjuh6B498ItE+xKomXNtnBRB
         Oyt+/FtSaAseuhh3ByClTKY0G4OJ+oo8qPRSlf+rFJqluiLnKrLW5NdVbJnZP8PZwGP7
         zX+RbnjSR9TtLFlcy5FzIkEdINbkCY2XllR/v8c1OaByJVEiljsZdF/rvufl1q4y0XOO
         7s2k1RNRF90F18kXWUZ0mzGP7zdNpSceOafOnc754kGut2cCB5NdnfrnGxf8aJl+Icqc
         5v87V4AiIAhlh4vIPVdMyyfQtCJpeEdkv5szcBofZeYMMjcaZUOVyUfOf5nRtLGxuZ8j
         cDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769453124; x=1770057924;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzUUHM37iqxpGKoml5d9xTIQ0EByiMn/P+sNGyQg1IY=;
        b=UKTH8eye+L663xbZGxzYquFiVar5/XJn0Dr8+SKZg1nSxsmVj48Nv7kuOeQ2fR1UGq
         GHAZjQi3q4FthbccMUFrDzk2dEmdfQtVkK8ovcfoSGKJJBnxiIXgg3/fDIsYVALjmP2Q
         j06QZAmrFAppTYGwhAIyM6qyzrNyHWaZpm91cJl6ul2D9nwXjDyyTeMSBahFpwGFjcfy
         cCtDX/Ap7/yuXYqVDi2FpsVvJYwfYoQ2BhL3IbOiRTGrXylxMHEQ9bACAJoqS1gfiH8W
         FOXiYGyiUvhQzUiz00qgrGQ1Ihem8FrqOHl+pTxnXfXZXP9y0hjMSHO+pb+G2C9QipxG
         sloA==
X-Forwarded-Encrypted: i=1; AJvYcCUCn1PGWESG6FnRd+NB4WWY9Ahwd4TvM6VH+dAlSWM0yk1l9CXgzHGPeQn1ziv3KmjR66fcNKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ysWtE4a29fjjEu6PybkkSXhf18C2T8kbO0m1lZQEJ8YXhfU6
	ae/rRIIc9FyMigsYGqhN4yWAjBpUPXLCQIAJCiNuvs+x6T2cSfd8SVXh
X-Gm-Gg: AZuq6aJKZylPFBbHPIrS4lyHtCRMEdhwcyJsXsyu8mHp0zxDPQvYg3RYYhjcyK0ji4Z
	0vMZUiNCrNcbZkL8wXlggA5JgJ4xgn2EEo4CzOo7DrM04LM0CTqE8moQ1B/goPs39KbZ/FS+vAt
	q5/75z+77DEPa7mgeAaWJpTwnJLgSBYJteisxmJjOXaupJnoPo0HItqLA6CmYCtd2T5UKIcZq3y
	6egXBTcrCsZQ8zH6kdA7WJyla9fmBdDsv4SWSNy8ZMQstvEtH3I4LB0CWsI49wgj1n4Xnk/UsWT
	miy/FjDQIBTEJxDcMB2hKDIRozjeAZmDM86i4y5hrcDvhkz7+1K2T5fI6y+GiHVKmsjU4p0nqSl
	9bycKDp/kL2HcTOIU61vwxzb93RkPlA9MwUDQ6aotDqFsf5sqpTwWRR0dnBeOIHH0WqwbtaUAGn
	CjdkzSIRsfuuBMY16bee0Ub77VDiBE3P8O9w==
X-Received: by 2002:a05:690e:11ce:b0:635:4ecd:5fcc with SMTP id 956f58d0204a3-64970c03363mr4264419d50.41.1769453124075;
        Mon, 26 Jan 2026 10:45:24 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6495ce752f2sm5613399d50.1.2026.01.26.10.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 10:45:23 -0800 (PST)
Date: Mon, 26 Jan 2026 10:45:22 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
Message-ID: <aXe2QhzL4DoVbesQ@devvm11784.nha0.facebook.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260120170749.101e8bcc@kernel.org>
 <CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253569-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,arndb.de,lwn.net,lunn.ch,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 2A9D38C2D5
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 08:21:36PM -0800, Mina Almasry wrote:
> On Tue, Jan 20, 2026 at 5:07 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 15 Jan 2026 21:02:11 -0800 Bobby Eshleman wrote:
> > > This series improves the CPU cost of RX token management by adding an
> > > attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> > > binding to avoid the xarray allocator and instead use a per-binding niov
> > > array and a uref field in niov.
> > >
> > > Improvement is ~13% cpu util per RX user thread.
> > >
> > > Using kperf, the following results were observed:
> > >
> > > Before:
> > >       Average RX worker idle %: 13.13, flows 4, test runs 11
> > > After:
> > >       Average RX worker idle %: 26.32, flows 4, test runs 11
> > >
> > > Two other approaches were tested, but with no improvement. Namely, 1)
> > > using a hashmap for tokens and 2) keeping an xarray of atomic counters
> > > but using RCU so that the hotpath could be mostly lockless. Neither of
> > > these approaches proved better than the simple array in terms of CPU.
> > >
> > > The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
> > > optimization. It is an optional attribute and defaults to 0 (i.e.,
> > > optimization on).
> >
> > IDK if the cmsg approach is still right for this flow TBH.
> > IIRC when Stan talked about this a while back we were considering doing
> > this via Netlink. Anything that proves that the user owns the binding
> > would work. IIUC the TCP socket in this design just proves that socket
> > has received a token from a given binding right?
> 
> Doesn't 'doing this via netlink' imply it's a control path operation
> that acquires rtnl_lock or netdev_lock or some heavy lock expecting
> you to do some config change? Returning tokens is a data-path
> operation, IIRC we don't even lock the socket to do it in the
> setsockopt.
> 
> Is there precedent/path to doing fast data-path operations via netlink?
> There may be value in not biting more than we can chew in one series.
> Maybe an alternative non-setsockopt dontneeding scheme should be its
> own patch series.
> 

I'm onboard with improving what we have since it helps all of us
currently using this API, though I'm not opposed to discussing a
redesign in another thread/RFC. I do see the attraction to locating the
core logic in one place and possibly reducing some complexity around
socket/binding relationships.

FWIW regarding nl, I do see it supports rtnl lock-free operations via
'62256f98f244 rtnetlink: add RTNL_FLAG_DOIT_UNLOCKED' and routing was
recently made lockless with that. I don't see / know of any fast path
precedent. I'm aware there are some things I'm not sure about being
relevant performance-wise, like hitting skb alloc an additional time
every release batch. I'd want to do some minimal latency comparisons
between that path and sockopt before diving head-first.

Best,
Bobby

