Return-Path: <netdev+bounces-167340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE56A39DDB
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B29D3BC991
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D55E26AAA4;
	Tue, 18 Feb 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lz62ZmZg"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7C269832
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885540; cv=none; b=TEkCzqIoXT183XEoOossql6fDoAWB3lOSWuG0SsJlmaxGK1UZ9Z1bXEGB1fbN4iXr0kuVdhKc8K0oo+S/yZb6tKXHB2Txad0WMgCBGvq+csdryUZqzgfY3tj5Aqpa7iAJvy9fzlKNxzCl20xvETo4P/0cAOQjVMVx6w90K5Q3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885540; c=relaxed/simple;
	bh=N4g6QUKBv0hrbd2d5K+Izcwtyx7UVmTbogTjheFSivA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Co/pi2SiT7GG+RQGCyrhlcckvP+XebhDjSOYjp7tEKdInoOr0jXDpm7TBkixcmEXGrw5Je6U95TvvKHIgf7APIj/cHNTMJObd6h/qExg5cUMkP69RmPxFv3+tVK4XzA0Ewu8Sbm6jcDMDStbHEwdkL+lUh1UMXyrPpkwWJXMLEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lz62ZmZg; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739885527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1owyGoVG+hJEAVjlb29HvV4RQGKZjOiBR9fNEU4IJr4=;
	b=Lz62ZmZg3QSh0KoZZwM44daV9czYvRMFJ+A0rEcLTqoVZYwUlbZhHmnfWyvN3z0GK3nkEg
	H0XZjzUDTJxj3R/YLmui5jkFB4ShzJqVIe/QhDMYOXDUm/9p3ZGg8bIz5wA4PfNq/FVGZk
	s1612+SxahwBJsB83LhhT4EBWxZTsWs=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.ne,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ricardo@marliere.net,
	jiayuan.chen@linux.dev,
	viro@zeniv.linux.org.uk,
	dmantipov@yandex.ru,
	aleksander.lobakin@intel.com,
	linux-ppp@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mrpre@163.com
Subject: [PATCH net-next v1 0/1] ppp: Fix KMSAN uninit-value warning
Date: Tue, 18 Feb 2025 21:31:43 +0800
Message-ID: <20250218133145.265313-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Syzbot caught an "KMSAN: uninit-value" warning [1], which is caused by the
ppp driver not initializing a 2-byte header when using socket filters.

Here's a detailed explanation:

1. PPP protocol format
The PPP protocol format looks like this:

|<--------------------------      7 - 1508 bytes      --------------------------->|
+---0x7E---+---0xFF---+---0x03---+----------+---------------+----------+---0x7E----
|   Flag   | Address  | Control  | Protocol | Information   |   FCS    |   Flag   |
| 01111110 | 11111111 | 00000011 | 8/16bits |      *        | 16 bits  | 01111110 |
+----------+----------+----------+----------+---------------+----------+-----------


2. Normal BPF program
For example, when filtering IP over PPP, libpcap generates BPF
instructions like this:

(000) ldh [2]
(001) jeq #0x21 jt 2 jf 3
(002) ret #65535
(003) ret #0

2 bytes data are skipped by bpf program and then bpf program reads the
'Protocol' field to determine if it's an IP packet. Clearly, libpcap
assumes the packet starts from the Address field, just like the comment in
'drivers/net/ppp/ppp_generic.c':
/* the filter instructions are constructed assuming
   a four-byte PPP header on each packet */

Corresponding libpcap code is here:
https://github.com/the-tcpdump-group/libpcap/blob/master/gencode.c#L1421


3. Current problem
The problem is that the skb->data generated by ppp_write() starts from the
'Protocol' field.

To correctly use the BPF filter program, a 2-byte header is added to
simulate the presence of Address and Control fields. And then, after
running the socket filter, it's restored:

1768 *(u8 *)skb_push(skb, 2) = 1;
1770 bpf_prog_run()
1782 skb_pull(skb, 2);

The thing is, only one byte of the new 2-byte header is initialized. For
normal BPF programs generated by libpcap, uninitialized data won't be
used, so it's not a problem.

However, for carefully crafted BPF programs, such as those generated by
syzkaller [2], which start reading from offset 0, the uninitialized data
will be used and caught by KMSAN.

4. Fix
The fix is simple: initialize the entire 2-byte header.

[1] https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
[2] https://syzkaller.appspot.com/text?tag=ReproC&x=11994913980000

Jiayuan Chen (1):
  ppp: Fix KMSAN warning by initializing 2-byte header

 drivers/net/ppp/ppp_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.47.1


