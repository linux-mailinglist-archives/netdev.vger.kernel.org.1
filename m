Return-Path: <netdev+bounces-83652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7CC893432
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316802856DA
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9D215A4AA;
	Sun, 31 Mar 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKkf22qL"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8F15A4A4
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903290; cv=fail; b=vDkcli4J0IBullweGYJT0yLq7yUGkvrPKh9uraaYvS5qCfWlm1NEPeqc16MTELg7j0c9291jjzhKmIYf6pvOG2G+j9gH2vQV0b3HiH/4BxaqFwNouaID6eCw7YsHw59k0IGKtgTrhxG/iCWshkM737jsV9GxoQPFqrLqv63IXeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903290; c=relaxed/simple;
	bh=FuJogDh1PVOwWy0oZxG9rxNrbp+iNEtmgyFwxmZt/II=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=r18x2U/mWjTD6CMkVw1hkFNY6JUqLukHDMfJcbzHjG2opt6MJuIIugscbVA5gkNppIjG9e6ot0AWUaSWgqaRy4SLvVflSf2G7MJhp0xj7KmNY42ulWkiHSZqWcP/3TqtsCtgkGjs5gVh+L8uYrmHCPfs6nUp7jPatkMZWjpfsr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKkf22qL reason="signature verification failed"; arc=none smtp.client-ip=209.85.161.43; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9DEE5208C2;
	Sun, 31 Mar 2024 18:41:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6JRUbVOzAx5w; Sun, 31 Mar 2024 18:41:25 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7DBC820896;
	Sun, 31 Mar 2024 18:41:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7DBC820896
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 7082580005E;
	Sun, 31 Mar 2024 18:41:24 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:41:24 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:12 +0000
X-sender: <netdev+bounces-83570-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com;
 X-ExtendedProps=DwA1AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLklzUmVzb3VyY2UCAAAFABUAFgACAAAABQAUABEAnTlpvhaBCEeyp1ntZSMfKQUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUAbAACAAAFAFgAFwBIAAAAnTlpvhaBCEeyp1ntZSMfKUNOPVNjaHVtYW5uIFBldGVyLE9VPVVzZXJzLE9VPU1pZ3JhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAMAAIAAAUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAVXYFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQ8AKgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuUmVzdWJtaXRDb3VudAcAAgAAAA8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKACsAAADwigAABQBkAA8AAwAAAEh1YgUAKQACAAE=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13801
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83570-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2E3E1207D8
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711875932; cv=none; b=GDhHN3nG0FkJgI6y9tXlRu27sho7aNbzAHqupl053nkeTb8QRWLHUvqc2nDfN53kmbWXRZ1WAysRS7taYilklhCoPuGOv0WCOQ5nJOfU/MmoE1CFfPo5baFsrsVOJWpspEajucoZS5jRsgvHKG5A7XDLdzQ/hhmBLSkl6vTo1jE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711875932; c=relaxed/simple;
	bh=T3TbQ221nO1Il/6EQXBBuyWZkfJXamANSLShzFjxjWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hdfWMF55XziBhD+DNMysSDlVyUCAz5KKOUUk7sR8+jG1KH7BFclbr/Hkd/nGNKGpjai2SBgDsSrn5oU/KBd4A7ucQm3cRgJ729FXtmdoFs9WHHX2izACU7bqWyURayAXk21nZGc6q13ZusrA7ieRtA/+4GFZJbHzbfzXJP6nA+U=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKkf22qL; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711875930; x=1712480730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky119Wmn9lN3itBVAspC/BbZzZjapLFOG2bFm8WtvRY=;
        b=JKkf22qLc7bL34IrBvR7/FSZC3Ds6Kt8UzyqtExXUJsPHYXmGrY9R+vge8j+s23979
         XMc1Vd084a1R3GXiMWpKYr+8bXNaOKA6sQpsPyXhOH8sZ01XgD3bM5tTDongEqe/vjMc
         B8+lH4p3a5gRlyoX1zeJmh+h7qaYGOutERR3yXEtWMiOj1z+uxrk+5foMzbodHtPSAuR
         BuW63xaz3kqlbe+Q0NNITSOvShWClbFRfcUck7vrulMHE3Qa3CXloYk5bXFuqgTsdGWs
         JUymIbQJYcpRb445A58u2pwIZ5KKQXL1v3nB+mDIRmm0hbtcvPJ9Qg1sQBp52PBjx0Zp
         mYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711875930; x=1712480730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ky119Wmn9lN3itBVAspC/BbZzZjapLFOG2bFm8WtvRY=;
        b=OYM02JA5QIrLohjsYuYvoUS0cAFmAuneRZTC2WF2CfJcKLOAOmtMLnb/kMGwHack4k
         TPitosh/VAMXSSR4QKDn73A/selJTRQNQlfkbKmp72f9dpsRy/dMNddyEh1mQUZwdfIm
         gHqsak+Q/SwLu9EGkFTZvyCJoge/vMCZyGSuXNmJQw+6EH4uotZGysvk6k7GBtBVFNX6
         C/oQKpT52wsKdJRkgZMVCEjCKFTzmFMpUPGvrS63wgJeLv9jD6h5XnoE8EOlBDdot/qI
         CsQLHpa9ea0K0VFvuVAm6zpfqg4O7+eWxQZyO8ZvStwqCLzUC0d6VARQ7GzJFvmiE3pS
         s2AQ==
X-Gm-Message-State: AOJu0YxEy35JhiDHQKvk1MIhdY+zOx5jTzhq4PiKTY50sBhoi5IWYqkN
	/rrXx6PN4v/N+joQqKxCmuFDQh9rQbMOM+7GLFBUKTGDX6t/ddET
X-Google-Smtp-Source: AGHT+IGWJlzjzT5DVCzi9/z73tCArAcJ7nYGcahi/w09HQ/aa5Kl9BT1U3gr+kB4vbHocoeCPjsw4w==
X-Received: by 2002:a05:6358:70cc:b0:17e:8b66:a983 with SMTP id h12-20020a05635870cc00b0017e8b66a983mr7934504rwh.21.1711875929568;
        Sun, 31 Mar 2024 02:05:29 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog
Date: Sun, 31 Mar 2024 17:05:21 +0800
Message-Id: <20240331090521.71965-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Jason Xing <kernelxing@tencent.com>

Since commit 099ecf59f05b ("net: annotate lockless accesses to
sk->sk_max_ack_backlog") decided to handle the sk_max_ack_backlog
locklessly, there is one more function mostly called in TCP/DCCP
cases. So this patch completes it:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/inet_connection_sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index ccf171f7eb60..d94f787fdf40 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -284,7 +284,7 @@ static inline int inet_csk_reqsk_queue_len(const struct sock *sk)
 
 static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 {
-	return inet_csk_reqsk_queue_len(sk) >= sk->sk_max_ack_backlog;
+	return inet_csk_reqsk_queue_len(sk) >= READ_ONCE(sk->sk_max_ack_backlog);
 }
 
 bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
-- 
2.37.3


X-sender: <netdev+bounces-83570-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAVXYFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAA==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 9563
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 11:05:42 +0200
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Frontend
 Transport; Sun, 31 Mar 2024 11:05:42 +0200
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 8EDAB20322
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 11:05:42 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.749
X-Spam-Level:
X-Spam-Status: No, score=-2.749 tagged_above=-999 required=2.1
	tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
	DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
	FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
	MAILING_LIST_MULTI=-1, RCVD_IN_DNSWL_NONE=-0.0001,
	SPF_HELO_NONE=0.001, SPF_PASS=-0.001] autolearn=ham autolearn_force=no
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=pass (2048-bit key) header.d=gmail.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e9wpJaepRI49 for <steffen.klassert@secunet.com>;
	Sun, 31 Mar 2024 11:05:42 +0200 (CEST)
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83570-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 76F86202D2
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKkf22qL"
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 76F86202D2
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 11:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB26B21AA6
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55B773171;
	Sun, 31 Mar 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKkf22qL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF221C0DE5
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711875932; cv=none; b=GDhHN3nG0FkJgI6y9tXlRu27sho7aNbzAHqupl053nkeTb8QRWLHUvqc2nDfN53kmbWXRZ1WAysRS7taYilklhCoPuGOv0WCOQ5nJOfU/MmoE1CFfPo5baFsrsVOJWpspEajucoZS5jRsgvHKG5A7XDLdzQ/hhmBLSkl6vTo1jE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711875932; c=relaxed/simple;
	bh=T3TbQ221nO1Il/6EQXBBuyWZkfJXamANSLShzFjxjWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hdfWMF55XziBhD+DNMysSDlVyUCAz5KKOUUk7sR8+jG1KH7BFclbr/Hkd/nGNKGpjai2SBgDsSrn5oU/KBd4A7ucQm3cRgJ729FXtmdoFs9WHHX2izACU7bqWyURayAXk21nZGc6q13ZusrA7ieRtA/+4GFZJbHzbfzXJP6nA+U=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKkf22qL; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a4b35ff84eso2034384eaf.2
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711875930; x=1712480730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky119Wmn9lN3itBVAspC/BbZzZjapLFOG2bFm8WtvRY=;
        b=JKkf22qLc7bL34IrBvR7/FSZC3Ds6Kt8UzyqtExXUJsPHYXmGrY9R+vge8j+s23979
         XMc1Vd084a1R3GXiMWpKYr+8bXNaOKA6sQpsPyXhOH8sZ01XgD3bM5tTDongEqe/vjMc
         B8+lH4p3a5gRlyoX1zeJmh+h7qaYGOutERR3yXEtWMiOj1z+uxrk+5foMzbodHtPSAuR
         BuW63xaz3kqlbe+Q0NNITSOvShWClbFRfcUck7vrulMHE3Qa3CXloYk5bXFuqgTsdGWs
         JUymIbQJYcpRb445A58u2pwIZ5KKQXL1v3nB+mDIRmm0hbtcvPJ9Qg1sQBp52PBjx0Zp
         mYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711875930; x=1712480730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ky119Wmn9lN3itBVAspC/BbZzZjapLFOG2bFm8WtvRY=;
        b=OYM02JA5QIrLohjsYuYvoUS0cAFmAuneRZTC2WF2CfJcKLOAOmtMLnb/kMGwHack4k
         TPitosh/VAMXSSR4QKDn73A/selJTRQNQlfkbKmp72f9dpsRy/dMNddyEh1mQUZwdfIm
         gHqsak+Q/SwLu9EGkFTZvyCJoge/vMCZyGSuXNmJQw+6EH4uotZGysvk6k7GBtBVFNX6
         C/oQKpT52wsKdJRkgZMVCEjCKFTzmFMpUPGvrS63wgJeLv9jD6h5XnoE8EOlBDdot/qI
         CsQLHpa9ea0K0VFvuVAm6zpfqg4O7+eWxQZyO8ZvStwqCLzUC0d6VARQ7GzJFvmiE3pS
         s2AQ==
X-Gm-Message-State: AOJu0YxEy35JhiDHQKvk1MIhdY+zOx5jTzhq4PiKTY50sBhoi5IWYqkN
	/rrXx6PN4v/N+joQqKxCmuFDQh9rQbMOM+7GLFBUKTGDX6t/ddET
X-Google-Smtp-Source: AGHT+IGWJlzjzT5DVCzi9/z73tCArAcJ7nYGcahi/w09HQ/aa5Kl9BT1U3gr+kB4vbHocoeCPjsw4w==
X-Received: by 2002:a05:6358:70cc:b0:17e:8b66:a983 with SMTP id h12-20020a05635870cc00b0017e8b66a983mr7934504rwh.21.1711875929568;
        Sun, 31 Mar 2024 02:05:29 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([60.209.131.72])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a00214300b006e6288ef4besm5695333pfk.54.2024.03.31.02.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 02:05:29 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog
Date: Sun, 31 Mar 2024 17:05:21 +0800
Message-Id: <20240331090521.71965-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: netdev+bounces-83570-steffen.klassert=secunet.com@vger.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 31 Mar 2024 09:05:42.6168
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 36aafd84-d312-4100-63a2-08dc5161be4d
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.secunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=cas-essen-01.secunet.de:TOTAL-FE=0.009|SMR=0.009(SMRPI=0.007(SMRPI-FrontendProxyAgent=0.006));2024-03-31T09:05:42.625Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9135

From: Jason Xing <kernelxing@tencent.com>

Since commit 099ecf59f05b ("net: annotate lockless accesses to
sk->sk_max_ack_backlog") decided to handle the sk_max_ack_backlog
locklessly, there is one more function mostly called in TCP/DCCP
cases. So this patch completes it:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/inet_connection_sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index ccf171f7eb60..d94f787fdf40 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -284,7 +284,7 @@ static inline int inet_csk_reqsk_queue_len(const struct sock *sk)
 
 static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 {
-	return inet_csk_reqsk_queue_len(sk) >= sk->sk_max_ack_backlog;
+	return inet_csk_reqsk_queue_len(sk) >= READ_ONCE(sk->sk_max_ack_backlog);
 }
 
 bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
-- 
2.37.3



