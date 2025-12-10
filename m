Return-Path: <netdev+bounces-244241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08654CB2BED
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 11:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACDEE3009850
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E65632254E;
	Wed, 10 Dec 2025 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="o7lYL8/e"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA131A54E;
	Wed, 10 Dec 2025 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364031; cv=none; b=nWO35rRGhB/LIrCly+X+eQq85RL2G3Z5SknFROZIgw2TtyiebN8TI3AhIrG8otKJy1vtK/4U/l3cuGmje6wFSf7KyT30Pz25p58m51BZAE968Z/7MxygP4+f4JHBZDYYEQs/SzFvsSEFpuHdtqbZ+YaCsi92k4CZC8gREwSwWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364031; c=relaxed/simple;
	bh=+1nJAk1jtIExL/iO8VDBTCY/I8bCl+lQCbq0fh2zbKk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=T0sayJmy3AtKZGlk6CKjv/zfZ86jkTLsl2tyt93gi/Jm4kO5A1PwzVIkau/3Je+bKl36mHRCHZNVFrv9wUKuG7ZkqZD5xi7bOeLZAE1nfkAWg56HyhZBOpFClQN07Y2y3mNP9rYAtwXDxaGO+FyY14xuXBeKdyKTTzh0YwrAh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=o7lYL8/e; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1765364009; bh=kPXz6r+k9D2wVXIeVeJFfn0NFGNFryyJSK1xKLgc7OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o7lYL8/eHMKmDYVDiY3efarlu+2is1Ey0J/+NstIaqug4RUujc5Firv26O/rdPDAj
	 7xvnOfrnb0uOnLa0LynDk0xlxdxpT56AGZL52U8Pis4Hj1okKqkrxk/Lhe/4Fhf/uM
	 Hz8vCQVktzzUv6qw+BAcoPZc+ZozcU79VUBaID0o=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id C823C2D9; Wed, 10 Dec 2025 18:50:02 +0800
X-QQ-mid: xmsmtpt1765363802t1p8wn3d4
Message-ID: <tencent_4312D7064DC99FEEF62ED1CC8827F946E806@qq.com>
X-QQ-XMAILINFO: MIbv1O9N9h62+FYtff+vDOdkQSbgo0K9X1WPuCyQQY5M6nCmtF6IqjyVQKI5Sq
	 AXNwi8hVzaIt/a8wBvTYN0XnTVd9Nv7txLrW3mCctO4g+zvZLabeNVdbKg9nfjkkxMLjmPY256wc
	 +OIbvGOS3vudJduloXfmULJLx8I8MCkv9owNBckonIJySgUNgHoGHwA01E7oiAAwGVu11dkm9TV5
	 p/CcU4Ld5JjXWkvn4BhFSTzoD/89rIImNAfquZwgxM3mP4SPksunfnqIaknQwrlcD38S6OnFAeXw
	 vnVR2kWdRRm8b9c4sO6IKvSQYc9sAzoLn+rLn786cqmtKYCLhCBzSkplAaoyxpJLr7JfbBwOCoLc
	 jqJDbpgWe07mhPhuTEKy3SJ9jT41zern9m1//K3z/b8Xhr/2lR4z6ryISq7lzczVcFKVM3bIA+eK
	 ylBvG2s/Nx1R37otfV2dUtWZC+HYfqzchdONSu24Px5uhdYiBbDWpmx3Q6VgahjmYZ21MpI7QmjR
	 ual9xUzDrrFwBgjVa17xbkjyPWLnwenK4+H/l5VFKBD2kH3Q5PvA3OLRYY0HP3vCM8vVNbzBmav0
	 1/e2iCN0UnUHjRHa+BwCt+J77iUUyqyWffdMr1obxRCheBsFtRe54Otjj4hWo4z6T8CWs5UDj4Ct
	 W2tCm7zTFC5ra+ApKbr2yKQnOStvd8oQ4eud9BNkDPcKZKcj21yLE8e+ymhId/ZxmUh5Gd2TVxpK
	 5iyAmA0gbWNFBMBOWO39kTwaRCHf7xw4sTSHj5UEkyQ0Yq0eKSVSnn55izfKQEMpUK9Afkb3JsEw
	 BYMTRkL4ti0STdl3BmJY+P/657kxH56EEuSexeAa4ZETRas1EF7CWndafIGvqytmXqZ666Z9EaGA
	 /IRU5rwiMl1lJfz8DEkq/Qc/mNC75ey8mc+YJ+PYwZh4cnfqyZj1tc/axcGTesBcW0t0uZhd7bmB
	 YrJnEkg+Fu9zwCGPIjGtychujTwKyP5SPXybP1pVRqiQqovS2h/b//iQCIxxnbvf9GVKjrwEuwjZ
	 3Et01MCS8V39iKmRCM0wQbKqovhYEskic8OyBigA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net v3] net: atm: implement pre_send to check input before sending
Date: Wed, 10 Dec 2025 18:50:02 +0800
X-OQ-MSGID: <20251210105001.15542-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aTlMBiGNH7ZChSit@horms.kernel.org>
References: <aTlMBiGNH7ZChSit@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sun, Wed, 10 Dec 2025 10:31:34 +0000, Simon Horman wrote:
> > syzbot found an uninitialized targetless variable. The user-provided
> > data was only 28 bytes long, but initializing targetless requires at
> > least 44 bytes. This discrepancy ultimately led to the uninitialized
> > variable access issue reported by syzbot [1].
> >
> > Besides the issues reported by syzbot regarding targetless messages
> > [1], similar problems exist in other types of messages as well. We will
> > uniformly add input data checks to pre_send to prevent uninitialized
> > issues from recurring.
> >
> > Additionally, for cases where sizeoftlvs is greater than 0, the skb
> > requires more memory, and this will also be checked.
> >
> > [1]
> > BUG: KMSAN: uninit-value in lec_arp_update net/atm/lec.c:1845 [inline]
> >  lec_arp_update net/atm/lec.c:1845 [inline]
> >  lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
> >  vcc_sendmsg+0x1052/0x1190 net/atm/common.c:650
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> > v3:
> >   - update coding style and practices
> > v2: https://lore.kernel.org/all/tencent_E83074AB763967783C9D36949674363C4A09@qq.com/
> >   - update subject and comments for pre_send
> > v1: https://lore.kernel.org/all/tencent_B31D1B432549BA28BB5633CB9E2C1B124B08@qq.com
> 
> FTR, a similar patch has been posted by Dharanitharan (CCed)
Didn't you check the dates? I released the third version of the patch
on December 4th (the first version was on November 28th), while this
person above released their first version of the patch on December 7th.
Their patch is far too similar to mine!


