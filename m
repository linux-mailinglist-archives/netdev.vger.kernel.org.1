Return-Path: <netdev+bounces-167687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DFBA3BCC3
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 12:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F987A6759
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CF41DD88D;
	Wed, 19 Feb 2025 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n/0scnwJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8411DE8A8
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964435; cv=none; b=I/Q90EpGDWb1IRh0tQYadQ6XBYjNNKvpZwvyyHdSXY5ehDd4aB8HCQhZe/DR1NjJ5zkPCFELCljBhclbAvXsHIe9cw8XYuZWjc9zNLpkS61e2J77wZb1gQtcu/uzt5ShGHsIHhwWvC8dtHCvTlQ0EL0K4jJMyvPdOxW45HunaxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964435; c=relaxed/simple;
	bh=hKbTbTPgGO7McdkRhmBusUxtdCzNI2FParRdx0fHlJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/Jk9JrwGkEkIjSAXZVyrTuOzByd+qM7OmmoRZ/HR9l4F/mTLUg27kJHVfCzlcNz5X2hCkckB6b2b5eOc7YXlDJyEsoHOqnNPsANx2azuuOEedNGgPUjqm7uWKg8Eaxo3FyAF0q0d/diWTV+hHHaysNAm+9Is0+3SnuFnyCiOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n/0scnwJ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739964421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZNYOLvW3Weg6bzUQ9QSnKQKMpGXw2nnh71Sx7Tukak=;
	b=n/0scnwJnWmY+sy4Po1UIp8em6wCqZSaD9xVmNikkWWBou0s8MBVaPah+VwmejbLseY6gb
	Mc8otbYcHGZl3oQImpq/t18JCVHI6JF/JrfpIEcklw2cHIZcVI3yzR10Bw/i43HmLEA2CA
	YzNhiRPd5tBeapikTsQMZEaI/Xp2U9M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] sctp: Replace zero-length array with flexible array member
Date: Wed, 19 Feb 2025 12:26:36 +0100
Message-ID: <20250219112637.4319-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated zero-length array with a modern flexible array
member in the struct sctp_idatahdr.

Link: https://github.com/KSPP/linux/issues/78
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/sctp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sctp.h b/include/linux/sctp.h
index 836a7e200f39..19eaaf3948ed 100644
--- a/include/linux/sctp.h
+++ b/include/linux/sctp.h
@@ -239,7 +239,7 @@ struct sctp_idatahdr {
 		__u32 ppid;
 		__be32 fsn;
 	};
-	__u8 payload[0];
+	__u8 payload[];
 };
 
 struct sctp_idata_chunk {
-- 
2.48.1


