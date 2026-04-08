Return-Path: <netdev+bounces-276210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJfeCu6d1Wks8AcAu9opvQ
	(envelope-from <netdev+bounces-276210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:14:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D903B5A51
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B08C306971A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 00:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3213777E;
	Wed,  8 Apr 2026 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdVGUQkX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89BD72622
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607171; cv=pass; b=CuN0geXgROrr5Q+NJKqdstV9Xv+/Sg4hDKPF4TVDTdeN8sx7HPEdYZjmKw6NfBctWj5Tw2YACPYvHjVJenXIlxKkGClvgMK6oNN167BSvhd3uW7t6YYSE0h/MYjGv2A9O5cs1Ddu/QvvlhC7qm6Q9I2jjH+husmPkdo4eUTN3Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607171; c=relaxed/simple;
	bh=Hq5a+9Z7xklW4vTTDEilr89dxjbEY3dhoQCa8Qpb0FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUp5cx6IpOuZbidlKLxAGTbtAy1kZNNDvrJ8qVc0hhX045tAa9N184qRqX++x+c91V93Jt5fAhlI1VhrIAMQLVY0Xzy+sr3CTk+pQ+XSYvvTmqN+fAXiMFUBErwq1ey5CY6xCpgdfDsjs1g0WCnde3Dlrl5wv5DSYngPs2ArBYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdVGUQkX; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso2792a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 17:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775607168; cv=none;
        d=google.com; s=arc-20240605;
        b=DGqA9LdgXfe1tyyoSb7LLpWm0yIkpSjJWGPy9z2F+cUEAs92EgEHYzAhQsgS6PGcKc
         YGKF4FBkc3O3s624JmES8XwnTYUzS53aIj+hyN3GuDyJji470rstb0INitEJUSGlnUnX
         5zLmfdYnfFM4cHPUgEsZ0P8MutjFuUNh88tvrsPH+cdvXEAhAK5DNVi3qXvCwodvguIW
         QdLY2EJr4amJL8wc23AUJYDCFOo/2i74PUOvbXq8049Wd09zURESUmtmWmLl9qbf6k7z
         LKdmida1+13AnIftGyozzDjWTxY2HWJHocGDvdX+g1+f5IpEq5InVnWSZ+iqtBUY5TEV
         VOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hq5a+9Z7xklW4vTTDEilr89dxjbEY3dhoQCa8Qpb0FY=;
        fh=whJ1M2Sd89HBEiP/kLTqFCYRoRdlU0ogyvWNIrlhwFg=;
        b=dXV1/srhHQJaHmR63DRGRY2W6+ElxiYR9qG6SmbVZZzYo1eQI75zPCC5w7RUos7kZ0
         YuBqGNEhwNRqgEc0ErLijTPerOvR7KpgWjJ8fVJvs5KmM11SU9UjEkTbbSK5wEoPj61q
         m9RdqSs4VbstwP7mITPLjgunQMNOvkHY6Egu5QumpNP8xt9shaIRBvQa/i7Vglnb0NmD
         ifL/XFNrO5vkRLP4jVXjDuQkXmDHA7n4DViq2f8kaQXpWtvPtODVsHxidkliod2oZht7
         pwtmWo4aj6XjtauZnUbxxP4yjtvD1Nc2Y5TuJl/65ZcBqPJWwhngBG+qBpGWjvCU0G3o
         D/EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775607168; x=1776211968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq5a+9Z7xklW4vTTDEilr89dxjbEY3dhoQCa8Qpb0FY=;
        b=pdVGUQkXDMlo1yGRpdb/bvNUZbVs/vtDUnnO3ETpz8E+rUYIWI2g7CioMICQovsd2g
         HH0OwNEY072akA9bXKXb70za363CrdRKi71XPQ5kMajEx8DJv/Y6V5AQfqBrAfBTPFlC
         FhwUgcLzJAalDQJc+4x8gKINq47KiKOT6KHPU+0f4pRsK1nrGyTEjfJzgzI7YbIfoqkb
         0iTpv/6YXi1qIItHFW6wKVn1QnMONLdtgYls+AlldbRqCCxJbsauK7QwmeP3+XkpPaUe
         TkirifTxX0sc/8GXAPMxP8fB1rI76NgHzqwl2CggngyCDNyiolgZ6EnJCsMo0gxV/gq/
         /EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775607168; x=1776211968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hq5a+9Z7xklW4vTTDEilr89dxjbEY3dhoQCa8Qpb0FY=;
        b=hc0VYW0euF99ffys7vww/K4gauUA5W88uemgDcs0vW/Qhl5ZhQM+9wFL7kRClF5njV
         jUdQnVsF6uP+FuoNzVTLG23c0lq5EC+WvKwewWHVSMVZVq7FHL8bYh6wfF+BQUaSdG69
         BINZMUn1takHemNEIGrRMrkFTn9sSxXkA93hByuUgEahqwCiNvHEWDCtZ1JHG095LQld
         ifUTlo8vnGSDwNFQycT1Njsq2m9ZyZofGH9zdsj8I82gmkrZ0Q6ha7rKPoXxpa0Tke60
         pHAFVpglBt66UV7ociPPG+d74AJNyJr9p6abmYZSiHzQxk92dOlqIdySOxmwaBoAY1Hk
         9LTA==
X-Forwarded-Encrypted: i=1; AJvYcCWeDBJacw3P16NfyuIa2v1SufM90PVcY33cXGWD/jQSv1onWAikSpt4BYzEKWUOKZFIe01WU2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2GXsxbV+w16w4CX/e3GJHIws4tKV4xtiFSXEvMvrP38Fs1Wa
	9wGcUMpJ6+CLwfRQ3eeo4Yw/ZsfpP6xrWva5rLkSoU4PCKb+9Yakbpfv51ES84UkUp8ImQXDPkq
	SizFhq75WQJC59aCQbM1Mq5QbPA8juAeF5GtPBVbK
X-Gm-Gg: AeBDietPtKFYwnHeisBSXo9CYZqGZDFedDLYVIzX2653VWNM8PxjIcOtfB154+0oTIE
	oqYt6m5+cqlhwRkG/2tF8G48DsruGyKrJVT0k0BQYvWDmZDjaqdUABwNAOgwoAsfQCxbxdtwvOi
	LRXZTut+rK557BDSYtwPi3VIPaMhO2isvaOK1U20AJrLquZEWD4ZW3oh0uJxc4nivEdTVIaun6i
	Z1+np97Z6Urnn209Tzt/3OBIsGeMmRL4qcJ2Tb8P8azJJJmjNBN4n7CN9l8THqxvT+HyqwUfXx+
	3VPx7RJsMcgl3fjijCklDpF7sbybS8WQx6AKSXjvTvAkta88n3s5YZRZjpjE6fh8Og==
X-Received: by 2002:a05:6402:400e:b0:66e:e3f9:ebb6 with SMTP id
 4fb4d7f45d1cf-66f9eb0e641mr15274a12.4.1775607167874; Tue, 07 Apr 2026
 17:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com> <utlz3oebjyd4lqp5pd4qdbth2kywxo4hrlrnwcxsx3br76fwfg@vy3tx5f3lv32>
In-Reply-To: <utlz3oebjyd4lqp5pd4qdbth2kywxo4hrlrnwcxsx3br76fwfg@vy3tx5f3lv32>
From: Marc Harvey <marcharvey@google.com>
Date: Tue, 7 Apr 2026 17:12:35 -0700
X-Gm-Features: AQROBzCE4KyLZl3QQoeKiTuqJ5qKwgmhvNqAUTtOXd9q7AJJ_ruBCFl-97d0z_g
Message-ID: <CANkEMgn80UM7+mymVm21Q8yszgVeh029tvO+kHqmLGmf-2MU5g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/10] Decouple receive and transmit
 enablement in team driver
To: Jiri Pirko <jiri@resnulli.us>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276210-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,resnulli.us:email,options.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3D903B5A51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 4:55=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Mon, Apr 06, 2026 at 05:03:36AM +0200, marcharvey@google.com wrote:
> >Allow independent control over receive and transmit enablement states
> >for aggregated ports in the team driver.
> >
> >The motivation is that IEE 802.3ad LACP "independent control" can't
> >be implemented for the team driver currently. This was added to the
> >bonding driver in commit 240fd405528b ("bonding: Add independent
> >control state machine").
> >
> >This series also has a few patches that add tests to show that the old
> >coupled enablement still works and that the new decoupled enablement
> >works as intended (4, 5, and 10).
> >
> >There are three patches with small fixes as well, with the goal of
> >making the final decoupling patch clearer (1, 2, and 3).
>
> Looks fine to me now. Do you have libteam/teamd counterpart?

I don't see a need for this to be used in any of the teamd runners.
Libteam should support this out of the box, since the options are
identified over netlink by their string names. The options.sh test
uses teamnl, which uses libteam, to set the new options.

