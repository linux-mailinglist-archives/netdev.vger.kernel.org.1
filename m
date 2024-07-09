Return-Path: <netdev+bounces-110103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2292792B005
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A41C2142E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6234912D1FC;
	Tue,  9 Jul 2024 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3R95UK9t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772412C475
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506214; cv=none; b=ex5rR/xMY1owJknQE27FPAtx03lLK/641IpB//c770lZH/BZ0S6DAi39rqjbWNXD9GsibYGY+Itg+R+W8JFymHTlSb/KclQflMStDA3ntLhwNAQWUO9H5oMg36Il977xUml++XjocDh3AqpZkROrPM5hITBaJ3QOlHMfkRzNepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506214; c=relaxed/simple;
	bh=4q8ATbKfZuaHt6kAUpBlm3I0ve+YgTU2g+hESTeixzY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OVL+XSUSwLlZ68D+cZABjZ81OOwVrDSXB+yK8nMX1zWNHMEXMajZwZFMTzsGni649HP6QKYZ3tq7yNmXddeCYPRjNDJp4CJCmh8GlKnmDsw8eZCRBFwlaGf3O06YjmEAXA93c6EzleYGEXGvDzfIhxsu93c664793WcrTF/ufwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3R95UK9t; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a3aafc6eso7642079276.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 23:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720506211; x=1721111011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gTIgIPhGqh6Q9kFztbHCyG0+YnbLAmMfS3aYnT9GLpo=;
        b=3R95UK9tIfa0PdmKEkMtM8k26eGg4FfN9F/kRyBWk9eg6nPCDc2K5GNkpzU3ZR4cBR
         X6LRzDeSgCqMmTArnlXJkhhYwS88a9v9QHvcdztJYtBvZSaq6i9XLjpyYXuzEuL8R1o+
         bNJzVO6IgtfnRRoA8QnMUqESLbSyKXt5/KjBv598y2NMa4GtULQBFpXWMvczzJSz22+l
         JF0H1Ag1vDsUvgHjBqOP6s5NWFzxFyftdjJXwiHz+5mvXr4OdCpzw7VZkVl+c/mmmV98
         oapJFRhPlxC9bSNgJ95gBq5IeusXXZTKf/z4vtR5G48QihMmb+rVeKBWkIVFnrTHK/NK
         X7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720506211; x=1721111011;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTIgIPhGqh6Q9kFztbHCyG0+YnbLAmMfS3aYnT9GLpo=;
        b=uQ9ypncgL7DrI/xfycawHD/x1m4Q7bUR3ygZY3zlUCES3DlkVPp5A7mjbs5nzYf5/c
         ckHcL/3w7lR7fshRlROl6pP/iesgy9I1nLkZTTYjoA5mrPogJkwaHWoEFbo2uvCp5D67
         ZjWV+7XWpdU8cIkIAIlJkyBYuFjf40n7rL55/yS99RTTrLxs4FNsLrSAEYWGUbgByAoN
         1hb6/XAl8bfEehNp2+nLaPABXz2bGJ2491cqETtmCjsNSRV9KgsWfRLE0wAqgXIGJl3H
         vpEA5Htx5AHHshfvd2OBJv+ATCNMxCvHAbVNB0vgnYlUZ9S7vv3hUGAyPAUFNhq8MsEu
         yACA==
X-Gm-Message-State: AOJu0YzDg0ZKLYjtRMP0iZ0wMZwOxOiQfgEpjmLk4BxY9m0/vNA9aDzC
	OZPjjndGRLY6gYWlAo2ve1k2uAcmDygjjHEmNQGWghjniHGoWJexzJXu2nGNNLuWvaYyIRahZ6Q
	k95KCoX5cMY97hNPxQWXKuRvWFyrSKWUQX7oJeC1Mr53Kg1eND6IXb5Z3Ni4Nngm8VbwnbpHHax
	3hLesMqtCFLIoIHvKydKyEGYkkwiNRp/Ug
X-Google-Smtp-Source: AGHT+IGfEFlXYlODfTexaqaHOtnt1oHf5ecdrjNP3TKIcRU4LKG6KVxe1kcLmvJMovleDirqDxr9n05qzyw=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:6902:1a45:b0:e03:a2f7:72e with SMTP id
 3f1490d57ef6-e041af3c7c5mr12009276.0.1720506210798; Mon, 08 Jul 2024 23:23:30
 -0700 (PDT)
Date: Tue,  9 Jul 2024 14:23:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709062326.939083-1-yumike@google.com>
Subject: [PATCH ipsec v2 0/4] Support IPsec crypto offload for IPv6 ESP and
 IPv4 UDP-encapsulated ESP data paths
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: yumike@google.com, stanleyjhu@google.com, martinwu@google.com, 
	chiachangwang@google.com
Content-Type: text/plain; charset="UTF-8"

Currently, IPsec crypto offload is enabled for GRO code path. However, there
are other code paths where the XFRM stack is involved; for example, IPv6 ESP
packets handled by xfrm6_esp_rcv() in ESP layer, and IPv4 UDP-encapsulated
ESP packets handled by udp_rcv() in UDP layer.

This patchset extends the crypto offload support to cover these two cases.
This is useful for devices with traffic accounting (e.g., Android), where GRO
can lead to inaccurate accounting on the underlying network. For example, VPN
traffic might not be counted on the wifi network interface wlan0 if the packets
are handled in GRO code path before entering the network stack for accounting.

Below is the RX data path scenario the crypto offload can be applied to.

  +-----------+   +-------+
  | HW Driver |-->| wlan0 |--------+
  +-----------+   +-------+        |
                                   v
                             +---------------+   +------+
                     +------>| Network Stack |-->| Apps |
                     |       +---------------+   +------+
                     |             |
                     |             v
                 +--------+   +------------+
                 | ipsec1 |<--| XFRM Stack |
                 +--------+   +------------+

v1 -> v2:
- Fix comment style.

Mike Yu (4):
  xfrm: Support crypto offload for inbound IPv6 ESP packets not in GRO
    path
  xfrm: Allow UDP encapsulation in crypto offload control path
  xfrm: Support crypto offload for inbound IPv4 UDP-encapsulated ESP
    packet
  xfrm: Support crypto offload for outbound IPv4 UDP-encapsulated ESP
    packet

 net/ipv4/esp4.c         |  8 +++++++-
 net/ipv4/esp4_offload.c | 15 ++++++++++++++-
 net/xfrm/xfrm_device.c  |  6 +++---
 net/xfrm/xfrm_input.c   |  3 ++-
 net/xfrm/xfrm_policy.c  |  5 ++++-
 5 files changed, 30 insertions(+), 7 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


