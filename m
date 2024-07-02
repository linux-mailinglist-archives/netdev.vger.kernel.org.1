Return-Path: <netdev+bounces-108360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9612492384A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFCE286274
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84E14EC79;
	Tue,  2 Jul 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVWW5U0W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D97140E50
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909901; cv=none; b=SKxXILWbieud/u7Vkx+Z3uD/sIS+XyUYAY3Qx9+6+fDsLltWY/rpDHtkdzWbEPiyLRUdLJjgIdAbmx0KDp2o+psRGKw5VSZcBbnDC8uZ9ObvBicQ86avct78fmRXkGAWivBwW66kbGNGz/dych8FpsoOjoo2LYCKioHg/3z8Ur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909901; c=relaxed/simple;
	bh=eUxhEdBF8eVzwPvZ5U0u7aRXZ690oAaam32uTP0/22A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D98jV/BC6K4GYSr2WA96WuWSVxtBR9xFt4558MuF449aHPYl0AUuWgA8yfG5jM+v/DCOKCBp7KDag3eHwrXFNDVa6E9ImGOBuC1w2Ecu2YBdyUGYlsX4Z5GiqLIQT3xmNMoppnAGK6BlpYBaKb8gygomO5tYM7rveJiQ2ZI6B1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVWW5U0W; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fb05cfe1cbso490155ad.2
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 01:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719909899; x=1720514699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=waL7BydcupL+MJe4ERuSN6+dDHL85jaymiRNyWYJIik=;
        b=qVWW5U0WgRXuYPubQcfj9fq0VscvM4mONStWXe22R1ck9Gk2P4hgfgd5UMDAWKc3o8
         KhsaEjSPg5VZDCsi4QFZiJpcA9fHKe3tI9j4PiN9wMkvamtSM9gOkfUTWKuFbdNQgkSX
         mpuO0uzMigHOGaozZSd162KMhR+1SWJDtscW86MqfHw/YhKeoN4pgAtKmXfYUovZJAJP
         CKS/xhHEcuhvhxg+a6HxR0aiTo6nbJ1rsLqzj3eNNeMKGsCbLtPktQTAZXKKymSy8ssX
         Zp2VuxUytllvqSxTHxeGXmKxeU+wCFu5tyPDh7Q0FZlz7ONd9muWC0m18fbjnPMeeTyw
         3uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719909899; x=1720514699;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=waL7BydcupL+MJe4ERuSN6+dDHL85jaymiRNyWYJIik=;
        b=xPJISAF8kTOVOIIflBybSgKSRZ+AcEv7/2HIwA5/fuSaLHuwo98/tgT7v+/wQ5iPzk
         BZv9+1ocJLjnb6U09zG2Ow8Bf7KxtZLZN7SSHIgnLsjX6zrZPMwUMvsNVA1SZihcHugd
         u5biMfq+xM24AWp7vrmi7YvFYjXbWl2IwYWS6ANPA07SQLQP9uk9z6tIy10b8w6EuxX2
         Ct/qFiGX5kbBN5GwmRa1U5FsVf0P1xf6yG4pAYs4y2NFMz66aoyK8Taxr8I3JCLo4uTR
         IfsiXzcM6obqxmcGKunKtkfr+nKIMMPG8NOQItwr7HEx3I/tXg2kwcKYcpCDaZkBkxSB
         00lA==
X-Gm-Message-State: AOJu0YxaNRnQvlF4N9p6suMvJXr0fIM1gOyb4AsQXLwbSb+giKdeH3eM
	Bb3xfI9T+ApgIrdhfdXMZqfzwOrSFFQqn9wtmcLiCNvI69TCCz/EVsLrPvRWowOt2kFJ0ipmVdc
	wqQibYYlcdloDlmvo9SR5NUANINkm8jcHcmjz/V2ZXjaXpBhly8yHu832jdrdwd7TFcN+ebJ3mG
	S3skRMwZmbLfDVpWtJ4o6KGZMalbGam1zw
X-Google-Smtp-Source: AGHT+IFDq0ZRLaB4kKbs0srT/vsrfdfFqJQ9r9U470UBTSrsS3emx2GaXvroifdvWWtVChjuA3WBzO1YNQU=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a17:902:da86:b0:1f9:fc92:1b60 with SMTP id
 d9443c01a7336-1fadbc969d0mr11113375ad.5.1719909898964; Tue, 02 Jul 2024
 01:44:58 -0700 (PDT)
Date: Tue,  2 Jul 2024 16:44:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702084452.2259237-1-yumike@google.com>
Subject: [PATCH ipsec 0/4] Support IPsec crypto offload for IPv6 ESP and IPv4
 UDP-encapsulated ESP data paths
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: stanleyjhu@google.com, martinwu@google.com, chiachangwang@google.com, 
	yumike@google.com
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

Mike Yu (4):
  xfrm: Support crypto offload for inbound IPv6 ESP packets not in GRO
    path
  xfrm: Allow UDP encapsulation in crypto offload control path
  xfrm: Support crypto offload for inbound IPv4 UDP-encapsulated ESP
    packet
  xfrm: Support crypto offload for outbound IPv4 UDP-encapsulated ESP
    packet

 net/ipv4/esp4.c         |  7 ++++++-
 net/ipv4/esp4_offload.c | 14 +++++++++++++-
 net/xfrm/xfrm_device.c  |  6 +++---
 net/xfrm/xfrm_input.c   |  3 ++-
 net/xfrm/xfrm_policy.c  |  5 ++++-
 5 files changed, 28 insertions(+), 7 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


