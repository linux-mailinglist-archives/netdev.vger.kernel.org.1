Return-Path: <netdev+bounces-192483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE6AC006C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BCC9E34FC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F723E338;
	Wed, 21 May 2025 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Bn6ZpSPI"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008023E320;
	Wed, 21 May 2025 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868903; cv=none; b=VyU3kO1H/x3KMb8Mc8hkOQtjxGSiidrQ9576qf3o6KMiTiQzRIPQlcBIbq7EjjdBO78jFUDFiPJ6Y8xguJYGunsTEsVFEZxi62X7epqSZucUfpNpumZvImHhX4/mTVqn3UKOr7Nbr4r/+OsO/XKssnM54jUAGyhOQ0e2pJqK37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868903; c=relaxed/simple;
	bh=3u5mXZTP639Bpzu/sDU3G0u22iZ2giq/n2kDW+3VF3k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QVq8cpdo8O79qX1JKzWB8nEcWjMa32eAgqHYG3Kqm4qwEFtKouiQSb7iqUu7Otb7UiWc/ufmAGo2ZnYKST73OKbZ7ELEm9k+0bzWan4jU8fRM1nKCvg4LCmGIqkvcG4mseouKBPpzngj6Jm6+3i07Xn9Iofrvrwn6TXhVQmNn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Bn6ZpSPI; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uHsXm-004HlP-68; Thu, 22 May 2025 01:08:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=QZBN6QDC8c9YN/GXfrYKyb8peS8O4SoKVkwZdKf4dk8=; b=Bn6ZpSPIiXuCsNZ/PI9ofTwzry
	iU/Zno9Uzv1PuMW8ZvKfcx0Q5vhgYaOV6D+1ZYtYa06wnd5HcV3AfGMxbQR+QA7h1JFl5V4xhyG2W
	umUOsKZEb8AmBIWzy0oOS5rQObT3oGPv1VexxTiZYA1naH2PRrLlssA9MPrE2ORz/GBEWFG0/EO4H
	vU5fClJUSeKrYpyHGvqlQixezR8E7yaVM+wKpWJJsXnY01tT3O53j8t7wivnUDD+tdeRaqBM4bYNM
	//Y3V7liOftxp1IGSFRhyFw5XTIwq2IKrYNWVx6f0d1z8Ho8CMkTin1ouY0iliXTQQjo2//vGua0C
	QB+IVRNw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uHsXl-0005Vz-36; Thu, 22 May 2025 01:08:13 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uHsXi-000dQu-GI; Thu, 22 May 2025 01:08:10 +0200
Message-ID: <89df5f4b-6955-4f01-97a5-4d24dd82ed51@rbox.co>
Date: Thu, 22 May 2025 01:08:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next v5 4/5] vsock/test: Introduce enable_so_linger()
 helper
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250521-vsock-linger-v5-0-94827860d1d6@rbox.co>
 <20250521-vsock-linger-v5-4-94827860d1d6@rbox.co>
 <3uci6mlihjdst7iksimvsabnjggwpgskbhxz2262pmwdnrq3lx@v2dz7lsvpxew>
Content-Language: pl-PL, en-GB
In-Reply-To: <3uci6mlihjdst7iksimvsabnjggwpgskbhxz2262pmwdnrq3lx@v2dz7lsvpxew>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 16:41, Stefano Garzarella wrote:
> On Wed, May 21, 2025 at 12:55:22AM +0200, Michal Luczaj wrote:
>> ...
>> static void test_stream_linger_client(const struct test_opts *opts)
>> {
>> -	struct linger optval = {
>> -		.l_onoff = 1,
>> -		.l_linger = 1
> 
> So, we are changing the timeout from 1 to 5, right?
> Should we mention in the commit description?

Yup, we do, but the value (as long as it's positive) is meaningless in the
context of this test. That's way I didn't bother. But since
enable_so_linger() is gaining @timeout, I'll pass the original `1` to keep
things as they are.

Thanks,
Michal

