Return-Path: <netdev+bounces-119393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D49C9556BE
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A434281E5D
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F801487CE;
	Sat, 17 Aug 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="YKYEfoyo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpdh17-su.aruba.it (smtpdh17-su.aruba.it [62.149.155.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1970148317
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723886930; cv=none; b=fqBzXQHEH8ZUbE5HEWCCEgkoA/6o8vkhlMdYtgl6mGB9+EwtSU7sZ2L9+5XWaeAKp+qbAc0xE7Vxc0UGzwt4ds6Rg7JFsUdiBIOMfcIiG8AmSI7h47FNT4efxaQEE1Z48Y7+U4G0C/W8YkfRZYeWs8sCax3Hi4YnL5yDFUft9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723886930; c=relaxed/simple;
	bh=4SvgcqjQqIApfuzqVr+Pfy0s3dgei0JUM6ZubilOR+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mHL8P6KV6pHYqmP+h0mevoKMOex/vgZN/2s/5CZeo+QE7GQ2ZmmvatqpV12VBuro0YV6oV82hSx0VBTVd083sQMbm5DbLBUY+RRsIkVmfnphIeC8eg7aKcaFRzivacqHaxK3/780vVYygXr/XzEf5E3m/M/dmItBTvvCTcAWPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xhero.org; spf=pass smtp.mailfrom=xhero.org; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=YKYEfoyo; arc=none smtp.client-ip=62.149.155.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xhero.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xhero.org
Received: from xhero.org ([84.74.245.127])
	by Aruba Outgoing Smtp  with ESMTPSA
	id fFglstT0CJLbHfFgmsuKXH; Sat, 17 Aug 2024 11:25:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1723886738; bh=4SvgcqjQqIApfuzqVr+Pfy0s3dgei0JUM6ZubilOR+c=;
	h=From:To:Subject:Date:MIME-Version;
	b=YKYEfoyomrbvGK3PRFT7GBW/aP1eMp2d1Fy2JkBNOVuNLN3qRsqRd6MLI08y/1hPK
	 QJp5eN8XnL9yOBKzcaXXCPwvbpYTuarmk2MFVdGlNCS65OSU15RLDBS9WNurE6W4UF
	 MOZCjGZB0QOKSntameMU6DCmQssC5gcwuyBkto20O7Cp6MUU1NEyNgT4BWAaAkJ253
	 wJeqxnJq3BAwY7u387d5xuG3lhph+Q/fVFtMil+ZaQH10+hib3X+uE+tGRzIHoj5K+
	 CNlx7FbFEBtvT2rgHd/6OuUGKnZX0qozBIyRbnYqMYgTbTBjmjXZu6tBK6gDeqkxYm
	 /aelEe/HcM2CA==
From: Rodolfo Zitellini <rwz@xhero.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Doug Brown <doug@schmorgal.com>,
	Rodolfo Zitellini <rwz@xhero.org>
Subject: [PATCH net-next 0/2] pull-request appletalk 2024-08-17
Date: Sat, 17 Aug 2024 11:25:20 +0200
Message-Id: <20240817092522.9193-1-rwz@xhero.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfC0wUgpjHIW+1WgCBy3vFf/B9Zzdd8klNMYrRHRkzBN1ZBVWRqkddqbt7kR68RlyxvvA1Uv7EobfiXNbNntvYOYrJFM9CqHylj5EDNDRQhWN9r6OUe2K
 85l17DIbAPrrZVmphvur6mDzGO77Zd/cPA2RGRq9vLKPlDWxSjCBubWbObuJppyZLbsWKZB8aLz2U6iysp8MGgnqHDb1qh9a0Y56V+bUzCmcGoTz6i4WlCBs
 cIhErSvCpcnuKOrmp/TGgYSnBrf7hB5pFQmyb6X2BXEAaV2JXJI7JdQ4RT8TbBHTou7tiUCLnoZfNP7WpneLOvOUgmtj2QTTT+jn+gT/qYmTeK48dW0Rt0XK
 ebnzUvdrQQ1XEFnsOacZ9t7sjzPv3W7DknuOOpyaB8SV3FRvueroZMItnIk7SmFzKuzq1n536AbmmkyU1FxevmYJpHRTTRZqyCixwW/6NpPNYj4PZ/Mc8yYY
 NAxqQJoi3Yw0dia8UNI7afu2NEM0ldTgK9BXsOU5LT1P4Y+A1THoFTIZrNBRG80ckwNwY+5lqU/5FlG6vP7p7eiN/XfmbrcUuDIzGnQsbctXPt51/DUmSHIN
 tK8=

Hello,

this is a pull request of 2 patches for net-next/master

The first patch introduces a new line discipline ID for the
TashTalk line discipline.

The second patch adds an Appletalk driver that serves as a
drop-in replacement for the old COPS LocalTalk driver. It
implements a line discipline that interfaces with a TashTalk
device, an open-source project that provides the proper SDLC
and FM0 encoding required on the LocalTalk bus. With a minimal
amount of supporting components, it becomes possible to connect
a modern PC to older devices (Macintoshes, Apple IIgs) on a
LocalTalk bus. It is compatibile out of the box with Netatalk
2.x and will also work with the upcoming 4.0 release which
re-introduces Appletalk support.

Kind Regards,
Rodolfo

Rodolfo Zitellini (2):
  tty: Add N_TASHTALK line discipline for TashTalk Localtalk serial
    driver
  appletalk: tashtalk: Add LocalTalk line discipline driver for
    AppleTalk using a TashTalk adapter

 .../device_drivers/appletalk/index.rst        |   18 +
 .../device_drivers/appletalk/tashtalk.rst     |  139 +++
 .../networking/device_drivers/index.rst       |    1 +
 MAINTAINERS                                   |    7 +
 drivers/net/Kconfig                           |    2 +
 drivers/net/Makefile                          |    1 +
 drivers/net/appletalk/Kconfig                 |   33 +
 drivers/net/appletalk/Makefile                |    6 +
 drivers/net/appletalk/tashtalk.c              | 1003 +++++++++++++++++
 include/uapi/linux/tty.h                      |    3 +-
 10 files changed, 1212 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/networking/device_drivers/appletalk/index.rst
 create mode 100644 Documentation/networking/device_drivers/appletalk/tashtalk.rst
 create mode 100644 drivers/net/appletalk/Kconfig
 create mode 100644 drivers/net/appletalk/Makefile
 create mode 100644 drivers/net/appletalk/tashtalk.c

-- 
2.34.1


