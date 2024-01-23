Return-Path: <netdev+bounces-65102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD20883942E
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBB41C20C17
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35124612EB;
	Tue, 23 Jan 2024 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDZnVfJo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE45A110;
	Tue, 23 Jan 2024 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025948; cv=none; b=pQVpuVlVoW1AeL0L+mBFARHGZimgseAGD+R8CxBkFTwtQeIlgVSMWrymtkln5Je67Qe8fCZrSvLc3KXA1aohAh/JyG5PVbXZnT2V+eHaPIr7xYX0SshCERKRjFcUULvrKiWR1yD1uep9QVRk08C8GClBfkibSvqfQrJym6GuYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025948; c=relaxed/simple;
	bh=EqwuZoW8ZN+QzaeM3/ZJRHEDInLVBlC2rbl+crDOliI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpeCzP9wE3aNiDvCmVQsJqgANbg36FAWoZb7xHfHX/lZVE2iL7yg/CZi41Z0zy2NYE83iUQnGmbpdjZPsFq0DBBP6FxyZx67jYXBYaQVMLnJdHYE3YS/T7GLP5G4r/OGMWG3AAIY268huMH2ET6/cFI9BEiEt7pd7wD/em5VTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDZnVfJo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ec3535225so2081635e9.2;
        Tue, 23 Jan 2024 08:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025943; x=1706630743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmYT9Ec7jUi8wFLVKDFE7/uYZ6ywsX/UTzcSASaEzGM=;
        b=UDZnVfJo3eNH2mniKvg/wAYbmQ1BwErhKP0t4TZ1brU6uaObaDwMDvM4pvZsvA9mF2
         75gXUNYksKypfiZ94ESqGKvPc6rtPDNIcHUYuUIZWC6VF4M5SqGdY4DHz/o9bVG/LZtc
         dApbV57gwO+oARYfNVDoTVDCmjSzLivE3BFPzIY8tXiR/Sk9VqJitdDtf+xZ4kKLtate
         mCHySpxHOxEjx7p+NvinQgB/ndkKH8KNBfYh8ByCnFMvAeytoXGg5lpkc7cmIku1a7g5
         DDzZI6V1xT4fYaN6WSwl0H8mBK+918Zw0B43NamzCHA2y00STxlR+VyixnJXkyHfGDgt
         UUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025943; x=1706630743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmYT9Ec7jUi8wFLVKDFE7/uYZ6ywsX/UTzcSASaEzGM=;
        b=Xvi1oDwqebTBIrXEKM4y05VoLhSbdRTvxFN1ABWKesSN705iy7qzT1nW+2yaeMpfzi
         Ln2PiW/5gFakg+Q7R7KBrZGYgIEvaRrg0Gl2uxyDXfZZOtBXML+21kinyZ9cZ5oUTEx5
         xLIttgecFrZRO/NuaC5GVda7A52LJuw/pZ7Nh5Fat+dBpWiI0ibt5J2fhCAgjl5wPIXj
         WjilfgzPOH2f0wjE2A9j24UfLc8eonlgkjuVHyuvSfTqWbXCyQcV/HrHkeG8+YPHPdif
         E9R4+NMCqLcDbf6WHYO7yR4oNxAylB/05lEujtz9iAQtQZVNqpaK5O7AOkGs4K+d53+u
         P+VQ==
X-Gm-Message-State: AOJu0YybW5PLrwyxQtcE4/NCVdgG4OocuXbYCBoh9ro4l5iOsLj6NB+X
	2WyLXVXOka+Qqhe91pUZQxdPG/oPBfyRuOZYAFO8qGoC3hSlGVj3ReciSVMWYdGMF8Eg
X-Google-Smtp-Source: AGHT+IFCDfPC4AtMMFuP94bRzW6EAdWmT2fryuxb44W8L1z4Vwf8kSI/CgHpQF+3JmiLWSByzsc+KA==
X-Received: by 2002:a05:600c:470b:b0:40d:3be1:daaf with SMTP id v11-20020a05600c470b00b0040d3be1daafmr329421wmo.51.1706025943102;
        Tue, 23 Jan 2024 08:05:43 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:05:42 -0800 (PST)
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
Subject: [PATCH net-next v1 00/12] tools/net/ynl: Add features for tc family
Date: Tue, 23 Jan 2024 16:05:26 +0000
Message-ID: <20240123160538.172-1-donald.hunter@gmail.com>
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
Patch 2 adds support for sub-messages in nested attribute spaces that
reference keys from a parent space.
Patches 3 and 6-8 refactor ynl in support of nested struct definitions
Patch 4 implements sub-message encoding for write ops.
Patch 5 adds logic to set default zero values for binary blobs
Patches 9, 10 adds support and docs for nested struct definitions
Patch 11 updates the ynl doc generator to include type information for
struct members.
Patch 12 updates the tc spec - still a work in progress but more complete

Donald Hunter (12):
  tools/net/ynl: Add --output-json arg to ynl cli
  tools/net/ynl: Support sub-messages in nested attribute spaces
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
 .../userspace-api/netlink/netlink-raw.rst     |   34 +
 tools/net/ynl/cli.py                          |   22 +-
 tools/net/ynl/lib/nlspec.py                   |    2 +
 tools/net/ynl/lib/ynl.py                      |  174 +-
 tools/net/ynl/ynl-gen-rst.py                  |   10 +-
 7 files changed, 2241 insertions(+), 234 deletions(-)

-- 
2.42.0


