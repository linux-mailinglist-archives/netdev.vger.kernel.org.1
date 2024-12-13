Return-Path: <netdev+bounces-151578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D89F0134
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 01:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643C128603A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 00:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93BC383;
	Fri, 13 Dec 2024 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ltpQ4DrN"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B217D2
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050543; cv=none; b=IH7+WRxOLQF+/JB6yW7ptQer8Oev5dlmetDxrmAJ3T/1NfjKNTSL9ha4rC8DRItp2qOjfBRo/TCanfDwQibcIvOvscvBicolbuEi0tkBtaJjMl5cPIJhscv8D7Rm5O/L53KbWkj4ZQWnBTj2D4FU20p2ViMFWra7znmigBj8+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050543; c=relaxed/simple;
	bh=Yp7UGQxcclEWhZ0+p5Yo6dN+XGf+KdKUUMocALofWbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6to3VVSDPo+lcaOOUrdzSUg3T70T0xgvtVydYTb+jshG7maVIZYRaK0rjF6tW9Y3x3vKA2FZOt9bQ6bP6y37xPsuCgD8V1CWmUH0ZHyKm0VQo4+CE3B9Avtv3XcZmfJKXVdiMCfL1Ez8xw+uAFed/hGvmSwlBm9WGE5jtSZCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ltpQ4DrN; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tLtl0-005ckK-34
	for netdev@vger.kernel.org; Fri, 13 Dec 2024 01:42:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=90lAd4Ub90Y3lwR0xrHqn4Mn/GoxQ9voexWYlptAWvY=; b=ltpQ4DrNv5uQqO7Cn+qZig+qun
	cXVJgte+GPBQJNZCURp7B5apx/yqnSHPUXb0Kgwyej942R3HzmyNstJBHeaIBwg/TdI0g+4sdtzfV
	99SKnldRPeuPcKXAC8S6bm9uorZQc7eJ++scFyKY8z3FaXQnbdU9+RG3T9J2IEzxH9ic/vVwzVySB
	3n1NHSG/BJp6QN+3/vOecuSQDwgSwJmyeX2owo651Hg46VHjXwPanJREdctbLDi5bWNvfTdo7I7VP
	uoU5xJCCqSePR6s/+HsYwZuMcllLC/TQQ4GeuU6Vn6ZQqSrTyPj7yFh8g6ENmk2k7KB5ulXqU3s6r
	HxIT3LaA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tLtkz-0003fr-Np; Fri, 13 Dec 2024 01:42:13 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tLtkj-009S1a-Il; Fri, 13 Dec 2024 01:41:57 +0100
Message-ID: <f3bce5dd-1cfb-4094-b80d-584bd00333d5@rbox.co>
Date: Fri, 13 Dec 2024 01:41:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] vsock/test: Tests for memory leaks
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <gm7qmwewqroqjyengpluw5xdr2mkv5u4fgjrwvly24pc5k2fl7@qelrw3hzq33h>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <gm7qmwewqroqjyengpluw5xdr2mkv5u4fgjrwvly24pc5k2fl7@qelrw3hzq33h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 17:25, Stefano Garzarella wrote:
>> [...]
>> I initially considered triggering (and parsing) a kmemleak scan after each
>> test, but ultimately concluded that the slowdown and the required
>> privileges would be too much.
> 
> Yeah, what about adding something in the README to suggest using
> kmemleak and how to check that everything is okay after a run?

Something like this?

diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
index 84ee217ba8ee..0d6e73ecbf4d 100644
--- a/tools/testing/vsock/README
+++ b/tools/testing/vsock/README
@@ -36,6 +36,21 @@ Invoke test binaries in both directions as follows:
                        --control-port=1234 \
                        --peer-cid=3
 
+Some tests are designed to produce kernel memory leaks. Leaks detection,
+however, is deferred to Kernel Memory Leak Detector. It is recommended to enable
+kmemleak (CONFIG_DEBUG_KMEMLEAK=y) and explicitly trigger a scan after each test
+run, e.g.
+
+  # echo clear > /sys/kernel/debug/kmemleak
+  # $TEST_BINARY ...
+  # echo "wait for any grace periods" && sleep 2
+  # echo scan > /sys/kernel/debug/kmemleak
+  # echo "wait for kmemleak" && sleep 5
+  # echo scan > /sys/kernel/debug/kmemleak
+  # cat /sys/kernel/debug/kmemleak
+
+For more information see Documentation/dev-tools/kmemleak.rst.
+
 vsock_perf utility
 -------------------
 'vsock_perf' is a simple tool to measure vsock performance. It works in

> I'd suggest also to add something about that in each patch that
> introduce tests where we expects the user to check kmemleak,
> at least with a comment on top of the test functions, and maybe
> also in the commit description.

Sure, will do.

Thanks,
Michal


