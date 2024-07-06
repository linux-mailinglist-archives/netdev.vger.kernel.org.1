Return-Path: <netdev+bounces-109632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06859293F0
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 16:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0AC1F2169B
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000636F2F7;
	Sat,  6 Jul 2024 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF/VvRuF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC6A93D
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720274461; cv=none; b=KJHPLLgG+u1jw+j0xF4XuUR9ltIB3EejTov3Sv2+xW278Ig1T8HV6CEe3t8WUzFSB0x1IFU/9BDzPBcdRS+Z6sgf4jMiP1z9/LzALw8vjL2wOgt2RNHDB8DQu/SnEVqf+9oIcRGuLjOmrA3blI9th+U896Kz8zpDySHvcuhjtxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720274461; c=relaxed/simple;
	bh=xZe6GXCMGCFNfM+0O2YchdUILZs00nzbdR3Aw2YxHro=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=T1bX0Q6aOYqLet2nreun03qjdlPte9iUaZfhziYPWupOgfgU4Ia9YIYMNx8LZMLLL4FGFBlraZc1PNjutqWf5igQUjAgmQkqnhrpUwcyEPs69lOydwDJQYfx6S1soArqsbD67WzJ3Xin5NtJufdXXFbuiFYrdrGYFmOJ/3IWRLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF/VvRuF; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79efb877760so61720885a.3
        for <netdev@vger.kernel.org>; Sat, 06 Jul 2024 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720274459; x=1720879259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9EdbZu0erPl2anVo4DSyJbAZUEdrOTwxd2jxVSr9NQ=;
        b=DF/VvRuFxwJdR0vAzyReRXXFzA5Qsm7R699UUdlyOgN8JHiQAFy+GJxIzIJmhgKB/i
         3Qvzi44xR4pKrnoXa1quuGZFbya667PFRY0rJVVEwprJ3kSgIJwhI262arG/CciwFzf3
         S3nHx6bzc1+v1hUaAC/3GO38br6aUdf8wrtoHEHNQ7rRDOwepnRU7P0U7PBQTnllDoUH
         zYUygUxEQuPQjaVype4wtWXt3Tcp9IM3Nx83oFUGx1z+50RQZRY9M/yowjHiiiE7uRZK
         i8zJ7xSorv5PDWCwcI/mhN5KubbIF/Wc3nI71QuYVWkjlOG3xBiUezXigXyVSCr83eqb
         acbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720274459; x=1720879259;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H9EdbZu0erPl2anVo4DSyJbAZUEdrOTwxd2jxVSr9NQ=;
        b=lD8qTd22OCMq4oQjigbCkYfUAW6byYTkKlhknQRF0wWKB5WXna10g7De8lWhEI2FW5
         UIW08PK0ZGwtEUxa9+ZWnGJnWlR9rWt0RBCUcIZq5fHufO/JsSyct3yJh6LqGdBwfd2C
         6kpsQP9pT2K9Pd4RwUyIug3cYR1t7m9foDkgUfvVoo+++FhaLKk3cvXrulpJ5ACfOlCQ
         gDwtueK3TjvtydSOgNviSvw1rlfhr2ACwi5Lv6LHyKONqfdNig26wYMUajsDkSBKpXFD
         IWAkmF9c7a+A1TnuIHn4IPYDtZ5k5lILRk1dmxEIx0+jC1wjNTanipa1Y62Z0LoDJyRd
         mlkg==
X-Gm-Message-State: AOJu0YwxYow/4fMJAsOcbtIYqWIze0DKvqMmuyXTq0devO4vKrcs8Zeb
	mt82bfpiKbVWIfQcgBkZ4M2EIYBrxPBxTha5K6w6kls04eahii/F
X-Google-Smtp-Source: AGHT+IHCocVkaHU16z6X5tGYLAxtxzsKsJNuvqTdzAkbQHksfDYBDHQHWXVRaHjOncfXF4d7vnED3A==
X-Received: by 2002:a05:620a:2158:b0:79f:90:7d53 with SMTP id af79cd13be357-79f00907ed6mr219589285a.23.1720274459113;
        Sat, 06 Jul 2024 07:00:59 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d6927961csm875385585a.41.2024.07.06.07.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 07:00:58 -0700 (PDT)
Date: Sat, 06 Jul 2024 10:00:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 petrm@nvidia.com, 
 przemyslaw.kitszel@intel.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <66894e1a6b087_12869e294de@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240705015725.680275-4-kuba@kernel.org>
References: <20240705015725.680275-1-kuba@kernel.org>
 <20240705015725.680275-4-kuba@kernel.org>
Subject: Re: [PATCH net-next 3/5] selftests: drv-net: rss_ctx: test queue
 changes vs user RSS config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> By default main RSS table should change to include all queues.
> When user sets a specific RSS config the driver should preserve it,
> even when queue count changes. Driver should refuse to deactivate
> queues used in the user-set RSS config.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> +def test_rss_queue_reconfigure(cfg, main_ctx=True):
> +    """Make sure queue changes can't override requested RSS config.
> +
> +    By default main RSS table should change to include all queues.
> +    When user sets a specific RSS config the driver should preserve it,
> +    even when queue count changes. Driver should refuse to deactivate
> +    queues used in the user-set RSS config.
> +    """
> +
> +    if not main_ctx:
> +        require_ntuple(cfg)
> +
> +    # Start with 4 queues, an arbitrary known number.
> +    try:
> +        qcnt = len(_get_rx_cnts(cfg))
> +        ethtool(f"-L {cfg.ifname} combined 4")
> +        defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
> +    except:
> +        raise KsftSkipEx("Not enough queues for the test or qstat not supported")
> +
> +    if main_ctx:
> +        ctx_id = 0
> +        ctx_ref = ""
> +    else:
> +        ctx_id = ethtool_create(cfg, "-X", "context new")
> +        ctx_ref = f"context {ctx_id}"
> +        defer(ethtool, f"-X {cfg.ifname} {ctx_ref} delete")
> +
> +    # Indirection table should be distributing to all queues.
> +    data = get_rss(cfg, context=ctx_id)
> +    ksft_eq(0, min(data['rss-indirection-table']))
> +    ksft_eq(3, max(data['rss-indirection-table']))
> +
> +    # Increase queues, indirection table should be distributing to all queues.
> +    # It's unclear whether tables of additional contexts should be reset, too.
> +    if main_ctx:
> +        ethtool(f"-L {cfg.ifname} combined 5")
> +        data = get_rss(cfg)
> +        ksft_eq(0, min(data['rss-indirection-table']))
> +        ksft_eq(4, max(data['rss-indirection-table']))
> +        ethtool(f"-L {cfg.ifname} combined 4")
> +
> +    # Configure the table explicitly
> +    port = rand_port()
> +    ethtool(f"-X {cfg.ifname} {ctx_ref} weight 1 0 0 1")
> +    if main_ctx:
> +        other_key = 'empty'
> +        defer(ethtool, f"-X {cfg.ifname} default")
> +    else:
> +        other_key = 'noise'
> +        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
> +        ntuple = ethtool_create(cfg, "-N", flow)
> +        defer(ethtool, f"-N {cfg.ifname} delete {ntuple}")
> +
> +    _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
> +                                              other_key: (1, 2) })

How come queues missing from the indir set in non-main context are not
empty (but noise)?

> +
> +    # We should be able to increase queues, but table should be left untouched
> +    ethtool(f"-L {cfg.ifname} combined 5")
> +    data = get_rss(cfg, context=ctx_id)
> +    ksft_eq({0, 3}, set(data['rss-indirection-table']))
> +
> +    _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
> +                                              other_key: (1, 2, 4) })
> +
> +    # Setting queue count to 3 should fail, queue 3 is used
> +    try:
> +        ethtool(f"-L {cfg.ifname} combined 3")
> +    except CmdExitFailure:
> +        pass
> +    else:
> +        raise Exception(f"Driver didn't prevent us from deactivating a used queue (context {ctx_id})")
> +
> +



