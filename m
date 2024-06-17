Return-Path: <netdev+bounces-104102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480E490B384
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D516C28131D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46965153837;
	Mon, 17 Jun 2024 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFuD534R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220F714EC72
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634294; cv=none; b=UvqB6AAODDMQYuoljPwssgAg5ngTBfk59Ql3wccBnLIe2NnWsLU08YNpsTjv2YzirG/lFUqWDaXqn/rgtXXe8QnQ/CoBpixnuCZE4r4dIcWLEA2oji7SzWSMb/SwCCMlueS1vY48S3jRczxXOVDWr25TyHdseChVnKa5VfAWLNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634294; c=relaxed/simple;
	bh=o0jmL4lN3J7WcxsfmcWqBypOmq6/diHZGC3tFuZQ4S4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JX7acISRAuedZLK6Cqv7FdHzl2Qp4x/mSaww28qynVj8yZUuVh9dNjfAvRRywDEEzbN+PtIZch3O2RGAtKGgQbJtn3Ufa4dFDhqrBHU/5NB7zKFQrf3X9kmzeIZb/iXvRXjP+GXE0dCg4ZZ7m/xFQcSxfEw37Lq6zmIATSAU/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFuD534R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F242C2BD10;
	Mon, 17 Jun 2024 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718634293;
	bh=o0jmL4lN3J7WcxsfmcWqBypOmq6/diHZGC3tFuZQ4S4=;
	h=Date:From:To:Cc:Subject:From;
	b=LFuD534RnVnYTWP1X9I3zrdn8XlOQZOonkkD/rpdrIMi6BV7CGIxn7Ap0bfzupEEj
	 WbX6wiMv4tv76pfM5Ql8LpJLiombSPEowixAjohr5Nmx+alyF9ui14Mb4o5rzcH+SZ
	 s1Bda+/G8Vy8HXQ6vEMgJeYsiT3Hep8SePDW8VMwU3oHYszoueCDG7diemXYgz6TuF
	 EYOgwwCOngJAf6aiO9km/r1QFn+KppUsktdovfjY3t85DiikRi2QLHcQpaiWjJp2z8
	 7YqAgEqFegemOTjQ5lIXKdL/7MZUU+qs0J08ZagtfMiXT0SsqtQ/g9fxtyM5o/F4XY
	 Sn5UJKmoiOl6w==
Date: Mon, 17 Jun 2024 07:24:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [TEST] TCP MD5 vs kmemleak
Message-ID: <20240617072451.1403e1d2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Dmitry!

We added kmemleak checks to the selftest runners, TCP AO/MD5 tests seem
to trip it:

https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/643761/4-unsigned-md5-ipv6/stdout

Could you take a look? kmemleak is not infallible, it could be a false
positive.

