Return-Path: <netdev+bounces-148148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B60029E0C28
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A38B27A57
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A420D19CC26;
	Mon,  2 Dec 2024 16:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80525199E8D;
	Mon,  2 Dec 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156980; cv=none; b=aIpqpx6/npy2BDdkCFvJxbNS38fnL3zzRNie0jIBlJikQ1mUYfETtxRTKzKa/q/yP0Xi2BvuKkOSU+VQi2UJnbwzLnD0IE4Iw8APasf/lrMN6qv+DX6ydE1ADzNQTekcOMglCqtQtgzCDxRx7/Xa9Xhdm83i6yCtewbu4zJgCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156980; c=relaxed/simple;
	bh=yiONnHmDvX4qwzey5n0hL12IEZwVKs6E4DW4PuPL138=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GFyINAtauCwDU0LxtlWk2nf7l69SjlX0WNMDhFlYUjHVzbiX4YlTrrKW6xpFx73j2+90RqZPxGhJz/9mhZA07kKdZkCv6JResc8yfqlRVs0l4PiqX8d4IdrEWXiRyWJOQKK3y8uBVAEoftW04BybAJGJbMQQln5LHdGsLgGByM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21288ce11d7so40461845ad.2;
        Mon, 02 Dec 2024 08:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156977; x=1733761777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfL9pfVed/5lGXLlfCTto6TeVoqcUMOXv4x0sAXkdgA=;
        b=E98U4EUBSDNdO4VBHD3vcSXgF1AhjKziMunVMqBXFKsEgoEzfBbZZf6CxlnEvfZTHF
         E6MIVEiDG6na+WqXHrmxrW2B2t4HU6YimNxo5BKbJBYQIhqY6XEdk7FMGNbsWCwmVNP4
         r+nddxTUIZd9ennVVLhd03ugC1RwnJ5jiRSuqLfUU7sQoAB5mN5HjesdaAhsMbDq0Ea4
         JAvC+P3ZkcL6ll1ZLPDnCKMwtOHI9/YdMbtU5XcPGzx2iR+XRCp1gKCmeXaPghwHthD6
         5rTMKFXAF6czI7dFiP6xQ0v8cjn9C3Kq+9tsh30lGQz72aMLKhsYyC7aEjSUUzpgGkCB
         vvlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrUMCsdqhQeiJU0ZZHYMtJOzHqzMg58s28S6iHHpjjqJRMdcuIDcpNFDO1oXim7+8c0fgv6fBxW3U=@vger.kernel.org, AJvYcCXq5JxsDdlu3LcCaAi1NKqk6V7RwWD1m0WraoJ0gP7buiGRQ3edPQDOqLIU5UD718d3PIgGfG48vQRHMdP2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8J8z7DtgkszX+tBYDSheNCwq7nl1RkCX2YaQgtbZXYHRoY8d
	jrDTGn2qyhwc5YXAVCszjsDzwtgi0nneGEKRdztMYi40mMdH14L3iuBpr9Y=
X-Gm-Gg: ASbGnctPt1kUcv/VglM0vEMXcXYtV4vSJ4HupncZBDgxEb9vQwz+owCSwLPvjwSyPdp
	CwK8YdfaWhni2BmxW1gWgJkifdPf7gsnBW76sI16zDCqV2lluCWomcQO1HH3YYqjP9jW+Jl09PO
	DlJ+oIWPrrnR4Byb7PUptEOb0xGwvaUFwakyOSHaXuvXJas/l1yMOxwzBeddHfeblFifwbTpPGx
	5B/X7dTrQ7bYt6tjwwgM+l3OM/3vY/e0uWedfoiMVjTIYYO/Q==
X-Google-Smtp-Source: AGHT+IFYuIT1TXCwUE+DMeo6jbJzFI1AzXMjy9fA6FNv9SpCnybc9kSaje1cbCnd4RCEEABbkihZRg==
X-Received: by 2002:a17:902:e949:b0:215:931c:8fa7 with SMTP id d9443c01a7336-215931ca8f2mr76094315ad.31.1733156977566;
        Mon, 02 Dec 2024 08:29:37 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176fe28sm8692144b3a.72.2024.12.02.08.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:29:37 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next v3 0/8] ethtool: generate uapi header from the spec
Date: Mon,  2 Dec 2024 08:29:28 -0800
Message-ID: <20241202162936.3778016-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We keep expanding ethtool netlink api surface and this leads to
constantly playing catchup on the ynl spec side. There are a couple
of things that prevent us from fully converting to generating
the header from the spec (stats and cable tests), but we can
generate 95% of the header which is still better than maintaining
c header and spec separately. The series adds a couple of missing
features on the ynl-gen-c side and separates the parts
that we can generate into new ethtool_netlink_generated.h.

v3:
- s/Unsupported enum-model/Unsupported message enum-model/ (Jakub)
- add placeholder doc for header-flags (Jakub)

v2:
- attr-cnt-name -> enum-cnt-name (Jakub)
- add enum-cnt-name documentation (Jakub)
- __ETHTOOL_XXX_CNT -> __ethtool-xxx-cnt + c_upper (Jakub)
- keep and refine enum model check (Jakub)
- use 'header' presence as a signal to omit rendering instead of new
  'render' property (Jakub)
- new patch to reverse the order of header dependencies in xxx-user.h

Stanislav Fomichev (8):
  ynl: support enum-cnt-name attribute in legacy definitions
  ynl: skip rendering attributes with header property in uapi mode
  ynl: support directional specs in ynl-gen-c.py
  ynl: add missing pieces to ethtool spec to better match uapi header
  ynl: include uapi header after all dependencies
  ethtool: separate definitions that are gonna be generated
  ethtool: remove the comments that are not gonna be generated
  ethtool: regenerate uapi header from the spec

 Documentation/netlink/genetlink-c.yaml        |   3 +
 Documentation/netlink/genetlink-legacy.yaml   |   3 +
 Documentation/netlink/specs/ethtool.yaml      | 354 ++++++-
 .../userspace-api/netlink/c-code-gen.rst      |   4 +-
 MAINTAINERS                                   |   2 +-
 include/uapi/linux/ethtool_netlink.h          | 893 +-----------------
 .../uapi/linux/ethtool_netlink_generated.h    | 792 ++++++++++++++++
 tools/net/ynl/ynl-gen-c.py                    | 139 ++-
 8 files changed, 1250 insertions(+), 940 deletions(-)
 create mode 100644 include/uapi/linux/ethtool_netlink_generated.h

-- 
2.47.0


