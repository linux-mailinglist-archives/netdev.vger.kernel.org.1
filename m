Return-Path: <netdev+bounces-74365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B68610B8
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A231F213D6
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D4A7A725;
	Fri, 23 Feb 2024 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="lQfe4Xww"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF07A71E
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688811; cv=none; b=rbUt9Wdx4jix8WStmM2hnkxn9OiSupGGggBffNAaQUlmfe6ktN64ijEwekH/i5R5MSTfxclOteHcAdCtqNx4Lgxo9OqSbQ/YZYPYbE5rai1sx09UBk/MSLn94xpWA+Bzb61hPHf5N8miAYXKvtLKQA9Sbf4m2Nyx5jZrc83Qu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688811; c=relaxed/simple;
	bh=wKwKA0p4vt6AwTeHwXt7AVmIzq29IsV/+yie3gcAHZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TmAe956Q0coih7uYloHKU9d0ypwzuaUfBUD2Z2bD9eFq+cgWMaoUFI2BP3YURXP33xGfABcbAgTlvA4XUR52wUVEsvr/8cNjDpiQbcaq2H//Gd8bZy1lTnOodLN0qvEjrUwZRCA1aWEqpB5fGvPBI2UicoTpM6NWtfX0+W7hFD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=lQfe4Xww; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512bb2ed1f7so275429e87.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688808; x=1709293608; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYaGIlRWtlH5yr29hsAr3bMxvcE9aO0b9v1PXvyEfT0=;
        b=lQfe4XwwYuj3CNqRizOTSiwVbCuyYjLZeWfzSXz7VCJFGiKvqOzTd4T/3jDR+6eTAo
         rlGfO20Kq3cQzcBHZxC/ph5f47C4efBvH3mST2PLy9jmo8N2BEXfjmd2PGVDTngLuL+D
         xyPKoqnw9yGqANqrHHO6fokmDJiqQTkEt0M0BHJdm/RFeWexKsJ+mwcEkcabiTJLw1zX
         kuFpO7k83Ai4wNCYwUl3wz+1NFskHHoKGvkMj8y+aozOvcea5xGwQcIYdep84SQb8oFG
         +5gmZatuQB5znoiRDR8IXswsfg04jvsxXs7L7sQ7MkyRJ3C/y6PrJaU7FxSZ4A+YMnGW
         dyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688808; x=1709293608;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYaGIlRWtlH5yr29hsAr3bMxvcE9aO0b9v1PXvyEfT0=;
        b=l3oE7Q4vSXJSpRof8eLi23dK29damnAZOm8j+fCXvNoFUKm6Ou3GWnykS+9gEVH4AT
         YlDiu9D1MOmAWdJnRwEKzE54Ub0ZVy0eOy6kv99+HBN1BPDQkmk/L5+SmA5whTFsCivU
         jYZ0GT44vQ6bQtqtY3GyfiAi3nZZr2CsO9nclpmhlN6EQ+8qJr3bdCsETPFcKd0YiLQL
         VBqWSlIYx5mD5jJbcNAG5rAiC3b8ZCYSI72EnWNi0Vdx+dkm5Ljgjl2mGDRg7mUhSerA
         yBI+bC/Q2g0uq/4eoQZ4MXwflwfB6CnOdcZTExnzr/yqgHu6v+lXdiVYU0JdhDNEIDp8
         K0Og==
X-Forwarded-Encrypted: i=1; AJvYcCW9wWCUdZWmgjtztdT78DqODgkG4ti6zd4Y1CEebkHKxSlgRrhiNGxKm51sz09p4NkRPvAxvcD2QJkjOc0is7MbFdinCuCs
X-Gm-Message-State: AOJu0YwsiPMtCQQ2NBh7M9jw2SGIrS8hPLbKs2C4i8vOgEuhAEVM5Xhy
	R0wLvhmVaocEU/Wj4DPUUplhvHk7L6qjshqGSg399vqS/kQL1hDs5di6oiHGrfQ=
X-Google-Smtp-Source: AGHT+IH2mdJq53bkBO5sog527xIQE+kgKnqpGPuW5eYY2m4q0AZgoHvbR0Xl071UF67OKiEa7BV+SA==
X-Received: by 2002:ac2:58ce:0:b0:512:b437:4b06 with SMTP id u14-20020ac258ce000000b00512b4374b06mr1084775lfo.67.1708688807864;
        Fri, 23 Feb 2024 03:46:47 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:47 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 0/4] net: switchdev: Tracepoints
Date: Fri, 23 Feb 2024 12:44:49 +0100
Message-Id: <20240223114453.335809-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Add a basic set of tracepoints to the switchdev layer that allows us
to monitor all messages being passed between a bridge and the devices
attached to it.

Deferred operations are additionally traced at the time they are
enqueued. This is useful in situations where we want to inspect the
conditions that lead to that message being generated, by looking at a
stacktrace for example.

Start off (1-2/4) by creating stringifiers for common switchdev
objects. This will primarily be used by the tracepoints for decoding
switchdev notifications, but drivers could also make use of them to
provide richer debug/error messages.

Then (3/4) create a common function through which all replay calls
pass, to create a natural point of instrumentation, before adding the
tracepoints themselves (4/4).

v2 -> v3:

Take a more conservative approach to the refactoring of
switchdev.c. In the end, I don't know that my previous attempt really
improved the situation much.

v1 -> v2:

- Fixup kernel-doc comment for switchdev_call_replay

Tobias Waldekranz (4):
  net: switchdev: Wrap enums in mapper macros
  net: switchdev: Add helpers to display switchdev objects as strings
  net: switchdev: Relay all replay messages through a central function
  net: switchdev: Add tracepoints

 include/net/switchdev.h          | 130 ++++++++++-----
 include/trace/events/switchdev.h |  74 ++++++++
 net/bridge/br_switchdev.c        |  10 +-
 net/switchdev/Makefile           |   2 +-
 net/switchdev/switchdev-str.c    | 278 +++++++++++++++++++++++++++++++
 net/switchdev/switchdev.c        |  87 +++++++++-
 6 files changed, 521 insertions(+), 60 deletions(-)
 create mode 100644 include/trace/events/switchdev.h
 create mode 100644 net/switchdev/switchdev-str.c

-- 
2.34.1


