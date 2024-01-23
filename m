Return-Path: <netdev+bounces-65085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F8B83936D
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B141C25F6F
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 15:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D330260DF5;
	Tue, 23 Jan 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="MsISOLUI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFFB60DDC
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024251; cv=none; b=DXY0YP8ysQF+M83rJ0okaG1WG3QnA9YGG3Rk4uVvGR51uYhRCzt3HE7P/YuGJg7pUpT75MVNpCc4HoK/a+zSYhu3CLkWfkbu+JYF8OUcLg2SxUn9izJH8JYUlIttEObjC84F0NFi2DnLD4Nfz/uKH0RM5MdWDXsLqJ2qMPuA66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024251; c=relaxed/simple;
	bh=SmprmXJKPp6opHqPLLviYvms4SHFNPILVuQUb8Rwo/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a43/OBw1lvTIiKn/1u/fvQsMfpifT1bfgaPZC4lEJWfgqbvx2SApqjaZtuVSS/znyw8udMDVw8URgvHfSYlRh9bc4AcccZFRRvce/oG9RVB/0PLHCxN0ZstIu7O644o+XCEFlrChouIyFw6PhYgO7+N//9XLHr/TPO9ze3vtIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=MsISOLUI; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cdfa8e69b5so48953261fa.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706024248; x=1706629048; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=veMMcsUebJYkhfmIXUs+5LrZbCXp0fVUgnh9FAkwwJ8=;
        b=MsISOLUIWstqL7yUkebxzfBu/pnfgZU+Svg90v4DNfJ250MNoawySr6YV+xla1ydcP
         rWrPH6Odc6TxYUgQ834XTxugGIBYSGgpMOOe+4HAvLfznpixjYjsBbyRS/cwRdowrRpF
         Joq9DkKkGh260RxSUIdbS4vGn01ZWKRSWnVkyLZswK0EwAXuj6D2/S1AZy+hx0YPqhb4
         SmTzothq5IsenSEqG2vJsyf+5N76jI4UtMtAK7WZJ7a4ymxBymNL6CiR8JE3SE1BTKPs
         FsdOMbNZfAJUa8uXqYmB8QH3/+2K6F8Iet7ktAymN14SSORXyLiePpsEz1dU9+SkTQcX
         FoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024248; x=1706629048;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veMMcsUebJYkhfmIXUs+5LrZbCXp0fVUgnh9FAkwwJ8=;
        b=EI2XlO2+gTB3GNuHEDBN5G1tEy5S56xmpQwg5KH3N1t7110DDObFRr1lAvsEYZdbWS
         WfqwuXkm9fo1ZNKbdABWmyUkdccdPlHKQFOdYnwYK7zSf0kgvjyxgf6MXlbsLq3tzTWt
         BTOaJvf63nnT85gWIuu+UxqUDxjOULgNMHz0b+EG7rBvPBu9Tjry6hUjxBkUFM7Bnpvn
         CiHKW0tfLqZ3ObipK048Ps2JrXodUuXwD8V5dtIXVfNPoKXHAintX2ZT1X2YUGlthrYM
         97Rz3DDa43Qw/wiSD+Y2FV05wJcIKGvJD08MZOMv7mbY6qzD8dC73KH9hREglO9zxviH
         pGcw==
X-Gm-Message-State: AOJu0Yx8Knhw1jBpQ0N+B5PTg/g9BJPyutCMnSG1bJjfrjMFgoVtlRhX
	NirLMsrmSMmBRFu0ngn+5rBIQ7cdgiSkETgzVilkcfhxiHlrKO0Ihjkk7f4eMto=
X-Google-Smtp-Source: AGHT+IGhlL9oAnwBrOhrZJ0R/VfLySlP45A9B/Vc0ntm6DeD38WuWmDZF1mZUlXPMtYF7otvhtzzRA==
X-Received: by 2002:a05:6512:1295:b0:50e:ca83:887e with SMTP id u21-20020a056512129500b0050eca83887emr1948380lfs.34.1706024247144;
        Tue, 23 Jan 2024 07:37:27 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id h23-20020a19ca57000000b0050ee3e540e4sm2386790lfj.65.2024.01.23.07.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:37:26 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: jiri@resnulli.us,
	ivecera@redhat.com,
	netdev@vger.kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: switchdev: Tracepoints
Date: Tue, 23 Jan 2024 16:37:02 +0100
Message-Id: <20240123153707.550795-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This series starts off (1-2/5) by creating stringifiers for common
switchdev objects. This will primarily be used by the tracepoints for
decoding switchdev notifications, but drivers could also make use of
them to provide richer debug/error messages.

Then follows two refactoring commits (3-4/5), with no (intended)
functional changes:

- 3/5: Wrap all replay callbacks in br_switchdev.c in a switchdev
       function to make it easy to trace all of these.

- 4/5: Instead of using a different format for deferred items, reuse
       the existing notification structures when enqueuing. This lets
       us share a bit more code, and it unifies the data presented by
       the tracepoints.

Finally, add the tracepoints.

Tobias Waldekranz (5):
  net: switchdev: Wrap enums in mapper macros
  net: switchdev: Add helpers to display switchdev objects as strings
  net: switchdev: Relay all replay messages through a central function
  net: switchdev: Prepare deferred notifications before enqueuing them
  net: switchdev: Add tracepoints

 include/net/switchdev.h          | 130 ++++++++----
 include/trace/events/switchdev.h |  89 ++++++++
 net/bridge/br_switchdev.c        |  10 +-
 net/switchdev/Makefile           |   2 +-
 net/switchdev/switchdev-str.c    | 278 +++++++++++++++++++++++++
 net/switchdev/switchdev.c        | 346 +++++++++++++++++--------------
 6 files changed, 650 insertions(+), 205 deletions(-)
 create mode 100644 include/trace/events/switchdev.h
 create mode 100644 net/switchdev/switchdev-str.c

-- 
2.34.1


