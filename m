Return-Path: <netdev+bounces-123181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C872963FA6
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2081C222FF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD46F15F40B;
	Thu, 29 Aug 2024 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="HopcupL8"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE018CBE9
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922947; cv=none; b=n8HwzHNqJr+Asl4k1cnc7sSVko3nWZ8GTImEpPB3pQZri3GCoJvAngWrD+rHkUQ4c85RYQBCGpM11xy1zljipNbDCqmpbgF4DBj6G6gsEP7OooLHG3LdRNyXtFsWIZ4xuLWTJ3y/U4/PQCl55Ed691dTBwx1CGnxZr3jEpNay/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922947; c=relaxed/simple;
	bh=jbIqLh5b7686jfuAQU+00nfDZvfQAAUcRM5NDB8YpV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ro4qTmtHDe3EAngwW8hE3vOcr1Zxu6gs4elSPx9O5uSGCxD2Jz3ZkxYk4hzU/OjCaMSjbb1Nf0bi9hF1FcnztAnKggEyVllSMZaT6WHNR9Wib1RMYJro78lAjoU4m3H3ixMwGO7Qm/SGWKcYVUPgNdoad66TLG5jdhfml8vz7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=HopcupL8; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 23BB6200A8B6;
	Thu, 29 Aug 2024 11:15:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 23BB6200A8B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1724922938;
	bh=EIZ+ed82Ep5w3InTzHBdyZQ84M1Ux+SD6TC0A9JyQD0=;
	h=From:To:Cc:Subject:Date:From;
	b=HopcupL8QEED2VgGHTP/nDcgc1Cb3bcEo317maunfK3qnmPA8zUEbgU/D3KFO1UW7
	 3RMDZcUKsED8CdclRxP4OS1J+3qI/NBEWe1UAwuCJsPvrrrJcqNeC/3ghK9n7SMZuS
	 LZ17sRPBie3eTedhZRrc5Dfzn1ufU79WjJX7g6T6bZ5Q5oIEdUWh6/lXJ7NU7xI1vD
	 yncDpsX7gM/cepgtHmkDSUdqRR2IzdkMTPcPDPNAf4fOKl/gqL8tJkau/RmTVxIhwn
	 Fbf+KFQbacyMKyz8X/oGgxMww6xZX0oX4yA3APNOnekqXYM+EM9Ek9QaKbAnqzxYik
	 z6uhe1xwzgebg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next v3 0/2] add support for tunsrc
Date: Thu, 29 Aug 2024 11:15:22 +0200
Message-Id: <20240829091524.8466-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
- s/print_string/print_color_string/g for INET6 (thanks Stephen!)
v2:
- removed uapi patch (@David please pull from net-next, thanks)

This series provides support for the new ioam6 feature called
"tunsrc".

Justin Iurman (2):
  ip: lwtunnel: tunsrc support
  man8: ip-route: update documentation

 ip/iproute_lwtunnel.c  | 47 +++++++++++++++++++++++++++++++++++-------
 man/man8/ip-route.8.in |  8 +++++++
 2 files changed, 47 insertions(+), 8 deletions(-)

-- 
2.34.1


