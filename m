Return-Path: <netdev+bounces-77909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1087371F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B853A284743
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B289F12D767;
	Wed,  6 Mar 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlBjj2AM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0C130AEA
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729832; cv=none; b=f+UVYeNieluTxMqCFJRWW/g80gdb1JrDQhqBkohXTpLVvwey4vxs5mi5okiUDnJNlbc884YMArQunfztZYVUGQmNrrAPWvf7poS9RnSS8eyMuaeJbST/WqChXPKysL2GR4gzVZ8A6LwOdpCNBOhDtUiX+q/qRbeTAzt+oLQbkF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729832; c=relaxed/simple;
	bh=EsGjkWEz1p36pVcCQXznBJj6XdJdT7vx45NIg3/iPFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNjERWOkjo7KcOWT1bpKwxWn2Oi77VmE2Mz2vNC9I2WAW/iV1Gje7lytvvGDRLQ7pTBzFLEiIgl1J8E657jVyh4lIkm/JofGh6ukmh2MiSuasoTYYbI8SLTdUmvyMLsDHJI/itNX+deeg40h+muGtk3MAwD4l8JYo7M29KVtWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlBjj2AM; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5132181d54bso7938160e87.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 04:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709729828; x=1710334628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UN7owD9Kf3MZh+zNWvQHNa6BCWm0q6hmWvptXNtqSQ=;
        b=BlBjj2AMN3bFgKrTDE8fqXNMNYy+zpvMSBy5pwxQYwyhc01YRESX+AHD6LPwEQ65XS
         oOdJVNJ8tmOqyobmVZUA0TOZdzhBXYvSp1NNa+9gArjylbUJ7U06eRcDI8lholsW+OGw
         0N6fFL21wUVtD9VElqSKc6MaxxJ38/u6sr3hy+XcuhRyjlaTLugcMC7EEMDU6VA2poNF
         Wh5CIpJqjv14eMQroZHPCPZQxJN82oJzTN8frWe6w8jIsZ+97DPndJDDU16VwaRu5VcQ
         wba9ImTDOgBEHtNFVbP/nU5IXn0Ty/DFXrBmNGM6EoABtVrtPg8tAv/gB+uC7fDApOHU
         li3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729828; x=1710334628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UN7owD9Kf3MZh+zNWvQHNa6BCWm0q6hmWvptXNtqSQ=;
        b=LK4XN+rqmzLsgff2ioefLJLE2uTyQFB5zDMqn34Q67lZFy2I+ZdV39HaInOy5zMTYq
         Yg7f07ItZQKAubvYSOOZz8Uu+mYyAOubkb9VOXg+Xc28FtB9APrDlCvUigZwu9DdqT1D
         gpzRx3ylRFqMf2Hot3QB+BSAEpY9yt6n6XvIO2AJPauA32MvXPt+ZbFIFw3BIWvNwf90
         uRzbyLo9bPLTpuDGSYPpnc77tkfCx4FDlBRVhgTuYYOp3G/jqsRnvdsfAzreT8w89SEg
         udA25G3S88axTa9UP02WcK3gDjkLTxn5mHIamWBrpvSB++Wx1mVyddcZ3jOPi+9wHUNd
         pO5g==
X-Gm-Message-State: AOJu0YyqYphAZI4n0NbfvcG+2WD1BqJFwebuXleSYSpvJ9afkgD3cP/U
	YxhYPtapWF9i0Ln9frj2W/0iNr2y9HU9jgLXvpARogFwxpmgPEL2HdRsJAc7VxM=
X-Google-Smtp-Source: AGHT+IG822M164yYpe/rcaE7kYajuImXNeDuUMZjcekiWnAl/26wyURkyUrH18PM4usdv0FjhYM2GA==
X-Received: by 2002:ac2:5b4d:0:b0:513:4b49:e1c3 with SMTP id i13-20020ac25b4d000000b005134b49e1c3mr3141732lfp.53.1709729828174;
        Wed, 06 Mar 2024 04:57:08 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:503c:e93d:cfcc:281b])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b00412b6fbb9b5sm11857279wmq.8.2024.03.06.04.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:57:07 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 0/5] tools/net/ynl: Add support for nlctrl netlink family
Date: Wed,  6 Mar 2024 12:56:59 +0000
Message-ID: <20240306125704.63934-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new YNL spec for the nlctrl family, plus some fixes
and enhancements for ynl.

Patch 1 fixes an extack decoding bug
Patch 2 gives cleaner netlink error reporting
Patch 3 fixes an array-nest codegen bug
Patch 4 adds nest-type-value support to ynl
Patch 5 contains the nlctrl spec

Changes from v1 -> v2:
 - Added patch 3 to fix codegen bug
 - Removed multi-level array-nest patch
 - Added nest-type-value patch
 - Updated nlctrl spec to align with headers and fix compilation

Donald Hunter (5):
  tools/net/ynl: Fix extack decoding for netlink-raw
  tools/net/ynl: Report netlink errors without stacktrace
  tools/net/ynl: Fix c codegen for array-nest
  tools/net/ynl: Add nest-type-value decoding
  doc/netlink/specs: Add spec for nlctrl netlink family

 Documentation/netlink/specs/nlctrl.yaml | 206 ++++++++++++++++++++++++
 tools/net/ynl/cli.py                    |  18 ++-
 tools/net/ynl/lib/__init__.py           |   4 +-
 tools/net/ynl/lib/ynl.py                |  19 ++-
 tools/net/ynl/ynl-gen-c.py              |   2 +-
 5 files changed, 238 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/netlink/specs/nlctrl.yaml

-- 
2.42.0


