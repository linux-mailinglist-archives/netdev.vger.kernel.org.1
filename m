Return-Path: <netdev+bounces-226594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A60BA2705
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 07:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA80D56075F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 05:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7972773E6;
	Fri, 26 Sep 2025 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wYnqOsD7"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059CC19E7F9
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758864645; cv=none; b=QLoWvRaSear5Ai2dkoTXrXDXfTU54rPGIFn2b2h6uwxnLJckfRdcnesFznJieQMjjGHBhJ0XOanYOMjJgysB3780a6WTzycfS39s1BUnb22z3XS3q7yDfopkmKEB44iLuC0tpGy7GcderE+ZBgudCLc1qSafaqde1X3XeYZsAHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758864645; c=relaxed/simple;
	bh=1XDZFzYOWK0NJeBSnyn0pjcV0FzVXxGofLIW+N6xO0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DIciRZYdK5891HJCPvRnQwyGYdP/Sp21VFQ5lZnsM1jMRE7zZDy6mx4wl+nYjNNqHywb6ogBFmmmb9TfBdg1AbvJ1Py3PtOEfWvKvVKrbvoT+YrGQ+yD5zP227yQyHRVIH7mso3TV5w7cpmcyn31YTKNHYDCrfIfho+/4tHk4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wYnqOsD7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EFA33208B3;
	Fri, 26 Sep 2025 07:30:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gJwAjAvX5S30; Fri, 26 Sep 2025 07:30:34 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 71EA0208A2;
	Fri, 26 Sep 2025 07:30:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 71EA0208A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1758864634;
	bh=Ix3F72Av3o6wSF9fqfaQkMFGIDjzEJ397YLv0mDByTw=;
	h=From:To:CC:Subject:Date:From;
	b=wYnqOsD711+6rA2oMEF3dBWyhzbR8vczAk5iw4hoKP3ly91B2CKkbwYSHh4djAo0S
	 zxk7ybfX/5TjV17eB9mWgHvGXl5p4ZI7oZsXNsm9ol4UsEsYwiSbn9T8IT8NcGZAYs
	 nxzjNJNnTfEm4zbsDUhuAyndGb0KwnWB0AZQL5bEpHkljTedDjHvlQyQC5KIrfTi2i
	 mv3C2qQagVbUPv4+e9L3//ic8pYFj1PAJkS+Hw4+5F+cBdbyxa2+2PMAxwOjrVue9N
	 EoZSKegZLL/Y+R2J5LfI6PS5eam62mb/dcdQuhZbWBrkwqeprGCyw2IsChFq1+uKn3
	 Bse02VeCVoqOw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 07:30:33 +0200
Received: (nullmailer pid 2242257 invoked by uid 1000);
	Fri, 26 Sep 2025 05:30:33 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/2] pull request (net-next): ipsec-next 2025-09-26
Date: Fri, 26 Sep 2025 07:30:08 +0200
Message-ID: <20250926053025.2242061-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

1) Fix field-spanning memcpy warning in AH output.
   From Charalampos Mitrodimas.

2) Replace the strcpy() calls for alg_name by strscpy().
   From Miguel García.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 3b5ca25ecfa85098c7015251a0e7c78a8ff392e5:

  Merge branch 'net-don-t-use-pk-through-printk-or-tracepoints' (2025-08-13 18:26:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2025-09-26

for you to fetch changes up to 9f4f591cd5a410f4203a9c104f92d467945b7d7e:

  xfrm: xfrm_user: use strscpy() for alg_name (2025-08-15 08:32:32 +0200)

----------------------------------------------------------------
ipsec-next-2025-09-26

----------------------------------------------------------------
Charalampos Mitrodimas (1):
      net: ipv6: fix field-spanning memcpy warning in AH output

Miguel García (1):
      xfrm: xfrm_user: use strscpy() for alg_name

 net/ipv6/ah6.c       | 50 +++++++++++++++++++++++++++++++-------------------
 net/xfrm/xfrm_user.c | 10 +++++-----
 2 files changed, 36 insertions(+), 24 deletions(-)

