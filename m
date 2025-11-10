Return-Path: <netdev+bounces-237137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4438EC45CE3
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 971B24ED78C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107EB3016E1;
	Mon, 10 Nov 2025 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh8nB5D+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804A2FC011
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768813; cv=none; b=qx/d0nz3Aaf2a5cn0oSk+9wqZjdgZYR9Ofyb3iUSaXG6JF0SQ0OShvYyolVb1WEnpohYOlzObcKahabcUl6xuoNd3rP+Yw1Sjd/vaY9PP4+IbL7Y09aeu5Sg5ulY9qOjpm1ftnZYUMFIomLLWKADfIBAjyi0zHGQnVVRzfxyFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768813; c=relaxed/simple;
	bh=d215PWFM8qxXYKt/8lkU5pN3d3EhestbeEvDkMog5Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r15wpP0QODgMt/Bf8jvPq7b6ESo3YYSpyHxGKFCEm5eozztwZuIYFrGcQtfKv5jdhLohZ+HJVAqTQ0NivOm9Q37eaXLicSFuRJMq98ZbW+13/GJmRtfxG3K4mq14GTMllh/toR8eYniOKcGyZZzbNy02XAvJ5AmEFyRWuD8+7hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh8nB5D+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-343514c7854so2541172a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 02:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762768810; x=1763373610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AmgR+u0TEkpWFrCZSKVrnRAx+y2xDke12OZ7RxuA0bM=;
        b=Dh8nB5D+4/3z4HAHMbyGPwiONDu1n9+aQRbrFjeygxwvGdfmPaJR1xQoSVekuRK9sI
         Ap5PX4/jqJNkkX/wFYxRSOKz4Al4YdlTEsYJwbaP2SvfZvOMr8NV5aIgdIFpG5Z+uc4z
         8jCpipxF3bBPeIfo0jdxIU+L3UdLjU+eSH5RNadX2VyiyNLkPIE0YhESqKIEkdo+pMz6
         DaV5uJs8PiFYR5OlGwG6ZeAauSotEVlvdf3EQaki76SEyoB21DUuDznVpbY7vP+LH3l+
         75LOkQUhrPCKwXwO1EAU0VOq6FPbZegUpjEm6DZyessqBfsAilKjcpEpCpTqJe6nd56a
         d5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768810; x=1763373610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmgR+u0TEkpWFrCZSKVrnRAx+y2xDke12OZ7RxuA0bM=;
        b=tXzMNalbN8LpIPDIc6s00Uhn2AI9VIZgK6eHpnj2oNcaEMwsiKWnDDh1pbt6FvKE6F
         tnQxmtY5Rj0h228OBXDOC/IhnRIYEXOkkLJRIBlTFqNRVx+9KLXhLxQndQ8VlqAZACHY
         zJ1NgyA1jnJdbPoJvZ9NetKsXyQ4brBkeC8/QpMXXQQphQBDI1gVAEHK/9En3aZDqb2e
         dCPeNR1Wd+5QfvuAQrqV6aNT7qyXF1UPMdvXI1NBMrR8V3tsr81o3K8UKvb9zSImObxR
         K+okPwRH3cObnG8ZU4AwxpXVzBrxe4zJsvWx5MV+YVmXv0lD+fTG6QTTUK+2A3uMTsBY
         MwDw==
X-Gm-Message-State: AOJu0YxKm0soOZbIaIBK6v60vduph32NegIT5NdgbcVrN+J+4xxnVsnf
	QPlOn2aSu058EviRedL/dScgUaSZlXccYFs6/9QVHlZFtUiEvKEGi9taMFdIFQmk
X-Gm-Gg: ASbGnctH/I9N29qb3TM2Ofd1mT21JeEM9Nbp4cUYjbSSa3W3NyoRAUx6glJg7wieHXj
	NQ57HDA2vZ8rk/3NpbvnMmbYCUg4JXBd8xiEaY+sG+0u0kgZH9090kQpgp9NzTdfV3cKPlZKclP
	IFjFoRGcFA5NCx9pKp/iN/6Xjh7PABn+BtDpe6VRWsDl/LVnV3USuCpaj0Y3sCAFx+HAyLXqJBO
	JWBbg+osa7BEVszI67FQMur9hDFMtRKGek2evQ/NWGVLMTBkTrsD65962bjwPZdq3/CIUbHrbt0
	YtShoJzQDgl3accmnp6CpVfk3qSdj5O/1Ran6bG2gSsvxwB9zjiLm8d3FLe06zmpwLDLu/JUlkL
	tcvOJqizgxjUkwtrfugUqv7O3MnNj/+rIY8mJFau3miZz1lrRzHAMzxwLR3enfunDTQO6/ogcs2
	AdIif7
X-Google-Smtp-Source: AGHT+IHpquhlLWaTSSNaMualbmYu1zLOSUlB5NFBkn99F7VHkJSDvZz5XO8ivlQfBuEqvnJB+EPNXw==
X-Received: by 2002:a17:90b:2e46:b0:343:89cc:6f23 with SMTP id 98e67ed59e1d1-34389cc7a96mr5317299a91.14.1762768810423;
        Mon, 10 Nov 2025 02:00:10 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm10374405a91.13.2025.11.10.02.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:00:09 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 0/3] Add YNL test framework and library improvements
Date: Mon, 10 Nov 2025 09:59:57 +0000
Message-ID: <20251110100000.3837-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enhances YNL tools with some functionalities and adds
YNL test framework.

Changes include:
- Add MAC address parsing support in YNL library
- Support ipv4-or-v6 display hint for dual-stack fields
- Add tests covering CLI and ethtool functionality

The tests provide usage examples and regression testing for YNL tools.
  # make run_tests
  make[1]: Entering directory '/home/net/tools/net/ynl/tests'
  Running YNL tests...
  Running test_ynl_cli.sh...
  PASS: YNL CLI list families
  PASS: YNL CLI netdev operations
  PASS: YNL CLI ethtool operations
  PASS: YNL CLI rt-route operations
  PASS: YNL CLI rt-addr operations
  PASS: YNL CLI rt-link operations
  PASS: YNL CLI rt-neigh operations
  PASS: YNL CLI rt-rule operations
  PASS: YNL CLI nlctrl getfamily
  Running test_ynl_ethtool.sh...
  PASS: YNL ethtool device info
  PASS: YNL ethtool statistics
  PASS: YNL ethtool ring parameters (show/set)
  PASS: YNL ethtool coalesce parameters (show/set)
  PASS: YNL ethtool pause parameters (show/set)
  PASS: YNL ethtool features info (show/set)
  PASS: YNL ethtool channels info (show/set)
  PASS: YNL ethtool time stamping
  All tests passed!
  make[1]: Leaving directory '/home/net/tools/net/ynl/tests'

v3: add `make run_tests` to run all the tests at a time (Jakub Kicinski)
    use ipv4-or-v6 display hint for dual-stack fields (Jakub Kicinski)
    check sysfs in case of netdevsim buildin (Sabrina Dubroca)
v2: move test from selftest to ynl folder (Jakub Kicinski)
    Link: https://lore.kernel.org/netdev/20251105082841.165212-1-liuhangbin@gmail.com
v1: Link: https://lore.kernel.org/netdev/20251029082245.128675-1-liuhangbin@gmail.com

Hangbin Liu (3):
  tools: ynl: Add MAC address parsing support
  netlink: specs: support ipv4-or-v6 for dual-stack fields
  tools: ynl: add YNL test framework

 Documentation/netlink/genetlink-c.yaml    |   2 +-
 Documentation/netlink/genetlink.yaml      |   2 +-
 Documentation/netlink/netlink-raw.yaml    |   2 +-
 Documentation/netlink/specs/rt-addr.yaml  |   6 +-
 Documentation/netlink/specs/rt-link.yaml  |  16 +-
 Documentation/netlink/specs/rt-neigh.yaml |   2 +-
 Documentation/netlink/specs/rt-route.yaml |   8 +-
 Documentation/netlink/specs/rt-rule.yaml  |   6 +-
 tools/net/ynl/Makefile                    |   8 +-
 tools/net/ynl/pyynl/lib/ynl.py            |   9 +
 tools/net/ynl/tests/Makefile              |  38 +++
 tools/net/ynl/tests/config                |   6 +
 tools/net/ynl/tests/test_ynl_cli.sh       | 291 ++++++++++++++++++++++
 tools/net/ynl/tests/test_ynl_ethtool.sh   | 196 +++++++++++++++
 14 files changed, 569 insertions(+), 23 deletions(-)
 create mode 100644 tools/net/ynl/tests/Makefile
 create mode 100644 tools/net/ynl/tests/config
 create mode 100755 tools/net/ynl/tests/test_ynl_cli.sh
 create mode 100755 tools/net/ynl/tests/test_ynl_ethtool.sh

-- 
2.50.1


