Return-Path: <netdev+bounces-73752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E876285E23B
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D33B25A79
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB8823A5;
	Wed, 21 Feb 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lSxBK/6e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C6823A7
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531115; cv=none; b=nFPWBfQfsSCv3u1UCe9W6WIsCgGsSg7IO/dS+oJS2WctbdRMUHLEv4lApwE7aYn8xDihk7lMY9u0OtUjAkzWuNoPVV1hMWIkG6oRDjdjAtJjfziGqFmv+YOpJspEAKNjJPyJ7MXqiy89bjzVHZRIfLNx5Y9fISdSmgWJyx03HHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531115; c=relaxed/simple;
	bh=pWhB/9g8CnlBlxQ4Kle145idANlWr2RhmhOKdwGONLo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=H/QxsMIUd/jFBEc4TGGSv0jFmvBsOp0JcsWXYXxzaO1XDKyZiFT6QSbyQfNqqIQCipdhvgz+zshneV89KbGeLQlQCZBVGFUybUKXN8pMQgjvyAMW5GabNbQqKjELjx1rYgAxYU4a28MARJsAGMi0+oOyBDEcoZjMgNBOuVgOHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lSxBK/6e; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e45bd5014dso1565522b3a.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 07:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1708531112; x=1709135912; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak7VbKSDllUoXEGnuzHtfjgftB0cmnm1/VIOdiVmP0s=;
        b=lSxBK/6ezXaqTjYAA57Z6SSYkeQ87fijqJG7wwsrr1hfGQgHwk9j6MfqRaGM0tFDL/
         koVqnO3pXr84FOx8JHuA5xP6pQRPK+YXj44ithDPeQUDiRirNvnW2A+kcX7FY3XQP6Ud
         h8dHtXsdfXJd5BFaQ7z1XA8Y8Faiw8zikLClI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708531112; x=1709135912;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak7VbKSDllUoXEGnuzHtfjgftB0cmnm1/VIOdiVmP0s=;
        b=X+5eBqwkPyIbvXuU+1J3jZsP6Pds9ziwWqblfPk0GUhWMGVWXqw1rQkowekyfAxIx0
         mZ4l1fkZWjtWV7BNH1nF7YS5wpsdLJnDe1zxcTzTzHPDd4mFp+cHCC2B3l9y5i6wvO9Q
         EtIJhhdHQaER9aOqSKc3Z3V0Gp+gOdVdT7JE7xnzak/OsabwjkoWqKkCN+BgW1oSm4On
         N7c2uyAd0o73tvk+bk1N5qmODlZFOR/ReIWPoIck/WKpD8xsU9UR94yWH8l42ZDpDzuH
         Eh6VRSaPxjyyJ9lCsI6yxASuKs/NRbIFdU6xnrN+9jzdA2cvyebIl8M92uKZin9KbDFl
         qzoQ==
X-Gm-Message-State: AOJu0Yz6LlclcPhArW8wBEd4sfdiRuqMIrAlr0FpmE+4GXmSzq/LmoGP
	T9+4ss0sBwhDexgxSW0paWzD5aS0tBGafdoHf9JsUerhS20QE+AQoM1NfU/gmyFaq7qLH27Os3Y
	X99+8nJeRGP65zRh4CLaVZaXjpeDa2GSFQUKZ9pz9xAwbLgjeorjsBZi2jq4S79SuKsWGz9T/jb
	6HRCbXw8XZUbjfY0h5+K3tcDGMuqnOFmpmd4AYFA==
X-Google-Smtp-Source: AGHT+IFWspkCZ1P2HbxMSfAYU2V9J1Ht1gvojwI7Vl7x2V0VqK21ZzagaOz9patq3QdJv+5jFG0Xtw==
X-Received: by 2002:aa7:8704:0:b0:6e2:e48b:43f2 with SMTP id b4-20020aa78704000000b006e2e48b43f2mr10940437pfo.20.1708531112482;
        Wed, 21 Feb 2024 07:58:32 -0800 (PST)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006e46672df97sm5751327pfb.75.2024.02.21.07.58.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:58:31 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 0/2] Expose netdev name in netdev netlink APIs
Date: Wed, 21 Feb 2024 07:57:28 -0800
Message-Id: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Greetings:

The netdev netlink APIs currently provide the ifindex of a device
associated with the NIC queue or NAPI when the netlink API is used. In
order for user applications to map this back to a human readable device
name, user applications must issue a subsequent ioctl (SIOCGIFNAME) in
order to map an ifindex back to a device name.

This patch set adds ifname to the API so that when queue or NAPI
information is retrieved, the human readable string is included. The netdev
netlink YAML spec has been updated to include this field, as well.

This saves the subsequent call to ioctl and makes the netlink information
more user friendly. Applications might use this information in conjunction
with SO_INCOMING_NAPI_ID to map NAPI IDs to specific NICs with application
specific configuration (e.g. NUMA zone and CPU layout information).

An example using the netlink cli tool before this change:

$ ./cli.py --spec netdev.yaml --dump queue-get --json='{"ifindex": 7}'
[{'id': 0, 'ifindex': 7, 'type': 'rx'},
 {'id': 1, 'ifindex': 7, 'type': 'rx'},
 {'id': 2, 'ifindex': 7, 'type': 'rx'},
...

$ ./cli.py --spec netdev.yaml --dump napi-get --json='{"ifindex": 7}'
[{'id': 448, 'ifindex': 7},
 {'id': 447, 'ifindex': 7},
 {'id': 446, 'ifindex': 7},
...

An example after this change:

$ ./cli.py --spec netdev.yaml --dump queue-get --json='{"ifindex": 7}'
[{'id': 0, 'ifindex': 7, 'ifname': 'eth1', 'type': 'rx'},
 {'id': 1, 'ifindex': 7, 'ifname': 'eth1', 'type': 'rx'},
 {'id': 2, 'ifindex': 7, 'ifname': 'eth1', 'type': 'rx'},
 ...

$ ./cli.py --spec netdev.yaml --dump napi-get --json='{"ifindex": 7}'
[{'id': 448, 'ifindex': 7, 'ifname': 'eth1'},
 {'id': 447, 'ifindex': 7, 'ifname': 'eth1'},
 {'id': 446, 'ifindex': 7, 'ifname': 'eth1'},
 ...

Thanks,
Joe

Joe Damato (2):
  netdev-genl: Add ifname for queue and NAPI APIs
  netdev-genl: spec: Add ifname to netdev nl YAML spec

 Documentation/netlink/specs/netdev.yaml | 10 ++++++++++
 include/uapi/linux/netdev.h             |  2 ++
 net/core/netdev-genl.c                  | 22 +++++++++++++++++-----
 tools/include/uapi/linux/netdev.h       |  2 ++
 4 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.7.4


