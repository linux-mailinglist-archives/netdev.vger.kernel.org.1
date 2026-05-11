Return-Path: <netdev+bounces-286757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMfbI38YAmognwEAu9opvQ
	(envelope-from <netdev+bounces-286757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:57:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D01513EC1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 722CC3025D12
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341BA44102E;
	Mon, 11 May 2026 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8vvJHix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7E449ED6
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519872; cv=none; b=d5n6ldQfrqjEZQ94ZXhB5X40I5bLUdN/vCnYStFNOLlAnSaOqqsZwb9BRJfiDHtxNptFk6wdWSbe/jL8vIZ/hhx15COt0RbbdBVxp+lKEqBh/nF+M09ZxMElTQ1vnT0au5EcmAY/Pat5X+TCh4i9w8GNas6lrB/TVEDCWt6wHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519872; c=relaxed/simple;
	bh=hFY7DZz2dPp8r+14dtw6/8VgSlUQgJuN+xeWAm4e7PI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RImbMwgsNkZirZ4zaLJhiw2Przu7gD3lkVFtO5z3kahZZOoVrsXQS7eHT+riCdD0xsRY0/T/Iq5KRCL7dB/nugzE++hVRyDPKv4UofbRE/28dwyLtTnKHG+zGDcMwxpOg7/ugVGnCztLUGf5P8sRSjLNepcIE7PvaIGfyQto8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8vvJHix; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-367cbac9c37so1597145a91.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519869; x=1779124669; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gPhuaAbxwetzboeNCx+LRxGrGydKpCVrVHpu2bOzJRk=;
        b=V8vvJHixYDaozBdFHVRbRexy5+YgceZn4o39xMH8WDAG3sASFiRz51Ic3CtQBIBohq
         jTp5/zb2onT4c5lpQY3jug0Kst33llla9yznQFMnC3ZrcA5R69S7asZ6q+FOxXWrTtNQ
         uScHNmZ13JZpQ95dmLmxHJM5bmgHOOHaFFL/ZGf68Nvtz7LUKFpEOhNEFIs4OrrKJWDt
         sPm723Y88tVyc9l0+6TtteTaSS497ZOuPUG3r4qrFZWoawMEgGR3xRNyCVjDAj57IfgL
         6QbQYLwElsLws3IwkaEEzmhmAqfu/tHG5nguh00ew2Z6AIsUXwrVNroidxy0T/JIWZ8Y
         lUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519869; x=1779124669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPhuaAbxwetzboeNCx+LRxGrGydKpCVrVHpu2bOzJRk=;
        b=i6g2NaBHT4FW5+oo2IV8moMvlAyogV4bZypzaEYxiRNt5qoStZkIEDT/gzIcflwskp
         ntYgAVeO5jgAV+HyFhF2LzZt6AmyeCqWG+HTD4jS6TZXqU+tk0Dotl464QY27zo5isyd
         paqOa8TnqdkFv1WsgDYTkan+WY/T3NZ03qsDIZBI4zWaoN1H3Eh9L93g9APWjJCib33H
         35Zj4U4Pa+6k2oN2tiZYzDegXEnNKTv2TSJE8dWLoLCmctz9AzcYOIhEH201eJSoX+Ya
         ADTj4iCC8nwCiXMZFKNu1rqWuBB0rGrT+yyFjY5umKULaWWphq9pW5mq9ct4isiShXlv
         j5gQ==
X-Gm-Message-State: AOJu0YwH8Mpd2fsJly2BeLZD7LBWriB9/CePAMgBtTUVUSmC/dAOl9Px
	OY5KizIQQbr5S28C4b+e06cP8d5O+2Hi6eIcjyCdHqXrPUYjsjOlBKas
X-Gm-Gg: Acq92OEouTvdRzHZ4PLJP6AmzxuAP7spI08mCdT2k905oQonrblhgh2Ea7NGx3uNnZ8
	l7GvtXjd9KAeOZ/wbONzsVjcyY0gx17JO8EAhRomFvSmlDE9jl1eSlXv7vxraKLgQYwHrzOfQm0
	8UYfCTVCNpFp91YjOrDsNabIQICYlGFhLYNxb1/lGEctxD7/PKbyiSPTxret0d+w70o2fpwFAgy
	RAacvxPi16bWp7EaHzION+rtEjM6GQpYBaLbuOc3vqnOU+9fHfbSdB6fjpEOTIIMHZua9waIsfS
	xMnwbRzL3VhUJsrBEVhA2X+n2oHVnBhuy7XMSloG/J0ZRSwYV7YZcjbr3ID42aiK6ysKlKhn6Bw
	Yinn8bPumjIo9r+rOuVGF2rrdh3DwxmiHnTa0mqh+nta3fEbWf4hNMNvghkpvEMNwJWTXQopk+2
	wmx9MUwuPQE/Ag2rxNeq0DEQK0xouNl8/Zt4yBoUqvGfrTXJKRlpXI
X-Received: by 2002:a17:90b:1850:b0:368:6ff3:6678 with SMTP id 98e67ed59e1d1-3686ff36d15mr3942399a91.20.1778519869103;
        Mon, 11 May 2026 10:17:49 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d65ed459sm10983837a91.14.2026.05.11.10.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:17:48 -0700 (PDT)
Message-ID: <7f0d8cf18e3e0d60751b2453815a1f0ea62ca928.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 01/12] bpf: Simplify
 mark_stack_slot_obj_read() and callers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Mon, 11 May 2026 10:17:15 -0700
In-Reply-To: <20260506142709.2298255-2-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 73D01513EC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-286757-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 2026-05-06 at 07:26 -0700, Amery Hung wrote:
> Directly call mark_stack_slot_obj_read() from function processing
> iter, dynptr and irq_flag. To prepare for unifying dynptr handling,
> dynptr_get_spi() will be moved out of mark_dynptr_read(),
> As mark_dynptr_read() would join mark_iter_read() as a thin wrapper of
> mark_stack_slot_obj_read(), just open code the helpers.
>=20
> In addition, since 6762e3a0bce5 ("bpf: simplify liveness to use
> (callsite, depth) keyed func_instances") has made
> mark_stack_slot_obj_read() always succeed. Return void and drop the now
> unused bpf_reg_state argument.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +static void mark_stack_slot_obj_read(struct bpf_verifier_env *env,
> +				     int spi, int nr_slots)

Nit: this is probably a leftover from the stack liveness commit,
     but I think that a better name for this function would now be
     mark_stack_slots_scratched.

[...]

