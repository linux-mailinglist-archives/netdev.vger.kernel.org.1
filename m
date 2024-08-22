Return-Path: <netdev+bounces-121079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE9695B941
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 17:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF9DB2880D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B431CC89F;
	Thu, 22 Aug 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="OprhzNuL"
X-Original-To: netdev@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0EE1CC88D
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338875; cv=none; b=ZSTb2tsMkCXQUKKWnY+qlKGWjlB3kqp+lg8cmKvDD7glVhYEbg/iPaVvpwjsSpb7W25LPYRXlxl2y2zd7bkxo/poevydN+esNroexNJ+48oif1WWjcGTXYcfLCv0QfLftFrqxJUVSxVcmlMNoPp1YzsYiKiSBX9Dlk2ugySrecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338875; c=relaxed/simple;
	bh=znHPXVQUQaPGu7v7UYm34EibjsqpZB+F71eqdtueIH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9fcT3mXS8hoV3cVZh/iFl4QG43kPN8nPEmfqSCGruambplwj1nIWLuGIwwfibM44nNzEBj/qMMrE70BBuWj+Q6Btp32BcvFu4bcnOLju1pCre98ANHPlVBGYqTQ72l269kXRgN3LsXrE5blXfnvbQGcIE1U2V54aTXd0hA9kwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=OprhzNuL; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-67.bstnma.fios.verizon.net [173.48.112.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47MF0Mmd022375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 11:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724338827; bh=t18gtYxklKYa0rJY7RSL7YSQJKA9/wN+2NyFSJPFoxU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=OprhzNuLBbXTcYcn91CAIAUjb4Jb/s0CqItLgL4SGj9Ufifjv4uCF0IbqpYCi05+C
	 KkCTLf3guoR2t2mHnMaUVUMiFojToxTCYZ65Zs45I/82H5fkd8gKGlu8REJwrFzieJ
	 Cv9hu9kLyoIyePGgJrIp/GOyv0fq7j5qvDD/EKZ5FGaiIteqNouU1N6xyFlD8P34W/
	 WCTEjOJ1L4eMx1LIGuW4ufDhHA+JwhICT5V1CQfrnhZ1grXSrJ7B0XzK5CDJqnFyYm
	 MkjqtJrnY2zWZ42jUX76TcwkpU6bdZUeDg7qUochXApMvMiLpVZAJl5iapEoyqmeUz
	 tDbe7L2wX706g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E0B3115C02C2; Thu, 22 Aug 2024 11:00:21 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: krisman@suse.de, Lizhi Xu <lizhi.xu@windriver.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        coreteam@netfilter.org, davem@davemloft.net, ebiggers@kernel.org,
        fw@strlen.de, jaegeuk@kernel.org, kadlec@netfilter.org,
        kuba@kernel.org, linux-ext4@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, llvm@lists.linux.dev, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        pablo@netfilter.org,
        syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V6] fs/ext4: Filesystem without casefold feature cannot be mounted with spihash
Date: Thu, 22 Aug 2024 11:00:11 -0400
Message-ID: <172433877724.370733.16770771071139702263.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605012335.44086-1-lizhi.xu@windriver.com>
References: <87le3kle87.fsf@mailhost.krisman.be> <20240605012335.44086-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 05 Jun 2024 09:23:35 +0800, Lizhi Xu wrote:
> When mounting the ext4 filesystem, if the default hash version is set to
> DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.
> 
> 

Applied, thanks!

[1/1] fs/ext4: Filesystem without casefold feature cannot be mounted with spihash
      commit: 985b67cd86392310d9e9326de941c22fc9340eec

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

