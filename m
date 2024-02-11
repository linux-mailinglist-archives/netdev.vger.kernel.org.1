Return-Path: <netdev+bounces-70842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C18D850BB4
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 22:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6C4281836
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 21:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BAB5F47E;
	Sun, 11 Feb 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXxAhLox"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C30B5CDF6
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707687849; cv=none; b=Hdb7NHVLdsKelZi/iotwKCru8QsoTFbu7sj4w3qcOyQwl7tESwaAhU1tMYDdmkh1c1cQWhtWa4PaJHlK7p9lb8GmAyqf79F66B5bhY5hTKT5Gw85jLpk/tkeiogAr/U7nYxSvbk0GItszO3USQvD0TOS3vF9k8pL7Wdspjnqq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707687849; c=relaxed/simple;
	bh=aWUQ8dbop1zm31x+jHP3faYtorroDUFz0NQulbr8rTY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qe9Q3j9itImGIVwQqdLHVte8lyQCsvBaFiJc4fQqQ6OGMv6XjlfMPowt6O2Ot8hsTgX3G9s2iuE7Kq5s2K8gG9zKqrHcEPRn0FwHgUhAR22GhFXO9Z9bAAXNRYS3xHsttgeBrvUTOjMH8gCQm79z65jokde/MNsi2pXGyFVzNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXxAhLox; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso4289839276.1
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 13:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707687847; x=1708292647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mDYYLh5yXLdtEqDnH+l0ZFEPa83u4tu/M7tvrJscj6Y=;
        b=tXxAhLoxQW+2jxMLFsD/mW6dOSwttEhtwVu1L1riRtNmJ14t/+aoNL1R/bc3YNoJ77
         BOvshxk/Nqnleee7VX8fiwNDKJApMZG5Ij2Wu+Q1HJIzWxHFo3rRsSZRdGHzpDitWmzG
         TyOXCXpgu+z7d12Po3jZMlG+C8JizpdnbIKE07vzonKR+ZX+O7+v2qCLF/jFh6aWvX1Z
         FLR80C2tEoaKR7VDziC0Tye0rVM/G3AQF86z8YLILjHE1bq6h7QfgU+To44rIOSU+/bW
         /dWBTpIo8cye5Ir1LW2sZ58PXydjMQ3IkMg7MkUmKd4tLrRr6fAnGtNdc7j8YaJlmIgT
         5ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707687847; x=1708292647;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDYYLh5yXLdtEqDnH+l0ZFEPa83u4tu/M7tvrJscj6Y=;
        b=GEjFu46O798oZky95jXjXvtg4kytuurQzCI4i6+qsF2gALFmhJ6nSsOHPgyiM8Yxo2
         tTElg3C905Z7lYgRKayS3D92yfPeENfOfjq7td/9ZsGHiFneLqg0Gq5qLZYSLaNxuSoV
         Zc/ciWbO9uMKfb3D/fsnzMTYBvzSjYg1SpJ9STbXVDriGBh1Du7SzPvpKlWXkNgyyroH
         TS2QkjuUCX/dUDeC376Pcw9Ew7zD7s4xDX/9Lnn6sMvV55AfrEp2Pc+0h5bk0JL8nrEe
         KXKUjJiNY0zNR0w3eYVcyTUS9YGtfv8IrwC473S+FPcuKQZu5lZuT/0JWRVVR0KQKrMs
         yhBA==
X-Gm-Message-State: AOJu0YwAqqIufuJQVBMb6izrOrI5rAA2/SE8wb3fb1uvvXr0coA8nDK9
	Uu7/Y8ts1bo0J7uZfPakahxRyll8dSBhgZtXk1MwoXAKjzPe8hq89RbxT5/aAFJL0to0o2/a92i
	7yoWBVK6jwg==
X-Google-Smtp-Source: AGHT+IH79Eo0orslh2sYwD8W/mttZ9HPD4XFZNN0tZKQyq5d2HjxaV1b8+cfDOtnNJpPKcpSzPMpk7kBAOKYfA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:6b46:0:b0:dc6:d1d7:d03e with SMTP id
 o6-20020a256b46000000b00dc6d1d7d03emr157917ybm.8.1707687847289; Sun, 11 Feb
 2024 13:44:07 -0800 (PST)
Date: Sun, 11 Feb 2024 21:44:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240211214404.1882191-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/2] net: use net->dev_by_index in two places
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Bring "ip link" ordering to /proc/net/dev one (by ifindexes).

Do the same for /proc/net/vlan/config

v2: added suggestions from Jakub Kicinski and Ido Schimmel, thanks !
  Link: https://lore.kernel.org/all/20240209142441.6c56435b@kernel.org/
  Link: https://lore.kernel.org/all/ZckR-XOsULLI9EHc@shredder/

Eric Dumazet (2):
  vlan: use xarray iterator to implement /proc/net/vlan/config
  rtnetlink: use xarray iterator to implement rtnl_dump_ifinfo()

 net/8021q/vlanproc.c | 46 ++++++++++++-----------------------
 net/core/rtnetlink.c | 58 +++++++++++++++-----------------------------
 2 files changed, 36 insertions(+), 68 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


