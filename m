Return-Path: <netdev+bounces-28163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B4C77E6BE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 18:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E15A281BC1
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D61174D0;
	Wed, 16 Aug 2023 16:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0314281
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 16:40:23 +0000 (UTC)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46563271F
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:40:21 -0700 (PDT)
Received: from kero.packetmixer.de (p200300FA272a67000Bb2D6DcAf57d46E.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 64368FB5B0;
	Wed, 16 Aug 2023 18:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692203600; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=m1w6FoGMV+sfhD7tg4nzP8v3sE5qiFtEwg083Tmb81U=;
	b=F3hUDqEbmJekyGRawjrUDrekktiIIGEiZO6ZqsP4F/8/5U4J5dyFVnlioGi3/wGXPzjzgF
	OR2SUHwjZcGvyWslqMh78BrrJUwRZMrCIRJCJ/A8dSU8cdLkWdNTC5Qo9yuadLRGKgEnth
	b1K+qzmZYSN6JYTdckO0eSgcn5yy023JSAz+aNqD+a/CFfNRYYNYXgrOKaOe5QFwvJak7H
	DEpE3Jh6fQo3gPS7ZT9MnpeNCumRCc7QQIc7ak/3hBrF9w151B/bMOYH7bJZjF7YoEToSV
	EVLt8GFuaOXMkFbbHrA9btUS4NOC3r9vo8J8BC0tRP3tIbdFQvZcw14An+xkMg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/5] pull request for net: batman-adv 2023-08-16
Date: Wed, 16 Aug 2023 18:33:13 +0200
Message-Id: <20230816163318.189996-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692203600;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=m1w6FoGMV+sfhD7tg4nzP8v3sE5qiFtEwg083Tmb81U=;
	b=w5zzxd2iYrgIPHMMWMgNsHPeyKEvPUrotjdrBAta2yBKE6sSzjtLbrjYlDLDs/BAl40U8I
	orVg+3+SL2m2/rpRqQkdEx3u9wEm+Mmk09Z92g6SIcQfSAOZsFfByMv8tGqoMfKJsNZ0ZY
	Iz2F0NltGKXXy0KED36TUEbn3R3gkeEBUvJvCPukc1KOpQjARrovFykxk757udt0nVr8qB
	9bWiLyCBXznHQMYUi0nXeZJWFfZHBAgzDmFrGWblH6O8C3MNBD5gvrJvqulSy3ATCP0+tq
	BiUFxxZc2nyT7iPziZNqnPdmPLDpdHIh66UDRSEWARwNU+IZa+WCwkUI0Mba2A==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692203600; a=rsa-sha256;
	cv=none;
	b=hi9As+oKAsM71PgOCV5+aZUmKgvQPNgiAe34JsFGZQ1zGoxISTlDI8Yn/CZAsVOMGSja8JQsPEMwFU6AZ3TdgagsoC485sq/0/dp87RH7mp0gze1JcNe0AdtXVTMJwaWNC3XGXUqXJGM7xM5EiyQpmekwsJixO6pPW8L1BysXvHjZuM3I6Or5Dno+V7460CSBK3riYxAyzs5k9PMUkbsKCSRxUHDzdLQ9sOMEX+Lxib4Vy6k359X7nAp+wfx2tSFuh9BJP7EJFD2Z18hJ9i7t2Pkh8bKHhqFoAOQ0RA1VWABfTcLrQczgXUdyKKB9Z4C7igbm3LWRoDTIA08w5HsSA==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David, hi Jakub,

here are a few bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20230816

for you to fetch changes up to 421d467dc2d483175bad4fb76a31b9e5a3d744cf:

  batman-adv: Fix batadv_v_ogm_aggr_send memory leak (2023-08-09 17:33:03 +0200)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Fix issues with adjusted MTUs (2 patches), by Sven Eckelmann

 - Fix header access for memory reallocation case, by Remi Pommarel

 - Fix two memory leaks (2 patches), by Remi Pommarel

----------------------------------------------------------------
Remi Pommarel (3):
      batman-adv: Do not get eth header before batadv_check_management_packet
      batman-adv: Fix TT global entry leak when client roamed back
      batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Sven Eckelmann (2):
      batman-adv: Trigger events for auto adjusted MTU
      batman-adv: Don't increase MTU when set by user

 net/batman-adv/bat_v_elp.c         |  3 ++-
 net/batman-adv/bat_v_ogm.c         |  7 +++++--
 net/batman-adv/hard-interface.c    | 14 +++++++++++++-
 net/batman-adv/soft-interface.c    |  3 +++
 net/batman-adv/translation-table.c |  1 -
 net/batman-adv/types.h             |  6 ++++++
 6 files changed, 29 insertions(+), 5 deletions(-)

