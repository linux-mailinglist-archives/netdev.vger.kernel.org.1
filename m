Return-Path: <netdev+bounces-286669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ErHGOHiAWoEmAEAu9opvQ
	(envelope-from <netdev+bounces-286669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:08:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A03B50FBCD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB61E301917C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EDF3FA5FC;
	Mon, 11 May 2026 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ7QlUDb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B33FCB03
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508011; cv=none; b=GQcJx+OfF1h0CISElTXMej14P5TSgYw90b/uqU1CvTOlXROuNli8afGNREmJ5yFB8DN2ttO0v+BsJPDs86nakmHK3u4jjeNT9cf9FA2dO7wk4GnlxJBlny3dWVDFuZiYZ/BffI34hrght21d9x9MxyKzZokooipmQsZTv00MRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508011; c=relaxed/simple;
	bh=5NYb3nCdci3KXze42GOuIOeKBASnZfbaXOLgNEusfFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDhiZju68FwyT/ePs1lzUTlm/WP5qzNQBYzSl1ZqVQfpIHk2/GLE+5K6xfIC42dlDXuP1H2sIW0uFF74hItKJsQqLl+1N5unuEN+kUu8QVgreUvQ9gvdF37jI3OPtMDgyIRvYNstqC8nQIYMFlj3keOxGLWAA91ene3tyLme1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ7QlUDb; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3070869eec.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778508009; x=1779112809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/KHb6lEoTrKYlmbOXQjnmGlvfUFlTPFpTL416gJbnM=;
        b=dJ7QlUDbR/bQ8A6z7fpaowmDzzKDB8/tnLwRRz4Lya04GxoJ6Yc0H3AZ1zXp9pAK+g
         pW5XKk7qo6BZI8WW2Nsa1NMK98Nw61D/jEwPZ60fmwlCLVAcTtununIyHM0IKDMH3o4F
         b3C8ESXxmZnFzJF5U8Hy30v6DHs4A6ziyO/IBk58BXH/b0VgMdzOUHpaaXffyEq5C14G
         enliNQioZSTBVOyKvp6l9s776ng4rWyq8a/ipBJwW951TDM1WKhTYEYBW+MiQhuHtBRU
         hvOM9R+vhtiskGid5wj8VE0/kgLHwFhbiVNa7tVZ+/CGd/7gg9SsA27DojrWZJDLDL6r
         HqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508009; x=1779112809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/KHb6lEoTrKYlmbOXQjnmGlvfUFlTPFpTL416gJbnM=;
        b=lHg7AyzK7sg/qVQJuORgZ3nSIpJlWHDbh+WTHpajEqGH4UMRxm4S8AcN/fKbXDJiS5
         vV1K3xZ4AqNHnmlDiuq/MNnSdiCJTrhCupSNRmK+83hLT0gSLHAIiaiMSF+Cu6AFcZwH
         VYKMAepIYFguj/eHooY0j3dtrOVe/6EEwvy75vzpTkNAe3H0ZSig7LceObndIU504Vxf
         a7SR+fVrlcs8skCl+gQ/B/M5VaUz0JRUl/i4poDqV7+wWoCS81H8zHeUpQsOliD100W7
         e3+tQbSzuzeIGFYAo0/QJzoy4T9TwnC/UKmodVV3tD/ec61rAnh8P+ovpQTaI3xrJ/t2
         8Ocw==
X-Forwarded-Encrypted: i=1; AFNElJ+TgZhcMMiXsTv2P50yOUj3IYZ7YxJTcDLuPLu6fRBH9tDr4iGFv5hsyrsiUTFYbqklcy2nF5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrEQZjiKzhS7SWXoWEU5TYXdFsq6x/ANiwFVKzJWoQjCSk+Lsq
	H8mFWHdaJ5ydTg52w0i+S+URV6ORDYP/9qy5jxtlSV8E4lorLATZ0s5m
X-Gm-Gg: Acq92OENcOoH4tMnUoCqxNreRVR9Ao4cBj3oY0kyj2ct1AfhbK3GByjAbLiuoWa6tDF
	4jOBD7IcTDDtjfUa63PAfkNe66b2LRPEnwKiy3AdVe/NwAedMMcUSz+QHbMiIS62ZdMtSZ7Cffa
	qi6eX4Zr1MfKWBGt9n+eXIQ4oVgNygk6KVPLSm7DXu2Qfj8GocHH5ZfOJMARJtrxjDsALZUIB3+
	60jZuro843FgrguuL/p12QVSlRqpDPnf4iL2Ybe9WZrQbo7yp1HhN8tQFz0EOc4aR0DnAPaoCt9
	psHo/pPeMGcoxV/e+EkYy0WIBouc8V/8C/iThpn/MAAE6oz1m0Wldm7mh+tLlLrTfF9HD8EPImU
	NuThMFOkrbNPHIkN3+Nhte8mUghwcOGGoN0aHfJ3omJQlROUmrpgOe9XVU7olpvYvEKT5oXLu3G
	yZYiJ68Mw1t6MocIS6CawLxnd3FYhgTtmlvatNIr8pdIKx4A==
X-Received: by 2002:a05:7301:1f04:b0:2f3:b7b2:cbd3 with SMTP id 5a478bee46e88-2f6e2402b30mr7663322eec.5.1778508008930;
        Mon, 11 May 2026 07:00:08 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847506fsm16313143eec.18.2026.05.11.07.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:00:08 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: sd@queasysnail.net
Cc: albinwyang@tencent.com,
	alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hannes@stressinduktion.org,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shenyangyang4@huawei.com
Subject: Re: [PATCH net v3 1/3] macsec: introduce dedicated workqueue for SA crypto cleanup
Date: Mon, 11 May 2026 22:00:05 +0800
Message-ID: <20260511140005.2619263-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <agHahVF3yq9AuLmj@krikkit>
References: <agHahVF3yq9AuLmj@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A03B50FBCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286669-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[tencent.com,gmail.com,lunn.ch,davemloft.net,google.com,stressinduktion.org,kernel.org,vger.kernel.org,redhat.com,huawei.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[alexjlzheng@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, 11 May 2026, Sabrina Dubroca wrote:
> > +	macsec_wq = alloc_ordered_workqueue("macsec", 0);
>
> Why did you pick an ordered workqueue instead of a normal one?

I chose an ordered workqueue for its serialized execution, which
avoids potential ordering issues between concurrent SA destructions.
In hindsight, there is no actual ordering dependency between SA
cleanups, so a normal workqueue is sufficient here.

Should I send a v4 with that switched to alloc_workqueue()?

Thanks,
Jinliang

> > +err_destroy_wq:
> > +	/* Precautionary, mirrors macsec_exit() to stay safe if work
> > +	 * ever becomes queueable before this point in the future.
> > +	 */
>
> I don't think this comment is really necessary, but ok.
>
> (I missed the discussion on v2, it's not possible to create SAs at
> this point, but it's reasonable to add the rcu_barrier here)


