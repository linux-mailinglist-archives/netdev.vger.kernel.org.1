Return-Path: <netdev+bounces-181893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892F9A86CDE
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 14:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5978F46028A
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 12:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2341BD9E3;
	Sat, 12 Apr 2025 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaocKa5h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572FA1519BA;
	Sat, 12 Apr 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460676; cv=none; b=gyZseV57LgRqlxxVS0XskpBW05mLU5ok/cqkWrDoXfiWo91LJ6tcVGBoV1W1qedxyEbyb3GtSfYZWXlSBUX9074g7RnbnGs2fiZuPCJUsVex0KDYgmEtXSgzI/CoNXgpgcoFOlxctOZOW/ChlWlUUrzIujBmj8CRrsQ1hCfSuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460676; c=relaxed/simple;
	bh=J80O7lx+S9pEIU6bV6NeFN2f6XCVqGZw2Hw8t5NoRHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ScjHWKJ4A9b9FDtY2lGhxlmYfu88lTjPDWHfMIMXnja+phjksikNVVKApXOSZ1b1Xq8b3+8DodhwL/u2s1xorIggGxk1bpXFmgpnr/YaJwTeDY/RCEcgxx8SP8YBDcTTGeWspcj7rkaeSMfT8Mzl3tB615SzM8bMpvuIsiHFilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaocKa5h; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so4534741a12.1;
        Sat, 12 Apr 2025 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744460673; x=1745065473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVuqSu3NOK87RkcbSVOR8gLBwOzmPgPAFU9FS4oYFp4=;
        b=jaocKa5hMxDYZyIc08OZZCJPKFTkUegZufrmHZp2BfEX40OsgLfqt0ZVjKnHDmMhVo
         j1A8Bnj1Bv0JeJK6qobMgItFQEe2PC+fp656cx3cLMISMZzQM+pSsr2KJSbrEVPC3ztw
         4nmiqJF/CQwxKAOdyMUF/O4BkWkTHIvZsJxVF3hkc0Otf2TyMc+vgprD12csa0Gr628s
         Lo8zHrXw6rHHXXi3jHWNXs3nyJWk2R2KMnKTIX/ucV193BpjqUo4joAbaXNE7ZYxCHIs
         YwYkNxirKIDYJj5wAKTHrOM1ugpF3WcFS3DiZiDkWyTEbkbLvfIANr4SekTgzDgFsL9g
         MAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460673; x=1745065473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVuqSu3NOK87RkcbSVOR8gLBwOzmPgPAFU9FS4oYFp4=;
        b=QJgEfLBZKdIxTPMVq+bnXbC9qpb1nzUpbJfR9ncjOGWh1jMMGDkfLHBGeXxGkfAdgk
         Zi4Y7Qe9FBc4HghB1YNseUFA4qxzU9EWk8zo85eKS7Qdt4iBGX9yGpHn3ECkRELet6T6
         33rCrUcRAjCc13YMVGb6PZACupbHwF3AeoBOxaRBZl6oOFIziFpIJ+CT+kb9WHNquueb
         uLkNr+D5wFIjm43DsW/p5ZYKMtM6S4wWzM6HNJHJf/dhiI1aG9pOew3E43ntm/TtsF3s
         nExyIAovCbirbhP75o0NAoM6uDX+tXscvctxRpeE4x+5cTVXoktomod5eQ/DlEYwAt6d
         5gew==
X-Forwarded-Encrypted: i=1; AJvYcCU8DL6JMnmVMrM2EFUOcoGQsII2tAcqvUj00ZHKVtl/NIaaQGf2RKmqVF5A62sB+EB0CFkO0O+4@vger.kernel.org, AJvYcCVPeMG8NDQWx5Ato2TD+rHhCkeU1K8w6QJIh1daBsexodVlmaP2uxkJpiHa+/P8QofUkbunyAcNg9LGFb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYL0Kdh9Yyn9BLLmbzD/fogz8do2KOVh3hONfxHV37i9GIn/y
	aJ8AIjl5I4RXHMPcGwFWXIVin0zwXMJyKCt+Zh4Oe174v2aqzrLI
X-Gm-Gg: ASbGncvvieZOL8MtRo9BdilIdRhbtOel8TS9l3Qum5/rDnIQ0YTWvUVyZi/BZefSNS5
	oJtiEMhbd57RI7TqNadIZpSZKQPEDw4rfhfYz6hpAOIzhliLbD7btY22Kzy6bm7EfxqbQdQ7Ytr
	a8ptyzpATngYdlUT0OKpBwKQGph/iaKCzSSCGjlNLXjOGHrhL1xjL5Oy1YktAB4Ot2Y9yrUhufg
	/6MuwN2kK2lpfkiH+T48ya7omG/84U9S7dAGFbodvz6+R+VB4OCfIaOQzAXoN4rpH+ll0PkrTFw
	32WC7QWDEJmXvRgMq/Fg3LJfup0KkZDmlNxFJk95Z5CO7hxuRc1PyZLz63h2x/2UQu0yYEpKZYQ
	H5sPUAZ0QXoNXzCq07e1q
X-Google-Smtp-Source: AGHT+IFc5anELwtiJCusv+yFZK/tdXxvnsuy47DJan7xHGiTN/SrWnZQYj+SMt5guZE4sgjUUqlcjg==
X-Received: by 2002:a17:907:3f16:b0:aca:c7e0:6375 with SMTP id a640c23a62f3a-acad3456e7fmr561981366b.2.1744460672462;
        Sat, 12 Apr 2025 05:24:32 -0700 (PDT)
Received: from localhost (dslb-002-205-021-146.002.205.pools.vodafone-ip.de. [2.205.21.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be91a3sm588742766b.44.2025.04.12.05.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:24:31 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net 0/2] net: dsa: fix handling brentry vlans with flags
Date: Sat, 12 Apr 2025 14:24:26 +0200
Message-ID: <20250412122428.108029-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While trying to figure out the hardware behavior of a DSA supported
switch chip and printing various internal vlan state changes, I noticed
that some flows never triggered adding the cpu port to vlans, preventing
it from receiving any of the VLANs traffic.

E.g. the following sequence would cause the cpu port not being member of
the vlan, despite the bridge vlan output looking correct:

$ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
$ ip link set lan1 master swbridge
$ bridge vlan add dev lan1 vid 1 pvid untagged
$ bridge vlan add dev swbridge vid 1 pvid untagged self

Adding more printk debugging, I traced it br_vlan_add_existing() setting
changed to true (since the vlan "gained" the pvid untagged flags), and
then the dsa code ignoring the vlan notification, since it is a vlan for
the cpu port that is updated.

Then I noticed that deleting that vlan didn't work either:

$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 PVID Egress Untagged
$ bridge vlan del dev swbridge vid 1 self
$ bridge vlan
port              vlan-id
lan1              1 PVID Egress Untagged
swbridge          1 Egress Untagged

which is caused by the same issue, because from the dsa standpoint I am
now trying to delete a non-existing vlan.

After fixing that, both were now correctly working, but the configured
vlan on the cpu port would be stuck with whatever the initial add set.

E.g.:
$ bridge vlan add dev swbridge vid 1 pvid untagged self
$ bridge vlan add dev swbridge vid 1 self

would change the flags in the vlandb, but the hardware configured vlan
would still untag at egress to the cpu port.

Patch two fixes this by allowing changed = true vlan add notifications
for the cpu port, but skip the refcounting. Presumably with the patch
there should never be a vlan add notification for the brentry with
changed set to true anymore.

In case my reasoning is wrong, I added a WARN_ON(), but I didn't get to
trigger it so far.

I did a check of all handlers of switchdev port vlan add notifications,
but DSA seems to be the only one that even looks at the changed flag.

Sent as RFC as I am not too familiar with the dsa/vlan code, so I might
very well have overlooked something.

Jonas Gorski (2):
  net: bridge: switchdev: do not notify new brentries as changed
  net: dsa: propagate brentry flag changes

 net/bridge/br_vlan.c |  4 +++-
 net/dsa/switch.c     | 22 ++++++++++++----------
 2 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.43.0


