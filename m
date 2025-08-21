Return-Path: <netdev+bounces-215523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B244B2EFA7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3125D5C6814
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FFB248868;
	Thu, 21 Aug 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqY/zQIF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9687E4A2D;
	Thu, 21 Aug 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761460; cv=none; b=GD7tLGQtvcukLugIlM0prAuoDHPeEDiPv5LZWyH2gVGaLc7WA00TVT1XP93flp4LKhp4qU2HxgVvABv9JHsWE7l52tVAP309c0ZApGiRP/L8SveIgTDVMzbAiNL9iwJlYDtJO9PldLO+peqcbxqWhbDSTalhCIAOas5jq+2NT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761460; c=relaxed/simple;
	bh=NoOxgPPyA0CjlXVdjQ95IPFGWOGibUXlbgnZAVtKOSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NmtzxVCdQChS3+sNNe856pWy0aAEgiAqhLhB0yMfp9PwOaXst7k2eTYsed9kQIoT8Rx/BMyBXM674qk4F0AFc8LmO/X0yuIcWMmATOT+MKpw2CWpXr7Sv3GRE5Vhjz+X8Grry20eW59dmnGuNNajBD1XSlUlFUoMv99dHCxcHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqY/zQIF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so4748345e9.2;
        Thu, 21 Aug 2025 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755761457; x=1756366257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=adPR99z7uaMqKFrkC/ChFejy0pYBysSlu6YQaTTBbNI=;
        b=PqY/zQIFQu1B0PtNo/b2jJ6VK9IY380XLOxE2zcuiR5a855oa1PahVpgYt9utjrmK0
         m+M91OWwNAL7JDbmnmhsNQNpvbOPj5uXYrrBOIi/Wr1ugROMYp9a1ChKaCuA0qcKWSTs
         vnBha/UsHHrLwFZ3eKPfUHZWEfSzeayF0qMJUfez8vOwpZtVECgZBJ/5TW32HxXYALeY
         lMIdzuye78S0sMxSZZ3p8BxjMH6nKhd3kirE/nynrxZJT1sWuCZxRdk8x/vFAy8Ruszt
         UhZRMHWYhMcV4aRM8q3nQ0nRrv9AqpqCzAxN96mAGdVy3RnHETcvD65Cp8fx40IAfSv+
         UXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761457; x=1756366257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adPR99z7uaMqKFrkC/ChFejy0pYBysSlu6YQaTTBbNI=;
        b=ka0R85U7Yu/rGiTBgHyo7YeuEbEvh+MP8Jq9FXgQTo1Sqb0N81RX3sGM5oM+DR+n+e
         i7S8bC2LBaTqib1teC/eo4fMM4bMoCF8IM+y/yBQOP4mFR8zApHNKnVswtWvT2phmAjV
         siQC5+6a9dioCTPRJ+ipX5AhkNNLAmaZhJGPfYTdhdr1ocr1dZQpzxvdRWrAyps+4yDj
         dMwnQnNeGEUtbwLA3ZH06hQeuhjmxYtyhhX50iM40p9ST28ESl1ofppHfg9fwywY7+mv
         t3IrkeATZcn+oCAy9v32xqVcNbbqIUV9Xw8lGk6h8NksD+PGMM0RSruai6iAPBNJOxB6
         8PGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG37rjS1kWR/XmhSpPLKiV0do1eTus6CiNAl0ccY0xwqj3Mh66HXUxWoaR20Ck20H/6A3hJ7kJPRRvtc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFy/UcwAHfWXShH1wSBV9STzlHWbUAe8WsdnF7UbSyXFFkdJzp
	3Kur2Ggai4d83F3QgwcJoVtcGoqeS4J0zqyzyuZTbbIwBxa7n6t1e6nDNLty5Q==
X-Gm-Gg: ASbGncvf2EzTlVmHK+R8NfXhHac0GT5FxDPNN6uywl9c7miAkZNHcjpNV+TyE0epHAo
	UK55PHtpi1cR/fe/4Pl1bcTVEXK05F90I6JxZ5DJO/iNhObcV68hEFLjJp2BnRWsvlJ/adScG11
	VpPRlOUEhMOqWuBMawMJODd7di5DXjE2JaDCPNHlnWyrNg5CQzwZg339f+xab+F5iP2/VD8e+JM
	anPANl1Ks83lbI9R29fWncWa1x2JdmaGdobj9NQIYl23lCWl6vbGw5j18GGk4BNlK3Rpa7nQsPi
	Z//vJQfsznj25CMq4SEaYIfFOC26ppU6VHmsrMd9/xPq+HpuwGaISdns3k5QaFQtSdvjfEtyn1M
	IEUM=
X-Google-Smtp-Source: AGHT+IGfe/BJcuKAmVkDpeDyemrW+OMi61HUAXoSWQ6mkZj3VNlvAEof8WV4jAktzKV8X7txh47Htg==
X-Received: by 2002:a05:600c:1d18:b0:459:d821:a45b with SMTP id 5b1f17b1804b1-45b4d7ed486mr11170605e9.9.1755761456555;
        Thu, 21 Aug 2025 00:30:56 -0700 (PDT)
Received: from localhost ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db1eb0asm16468385e9.1.2025.08.21.00.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 00:30:55 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	ecree.xilinx@gmail.com,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	willemdebruijn.kernel@gmail.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v3 0/5] net: gso: restore outer ip ids correctly
Date: Thu, 21 Aug 2025 09:30:42 +0200
Message-Id: <20250821073047.2091-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GRO currently ignores outer IPv4 header IDs for encapsulated packets
that have their don't-fragment flag set. GSO, however, always assumes
that outer IP IDs are incrementing. This results in GSO mangling the
outer IDs when they aren't incrementing. For example, GSO mangles the
outer IDs of IPv6 packets that were converted to IPv4, which must
have an ID of 0 according to RFC 6145, sect. 5.1.

GRO+GSO is supposed to be entirely transparent by default. GSO already
correctly restores inner IDs and IDs of non-encapsulated packets. The
tx-tcp-mangleid-segmentation feature can be enabled to allow the
mangling of such IDs so that TSO can be used.

This series fixes outer ID restoration for encapsulated packets when
tx-tcp-mangleid-segmentation is disabled. It also allows GRO to merge
packets with fixed IDs that don't have their don't-fragment flag set.

v2 -> v3:
 - Make argument const in fou_gro_ops helper
 - Rename SKB_GSO_TCP_FIXEDID_OUTER to SKB_GSO_TCP_FIXEDID
 - Fix formatting in selftest, gro_receive_network_flush and tcp4_gro_complete

v1 -> v2:
 - Add fou_gro_ops helper
 - Clarify why sk_family check works
 - Fix ipip packet generation in selftest

Links:
 - v1: https://lore.kernel.org/netdev/20250814114030.7683-1-richardbgobert@gmail.com/
 - v2: https://lore.kernel.org/netdev/20250819063223.5239-1-richardbgobert@gmail.com/

Richard Gobert (5):
  net: gro: remove is_ipv6 from napi_gro_cb
  net: gro: only merge packets with incrementing or fixed outer ids
  net: gso: restore ids of outer ip headers correctly
  net: gro: remove unnecessary df checks
  selftests/net: test ipip packets in gro.sh

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  8 ++-
 drivers/net/ethernet/sfc/ef100_tx.c           | 12 ++--
 include/linux/netdevice.h                     |  9 ++-
 include/linux/skbuff.h                        |  6 +-
 include/net/gro.h                             | 43 ++++++--------
 net/core/dev.c                                |  7 +--
 net/ipv4/af_inet.c                            | 10 +---
 net/ipv4/fou_core.c                           | 32 +++++-----
 net/ipv4/udp_offload.c                        |  2 -
 net/ipv6/udp_offload.c                        |  2 -
 tools/testing/selftests/net/gro.c             | 58 ++++++++++++++-----
 tools/testing/selftests/net/gro.sh            |  5 +-
 12 files changed, 110 insertions(+), 84 deletions(-)

-- 
2.36.1


