Return-Path: <netdev+bounces-154448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E7A9FDED3
	for <lists+netdev@lfdr.de>; Sun, 29 Dec 2024 13:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB233A17F2
	for <lists+netdev@lfdr.de>; Sun, 29 Dec 2024 12:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79C1E521;
	Sun, 29 Dec 2024 12:38:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.icdsoft.com (us.icdsoft.com [192.252.146.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C46259482
	for <netdev@vger.kernel.org>; Sun, 29 Dec 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.252.146.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735475894; cv=none; b=CP1dRpOgBB59Febz9qqq5h5l4PFTEZdC35UuJ3YTL7+gP+T9qmy9PFKy/BhU4Ku2EvO4FCMvmsyALV+1zSf1pl2tqeWIwgmNwpJ0Q+GAvlI993xyx+3JvDj+FH9+QJcsnDy/Gm+8tNJkbDoUkQJ2pH52bweTDrBtbvFsvLt5Xxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735475894; c=relaxed/simple;
	bh=ZiOAyDZSI/hRqm5Qjqd3a8iMvKP2Tf+81RX/lKR4Czg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=jfVPE/8xZxAnLlISW4DJAKtdfjhKGjOZV9sudtbeMC0jVi21bPhtRKpR4OQKCiu9wZArOXJ0n9BCelqejh9lNO2LdcbwKyIj1YznMq1qExbFbmZGrgqKY+JXm5HT0oOB5nezeUDL4PgSKp33rvbVLQa/pjCWhG/KI9nhXhfDDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icdsoft.com; spf=pass smtp.mailfrom=icdsoft.com; arc=none smtp.client-ip=192.252.146.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icdsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icdsoft.com
Received: (qmail 4446 invoked by uid 1001); 29 Dec 2024 12:31:28 -0000
Received: from unknown (HELO ?94.155.37.179?) (zimage@icdsoft.com@94.155.37.179)
  by us.icdsoft.com with ESMTPA; 29 Dec 2024 12:31:28 -0000
Message-ID: <e831515a-3756-40f6-a254-0f075e19996f@icdsoft.com>
Date: Sun, 29 Dec 2024 14:31:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Teodor Milkov <zimage@icdsoft.com>
Subject: Download throttling with kernel 6.6 (in KVM guests)
Organization: ICDSoft Ltd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

We've encountered a regression affecting downloads in KVM guests after 
upgrading to Linux kernel 6.6. The issue is not present in kernel 5.15 
or the stock Debian 6.6 kernel on hosts (not guests) but manifests 
consistently in kernels 6.6 and later, including 6.6.58 and even 6.13-rc.

Steps to Reproduce:
1. Perform multiple sequential downloads, perhaps on a link with higher 
BDP (USA -> EU 120ms in our case).
2. Look at download speeds in scenarios with varying sleep intervals 
between the downloads.

Observations:
- Kernel 5.15: Reaches maximum throughput (~23 MB/s) consistently.
- Kernel 6.6:
   - The first download achieves maximum throughput (~23 MB/s).
   - Subsequent downloads are throttled to ~16 MB/s unless a sleep 
interval ≥ 0.3 seconds is introduced between them.

Reproducer Script:
for _ in 1 2; do  curl http://example.com/1000MB.bin --max-time 8 -o 
/dev/null -w '(%{speed_download} B/s)\n'; sleep 0.1   ;done


Tried various sysctl settings, changing qdiscs, tcp congestion algo 
(e.g. from bbr to cubic), but the problem persists.

git bisect traced the regression to commit dfa2f0483360 ("tcp: get rid 
of sysctl_tcp_adv_win_scale"). While a similar issue described by 
Netflix in 
https://netflixtechblog.com/investigation-of-a-cross-regional-network-performance-issue-422d6218fdf1 
and was supposedly fixed in kernels 6.6.33 and 6.10, the problem remains 
in 6.6.58 and even 6.13-rc for our case.

Could this behavior be a side effect of `tcp_adv_win_scale` removal, or 
is it indicative of something else?

We would appreciate any insights or guidance how to further investigate 
this regression.

Best regards!


