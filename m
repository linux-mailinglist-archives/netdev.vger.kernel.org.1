Return-Path: <netdev+bounces-117189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EB794D06D
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320C41F21AC9
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D75192B99;
	Fri,  9 Aug 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="o8aH7Er+"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F91E49B;
	Fri,  9 Aug 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207533; cv=none; b=HrabvyTdSar32tCZFh0ujdW9O7GqiwqYJtL5j46CKxj/iogENNUWhHxHjjwdYX+vfpUGcgKMJIXuwNkgmOzXJsZhCqUZcFuB+Xj6eQcKmiK6pQnm2xXEnsUG8BWycz7jAeZPsWKZnT4pO9c03F+8J8WZ0wKjJ2K814AR1dj3AA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207533; c=relaxed/simple;
	bh=k8Y6IdSC1c6L9mCKG4YcpPi4RtYeUxeB5vvQv2bbOhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fEtlzl15ncp4t/7ONMYbyTdlaJUt0xVLtJA/4vUDEUGXrVfBfguTxcu1JhZG0Panr2/Ew6r75UnsFD/p1FNVyTmyItrOXuRNepoyKRmpBf4l3Lkb5pUMYZPYWSDT31Y5oIRNl5JhB/ZGOXlGjcnWIrKRqw3Mrt9ZUI4UTMoxt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=o8aH7Er+; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 6B506200BE5F;
	Fri,  9 Aug 2024 14:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 6B506200BE5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723207171;
	bh=XpwIqo1AiVwWFE4S3CUBFjvGb9oc0dEp4/MZI+58/fw=;
	h=From:To:Cc:Subject:Date:From;
	b=o8aH7Er+lz65rUpRfijCaDQxro4CIJs90dZdJYs8YAsrlXrZLK+Crm6oYlFCADeO8
	 9EI6GgfEQxTc4qluUUGOOBT5GOPOI03nXVcH3+rerzypMW6fonVWYLncj5D2EG/cMR
	 jSmh1CdrXuApKy5Gv0J4vnPUyX9euLc4ZqzFmWEwhgt5Zkt37geDFer+EbEr6zBKBC
	 L/12CLOqdXoTBTCcdtkaGP50xWirn22VjRkftF7xE6p85mR4IuuVZEhCK5j2v4fj9t
	 GYgcGFjFPQsf4ZeB4MM6LO+cyqLw6i4n2QOIjiL+Tge0HAcpyqg5MJTL9JtKh+1n3x
	 apsGey7T3drMQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next 0/2] net: ipv6: ioam6: introduce tunsrc
Date: Fri,  9 Aug 2024 14:39:13 +0200
Message-Id: <20240809123915.27812-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces a new feature called "tunsrc" (just like seg6
already does).

Justin Iurman (2):
  net: ipv6: ioam6: code alignment
  net: ipv6: ioam6: new feature tunsrc

 include/uapi/linux/ioam6_iptunnel.h |  7 ++++
 net/ipv6/ioam6_iptunnel.c           | 57 +++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 8 deletions(-)

-- 
2.34.1


