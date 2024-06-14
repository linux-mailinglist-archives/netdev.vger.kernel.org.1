Return-Path: <netdev+bounces-103611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EEE908C98
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C314289E9F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CED63B;
	Fri, 14 Jun 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="DcfWHQfQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2917D2
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372338; cv=none; b=WOdln6c2BmG1227+nZJdMCVetzTCQPYvH5B9S90BDTsP3y/ligBc4IXCqDW9NRBPRqXo+RFgPV3C1DKGj6TflnbprGOU3KuSazH0mqMgsB02nUcoCqF0ip7sgIo1E6Znom1yw8ADOpUKD1PctE/9cMu4k5/OTuDO9ZjUSgUrKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372338; c=relaxed/simple;
	bh=kH0PH5dt6QFFMaRGWcSqUqKFXV8YoUOdEQXipOcZGtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OoXDKKYd2KnD2gSczlNR2cjIalfoLZKYBKsKRHSE/vO4PBsR5UjIyglFarFKB6Ah2clnwJr7/rkIPz+nS5JIHF78re1iImEuiUj0zw5uS/JXYmtqvsAxL5AaQixe5SRiVqhUIjvBdNa4KfxIiqT/r7yDTTuuugtDm/0p62aOZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=DcfWHQfQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso19876181fa.0
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1718372334; x=1718977134; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9/Bo6xuQ8/icZdSZ4QUImSbd69qs1xMMxhNgtWPWwg=;
        b=DcfWHQfQ6uIJRX4H5RjIamwud43VVM4ty0JiTW7Tkj0+YD0BgKE9cqsJU/grX/fuGo
         8AAJ+kksUEq5xx3w3vR0fDt1LPjAjmjIVFySvIvNDLglAI60mWbmlUUH8X8BURRcVM15
         qOnYwbD21eV5zGwYXRB4NDyFRmL5L7m9THvMepfdwXcqETIL2iGkX5g1RhuC9fBd5aSa
         ODe4V6BNYkCdPpH0/Od9BuhWTdZxvBAAVAHZQJ0+VQC62utOTJdON638SpHorbfRDzTu
         xFeuAJQt5yPJ8AgcBbpgkvtyRQlD6KptFQUvlLD9ikD6K1E7es/2C6Lba4SOY5Lh5WJG
         9kCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718372334; x=1718977134;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9/Bo6xuQ8/icZdSZ4QUImSbd69qs1xMMxhNgtWPWwg=;
        b=ER3+AhSJ+xCi/2AQ3upj2YhstBIeBuWbaXlYb8sOXk1g/lxmzsrBj3sb/AzsTrrbQ0
         y9rVcOsDQiukmGoG6zJLptSYVQQ/E5G+CVEJ0DN94hZD5USnkJnoT1fCWEdr5iP9I6iQ
         sQBMocWtEP5SbezVa/H46k9y9bZhYVuidNUTSTEKNwUscSjRIpOqsxPlgqhTDP9RhYoK
         iF4eRcEdDo7xgJ5v/AgSOoQliRVw2K9INQYUTWI8Z6TsXElsb1Ln7NDAyjJ30Y63+rQh
         MP5B4QYdtDA70d3pgsj1lTQLgUX2eLl1AnirykD0geLylu5ojBrx6/NGZ/RdwKrJFY8X
         4oOg==
X-Forwarded-Encrypted: i=1; AJvYcCWycqkC25TNPNdLJUG95SsGTd2RR8A1V9mzvmdpH6jAOQPrZnldA2IvIpexn1LSZ+UDIa60KZpNNj1WzinWgx8cZASuNSd9
X-Gm-Message-State: AOJu0YzTFR7jNC4k4KVBr+xcC1P7S2ryM1hjVAbdCv9dlhlqVg8XB6Va
	PG2xhbGNF6CwY5Ra3lrjO++G7YwUYAwZTF7jvRjlTlhiTp9GCNwJUfaFnDQqiR8=
X-Google-Smtp-Source: AGHT+IHdl8ntO9gOdh36Hr77zkWwfPVz9dm1S6pHkk0A2SAa0F3XpPVQY6LJM5TDEV/jmFLzUGKvwg==
X-Received: by 2002:a2e:9619:0:b0:2eb:ee64:1e20 with SMTP id 38308e7fff4ca-2ec0e487625mr8706201fa.14.1718372334044;
        Fri, 14 Jun 2024 06:38:54 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c179c5sm5327621fa.67.2024.06.14.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:38:53 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: liuhangbin@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 0/3] Multiple Spanning Tree (MST) Support
Date: Fri, 14 Jun 2024 15:38:15 +0200
Message-Id: <20240614133818.14876-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This series adds support for:

- Enabling MST on a bridge:

      ip link set dev <BR> type bridge mst_enable 1

- (Re)associating VLANs with an MSTI:

      bridge vlan global set dev <BR> vid <X> msti <Y>

- Setting the port state in a given MSTI:

      bridge mst set dev <PORT> msti <Y> state <Z>

- Listing the current port MST states:

      bridge mst show

NOTE: Multiple spanning tree support was added to Linux a couple of
years ago[1], but the corresponding iproute2 patches were never
posted. Mea culpa. Yesterday this was brought to my attention[2],
which is why you are seeing them today.

[1]: https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/
[2]: https://lore.kernel.org/netdev/Zmsc54cVKF1wpzj7@Laptop-X1/

Tobias Waldekranz (3):
  ip: bridge: add support for mst_enabled
  bridge: vlan: Add support for setting a VLANs MSTI
  bridge: mst: Add get/set support for MST states

 bridge/Makefile       |   2 +-
 bridge/br_common.h    |   1 +
 bridge/bridge.c       |   3 +-
 bridge/mst.c          | 262 ++++++++++++++++++++++++++++++++++++++++++
 bridge/vlan.c         |  13 +++
 ip/iplink_bridge.c    |  19 +++
 man/man8/bridge.8     |  66 ++++++++++-
 man/man8/ip-link.8.in |  14 +++
 8 files changed, 377 insertions(+), 3 deletions(-)
 create mode 100644 bridge/mst.c

-- 
2.34.1


