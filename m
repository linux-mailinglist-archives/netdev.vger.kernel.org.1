Return-Path: <netdev+bounces-110545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE1392D08A
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A50B2AFD7
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BD1190072;
	Wed, 10 Jul 2024 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhgRecsb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61C19006E
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610229; cv=none; b=NAzNSyMxMTjyQI590ydSokvO2EfgNdhZeQW+kYdS4Ny5Bnmu+H8jHstExBl9nfMfu25pcgSy7EWmVxhSjGrHSEhEs1kXANEyr+XUWnDDydVfOBP4gqu4DWpK61MN62TXAGindwNE2pKpNA8CfTAoda0zmsbRqtSyhAUxefS+Xv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610229; c=relaxed/simple;
	bh=L2QLVpCrWK3To9JfVU3/qMqOQJv1TZa5VYxjdz0mzZ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FZw3uo92d6z2UEYiPO4BwLEImpYaszEjxGpAyH4YevycRzsN8GcTpU7Sq1qAnB/2BpsfIVpY0X4mgqNk2CSP+kYFAjZbDz3/u3p0FI/lo7SUFtPgwzdByE+OtUX6IP/OC0GzfKO9mifT4w23odVvTHPds33wTjSrlXDy4GdL54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhgRecsb; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70af58f79d1so4412750b3a.0
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720610228; x=1721215028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5WYlwwl3HOp33dodEq7y/gshBipElsaGb/RSLbFJHSw=;
        b=MhgRecsbcKqcuA/L8DgxKg5NN0cXo0UtHxW19GmFWi6X3+n2XHr5JcruX6lH+EA4uq
         vkXN4gwG/ygfwDHYeILqpMeXV4WE/Oh0JeN3Om7w17pz2Ahbo18xCV1KMi0vxrhoVp1G
         kSBUumzLH4WoYcKvCxQNarqGn8XSOHD28tpjlPKRHqJlhguSU3xhBhEvqClZ75i0fQCa
         P+5ZDi2zfDWUM9k2Sncq4Lg538IgRyMWnIoD+KMWn15Dtlzj3M0U1x6sX688WKLUQ5mT
         HSOsq/eVhOc0tx/VyT3nUdUaiJVioQuBS+VaIOQaLln7EFtBYQZNcu0HIJXweqe2DWAe
         DfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720610228; x=1721215028;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WYlwwl3HOp33dodEq7y/gshBipElsaGb/RSLbFJHSw=;
        b=DYakldlOE+cZcBB1J0cuu/gMWPAlQd+ZJX+0u8IkQzmjsi5Cu8ne2wQ63Aed287mq2
         ckhj8JR6Tcs4zN0PIA4uHYNCoauTZ2sQgX3lG07eb6H5vQor4RTIhPo5ZkZ9tuCtADUe
         Vj+qLeaRboLV2zdHw/vrNkF7wLDEcawdly9iM6Dp0jBm9noYAfep1ynDPTCE6URSW/9N
         TzUEzqd531IiGBMTTX1XD1OoUBZYjxeqCIqFZMg0oZVcFwEPT9YWUJ1795Xw+BgpOgIX
         L0l4oTL4sDKKFCOtm8AAtYMkMmaxjsg8Wks9UlagXEk3047IbrEXtlVdIm/R6j/1uKdc
         ZNWg==
X-Gm-Message-State: AOJu0Yw43G3fgPeqNd8K1WpcVDnYfUIFaxY1SvtlEdKKGJ8K9u2VdyDL
	QDUd2y+0OkS6jn34nLNknNFgRD3L5hvqnSiDXu6/edi+g3+PYCDgzOLbtINw6ekP/eSAz7hQzrU
	0JThapJy6K8rrCsgo6YfDXVl2LDlM+BX8PbPf8skTFfSdqNaJ0fdvuVCML9KhK21quH6Bk3V0Xr
	7XP/QE4iQKYObJA22bH8IjBAwUdKvIat5R
X-Google-Smtp-Source: AGHT+IGDxpKA7csdunu2OuGUDm8AnmqxmtKexZvYf7Qz1UlfWk0USBtS1lNlL+G0aXfdJLZw4RcsqtBhXrY=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:aa7:98de:0:b0:70a:f547:382 with SMTP id
 d2e1a72fcca58-70b4369d510mr93773b3a.5.1720610227371; Wed, 10 Jul 2024
 04:17:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 19:16:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710111654.4085575-1-yumike@google.com>
Subject: [PATCH ipsec v3 0/4] Support IPsec crypto offload for IPv6 ESP and
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

v2 -> v3:
- Correct ESP seq in esp_xmit().
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
 net/ipv4/esp4_offload.c | 17 ++++++++++++++++-
 net/xfrm/xfrm_device.c  |  6 +++---
 net/xfrm/xfrm_input.c   |  3 ++-
 net/xfrm/xfrm_policy.c  |  5 ++++-
 5 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


