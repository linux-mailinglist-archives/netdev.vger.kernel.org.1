Return-Path: <netdev+bounces-143614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC429C3545
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 00:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6780C1F2150D
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 23:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0769F1581F2;
	Sun, 10 Nov 2024 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="NqlVNPTa"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4913AA38
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731280736; cv=none; b=uEtygGSl5WqS0Y2hMqECInzSMYR7zFWokuf5kvMFNi/FgHMVAFoMLI1EXWh4gFwJGGhGjV7wfBMNbp8rVByRPPXukQY/7eY65uO/62Rv8tBCiAg8IL38U8FRf4aZIukpBLpRm42/ascR5tfQ/MK5EImVl0AjnV5rxKs/K4bMpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731280736; c=relaxed/simple;
	bh=yq/Ym4oRoNkAG4zni3vQra21S+lBbTrk7xAvro4OheU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RzMnkSz68mIEu0+nl5r8oWitJISUC7LxeGXs/pP3phNcjKki9+u0WXbp2vtb0fvkPIkDn/ZxoTAWcRuAoRYZbsid60wuxmxPhvGP8ldSkhMu1l67jOimEUi7ofG+ZseDRgI4qQLdaufplpm0Sui9308WpN/eHoOrblx5b5xInNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=NqlVNPTa; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tAHCb-00B3dE-Gl; Mon, 11 Nov 2024 00:18:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=iyUm8YzuREHK2Tx/q4mT/Kn3rxYtLxNSAYbM6d/c9KI=; b=NqlVNPTaGRIszkLeTrwmKk869C
	L4WJ76UlnuMowTddFr31zmNvV9NQbiznZ2zdGnHaufu6xJCCQ5g1AccpK/VPbHstIJJDQSulu7ndH
	E3wyd8Ha7SK5jP3IV7/ZGbl+e/vSSaCL/1zq3tgFKyLF4uWmkjNgyzdhpfRSKzLjudoGMydz4twoz
	kStUsjuafAA3ieBxuT9lQfSCK4EX1a+HXfYUH9w/17I/pjrLGFFZOR0OtcuGBGs8F5CiVLXORNkEs
	SCQIuugwIo2Gc0kDh+Tn6JXwpNVol4h4WLIW7S/f0riPoKai5kVyZt2iYPlo+9/jTVr50aLX7DZ7J
	zV+NVJ8g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tAHCb-0004a5-4Z; Mon, 11 Nov 2024 00:18:41 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tAHCJ-002qFl-9V; Mon, 11 Nov 2024 00:18:23 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 11 Nov 2024 00:17:34 +0100
Subject: [PATCH net] net: Make copy_safe_from_sockptr() match documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-sockptr-copy-ret-fix-v1-1-a520083a93fb@rbox.co>
X-B4-Tracking: v=1; b=H4sIAA0/MWcC/x2MQQqAMAzAviI9W7A6BP2KeJBZtQjb6IYow787P
 CaQZIiswhHGKoPyJVG8K0B1BfZY3M4oa2Fom9YQNQNGb8+QFK0PDyon3ORGu/SbIUPdOnRQ0qB
 c9L+dwHGC+X0/B1T2dGsAAAA=
X-Change-ID: 20241109-sockptr-copy-ret-fix-ca6f41413d93
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

copy_safe_from_sockptr()
  return copy_from_sockptr()
    return copy_from_sockptr_offset()
      return copy_from_user()

copy_from_user() does not return an error on fault. Instead, it returns a
number of bytes that were not copied. Have it handled.

Fixes: 6309863b31dd ("net: add copy_safe_from_sockptr() helper")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Patch has a side effect: it un-breaks garbage input handling of
nfc_llcp_setsockopt() and mISDN's data_sock_setsockopt().
---
 include/linux/sockptr.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index fc5a206c40435fca5bc97e9e44f47277ac2aa04c..195debe2b1dbc5abf768aa806eb6c73b99421e27 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -77,7 +77,9 @@ static inline int copy_safe_from_sockptr(void *dst, size_t ksize,
 {
 	if (optlen < ksize)
 		return -EINVAL;
-	return copy_from_sockptr(dst, optval, ksize);
+	if (copy_from_sockptr(dst, optval, ksize))
+		return -EFAULT;
+	return 0;
 }
 
 static inline int copy_struct_from_sockptr(void *dst, size_t ksize,

---
base-commit: 252e01e68241d33bfe0ed1fc333220d9bd8b06df
change-id: 20241109-sockptr-copy-ret-fix-ca6f41413d93

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


