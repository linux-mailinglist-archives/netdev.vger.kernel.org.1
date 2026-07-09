Return-Path: <netdev+bounces-306018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f0R/Nh74TmoMYAIAu9opvQ
	(envelope-from <netdev+bounces-306018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:23:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4077472BAA0
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 03:23:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GbScoS2O;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306018-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306018-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 357A930584B9
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D861C395ACD;
	Thu,  9 Jul 2026 01:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672AB38C2DE
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 01:22:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560143; cv=none; b=gIGPX80E/A7jS7cLDfc84QQlkNbTpO8639/tLuUJ142oOH2FLSM05ylO6OUZT1uLk5tKmc4wtQD5gFXGX1/rU8EXmaTpVlrR90427mrgqfvywQYYaSBHfMioEDaTZMKcQP1Hfohsjzkhk2DE1NURZJfjJKhKFDGhGNqyn9WrJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560143; c=relaxed/simple;
	bh=C3NzKl7R8jEudJ1vBCLGnRxXduqEmYcQCEFZ+/mUdi4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IjKl2DVzeLtGD/DfggLMmUtLdCQ19zLaYhYt1YlD0C46+siFcTj4bqeXKa0MQfC/5jNP0AqWp333lboWcxLw6n9FJleQb40Vx9Tm0HSjb4KRD2BAGeQnWuq+jc/fpmzukGWfXGWqxTO45WG9okDdD4qfXSDdz27zKl6isBdqhqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbScoS2O; arc=none smtp.client-ip=74.125.224.43
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664c535f1a0so577633d50.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 18:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783560141; x=1784164941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=67xPiCc7IoK1MebZhELUS99nIxtEFCS5kPqGhdt1OzU=;
        b=GbScoS2O9946NWQYXZnysCstaxtNBfQCzw1w0cRQdCj2omccylCFulXpJu0u9FWgoL
         MRqCO8sX0SHRA4DtVr7H1Xbx65vJHgjGdHNkLJ+kdeIyYvy/tntJGvyDTN+hrZZ45+rd
         LxJg1icMIRah+zr96NWnCLxDA0kYu2EpVQSsjImXGrkULw6/bisPq83/p0O3y5mkfyog
         rFedRlBWJiWDsQqILd5VvivOGNJGRee+JenoyQfLfyuceUWFhLAmNN3PxZ2hrL76eugc
         ZseQo/P0QHjmLeZyM8g0RlictLt22lHtPGtlgOLBz7iD5VBqUz7djZuwdsEgaWKCsuN0
         O+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783560141; x=1784164941;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67xPiCc7IoK1MebZhELUS99nIxtEFCS5kPqGhdt1OzU=;
        b=a6QwdFb4HacL1mQ1gvOceeOXk1GZ+WBxXPXKk507JjXjMD3pjD/n+NRyhXpMn+oslN
         MoMc1z7MTh7N7FxjI0il+PFhz1VQv8dNiFsPFHZVCCsm93RB70e19Qtezf3ki6eP1J1I
         YefHi1rnFQFalO8bdEcsSJCF13jBAiGzGtw7jyJQSCTIwhqTy8VLrHU5nLahtbBSJJes
         /+mg3lk+9fLyDSk5fJl2OYVHFwsqWq38ea7LoMAdmDULY3ftgJXxl6eky2+lR+S3gm4V
         tYTvr4Xkv6ayN0vyj08qZmixv6BWJEDHFTg1vBBlfbJzWfJmz9MiztLMoPtH8FGpEI2i
         92tQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOF/VXB54IZnVg/3aSG2I41yu/jA7aYsboyb2J7ADZrbGWXkdEC1DUX/pDTAE1CBSuAG//Rx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwljqAmcsefy01OHh5REqA9Vs98+ADKDTjXlmn98v3r2BoXq30t
	az+xY/uPFt6d1dLy9mDTkKgiWKBQpRqNop80Nhbj+HyJNhrtM4uSE+go
X-Gm-Gg: AfdE7cn+7YQQSkByohXFZa+i+1jcf0/6qvm4SH2FYU386I0VqTAo7D2P2ALK+bMNc1n
	ROFphRAKX8D0/wtEucNkQ4ZU5t38dED5jJR5aP4qCr2YtpAW3TUwSOPKgRRV7CylEp/MINttsrC
	OjyFHE3VKp5vbItQs9dGDXqNbBPPGUFS7aIl0l1kG0Xgln3G9xJjGM2/csQOV7DyqzIXbjlIKpT
	ff/LXOO1pX1E0WHQhOHLjr39+x4Mz8CVyiqt0nrbEKvUxxV216mqy09b8UrbYk+wSUMfcaZnq50
	HDrm9r3pgiized4EPZhK+sZbhy5HiXrR5aJegaV8v8mRl9fzZmhdFGf86oVNwHHXekeGAX+/OWs
	z0R6DKKisS5Fd8jM36OSiHbJO4+nKe+b7FG5JkIXfyLGqmi16HxOAWsPrRbY5MdrcUpf+2R0kwz
	0pn5N2oupwYDpSrFFrMlUE/WEXfBd90AL/D1j5VrdCBOf3wXKVb6/tvB4ayiZyL1dcLg==
X-Received: by 2002:a05:690c:61c9:b0:80c:3848:bde2 with SMTP id 00721157ae682-81dbee6d64bmr39120257b3.32.1783560141411;
        Wed, 08 Jul 2026 18:22:21 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1a5d16sm5860997b3.25.2026.07.08.18.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 18:22:20 -0700 (PDT)
Date: Wed, 08 Jul 2026 21:22:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.b213c4463b15@gmail.com>
In-Reply-To: <a5b65f092d22a12b52fc536c0565b948cd8ecae3.1783372173.git.littlesmilingcloud@gmail.com>
References: <cover.1783372173.git.littlesmilingcloud@gmail.com>
 <a5b65f092d22a12b52fc536c0565b948cd8ecae3.1783372173.git.littlesmilingcloud@gmail.com>
Subject: Re: [PATCH net-next v6 2/2] selftests: net: add FOU multicast
 encapsulation resubmit test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:littlesmilingcloud@gmail.com,m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306018-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4077472BAA0

Anton Danilov wrote:
> Add a selftest to verify that FOU-encapsulated packets addressed to a
> multicast destination are correctly resubmitted to the inner protocol
> handler (GRE) via the UDP multicast delivery path.  Both IPv4 and IPv6
> paths are tested.
> 
> The test creates two network namespaces connected by a veth pair with
> a FOU/GRETAP (IPv4) and FOU/ip6gretap (IPv6) tunnel using multicast
> remote addresses (239.0.0.1 and ff0e::1).  Ping is sent through each
> tunnel and received packets are counted on the receiver's tunnel
> interface.
> 
> The veth pair is created directly inside the namespaces to avoid
> possible name collisions with devices in the root namespace.
> 
> Static neighbor entries are configured on the sender because ARP/ND
> replies from the receiver cannot traverse the unidirectional multicast
> tunnel back to the sender.
> 
> The early demux optimization (net.ipv4.ip_early_demux, which controls
> both IPv4 and IPv6) is disabled on the receiver to force packets
> through __udp4_lib_mcast_deliver() / __udp6_lib_mcast_deliver(), which
> is the code path being tested.
> 
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
> Assisted-by: Claude:claude-opus-4-6

Reviewed-by: Willem de Bruijn <willemb@google.com>

> +setup_ipv4() {
> +	# IPv4 FOU (CONFIG_NET_FOU) is built in on kernels configured for

Instead of this distinction and modprobe for IPv6, also set those new
CONFIGs to =Y, so that the two are equivalent?

Not important enough to respin.

