Return-Path: <netdev+bounces-222963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CC9B57497
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840E8170205
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F4C2F362A;
	Mon, 15 Sep 2025 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5EfD67W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34942F2917
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928001; cv=none; b=SU6R5qFRP62i5E3OCX0lhcG0PZm9eGuI1m7iJZgahEQUvkW25ltcayPvPMWJI2t3359CvlAA7scXJCxM4HzxB/Mf3Ed+ZfbXV6imcDiaTVoiF+5w9y4CjQV7hTlLdYwDLxPPmvwNkk9h8oZYnaFvmOR7cj/LHWOtDFOgHM/R2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928001; c=relaxed/simple;
	bh=K0GJ+R9x0haORf15J5GMt5LUhuQsz2f02NKRrcKInbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUgspzU+b0J4GOm9qwy8ss45+hqdtW31+Zz7TcixTjSlZnTLS+WnWfO2pVEgT8f8NHYyi0+qN3UmLM0c3kPwCkOpBNQzkYY4ZptshXx3dYq4+qc3z0G5kVhK8wUk27PBDwn/gqdpDFoiJbUbyRsiaROeM319Vde5Rhng8CnWCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5EfD67W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3F2C4CEF1;
	Mon, 15 Sep 2025 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757928001;
	bh=K0GJ+R9x0haORf15J5GMt5LUhuQsz2f02NKRrcKInbg=;
	h=From:To:Cc:Subject:Date:From;
	b=u5EfD67W87bLRzGmBlB1cXO9Za3xxRBeqZIyQn0Aqy3GQfOm/hXqved4KdXF/KYBT
	 KYSN1IdrITeFOlKKqPVPDcLww8dxtb82oAnI4/LxBquxKj1wNzPsvlilp4gRbYH5nQ
	 fULX/dPuuYolGWQ2+t6QOXGLyeWvQSYDH61/TFdmLadkp1A6kktBa5WZWPk6UnklMO
	 F7LgWlWZOQa0WVuIPIGKwf2uAinQqMngsivKFJN59noSsVrFDXdPG4qrT0zVI/79WY
	 Zu6iUeGOWZlte8iWTQH4GRTPv8B70ZnWo0TR7pRw3tiHfGeszzes1p6aVPqHdg+k3d
	 s1kIoa4Pcl19A==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] net: ipv4: some drop reason cleanup and improvements
Date: Mon, 15 Sep 2025 11:19:53 +0200
Message-ID: <20250915091958.15382-1-atenart@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A few patches that were laying around cleaning up and improving drop
reasons in net/ipv4.

Thanks,
Antoine

Antoine Tenart (3):
  net: ipv4: make udp_v4_early_demux explicitly return drop reason
  net: ipv4: simplify drop reason handling in ip_rcv_finish_core
  net: ipv4: convert ip_rcv_options to drop reasons

 include/net/udp.h   |  2 +-
 net/ipv4/ip_input.c | 29 ++++++++++++++---------------
 net/ipv4/udp.c      | 12 ++++++------
 3 files changed, 21 insertions(+), 22 deletions(-)

-- 
2.51.0


