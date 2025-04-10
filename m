Return-Path: <netdev+bounces-181330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD88A847C6
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E944E0F41
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F81E9B09;
	Thu, 10 Apr 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="nBkPypzi"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846381E3DFE
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298701; cv=none; b=J1tnXHTGq7NW+hlUshmMgDJ3cQJKyD+dNtmCrkRPNbKuHrmeeGXWnyVn5T+zl7GGIWHbNvgUDvCCFABnH9Anvql0KfraJ/eu3/0BmXB9b+RP64Exr48fKh/eKUseGgFkbpyWpJxMXFYebqXX84rCjkAM5rVFGi0GQWJvMJylKI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298701; c=relaxed/simple;
	bh=OoV04jMkqCepD3dnZqtdd1K5UbeqvwPhreWVJClPm4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bAdDYZkvVRovOUuCmGhFPfkYyIU3CNuatqlgLQraXRGEWsD2xQ90kMfcf246pzvP8iJpYGQMLX7MQNHpsrMuRyS0Bf4qolCI23+bRD8oFO6RjU2374HrXuSSnZ7SoiV8LWuWOGOV4xQo5ICG/eVTD1Y/l7WdmTrMYP9n5zAjxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=nBkPypzi; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 9824F200A8C0;
	Thu, 10 Apr 2025 17:24:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 9824F200A8C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744298690;
	bh=Tsm0v27J7SFwZ4hv4Vw8KTGXPsTq8PtGkQ1UmvwYGLA=;
	h=From:To:Cc:Subject:Date:From;
	b=nBkPypzig5ARknhtnaotEsOlmuNhLIv4hb/M8RWKIPDUCiqF9zEdnzvKhdQ3qyYmM
	 YUpgm0TQTMX3clz95KqPtHwqiYvdNaSClSZMrmuExbqzolBh340OPDoSucNiUQVNbD
	 2V16tGStNz+7fBZLVuFhKCRWpwj8A5Of9rnfwBe1iZc3xTAvH8DwM7oBgvFYOkQb/2
	 MDfFWeY69sMCrFDd5ux5F9nS4t2EI3Jr4sFlYI0vEL1MbbhylKP7hBlbnxLb8HfYPv
	 hsnYkH8CdvoG+Yw46QNTnmfSeKU3RK7RtejnUz5D9JA/aVo0/ODNC7UUo2u29CFwmq
	 ye+iL3s1Mq1FA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next 0/2] Mitigate double allocations in ioam6_iptunnel
Date: Thu, 10 Apr 2025 17:24:30 +0200
Message-Id: <20250410152432.30246-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc
issue") fixed the double allocation issue in ioam6_iptunnel. However,
since commit 92191dd10730 ("net: ipv6: fix dst ref loops in rpl, seg6
and ioam6 lwtunnels"), the fix was left incomplete. Because the cache is
now empty when the dst_entry is the same post transformation in order to
avoid a reference loop, the double reallocation is back for such cases
(e.g., inline mode) which are valid for IOAM. This patch provides a way
to detect such cases without having a reference loop in the cache, and
so to avoid the double reallocation issue for all cases again.

Justin Iurman (2):
  net: ipv6: ioam6: use consistent dst names
  net: ipv6: ioam6: fix double reallocation

 net/ipv6/ioam6_iptunnel.c | 73 +++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 18 deletions(-)

-- 
2.34.1


