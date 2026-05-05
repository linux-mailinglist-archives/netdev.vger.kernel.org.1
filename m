Return-Path: <netdev+bounces-284496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFrXI0EV+mlRJAMAu9opvQ
	(envelope-from <netdev+bounces-284496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:05:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5F64D0DAF
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2E1330D15D0
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD848C3EE;
	Tue,  5 May 2026 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joU5c9Tb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818748BD49
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996692; cv=none; b=KrNlgvTH80bcDGGtePHPsWG5fSu6K7pFMjZ826ZakIjR/n23XnNZDbvXBRBRthP2sX9HV3uC7mIixDyoi+qANhDUp8q7D+8/BX1el9M9qZ7wv7tw84NBVdRjARt2+5OKGbIb/d9sZZws+PxT0lSeLyk/ongCT2KDq/x8dQoozp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996692; c=relaxed/simple;
	bh=D2o/PVb77AkBEhbzcdF37qpR3SjVgvH1lEK7F9GQx9U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=J9o7OlejxsrQe9VXu1chZoApsW3GcRhDyh2fO0KNNXJl4MY1zcZIrt87I3ekZ7Opr9Vi1vVYo9x75FaRj77Al3YMi1ip6NUFOFK943Vmrl1/ddum81vTKu5xJ4fraQRFmRmJ6fGRE6JpBzXW0GqGXLCVhb4D0fP10jpF7wHwrD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joU5c9Tb; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c24be9e4bso4671702d50.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777996689; x=1778601489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aejSiLDsfk8IAFtVBk+tM96P+lkGFUJjyUFGj4omje0=;
        b=joU5c9TbCxNdu75tqqmlGj2AKZq2aqA5+gJdigk0uZm0lq+uIzREpJl5uKCsAOlvzW
         LTeL5TaKPxtUdJE4u5gY05JYLuyfCldGCM2573grKPgAMLhqWGMAW+o9j3ns+bva6Ty2
         L1elbmCtFtP+D3A+BDBNDiR8Fn0LaniOcXup6PXET9RlLfa2B5gKBjGfLynAKiPgG+EV
         qMppwOHPyZn3alRy+Sfxlg9VKR+ol8JFOuR/3dAYCj7s65amlzq7TBE0qvwOcKpDu7vr
         HR4TBKY03DgVDorDK4idCpI2xJn4Azr+Omn46Tlbq5DBYowG3/j8LGSd/alWffwfPA1+
         8cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996689; x=1778601489;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aejSiLDsfk8IAFtVBk+tM96P+lkGFUJjyUFGj4omje0=;
        b=Xbvn2HJcGmXRfjvOfbhnVzYEsrBVdNSmhWIY0Pb3PNVPagyBktlh3WVYHtit0MJ0Xq
         IIXhMNJDigjCL1lKZKznpqHoCXgVmTRWPL4PkH3n87k8q28dG7J1tjpjpJyMbq1NKT9m
         JhsjcNf4nXGZAHi+4Ot8Zt6KIOjIFX3TXDcU8734gc3uDOFKReViOEm3tirkkS12Y9cI
         JILJbEUASjQQFQGyAcHuKqCGabz0bUKUNUJzu+c6vPZdAYdGOQbxKVjDBipcjoor8csO
         o5nvNQNGgTHd2Q1Wl8F1aNQJMHptYn2wOY3Qm2BzmHIczpNi57NJ68xkIXnuPluKVibG
         aJOA==
X-Forwarded-Encrypted: i=1; AFNElJ97TfQ/Fw9WRCp8ZfDcGM96t7l2ja9GwrpV3Wl0RXg8kXLoIs9YO/GrAmsVy54bJQ1EM885qms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAadEhfWoit+4TRhLQojiRZksKez99Q+iJu5+faD5Ftf1hRe9
	bTomTi9vsFOWm/6TP4mLdbLfpTXdZdHaeMtnahWeV2rKDX9i+s7klLgT
X-Gm-Gg: AeBDiev0X5ATp7cL3ldWBe+J6U4BK9HpXio+Mos8/lBbQkRoRZBJ0ZpRcuBg32vGZmi
	0mNkCO5dhSr9s2HO0IZu1GEC5v2N6ETxCmUzXkAOI/ULWmAaiZYbmRk82woHXx5AFC1PKEtkmlx
	VbqkuE81meU9GEtK96Q+mAIytVDcmAri3tPEHpFRkQ6odjLT6BKTLPKkGptHfJ1UJwZc7Gt/BvG
	PTFX9DNegquy2LAn/UENYZ8ldvFXdrfpUZYU1YheGRWTcSndIfKWuaUK7q3ytxyLD85wq5hvqm6
	ofHPFUdxRhYoK91RCJBoRmYJ11iCSCrIHpUOOWbPq9R3kmArzC9o68XBPjF5BaSKVnl3phBbldc
	ZgFsAik1nG7sO2IGQZMo/3DVUOl8gKby9kiBIvAFv8CFJT+pHGJY4j3orKDTbC9oymY60mVjc0t
	Ra4pU09r/xdSDp1Li+tCWjY83aC43zHJf73T4jZojK/aheLUWCe634meDhbskwfDagT6A74F+PM
	evqsXvlCCk59qK1zhmEe1x1Qw==
X-Received: by 2002:a53:b457:0:b0:65c:5b88:84a2 with SMTP id 956f58d0204a3-65c69c48b3cmr3048915d50.4.1777996689221;
        Tue, 05 May 2026 08:58:09 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e1d95a8sm7216162d50.9.2026.05.05.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:58:08 -0700 (PDT)
Date: Tue, 05 May 2026 11:58:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
 Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.30d081513eee7@gmail.com>
In-Reply-To: <20260505072015.1672730-3-maoyi.xie@ntu.edu.sg>
References: <20260505072015.1672730-1-maoyi.xie@ntu.edu.sg>
 <20260505072015.1672730-3-maoyi.xie@ntu.edu.sg>
Subject: Re: [PATCH net v7 2/2] ipv6: flowlabel: enforce per-netns limit for
 unprivileged callers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3A5F64D0DAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284496-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,ms2.inr.ac.ru,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Maoyi Xie wrote:
> fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are
> file scope and shared across netns. mem_check() reads fl_size to
> decide whether to deny non-CAP_NET_ADMIN callers. capable() runs
> against init_user_ns, so an unprivileged user in any non-init
> userns can push fl_size past FL_MAX_SIZE - FL_MAX_SIZE / 4 and
> starve every other unprivileged userns on the host.
> 
> Add struct netns_ipv6::flowlabel_count, bumped and decremented
> next to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new
> field fills the existing 4-byte hole after ipmr_seq, so struct
> netns_ipv6 stays the same size on 64-bit builds.
> 
> Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the
> file was added. Machines and connection counts have grown.
> 
> mem_check() folds an extra per-netns ceiling into the existing
> non-CAP_NET_ADMIN conditional. The ceiling is half of the total
> budget that unprivileged callers have ever been able to use, i.e.
> (FL_MAX_SIZE - FL_MAX_SIZE / 4) / 2 = 3072 entries. With
> FL_MAX_SIZE doubled, this preserves the original per-user reach
> of 3K (what an unprivileged caller could already obtain before
> this change), while forcing an attacker to spread allocations
> across at least two netns to exhaust the global non-CAP_NET_ADMIN
> budget.
> 
> CAP_NET_ADMIN against init_user_ns still bypasses both caps.
> 
> The previous patch took ip6_fl_lock across mem_check and
> fl_intern, so the new flowlabel_count read in mem_check and the
> new flowlabel_count++ in fl_intern run under the same critical
> section. flowlabel_count is therefore plain int, like fl_size.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>

Reviewed-by: Willem de Bruijn <willemb@google.com>

