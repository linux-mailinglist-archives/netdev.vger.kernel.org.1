Return-Path: <netdev+bounces-252132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPEtCkqAcWk1IAAAu9opvQ
	(envelope-from <netdev+bounces-252132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:41:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520E60717
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F30B7406A8
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C8C354AD1;
	Thu, 22 Jan 2026 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQou3zu8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F165350D5D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046044; cv=none; b=V97PgzXOsUXdFLU41LRhzxRUCRHCYbPMKFvPEtW9gXGZjtwj9Sn+dLlpW30Y992RkqNuX+ESlR3yS1q060WGNvEOGwoGSyLZ3XC3ACUnauglAWGLkzIOYhHhnzv12SBaUwbFgt7uADPtJGjGaPrLkYIYWTB1rG7YP1lSNCkBZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046044; c=relaxed/simple;
	bh=/ch7Q2uvZMZe33IL5LXrXfMmiaE5BvdMSTaXCfhBGA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWGkd46eQ8jPS8wv+06YSuGwoIIq/sEFADfAvRU9n6jTOWX/bI6JyCojcSEZ9qWnkJGcYA9bD4aKxyvwCe0A5NTRFOXLBwBVNJtbpd3MWBUao2tV6w1MhrGBV5Qr35jQM5SrWOWnENoKmGo9/Jpr4uauGrBjELNp3JmL8h2dZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQou3zu8; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12460a7caa2so714355c88.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 17:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769046042; x=1769650842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv3y2V8fADohDcIx1NVelau+w+a6LhiaxX40puOmnps=;
        b=UQou3zu8EZVoa356eCksjDfsstLGw6aqoVn+62DTOLpv0LZCm7q61qk4y5rj37ojXI
         q2NsPRlQjEjRTYjoKEOPFF2iZMZuvQ2BexE1xKBaml/3T5+Nz/xOSk89bk1lxdQiRP5t
         ymampuYbxSGo3hLLcRzGCqhmKX3a25SZjYq4nIwA3v7PSS0o50CXfR30ttUdmgGTcuJZ
         QnXxclfOMOLuNwow+gMAqVXc1+ooxnd58cU9GNNEZGJUsBJoubg5DGIjDx8Ij0Wt3m/C
         AZrUMyKlJ9DBFCYtL9Ak8dR9Qy9VF9e1InX6NllnjrOyqKFVYDKMBLELiYjifZvu4sx7
         LNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769046042; x=1769650842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bv3y2V8fADohDcIx1NVelau+w+a6LhiaxX40puOmnps=;
        b=btuG49Jkugo4jHRC2G7WWAHTAt46AZ2Wuz1e0Hkd9cIHTS9lqHvhYNMiYfHCWuWHjh
         sziaZ30/fzCXnLRph1K49skJC82bCMK5aWkWWvJCbnnxtJVB3hzphlV05eT9EIbNbF1X
         LqfqBo+vzLURsOoH9VRIu1CMUcXErFFS5WZuyRS3cmo0uzeyOG/2yH4zW2bDY6KBZeWV
         n3/U08wfMZnF0maXu3EkzGXo0OHiD4JJpFYRt/WzhvwM197I3GQ9rw7vNIiY2Yquw2e1
         Ij7kBAQXhk22SqffCqKIUWo0AIJAl0myH2+uPhKdJi0X+BVeq4w8wmdpQrdxenKQca3Y
         HxNg==
X-Forwarded-Encrypted: i=1; AJvYcCX/DVhe55w5J6WJ/qJN2+RuDvBVATo0OfntQcJKVqoAxEoClS+x9BgN8UG07kxubhufhJO4loA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLr+a6bcAYStObeR5v3Zztr7/pv54qWCaf32Rrc0PAW1TS+iHk
	bO1M6PcAy3FfsJ9BFXGtYswTGLoRdcSiDIYYR96Ks3CwI/LeIYTTCwDv
X-Gm-Gg: AZuq6aLnzm4jAfEeDLsqpoodq5S75WTq+0LbcCQXtp8lN7IO25vbjRltROBwqrG16s8
	5o8v2eJyfXnwfkKOhE+Orc54pz6xyIZdqpjVoiUMkYZQVCWtUA2RvrKIdXEF1rS60YSXYa1JYYT
	KqV6lz/S917n3PPrciVF3JyXmM+PSBNtDRbaERERTj+EvglO8f7eQt2aec8MZCVeJ2RLIqmDybL
	SCUp7Lgn4WgRPenVhio134YQWDD39gfaulgUU+OxRdgXQ0DCM+mqXa++jhezwFv0AEhHKC30W6M
	wI8Q5o0A1hx9nSswx21YVVo+xD4AXw8rFOqozmWPL0zAg/y/FnCuDoF7Bt58Ln7c5otC3r6kJJU
	udJ7pt1+h3fY6/woU8u5ZzNw6spJyRlfYg/TH8gqsAeXT4Bjc0/WoW2D5dzFNGzWLOORSA/MGy2
	2sBQY=
X-Received: by 2002:a05:7022:6284:b0:119:e569:f611 with SMTP id a92af1059eb24-1244b30446bmr12551894c88.10.1769046041263;
        Wed, 21 Jan 2026 17:40:41 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad72063sm29147090c88.6.2026.01.21.17.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 17:40:40 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	mhocko@suse.com,
	vbabka@suse.cz,
	willy@infradead.org,
	lance.yang@linux.dev,
	hannes@cmpxchg.org,
	surenb@google.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	weixugc@google.com,
	rppt@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: Re: [PATCH v5] mm/page_alloc: boost watermarks on atomic allocation failure
Date: Wed, 21 Jan 2026 20:40:10 -0500
Message-ID: <20260122014034.223163-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121125603.47b204cc8fbe9466b25cce16@linux-foundation.org>
References: <20260121125603.47b204cc8fbe9466b25cce16@linux-foundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-252132-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 0520E60717
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 12:56:03 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> This seems sensible to me - dynamically boost reserves in response to
> sustained GFP_ATOMIC allocation failures.  It's very much a networking
> thing and I expect the networking people have been looking at these
> issues for years.  So let's start by cc'ing them!

Thank you for the feedback and for cc'ing the networking folks! I appreciate
your continued engagement throughout this patch series (v1-v5).

> Obvious question, which I think was asked before: what about gradually
> decreasing those reserves when the packet storm has subsided?
> 
> > v4:
> > - Introduced watermark_scale_boost and gradual decay via balance_pgdat.
> 
> And there it is, but v5 removed this.  Why?  Or perhaps I'm misreading
> the implementation.

You're absolutely right - v4 did include a gradual decay mechanism. The
evolution from v1 to v5 was driven by community feedback, and I'd like to
explain the rationale for each major change:

**v1 → v2**: Following your and Matthew Wilcox's feedback on v1, I:
- Reduced the boost from doubling (100%) to 50% increase
- Added a decay mechanism (5% every 5 minutes)
- Added debounce logic
- v1: https://lore.kernel.org/all/tencent_9DB6637676D639B4B7AEA09CC6A6F9E49D0A@qq.com/
- v2: https://lore.kernel.org/all/tencent_6FE67BA7BE8376AB038A71ACAD4FF8A90006@qq.com/

**v2 → v3**: Following Michal Hocko's suggestion to use watermark_scale_factor
instead of min_free_kbytes, I switched to the watermark_boost infrastructure.
This was a significant simplification that reused existing MM subsystem patterns.
- v3: https://lore.kernel.org/all/tencent_44B556221480D8371FBC534ACCF3CE2C8707@qq.com/

**v3 → v4**: Added watermark_scale_boost and gradual decay via balance_pgdat()
to provide more fine-grained control over the reclaim aggressiveness.
- v4: https://lore.kernel.org/all/tencent_D23BFCB69EA088C55AFAF89F926036743E0A@qq.com/

**v4 → v5**: Removed watermark_scale_boost for the following reasons:
- v5: https://lore.kernel.org/all/20260121065740.35616-1-realwujing@gmail.com/

1. **Natural decay exists**: The existing watermark_boost infrastructure already
   has a built-in decay path. When kswapd successfully reclaims memory and the
   zone becomes balanced, kswapd_shrink_node() automatically resets
   watermark_boost to 0. This happens organically without custom decay logic.

2. **Simplicity**: The v4 approach added custom watermark_scale_boost tracking
   and manual decay in balance_pgdat(). This added complexity that duplicated
   functionality already present in the kswapd reclaim path.

3. **Production validation**: In our production environment (high-throughput
   networking workloads), the natural decay via kswapd proved sufficient. Once
   memory pressure subsides and kswapd successfully reclaims to the high
   watermark, the boost is cleared automatically within seconds.

However, I recognize this is a trade-off. The v4 gradual decay provided more
explicit control over the decay rate. If you or the networking maintainers feel
that explicit decay control is important for packet storm scenarios, I'm happy
to reintroduce the v4 approach or explore alternative decay strategies (e.g.,
time-based decay independent of kswapd success).

> > +	zone->watermark_boost = min(zone->watermark_boost +
> > +		max(pageblock_nr_pages, zone_managed_pages(zone) >> 10),
> 
> ">> 10" is a magic number.  What is the reasoning behind choosing this
> value?

Good catch. The ">> 10" (divide by 1024) was chosen to provide a
zone-proportional boost that scales with zone size:

- For a 1GB zone: ~1MB boost per trigger
- For a 16GB zone: ~16MB boost per trigger

The rationale:
1. **Proportionality**: Larger zones experiencing atomic allocation pressure
   likely need proportionally larger safety buffers. A fixed pageblock_nr_pages
   (typically 2MB) might be insufficient for large zones under heavy load.
   
2. **Conservative scaling**: 1/1024 (~0.1%) is aggressive enough to help during
   sustained pressure but conservative enough to avoid over-reclaim. This was
   empirically tuned based on our production workload.
   
3. **Production results**: In our high-throughput networking environment
   (100Gbps+ traffic bursts), this value reduced GFP_ATOMIC failures by ~95%
   without causing excessive kswapd activity or impacting normal allocations.

I should document this better. I propose adding a #define:

```c
/*
 * Boost watermarks by ~0.1% of zone size on atomic allocation pressure.
 * This provides zone-proportional safety buffers: ~1MB per 1GB of zone size.
 */
#define ATOMIC_BOOST_SCALE_SHIFT 10
```

Best regards,
Qiliang Yuan

