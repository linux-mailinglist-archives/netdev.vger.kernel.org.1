Return-Path: <netdev+bounces-74780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A0D862C61
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 18:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E759E1C209BD
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E018637;
	Sun, 25 Feb 2024 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvxDbDpZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AB17C61
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708883190; cv=none; b=edPdl3KP/koFTl6TSESrzZLTiQ0CuczVKRKwFImPp02ZCAQgE01WaitAB1eEJvlB9qKblZYfn4rlWoj7aQsLdZRdz2SkmvijCXgT0qSlSUHDi4QJEWmEHumnsHz0ZeCIvzFFaZYKKu6gMso67xNpvf9JCEe5sHPLj+HAmi6kBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708883190; c=relaxed/simple;
	bh=cm7dWnab0UdQye4aGG46uKB07sXF9Kn+soxGYQmpQ68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEn0rOhscgsCcGL4IzPeEhtv5A70NKO2EvwiNPt8RaPHyQXLaeNoSk5l5/984tBJzQF6IbT6DkfpQGhUJWkEDaX9uZApvMKQyvmSp4Ai+MTmRYkD5PsJ0c5RbjfoDd7zwZ5gToE7LgcqcW3bqIUwLtPpOOuYhL4u3EBe63W/5i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvxDbDpZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d6bd39470so1256575f8f.3
        for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 09:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708883187; x=1709487987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7Q3sQdZvSnQiaDybkVkM394RMMDi5+MFZ55Ciz15wE=;
        b=VvxDbDpZu5h4NmkDwP3/Rg44WHvQNA1f9OKDXm28z4CH9Z2wdk3OY0/368MXNEXAub
         DdUi7s+IWo08G468LL9F5FdmnX5yZIq2gIa7aWlbXCxwAaPZTcajcubBz9lvjbwBPR1/
         peHUV7wKphTIp8T2BU9jpfuuIL79hh1HjwwOqn//6pc3bw4UjnsdpNHW6Bp3mGIfuuzg
         UmDfX0MJva9+15fCMUpTnZnUhxc8Ol/rrn54bPIfdLkyDtfM6sXNUGfDO5jfjNGeKpOz
         6S0X8NA4Kmc291hR5czV3IYTNnJoYINXmRFJoa4emdxprMcsgYUH4bmyLK/MOeWK6CLh
         gQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708883187; x=1709487987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7Q3sQdZvSnQiaDybkVkM394RMMDi5+MFZ55Ciz15wE=;
        b=CpnSGWcy7apyzhb+Jc+cE0cNqGQtf9/yvUvrawVd0sLJsouTL0SOdc1QHXIygBV43+
         x6e04x4Kf7H9Ipz/ounD2FUI5SEDPlTVkaI4xVwHZ1rYsXIMf1IJEDcL3twrdz0I9OKd
         jK7BD5AmslqwMu3UDqHbV6jJiEto2LYfgsUEqmIOff6r+ELv+EtdDmJd0BASCsx73yfR
         aUg7xpnwgi7fe+7+pbF22R6Qunl6lyJyOG7+GWFlPJd8LZ530/24sqaDSqkyt/UjruUb
         M7U/6qnjlyXLN+u5BLSYAHqF33C8gAvCngdwwL2/z1bwuw0eBJTski0zocXJKdxVx9zk
         Tl7A==
X-Gm-Message-State: AOJu0YwPVtG5znDEzUPhiVkjFmiWA47v7u9BYgYIinp4NrUEKB+JH3pA
	pzzx/p4QOTIo6hHaR+vfawtv/29OKsfyRzefDBgYeqWMCSOoh7ChI4moskDh7iA=
X-Google-Smtp-Source: AGHT+IHON1BCj6CBiidREzyIt1zmv+G/Uixkk0aNZ7I55fr/Hodt/qt4IpMplnnk3H12QL72iqxAiQ==
X-Received: by 2002:a5d:4741:0:b0:33d:63c0:3b7f with SMTP id o1-20020a5d4741000000b0033d63c03b7fmr3155802wrs.42.1708883186658;
        Sun, 25 Feb 2024 09:46:26 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:907c:51fb:7b4f:c84f])
        by smtp.gmail.com with ESMTPSA id r2-20020adff702000000b0033b60bad2fcsm5558729wrp.113.2024.02.25.09.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:46:25 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [RFC net-next 0/4] tools/net/ynl: Add batch operations for nftables
Date: Sun, 25 Feb 2024 17:46:15 +0000
Message-ID: <20240225174619.18990-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nftables netlink families use batch operations for create update and
delete operations. This is a first cut at extending the netlink-raw
schema so that operations can wrapped with begin-batch and end-batch
messages.

The begin/end messages themselves are defined as ordinary ops, but there
are new attributes that describe the op name and parameters for the
begin/end messages.

The section of yaml spec that defines the begin/end ops looks like this;
the newtable op is marked 'is-batch: true' so the message needs to be
wrapped with 'batch-begin(res-id: 10)' and batch-end(res-id: 10) messages:

operations:
  enum-model: directional
  begin-batch:                # Define how to begin a batch
    operation: batch-begin
    parameters:
      res-id: 10
  end-batch:                  # Define how to end a batch
    operation: batch-end
    parameters:
      res-id: 10
  list:
    -
      name: batch-begin
      doc: Start a batch of operations
      attribute-set: batch-attrs
      fixed-header: nfgenmsg
      do:
        request:
          value: 0x10
          attributes:
            - genid
        reply:
          value: 0x10
          attributes:
            - genid
    -
      name: batch-end
      doc: Finish a batch of operations
      attribute-set: batch-attrs
      fixed-header: nfgenmsg
      do:
        request:
          value: 0x11
          attributes:
            - genid
    -
      name: newtable
      doc: Create a new table.
      attribute-set: table-attrs
      fixed-header: nfgenmsg
      do:
        request:
          value: 0xa00
          is-batch: True      # This message must be in a batch
          attributes:
            - name

The code in ynl.py is sufficient to test the idea but I haven't extended
nlspec.py nor have I added any support for multiple messages to ynl.

This can be tested with e.g.:

./tools/net/ynl/cli.py --spec Documentation/netlink/specs/nftables.yaml \
     --do newtable --json '{"name": "table", "nfgen-family": 1}'

If the approach is acceptable, then I would do the following:

 - Extend nlspec.py to support the new schema properties.
 - Extend cli.py to include a --batch option, then only allow
   'is-batch' ops. Also fail 'is-batch' ops when --batch is not used.
 - Extend ynl to support a heterogeneous list of ops to be sent
   in a batch.
 - Update documentation.

I'm thinking that usage would be '--do <op> | --dump <op> | --batch' and
when '--batch' is used, the '--json' parameter would be a list of op /
param pairs like this:

[ { "newtable": { "name": "x", "nfgen-family": 1 },
  { "newchain": { "table": "x", "name": "y", "nfgen-family": 1 } ]

Alternatively, usage could be '--batch <ops>' where <ops> is the json
above.

Thoughts?

Donald Hunter (4):
  doc/netlink: Add batch op definitions to netlink-raw schema
  tools/net/ynl: Extract message encoding into _encode_message()
  tools/net/ynl: Add batch message encoding for nftables
  doc/netlink/specs: Add draft nftables spec

 Documentation/netlink/netlink-raw.yaml    |   21 +
 Documentation/netlink/specs/nftables.yaml | 1292 +++++++++++++++++++++
 tools/net/ynl/lib/ynl.py                  |   33 +-
 3 files changed, 1339 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/netlink/specs/nftables.yaml

-- 
2.42.0


