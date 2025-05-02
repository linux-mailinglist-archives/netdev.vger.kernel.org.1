Return-Path: <netdev+bounces-187364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01986AA68D6
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 04:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F161BA74CD
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6CA17A2ED;
	Fri,  2 May 2025 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="EjivBGBZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914A15350B
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746153559; cv=none; b=dably6OS7E7nOE8isNL7OLUb01PQu/ZNETzoU9c/uPxWpQv6D2l+O9ncx+b04VvJM5vbNCx7fvEu/ySaxOhq8kMg/aZK40zvjL7KS1hiwLCXKvX5rGJiOqsWy1lrGU66pUX/1i39ZGLCwusWdprvwHNccu1XIxXF1RL0Er0iUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746153559; c=relaxed/simple;
	bh=JA8aUuLuYjspyrVQjWdLEaOO8Fg5h3LwYwiRqqhE3ds=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=f1Oc69bE4I8bgDUJWoopFrgmyYpE2vramw3ARmSWuACMJdo7TwJqVGIn3l1kBCUak8xVeA2tmiegxASzjI/oYXOoErnunBcwWWtA+xiPnQlnByMKnGmTmLY+DX3PFBrerpiUqr2I8q+aTccjhFZEOoai4d2Mw+4WV85H4fjQX4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=EjivBGBZ; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1746153554; x=1746412754;
	bh=JA8aUuLuYjspyrVQjWdLEaOO8Fg5h3LwYwiRqqhE3ds=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=EjivBGBZCxk/vNK0PmP29nP7YsDdDRi/zmqiVWlhMBaa0xLODlAixZ/TkBozXOgW2
	 MFLkL/mdV8gw6COyzifbr9z2EgPXaZlXjvR9Fz6LHAkHz/LCgKOxLPxqdwlIIJk9jv
	 PSIvwVmlIF+aORXtY9PZ74UmxhIajrnH2BM7AuP89Ve7TZ8U1Hmb4DXg5vD3inVL2x
	 RBg2f4Xdhxz6Uq3Ee/KywOcvcBLFWyuRUae2w1OhDbSjYA5Ank+dUrqN4Wh9oD0HIm
	 txHuhdR336Cc4fOwNZvWPAIczgjfuCZbhUA0R/W9wu/k7Kf1DyxD12wZcIYH+TLDFz
	 lNPGQFpeoPoQg==
Date: Fri, 02 May 2025 02:39:08 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: thesw4rm@pm.me
Subject: Potential bug: errors from tcp_ack are ignored in tcp_rcv_synsent_state_process
Message-ID: <mpuv6Xh1ObRSjS40iJdc7BNUqtJ4uqX5JdfCX5Sh9BKacoNJlqRBd8oznQs2q5HEslP95tIjkAGl_khiR07cyrLtqqHfsXya7bVu-X9Ard4=@pm.me>
Feedback-ID: 11923722:user:proton
X-Pm-Message-ID: 244437af0b7fc87dfd980704d0029830680b9ed1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I found something weird in tcp_rcv_synsent_state_process in net/ipv4/tcp_in=
put.c

On line 6555, the return code for tcp_ack is ignored

...
tcp_ecn_rcv_synack(tp, th);

tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
tcp_try_undo_spurious_syn(sk);
tcp_ack(sk, skb, FLAG_SLOWPATH);
...

The three methods above tcp_ack are all void, so I can understand why the r=
eturn value is ignored. My instincts are telling me that someone forgot to =
check the return value of tcp_ack, and this could be a big problem if we mo=
ve to ESTABLISHED and the ACK is invalid for some reason.

Does this need to be fixed? What am I missing? If I could get some context =
here, I'll work on a fix.=20


