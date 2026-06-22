Return-Path: <netdev+bounces-301196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q3qmH7CaOWoyvgcAu9opvQ
	(envelope-from <netdev+bounces-301196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:27:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0415F6B2421
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:27:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=QNFstsFm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301196-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301196-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2DCC3055432
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 20:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3BE34D3B2;
	Mon, 22 Jun 2026 20:24:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD2347533
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 20:24:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159843; cv=none; b=SU+mQkZMiq8AEHHqiXtRRaNwOBX3Fh487/GBaJ3qpDnOBU0/zIK5c2dVfdjimB4SYk1rfs2quBMlsBYc6PKscKF7v00cEtaU/Jy+zCuMpRJ1pEh61TzvQw4AuiDyaDLMIY1pYbi/cE+DtoUL2DRjLyCvHSzukML/zt1uQo5zUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159843; c=relaxed/simple;
	bh=H5cpwCepsxhixKLNTuJkp0Y44Iv6O2UiPDuOJDmxpRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kDuFZCosr8pEmOiT7fHCjHkEXLupiqv+Ce6GRKm1F9r/ZTKydOKCiZJEQkPG9wqreLIAlDwpEXohu/ItwKieymRNFcRQdx19zdeZPXYXd0Fz4LyCZytbrdIz9Ii746rOyyixpUmJ78WgemLGsfhEK+xyB2P4zLBP0UxLIk6Xazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QNFstsFm; arc=none smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-696bf0e7c9cso657997a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782159839; x=1782764639; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/IySwbjdjXdYnWQzeR8fepg9364jfucwrDIdGzLDupY=;
        b=QNFstsFmVAHKlcPRfWohAHiPOQvVIdo2TmyS8FBnmQe0qE13iQXfKI4PbXJJt/E628
         IsJpjN2cWcYnTiwwhEBoRRztKYAOW1gih8KeVZ/PDycG5RMNcMUc5+wE5qOHlY1BuILo
         hTRXKXHgk1/l7wl7WzkB8ySa+4uRTVXc7umBaiRwzJUBywC0Jn67py0C+YRzfKI0G22n
         avngiBFBWBRQ8Ri+RPVjnOaGuBpYXt+Jg0YXwGOUZ3soD+7L7NuT+eRaU1IpTJiG1hAQ
         LhN6JJ9MAXo3RSTsUTgXw6DTSFvKOqem4GFwex1tnrg3p7fp4mL/1TB7/C6VcohbNr89
         t6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782159839; x=1782764639;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/IySwbjdjXdYnWQzeR8fepg9364jfucwrDIdGzLDupY=;
        b=qMEvVKmbeHfiFrO6C7LMgnXhZgSRcEh7r/kGBxfWNAUufRoayqycv9Eb8tK8/WVmf3
         gvHUUcrGsrgmQsqapeQwDoF9WqT9wYNkkKWxmjwdD16vtHE3p9cnn9rtQqZ1cB2jld8Y
         ZUOM6n0BYeRxwo7GHP3cLvhp5KJS9zpaLhibDjIVKHUHJaivoQ4zXQsBAPhjatAVzR+D
         45c9Hd00reRkbBlyYoSbSrYK17DxTfZxkPqghbsiVj+TluXvm3Wc3vXK7IzLSUQnndQP
         SKvt9rbarQhHJ//H5QAZfxHhq4isLtMp/e+s76oPXSPO1BKT/vM0WihxcNAzRaCJx1K+
         IiSA==
X-Forwarded-Encrypted: i=1; AFNElJ/dfNA2FayfFl9sONoeZhmnMg3wUDq1Do3H5gF0C7v7L54kSJ/3MoJx/EGqVDsWwz1tlGY4I3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV7vIgeXtGVBnxjDjaPijEZOGzSRjBfZWEjUfwF3rkqrkyEPWV
	AWPEe1wqlPk/uAxaKKqHxbXwQBafSha708HIJlHeq43ZWjwydckcs9kaQ5pHiC6fCLg=
X-Gm-Gg: AfdE7ck396S2LPQNGneeU0Hb0/TL4NcUruWxodZipogga5n5IcSyeKPuyNcFovZ9ARE
	Od/lcMR8c8XJKVmyKItQgbKd6Gi25ugeg+ys33Niyrd4pUN95dhHwrcFDCAFFPQbLAPU4xA18yK
	ouU0KrkoBMyDV0+TG5yvrWqEvsr3x0gnvTxW8TFdczesmx7ZB1f8nDI5I6foByC3dhfJkuQBPsz
	BCf8J/ZpNxvo4PfvJ3AeL3fbk8LlNBG0r94u6kS8GV3/wbi+csAEi7ePGmzfIVrOcacBzDY/sYP
	3Q7vZSm4/g9lvrH1b5k3NxOdL5ArMz7U95UmwA+kHMFLZjzFPgbjaA0ymN9Vl5ZaoBS5eTrN8tL
	1ANVN/z0C8ah6QBgWCJSIFwzX0cK8kKLasJxMsQyP0OK2Lz8cSXlvZVqgUyklw9/rQSZzpHg0W/
	3oXWT/YSy5IRcvOPY=
X-Received: by 2002:a05:6402:278c:b0:697:83e1:5ef3 with SMTP id 4fb4d7f45d1cf-697d4317020mr518300a12.14.1782159839361;
        Mon, 22 Jun 2026 13:23:59 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be31ca1sm3633269a12.19.2026.06.22.13.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 13:23:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: ast@kernel.org,  bpf@vger.kernel.org,  daniel@iogearbox.net,
  jiayuan.chen@linux.dev,  john.fastabend@gmail.com,
  kernel-team@cloudflare.com,  kuba@kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, unix: Guard sk_msg-dependent code behind
 CONFIG_NET_SOCK_MSG
In-Reply-To: <20260622161221.1742161-1-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Mon, 22 Jun 2026 16:11:40 +0000")
References: <20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com>
	<20260622161221.1742161-1-kuniyu@google.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 22 Jun 2026 22:23:57 +0200
Message-ID: <877bnq4942.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301196-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,linux.dev,gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:ast@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:kernel-team@cloudflare.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0415F6B2421

On Mon, Jun 22, 2026 at 04:11 PM GMT, Kuniyuki Iwashima wrote:
> From: Jakub Sitnicki <jakub@cloudflare.com>
> Date: Mon, 22 Jun 2026 14:58:34 +0200
>> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG.
>> 
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  net/unix/unix_bpf.c | 6 ++++++
>
> AFAIU, everyhing in this file is for BPF_SYSCALL && NET_SOCK_MSG,
> or am I missing something ?
>
> I feel that it would be cleaner to add a new Kconfig that depends
> on BPF_SYSCALL and NET_SOCK_MSG, change Makefile obj-$(CONFIG_XXX),
> and guard .psock_update_sk_prot in af_unix.c

What I'm aiming for is to have all code for sockmap-based redirects
behind BPF_SYSCALL && NET_SOCK_MSG, and the rest, which is the
implementation of sockmap container for socket refs, behind just
BPF_SYSCALL.

You're right that in the unix_bpf case, the whole file could be behind
BPF_SYSCALL && NET_SOCK_MSG because while you can keep refs to Unix
sockets in sockmap without doing redirects, it won't be of much use
(there's no sk_lookup or tc-sk_assign).

We can add a new config but I won't be able to follow that pattern for
either tcp_bpf and udp_bpf, which are next in line.

