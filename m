Return-Path: <netdev+bounces-123638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AE2965F1E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9971F27085
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 10:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569CE183CDF;
	Fri, 30 Aug 2024 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="kvcST/Ai"
X-Original-To: netdev@vger.kernel.org
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378F184555
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013603; cv=none; b=neiz7CjbyiF5PYG2CBYnoKymC6OePBxnqlH8y2THH+yGvbU0rXEwtVSy0Uq/sWwS0Iz1vrkv70hIuIFL0r9EcDzUOvkhJ8L0qiSxoGpS5jXiDVZSea1uMlY3Bl256r2KNUbROUhyAVv/pujDN2MmNCuvUGGMoDP0v/7wS6X3aq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013603; c=relaxed/simple;
	bh=psvNxcokM36AAT0wrzDWuJlZYR+CdS7AobzGcXZjoqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H6HurbkjTbF2hOt8w5+Kj+qlKAJF5HjD08xC43v1bfkzbBsFafdpHSF078kVNf0yuLwWeyryBNpxjEhZmN2d431+vM5wKC6fyECCz9IcisZZhkRQ1ssuh9Dsbw6njRstLL2/uIB/2OOHn1o7pmdUyAXxVZ6QPuaXhg8ziObW16w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=kvcST/Ai; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id B8558693C2
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 13:19:02 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:3483:0:640:1715:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id B655960ACB;
	Fri, 30 Aug 2024 13:18:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rIUvxkaXxCg0-RZnvht08;
	Fri, 30 Aug 2024 13:18:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725013134; bh=psvNxcokM36AAT0wrzDWuJlZYR+CdS7AobzGcXZjoqs=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=kvcST/AiWdV0tOqyiwAiPL9M80dwq44XPmgAEeUnd3nynjX7l0UW7jnvuiXw/Jahv
	 0uwkD1bXpuCyI5NuVTczAxaFBDfYtN73OZAgPI3IgHwnNFNBRdf6HLvtz5xCaYQ5IJ
	 glpDpbnMNnQYAIqZ/caS9aI7WTzOcMtVnJZDlIpg=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Resend taprio series 
Date: Fri, 30 Aug 2024 13:16:30 +0300
Message-ID: <20240830101754.1574848-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a resend of https://lore.kernel.org/netdev/20240807103943.1633950-1-dmantipov@yandex.ru,
briefly re-tested against 6.11.0-rc5 on x86 and arm64 qemu targets, with (hopefully) addressed
notes from https://lore.kernel.org/netdev/20240807193352.66ceaab8@kernel.org and
https://lore.kernel.org/netdev/878qx6y8ds.fsf@intel.com.

