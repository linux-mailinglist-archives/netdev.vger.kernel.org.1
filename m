Return-Path: <netdev+bounces-179404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAFAA7C621
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 00:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CED3B4F43
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 22:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC0021507F;
	Fri,  4 Apr 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="tI6C49oZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2937F1465A1
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743804194; cv=none; b=EDtxeVMylKHcOGep03jfcp+0KBlkGJe68pMEboFiuh6OaJ7tVjrJI5r+HEZUYt2eQ/zbIdmvTfaFiM8PCkDW0Nkcv2VkdBFcwgwXlWdT+hGDfVi/wb0lWIc1Xef0i7mkODMDP+PlUyQstpqk3/3fcB4r8HO4Fw+GUzzvGvup8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743804194; c=relaxed/simple;
	bh=gDIk+x7JiIL+gnOhb2PtlJx0NIt5hrUfBy9Dv1McNpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZrKnknYBQ72yZ0z78TymJ8/BQo7PZYArEQsQFivfAxAFz02ahhXo8hPVsuaeSWtGqAB/vu2H4EvW14xCOcDyy11I+P8XtU2IZp5Nvvny4KrlBsxG2mMCuX+wLItA5weS61nXBiYP2/i7nIA4EzAaTi11EaivtqIAmc1HntRQAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=tI6C49oZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7366d0f3231so392516b3a.1
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 15:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1743804191; x=1744408991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CW5ZyU6B2yF5dGEahKYT7fT/ZpR48aYGEFhGWqrrZLw=;
        b=tI6C49oZPPpgW2fv0XbuPGy6xP0B+1w7Kcy3PcxNrA+Liehl4zLsLEu+SzNniC3xTb
         ZbN78wf2Q2QZVyL2INYXc2i78LpNPIUmQ3bb7DvSpEDjWm/c1Uvn24zRtHYBvxoKDoBn
         VCSu3LJfKHCdxTDg/fgei29VRc8yKpYD85ovuM+VaER18FR0R8RofCg6qTEVVknZ701x
         dA+20V1A3ANtniT/t0KbP0d/btSfGUxsckmDLsyOcemrz1SPsQRv7yLoeAt3sjAjITo8
         lHZ8jj3M1/ZFBgSlrr1vWBWfHtgm20iu4IkNb9E7xxJauoMkmEdT86qXENguh74EGW+t
         i0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743804191; x=1744408991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CW5ZyU6B2yF5dGEahKYT7fT/ZpR48aYGEFhGWqrrZLw=;
        b=laXve+SbQDe0jVLhMbQKPJ9UmdcIJxrkkNHUnD6KQnFAn7N0DA1g0leutBzGL50ian
         cbq/IMV95sLQ7cJ6BJC9tZ3bUf/0Uj8yAxf+Fc3CY3Pons+KPCyp6lxzS3PR9J2KEHWi
         qT+mZrKNzir+c4qvK1waF6ioEPyiEKwyC049CFQsQBdVeYOaIsyfbDH5yV0X6uOIq9aj
         aKrH0DqAfTDb+lrEjNFttYChFhcy7h9VRZKNLQqbBkEXuYqRus5nhE7ayG82i6gCGJJo
         46LgMX1JPjd2jTBSRWC7nz7wdp+R5nx1NWEoXfrWTI7XNd6eHIlTlcM5H9GtWVNgB8eh
         Q9wA==
X-Gm-Message-State: AOJu0YybB3hz2K+ekqHz7I7EA3NIZfvcgp6QxEPFvcOJqTIZUt+opj7N
	3T97VjPtReZVzSaGoXJlso0ar59nD1Seg4UPVDQp8d2AFlHCWebe225nrpRafS2ed6THyQ6SIGu
	Ect4=
X-Gm-Gg: ASbGncvPz48bKTjcQYN2Q5LF2chkjFmUA5hZOF7dgTg9AegoBCrgtlYipEz3jxCOd8x
	ksw3ewR+QbiZCR5c1QUgQkfK16iSD+AJoLLaRKhvN+wc8zaTEqv83OV6hlGLfynCByQ6UWQiC+Z
	P/ZRmdJpnwTpCmp+f7mIOO5WdnEKx17D3xluHQoDA7Npbx5A4H0CIR4FxZK6JB9m4E8fwa7Cn/C
	TiQpgUxVMuZbfPjMF2knvIRbBb0bD6J0kHF/4oEsiFAX0V880lCvix3DyxL75hTwMEPryzx/4RO
	VZi0MHMQ8pRo2WMDYLYIG2eC72WNLChhHA==
X-Google-Smtp-Source: AGHT+IGPY11M35Kf34J5Cp2LKGX38l0gM/LjzYNVc47EBpMsFRd04aizMBpqNDtfukm7vlwivU1AQA==
X-Received: by 2002:a17:903:18d:b0:224:706:6d08 with SMTP id d9443c01a7336-22a8a06ee21mr24874435ad.8.1743804190744;
        Fri, 04 Apr 2025 15:03:10 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d158:c069:399b:1ed0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0deddfsm3953570b3a.162.2025.04.04.15.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 15:03:10 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [RFC PATCH bpf-next 0/3] Exactly-once UDP socket iteration
Date: Fri,  4 Apr 2025 15:02:15 -0700
Message-ID: <20250404220221.1665428-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both UDP and TCP socket iterators use iter->offset to track progress
through a bucket, which is a measure of the number of matching sockets
from the current bucket that have been seen or processed by the
iterator. On subsequent iterations, if the current bucket has
unprocessed items, we skip at least iter->offset matching items in the
bucket before adding any remaining items to the next batch. However,
iter->offset isn't always an accurate measure of "things already seen"
when the underlying bucket changes between reads which can lead to
repeated or skipped sockets.

In my original RFC, [1], I proposed a solution that added a new index
field to struct sock_common, but general feedback is that we should
avoid this. After some discussion, Martin suggested using socket cookies
to keep track of what we haven't seen yet in the current bucket. This
series is a follow up from that discussion and implements a PoC of this
approach.

This series replaces struct sock **batch inside struct
bpf_udp_iter_state with union bpf_udp_iter_batch_item *batch, where
union bpf_udp_iter_batch_item can contain either a pointer to a socket
or a socket cookie. During reads, batch contains pointers to all sockets
in the current batch while between reads batch contains all the cookies
of the sockets in the current bucket that have yet to be processed. On
subsequent reads, when iteration resumes, bpf_iter_udp_batch finds the
first saved cookie that matches a socket in the bucket's socket list and
picks up from there to construct the next batch. On average, assuming
it's rare that the next socket disappears before the next read occurs,
we should only need to scan as much as we did with the offset-based
approach to find the starting point. In the case that the next socket
is no longer there, we keep scanning through the saved cookies list
until we find a match. The worst case is when none of the sockets from
last time exist anymore, but again, this should be rare.

[1]: https://lore.kernel.org/bpf/20250313233615.2329869-1-jrife@google.com/

Jordan Rife (3):
  bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch
    items
  bpf: udp: Avoid socket skips and repeats during iteration
  selftests/bpf: Add tests for bucket resume logic in UDP socket
    iterators

 include/linux/udp.h                           |   3 +
 net/ipv4/udp.c                                |  94 +++-
 .../bpf/prog_tests/sock_iter_batch.c          | 452 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 5 files changed, 533 insertions(+), 41 deletions(-)

-- 
2.43.0


