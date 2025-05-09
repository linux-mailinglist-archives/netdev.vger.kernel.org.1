Return-Path: <netdev+bounces-189276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542C2AB1756
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD94F16A8BB
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A52147F1;
	Fri,  9 May 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ablaaaIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E520DD72
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800857; cv=none; b=W+LeP6TJYlpIwdp8MK55kF9qL1U6WPjb7vijmFrOa/IzyA6FRJaHmbu0DRBjszC05JallYbi+5hdNZL9KSc8Zr4GnxoDX6jQALsAldRTqDW+6f7VHGmuNbrn1TcAj8q9XXl2kdEYRKYsgi+nAuUNWq5k0Otk3m0IYfrnBJzSg1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800857; c=relaxed/simple;
	bh=l3E3hP+ZTU3+TnZqnrk8NOopkqGZ+qIahKsDOidVris=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ObLiQpI1UisF1mOrSF9Qq1Mfkj/jLfsyiwo9XXQZY8DNY6aj9BARzOlPUC5lgnPI4ZYE6JTP3jEdgYL9W2bDPjCRRmnY5FSmZdnDIoChRWT3iKdp1mzfH1tvK+9NV0IktsZmjefkL01A60ur/lxuF7inNg5jj77ufcgsjNh29zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ablaaaIp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so23095285e9.3
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746800853; x=1747405653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7mBAadUtTRhMmbUdVab6q556i107NNElwL9mkACPKHI=;
        b=ablaaaIp1KGtMjjrOloVyLimSmEJyws00vi5p0EdbuCKiLKkIWJvjPxsMcSXqkOS7a
         Q5f+mHmR1G8oRFIVvFagwZ2/2U+5eRBmBXEeZCWq8F6raOZ9o1/rF/zqE6BZcNIeu0PN
         IZoAX2QsujUnIEP+ZoSSzOJv772KV/zkEFkgNhB23NUhP+yMmulBoWXyoFMB1BobAC2g
         XDKG5YST4Nsla1FCw8wLzVRzZzkjgv9g5Cr6S1DdvINFV9Q8Q63hYbXoKhpc8KmL+Yyh
         4b4WaalESu8CvEHYmZl5ZrNqGhUzywL7RCLzGNBsHWZDwsMYo4m2dkgrjBpdJDiJq89d
         DUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800853; x=1747405653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mBAadUtTRhMmbUdVab6q556i107NNElwL9mkACPKHI=;
        b=G674hKov10swVbIfVY0OFrMb+kMX/aHoLNEzzme3zZWicvPrQdFUPU+Iyi3RUqZSSK
         4DkAHndxn4jpxA4+8v75BerrTovjiFqA+iVAEbxlooyp5/0Y9YAmQDFSc+0BW9vbg3sr
         vhxlMuBEnxUNzFA4DVO5s8S6AgDKRjT50AsVHdqaWjpp854kH/yMfZVLIDSvJAFARcOu
         23XNXBSZ7igqbwduqQiHZd5s/bLWIjZ1qfAzwPrvQaLPKmBdX4z3sTngEYk6YY+IqUvJ
         G8B0MKzReA0meRZ7JwyRGp/3tcqAeZs3LEw9ZbI/7inS5Y4+o2yJz9Qs2cz1S7L46IUV
         LiWA==
X-Gm-Message-State: AOJu0Yzhbkw0fkZ1dmeQP1T/Go62IWFYfapVj+RJpPkshQZRLmyX0kG0
	rpaJL5gSN+jDGG6sERd9CCg4lnXoSz3bdWdp4dLIcX/1/gP07hIxQ/y6/5kYBWpXqylETu7uHS8
	IuyRP3569zZB1ftKHKsheTCFCDZIzN/a69ysf9NeIk4B2vX8TnCZFBqvRt9HJ
X-Gm-Gg: ASbGnctcqZOTtXQrCeK0ltXiwvUqBsWTh2NArtYPtUGEvfVwcVGLhdR2hHak+liqjWX
	NbbQsd7LsMKqq7RgrsqhEjQFrUn2taDyXoW3HYHgi5tCsF1B4DMq0347THDjECdo/oMQd5fBDTa
	9zzLKKzG8aMz/XnttLIFs3+CdQLOiYBbN5S330ip3qLlfzPMf0o/qDZHahT/5piHA/qnCXHG5Ld
	5UvB2eG4xCjuMrD+n08+1CHo6woKVDoRPlVKfAkhV2UrOaNqlO0l2HHzv2ARD+/JvDUMGU5AtYb
	FX6ZAWMcKl9fmUrIdaDmgit6l0Gh4kd/uaJrEwWWI+uQxN6ZpOvHfZ3R4+nMMddATKUM2OeXlA=
	=
X-Google-Smtp-Source: AGHT+IFZ+PJV//g0Th88LZIMgq02MFNe5zK+5XN4sDnr29c1O9EQFaeY8er+njdyN/nnHEna27qBlQ==
X-Received: by 2002:a05:600c:4e09:b0:43c:f64c:447f with SMTP id 5b1f17b1804b1-442d6dde9c9mr31607045e9.29.1746800853312;
        Fri, 09 May 2025 07:27:33 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm30905025e9.38.2025.05.09.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:27:31 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 00/10] pull request for net-next: ovpn 2025-05-09
Date: Fri,  9 May 2025 16:26:10 +0200
Message-ID: <20250509142630.6947-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jakub,

here is my first pull request for the ovpn kernel module!

As you can see in the patches, we have various tags from
Gert Döring, the main maintainer of openvpn userspace,
who was eager to test and report malfunctionings.
He reported bugs, stared at fixes and tested them, hence
the Reported/Acked/Tested-by tags. If you think such
combination of tags is not truly appropriate, please let
me know.

Please pull or let me know if something should be changed.

Thanks a lot,
Antonio


The following changes since commit 3e52667a9c328b3d1a1ddbbb6b8fbf63a217bda3:

  Merge branch 'lan78xx-phylink-prep' (2025-05-07 12:57:06 +0100)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-next-20250509

for you to fetch changes up to 476148af4e28f498bf769eeed81ef99728544c56:

  ovpn: ensure sk is still valid during cleanup (2025-05-09 15:37:31 +0200)

----------------------------------------------------------------
This patchset contains the following:
- update MAINTAINERS entry for ovpn
- extend selftest with more cases
- fix ndo_start_xmit return value on error
- set ignore_df flag for IPv6 packets
- drop useless reg_state check in keepalive worker
- avoid crash during concurrent peer timeout and iface deletion

----------------------------------------------------------------
Antonio Quartulli (10):
      MAINTAINERS: add Sabrina as official reviewer for ovpn
      MAINTAINERS: update git URL for ovpn
      ovpn: set skb->ignore_df = 1 before sending IPv6 packets out
      ovpn: don't drop skb's dst when xmitting packet
      selftest/net/ovpn: fix crash in case of getaddrinfo() failure
      ovpn: fix ndo_start_xmit return value on error
      selftest/net/ovpn: extend coverage with more test cases
      ovpn: drop useless reg_state check in keepalive worker
      ovpn: improve 'no route to host' debug message
      ovpn: ensure sk is still valid during cleanup

 MAINTAINERS                                    |  3 ++-
 drivers/net/ovpn/io.c                          | 18 +++++++++++++++---
 drivers/net/ovpn/main.c                        |  5 +++++
 drivers/net/ovpn/peer.c                        |  5 ++---
 drivers/net/ovpn/socket.c                      | 21 ++++++++++++---------
 drivers/net/ovpn/udp.c                         | 10 ++++++++++
 tools/testing/selftests/net/ovpn/Makefile      |  1 +
 tools/testing/selftests/net/ovpn/common.sh     | 18 +++++++++++++++++-
 tools/testing/selftests/net/ovpn/ovpn-cli.c    | 19 +++++++++++++------
 tools/testing/selftests/net/ovpn/test.sh       |  6 +++++-
 tools/testing/selftests/net/ovpn/udp_peers.txt | 11 ++++++-----
 11 files changed, 88 insertions(+), 29 deletions(-)

