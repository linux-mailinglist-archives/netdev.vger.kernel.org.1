Return-Path: <netdev+bounces-94676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5389E8C02AF
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60641F23666
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D8E7D41D;
	Wed,  8 May 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e/7av/64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1862E62C
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188299; cv=none; b=GrIxOjWJ1uoDCNhaz+WYrKWkbmFpDhYcB+ldLzfPA20ic1WXD/MFUdDtTPdWCVbg/zNkehL7IdacsKHv/qtUJnoALi0Z4N/RRzuiqUASIdWExkT2h7VuLQbk6SwBgXYZK3XlDYrn4BYU3z0lrGmjvJP9B2G9xCRN1Uinc0GuwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188299; c=relaxed/simple;
	bh=3H2Ex21607oQUraLy4a6ZebeomrW6qImqDFNkYN7KH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyUkGA+k8uBlK2Wg6KjqCe9VrNZKRZXiXkyf7yc9Uza8afhAYCuEWYYJtWrpsNpPL/pgSUHy1nYWPf1ok8T1f9f1XxrPrvWtitl0UN/wBzQaVp02XEqqRX1DY86WEnX7cryrX8ZASh+nQ3C/WiFdRNivKEbcHM7jp8K7HnBDDSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e/7av/64; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so8626b3a.3
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715188297; x=1715793097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tSmrj41Qt+Se2fdGi7WeozvVj6AfH//AS3pb2zkquGg=;
        b=e/7av/64Dcgf3OMhlc/3aG68Cv9i0FKAXx1yap6cSbdW0nsJbcNd95Yo1lRWM4CXEO
         StJJA023SDun4hdxa5p+ZL91TWCTjhJqbT/I8537Y89y8wwXzIEuISflNf2v2IqVxAlb
         rwDXFcNsSy0ds4FxqMQiDgXwqp7u78CH/UbW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188297; x=1715793097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSmrj41Qt+Se2fdGi7WeozvVj6AfH//AS3pb2zkquGg=;
        b=eDxzcMff81EWbOnC3gjsqRdkh3ir5DWVgFCVWNgBXT3I+/7bCC7z7HChExNfRYG9e4
         /3dMtoaTM+P1bvdWkzwmgYRdMs4KYLbrOusGFOcXIVRxBaoCCbbZBH3/hrzjHjNiWgrS
         VL5z8dvr0lQfqZHVHvekpJ9DrqtkN8JaajdwAQges/VMzPM/nfHc476GWsQe7mEBxZEq
         g2/SpNpdE9Ht5mLhIZXlyt4RO7Z8k++B//BZUKXo/cR1cIwnNjIObB96od/5kSSQ56KK
         jSM/uRJ65l27jmOG9OHymmDIKn/ItAGrDHBqZZ2u6Bwh2OEwn/vHzn2tzqf3q6lIS0bd
         4qWg==
X-Forwarded-Encrypted: i=1; AJvYcCX0nSGo8NagqoqzotZDL+0FDBS37b1AFE8ZtY2myaLNFljIdxLXoMLKQJQg3uJjyPjolBNv6ISBe/UXs4XTBw+4+A+bxi8X
X-Gm-Message-State: AOJu0YzMTFDWyw1pG5sJ/AT/uG15fXsee7oNJs9tI6L6lobQ4Ovz9+Xk
	VvnIBt3q0sjBvf3TIPujkl3uG+u0B1NPfvl34iqQny4TZLQCCmkOLnAWUa/TXg==
X-Google-Smtp-Source: AGHT+IHN8eeXE9OsgItxEKHR70nrrazwBAjav29jEzJB0wGGmdP+iVlP1VjtMYRBUjqpRzzzPBgYhQ==
X-Received: by 2002:a05:6a20:c88b:b0:1a5:6a85:8ce9 with SMTP id adf61e73a8af0-1afc8d1b02amr3543639637.12.1715188296881;
        Wed, 08 May 2024 10:11:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lp9-20020a056a003d4900b006f44ed124dfsm9245352pfb.160.2024.05.08.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:11:36 -0700 (PDT)
Date: Wed, 8 May 2024 10:11:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Eric Dumazet <edumazet@google.com>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <202405080959.104A73A914@keescook>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <20240424201234.3cc2b509@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424201234.3cc2b509@kernel.org>

On Wed, Apr 24, 2024 at 08:12:34PM -0700, Jakub Kicinski wrote:
> On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Wei�schuh wrote:
> > The series was split from my larger series sysctl-const series [0].
> > It only focusses on the proc_handlers but is an important step to be
> > able to move all static definitions of ctl_table into .rodata.
> 
> Split this per subsystem, please.

I've done a few painful API transitions before, and I don't think the
complexity of these changes needs a per-subsystem constification pass. I
think this series is the right approach, but that patch 11 will need
coordination with Linus. We regularly do system-wide prototype changes
like this right at the end of the merge window before -rc1 comes out.

The requirements are pretty simple: it needs to be a obvious changes
(this certainly is) and as close to 100% mechanical as possible. I think
patch 11 easily qualifies. Linus should be able to run the same Coccinelle
script and get nearly the same results, etc. And all the other changes
need to have landed. This change also has no "silent failure" conditions:
anything mismatched will immediately stand out.

So, have patches 1-10 go via their respective subsystems, and once all
of those are in Linus's tree, send patch 11 as a stand-alone PR.

(From patch 11, it looks like the seccomp read/write function changes
could be split out? I'll do that now...)

-Kees

-- 
Kees Cook

