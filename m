Return-Path: <netdev+bounces-209830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E665B110A1
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AC03B0B8A
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813432EB5C9;
	Thu, 24 Jul 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5NtYKXu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3E2D46D4;
	Thu, 24 Jul 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753380412; cv=none; b=ogcr2nWroDU+TgXJqDeQGk1j8Dp2SFEjK72mPIfsGJL2lE0bUZjZgyJNYwLffc/2SFxo62dXGJpKzCht+cMumv8w7/uhQgDARx1+oNBKBNdP8YJCA97fPPLo2sl2uiMaY93TRNjHTXLBhUQqtclHCLC2V6vtQfml50Fj2xG/j14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753380412; c=relaxed/simple;
	bh=KnoLbqTfuKStF+ahH1hs24dWbm8IIgORL1+MMSISfGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpK+xaCqYWNAc5F/FHcu8y/lnY1ZUDTZPQdaPoTEzziIdn1GdNxgvK6iBgpoV2/rUsaN17oHc1OutLkEPH5qAn1wWwDNyrKvzxiNp5QzaOlahcMjPGZ0JOawTUl/rn6iKArkHJOn3hveEQ3uvDigKt5ZziPaJSyiu0nwZJnf95U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5NtYKXu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7426c44e014so1179126b3a.3;
        Thu, 24 Jul 2025 11:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753380410; x=1753985210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/B3d3EW75kabIduY/zlHbkmuA3wULeBZ2mrkCKlN54=;
        b=e5NtYKXuWASp4Y3IztNNksDDgYgLSJ1RvrfiY4sbwTiGVQKW6kAgfdDZs/jDr1JZYd
         XenlMSSbZtqs2+MfmTR6ekCQAD9vd2kXcPyIjE70+3L1CzjsyKq5LfTyCY3AJcJLm7IX
         oqdljGbw97d9aE+TcrOxEkDbmMHrUKbp2w5SuOaBnS+m46sc2oeZbNz9WG5z3LMtnI15
         Rw+/Fpg2DDa/EkwmcLatk7hIURU5g+66OT1f5SiT9bjXcAEP7njpCQsYdAEasaae/AEN
         tNBOnmJA6ci1b4R3u5b8yZX4j8s+N1BzBb/cLyR//0z6RmCTc+NwYYOuMOJ+014roEyY
         /PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753380410; x=1753985210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/B3d3EW75kabIduY/zlHbkmuA3wULeBZ2mrkCKlN54=;
        b=vAamHyq5vHqgnegKveWVaNANy/JpD9utXqwHHTf2NT8xgXq3seRdCdJOupT5r2O1Bp
         IdznElVOcUW8bNPlNINc5IrHco1GmZ5Lijp68CsGhOs//LdfzliCZkBdtk4g0OCsDvU+
         DqfXQcHn1fhyWwgvLyQMS2DLLRfiNjqMtdGVwvtbyNLB1G4epHe/5cdBSbQgXrI1VX0n
         WIVg3wJ8RH2oYeZvhm/kHVr5JFEMvIYdidrjGlHSGX2y1ckm7f4MMuqYZyXV71qAGK0j
         pEKXUxxyDvcQSoaXe399pdq2bbwCNI86+PagYX6Qi0Tm17s4uenCZKPUJo+4bEF9QDHg
         NHRA==
X-Forwarded-Encrypted: i=1; AJvYcCVHGvyBr0XS8We+xXReqCdA1X4gpDSFzelE513UMLnGcDr8oWLLk5tpooJGkEIATXTIYgTQ0rCJw2ynuzw=@vger.kernel.org, AJvYcCXQ+8HLSGSHknMVpPviJEiV5bQFV0ni4Wfd4pdKLZJNz2DeVtPN3I+ByaR8MbCNCJtV59b0//b8@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmVtHjf9+4iFp4DrxT+9gU95bW60kNnGkVfLnDTZhJWPX5EF2
	hIOJSFvhJ9mbsGHYBseuxIViNsxr6OfLyTnOnPiFminWAT4xnz8NPk8=
X-Gm-Gg: ASbGncuOl0vMaRmspTYuVVdgpV/SQigy62nr2Fbn/KtawccsZJwFoMEyIWOqfSFt+g4
	+a5G/JPgKqCmgyYS+oKAVCpaotNXeB67no7qSauEHynr2PB7C94rw8Bw90siTHP00rWN5Lo3ocP
	36HzUEw9VMtZ3Z+8bv0tpP0IRRBSSo8EaQLG0XWM5xo1weK2vc+DhNq+1Kx5PBYdXMlw28Fi0p2
	U6ubITL81B8Xaov07YA25IfF0+jaE0pYP5X7Jl/qRxitFJRSslaBoVMNTuhcKPTZWgiaXa7ESQ0
	kCiJASXaO5wsXsiZXiz2bnlgI4j6nnCrXaVREAH5HJh+fTg7+k94rPBoL8y5kNw3Hw5h7eJnwOU
	M0SWVB8s+Q5PArP06cu6QmIc23cApsrV0HPCuwy98pqmaOvC/NdbYZom5rsE=
X-Google-Smtp-Source: AGHT+IHYnXoYKHT2KuvkONpl696R4MneL5tFcQGYyhP6WUOrJZ/crhnkcWyNOGzkmRu3TQjg/nUAhw==
X-Received: by 2002:a05:6a00:3cc4:b0:75f:913e:aaf9 with SMTP id d2e1a72fcca58-760357faee4mr10197348b3a.13.1753380409934;
        Thu, 24 Jul 2025 11:06:49 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3f6c1162a0sm1799216a12.52.2025.07.24.11.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 11:06:49 -0700 (PDT)
Date: Thu, 24 Jul 2025 11:06:48 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] vrf: Drop existing dst reference in
 vrf_ip6_input_dst
Message-ID: <aIJ2OA6fnxrdo2XE@mini-arch>
References: <20250723224625.1340224-1-sdf@fomichev.me>
 <aIIXQiu5i_ABjqA9@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIIXQiu5i_ABjqA9@shredder>

On 07/24, Ido Schimmel wrote:
> On Wed, Jul 23, 2025 at 03:46:25PM -0700, Stanislav Fomichev wrote:
> > Commit 8fba0fc7b3de ("selftests: tc: Add generic erspan_opts matching support
> > for tc-flower") started triggering the following kmemleak warning:
> 
> Did you mean
> 
> ff3fbcdd4724 ("selftests: tc: Add generic erspan_opts matching support for tc-flower")
> 
> ?

Both seem to be reachable in my local tree:

$ git log --oneline 8fba0fc7b3dec1abc4dd57449d578d8c2682d60e | head
8fba0fc7b3de selftests: tc: Add generic erspan_opts matching support for tc-flower
a6906c86ff9c net: phy: qcom: qca807x: Enable WoL support using shared library
dea37f39a2ce ptp: prevent possible ABBA deadlock in ptp_clock_freerun()
545a0b84c678 netfilter: xt_nfacct: don't assume acct name is null-terminated
f472ea3cce90 netvsc: transfer lower device max tso size
a9a96c581e88 net: usb: smsc95xx: add support for ethtool pause parameters
5be49dfee611 selftests: drv-net: rss_api: context create and delete tests
4ee6aab279d6 ethtool: rss: support removing contexts via Netlink
8bd3be3a6690 ethtool: rss: support creating contexts via Netlink
f6a1fa5e4327 ethtool: move ethtool_rxfh_ctx_alloc() to common code

$ git log --oneline ff3fbcdd472453190d4f37fe1d1e69e50cce7612 | head
ff3fbcdd4724 selftests: tc: Add generic erspan_opts matching support for tc-flower
dd500e4aecf2 net: usb: Remove duplicate assignments for net->pcpu_stat_type
4701ee5044fb be2net: Use correct byte order and format string for TCP seq and ack_seq
190ccb817637 net: bcmasp: Add support for re-starting auto-negotiation
e07ba344a465 Merge branch 'net-maintain-netif-vs-dev-prefix-semantics'
88d3cec28274 net: s/dev_close_many/netif_close_many/
5d4d84618e1a net: s/dev_set_threaded/netif_set_threaded/
93893a57efd4 net: s/dev_get_flags/netif_get_flags/
303a8487a657 net: s/__dev_set_mtu/__netif_set_mtu/
0413a34ef678 net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/

But yours is indeed the one that is in net-next. Not sure how that
happened.

> [...]
> 
> > vrf_ip6_input_dst unconditionally sets skb dst entry, add a call to
> > skb_dst_drop to drop any existing entry.
> > 
> > Cc: David Ahern <dsahern@kernel.org>
> > Fixes: 9ff74384600a ("net: vrf: Handle ipv6 multicast and link-local addresses")
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

