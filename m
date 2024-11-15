Return-Path: <netdev+bounces-145262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D49CDFD3
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862FB1F23A09
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270CB1B982C;
	Fri, 15 Nov 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="JBvNZuKW"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC281B85EC;
	Fri, 15 Nov 2024 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677003; cv=none; b=JRZMRNKXy5LmyhCed2RWxXTnHsyY1n1SDeWmSJacKJ6ZIhcyDmKaxooMRcy/BrAucHEQAcAPXWAuVlSY7jbgRnn6O9lzqPqMaI4B6/DfGcbGUGp98HxiCFir6VZZKn16TtT7CIiDH/v6Qy035oNw5F/n43pzBs6fKrfDyJUWJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677003; c=relaxed/simple;
	bh=Qrkypyn6oLcQyux/FiD+FNhRfG3YNrtpoe3KECqQWpk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TYkWA+V2cg8GXXUvcZvp4Hb2zsx3cBaE469JxDEojXAHTqJ/1Q49CKrHSXSm977cmQX9YeocehDRzuKmefizQJPjer+gbrwt6o9vCtCGUvU0sQsPLYkrgaIY/s1VgEo/997OTbds0Ui3tNdS3GrY2ty0yItrEHzQ1DzbOVzxL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=JBvNZuKW; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBwHw-007sYD-Pr; Fri, 15 Nov 2024 14:23:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=BTb5bnxrLGEwgrcrSvx3sXPxwvSsd+znqfFVwgZLS/4=
	; b=JBvNZuKWOWLoFvHjz1R1mJhxdBH3A/4SKIyS7qq6yjhuWRywSgPdTa8oTE2+ws7xrnYMYH6Q6
	c9GCEgx28yuob1wrnzhULTudPc7yWp1q29v3dNLFjyqoa+FqrQRmiVWkRmqHQF7wPiBhC/Kkko9FZ
	wvtjvqCGVI9VzOLHMvUN3Yxujo8ZS27D0pg4diUNF4p9Tb710ISN2jtD+BT0f80zDtGjlXgtlLthJ
	eCg2X08xbM0yquSWoMnJvs6pDMywtOc6YmHjBQ2cLM+cXeRFvicSIJASKg+KEQs13gyg0AVQaIdTU
	3LxWB17EuuhVeXC6KWEVjMsvl3THPLQURcsE4g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBwHw-0003oo-Aa; Fri, 15 Nov 2024 14:23:04 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBwHh-00BIK5-EG; Fri, 15 Nov 2024 14:22:49 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net v2 0/4] net: Fix some callers of copy_from_sockptr()
Date: Fri, 15 Nov 2024 14:21:39 +0100
Message-Id: <20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAONKN2cC/22NzQqDMBCEX0X23C2uPzTpyfcoHmKy1lAwkkhQJ
 O/eEHrs8ZthvrkgsLcc4Fld4DnaYN2aoblVoBe1vhmtyQxN3XRE1GFw+rPtHrXbTpztwQFbKSU
 rJUgpgjzcPJci716w8g5jDhcbdufPchSpVD9n/88ZCWs0JFotHrOeTD/4yR137WBMKX0BD8Pjk
 7cAAAA=
X-Change-ID: 20241114-sockptr-copy-fixes-3999eaa81aa1
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Some callers misinterpret copy_from_sockptr()'s return value. The function
follows copy_from_user(), i.e. returns 0 for success, or the number of
bytes not copied on error. Simply returning the result in a non-zero case
isn't usually what was intended.

Compile tested with CONFIG_LLC, CONFIG_AF_RXRPC, CONFIG_BT enabled.

Last patch probably belongs more to net-next, if any. Here as a RFC.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Fix the fix of llc_ui_setsockopt()
- Switch "bluetooth:" to "Bluetooth:" [bluez.test.bot]
- Collect Reviewed-by [Luiz Augusto von Dentz]
- Link to v1: https://lore.kernel.org/r/20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co

---
Michal Luczaj (4):
      Bluetooth: Improve setsockopt() handling of malformed user input
      llc: Improve setsockopt() handling of malformed user input
      rxrpc: Improve setsockopt() handling of malformed user input
      net: Comment copy_from_sockptr() explaining its behaviour

 include/linux/sockptr.h           |  2 ++
 include/net/bluetooth/bluetooth.h |  9 ---------
 net/bluetooth/hci_sock.c          | 14 +++++++-------
 net/bluetooth/iso.c               | 10 +++++-----
 net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
 net/bluetooth/rfcomm/sock.c       |  9 ++++-----
 net/bluetooth/sco.c               | 11 ++++++-----
 net/llc/af_llc.c                  |  8 ++++----
 net/rxrpc/af_rxrpc.c              |  8 ++++----
 9 files changed, 43 insertions(+), 48 deletions(-)
---
base-commit: ea301aec8bb718b02b68761d2229fc12c9fefa29
change-id: 20241114-sockptr-copy-fixes-3999eaa81aa1

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


