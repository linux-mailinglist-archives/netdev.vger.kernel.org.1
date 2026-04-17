Return-Path: <netdev+bounces-279258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFa0J33s4WmKzgAAu9opvQ
	(envelope-from <netdev+bounces-279258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:17:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0771F418796
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09EDF3037EF2
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E7E39B974;
	Fri, 17 Apr 2026 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnXrsnGy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303FA306B08
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413543; cv=none; b=rE6ks9VCcJvIBQbCI4GVB5qs8PMrit2gRomo4vOGXNyUvzZLgauq1kFVm4Zxa90kYX1H5iuhRy7XsqtkaAH+CMcH/ApsHzAwMC3ABOT7ukxMslP9VO3fltzwVhDpKaq161ByMgl1kvbjUWsR67rNTmzhjmEND9heLm50UoY5dxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413543; c=relaxed/simple;
	bh=f1f8FP5MAPBZgyVtMY0NYdH9uQSsSaWjgN4QrxBbNbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inyxgNEhn9Lj86a2FBNubiTqgBR7II65pPhnHarof7TVM3DiDD2W+6tVAk8Ngc5ieGQT/t54iFsSxeKRTHNdzcv3eEUj/VsELk4Jb5MyhuTzQQfQtTMrO8jWVHxl+8mvK+IP4+03RiR0ikF4r+aAv0nNRU/b69ZEufXl72gc/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnXrsnGy; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c726c30efso364645c88.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776413541; x=1777018341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FVUfbekTe9VVF70JZx+Y2dELk9ZGKMrf0H0ErIcWXs=;
        b=bnXrsnGyk78ORRttd9feF47MUZLCAEgruJmRI4R1K9Ltwde4uIw5R1LlthzFLt96WV
         JQo6aW3OymwuHGdX5+UTmBBO19EZJGk5Ba2d6IsbE1Zx1n2K8q+XI/VQSHKDFJYIjXly
         cCCYG1z2KrIis1DOAWnEATyz/a4quQMKB2ist6NYDivoNijS5H5lkJcSnpUdbToKzmNj
         6dNB/sCcpHjTpi6cbYAMwDWHOE655PvkJLLkWrETXbmrSBJF/pMJ09SYhBrYJ+aOCe8P
         jgAvOLUe9pWmwkpndU657H0DGSrRN4WZimpdLUSb1D3UlS52gNLO2MYGVCt1sgTJqonX
         8CdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776413541; x=1777018341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8FVUfbekTe9VVF70JZx+Y2dELk9ZGKMrf0H0ErIcWXs=;
        b=CH4M3puJD7uVbZVt8Jjp6R092QoPFt15BG5jUsGSHLCc95ZLGa1WwGR+M26yqYu7zN
         epDW37tyxUJtyEO8GBV9o2OdKNvKaNopjPCFo8tOHOHUITXD6nS+quAQ7MM515F0pzQV
         PNpPGE943FLrVfhKSurLgbHuL4NgsiSxiLiZVO8K0VBwB1uvDWkV3Gs2JufJ8Nhyi979
         IVCWBX0pSAljSvKl/3X88ju77GYwrqDlUVmqukSC3U/5rmqdJe4m26N/JeH4fPzFuaez
         2ZMCkxI2eVjlPeYcWJVfFCrm3gkhTs3hEVeQcFOT9Sm/5WiI5KdpeTV+UA1EmAU7XBVK
         IokQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fUz54kq7ntPPSyUEyrb2//AuuKIVDjdFBBKC3CKN0DEZdeL+4ra0TzoTCerL7cRWrm/eHe8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuwvy6PW/tRuDnw7Ftd9YzdNFM0meVC6d3nzMfhA8Vj2KZB1+n
	VutIPgQirybWadozrvxFvIPwZy28/8w8dj5hSkq6GKZZ45+xuIMO9AmN
X-Gm-Gg: AeBDieudUjJJzT6sTjdarhAvYS4WEuZiycmSgZI16ApKZqdoaOXdr9aUsvs1+feu3no
	k1rWAA25AY8LNNGxQTQ3eGvCW8Y6G/JjUn37pfNtps9Lnr8/ChPFNG2KlqNdPYYItQpGjEqXbu1
	SG1WKmNKyjRhjxVZLu2yvjUOrei9xtJOsShyr0Ksh5P+TFuX33BlSx3BBDXLByKpJ94/LTLVhoY
	MobwXejmNjuxJ2hp1tMhD0DkU+Z2HwNjqAKDG/IWGDAxr7Hw1r2cEoVOFDmpIC2NRlE20pd+Yfo
	7xV4QAMvgV8L6fsdGswL5nihmQBdVTI7+1x0MunZYcQwBTlv2sujjqFeJqn+9EDQEcmpUUKtrRu
	1VAACwZLChvwQQdRC08RcjDtpD/R+ruqB7Vp72pjIietVg81TFBO8vpBs8544Mhq+ceY3684PP9
	YQOUbdor+TCEN0A+EpdwmNA9PuFOWWXqhtTX0A4Mn1l0cGOA==
X-Received: by 2002:a05:7022:6b99:b0:12c:2dd7:9099 with SMTP id a92af1059eb24-12c73f9fb84mr680694c88.30.1776413541268;
        Fri, 17 Apr 2026 01:12:21 -0700 (PDT)
Received: from localhost.localdomain ([104.28.152.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20c55sm1161356c88.13.2026.04.17.01.12.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Apr 2026 01:12:20 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: willy@infradead.org
Cc: 21cnbao@gmail.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	hannes@cmpxchg.org,
	horms@kernel.org,
	jackmanb@google.com,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linyunsheng@huawei.com,
	mhocko@suse.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	willemb@google.com,
	zhouhuacai@oppo.com,
	ziy@nvidia.com,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
Date: Fri, 17 Apr 2026 16:11:34 +0800
Message-ID: <20260417081138.23426-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aO11jqD6jgNs5h8K@casper.infradead.org>
References: <aO11jqD6jgNs5h8K@casper.infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279258-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lwn.net,davemloft.net,google.com,cmpxchg.org,kernel.org,vger.kernel.org,kvack.org,huawei.com,suse.com,redhat.com,oppo.com,suse.cz,nvidia.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lianuxmm@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0771F418796
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Matthew, Barry,

> So, we try to do an order-3 allocation. kswapd runs and ...
> succeeds in creating order-3 pages? Or fails to?
From our reproducer runs, both happen. We observe intermittent order-3
successes, but also frequent high-order failures followed by order-0
fallback.

> If it fails, that's something we need to sort out.
Agreed. In this workload, the bottleneck appears to be contiguity, not
raw reclaimable memory shortage. Order-0 memory remains available while
suitable order-3 blocks are often unavailable.

> If it succeeds, now we have several order-3 pages, great. But where do
> they all go that we need to run kswapd again?
In our runs, order-3 pockets do show up, but they do not last long.
They get consumed quickly by ongoing skb demand, and the pressure returns.

To investigate this, we built a reproducer that keeps creating memory fragments 
while the network stack continuously requests order-3 allocations.[1][2]

Raw sample output (trimmed):
---------------------------------------------------------------------------------------------------
TIME       | BUDDYINFO (Normal Zone)        | MEMINFO                   | KSWAPD CPU & VMSTAT      
---------------------------------------------------------------------------------------------------
11:08:11   | ord0:11622 ord3:0              | Free:96MB Avail:1309MB    | CPU: 10.0%  scan:83107932
[*] PHASE 3: Triggering Order-3 Pressure (UDP Storm).
11:08:15   | ord0:52079 ord3:0              | Free:273MB Avail:1300MB   | CPU: 90.9%  scan:85328881
11:08:16   | ord0:102895 ord3:0             | Free:477MB Avail:1309MB   | CPU: 60.0%  scan:85873777
11:08:17   | ord0:115459 ord3:5             | Free:517MB Avail:1284MB   | CPU: 54.5%  scan:86584389
11:08:18   | ord0:115164 ord3:0             | Free:509MB Avail:1107MB   | CPU: 36.4%  scan:87083561
---------------------------------------------------------------------------------------------------

The current phenomenon we observed is: Free memory is plentiful, Order-0 
pages are abundant, and the network allocation has already successfully 
entered the fallback-to-order-0 path. Everything seems normal on the 
surface, yet kswapd remains trapped in a futile loop.

It appears that kswapd is stuck in the following logic: 
wakeup_kswapd -> pgdat_balance -> __zone_watermark_ok. 

Specifically, in __zone_watermark_ok():

        /* For a high-order request, check at least one suitable page is free */
        for (o = order; o < NR_PAGE_ORDERS; o++) {
                struct free_area *area = &z->free_area[o];
                int mt;

                if (!area->nr_free)
                        continue;

                for (mt = 0; mt < MIGRATE_PCPTYPES; mt++) {
                        if (!free_area_empty(area, mt))
                                return true;
                }
        }

Because our reproducer keeps creating fragmentation while the network 
stack requests order-3, this loop continues to return 'false' for the 
high-order requirement, even though the system is functionally fine 
with order-0. To be clear, we are not intentionally creating "artificial" 
fragments just for the sake of it. Rather, we designed this reproducer to 
effectively stress-test and expose the existing feedback gap in the 
reclaim/compaction logic—helping to pinpoint why kswapd continues 
thumping CPU cycles to satisfy a watermark that the allocator has 
already abandoned in favor of order-0 fallback.

A related discussion in [3] helps reduce vmpressure noise in this area.
Useful, but it does not close the contiguity gap by itself: high-order
wake/reclaim can still repeat when contiguous blocks cannot be formed.

It seems the current situation directs us to take a much closer look at 
how kswapd behaves in these scenarios. After carefully reviewing 
everyone's input, we believe it is time to do some targeted work on 
handling these high-order page issues. 

We already have some rough ideas and plan to conduct further experiments 
in this area. We would appreciate a broader discussion to help address 
this potential oversight that we might have collectively missed.

Links:
[1] https://github.com/hack-kernel-just-for-fun/kswap/blob/main/kswapd_spin_repro.c
[2] https://github.com/hack-kernel-just-for-fun/kswap/blob/main/kswapd.sh
[3] https://lore.kernel.org/all/20260406195014.112521-1-jp.kobryn@linux.dev/#r

This was reproduced and cross-checked independently by our team
(Wang Lian <lianux.mm@gmail.com> and Kunwu Chan <kunwu.chan@gmail.com>).

--
Best Regards,
wang lian

