Return-Path: <netdev+bounces-146250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23169D26F8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7DA1F243A2
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4551C1F2A;
	Tue, 19 Nov 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="PI3/0jX/"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AD55896;
	Tue, 19 Nov 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023146; cv=none; b=BIgWAu9Vk2EU+wsFt+uz8CTM1pykU0aS0kl1AJdvYcOH83gEY8rqa+M1Bfqb6zwZ7K8NY1fpSqdMd3bNhYsmBbL0sQ6pnIvFSTPx8nzHoLLFs+WX3l8+Yy+3bX0gfBoS9A5AeenVR3eMauNg2Cppa6KO1eHVya4aiKjhc1c8vQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023146; c=relaxed/simple;
	bh=TGYgKHrWi45eP74OGx86VNr8aTqx9OASNe1ALzs0Ipo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2Si5g/xm0YazaQ8QVS37h2ZoEnjFcNMBvUWRI5RuGirn+kUB0AaC/2fiQ2aIrl2W2x5OofO8pv10UdMIVDtvQ0VyLdc+rwYuWsDibTeBEcmvuTvu9zXRa5yWiUax9KxQWU0e4k2zO20G+4CExWrK713SXSRtjMrm5k3GVVzeAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=PI3/0jX/; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tDOL0-0024S4-CE; Tue, 19 Nov 2024 14:32:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=2mJwBMTodwxfnLyOzYPLEocXMS7HcMW4KzH89mo5048=; b=PI3/0jX/INHE6u0HeHDHxKsiSp
	ymf08fP/M8ObhfX8HIm3Ras8fB41Tb9GGotqliE+xzbR+orxwpWfkHNn/unn53hsmcP65e00bthPO
	G29rIAMja3klIasVZldU5G4TxI05DvBg1PXp4twhdkbb8h+3JNM/9txtSjiX0RTLhT3ez2jzmgZWE
	UXEXeFKaCgBK4fq347ej2X7iL6PiFt6TJE0DXsFDg5bH+Jk7nGSFG0MwFw1iZfdC1/2xDPulhwu0e
	dihX8fN7Rc1HbmgPA23tP1jmCOEf33HWYKdMZlO+LK8MfR5heQMKv72HRAWvtklm0D5Lxpp/5aQtu
	O6CI85OQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tDOL0-0000aP-1B; Tue, 19 Nov 2024 14:32:14 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tDOKk-000XIx-GL; Tue, 19 Nov 2024 14:31:58 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 19 Nov 2024 14:31:41 +0100
Subject: [PATCH net v3 2/4] llc: Improve setsockopt() handling of malformed
 user input
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-sockptr-copy-fixes-v3-2-d752cac4be8e@rbox.co>
References: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
In-Reply-To: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 Michal Luczaj <mhal@rbox.co>, David Wei <dw@davidwei.uk>
X-Mailer: b4 0.14.2

copy_from_sockptr() is used incorrectly: return value is the number of
bytes that could not be copied. Since it's deprecated, switch to
copy_safe_from_sockptr().

Note: Keeping the `optlen != sizeof(int)` check as copy_safe_from_sockptr()
by itself would also accept optlen > sizeof(int). Which would allow a more
lenient handling of inputs.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: David Wei <dw@davidwei.uk>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/llc/af_llc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 4eb52add7103b0f83d6fe7318abf1d1af533d254..0259cde394ba09795a6bf0d44c4ea6767e200aea 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -1098,7 +1098,7 @@ static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
 	lock_sock(sk);
 	if (unlikely(level != SOL_LLC || optlen != sizeof(int)))
 		goto out;
-	rc = copy_from_sockptr(&opt, optval, sizeof(opt));
+	rc = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 	if (rc)
 		goto out;
 	rc = -EINVAL;

-- 
2.46.2


