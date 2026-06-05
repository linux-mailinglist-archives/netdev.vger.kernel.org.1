Return-Path: <netdev+bounces-295981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rn+xLkhCI2oFmgEAu9opvQ
	(envelope-from <netdev+bounces-295981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:40:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70FB64B750
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:40:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295981-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295981-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9312300E17A
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 21:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5DD3BCD26;
	Fri,  5 Jun 2026 21:33:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AFF30566F
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 21:33:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695186; cv=none; b=GA6vqMEwe5Ls1Ej8JOSp8gdfiUgiK5xo5ZaDhtn7AknFYj0PsvpfONrvN2+F6+YQBd1R+mqLD1UUjaBwFEgg3gllInk2YQ/eg5DCfJUiIOwkXMsC8z/FCbbQBRTXwHDBxHpAHCXlKwbqMZY5mqBwB4ihkOIdGd1+Y2M6zzJpCNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695186; c=relaxed/simple;
	bh=yB8i6L7KoJ6YeQ5x5SkEb3TWEe2vEfLFo8gyBr/eSF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqVfxUI+tFDaa6P9rIZ5J3M4s1r1M1XHioOgWCfjPh1M1gqVGAcsCnGmZDsh5LvhvPcnViRTeEA6TK3gMyFYHOyLPJ5MVVMi4pIXcEg/SUDtXQyLIFC/SF8GnpA74usamaPcD3gx3FgwMfmfDSIo9aDCOSFNULGeZS33oVpM7eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso17406105e9.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 14:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780695184; x=1781299984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yB8i6L7KoJ6YeQ5x5SkEb3TWEe2vEfLFo8gyBr/eSF0=;
        b=M79jDEcZLFXRsZCP7tjOMXZfMOkXZjoPCkAIcbHNWLGLcPAh07dBWA+8vuqbhFF9qJ
         fgY1zjAvE7y0Vn1Fh2KpnKN63sILDa1Ozw521X5tcUjxroKqNRNAjE5veaWcxDmZaVOM
         qzVhZx0lMwwnybRITeC62k00F86XPESjmkKaXP2MJeY2MpVzmwWITgiXTE/tNFzJnXGK
         czHkW5kLic509bZnjXka4qX/XpdHm8SyedFWqevjQEfjhAfE68PcrbGgCheEgDP76dMy
         l7MUKpiLQbM7UAOyOMx0odLf1nhastpksK4RLPHs+CsZa9OwqfqyC89RAFumE+6yFtLd
         n3Jw==
X-Forwarded-Encrypted: i=1; AFNElJ9hqOdUrC8TOHnrMoh9OpviDqs/N26bqGol9j+i78gsS5ubPVW4RacUfKKdrnSzijSPb7mqO1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YziFD+yMBfJQt9Otzmxu0AIVXhRy8H/l7x/hKCvrguXD1tviVmV
	uhshPK/QjviutZQ4bXhuY35s8SQVEQEq7f/zRrFGt+nefW+vJPYdRGm5
X-Gm-Gg: Acq92OFqvWPegnzYDYDrvy8xMdfUhhCZFOgWlASzOKLs5SV/WHBrZt4iwqJWeImKkzK
	yU61DcqCStHICWhv03ypYH+2ERKECr1+ZVk9RCUjfgNnn+Ae3zRkMW9Qd1qju+McgbslIX5/yR7
	KS6QBJq0c12g6y3awV2LQlUOad3bX0QJD5maowD8LFRpRkb5z52oudTAFhB9J6X2ti25lqPGHQz
	vMPm95ZsxidHTKfveVZ1fZmrpG4Ak2/b36A5f0bmWdOdSLsBfkvi7PO2KsnwEJ5gWdJtBKVtP3G
	1k8zX0aTlyp2Na7jITPeqmDdivec6jqRRf5Urrpzy4ZkbQFIbSF+0kxhC4ZiDAoBq2M2NuQ67Ab
	GxjJBUpEZ/NqxWvudoXYsAnATnE6erTtFfjEFE2YqierTWMp9tI3YAj41Kf2l2vvWzmhPlCuqEU
	tM9/2/NF6+7EfW/eQvTlR7+LjI4nqx1/oIeMnjnjrKvUsvZ97Yfm8zhOFE1vsErs4=
X-Received: by 2002:a05:600c:8183:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-490c25c6625mr78070045e9.25.1780695183438;
        Fri, 05 Jun 2026 14:33:03 -0700 (PDT)
Received: from [10.100.102.74] (89-138-67-1.bb.netvision.net.il. [89.138.67.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d52e5esm48030115e9.2.2026.06.05.14.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 14:33:01 -0700 (PDT)
Message-ID: <ab767baf-aa94-4ff7-81fb-c19804a7883d@grimberg.me>
Date: Sat, 6 Jun 2026 00:32:59 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] NFS: named client identities for mTLS mounts and a
 per-namespace .nfs keyring
To: Chuck Lever <cel@kernel.org>, Hannes Reinecke <hare@suse.de>,
 linux-nfs@vger.kernel.org
Cc: keyrings@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
References: <20260602154740.49861-1-cel@kernel.org>
 <bb9a872a-d4aa-467a-b4c9-7bca174a6bbc@suse.de>
 <b38b0983-7a63-4e77-a549-2d8859752cb9@app.fastmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b38b0983-7a63-4e77-a549-2d8859752cb9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295981-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[grimberg.me];
	FORGED_SENDER(0.00)[sagi@grimberg.me,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:hare@suse.de,m:linux-nfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:dhowells@redhat.com,m:jarkko@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B70FB64B750



On 03/06/2026 17:27, Chuck Lever wrote:
> On Tue, Jun 2, 2026, at 6:39 PM, Hannes Reinecke wrote:
>> I am all for making keyrings namespace-aware. Logically I _think_ they
>> should be tagged per user-namespace, as this really is about the
>> filesystem (and as such would warrant to be tagged per mount ns).
>> Tagging it per net-namespace is not a great fit (well, for me, at
>> least), as also block devices might require keys to present the
>> bdev (eg nvme authentication)
> My understanding of the proposal is that there is one keyring on the
> system for .nfs and the keys in it are visible only in the namespace
> where they were created.
>
> Therefore the consumer (say, NFS, or NFSD) is running in a particular
> network namespace. It will create keys on the one .nfs keyring, but
> only the tlshd in that same network namespace will have access to
> those keys.

Can tlshd run in multiple network namesapces today?

>
>
>> I might be okay to have it tagged per net-namespace, though, as all
>> current users are in some shape or form being network related.
>> But I'm not sure if that stays that way, so I am worried if we're
>> not restricting ourselves to much by that choice.
>> As really, the question is: what is the driving the namespace selection?
>> Is it the _requesting_ layer, ie the layer issuing the mount() call?
>> Or is it the _providing_ layer, ie the layer providing the
>> devices/interfaces where the mount() call is operating on?
>> If it's the former, then we need to tag is as
>> net-namespace. If it's the latter, then we need to tag it as a
>> user-namespace / mount-ns.
> tlshd is a network layer service, so it doesn't make sense to bind
> it to a user or mount namespace, IMHO.

I agree with network namespace isolation.


