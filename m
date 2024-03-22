Return-Path: <netdev+bounces-81205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D138868B9
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797AD1C2230B
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3941863B;
	Fri, 22 Mar 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="QqZlFcYI"
X-Original-To: netdev@vger.kernel.org
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11BD20DDC
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098043; cv=none; b=VzzSp5hyeG3DjRJ6VmGhm8BYBZUVTQO7UM3p2GmSQHnmUrnZIWh9mYx5+tE6zlThxAUua0BjuSYmz18OxiNf0k5FLU3CfdojIMWVtXs1C32naxz/1T0ByJA7WpJ6/FIzfxagbuTgB1qeSvlnSDDctRyygp40FIkH0vBI4wWjnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098043; c=relaxed/simple;
	bh=qiVluYvnB0Gya5Wnps/6CNKO3AxC4EYDkPeNrmdL3rk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KeuKgkS9lofG8+R+SZYAzhyGH762tB0EQ9FmcV0W77zq6LZPcy7A7ZpAP1VdcgqgwUmpossITbjVqoTS04BWP3BMkOH2IhNmf4OsvPROVvtyviN3nX/j71FpyjtxjIMjX1TVSq32peRURHtUxAcgwruUXzhQMkEdzxtlf+r1O8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=QqZlFcYI; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c27:19c8:0:640:13a7:0])
	by forward101c.mail.yandex.net (Yandex) with ESMTPS id 70F4A60A9D
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:00:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Z0DkNk8OoW20-8gqjWukr;
	Fri, 22 Mar 2024 12:00:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1711098036; bh=f2yfUDW+88tbJDWtLFfL4vK04nnQUiNhqjfcAQJtxVw=;
	h=Reply-To:Message-ID:Subject:To:From:Date;
	b=QqZlFcYIrheCUinudnzzzI5OxEbt9aiS9NPCRIhSLx0wUGH+cnnt3Y2VronVih9Bs
	 LjgQphtxyr1DP1Ut29nHo2Bud+WeUq5EMsw7KNIJ+5lHFMFBQzuaGkzrjRBHYEU/YG
	 ecsxVzWUWyYMX8Wn7dqmjeLloE5B0F6mrsL+/aP8=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Date: Fri, 22 Mar 2024 12:00:45 +0300
From: Oleg <lego12239@yandex.ru>
To: netdev@vger.kernel.org
Subject: SIOCGIFHWADDR for wireless returns ARPHRD_ETHER
Message-ID: <Zf1IvSo3LzmsumHr@legohost>
Reply-To: Oleg <lego12239@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi, all.

We found that SIOCGIFHWADDR ioctl call for wireless device returns ARPHRD_ETHER
instead of ARPHRD_IEEE80211 in ifr_hwaddr.sa_family. Is this normal?

Thanks.

-- 
Олег Неманов (Oleg Nemanov)

