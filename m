Return-Path: <netdev+bounces-272371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GqUBvoDxmnQFAUAu9opvQ
	(envelope-from <netdev+bounces-272371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 05:13:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0C33F0C5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 05:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 872F0303765B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0837756A;
	Fri, 27 Mar 2026 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g87D2BkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D1733D6F0
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774584820; cv=none; b=s0yMNX3J+oqTQhZHCTq1Yj50ze2VW4icSHZf7rjVg/tbAaSdYRLgoGls8j9chKouN85JBgonqIa0GjUOhMdx+OHjDbJBiNh3cIRBqzfJGmXJ/xKhubX8jES7Wrf/hQpCbJ/8AnnHeZd3m9UVKM6UlKX/Fms4PGgavBW/U2gWYjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774584820; c=relaxed/simple;
	bh=nGoyc1kIi4XzvpCenNljDv4QrxgONALtXOE9PZUxcYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeMfFONoMGdX3SewVpt3B9p9YB55X1JYXT7+7z7z1LLX32DBUad6QKH4TgBQ0aXvUQv5cbS5HGiqWxDHu5+6xRYCdZvpUmofgldgBokrCEQSDsEfQ+xTqtP2xYMQ2Cn2APXX3hEw/Ys6MybJe6Is37Oi5lHbWAiY3DC8fjN1ZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g87D2BkG; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c0c955a481so386299eec.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 21:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774584818; x=1775189618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tyOAVvt1udsLVZZQB5qEya7iqC7i6PZ6uRkVS9XQ/sg=;
        b=g87D2BkGS1odowECpMHXsMgLx61N/Bjka32nUPqxQL1igfqJ38VOry+9DP1X/MTRBK
         Fmwrfw7NR6jajfxABsHQmoTy8YpAGQaUU5YRJILvwiI2jzPS0+H+7M60hz0BClN6pGHo
         fYMgWQ+DBDtWkVkqueAcF3u2XABqSkh/Ny6TnDN44cYvJ2QedlOPiNtDaohzfGHo02Zv
         hOzASsx4rYqvvqWgX8jHjW0fnZ2OMPCmqIHUmQQxWVagwZqCZ5iOe4FTSHE0uU7OpVG/
         1hxm5XIZfuewfPCUSYhrjydwTEax4bvZ8orwFYmDo4xTT5C+J9EO5bJ4czf6B6QCvxRi
         lqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774584818; x=1775189618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyOAVvt1udsLVZZQB5qEya7iqC7i6PZ6uRkVS9XQ/sg=;
        b=YcZaI2gYL3RkBFGFzkJNCzG0duxxDDfj3w0GR4+4WflwIgabWiT+vV4Dlx45i/3D9g
         EXONUwhxHbrLXxz1vhmBXXFXZB6YbOIbbuHB/VqZX097Q57cDwIOwLi+RqI2MwU+ilJd
         eUopfRahCdaBpW+gn+Xx3epPBld2ryKuwLOqkIzOygDannwYyRWFErwvaKdDpMzdgq1r
         ecHeZRz81EWJvD1od5zQSANvWUXkXB+5oNC7sI+AuC74C0+2m3IeUIKqd/9ZaCyChKqd
         DrCgOFCoQg/9X/OFdkopnLxPZbuwvJThfcJI6YuAa0WjM4CfSUV7RYMcUvnggZ+4TyMA
         F4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO3JvRMvrNvcoAjfDVIc0pJpDdvSSb3iX4e3WNlpswNzojxH7gs3J2SEiAYIsvDN+RNY80OHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtIMHHbp7tXI117Av7RYX4+ankYD8e61UxTdbkzyjUytSlAaL
	5H+c2039/mw/h8aVLOEdzCyoMUx3lmWYhGSx5aw5blH/ot+U68I3ajA=
X-Gm-Gg: ATEYQzzLUwK2L2pXrUmoGpPYj5m86ijR+th1RuVIG1sV12G4EDzgxpX1SHXnDcPZ6Eo
	n4eV7s9QVFsCbzkad6u+bH4pOzn7pWj33KbMacS3eWyeto9VZBEYgsUkmHGBWLh+ib0NgaMoE/7
	RwhEPONvhMHJlBoV33ZgQkpOkZIbTetdOr+gs1Q1A7dTo2RW29pAZz0wAdIUKUf36oI2qPAtaAG
	HmvF+r6Zli0l5XMaNW9xVkDiQh4Z5qPRynlw88TpSDJ4awZWGONsQBInLFHFRKnxA0R01JlnuzI
	zYPJeOhcSPFPFVRjzZn4OH0nfGpgxNOj9mvJ1AUgMgxHueaxgf0PmTh7N19bXsB7jqVwIKXemOl
	I7VDwg/5YsXnq2GD6bVhDiCRwtu1VcUiaylHVPVtKsAQFNq8F0aWsJ/xvjaW9HmAJZO1fdU0LEQ
	V6Eut+ybb4fx0sfGRuVKl3klr7T/CT8JJ7PBuLvEMDrDrZGuq3pZpIh6gRCbgvEyYk2BSBbWaPt
	84urtQ9qFOhWe16nw==
X-Received: by 2002:a05:7301:1006:b0:2be:a041:5d75 with SMTP id 5a478bee46e88-2c185e94a09mr490280eec.33.1774584817312;
        Thu, 26 Mar 2026 21:13:37 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16edde435sm4456638eec.25.2026.03.26.21.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 21:13:36 -0700 (PDT)
Date: Thu, 26 Mar 2026 21:13:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: add sysctl to toggle napi_consume_skb()
 alien skb defer
Message-ID: <acYD8JT16b3_htIz@mini-arch>
References: <20260326144249.97213-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326144249.97213-1-kerneljasonxing@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272371-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4B0C33F0C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/26, Jason Xing wrote:
> Commit e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> defers freeing of alien SKBs (alloc_cpu != current cpu) via
> skb_attempt_defer_free() on the TX completion path to reduce cross-NUMA
> SLUB spinlock contention to improve multi-queue UDP workloads.
> 
> However, this unconditionally impacts the napi_skb_cache fast recycle
> path for single-flow / few-flow workloads (e.g. AF_XDP benchmarks[1]):
> when the TX completion NAPI CPU differs from the SKB allocation CPU,
> SKBs are deferred instead of being returned to the local napi_skb_cache,
> forcing RX allocations back to the slow slab path.
> 
> The existing net.core.skb_defer_max=0 could disable this, but it is a
> global switch that also disables the defer mechanism in TCP/UDP/MPTCP
> recvmsg paths, losing its positive SLUB locality benefits there. AF_XDP
> can co-exist with other protocols. That's the reason why I gave up
> reusing skb_defer_disable_key. Besides, if the defer path is disabled,
> that means TCP/UDP/MPTCP in process path will trigger directly freeing
> skb with enabling/disabling bottom half(in kfree_skb_napi_cache())
> which could affect others. So my thinking is not to touch this path.
> 
> Add a dedicated sysctl net.core.napi_consume_skb_defer backed by a
> static key to selectively control the alien skb defer feature. Let
> users decide which is the best fit for their own requirements.

For a non-zc path adding a userspace knob feels like too much. And there
is zero documentation for users to decide which mode to use.

