Return-Path: <netdev+bounces-97134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE808C94D1
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 15:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DD31F21072
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B87A482CA;
	Sun, 19 May 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IdsTF9pq"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851131870;
	Sun, 19 May 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716126191; cv=none; b=ZEoQ2mRkfE0dwQQXhjXZHrZ6WL7yVxhdqnoNLRS2XsBV76jplEfRAWLIo6qlJaVxG0WbESeUTv3m4jO0gbIuGywNPQmfbeAqa+VR7FjtIlHOxn94P3a1aL1wXaQ2wRG9VbfRuu8ILvOPtx2foHWH1Z9T+AaF094eJizl3p6tU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716126191; c=relaxed/simple;
	bh=+Y1Lzo8WeJB7AApMCPC70VYGtLccrUJHK9AHQKDkz+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HAUBb7qqPnGe46Nbb1qPwC8q51uQwXRFUVJEe6ZTY5D/yKQijYcCuugg/0TX07jk/w3cZL+qRl7hBkohprT3R/AD+L0CP4+RDKUO67xXT3+dC4krbKeaKBOYDl4dAvUIM3jD4eaJ3+VdjK9LKZnSqUZ/3Wujg0O5IaJUWIGYt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=IdsTF9pq; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3D7534078529;
	Sun, 19 May 2024 13:43:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3D7534078529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1716126184;
	bh=+Y1Lzo8WeJB7AApMCPC70VYGtLccrUJHK9AHQKDkz+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IdsTF9pqJRjR6WqoBvb5KUuADrhTzG2jHCe3OjCsV+JpSfzXj44V7asG91b2Qouh4
	 MECgAxzxICwcxl3pfXE8wyx6CQ9kFsKFIrPq6Yaa+BmNEuzT7upR2xc0PI8+rA6LJs
	 nVv3iORfo1WSO8EOg3zgmq1b61G0N7KHuFoeAsrI=
Date: Sun, 19 May 2024 16:42:56 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: syzbot+25f4f05818dda7aabaea@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [openvswitch?] KASAN: slab-use-after-free Read in
 ovs_ct_exit
Message-ID: <20240519-7d869ad336bb2786efd83be1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000c1783b0614ab5634@google.com>

Addressed by commit 5ea7b72d4fac ("net: openvswitch: Fix Use-After-Free in
ovs_ct_exit").

#syz fix: net: openvswitch: Fix Use-After-Free in ovs_ct_exit

