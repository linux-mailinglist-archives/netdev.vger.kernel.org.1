Return-Path: <netdev+bounces-48590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A706B7EEEAA
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35178B209AE
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44B12E6F;
	Fri, 17 Nov 2023 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTOPc1Ia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8665198D
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:31:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2806cbd43b8so1386770a91.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700213512; x=1700818312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REL/gDqjVuJc56ZdXAkRKIRlX5LJbYNpucbCBTKeb8E=;
        b=JTOPc1IaOl9Cb9AlP8Rd+OG7GkhQ6n7lx1qq6VA7YLTf7FDAz7ue8GGMH7dAp3f4Xx
         N3BpAP2GUbIyUW0VtVDcGnr5kgWQRsekH3aJnurmCiCgWKilXWqxG/07Rl5AcS2NuKBv
         UReWfo4UgyOFIH6judoMlmU6BZaVIDA9M9vyiEkl2Nut66Q35sU9hGV5RzhiDmu/r/ra
         c7vZu/4ee8mPWDTzyFYeEQ1AL2/LECkxT7SIZCrxOEYiiAAeHK6kXEA/eTkZ+NMwR22h
         1/ZCrOaajYNktV4eJlVMYjKgM3/TwrbX50otFfhnCKyNLoEWHCMYBkdXNlUW42fZ06ZH
         Op8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213512; x=1700818312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REL/gDqjVuJc56ZdXAkRKIRlX5LJbYNpucbCBTKeb8E=;
        b=fSdyqr5aDYS/hsNSoBYDL6hDtp2Fpw6zOJo7a+ynoeByH/li8nbSv7zUGzsU2Fw3yz
         5UDwRLx0i2Xv7yvVI34QsvhR7wD7/2vwddFRZiWw9UxOl5vBgfZ/E6aRr+M4fhvkIUBx
         ivcPjuqG8BhFJt8rjoHQPQsHB1TaIBYu73ghP1VdLQVdWqtonLnPVNEA2yAYLk9ypd/J
         zFydlC0yOCGIMxVtDWLBJcAlYPXwI85q371a405gTNHHasq3KL/A9I1YCg/0lCC1znKw
         ZotGu+n/HjYXWVeICO2oacU2lCdhuCK0iRtFFvIH7qbKRR/LaI6a+oA8cLfoYgvgtyeS
         pJog==
X-Gm-Message-State: AOJu0Yyf7shuApgbmsVZfQPPsP1GQ/3WoJ8NwJrVYVHm+r+Sira1Q8zj
	EP37fnWPd4IO8ZQeoY3Y3XkhPQkni3Ln6i2s
X-Google-Smtp-Source: AGHT+IHcXoJ3Xzr7ufZDbthnkuIHjBCY0/yXGFW7eUzyMBAW+OiLhY2P9R5m6xY6pxqgRBlVz/O2Gw==
X-Received: by 2002:a17:90b:4a0f:b0:280:18bd:ffe7 with SMTP id kk15-20020a17090b4a0f00b0028018bdffe7mr16872343pjb.48.1700213512393;
        Fri, 17 Nov 2023 01:31:52 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090adf8900b0027ceac90684sm964060pjv.18.2023.11.17.01.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:31:51 -0800 (PST)
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
Subject: [PATCH net-next 00/10] Doc: update bridge doc
Date: Fri, 17 Nov 2023 17:31:35 +0800
Message-ID: <20231117093145.1563511-1-liuhangbin@gmail.com>
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

 Documentation/networking/bridge.rst | 321 +++++++++++++++++-
 include/uapi/linux/if_link.h        | 500 ++++++++++++++++++++++++++++
 net/bridge/br_private.h             |   2 +
 net/bridge/br_sysfs_br.c            |  93 ++++++
 4 files changed, 906 insertions(+), 10 deletions(-)

-- 
2.41.0


