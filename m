Return-Path: <netdev+bounces-83192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478189152D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E331C22512
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 08:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF0542064;
	Fri, 29 Mar 2024 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbypD6k/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6E63BF
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700936; cv=none; b=t01kLd74AVrqSHIGTPrIAzkDatzg4PX3isKCOHiYlDZvc/oNSZTcPZKGRy1nA9YJ2/+WtZpnjcuJmrWEnBjR89h/etHRo6aqPCxEuX8kpYqBmeRX6hOEFKbuCPpherxaBczjVWe+D6CBCeQvjcCTZGYMKROs7ykWRbRWlAt9ahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700936; c=relaxed/simple;
	bh=l6URACZdydpFl/gWIAgFxN2oMtPafykJ4Cdp79RKSZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a0PtVE9UMBLOffGnXGPUiVEBOB/ccPj5zaRxxo0K3aKjR/YCc6mEApcGmZq4vSgi16Kk3ltDUGfjgOlgqpshhaV/hWfSSZfRO+uMaUTEHuqR/YI0dGaJ5GD1mTl1fC0c0BhTiiRW3bBrgm8GaCCJhVXwXqXJbvN+J+lmef1fQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbypD6k/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e782e955adso1651063b3a.3
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711700934; x=1712305734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tGMFSQBWxAiCGLhom2Q8+s6vt3Bl4arHn8n/ojer/Og=;
        b=LbypD6k/moyN/aPyfH7Jt78ZWJqPfIcq+c0MsCbt/Z5NVq13ibhSiMZvdxi8fifz6d
         7800i2x/nB9hm0NjMrd1I0ST7esiYb8P7HN5TbU81uWPGwCxeqssvX3JLGwhYzSN/iEu
         XK4+7V7fAgMEzaJVLDidzxHgGICzCITezxDvTwr+/h/R3b0LjMZXX1Tbo0OVrQNr9kFP
         mCyqgjYeC9/WSb5phkuFiWkRFOhN55ieklr29kxl8xU41T88qu8N4D56BIq8Ma/ogucD
         Pc0I9M7DcwACdPxVHZ1CRGbUee+5OAXpcVDXFZ6OHp27rFtqDvBzwYr3jIMAtOTh4T4j
         chkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711700934; x=1712305734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGMFSQBWxAiCGLhom2Q8+s6vt3Bl4arHn8n/ojer/Og=;
        b=a7mPcDftwyJjy8HQuFyp8HGGsNIPx905u1cG6cGFqorhOqw83rnQoPwAxpmm5kJu1y
         lF/p+u+hQYlZ+eY7zMvHGqGxgVwqfMyjDB/UZZv8/yj8h1XZkbSekDF/OMztIJcORd/S
         6ZzclT29a/zycQBYFZWtGnzuj56G5TiVjpC1v+Wij4d2ZNORXKoPZeJqADgMywEy9NzC
         rjdz5SqZDw5A5VlE8hozYmhhJkozBXLRB76TEeQwKdpbPjL8khkOevek7qRyax23kUDF
         tOAwhQXmJ9HpocP6dITlFvOcDRCk6YJkqBk65gLmEbbJYIQ++Z008OFdrHlQvvqJIyXC
         aFaA==
X-Gm-Message-State: AOJu0YzEEglXXu3HGia6MTqkQOEwxA9o0U2HMnoXc3qhPbb4iHXybY8U
	i0ZNgpHK6oSpsbEZ1Ldp+tqn1SA5mmokhf7PonWMNmV9toUanSKwSHO16MLw6wUtoQ4E
X-Google-Smtp-Source: AGHT+IEVCywv11r/Mhs2x+96PZM5jJhduIzmE4+VJ6uqz5s460CWC3c/rtNH4KfTZoAh3rsYE/5r+A==
X-Received: by 2002:a05:6a20:3d90:b0:1a3:81d2:29f with SMTP id s16-20020a056a203d9000b001a381d2029fmr1501278pzi.17.1711700934212;
        Fri, 29 Mar 2024 01:28:54 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b12-20020a056a000a8c00b006e5a915a9e7sm2656020pfl.10.2024.03.29.01.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 01:28:53 -0700 (PDT)
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
Subject: [PATCHv3 net-next 0/4] doc/netlink: add a YAML spec for team
Date: Fri, 29 Mar 2024 16:28:43 +0800
Message-ID: <20240329082847.1902685-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a YAML spec for team. As we need to link two objects together to form
the team module, rename team to team_core for linking.

v3:
  1. remove item/list-option from request as they are not attributes (Jakub Kicinski)
v2:
  1. adjust the continuation line (Jakub Kicinski)
  2. adjust the family maxattr (Jakub Kicinski)
v1:
  1. remove dump from team options. (Jiri Pirko)

Hangbin Liu (4):
  Documentation: netlink: add a YAML spec for team
  net: team: rename team to team_core for linking
  net: team: use policy generated by YAML spec
  uapi: team: use header file generated from YAML spec

 Documentation/netlink/specs/team.yaml    | 204 +++++++++++++++++++++++
 MAINTAINERS                              |   1 +
 drivers/net/team/Makefile                |   1 +
 drivers/net/team/{team.c => team_core.c} |  63 +------
 drivers/net/team/team_nl.c               |  59 +++++++
 drivers/net/team/team_nl.h               |  29 ++++
 include/uapi/linux/if_team.h             | 116 +++++--------
 7 files changed, 346 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/netlink/specs/team.yaml
 rename drivers/net/team/{team.c => team_core.c} (97%)
 create mode 100644 drivers/net/team/team_nl.c
 create mode 100644 drivers/net/team/team_nl.h

-- 
2.43.0


