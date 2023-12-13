Return-Path: <netdev+bounces-56772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAE2810CB1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32FAB20BA1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E341EB34;
	Wed, 13 Dec 2023 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk+05/9i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18042A0
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:45:12 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35d77fb7d94so27022955ab.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702457110; x=1703061910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UbrNkZFw6v2Ag5z4UUkMK3ySGfIiAe6dvzGkwUXovY=;
        b=bk+05/9iYoZMhdFdXQ23z+vu4qADwVgRLEQk/blQGfwzAZZTlId8d/Ri9H23u9C7AT
         FURJf0zHyRj/ONpaf4m2Jq2zLGFYDXg/sGQ4mXhKqlr+BbBtzigzykrM+m7/MMBq1Y3p
         gEmXBnHDjLhzkie8SboLxoZMCpcJ348Zz1j/IHYBL17s+UnD5r7pu5vNnB5NMryUxhd1
         vMBb2t9OPHO7FGkFAv2XykpHLSuUfgvAPRqXAHSj305+vXS8vexYo99fuT/x3JI72jMK
         PB1WZNXuThI5mHnJLpt5kHPanpFgp/ZDSSk/OJ+TA10qVcGLniXwLnrSEtJQp8uItt6u
         CtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457110; x=1703061910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UbrNkZFw6v2Ag5z4UUkMK3ySGfIiAe6dvzGkwUXovY=;
        b=rkKWJPe6+K8qFE1vpo1iNmnW1tfhRPv64RANINVPP56VpK9yMQHiZsQqHMIgcW+3hT
         Gg5JWZSHwu44TJeDtdcrumdGjtJ5pfNWZAeMRDpzo5RvwPVHd/wrt4kNi3/FXGigEvEH
         R/TD91XsMyuwGMCkq//n1eC3sdMOpTiUmSxALD81JZXQ9U0vslfGhHUNmB1ehNMqwH1V
         +1htwLFoInOeMJruCBKZDyO35+64hLth+3vaIhoSrBe0mRuFKH1BBROMI/8Wwj+vLPcA
         p099WujmGw8JjP4/tQQg2M3d7mvQUhZhn8hSt4rcfEDxscyNtjaNQOiJb8pBcR3QvzNZ
         eztQ==
X-Gm-Message-State: AOJu0YxSeWezNT0jOa8l0Ys61pYI0fduUcuZNWujRXbEXFAN5Nf3XcjY
	Z2LmzVWxu27D1ImNSZx85SbaeyvQdovpVCmBD0g=
X-Google-Smtp-Source: AGHT+IEnaKQzZcT26KQrhmlJbsvfWvWyguGUjn17VcQVd2jU/WI1f1QoFDjd7eeQraE02SIdDKlLXQ==
X-Received: by 2002:a05:6e02:17c8:b0:35d:a84e:f720 with SMTP id z8-20020a056e0217c800b0035da84ef720mr13327799ilu.60.1702457110665;
        Wed, 13 Dec 2023 00:45:10 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f54200b001cfc67d46efsm9897824plf.191.2023.12.13.00.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 00:45:10 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [Draft PATCH net-next 0/3] add YAML spec for team
Date: Wed, 13 Dec 2023 16:44:59 +0800
Message-ID: <20231213084502.4042718-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

You suggested me to add yaml spec for bridge. Since I'm not familiar with
writing the spec file, I choose to convert team as a start.

There are still some questions I got during convertion.

1. Is there a preference to use "-" instead of "_" for the names in spec file?
   e.g. the attr-cnt-name in team.spec, should I use __team-attr-item-port-max
   or --team-attr-item-port-max, or __team_attr_item_port_max?
2. I saw ynl-gen-c.py deals with unterminated-ok. But this policy is not shown
   in the schemas. Is it a new feature that still working on?
3. Do we have to hard code the string max-len? Is there a way to use
   the name in definitions? e.g.
   name: name
   type: string
   checks:
     max-len: string-max-len
4. The doc will be generate to rst file in future, so there will not have
   other comments in the _nl.c or _nl.h files, right?
5. the genl_multicast_group is forced to use list. But the team use format
   like { .name = TEAM_GENL_CHANGE_EVENT_MC_GRP_NAME, }. Should we support
   this legacy format?
6. The _UAPI_LINUX_IF_TEAM_H_ is rename to _UAPI_LINUX_IF_TEAM_H in uapi
   header. Does that affects?
7. When build, I got error modpost: missing MODULE_LICENSE() in drivers/net/team/team_nl.o.
   Should we add the MODULE_LICENSE support in ynl-gen-c.py?
8. When build, I also got errors like
     ERROR: modpost: "team_nl_policy" [drivers/net/team/team.ko] undefined!
     ERROR: modpost: "team_nl_ops" [drivers/net/team/team.ko] undefined!
     ERROR: modpost: "team_nl_noop_doit" [drivers/net/team/team_nl.ko] undefined!
     ERROR: modpost: "team_nl_options_set_doit" [drivers/net/team/team_nl.ko] undefined!
     ERROR: modpost: "team_nl_options_get_doit" [drivers/net/team/team_nl.ko] undefined!
     ERROR: modpost: "team_nl_port_list_get_doit" [drivers/net/team/team_nl.ko] undefined!
     ERROR: modpost: "team_attr_option_nl_policy" [drivers/net/team/team.ko] undefined!
  Do you know why include "team_nl.h" doesn't help?

Thanks
Hangbin

Hangbin Liu (3):
  Documentation: netlink: add a YAML spec for team
  net: team: use policy generated by YAML spec
  uapi: team: use header file generated from YAML spec

 Documentation/netlink/specs/team.yaml | 205 ++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 drivers/net/team/Makefile             |   2 +-
 drivers/net/team/team.c               |  59 +-------
 drivers/net/team/team_nl.c            |  59 ++++++++
 drivers/net/team/team_nl.h            |  29 ++++
 include/uapi/linux/if_team.h          | 116 ++++++---------
 7 files changed, 345 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/netlink/specs/team.yaml
 create mode 100644 drivers/net/team/team_nl.c
 create mode 100644 drivers/net/team/team_nl.h

-- 
2.43.0


