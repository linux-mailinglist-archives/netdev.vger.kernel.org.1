Return-Path: <netdev+bounces-143704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A59C3BBF
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34CA1C21B37
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55011662F7;
	Mon, 11 Nov 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1AfwPRu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B1E545;
	Mon, 11 Nov 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320221; cv=none; b=M9Ye4vgzXiwByEir8Yne+P6s+g05Moiqi0eStjHz+L4nMZKYzTB3n3eqYk7Ewkyc+VhM/ieskP/W2zDdQmoHQS5o5q2f7zSlK2URDDwfS48dTNfh/SSKfvY4+zJtdKh5BZzWLxeYXjPxoo21lG1ETgn4Mj53u2KFADJkLs9uhds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320221; c=relaxed/simple;
	bh=0gP9UB59bQFSXmamZj9MLVJpfdvV6G8Gb4FOovrTXRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tti1bp7uv4mGh6Vgad7A0BkcfxaRr+yRHiuD8VflL5YpniCQcV092uSq/bSjTx4XZ2jJjQFSBpfKU97Kr7C/lq8vJbxcAUWlSJrs8H118/zzTwy+q52xW/7UmEpqBnV6v30IIZnxRdWH22CqN083j98LAfWkKJPp18+MUyJbi+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1AfwPRu; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e59746062fso3456245a91.2;
        Mon, 11 Nov 2024 02:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731320219; x=1731925019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/uaxk0VIcTk4w8Uo5lWmUAaFUSBTGhmduT8dpUAibBU=;
        b=Z1AfwPRuWojFIKbAZ3LLKFqGWzr3qJCR1Ljhs1Tthz9ILeCDFlwQ51qP/UEeDzg/S9
         uRQdgsb09Qg5X15oMxbBaQYEP2DUsVJmt8bs4GINmsrShft0hnve3UKbcfQ2vLMoTHet
         +JTDvru5A3nLsiT4vN91bXUZ1rozZiE6FprqzcWoPo9CN+cQujOJ6yKT+mvgGY3y4c70
         E4ITU8n6Ps2mTpzPdpj5iQkIHY+N3L5/SIUpOsmekkefRrffAyvHlYHExRio5sva4/89
         VAxs4cGPbhaO0A0ENNKzdUGUJtHDyfoDBxZzDqOfJfrRbFbTZGBN2wpHPb9qQ7eZVaDU
         wmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731320219; x=1731925019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uaxk0VIcTk4w8Uo5lWmUAaFUSBTGhmduT8dpUAibBU=;
        b=THNhQJsfX9rdZBJ93L7j/PEDIw2DYl7U05myr5srEcmZSZi/MdBE9jT1gVLjtahPdK
         oIrSIvbA7PtzVTZV1EoIA2Yz/I9PVRN4/TjhUE759Jp1S8KxOk5pl3yHrU0/mRRP7IBd
         vBRsLTeRFQXOaanXdMLEfdkexm3/l5vehvFKuNT2MIIcWtLEVV3K1SO5AyaAA23go7fi
         B4ixAt447UdguhjSutiUB8HtJA//FootfZBIDVkOv3pFxvfA3mu2Qm1dIf6vg6EZwqng
         jrvFSFBLbhLHKUIxMtmrTTSF785tN+yGPfSCpQFmXj3icoHiImevSK8yMXo4VH4Pl+d3
         yK1w==
X-Forwarded-Encrypted: i=1; AJvYcCXf7D88MZbS4p46klCb2zHfhPCu6fUCVfemq3d9N+Wrpgvws/pEfXB/R2+n9ImTvvg4m4IeHsdcH8pvTPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXPeO5ANi8yREDPahzyfi8jnnxFo5J0ZimAPGnKAZMJyCKoIE
	Hvb2dmGCtmbPWv5BZkC+1o5OL7QAcJwsaBa3BoWBuMAXkJoOxYRAkLuYUCSPuYuMOQ==
X-Google-Smtp-Source: AGHT+IFtqV1C/BJHYanyvs59UHDsIVD/Kbmt+5Csyh4WW8ghogWOBTfsW6FWCcxJMdyD6L4bJK1Lqg==
X-Received: by 2002:a17:90b:2748:b0:2d8:840b:9654 with SMTP id 98e67ed59e1d1-2e9b1754affmr16295483a91.34.1731320219351;
        Mon, 11 Nov 2024 02:16:59 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9b26b9bd8sm6309831a91.5.2024.11.11.02.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:16:58 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net 0/2] bonding: fix ns targets not work on hardware NIC
Date: Mon, 11 Nov 2024 10:16:48 +0000
Message-ID: <20241111101650.27685-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch fixed ns targets not work on hardware NIC when bonding
set arp_validate.

The second patch add a related selftest for bonding.

v4: Thanks Nikolay for the comments:
    use bond_slave_ns_maddrs_{add/del} with clear name
    fix comments typos
    remove _slave_set_ns_maddrs underscore directly
    update bond_option_arp_validate_set() change logic
v3: use ndisc_mc_map to convert the mcast mac address (Jay Vosburgh)
v2: only add/del mcast group on backup slaves when arp_validate is set (Jay Vosburgh)
    arp_validate doesn't support 3ad, tlb, alb. So let's only do it on ab mode.

Hangbin Liu (2):
  bonding: add ns target multicast address to slave device
  selftests: bonding: add ns multicast group testing

 drivers/net/bonding/bond_main.c               | 16 +++-
 drivers/net/bonding/bond_options.c            | 82 ++++++++++++++++++-
 include/net/bond_options.h                    |  2 +
 .../drivers/net/bonding/bond_options.sh       | 54 +++++++++++-
 4 files changed, 151 insertions(+), 3 deletions(-)

-- 
2.46.0


