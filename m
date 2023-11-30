Return-Path: <netdev+bounces-52630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120DB7FF867
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E6B6B20D84
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0EA5677E;
	Thu, 30 Nov 2023 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7JoHjZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83A310DE;
	Thu, 30 Nov 2023 09:37:07 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54bb5ebbb35so1301606a12.1;
        Thu, 30 Nov 2023 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701365825; x=1701970625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeCXfRlmQUScQLZAUqmI2JqPj6eKJj/ww0TVfVZMmZg=;
        b=e7JoHjZZlcMRLsG/FiSr0Jhe3FDs8gEDYISFo46t3clndJGOLVJZ3EORqO9tmHgbh1
         KObaLxXr4k7Uj+1BEu24kUJ5IOL5m9fFCNFR/B37trsVZ6c2Ef82vi/e2LG7c2C4DIgv
         7pvOz0b/hjd2NCyLg+HDUvnhcA5Fp1kcekp+hxPtE0Kw4wt1uViJHsj25hJ+nC9dlzbN
         Tx8IZXTcVgmoYEuSXyGGNJzqqpYd8QtyjPw7Z09ytoFlErLK8RATFrcMxLbxlavQL0bT
         HpljCV4+z04KsNpGCCFul4craPEGmbzuu6u3LF0Nf8zaELHDZK10NnECdzCYbUBuHY+1
         WJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365825; x=1701970625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeCXfRlmQUScQLZAUqmI2JqPj6eKJj/ww0TVfVZMmZg=;
        b=Hd14Zo+uG8mvM8EUf028fPo8DCv54XQ9/ag6zBkUViQ5svlsQ0nZxCSDuYmW2XVhGw
         u9lIiQ4PJfwrGytPJOYKaKAcV0RUH/2gK4C2JlYU/9g/6BbogKpSvG7t28+XxkKEOmAu
         VE44Kv577hMHscnm43Pei9/mn36egOqF0TjGwSo+T3D6uGNKZpEqwEqXHxnsglG+ZFOp
         ZTXVVflB6FJB0KhYxgot74KnNbI/j8PH+4A+SyqlucsPQPuce1H+jVohwP6og0CN3tAH
         VnIpJy23FUJvKpnYRO79rvq5YPb1nMvmW9DbH0py+SybLuRzBuaReV81pvhiWqTkSeEY
         VqTA==
X-Gm-Message-State: AOJu0Yw7FY/MQRlj2GC5dZWa5NwWqnDpkCJh5i/f1/1+9BSbmDgD0WQ3
	22LjV99nyJhhpkfCMrHBi7JvUhynh4jHnw==
X-Google-Smtp-Source: AGHT+IHCUiqbxPpMQrWv/LCVlmrkaO/pZL/818FfuyccD344VX2SXpADyXTxyyLg+sb0sxU4pJWnxw==
X-Received: by 2002:a05:6512:ea8:b0:509:3258:687d with SMTP id bi40-20020a0565120ea800b005093258687dmr91448lfb.2.1701364236937;
        Thu, 30 Nov 2023 09:10:36 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4842:bce4:1c44:6271])
        by smtp.gmail.com with ESMTPSA id f14-20020adfe90e000000b00327b5ca093dsm2014531wrm.117.2023.11.30.09.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:10:32 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/6] tools/net/ynl: Add 'sub-message' support to ynl
Date: Thu, 30 Nov 2023 17:10:13 +0000
Message-ID: <20231130171019.12775-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds a 'sub-message' attribute type to the netlink-raw
schema and implements it in ynl. This provides support for kind-specific
options attributes as used in rt_link and tc raw netlink families.

A description of the new 'sub-message' attribute type and the
corresponding sub-message definitions is provided in patch 2.

The patchset includes updates to the rt_link spec and a new tc spec that
make use of the new 'sub-message' attribute type.

Patch 1 adds missing scalar types to the netlink-raw schema
Patch 2 and 3 add sub-message support to the schema and ynl
Patch 4 adds binary and pad support to structs in netlink-raw
Patches 5 and 6 contain specs that use the sub-message attribute type

Donald Hunter (6):
  doc/netlink: Add bitfield32, s8, s16 to the netlink-raw schema
  doc/netlink: Add sub-message support to netlink-raw
  tools/net/ynl: Add 'sub-message' attribute decoding to ynl
  tools/net/ynl: Add binary and pad support to structs for tc
  doc/netlink/specs: add sub-message type to rt_link family
  doc/netlink/specs: Add a spec for tc

 Documentation/netlink/netlink-raw.yaml   |   56 +-
 Documentation/netlink/specs/rt_link.yaml |  273 ++-
 Documentation/netlink/specs/tc.yaml      | 2008 ++++++++++++++++++++++
 tools/net/ynl/lib/nlspec.py              |   57 +-
 tools/net/ynl/lib/ynl.py                 |   84 +-
 5 files changed, 2452 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/netlink/specs/tc.yaml

-- 
2.42.0


