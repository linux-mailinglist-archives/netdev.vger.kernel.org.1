Return-Path: <netdev+bounces-292168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEEIN4+oFmrEoAcAu9opvQ
	(envelope-from <netdev+bounces-292168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:17:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C325E0F49
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF9483019141
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5163D34BB;
	Wed, 27 May 2026 08:16:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CDB13D53C
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869774; cv=none; b=P+L1QAZ6mvAqVhVS+8fGkUBMhhly8PitG6eKaD78BU11U/XuZMCzY5cQEpgK+wuGh4+sTB4YhCQbtFIp5nroEqQxHOEIQppypJFLDv7/QyDEk40+jsiTW90DgA5qx406YM/NuBN4DFw4SxsjQkYKgtwGKpbWGLJm4X7Uye2Z3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869774; c=relaxed/simple;
	bh=OH27XX4XLcXiU6zpKSFDRIwZCZRUMRWZC/GON4wyJVY=;
	h=From:Subject:To:Cc:Message-ID:Date:MIME-Version:Content-Type; b=QhoaJuqsWlpxIfxTm3IFkfS2Qejvr05+ZNVdINDUgZNCCbZ+xn/fJc2AtCIT6viipzT3IdDfZZqKX+i2fVDds0YM8CoNA7KQGVCDPp2pM+a8pwium4mKEJ58Gh06Ta6FwBU8q0ikO5DlVw5by+AvEfqKQtC3vW1IjR/3ZTHMCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shinnytech.com; spf=fail smtp.mailfrom=shinnytech.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shinnytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=shinnytech.com
X-QQ-mid: zesmtpgz7t1779869754t55650d16
X-QQ-Originating-IP: i0JvW63Bg5of9qfTT+J4TUpX3p3Zc8PxQF6xHTfhqbE=
Received: from [192.168.0.218] ( [58.32.25.94])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 May 2026 16:15:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13477922265467916946
From: Zhi Cheng <chengzhi@shinnytech.com>
Subject: [PATCH net-next] tcp: fix spurious connection aborts due to
 TCP_USER_TIMEOUT and zero window
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org
Organization: shinnytech
Message-ID: <EDFF6E75FB9C46D0+ac77bc6c-2057-dfc5-4541-05679f6a6bce@shinnytech.com>
Date: Wed, 27 May 2026 16:15:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:shinnytech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MhHYuF7Otq+ozz2OOds0bmYRlaFEl354G9nRbwgXDOvWWlH4aUNy0Uj3
	RoMaLps27VkU60FhzGmOr8uU2jvLeAcPQ3Yyj5No1D4b65766Vsp9q+pWuYGmCgXCNvYhfR
	GwK8vTozkvXGH8XM2CfwvaUn19FZxmn7+QoY1Lyc1CjxQNz2cquiIQ4mPm27H85LyzMwLMH
	3DL5SFrvFgmm8E14OHV2CludT4dluTeLLJT24TZgBymulFFpjIGAd5bA4hegth0RF/E9v8J
	cpuLsum3TyIoP9EHZUh7K2Aahw54xkTvHMshjDjSvu515/2ar9TRi4iZw+GOgRZ7Usqj1zj
	k7u6pCqFiQFvJSvEgvYnZPJJSz8k19pCDZYzi9Wq9nxEqgUcgppxoM1lKEZ69zoW/pkM4Sf
	eA67uQYKosSdU8GM3uLUpoiS++Jma9wTOHLVVrBzw6ClnGdSnQ6jjkfSD6ZgcQ4HpoVk93S
	YBOZwNSFpeGAXlFxJ/6ZJ9R6ZvfCvJEZuCVVNmLI5KvH7tYVSkCfsjQ3NIwjudOyfYQ/xTM
	jKos0l/rsA0d1jJU4IcHWYcNQYsmIj9k1rfPbQ9iihZl5GLBXD+u6LEx0RhG7IxO+QvdeRG
	zTPNLxoe8NmyCOG9hJ9kLH5j7IpvRdOkkifP3umWxdfObUxCeMqcYeLkvpgSNCKssEZpYI1
	kwU79xVBXTo81UnOF5w9TrLp2Nl/ZOMb4/rAR/83A1Ue4eBbmrPZUGeGkCGwT0FesKjrXWO
	MwANxiJIYA3UbzylJ2TdhRBdfbyg728zBPhUw0GzWT4Lgwai/qscYmrXd1uI8FQYWin3s6R
	op2KbZIFZEIzxu4Iwbn8Zu7ZZet9IoP5Ri+mbvF/rCUkLRLx3V8/0Ii6Ozh6let8zmgHunw
	mxOWm9yVEeOqjOL/QtSQ3IR4vMOkzS++uIIr8zGma76A2fNPU8qD62h6sMqW5Qusn+bQXhE
	PyuBLfwupeUsSMMnpMApcz2kxCyKE/fFDngMve3RslJHFQTEoH3YtU8jVSQFVQm+uwwJK+q
	Runw949W1wIARC8iUNmpmjFUVri6s=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292168-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[shinnytech.com];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengzhi@shinnytech.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,shinnytech.com:mid,shinnytech.com:email]
X-Rspamd-Queue-Id: 76C325E0F49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Under certain conditions, a stale icsk_probes_tstamp can lead to an
unexpected connection abort during a zero-window state.

The exact sequence leading to the timeout is as follows:
1. A zero window occurs. icsk_probes_tstamp is set.
2. The window opens slightly. tcp_ack_probe() is called because there
    are no in-flight packets. However, icsk_probes_tstamp is not cleared
    because the window is not large enough to fit the tcp_send_head.
3. Packets been sent, and RTO is armed which overrides the probe timer.
4. Subsequent ACKs consistently acknowledge packets and the window
    never fully closes. Because there are now in-flight packets,
    tcp_ack_probe() is never called again.
5. As a result, icsk_probes_tstamp is never updated despite the
    connection no longer in the zero-window state.
6. Much later, another zero window occurs. When probe timer triggers,
    tcp_probe_timer() evaluates the extremely old icsk_probes_tstamp and
    immediately aborts the connection due to TCP_USER_TIMEOUT.

Fix this by explicitly clearing icsk_probes_tstamp in tcp_ack()
whenever prior_packets is non-zero, ensuring that the probe
timestamp is reset when exit zero-window state.

Fixes: 9d9b1ee0b2d1 ("tcp: fix TCP_USER_TIMEOUT with zero window")
Signed-off-by: Zhi Cheng <chengzhi@shinnytech.com>
---
  net/ipv4/tcp_input.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index de9f68a9c0cf..02de64881b76 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4365,6 +4365,7 @@ static int tcp_ack(struct sock *sk, const struct 
sk_buff *skb, int flag)
  	tp->rcv_tstamp = tcp_jiffies32;
  	if (!prior_packets)
  		goto no_queue;
+	icsk->icsk_probes_tstamp = 0;

  	/* See if we can take anything off of the retransmit queue. */
  	flag |= tcp_clean_rtx_queue(sk, skb, prior_fack, prior_snd_una,
-- 
2.47.3

