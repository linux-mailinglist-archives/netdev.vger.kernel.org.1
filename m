Return-Path: <netdev+bounces-148400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66DF9E15D6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2692B291F9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB44C1DE4E0;
	Tue,  3 Dec 2024 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gC/M3U2d"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5F1B0F1E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213418; cv=none; b=VI8SRy5BpfyQK+GUJo/PxcCaZOWKfhUos7uCnh+78hYqOoDFZOBEKxXK8c2/nLWgpbw6VYy2IOOcEwxBeGOurYzTJAKYQ9zwNwNxZ4yQCcYg/EJWGJEQyt8De/kwuvD90jQJcBgdCWolbWzuiUlI+R6FxDeD26gixDIoyxy432A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213418; c=relaxed/simple;
	bh=QtnBsfYZa31/Qr1SPL0KCinYN2AJlNTIR403C8wr8XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=eSwhYAAfI1bZJmpMSa0PhdDxX1AuxiPP4n10DlHA2vbG9JbCz2GHhI2G1T0oisbA5eIziLFc42zU95yY9a6MU5zpu0Q08J/TNfjdacKWIaOz71iDid1dsWvr/gtpTTsbAdF+E3Tp0hsGrRrUo+IAagWbFIG+uhmTs8WxECwtN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gC/M3U2d; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241203081007epoutp04faf5984978b2482b4847a70b64953820~NnGlVQDAt2661826618epoutp04C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 08:10:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241203081007epoutp04faf5984978b2482b4847a70b64953820~NnGlVQDAt2661826618epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733213407;
	bh=kxTPArR5B+jjKoq0idZWZS3H8GcXoNuskGgAVB4JQd0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=gC/M3U2dm6nzQqDSTpe9FtnIrGONsa4sQpTka+y3gY0DdjBLFaQRxliRbrrGYsfk2
	 ofQTHLFNUWYslxJ592RNWfAxa/MWz9WjCDIDHxaW0uwe/swD0HPW5mWc4MSpgkyeZA
	 A8EV+XCkAQ6Odl3thwNYxFrTANhMgeNEAI0uI50I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20241203081007epcas2p23b26a619f34bbf32a4eaf1b434d02518~NnGkvZ4OQ2492424924epcas2p2F;
	Tue,  3 Dec 2024 08:10:07 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.69]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Y2YH22pGwz4x9Py; Tue,  3 Dec
	2024 08:10:06 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.46.32010.EDCBE476; Tue,  3 Dec 2024 17:10:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295~NnGjalTmm2759327593epcas2p2Z;
	Tue,  3 Dec 2024 08:10:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241203081005epsmtrp2cf697a4eb0d96f969d6e77ea8e963089~NnGjZbHAs2167021670epsmtrp2J;
	Tue,  3 Dec 2024 08:10:05 +0000 (GMT)
X-AuditID: b6c32a4d-acffa70000007d0a-38-674ebcde09b3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D1.0C.18729.DDCBE476; Tue,  3 Dec 2024 17:10:05 +0900 (KST)
Received: from perf.dsn.sec.samsung.com (unknown [10.229.95.91]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241203081005epsmtip2139b10f98a9e4c7149a9a4baa8d680be~NnGjLdDaD2959429594epsmtip26;
	Tue,  3 Dec 2024 08:10:05 +0000 (GMT)
From: Youngmin Nam <youngmin.nam@samsung.com>
To: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	youngmin.nam@samsung.com, dujeong.lee@samsung.com, guo88.liu@samsung.com,
	yiwang.cai@samsung.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com,
	sw.ju@samsung.com
Subject: [PATCH] tcp: check socket state before calling WARN_ON
Date: Tue,  3 Dec 2024 17:12:47 +0900
Message-Id: <20241203081247.1533534-1-youngmin.nam@samsung.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmue69PX7pBvsmC1lc2zuR3WLO+RYW
	i3W7Wpksni2YwWLx9NgjdovJUxgtmvZfYrZ41H+CzeLq7nfMFhe29bFaXN41h83i2AIxi2+n
	3zBatD7+zG7x8XgTu8XiA5/YHQQ8tqy8yeSxYFOpx6ZVnWwe7/ddZfPo27KK0ePzJrkAtqhs
	m4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygq5UUyhJz
	SoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2Rk9
	jyYwFswWq1jRaNvAeFKoi5GTQ0LARKLv+gnmLkYuDiGBPYwSi961QjmfGCX2tL1ngnC+MUpM
	mv6eDabl6PHjLCC2kMBeRoknNzIh7K+MEoc+54LYbAK6EttO/GMEaRYRuMcoseTNRVYQh1lg
	OqPEpYZDrCBVwgL2El8m9LCD2CwCqhKHXxwG28ALFL/zrQkozgG0TV5i8QMJiLCgxMmZT8AW
	MwOFm7fOZoY4aCKHxPxpNRC2i8TBh3Oh4sISr45vYYewpSQ+v9sL9UCxRMP9W2BvSgi0MEqc
	uv4CqsFYYtazdkaQvcwCmhLrd+lDnKAsceQW1Fo+iY7Df6Eu45XoaIOGoprErykbGCFsGYnd
	i1dADfSQuHX8BFi5kECsxPV5vBMY5Wch+WUWkl9mIaxdwMi8ilEqtaA4Nz012ajAUDcvtRwe
	q8n5uZsYwSlXy3cH4+v1f/UOMTJxMB5ilOBgVhLhXb7eO12INyWxsiq1KD++qDQntfgQoykw
	gCcyS4km5wOTfl5JvKGJpYGJmZmhuZGpgbmSOO+91rkpQgLpiSWp2ampBalFMH1MHJxSDUx5
	y2YeTpw0dcsEawYdw9YSzQuS+3ZdOZ/6J22R/poi8eqJanKvU/Y2FX/LS34p2aEpqicyKaH5
	2Orin9wMcxzldAw5siT6FbcFVL3b7r5G3IGxc/Vn45tynld3vfBZHcOue2DbXrGmWZYNVnqa
	VkFy/6d+Totq5i0sapk219Cl7yV7U57i4aMvn2lKNAdGKZubHSjxeTB5W07DzUT3mxeeH2G3
	qTadE9XFe2/dl69n+VvEtf/tEZ29IuNQq6bBsxmax9Zd8f/EaRxfeU/IVWDSe6ak0lDpqORT
	q54/Szsh2MYdk1izNuv/phs3vlpcm6nx5LQEw9y/aa0aumuzwjqW5nbdi2CdctTLZGZ+txJL
	cUaioRZzUXEiAOCX4DRCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvO7dPX7pBqv2qltc2zuR3WLO+RYW
	i3W7Wpksni2YwWLx9NgjdovJUxgtmvZfYrZ41H+CzeLq7nfMFhe29bFaXN41h83i2AIxi2+n
	3zBatD7+zG7x8XgTu8XiA5/YHQQ8tqy8yeSxYFOpx6ZVnWwe7/ddZfPo27KK0ePzJrkAtigu
	m5TUnMyy1CJ9uwSujJ5HExgLZotVrGi0bWA8KdTFyMkhIWAicfT4cRYQW0hgN6PEhIPuEHEZ
	idsrL7NC2MIS91uOANlcQDWfGSXOrHvLDpJgE9CV2HbiHyNIQkTgFaPEo5t72UEcZoG5jBJ7
	1q1iA6kSFrCX+DKhB6yDRUBV4vCLw2BxXqD4nW9NQHEOoBXyEosfSECEBSVOznwCdhEzULh5
	62zmCYx8s5CkZiFJLWBkWsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERwDWpo7GLev
	+qB3iJGJg/EQowQHs5II7/L13ulCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYICaQnlqRm
	p6YWpBbBZJk4OKUamHznKeVPsNP/+13vp8mHHL/ccCaXO+9X6nW8meS+YsLV+6tuiOvuEsg/
	d/Al5wfPvlxevdDI7j/ODtME3jwWml74U9XIhOlQ3ZojXM1n+A2i1n6Milvnt+WwUo1RdxWP
	zLaq9V/P6HJ7CKw/3fku17rxVtaiWkW2zvkclm9/L3VT2Fh35uQ6a+aTL5i+NS3sLYiaq7T6
	D/t776vfE7UW9hz4IxHPWTmN7+BODbmfQp5bL3UnK5f7b3urUanu2s79UN/vrnPpWr3sNW8b
	vtaVPz+7NdtqjsKrzE5hLy7HTIVHi7dt01/ue/HUGZMwa/WH3jHKYnmWLUZde1aqr5vQMdkg
	5K0T05+AJe9byxNnKrEUZyQaajEXFScCAMMob1fwAgAA
X-CMS-MailID: 20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>

We encountered the following WARNINGs
in tcp_sacktag_write_queue()/tcp_fastretrans_alert()
which triggered a kernel panic due to panic_on_warn.

case 1.
------------[ cut here ]------------
WARNING: CPU: 4 PID: 453 at net/ipv4/tcp_input.c:2026
Call trace:
 tcp_sacktag_write_queue+0xae8/0xb60
 tcp_ack+0x4ec/0x12b8
 tcp_rcv_state_process+0x22c/0xd38
 tcp_v4_do_rcv+0x220/0x300
 tcp_v4_rcv+0xa5c/0xbb4
 ip_protocol_deliver_rcu+0x198/0x34c
 ip_local_deliver_finish+0x94/0xc4
 ip_local_deliver+0x74/0x10c
 ip_rcv+0xa0/0x13c
Kernel panic - not syncing: kernel: panic_on_warn set ...

case 2.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 648 at net/ipv4/tcp_input.c:3004
Call trace:
 tcp_fastretrans_alert+0x8ac/0xa74
 tcp_ack+0x904/0x12b8
 tcp_rcv_state_process+0x22c/0xd38
 tcp_v4_do_rcv+0x220/0x300
 tcp_v4_rcv+0xa5c/0xbb4
 ip_protocol_deliver_rcu+0x198/0x34c
 ip_local_deliver_finish+0x94/0xc4
 ip_local_deliver+0x74/0x10c
 ip_rcv+0xa0/0x13c
Kernel panic - not syncing: kernel: panic_on_warn set ...

When we check the socket state value at the time of the issue,
it was 0x4.

skc_state = 0x4,

This is "TCP_FIN_WAIT1" and which means the device closed its socket.

enum {
	TCP_ESTABLISHED = 1,
	TCP_SYN_SENT,
	TCP_SYN_RECV,
	TCP_FIN_WAIT1,

And also this means tp->packets_out was initialized as 0
by tcp_write_queue_purge().

In a congested network situation, a TCP ACK for
an already closed session may be received with a delay from the peer.
This can trigger the WARN_ON macro to help debug the situation.

To make this situation more meaningful, we would like to call
WARN_ON only when the state of the socket is "TCP_ESTABLISHED".
This will prevent the kernel from triggering a panic
due to panic_on_warn.

Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 net/ipv4/tcp_input.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5bdf13ac26ef..62f4c285ab80 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2037,7 +2037,8 @@ tcp_sacktag_write_queue(struct sock *sk, const struct sk_buff *ack_skb,
 	WARN_ON((int)tp->sacked_out < 0);
 	WARN_ON((int)tp->lost_out < 0);
 	WARN_ON((int)tp->retrans_out < 0);
-	WARN_ON((int)tcp_packets_in_flight(tp) < 0);
+	if (sk->sk_state == TCP_ESTABLISHED)
+		WARN_ON((int)tcp_packets_in_flight(tp) < 0);
 #endif
 	return state->flag;
 }
@@ -3080,7 +3081,8 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 		return;
 
 	/* C. Check consistency of the current state. */
-	tcp_verify_left_out(tp);
+	if (sk->sk_state == TCP_ESTABLISHED)
+		tcp_verify_left_out(tp);
 
 	/* D. Check state exit conditions. State can be terminated
 	 *    when high_seq is ACKed. */
-- 
2.39.2


