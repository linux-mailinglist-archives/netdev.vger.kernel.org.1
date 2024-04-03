Return-Path: <netdev+bounces-84523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334CE89725A
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E148928265B
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F303149003;
	Wed,  3 Apr 2024 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b="UGNWO+bS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out.a16n.net (smtp-out.a16n.net [87.98.181.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108AD149DFB
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154063; cv=none; b=Ckz4TuE6UrgTjOh86OKdpP+pKOHWkNW4gIuyy63wLa3uK2H11R8/aORSAR4xuPEFoPqxK38VRstPJHaUsb2EvjVU8WKEJYW6hPbo+oDaosx8RBw/4Npkoe9IKYvmLcBc2zMVAboOlFK86uRDmg2+koLSk8U/dhj+GX/WuBhunic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154063; c=relaxed/simple;
	bh=dVtAU9h1i9ihRnJeOBKBIcG3kebK46zuzX1tnRRUXXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rj7mytsNFb1IUb39ICydeJQ78uDWlsREipU8Vl6uRGiTG+A1kJiTTfDVrCW6atH5Jg1sevCqlZPffXhs5rW6Kut6HQaaUkc667pJTsYhAAmi39UqHfTCCJ85UGf/kyOH65OX7hd0wvjgwzo22EfwOczNcX1zO2QICCM/Xc0y5jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net; spf=pass smtp.mailfrom=a16n.net; dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b=UGNWO+bS; arc=none smtp.client-ip=87.98.181.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a16n.net
Received: from server.a16n.net (ml.a16n.net [82.65.98.121])
	by smtp-out.a16n.net (Postfix) with ESMTP id 6DCCC46058A;
	Wed,  3 Apr 2024 16:13:54 +0200 (CEST)
Received: from ws.localdomain (unknown [192.168.13.254])
	by server.a16n.net (Postfix) with ESMTPSA id 48B7C80117F;
	Wed,  3 Apr 2024 16:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=a16n.net; s=a16n;
	t=1712153634; bh=c7ZcKP8ocOHZtyOn2z5vV0iUsyKxwqGoswRgtIl9b88=;
	h=From:To:Cc:Subject:Date;
	b=UGNWO+bShI8Moi5vz12Ks2XqZ4GwA3pjuqVSt8gfuGV4yuvXNx1cglYPz8dfjKP7+
	 5Dl6ouOGzt8ImFPH5405fSxnI7L/gA4yWys4eGfIcXjwt2Tl8T36IUc7hgYJJa/Vq6
	 sq5u2v+k2tJam3dSL6BjtHwMRkCztwqz8t0uUTpksnjypZdj1s1DF+OFsYLKEMl0HL
	 +sZyiGSlBnwycF5Te4omKXrPz3cBnDyfW3cKWd0SkQ7fxk7XKD334CURZWQow8IU4r
	 V5/GgR3eT+FtoS62IOmMl4mvTWDVT+F8rAJZs5SZ8eISlVKTzHizR8g9yDnpdqB8Lc
	 7CuA1/C9b4IgQ==
Received: by ws.localdomain (Postfix, from userid 1000)
	id 2B7A920671; Wed,  3 Apr 2024 16:13:54 +0200 (CEST)
From: =?utf-8?Q?Peter_M=C3=BCnster?= <pm@a16n.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org
Subject: kernel panic with b44 and netifd
Date: Wed, 03 Apr 2024 16:13:54 +0200
Message-ID: <878r1ufs9p.fsf@a16n.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Unfortunately linux-5.15.153 crashes on my router when netifd is
running.

Further information and a patch are here:
https://github.com/openwrt/openwrt/issues/13789#issuecomment-1944799389

Could you please fix b44.c in linux-5.15?

Thanks in advance for your efforts. Kind regards,
-- 
           Peter

