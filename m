Return-Path: <netdev+bounces-145343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 527789CF225
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D92280997
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC481D434F;
	Fri, 15 Nov 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+F3bJTR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E22D1CDA14;
	Fri, 15 Nov 2024 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689568; cv=none; b=Ri5lgoSf4t5B3fmFOlmWrXipYB22VmrM14ghowrcv3U4p44pT/hDegxAcwZPJ5TgFcgP/gO/2LNPMmRox107JDJ0XfrWVyxVcL84JIEiuE7VPCuFTV3qUtxRZNHZT3GkXkzcD5HaQAIFAkgyNVfX/1w535eAp46ilzQUUBRW2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689568; c=relaxed/simple;
	bh=wJhmaIhoyc2bcieT7PTyq6TP4mqpolXYg20mo06tJQI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZrfD89iFpKfCNyZJfYJ3FuAPJVtnbinmQ1fNZJnbHOHTcV7ESDMeZXGDo/IeGFROs/UT2fD/X8AH7dvafI8BQan4CCsPD6hjUe0YUHxVid2PaHKW3MXh7/wPnMUghRsLnilyXNHZ2w7JRSiVMu0zs3EM2Sp3gVTIa8wrTW2G3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+F3bJTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790D2C4CECF;
	Fri, 15 Nov 2024 16:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731689567;
	bh=wJhmaIhoyc2bcieT7PTyq6TP4mqpolXYg20mo06tJQI=;
	h=From:Subject:Date:To:Cc:From;
	b=W+F3bJTRRbgWwty1WeFa7oLcTP2zfSkvlzIYvexs5Gt4R02n6I+wQY7P7kpSpRDPs
	 H8wivok+rtwMsJjQMNO/naLzQWf4KOfoBAPwxgjUbZUcFWmakCZohyXONJklisODEy
	 vq36kj+XLcfYtvmHp/1Q+EtbAsErAR5QoKaZ5RhwXhQozOk94zUraidpcefW5bUBqy
	 zDgWrT3WZBX1RW3OGAKkv6hhNp+0Pnb0hH0NLdiYS+6Br5cgS1WzG9rLGXIKxGRqLm
	 2k1MDghJNtrpUaGMXFaLsSqCJMggPycNYd4r1MXaZUmggVtKa3sGaJY5wIwsRIgXUy
	 NGdwJFX0midHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/2] mptcp: pm: lockless list traversal and
 cleanup
Date: Fri, 15 Nov 2024 17:52:33 +0100
Message-Id: <20241115-net-next-mptcp-pm-lockless-dump-v1-0-f4a1bcb4ca2c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFF8N2cC/zWNQQrDMAwEvxJ0rsAKNbT9SunBOEorGjvCckog5
 O8xgR7mMIfZ3cC4CBs8ug0K/8Rkzk3o0kH8hPxmlKE59K6/EpHHzLWxVkxao6ImnOb4ndgMhyU
 pBh+cY0/jje7QVrTwKOv58IR/DK99PwCQzhnHewAAAA==
X-Change-ID: 20241115-net-next-mptcp-pm-lockless-dump-a5a00e51f819
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wJhmaIhoyc2bcieT7PTyq6TP4mqpolXYg20mo06tJQI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnN3xd3ZG2hgDG8ZszYlPQIBfmCnvijUEJ4J7+5
 jIjykEb4tCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzd8XQAKCRD2t4JPQmmg
 c393EADbO7Khhkxkg0Y+85y2WBNlH2mo5Jm9fSbd8aeV/lsOx1qYvrWvev5AJ/HH6gfalUhiqKC
 TeBrxPEsgn/h9obWTjtwzh1sLiKvzPoQ+ZPg44fKiUDWvBAFqS2L0KmMXrxjHCjntB9JYIeYpLP
 7Lvr/DKu7OPQca2GTXtt6Fu8xNPf952Q4KYLCctuEnuhckTs/OgFQXgs1n2dRvfn+nnT4y+8ryq
 bXhj7voYOF+k7rE5L4ju3YdenmJldCXE4qUMY0hJdF7ezITWbTf4fgSfbIHSlUbjHQoe4Ep/8ni
 QOsjmHl+OjjFRb+tyMF6QqusG/6MdQde6SKa6Vyr+ET+8FoJ13TnNUgI1GJERB/AjupoASt70W9
 gx/dOihdDfoccnk8t9IYQ/w5lwvAM0AWlw6UL/8uQ8KAUUvdj1a75bgnrF+GVa+Ypkwpa2BslaX
 SAF/1owaMQ6nJH8DZGtTWFkXdx1JUb3132GMnNgmdtz9xY7I/IVZjJOlK/fPp4PzH9SKLjedo6o
 EfmtQV7UC/6h2H6vv5zLT6zq/gMwOTt0tt6RUS+neLlAscDAaGEGXXybB7Dsw071Kk5vR0jPFBV
 8A2RqQW8bzW9byznuXqlzuv66fyaotQ/TMspNa2yPXGEmFQk9+Wfh2NPrzWxFxP7p8BlmDowCdI
 5Q1e8Uh6nEsjvDQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are two patches improving the MPTCP in-kernel path-manager.

- Patch 1: the get and dump endpoints operations are iterating over the
  endpoints list in a lockless way.

- Patch 2: reduce the code duplication to lookup an endpoint.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      mptcp: pm: avoid code duplication to lookup endp

Matthieu Baerts (NGI0) (1):
      mptcp: pm: lockless list traversal to dump endp

 net/mptcp/pm_netlink.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)
---
base-commit: dfc14664794a4706e0c2186a0c082386e6b14c4d
change-id: 20241115-net-next-mptcp-pm-lockless-dump-a5a00e51f819

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


