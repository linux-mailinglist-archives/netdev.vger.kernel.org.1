Return-Path: <netdev+bounces-271811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAZ9OZmdxGle1gQAu9opvQ
	(envelope-from <netdev+bounces-271811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:44:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 937D332E74A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA7C130238DC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1838E5C0;
	Thu, 26 Mar 2026 02:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5Jr3sSF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A377F39
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492788; cv=none; b=U+0Wzi2nk5znVQlX96zohCo5ca0bHZ41cWPMaiIBVJA0tA+0keEedBSomdO0zMDv/s5anief2w0XlFW1MlAVss9GnVtL8kFpNT8hxb9xRNPCeAUmRswHTYcvMVJg3OXnwkPvRluK5Qgd9fz9MYdc4iTxQYjlSZ8adU23FknABUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492788; c=relaxed/simple;
	bh=oFuA9HJCp2JlyvrW6KQhqav2hsUc20F0Uqi2S8sqkmA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=a4VOa5XiOFe5MWtcqHPni+PmnuiWHL/3TemslaYgG0oPIHnKffdR4zqMTM4bi3GmwMjhDLeXjRkvzGZJtIv7Es3W3Hk85Qq3PpJbWHxTjfWWI0YX3BR2RfO+iv17rTT7mC7tZV+I47EKyBVd421HpVgwcMkwsuzJ099ZHgyzbjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5Jr3sSF; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64eee7b83cfso461788d50.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 19:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774492786; x=1775097586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkKASDSS27GIMRV0i5mmWnYYUA/gqbOObp0Nx68p+B4=;
        b=F5Jr3sSFzM6qt6olpiFaPQHyixDsqRB6iQKwLiLCojGBU7Cej2RJLy1JdMogIsHxbG
         v09HU7rhILLB5bbM8hYZ6u40TAhpZ1Vx20Mz+Ui/pJv2nQXy39mYSGL7tqDBLCHYhlQG
         6heOp93kwyN2mF2wHrYOj9AbZcbwS/yCqYHNIBzrNb8WWdXJs4Je5S/ue/6MJFi/JZSD
         gKoJfh2VRkvoXoKuzZ+dLMX9fVYiqwBy6cYr5Xdcn2qe6BG/5qNDebA7BGmqdr44cTuo
         gldphnvkoQOkpmGixirsSqv/a7mOpknwMFZkmCHGC9GXQ6Vro+16xs+m7Mt+dESYT58P
         MzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492786; x=1775097586;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkKASDSS27GIMRV0i5mmWnYYUA/gqbOObp0Nx68p+B4=;
        b=ZOhXq6QKSS2qpIwS/2lq5iI3mJyT6KgIMuU3us9jqHJkKsgHp+5kRXA7y/cvUuPyNx
         +fNXJmGaJZ5c9f5ibXKX1oxoAhEhdqHCmwrS7zc3vqy0QsnzI98nVnPTe7ap2TvKbKip
         ItGaoB1LJqGeumi5ZVioa1elFYO0d2DCuvZKMB0jcD1+zxAvoPaqd8xIbofWgiquP078
         qCUS99Quf+Ny8w7iufszLccO2GKT+NMXKUf82bbjWH1tb+gwps/VbX4XIqLZt/umldjA
         T92OtbBXi0rmaqKKVyj6VWNMYV+bp1k64e++/zMAxNaReNvxPBy2U20dMJKwopF6OHXG
         /hHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGRfXhwg16GuoAQ/Co5/76hHit8ojhCDWlzcrp1cBYQeiR58Xe+VcuR6cXM7Mmc6E6wn2khAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDE+fbrCds0m/NfdnfvZtWhpMklsv9YyAgz2VakwUz/uZ5QuO/
	Lc1II6HEdiJ1e1BFLcfBfOQkrRKaL8zGuaM8aL/QHF8TkXLXykrJmPl5
X-Gm-Gg: ATEYQzw94Jvh5yFAMXiqfgPzGuXdMCGK+V5IAcl2FvQeO1bhHbaXtavkzk4KPHj5wU4
	9Fy2IKnmul2EwT8/YWQZHNHrXS9F8oQmi4Ie7r2wh6imqIiCpZOpdk4rT9fw9Zw6elWXnl+t2ti
	P2Zr1B8JEA13VSyCbrzXt+KBOqGjo2SzCrx67yy2GCZ23TElg2RYrI1uN9rrbf/LK4Tp0eJYE3X
	5NTVcw7i1NARGgpCSyHNxqvKU68Gbff9xDhA/OmTlzEvecu2ijuUcNQ7ZrjO/Wj05xh2Jf7+E7b
	rnmJLZynoEDvezKqtMi3TAIcp/4yjAV8ZCf1skYK18p1Ic4O0eUtErmPcAD2zOfssvQKwH6TxEB
	it26dGeEAjTSZ82A6XcBUdoKbr1+cC6dTeJozYuU1TWqxvAYDcCMxcTTbhgA+oSrqOVezIvR92b
	ATR+FTYW9Dp4YWMzXwNESMglVffBQXh6Ca9J73t1v2xZToCscxOvhxBOV0Up14rP0lMRvJoPbi9
	DjR
X-Received: by 2002:a05:690e:43c1:b0:64e:9dc7:90ae with SMTP id 956f58d0204a3-64ee612f985mr3789416d50.43.1774492786528;
        Wed, 25 Mar 2026 19:39:46 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64ef6c08f2esm868428d50.14.2026.03.25.19.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:39:45 -0700 (PDT)
Date: Wed, 25 Mar 2026 22:39:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Qingfang Deng <dqfext@gmail.com>
Cc: linux-ppp@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Felix Fietkau <nbd@nbd.name>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.f147059acc3e@gmail.com>
In-Reply-To: <20260325165910.5bd7416c@kernel.org>
References: <20260305013852.3769-1-dqfext@gmail.com>
 <20260306170411.49912ae1@kernel.org>
 <CALW65jatv71b7G6jpr4g-6j520RjLBDJMH8uta5MPJHmEM1S1g@mail.gmail.com>
 <20260309140127.465b6ccd@kernel.org>
 <CALW65jZv53Y4-H3civxZLT5RGypsKjb3JyiA6iy0pw-_RK-=Tw@mail.gmail.com>
 <20260325165910.5bd7416c@kernel.org>
Subject: Re: [PATCH net-next v5] net: pppoe: implement GRO/GSO support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271811-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 937D332E74A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> On Wed, 25 Mar 2026 17:23:39 +0800 Qingfang Deng wrote:
> > > > I haven't written a kselftest before. What tests should I include?
> > > >
> > > > I think I can add a local ppp server and client over veth, and test
> > > > the connection with ping and iperf3.  
> > >
> > > We have tools/testing/selftests/drivers/net/gro.c and associated Python
> > > test. (note I have ambiguous feelings about adding ppp cases to this
> > > file vs creating a new test, adding Willem to CC maybe he has some
> > > guidance)  
> > 
> > He hasn't replied. What do you think?
> 
> He probably missed the mid-thread email. Proceed with whatever you feel
> makes sense.

Sorry I missed this.

It's hard to say without seeing the code. Perhaps code it up as an
extension to gro.c. If the code changes are manageable, send that. Else,
consider moving it into a stand-alone test.

