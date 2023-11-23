Return-Path: <netdev+bounces-50531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F737F60A9
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA02281DE7
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E5C25759;
	Thu, 23 Nov 2023 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZXGYR28"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AF5BA
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:05 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5bd099e3d3cso565942a12.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700747164; x=1701351964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LYbdF6V8Di/aqFyRAw2jfZamXJxCaSiyAQg2O0xOzB4=;
        b=lZXGYR281abqbfcdBLdUinlsMUgo72W/1lv7ik///cWCqO4yx5azSqKWUHJK2w+Eeb
         n/mcz8KMZpL9YL/biZzpjmTj3EijdY87SP14XHW3x8hfg0dng8sJjfL7C/E4prDGrBin
         f2vah41n/rEeEysITwQBGDPT6O7cUHHe4d4yHydsua6C364Eh1naeCqAtRxPleH1S9hr
         5kSf/GaFIrXU6bxmCJVjX7a+FvjvK0bju4nf8prpLBcclSyIc8zrBe3BUnBqPECOIo0w
         ka78DjRGupRk6jirrlcBVBRreCpHsxpPEt9Jkl38PdHboeY0of7TkgivoQw9jQJEp7Jl
         2lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747164; x=1701351964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYbdF6V8Di/aqFyRAw2jfZamXJxCaSiyAQg2O0xOzB4=;
        b=Qh8XmRHDOHaZ4MFp/M8bn5DPpQsF8XuWB+pp6MooAFGIXzPT7Mn5i4FkInMZpyAMgy
         VJWZgAkfDMGfSIeI0e0osbeVaEWyBgk8kbXVLdmgsGhl9Wbk9sUZYBIiiG1KMtfh5htE
         mfk0peu6IZVtkBP/aVhVCMHixWY10d4/ccEXLe+Uy9HauGlfzREdYp59aHZyI1hEsggt
         URJ+71Hk1b5ChzY3nWpZqss3/WzIkFFT5JW3pUsvu9yJDhfMi38A+Ubc0PA6fZqgPWFm
         zLyXymPor0FxLVudblVXfQsixZErAir95/dSiC4VZVuYhp2YLk6lL1Ub6FFr7UKT21Qr
         U/Mg==
X-Gm-Message-State: AOJu0Ywcyfn7ongyx5Q0ISvDWyHoSowDCR1L7mOACCz1XFtLmON6s3mK
	P4PS24XbSHPE0h/XrJW//PHTNuscgjBPimwI
X-Google-Smtp-Source: AGHT+IFZTxaO3xwpBBbIxdhJU9NM63sljMjgNMAfqnhOsq7Y5nnpc6zeQi3G/J+eBAU2zM/OiWriQQ==
X-Received: by 2002:a17:90a:1a03:b0:280:1d6c:a6a8 with SMTP id 3-20020a17090a1a0300b002801d6ca6a8mr5687963pjk.23.1700747164453;
        Thu, 23 Nov 2023 05:46:04 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0028328057c67sm1414210pjh.45.2023.11.23.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:46:03 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Marc Muehlfeld <mmuehlfe@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 00/10] Doc: update bridge doc
Date: Thu, 23 Nov 2023 21:45:43 +0800
Message-ID: <20231123134553.3394290-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current bridge kernel doc is too old. It only pointed to the
linuxfoundation wiki page which lacks of the new features.

Here let's start the new bridge document and put all the bridge info
so new developers and users could catch up the last bridge status soon.

Something I'd like to do in the future:
  - add iproute2 cmd examples for each feature

v1 -> v2:
- Update bridge and bridge port enum descriptions (Vladimir Oltean)

RFCv3 -> v1:
- Fix up various typos, grammar and technical issues (Nikolay Aleksandrov)

RFCv2 -> RFCv3:
- Update netfilter part (Florian Westphal)
- Break the one large patch in to multiparts for easy reviewing. Please tell
  me if I break it too much.. (Nikolay Aleksandrov)
- Update the description of each enum and doc (Nikolay Aleksandrov)
- Add more descriptions for STP/Multicast/VLAN.

RFCv1 -> RFCv2:
- Drop the python tool that generate iproute man page from kernel doc

Hangbin Liu (10):
  net: bridge: add document for IFLA_BR enum
  net: bridge: add document for IFLA_BRPORT enum
  net: bridge: add document for bridge sysfs attribute
  docs: bridge: Add kAPI/uAPI fields
  docs: bridge: add STP doc
  docs: bridge: add VLAN doc
  docs: bridge: add multicast doc
  docs: bridge: add switchdev doc
  docs: bridge: add netfilter doc
  docs: bridge: add other features

 Documentation/networking/bridge.rst | 321 ++++++++++++++++-
 include/uapi/linux/if_link.h        | 520 ++++++++++++++++++++++++++++
 net/bridge/br_private.h             |   2 +
 net/bridge/br_sysfs_br.c            |  93 +++++
 4 files changed, 926 insertions(+), 10 deletions(-)

-- 
2.41.0


