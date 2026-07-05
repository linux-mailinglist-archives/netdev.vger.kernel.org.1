Return-Path: <netdev+bounces-304744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S9DgCV69SWpN6gAAu9opvQ
	(envelope-from <netdev+bounces-304744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 04:11:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BD6708CCB
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 04:11:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HmKdtRte;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304744-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304744-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D202D300BC8C
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739CD246782;
	Sun,  5 Jul 2026 02:11:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46C20DD51
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 02:11:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783217499; cv=pass; b=OsmYITBY8jfaCRAUPD8s18ppw/U7oAtVStf0xwxt75wN1nH1XAK4hjw9dPiBFMwoEo+JEA+Q43nvwe62uAntFvtqChKGTf5amecUo1HFGvo8gxt8kI6uYMXCH9pmp7dr8Oi/mbqe8inHxpP/p363VttQoE7oSnDxoSp7vQQUHPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783217499; c=relaxed/simple;
	bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqVK70xLLb2wWO6DHVMFqw1TqrchNtwdzB0l2Vxx0vn5xept34/MvXVr0XUQoNcmg8eVuOwJLeQaC3zhLQfVdcQPfcQ59TPlg955BOG4TMg2iBjV9vf56zfa/7k5Ur/x95cpnlyhMe4VRbpZKOYXuVt9yn7NNjJ4GJ1Es374moc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmKdtRte; arc=pass smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-479b7aada85so1918550f8f.1
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 19:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783217496; cv=none;
        d=google.com; s=arc-20260327;
        b=ItGVqIEIxa1tQ58ZkGIH8c4hVEuztKKSlXWyZxL9yzW+MFAYKSjHhzxEo5o13Fty/t
         Oe7vCa4kMD8T6byZ0rqanpSVmjfsMOgkreDXDUl8FFK172iV4CAVqGAJ2HzflzuTktak
         W2Qfrrc5D7it6eYneGHPDFUv2bwnKKYmaAHGDxAqM5EhBXzTt5ll/fbOMmwsSu2/AUxx
         hkHHuWlZ3Eg3HBFnVy4VxtgiVwsp9OSLtnJ8KzEviQ+iF0wWQ4A5zwFCo6105YnwxqcM
         T8nLoB6suXErJ3y9T6MH50HScd64QNjQqFbr0wrtKp6bmj1S0aHD0DsRlQ2ubUB17z7M
         n5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
        fh=hG3SgtV8NExFJskVc8NpU2i/fuUHHrhnw4ZEoY0XDQc=;
        b=EJUTS/hU3fJC2wvs0rybq6DIw4S+0L5SoYDMg3Wqz1EVOd8/+z97FkFqeR0HyLCkgP
         7dlkzVqocDlowfz4kxeB1WXiLPX941zNz4Cy8kAo0JWeMTbxaNDvArawtJy8PWxoiJzC
         3VFyyNGsUD0qPTJMWDlqqSDGBEXUpoIfr5NaQCcXSgKlUi02AQRJBA29pZIDl1nl1vfp
         NFGDhT34dVofAh/Lt3xxYO2GpUIsdgyBvSJM1vSSgtmlzwOmSkP/eABqqPsA1Pd7yaxp
         h0NxU0mvOn9Dd7EyOodPHBxJDb+yfvga0TBwmP+hxtcID8XAifwBovboE01tXUdTukhW
         aY+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783217496; x=1783822296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
        b=HmKdtRtetM2NDeuyflLPyvdy/grl0W+ptN772MGAij7+nrHbbXhc2qymfD0Kb5PqMP
         ryLcrY6xh6NQjLQ2MJ9Fv5gSwpke/rB44sixz803C+m96rP8/YKQ/itznIpy8MUvMJil
         UUSjNEETrVFsP0dbmZGF0Tn3b4qcSpoYCEUkoZ8qq9Jn2sZHkelYODCB7QV6sqrdr/jC
         zrh3QMZ5ZSv+ytznAc9ha3cqn89lWqrCNun/9GbiRjj3OU2SMuSKLpEaytOpa/pF6YW7
         m8fTrMmEk4j/DFLdZuB5BdphHJLIgP/XoFSBOmiYaqx3yiClyxJBcS/hLRavFPyCBeaM
         ONHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783217496; x=1783822296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kxNPTAlLfcSyUWT9fknGJyrPuBuy2cw+GfowXjZrhaY=;
        b=UM02k9ODJ+LVmFkJPJ/3EuF8uQIgBMXi0IXRuIlQXSc/9niDZZXyNrfY4vusyKO5rB
         BpiodFCOEdjxEPYO2R6OiZiJSb9xMPcVa3Hn3cv84+r7AMg+C4KMGswzWH5cLmDNXlHh
         x0ctofqwZFV7WmCfZ/guEwug4lJS9FZoqkrumevIfGkZby3cG31qhZFN0ERJZ14uMBo3
         R2+VMpJcdi8a4rT65CGXxzGskQhIGGijQTg8Yn3PO0YOCvCbIQqJPkFW5TD5fzQr7Msw
         W++5W7bPfUCwlzIgYXQvG3/WkGt+x0OkXQh2KNgwlOitp4vYR9a4lqU8Waqmdcu3b1ZI
         wn0g==
X-Gm-Message-State: AOJu0YwwpMKMIhPAMDSv4Sbuht8KsvrAEcHNG026g0kyIzYiQbhfaKhm
	+4htuBaXVvPk//xjp8KUTmcf31LcRKRwtjUnds8RNMLopl22p3W9fs9F8v04pZSZduLVD7Ag3+1
	aklcH6TuI58xFJXYR7bfzFnjK2NDc3P8=
X-Gm-Gg: AfdE7clG0kZhFWnqKbXV3cZOZ2U0xYJv+iSBSom0BdLXjTBkfdDSr3vbF5aDMRHQgwK
	mvI8NNIWGVxRfq3s//hFsmBFvzBcwlATGjXR4aIou8fI+k/VKa9ZQL4p85JgabnHO9xCXGrCvmS
	0BvJ5nGCTsn+JxFQIQinC6/bQfIpkNGwC5rYu7IYIWP93DqJKJOciSuRsBdx+qAR1pNOBi/arTF
	H8fjwxYvZiGs/nC/RxrInJtd5tVItjb4He651Ct15bJfsfERmwSJkqygwwt7P94WRBm+g==
X-Received: by 2002:a05:6000:310a:b0:474:fd7a:93f2 with SMTP id
 ffacd0b85a97d-47aab961efbmr5621255f8f.15.1783217496219; Sat, 04 Jul 2026
 19:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com>
 <29129c40-4010-4862-9b4b-3bafad874568@linux.dev> <CAFk-A4n9U0r07tn6XHHqmOZ++-bmM4bSd-SwdpEU-88gjKts7Q@mail.gmail.com>
 <216969a9-3584-4dc8-9e23-50fc18b31725@linux.dev>
In-Reply-To: <216969a9-3584-4dc8-9e23-50fc18b31725@linux.dev>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sun, 5 Jul 2026 11:11:25 +0900
X-Gm-Features: AVVi8Cex59Et_09q6rUsvepTcxo82qiJkYVp8jk9ZmjruPc9k_ncvXD6H4LmGwo
Message-ID: <CAFk-A4mUijKffHg3QhOxC7Ne2rk_GVbYY2UJ-Ek497avdubzgw@mail.gmail.com>
Subject: Re: [RFC] xdp: add device context to bpf_xdp_link_attach_failed tracepoint
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	kuba@kernel.org, hawk@kernel.org, andrii@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:leon.hwang@linux.dev,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:hawk@kernel.org,m:andrii@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304744-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[masashihonma@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53BD6708CCB

2026=E5=B9=B47=E6=9C=884=E6=97=A5(=E5=9C=9F) 22:28 Leon Hwang <leon.hwang@l=
inux.dev>:
> Probably, you can get the 'extack->_msg' by tracing dev_xdp_attach using
> kprobe+kretprobe or kprobe.session, if the extack is not NULL.

Thanks, that's a nice pointer -- dev_xdp_attach() has both the net_device
(so the ifindex, which lets us correlate a failure to a specific attach)
and the extack, and it avoids depending on the tracepoint you want to
retire.

The tradeoff is that dev_xdp_attach() is a static internal function, so a
probe on it can break across kernels (inlining/signature changes). For a
best-effort error message that's tolerable with a graceful fallback, but
it's a maintenance cost on our side.

Since this is ultimately just an error-message improvement, and your
in-band BPF_LINK_CREATE work would solve it cleanly for all link types, I
think we'd lean toward waiting for that rather than adding an internal
kprobe to Cilium. Do you have a rough timeline for the BPF_LINK_CREATE
series? That would help us decide whether a stopgap is worth it.

Regards,
Masashi Honma.

