Return-Path: <netdev+bounces-278067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I6IOkzj3GnBXwkAu9opvQ
	(envelope-from <netdev+bounces-278067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:36:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBBF3EC09B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBDE23004DAD
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B14839281F;
	Mon, 13 Apr 2026 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMHYrx8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A0352C29
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083782; cv=none; b=IMCJ2USABPFDa9g7vejpkViWMloK3m0hCUKgj0Fwn0oForXVNs36ludq2fuNGpwue2NtvAdDML45vWJ/xZfRWMj8MBG74hL1mWk/Z3sabAh4IStpR7+S18TcNcZkJNs4rsysLOjri96VjG4Hw85bOSMe+P2/gF36+1OzqqcIxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083782; c=relaxed/simple;
	bh=duDBEuMQO+r39fUBlpMvZykm25SnTiIYgtpUPvcaeHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVtMB/xH25AJ0YGFs12Iyp2kKMjZKNZcwoKHUjLZOG7jmzGF8Lqx7AqdjDv/ysLbWKMtUNgApEcDF5z0D9WZ8EVV8JUYVhmLsAZEBd01tZWL7o1QQXd0HvhiKFSKSODbp/ThXwPToSB+jjWO8PigW7ZUzI0JS4MhXmCMKo3HOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMHYrx8z; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1273349c56bso5583355c88.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083779; x=1776688579; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SzjQnFnXmG73dA0+oAWDE1GrYR8ou6+5ae07pUlGoHQ=;
        b=KMHYrx8z1jkF81Yaty9MXX47Jny2GJguqfnhNz4s1p4k3MHwxz6CPbWmDrSmSAayBG
         pUs+XvgqqIcYpmSA/f+pVoOsv4YJrPkHxFislzvTl88s17fJT48LAHM+hfx3P8uO/yId
         6Vy+o2yB8UZiijFp7nwPsxzp05pdBIkRtgLWfLNhB7uheZzJIqq3PB0hWfMZVCPYaJhy
         E1KK3zeZNF2QboAlh0LJ+Jm0ucO44eUoxb9SnCq6W2ri0oSHW2ytnjE4EcR2S7yvFpTM
         2rdEfUwNTfeYYPORKcZD8SVUkyZcasftNa2JpIgO7nKSjd2TlcfGBUbmTPKsGsPcqfQZ
         Amdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083779; x=1776688579;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzjQnFnXmG73dA0+oAWDE1GrYR8ou6+5ae07pUlGoHQ=;
        b=S8NW5e70qQ+j7jerXpHVXAwLZvJzgAV4WPLKVDESrt1+sAG+kLXyu83UhLTTCJfu1u
         kl7nh6S8yKt5Oc0ib+sNTrNKivVUhTfAoFZN8inICb9VmJxrdtYkV4plQ6gKXU1tE0qu
         r0C95jntAgeX6t7qw+UKscqyaWY81XW7KrUqJ9UuF9f0C3egKiwZNAhcnCFRxqMORmWg
         +77fa3iv9+Z8aybr2WPwwGRLt/WiGqC4v59P3PL4DOnzcamy1rO13DZ9KmDkKBS/CPLt
         s1NjmkwyPTFzypcHFA4mLm73IllqDRp+9NQOyiDq7NHxwBAc1p48wtqxGxDMCAeBdJ6s
         5psQ==
X-Gm-Message-State: AOJu0Yz0wKhjxTpxhsyrDxoeMm50AEANO2pAlkZVoFBaB4/VLV10wUsl
	K3UNwhfS8waiF9EmTOXUSQlvFm0PrZHJgUbpx+icTwNv9N7vWfAEWPrqsfMTDA==
X-Gm-Gg: AeBDieuurkuYoNzsQKEp6b8oB3zU3RRPSQeNcZOq9UMk6tYsYUTjCRQpOIrdcZW9Iai
	K69cCMtebOK0tW6QpFGKfJDgsHaFzXcy4cTKOgWdwnHc4oR3aRQNX4HlIdlbzlCTZLIxQ8PzQ72
	O0Lc299fLjHdIhqveOqpb1A8+L9Mf0UcnB3XG9nagwnkGmhBC9KTvr3FbhOYT9AFRudCoNvUVxd
	BFwXjv3d4d8KSDQQAiGvsts9Knjd3axtQfrUOKblemm/s9zau0w/tn8gd38QL5tHKj46tf1d4j0
	WXVWpX42TpRRLk2iGB6oy8UwzReAjIJCIngldmYo7tF9yx3uF5b3QQ0Oaa46xnjG+cygmU7ZPsi
	CAV+z3hYIYnKR7J6Z5QaZmzBwZwBH915QQqroPqgitieokxHcBSES+7+8BBkTtkSzu9Q1Sptjy8
	fMbUVHYldgb9nGhKJ9rkIdvg==
X-Received: by 2002:a05:7022:389:b0:12b:f8f0:80c7 with SMTP id a92af1059eb24-12c34eed8d6mr6361870c88.21.1776083779414;
        Mon, 13 Apr 2026 05:36:19 -0700 (PDT)
Received: from t14s.localdomain ([2804:29b8:508a:1537::3a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d940083f49sm3844288eec.13.2026.04.13.05.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:36:18 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 489BA13FAC04; Mon, 13 Apr 2026 09:36:16 -0300 (-03)
Date: Mon, 13 Apr 2026 09:36:16 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Yi Chen <yiche@redhat.com>
Subject: Re: [PATCH net 2/2] sctp: discard stale INIT after handshake
 completion
Message-ID: <adzjQEZ18m5taEzr@t14s.localdomain>
References: <cover.1775847557.git.lucien.xin@gmail.com>
 <bea8a0dfcc56b9980cb914b54cffa9dd9948ba75.1775847557.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bea8a0dfcc56b9980cb914b54cffa9dd9948ba75.1775847557.git.lucien.xin@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278067-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marceloleitner@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t14s.localdomain:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBBBF3EC09B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:59:17PM -0400, Xin Long wrote:
> After an association reaches ESTABLISHED, the peer’s init_tag is already
> known from the handshake. Any subsequent INIT with the same init_tag is
> not a valid restart, but a delayed or duplicate INIT.
> 
> Drop such INIT chunks in sctp_sf_do_unexpected_init() instead of
> processing them as new association attempts.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

