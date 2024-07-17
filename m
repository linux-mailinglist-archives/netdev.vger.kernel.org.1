Return-Path: <netdev+bounces-111962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3BC9344BB
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 00:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C5D1C21782
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 22:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE8148CDD;
	Wed, 17 Jul 2024 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVrJjAJ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A4341C6A;
	Wed, 17 Jul 2024 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254943; cv=none; b=XwIncW8Dj8S5ABAbApzuRB6FTIGMBipuoLrqpL7+n9f0VU+oQTUEdIkAgqnysPDc8RDr2gZJ9AlEpIj4sJIBThY/OVEsFxk7DkNNWNnpe73CsJWQS4INXTlMwtPV96yEbQiCn2WsCdqaUvAFLHEQLhrXva1bo1RLnOsTQyNMSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254943; c=relaxed/simple;
	bh=85Kb0E3hPI0Cde+9G22x9Z7TDf0kIOEZciazLIa3os4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ghu1Ez0U03fr/wIRdQSzqJNMVj1FdReqD/qUNyHI2TzIhaQ6NDqkFcgaMzj2JZj79JZt3+fndZCTrwsHLmgVebLA7YGAopGwvRZFcmJnWDRJHxRXHt9diZm86WqL2116aSsTrI6jhUfB2cMv9JymNfhbPGXyw4WhAY+j14sK/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVrJjAJ0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-75a6c290528so83432a12.1;
        Wed, 17 Jul 2024 15:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721254937; x=1721859737; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UPEiF2RNiOzdnwwKo/hkn+r0utVVZvhpdHxJImlCUO8=;
        b=eVrJjAJ0UMuxKoz52W27e/aNdKT9mx1At8Ac/W3Mcl46VPzHSidP4ldIMT23xpPCGq
         FJ60Ayq+N2iDR/h+IZmlVLboQrjn06Xaa+v27xRPQ8cXWH/xvzD2MQjkVHj6CT3S+rWs
         dN3fpOyAJ/l5rIWa6rQ47lekkk7zxlVIvMyv7WZxLLxoIFpXzSKu8L+aTJQhQ+rmR1ID
         qLLR3dyKz8uQ7yT1nN1STcSVJa4XBg3+B3WnYxvXKGrlEaE7PmvlJmQv4h5TRBPViz+2
         jJHEqhAFWyEq62YRR3cmrMYU4w/E/TpcuEEj9XFP2I5IWcB6QDYK7fLSilZ/yDICAXj1
         x1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721254937; x=1721859737;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPEiF2RNiOzdnwwKo/hkn+r0utVVZvhpdHxJImlCUO8=;
        b=XIKS9T6JwSJBMjNwjwbFMDp6tgH9uuwJALrkRDj31IekW9j5Ke9NyhWj8OSGoQK/h8
         xmltdybxNDOMR74EQxbAaxujrSGWq3xGppnr0OC7CbpUgYebfIvz93Y4DA3IUoSFkwgr
         0V/oNw9R6fzpM+Z4D/O3pOTJWm8HYFqZfLomczs9Vg7aBHerY04ihJniFffBIsmfzQv8
         3KWo/7TTjJ1h9Wn10wZq9lwOiMC23aqD7E0WZU2A1E8SDMRnzVdBOAaxFNBmJQcSYRVz
         MTV2fpjvU7EXSL/6GX4UNnepkfTZACECkglHbRJT8rYrCmSRtmr8pwtVPt/30cFmLfUf
         wTKw==
X-Forwarded-Encrypted: i=1; AJvYcCWJkbM95j6J/jinedVJP/urn76/GGFrP9CIwn2aSvuzANKxlchPlYFbc180wds75l5aIO6W8/UUVGfuOwR0THTNviILDUOep/T2HN3I
X-Gm-Message-State: AOJu0YzBB/knnlsR+FHKrN3WQk8GWbGfOW0ZFEslanqpQll3wWj1wzRy
	b/3EEPDIcnlMQXVd9WjLZGeXGroTccLfelAom7uN0WvUkniozJaS
X-Google-Smtp-Source: AGHT+IFqu8OC2JShWRB4tKGgnZFmWEnFxHEbXhlwUw4JCt0M5FB5lfSluPJXB0/bnIZgneeirpI3cQ==
X-Received: by 2002:a05:6a20:2445:b0:1c0:e564:d720 with SMTP id adf61e73a8af0-1c3fdccb16fmr3849860637.33.1721254937422;
        Wed, 17 Jul 2024 15:22:17 -0700 (PDT)
Received: from win. ([24.5.160.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc43febsm80029015ad.234.2024.07.17.15.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:22:17 -0700 (PDT)
From: James Tucker <jftucker@gmail.com>
Date: Wed, 17 Jul 2024 15:22:14 -0700
Subject: [PATCH] net: uapi: add TCPI_OPT_NODELAY to tcp_info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-nagle-tcpinfo-v1-1-83e149ef9953@gmail.com>
X-B4-Tracking: v=1; b=H4sIABVEmGYC/x3MQQqAIBBA0avIrBPUIqmrRIuy0QZCRSMC8e5Jy
 7f4v0DGRJhhZgUSPpQp+AbZMTDn5h1yOppBCTUILTX3m7uQ3yaSt4Gb0fSIVuyTPKA1MaGl9/8
 ta60fXpPdBl8AAAA=
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Tucker <jftucker@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=jftucker@gmail.com;
 h=from:subject:message-id; bh=85Kb0E3hPI0Cde+9G22x9Z7TDf0kIOEZciazLIa3os4=;
 b=owEBbQKS/ZANAwAIAaeenghooCfkAcsmYgBmmEQXvoIWtWPvxlVC0zg50Sv19qAOTk1ZAztxK
 8OOc1uH6S2JAjMEAAEIAB0WIQSg43nLjsVzAlrc3Zennp4IaKAn5AUCZphEFwAKCRCnnp4IaKAn
 5NeID/sH/nhoMvkKvRNEQL2g+klUsvtSv1gS0bI5PtDbPoUnnZp/dJ36oVpmQb3guZoxLH6XPs3
 s0r+X59AK2KGU0niCKhVh1MmNQEkuTE85ufwChyOCW+Ww9DJxtVMSlhur5XJer/3rkegSdwHFx2
 r4KT+CjYBhi1rPndS9X2YqheDNwweHtZi2+1V7n2t8Hv5r44rDf45IShuDiA6vqSyHuYMbtH6VQ
 zKv47dMRL6g5Up/2IUFtEZ22lLx1oCgHUwzDs3/EOebgWdgNlm3eJVFN1wKGLviHYBOLmKNEB1u
 Gf4oTr4SFJpxggRrbkDHH1mN1Pvd36rqAyjiaBtyink2xVUsEp0A3LnZ3AJ440FpeTMkdd2LsBK
 tqS53QjfDm20xijrdJ3nuBSiQBOuMipMaKqV+NNHBZafCBQoaV6N+dFwwVE0K56q3qOnm5+NhKg
 VT/3sNiYHijaQRrC4+Ud7GzqP7HLrlc8nArvzf01KeZC5oSv6taZVsfyPpPjFj243TpVVdjVYJK
 5ixgjsItrcUk8cefmTnnsmT4cQ8e7rOmhVyBPZZLfzywFWoSU/UHlfqfdg3kZdsheOnBzEbLbzZ
 MHUU6QQ2fG90dOkSlSXTQ5wFMiJjfgnxnMljKlRFEYE3W4umnQpYmN4SEWpGXkWXMZ+0oqR13z9
 147Xt8IkZu43oVA==
X-Developer-Key: i=jftucker@gmail.com; a=openpgp;
 fpr=A0E379CB8EC573025ADCDD97A79E9E0868A027E4

Nagle's algorithm is one of the classic causes of poor performance for
certain classes of userspace software over TCP, but is currently not
reported in userspace tools such as ss(1) from iproute2 as it is only
observable via getsockopt.

Signed-off-by: James Tucker <jftucker@gmail.com>
---
The impact of Nagle is substantial on TCP connections in a lot of use
cases, but is currently unreported in the TCP info structure.
---
 include/uapi/linux/tcp.h | 1 +
 net/ipv4/tcp.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dbf896f3146c..d7675e7022b4 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -178,6 +178,7 @@ enum tcp_fastopen_client_fail {
 #define TCPI_OPT_ECN_SEEN	16 /* we received at least one packet with ECT */
 #define TCPI_OPT_SYN_DATA	32 /* SYN-ACK acked data in SYN sent or rcvd */
 #define TCPI_OPT_USEC_TS	64 /* usec timestamps */
+#define TCPI_OPT_NODELAY	128 /* Nagle's algorithm is disabled */
 
 /*
  * Sender's congestion state indicating normal or abnormal situations
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03a342c9162..2f5aa78800d3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3853,6 +3853,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_options |= TCPI_OPT_SYN_DATA;
 	if (tp->tcp_usec_ts)
 		info->tcpi_options |= TCPI_OPT_USEC_TS;
+	if (tp->nonagle & TCP_NAGLE_OFF)
+		info->tcpi_options |= TCPI_OPT_NODELAY;
 
 	info->tcpi_rto = jiffies_to_usecs(icsk->icsk_rto);
 	info->tcpi_ato = jiffies_to_usecs(min_t(u32, icsk->icsk_ack.ato,

---
base-commit: e2f710f97f3544df08ebe608c8157536e0ffb494
change-id: 20240717-nagle-tcpinfo-c6c3eef0b91d

Best regards,
-- 
James Tucker <jftucker@gmail.com>


