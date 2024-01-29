Return-Path: <netdev+bounces-66883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5508415AB
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A26F1F24768
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93BC27457;
	Mon, 29 Jan 2024 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjeIOKe7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D4714AB7;
	Mon, 29 Jan 2024 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567724; cv=none; b=hL+Ux+g1Hcy7Mfl+hhjLoln13XsxI+PpaS9bYylWcp3vpUWfu0U3Gd4B2+4fBWdHv6cylIEWAaFV5iHdihoyvsal8Smc9b1cH9jr0MsLUZnNEW0T40aeJqTGRwm+dmpGTA11aBvq4IiKZAIZc7wyimkaUk6O1ziFDU2V+iXUN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567724; c=relaxed/simple;
	bh=vQW9Xvh/YG9PKV1r+imGUPRVDcHKjSGttdHzT21dY8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCY0qKQ+ZJMZeTAlgZ+1PjXGlOQYBhnrDIgyqopAdwRLmpWK/jx7YJZFD530CLOMPe3sR67GUHO1PoiAMZcZmD6Lp0Spd25LzmWYKMtOP68YjrLf0INKYld9eRUD0FW7/mT2TX/IH6Y2gAzLKwoyvJ5bi9uCH9uW4XnNJ7CJ8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjeIOKe7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ef6f10b56so10961305e9.2;
        Mon, 29 Jan 2024 14:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567721; x=1707172521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mU1XzJNEXhOdfnqUbftSYm04uErm5Tjsf1H4e789TCc=;
        b=kjeIOKe7PGr0khE+lZ0exc8udAv01P0bIyP4gB+5mOPhmxy0Yw8QL19nD4bKf1DSGc
         2dZ9T8YNd/G/G5AASe5K2SWPWLqXbDWcgcz4oQiD2tf9FluSmQbKoacIbh/nIXcg3YZg
         tuLf+86xNbaTPWMQs4or5uVWdUKjeCwrmHSwp2rpndjG6ltJbLIzThSLJqWGoRbSpjpT
         mfBLkXyUeU9yBN2en9ZkZeLkBiS9zp9fvvCTQrt8+UC5YXnnWxBSz4VIAtq5Yj02WWaF
         oDErvdHJ81ZwqDhC4+74tiVN+X8l7Rq2uVlfpHYr1WZWZhRS4kdNuy/mtUjv1vhDAP0N
         85Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567721; x=1707172521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mU1XzJNEXhOdfnqUbftSYm04uErm5Tjsf1H4e789TCc=;
        b=laYntIY5Qk+Kog/8ZHRk8E60Tf1oXU6XbgEm5PRHycWazFqVwQ6niw9msd66/gdl67
         2CRGjP9CQfPbFGvavMLeIqLeqj+6/8LPVP4n6J+4pp0XqLjsCUv0mlcHycW88bIKoXZw
         6+AHyZWodFy4u/V6ILDP9ax9dnA6bQA9Ps6KFQ/fKiOkeyEo3JQSogiZ+zn2XSXIZTgb
         eMJFqpzLIKBlc0xZkQ5EroapZg0xuVxHPcnwvcK4HVRDtUkMMsxTkF2S3Xhs911/pVX4
         7wd8t+zGz4lPsHUX+dsmcvzpgMorReMfOwDWXtFUR353FPPPyHf86ut3ypfev38FGuVI
         EIyw==
X-Gm-Message-State: AOJu0YzxJDC25nWChjiNyFtnlJJDsKX031Og+M9kPZdIz6I/ZLwIf2Yq
	u8hJ1xo7SpJts/ZlPVJq1eveUFgitdl1tYC3qP0WnDwDzPQbnuxVEzlWemLbWRA=
X-Google-Smtp-Source: AGHT+IG8RuptjHcpRo9ua2ymxh2PuFqjS4lnbgyqoiWCANG9Y3CuzB/IbQP01yq3ihSyj8BVbiqrjg==
X-Received: by 2002:a7b:ca55:0:b0:40e:df1c:cf0 with SMTP id m21-20020a7bca55000000b0040edf1c0cf0mr5663129wml.33.1706567720643;
        Mon, 29 Jan 2024 14:35:20 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:19 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 00/13] tools/net/ynl: Add features for tc family
Date: Mon, 29 Jan 2024 22:34:45 +0000
Message-ID: <20240129223458.52046-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add features to ynl for tc and update the tc spec to use them.

Patch 1 adds an option to output json instead of python pretty printing.
Patch 2, 3 adds support and docs for sub-messages in nested attribute
spaces that reference keys from a parent space.
Patches 4 and 7-9 refactor ynl in support of nested struct definitions
Patch 5 implements sub-message encoding for write ops.
Patch 6 adds logic to set default zero values for binary blobs
Patches 10, 11 adds support and docs for nested struct definitions
Patch 12 updates the ynl doc generator to include type information for
struct members.
Patch 13 updates the tc spec - still a work in progress but more complete

v1 -> v2
 - Use spec-led sub-message selector resolution instead of ChainMap
 - Add docs for sub-message selector resolution
 - Remove unused variable declaration in ynl-gen-rst

Donald Hunter (13):
  tools/net/ynl: Add --output-json arg to ynl cli
  tools/net/ynl: Support sub-messages in nested attribute spaces
  doc/netlink: Describe sub-message selector resolution
  tools/net/ynl: Refactor fixed header encoding into separate method
  tools/net/ynl: Add support for encoding sub-messages
  tools/net/ynl: Encode default values for binary blobs
  tools/net/ynl: Combine struct decoding logic in ynl
  tools/net/ynl: Rename _fixed_header_size() to _struct_size()
  tools/net/ynl: Move formatted_string method out of NlAttr
  tools/net/ynl: Add support for nested structs
  doc/netlink: Describe nested structs in netlink raw docs
  tools/net/ynl: Add type info to struct members in generated docs
  doc/netlink/specs: Update the tc spec

 Documentation/netlink/netlink-raw.yaml        |   15 +-
 Documentation/netlink/specs/tc.yaml           | 2218 +++++++++++++++--
 .../userspace-api/netlink/netlink-raw.rst     |   42 +
 tools/net/ynl/cli.py                          |   22 +-
 tools/net/ynl/lib/nlspec.py                   |    2 +
 tools/net/ynl/lib/ynl.py                      |  200 +-
 tools/net/ynl/ynl-gen-rst.py                  |    9 +-
 7 files changed, 2271 insertions(+), 237 deletions(-)

-- 
2.42.0


