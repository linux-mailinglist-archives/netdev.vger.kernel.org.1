Return-Path: <netdev+bounces-83186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CCF8913ED
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 07:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785952885F0
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 06:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDEB3B782;
	Fri, 29 Mar 2024 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL0GeMRu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9821171D
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711695271; cv=none; b=eq5k8mtWQpuEDJLx3mOGfugOEX3MxjfooVsD4ooBZL2+RuZATtrCEop6Vne18UaWNB30OeQ4tOAsBcxvRT4wEOPFLgbDpUGTqyQ3Y+yMWgmj2GnA9o/vQ/bAlqBbokb8N5MSd2VQQOrXtHSV3IVCnlhESHOqWN2HLWqQLtfxjIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711695271; c=relaxed/simple;
	bh=oMS9i1d5dKrh6oFBGXKVOLG6LQ0CI7dKsozHsEM1dgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZImueqgTfpq1mfFL1nVwVqPI/bP/d+5z/DwLOYH0Pk/YiXl+qrmqsSXIRr8RzXD9IheuWYiXZH/7ca9Dj5E3jjbLDSu4tltEqxNfudZKsq0z0GMpbvqRTArQZTQDGMy/f1LqKfw5+1cY4DMXP8SxmEODjhZ5alfFeOpdymmLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL0GeMRu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ea838bf357so1486813b3a.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 23:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711695269; x=1712300069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szurVUTxnXbNRHV0T1I5B5TqxpKtZIuONlEA7/W/vx8=;
        b=kL0GeMRuxMuo0BauzTcXWTQy4eeupr9qwBG4nwrFTBF1XBP0HKAlT50fabQ7z58mM8
         PCDvc53Pw6O9kg3P9Lj3bCAd8ib7TmdIRqIbqCViWcq7I5ebHU2Gna388Xssn7rulNXH
         B63YDpAm0bdSyeYWgG80W3tH4iG1NbKva0OfwSGLtoWwjrCU07QqnfU87LULJduDLh8H
         1TCp+v7KKxGfU6bOiGiiiBFuhavKjx1xznuUn3XNHjEfX8faASVk4fPc6nb6ts2BNcqT
         3wO8tdewq8orQMn7XVbrPZIB57Sjhj6MCGNwKD9sIaQDkP1uUsp6OBWThULAsxOLSzQy
         dbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711695269; x=1712300069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szurVUTxnXbNRHV0T1I5B5TqxpKtZIuONlEA7/W/vx8=;
        b=pi8ck0iNpIlOj7w+zwOdJTuTPftPPks3jj5ghs7Y3owZw9mOvze5IwBp4zTeayOXAk
         z6zDpQQyiOzzM4G9RXKxuRmZwNdo0ZdrANovcn3ugNnmmcqv1K272mGvI/qaCtorFVz0
         RgwhaW0cZZzSglApGw9aZc6o8e1XjgZUnzlVLZ9SFCmAmgeWPhmASKiJv7IzNp7zpwV8
         CxWUdBhT0JgBBRQZV+U/W5qyIpAzPd2flaHiLwzEDBdRI0IDhG0W7vlL6NJClS2YuGao
         +Fo7GZ5dQWzZl0J4Lqcq4N78VSb03s9/nGK97OeIZ0oBmlLPBvOTM8SMeabHgIhRJiCt
         JQWg==
X-Gm-Message-State: AOJu0YxsGuJ17IpRdfSPiN2CLezYQchWKX8hRVU5vfvIRnits/Knq4uB
	eWa/+M6eRs/LRk24Tn1evYVqQTGbXtufJWqnYmYydoBdBtIARW26V66amZNIXFHyx2F4
X-Google-Smtp-Source: AGHT+IE9zZAlx59j7aGVKS+ymFtpW5l5f4ozXoQKwvXRAmiR68qHUinE3Pmvkvf8PQ/6hjY6hPnXXg==
X-Received: by 2002:a05:6a00:4b02:b0:6ea:b1f5:112c with SMTP id kq2-20020a056a004b0200b006eab1f5112cmr1473501pfb.27.1711695269477;
        Thu, 28 Mar 2024 23:54:29 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g8-20020aa79dc8000000b006e56da42e24sm2423251pfq.158.2024.03.28.23.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:54:29 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/2] ynl: rename array-nest to indexed-array
Date: Fri, 29 Mar 2024 14:54:21 +0800
Message-ID: <20240329065423.1736120-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rename array-nest to indexed-array and add un-nest sub-type support

v2:
1. raise exception for unsupported sub-type
2. merge all sub-type handler in _decode_array_attr
3. remove index shown in indexed-array as some implementations are
   non-contiguous.

Hangbin Liu (2):
  ynl: rename array-nest to indexed-array
  ynl: support binary/u32 sub-type for indexed-array

 Documentation/netlink/genetlink-c.yaml        |  2 +-
 Documentation/netlink/genetlink-legacy.yaml   |  2 +-
 Documentation/netlink/genetlink.yaml          |  2 +-
 Documentation/netlink/netlink-raw.yaml        |  2 +-
 Documentation/netlink/specs/nlctrl.yaml       |  6 +++--
 Documentation/netlink/specs/rt_link.yaml      |  3 ++-
 Documentation/netlink/specs/tc.yaml           | 21 ++++++++++++------
 .../netlink/genetlink-legacy.rst              | 22 ++++++++++++++-----
 tools/net/ynl/lib/ynl.py                      | 18 ++++++++++-----
 tools/net/ynl/ynl-gen-c.py                    | 18 ++++++++++-----
 10 files changed, 66 insertions(+), 30 deletions(-)

-- 
2.43.0


