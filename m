Return-Path: <netdev+bounces-131579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14A098EED8
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BD91C21193
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD0815E5D3;
	Thu,  3 Oct 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xAXCtCu/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398DEAD7
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957544; cv=none; b=Z4SF6zwbmkOsmYIumciErtNC8KPkNxzIL/uJky/6v5+zvuNi2Ja8cYW6MYNHeEQWnX9XwZhxFZ8t0/9jBRSyN3zmzNl+4+QZHZP30eno3GrdTGah/CkPKz2XU4SsTt1q1x+GsMGSTLs9iwonn/xkrviQyN1hSTJV2NGPiVIHXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957544; c=relaxed/simple;
	bh=taDKdn1D/LOIIdkYo5tox9xRjz1ft/wkd5OyH40zEJM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=azqMuX1K2ieXBuY/by5lw5QAskC67RXhqmWjXhqkU74s0OVWReoOx8qyu4G0urZbMrLX4L8SmxuaZjamIe3FP1tCuBnGhs1ZVqXGDhmqX20RXZY+f0AyCoA+8eo3D4ma+rgCSg6ESTsXN58oEZoOFPnlozaJIRdz09Jeb0D4ouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xAXCtCu/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso978060276.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727957542; x=1728562342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=15ktey/AM78eQUiHQmtJvgBWhY0YJk342r1ub333FVc=;
        b=xAXCtCu/nHrZQnqXpdEeUjfAnCC7GeIKW+znevf6513aWExzgqSlbfQ2r3NfXnTCi/
         8PHXnw/gRsKOrLtviPslriLHNKk/WeIlnw8DwBV9LxfYh8ir2hyZgQ3NonJShNKIy+S/
         drMAN/0n7S21egqK6AT/jpc8em8CGQRTXwublKGBMoReMzPtrksx0dykO7K3B3ghTQHz
         79c0YQdFwSWsTdevFF/cKAVEBuJNR6dGt7ZSOEl/uZZ+iQZfLHd8j+T8+6vG+YZuvYdC
         /bF2zs6B1enLc9cXcCMikZjSl/PjFKADBvbXHgGi/TNQKajq7RMraZlhYuiyG+Y8IK9z
         ozug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727957542; x=1728562342;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15ktey/AM78eQUiHQmtJvgBWhY0YJk342r1ub333FVc=;
        b=L1sWMuqhdLM/6yd75eu7u5/p6liB/MuavAibNLsfR4j5fuDoz2O21H5c5A+AJxhJTd
         QbEaQYONRJbpbG/s/G5grLx69tl0jqqnS8xO1yKXjQB+N/ZpiJO0VsR3OHQTq0GZlGGe
         YZewuU8jXmPKUnB3h1TLpqnkFqW6XsheHT8WmnuDZiRh6+MEPSdgIfkJSCI8DOqZk8yt
         V/mpuhuBu4ReQ1Hi5pTl3ACN0zC5HMWFLffVXfoCzp1G+kYPOTGhDWjQkyHJejiooyQm
         CLU+XciAfH5k0APsUuEVNeB8iLrSTvikvqvyXhlbMv7wno7Bt6eZQU4uc2LYf22dg7Gv
         UWPg==
X-Gm-Message-State: AOJu0YzolJbVrfrIdyD7SFg5EY6qWPcz97kBUUooVz03QcyYU0X8kjto
	llpbKByBcy8Crp4q3T95t74FnqNhJmF9JmpNYYCVaMGqT/ihwuoKh0JGklNgWbZmVXSLNENVd4O
	ze6rincZFWg==
X-Google-Smtp-Source: AGHT+IHNlDihc6QGh7HtybY77GZu8V5EmWm+4zpFemoFgbdfre/28iZva2KpHd5kAV0IYv9ZqLNGrx4GiTPxOg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:d342:0:b0:e22:5bdf:39c1 with SMTP id
 3f1490d57ef6-e2638447471mr3989276.10.1727957541972; Thu, 03 Oct 2024 05:12:21
 -0700 (PDT)
Date: Thu,  3 Oct 2024 12:12:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003121219.2396589-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/2] net: prepare pacing offload support
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jeffrey Ji <jeffreyji@google.com>, 
	Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some network devices have the ability to offload EDT (Earliest
Departure Time) which is the model used for TCP pacing and FQ
packet scheduler.

Some of them implement the timing wheel mechanism described in
https://saeed.github.io/files/carousel-sigcomm17.pdf
with an associated 'timing wheel horizon'.

In order to upstream the NIC support, this series adds :

1) timing wheel horizon as a per-device attribute.

2) FQ packet scheduler support, to let paced packets
   below the timing wheel horizon be handled by the driver.

v3: added yaml doc per Jakub feedback.
v2: addressed Jakub feedback
   ( https://lore.kernel.org/netdev/20240930152304.472767-2-edumazet@google.com/T/#mf6294d714c41cc459962154cc2580ce3c9693663 )

Eric Dumazet (1):
  net: add IFLA_MAX_PACING_OFFLOAD_HORIZON device attribute

Jeffrey Ji (1):
  net_sched: sch_fq: add the ability to offload pacing

 Documentation/netlink/specs/rt_link.yaml      |  4 +++
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  4 +++
 include/uapi/linux/if_link.h                  |  1 +
 include/uapi/linux/pkt_sched.h                |  2 ++
 net/core/rtnetlink.c                          |  4 +++
 net/sched/sch_fq.c                            | 33 +++++++++++++++----
 tools/include/uapi/linux/if_link.h            |  1 +
 8 files changed, 44 insertions(+), 6 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


