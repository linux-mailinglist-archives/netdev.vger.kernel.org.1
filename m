Return-Path: <netdev+bounces-81845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EB088B44F
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268331C3DDDA
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F335480612;
	Mon, 25 Mar 2024 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PNlfbDQE"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734B7F7E5
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406353; cv=none; b=JywHZZaD7mHEgDzNecs1/0TnpVaSdTpAFAR97eUZ5YBNCqzKeZs4/Ts0N37HrJpnMcQM5BcTiyhJPubp4p6Y7jKDwTp2mUnYZ6GbV55cwPPiBPia4+FnrEAhmehiIGYkwkbi89I+kmJ4npd+qRF3a5K8uJDSjffNrVhv06wvsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406353; c=relaxed/simple;
	bh=i0I/hok0H+uY5gnUiJjjMFYCqMDwvW7d0m9L7VM/mVo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uz3HdSJ7JTk6kosNgyaSys5+abpSNnj72wCYjO7nuoX/gJe4vyVW/HCh8YgJyTLW/HJr4/6tCPmYSyoyEa9qlwcEvQ7klShRBGIhZUrKr/hDs9RYrd2chSoExelDnWiwEQhy6On5SHC+2B2iaRp1l23TU3ccpvRU0Y1JMqi2f38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PNlfbDQE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=TSXJRpNiWth9BiUk+GIw4euhlM8CyD3+2Pi6Xz0mV7Y=; t=1711406351; x=1712615951; 
	b=PNlfbDQELrfxPKX+d9J0VH8t7xWBnOgIHJoC7ABwJJQq+AJAmWiNsoPe05s4yj2ZQHsKI9rFApr
	LXN81XL/ZM7RenlYXYW0CCbbLru/J6wDy1KyyLp/O6ghVV3vANYNdUrRpAV5JK5a/XrCDSj7yZnnO
	hIw+krnmz94Gt+ya+fVJSsyA6qPQP/1aV+U5Xcl/Hhy1zMn97qPV0ap7/4OoRcKfFUBJGrxnE1Ltd
	9rmxlo4NsRVCAI8hlFmUsct6c9LgBeInrwGcYXUXOA+CRjBvkUTM9MOyAaC03uNTvjVMaIZD3hxDQ
	Co0B4L9UkwlDHSmpND+squI4e02x34wjQSRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rosyC-0000000Ee2Q-1487
	for netdev@vger.kernel.org;
	Mon, 25 Mar 2024 23:39:08 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Subject: [PATCH 0/3] using guard/__free in networking
Date: Mon, 25 Mar 2024 23:31:25 +0100
Message-ID: <20240325223905.100979-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So I started playing with this for wifi, and overall that
does look pretty nice, but it's a bit weird if we can do

  guard(wiphy)(&rdev->wiphy);

or so, but still have to manually handle the RTNL in the
same code.

Hence these patches. The third one is a bit more RFC than
the others, I guess. It's also not tested, I'm not sure I
even know how to hit all the BPF parts.

johannes


