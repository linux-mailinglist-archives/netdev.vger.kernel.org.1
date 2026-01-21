Return-Path: <netdev+bounces-252073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENGuAXRNcWkahAAAu9opvQ
	(envelope-from <netdev+bounces-252073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:04:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 446FC5E74E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFDE44E0FED
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7294266BE;
	Wed, 21 Jan 2026 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lnc/OCVx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48E428852
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033069; cv=none; b=nGgfE/9RrkefxlvIfM0Nzl7kH0SPiHgf+1pClich0d+QIqaIHvdHlB7JGuhOcNkPU0/rWDrF9NMcjvkGu2IKuELLsKNwigA4cCW+QzJwwSF8x3qrW+7CpmGrDnLO58cCK2TyKWodwqYbwdkhgv3n62cxAyYT7GSmM2jAHJsn+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033069; c=relaxed/simple;
	bh=BPC40cd+PK6beKXkMEkAPgW8Vuk6zBAwXi60FwrFXDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3TSwfdMqTNc7nqZXxDC8XY8SSUPXaKGU54gRMyPuWnnCh8qfAkrSr4Y94knNPD/7ckrViAfyMpZJNxTEbsrhFo+Qhw/UmERs3961s8JKMXZeTy1AZe4CLqE/YIDV3ICyYFsELbh2V8JRiPVORUSyYWo5ifMnZ73DBb7Hc5wOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lnc/OCVx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801c314c84so3169845e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033065; x=1769637865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ68qOu/lJJCVxKn/HKtPSCAAtAx0dItgoT8Dw3lvcE=;
        b=Lnc/OCVx4gJnZ/x2tFPCQgcXmDatmD16iiKDPuMLI0gEK1O0lsFjr5I/dukAODtwMD
         +KxvBiUbQLJiayd5eR3ePPd3pKxFrptiCURDoW0YHhfOHz8nwFyVS6V3gTFeoM7D15/O
         3A2kBjXUon0I904hqTm5S14EzBoYiYHnmHz2ifopkmCKaTTeYBQUGceFSzq4bkcxHyRU
         Fo1wBVblhit2N3Ko+3fYX4ie84/zFjQWPtmvFogS1hvshclw1rFVQxdVVRrE8D1l9dJR
         J1amcpEbZEvzuHKTLHoU5XIoHHKk4iATqQSD8BE0lJVoYnAoqYKNvn20DBiXWTEAEQZg
         ruTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033065; x=1769637865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJ68qOu/lJJCVxKn/HKtPSCAAtAx0dItgoT8Dw3lvcE=;
        b=n78F2HP+a/EcYN5qFKGkdNkM0dbp/x+MY7GwLqp9SHAzokmM/6AG/Iv0d2oHYsNZaB
         4C60oU/fqgvjvuY2NIoTbmIo2iXxggOjEJKJVUlxEpdQHN18sHzJcFp2d6Q6OkY75AfG
         vUgDTRWqbcSZL33OaxoCHzOpSIqAv2CmwaEve23bWIGUtYTOkAFM9QSm8u3lctaAawHN
         W+EEGkxyLqKLaP5ePOomG2SX+iTkXJTgbaN23Gmy79QqXEdTpc5IV8497jpUlJahlHsN
         owbQ9P2YopJxgILxCREJsq0epLrTlmwQKCwV8P1u+B1TisLbnQj62TSHLXSlYRDnC+PQ
         tgdA==
X-Forwarded-Encrypted: i=1; AJvYcCWtsghbjacqAcoxreHC37JjHTlcKr5leUqHkRprQKdJBEqfsxZOwyBPpyEZH4d8EZ+PMo45wGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9p/HxeFB2pF60h21GCvyZIesn5jDyNB3KI0saIdvCkhXwWbR
	0LbiR8pnJKG7ZRy491DP4KYJom0JLxcVv0od3V//E3YihArWdGiP96h5
X-Gm-Gg: AZuq6aIkdAI+WAUF7GAhaI1IeqrmzkzdYbw5LU3Xe9yLg9rdoLLE33BNbk4SII6Mn2Y
	d8GLjDkc2V94Fh0Yxj3PMUcdH7BJGejD8fVHtelTqbnfGgqlBfaBFBM6YRUlKt4snOBviYubhqN
	EkhblNnjWuL6iz8ucAXbk4/edtHdThLn0V9AMMB6rOUWJmUbd4Eu94YLtuhZoxoQAA/arFf76gT
	XcA8M1QSHwTEy79q8pS57FV9H+JOt54kwz4eqOZcjzHNxFRUQzwHeGD2alBcVw2j3QDaauO80m1
	bWjjMRf6Hu3C+8hU6BurlC2qJBOY6VJRlV+EDylLpB4b57oif2pYFJFx4dZAYLfrN+BEcYCVwkT
	LmETBRQqAbwgUK9mljwUJ9MLdu441UVtzbE2OErG48PXf4wNaERVhYnFWGQH/42NzobVzSHTMli
	zhZ995sg==
X-Received: by 2002:a05:600c:8b27:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-48022668fd4mr258559955e9.7.1769033065384;
        Wed, 21 Jan 2026 14:04:25 -0800 (PST)
Received: from archlinux ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356999824csm39410535f8f.39.2026.01.21.14.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:04:24 -0800 (PST)
Date: Wed, 21 Jan 2026 22:04:23 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 7/7] selftests: netconsole: validate target
 resume
Message-ID: <aXFIk1L8G_dHF6od@archlinux>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
 <20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
 <20260120172057.6600eefe@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120172057.6600eefe@kernel.org>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-252073-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 446FC5E74E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

On Tue, Jan 20, 2026 at 05:20:57PM -0800, Jakub Kicinski wrote:
> On Sun, 18 Jan 2026 11:00:27 +0000 Andre Carvalho wrote:
> > +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
> 
> There's too many of them now and they keep failing on real HW.

Since these tests are only using netdevsim I was a bit surprised about the failures
on real HW runs.

I'm suspecting a race on my workaround to trigger reactivation and these runs
potentially running on a host with systemd with MACAddressPolicy=persistent as
I'm able to produce a similar error on this conditions. Any chance these are
running with different configuration then SW runs?

When the device is recreated with the same MAC address as before, there is a race
between my workaround and the resume. netconsole will immediately resume and UP
the device, then my workaround goes and:

ip link set dev "${SRCIF}" down
ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
# Rename device in order to trigger target resume, as initial
# when device was recreated it didn't have correct mac address.
ip link set dev "${SRCIF}" name "${TARGET}"

The problem is that the rename won't resume, as the target has already not deactivated
and nothing will UP the device. 

Doing "ip link set dev "${TARGET}" up" at this point should address this gap. Alternative,
we can skip restoring the mac addresses if they are the same.

Does this make sense? Perhaps there are other conditions that can trigger this, but
running it with MACAddressPolicy=persistent is a reliable way for me to reproduce it.

> We'll keep this series in the queue but I think it's time to move 
> the netcons tests out to their own target or move them to netdevsim.

Given the above, let me know if you prefer I send v12 with the proposed fixes or
a separated follow up patch to fix the test on HW runs. Since you mentioned keeping
on the queue I want to make sure a new version of this series won't mess up your process.

> With absolutely no error message getting printed :|

Yes, debugging these has been quite challenging. I'd like to improve all netconsole
selftests debuggability in a future series, looking to work on this as soon as I wrap
this one up.

> 
> TAP version 13
> 1..1
> # overriding timeout to 360
> # selftests: drivers/net: netcons_resume.sh
> # Running with bind mode: ifname
> # ifname : Test passed
> # Running with bind mode: mac
> not ok 1 selftests: drivers/net: netcons_resume.sh # exit=1
> 
> https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/482560/4-netcons-resume-sh/stdout

-- 
Andre Carvalho

