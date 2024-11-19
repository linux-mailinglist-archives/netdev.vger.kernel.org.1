Return-Path: <netdev+bounces-146317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE15A9D2CC1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2166DB3DA85
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E88C1D4176;
	Tue, 19 Nov 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="tq57xr6L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBAC1D3639
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037269; cv=none; b=ThmFDdhWYRF0oksBqXfXEEBKTmLRkvtvVuXdXhuBA3ziOQdryuZt0SKXdUKGIQ6HP+d1z0Beq2UH8rVNsJrRhe2lNnP2vzULfPcHlc6wSYwctTHHthZpMGykbJ2uyuaN1EBFT0x2flnjK/VV/RiEPNP4o5lmwrV+3CpyFkeZwi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037269; c=relaxed/simple;
	bh=irfr0wUkMdTaL/yDqhFIaTKzeomftakGMKe8SGtSv3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xk/sveL9LbtzomYqfTpctYvmJ8/lNjR3cj0NRcd8RyEWXDWdBaRAcjzjz5On51kE9p9jX+fv5a7pyxGHVq3nwiOXulCc38zz04eWo9ftxeOLGdSyp9MQP02LIC3D1w04YSCLircZL+MiT67Nhk31H01L5qp6vA8gI0WcysOtPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=tq57xr6L; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso163a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 09:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1732037265; x=1732642065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MLGzDuB6bBk2R3r8V2F/ZqYhmvXEFcQ6FBBynbvI8ps=;
        b=tq57xr6LK/GjfQ0tl+DaErCjJ+nXpTC9qN0zqlX0ANZh2XDvDqWq84waMYXY1SJpDD
         yngkpF9OTaZLudR82EYFP6RTyvOrZgs6U7Rwsr+eZKD7U7Y61Re+icJRGjtHIQfp/1a5
         y49IhkJJ8tEiBB01qp66Txa8U41Z/2mDb4nSrk3x66If4SQ2QbV68w33m0PMn9is9gCi
         TI5GywlU6w3YhQgLY4rnyR9XQYO6JyhLFmXm36fy16BrpnS2FSvubs6WXhw4zYerHc6h
         ydsrMJiQwYGoWUdwePjTQOeEVjtbPloKlMYeIp1dTP7sFrXqhJAbgDPRiz7QYw7JOaCn
         eVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732037265; x=1732642065;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLGzDuB6bBk2R3r8V2F/ZqYhmvXEFcQ6FBBynbvI8ps=;
        b=aJXsicwJa+jumBryJBk7Doxw0ljcxE+VOylvXHf0AWIx16heF/o3xS0qaP85mgxXYo
         TWtGMQQ//c18LdWRQJiGhRW22gImYOnuX+KGnte//mL9MRDakKEIwRdVbvTEBshA+JoD
         X1BwhMl6jiChh8nD9g6kGOlrDwmWJcxvnZ+6WAnlyA2Oi+pMDHrZIaTnbT03UJOMV6Zy
         /XazUple93TDI3aI3zQ6rYc9UM5zKyFw2+K2m59hrxs6dU1WfRkpsDcTJ8ollSx7L8u6
         rd4GIn6tpOpX2G2x/41CuOCOWBzO/7ywWe5swozHUdrpGEpQnkc7f0QZeHGJ8faXkHTY
         VtIg==
X-Gm-Message-State: AOJu0YySxWe/V2LLwEFxn71VlW65/lX47h6hqcl6X2O13KeVJa1RsLBg
	HG1yHQ55zIfG5sYX/uRWWEIPM2FMCLQAzonYdnWCFZ/cMXxXyd1lewM7ZPKe2h1DFAA8dDPSyG2
	jD+Q=
X-Google-Smtp-Source: AGHT+IEzKTuROz2SzDZftXhub++V872vT3mCYN3awJHqnvVO/Ti2Pi0oRpfNU6MvVtthpUTAsoetiw==
X-Received: by 2002:a17:90a:da84:b0:2ea:5c01:c1ab with SMTP id 98e67ed59e1d1-2eaaa75c8e1mr6264669a91.1.1732037265278;
        Tue, 19 Nov 2024 09:27:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea67700e19sm4654246a91.19.2024.11.19.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:27:45 -0800 (PST)
Date: Tue, 19 Nov 2024 09:27:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.12 release
Message-ID: <20241119092743.6a1bdcb7@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This is regular release of iproute2 corresponding to the 6.12 kernel.
Release is smaller than usual less activity.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.12.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Dario Binacchi (3):
      bridge: mst: fix a musl build issue
      bridge: mst: fix a further musl build issue
      arpd: use designated initializers for msghdr structure

David Ahern (2):
      Update kernel headers
      Update kernel headers

Davide Caratti (1):
      tc: f_flower: add support for matching on tunnel metadata

Denis Kirjanov (2):
      lib: utils: close file handle on error
      lib: names: check calloc return value in db_names_alloc

Hangbin Liu (1):
      ip/ipmroute: use preferred_family to get prefix

Jakub Kicinski (1):
      ip: netconf: fix overzealous error checking

Justin Iurman (2):
      ip: lwtunnel: tunsrc support
      man8: ip-route: update documentation

Nicolas Dichtel (1):
      iplink: fix fd leak when playing with netns

Nikolay Aleksandrov (2):
      ip/netkit: print peer policy
      bridge: add ip/iplink_bridge files to MAINTAINERS

Petr Machata (1):
      ip: nexthop: Support 16-bit nexthop weights

Stephen Hemminger (6):
      uapi: update headers
      bridge: catch invalid stp state
      netem: swap transposed calloc args
      uapi: update of bpf.h
      uapi: update to bpf.h
      v6.12.0

Tobias Waldekranz (1):
      bridge: Remove duplicated textification macros

Xiao Liang (2):
      ip: Move of set_netnsid_from_name() to namespace.c
      iplink: Fix link-netns id and link ifindex

wenglianfa (1):
      rdma: Fix help information of 'rdma resource'


