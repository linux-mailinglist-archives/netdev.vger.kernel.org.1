Return-Path: <netdev+bounces-253127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iok6A9eFdWm4FwEAu9opvQ
	(envelope-from <netdev+bounces-253127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 03:54:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7F97F895
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 03:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D23D300A61B
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 02:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D31FBC8E;
	Sun, 25 Jan 2026 02:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvMahlos"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90019B5B1
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769309650; cv=pass; b=Ty5s0k8pTM1K0HrcXVzNiZ9j9J00caOZFxOXJcyqcvadHn0iOZlR5ETFmmH7XCxpQ1zzSXGM4jXdjtM4F62eWKcMKwDnLVHNksXTdF3HD1BkUVOVk9L52OBy0yvu7QWpsEmos5svKGMxkcvjN1r5m6+no/blOm4YputX3kOMCiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769309650; c=relaxed/simple;
	bh=IYHtsqgFcIUIvfYQbQe6IeYMlZr60r15jL45TpHiEIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6AADAHQcXOMRV5GL5rSOJ37088dW9RSq3/sWR0TfnBcORijKd0Chrq+bL3e8YGs2Nv31SgZipceoiptMEb8JuNfkzJuEX3wgEv50mIfieuZsA0XJCMg2KvYm/fIGvttsAsmKboHEAu/k84sz/lzZkqA5EOtkM6BS6f5Ospp8Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvMahlos; arc=pass smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c6a50c17fdso403458385a.2
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 18:54:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769309648; cv=none;
        d=google.com; s=arc-20240605;
        b=LiVQ64QXmU31Izrst8MVOyxJK1sWRO0rEU0oMmYRiBVSffA8P29GrJ4XRCJ+039Doh
         cMtOY394j/Q7xV4YSfXGsHl0Vg+0kK4n7tc8Za0FFzrORjsuTT8acG7CNpcnJT6TOYYF
         //QHWKAiM48krR12ShC+57fDUdNvaqB2FqgwOWE82zvOWJGyGJSVyIwF0Favc1PY0Yp7
         xr+N1Ah5LILsOB7crGMtHyXDYZAs6k2dKcSK1fCUpSELLuotXd4VyyS3m/9IKDiCt9Uv
         HBO4KDFFz6HG5i0t4WbiwF6AaKclGqmY19+UtksKUGQXvhgwT5zwK3/+wtQsirUnkSfS
         kvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IYHtsqgFcIUIvfYQbQe6IeYMlZr60r15jL45TpHiEIQ=;
        fh=LgeYnhBTpuS5moPSr1VlCSbe9iw7ciqYtrZ6UNByRR4=;
        b=gMUGD5wBOZ7VHu0d/o/QqiSNzPqyLMICJyRGs/YmqaaNaMOf1XvQySv5wqcXfOAvLO
         LaX6FXoXba2yfuIIvcTg7CtnBYzAvlM8+0E4v9xZhM0UPnhEZfKkqdBOt/dQx8TVwavk
         VT+LmQgkcJzR1M3c4cNDJ6NA4YzG2yZR9M99yyeYi473+y9DqLO16XkqrdfIEIl/c5yx
         6VwT/ruFE+Xk3tJ/Xsl77vemLp9E3JUid+saBuIc/5JjID0b28tIcAfRfxlkxwmxfBHw
         1BFv9Ks59G/F/mPXRZHNvGIY2+7sFaE/36oDhLqynZUregZMoZSPrYGFnFLcXA+68tQn
         83zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769309648; x=1769914448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYHtsqgFcIUIvfYQbQe6IeYMlZr60r15jL45TpHiEIQ=;
        b=MvMahlosfmiu9qXX45IgvGREP0NfgTiEhyhG+av4sfaiIpgRXC7776EGKoKQsGtZpR
         iSqHcisuY5TiLDSVFrZBYV50LwO0kU3mXEmIeTw0FRLlpUkVvCFD6S8M7eSk1oXC/iFo
         IhLCWC9uax9v1QUjx5hDM683NIhifMuA3QyDAFiraEYwEqBemaMHg+TyEc3t4J4UtxaY
         I5iAzvbhHBU2Xa2MnTlWOGMP7FxmD84A4DT0gE0QjbqqO64j4XyfDk7uSWS96zCETmIb
         3cTOlrQa7/V8Sdf1Uo7wkQJasR11T/rYcV/5oOKkuvnXzZHJqpnGgLp9cb2KhRZmWP9N
         HBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769309648; x=1769914448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IYHtsqgFcIUIvfYQbQe6IeYMlZr60r15jL45TpHiEIQ=;
        b=ouxysJ3zBo2CFutw8EUNY5pcdCLoSffclI3hlh0j0aQE2TZOaJnfty6Hcm+FD6DsEw
         hyXTk/Z0nwL4LB8uGXe7jttLz+Tkhe2M9PzsoHd4RGFwUHbXn8KvVge+QJg2/WgmJdnA
         lOzjN4pgeEAbIyNPd4MvIClbHZu3W+QALtf/ayjNFbxTKvweF1tGJk3vt1F5YJ+ohOxD
         4zaGEV/LB0+eAoA4e8ZgkgR6j6F3dURMNHlJecTHbGpr/cWsOZRK6y64XokMBkVpfFQV
         OqGj+4+G0lLnJTXBwA332n9AvisznJdClo6KlyhoJREBKSHZDSstqXOmh3UOu5nSx8Vp
         9qdg==
X-Gm-Message-State: AOJu0YyAR1gx9wrr1PRyDDg5umr3pd152wgXPWJmJfAWwwWJMXqCK7bA
	agi8ZQs3aTPwXH9hiPhe/04NjCzzdEsqlYwJVMN76f8F3HLazz/f18heKK97rOIWFuJ5WrYwTJ/
	DpaEBp2uGOEkeuIM23+bzpWm8xU8tlN8=
X-Gm-Gg: AZuq6aJiqA9ghmOj8KKO97gMnqQwGaqcN3X+37WcoBdGvc2xdF6Jyh898MnTkQXI1Uz
	K0jrudJycXTpeJJFpB5dTfegcOzrQ9XwxzfbMGMQCcGbrgque+GdT1w+tfL4d9u2jCMwE5gY4TP
	EV6Sjy8Q2V8DLGWL29cEmBpQJK4uuFZYwmSowciBofwwhRRS1mK2jgDD1MaRiU5+PgEzyvroHz3
	ckr909G3nsllcqrwgrlpmfkB+TOH+f+aiNbYRA/JycBq5mYVoiUeaLDDTv8DgyKygFOzB+pbrOp
	3Ye3m6RriuTfc3jWq1WW7tFR/UgAW5N6n2Zuf6Kk5PqaAPoBPJXedUt1
X-Received: by 2002:a05:622a:2c3:b0:501:4f3d:1469 with SMTP id
 d75a77b69052e-50314c55495mr7134931cf.52.1769309647832; Sat, 24 Jan 2026
 18:54:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124080136.75619-1-enelsonmoore@gmail.com> <8d17a810-9e74-4ef1-8fa7-3267a8678b40@lunn.ch>
In-Reply-To: <8d17a810-9e74-4ef1-8fa7-3267a8678b40@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 24 Jan 2026 18:53:57 -0800
X-Gm-Features: AZwV_Qh5Nj-aIJJF_8HJO-NJrZ-96KaDX6vGZ_IV7_FiqKa5dzyv_xJzN9TZ2Uw
Message-ID: <CADkSEUig7Pp66nDx5ch+txDfNcbLj1wRUbC3n4a4pBuc9mBb4Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: usb: introduce usbnet_mii_ioctl helper function
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Korsgaard <peter@korsgaard.com>, Steve Glendinning <steve.glendinning@shawell.net>, 
	Oliver Neukum <oneukum@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Max Schulze <max.schulze@online.de>, 
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253127-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6A7F97F895
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 10:48=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
> You are doing the same as phy_do_ioctl(), but for the old mii
> code. However, we also have phy_do_ioctl_running(). It might make
> sense to add usbnet_mii_ioctl_running()?

Hi, Andrew,

It makes sense in principle, but after applying my patch to smsc95xx
to use phy_do_ioctl_running, smsc75xx is the only driver that would
use such a function, so it would add complexity rather than removing
it.

Ethan

