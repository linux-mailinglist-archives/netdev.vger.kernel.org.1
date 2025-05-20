Return-Path: <netdev+bounces-191810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCDEABD5AC
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DDE177D32
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A126274678;
	Tue, 20 May 2025 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL/1PXNI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4E272E63
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738707; cv=none; b=Yiaz4MHHQbCxhy518rvjJZmuPOG6CJYMIVeJIx69UDOhpkL+sKoe/8yD2UeJWWidAj1Gb+NQUMKKU3T17yZce2IWjQn4nm0sU9W413tDJq4Rbnre/cLlrmYEbZuYpV3WhM2QiPFLnvd+KNKmhFivFhRbI2XXvUtdtGlAIOtd0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738707; c=relaxed/simple;
	bh=XCjhuqMISSLiz8GE+zUfY3bVdPUVO6omDyP1PQiJ4QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U93cx5y3k8KfmWe0/pHM8VwKQUxcV9/0SB0XWFuU4wfCVXGgmYKFN2SupZZFPHp/5CSmbcDz4dm0KfoeE9N7Z94EZZkv6ywRA6Pk77gk0uGCt8/YMlRRmtpzTqALetuNDGYiXCsvWtz+a/XCkJyBkUt5j9hklE4W6jWhrLyQR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FL/1PXNI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747738703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D274b/Kowlx4frHiCJWZP9nEutUPctu6wUBTBcBAl+Q=;
	b=FL/1PXNIhWSeLXnyHnd6L1CGvcIpqOeGjkYUPkenRVJ23R1Fr5eOF/+kkgqWIiBQMRuEGX
	G/Jz/H50tVl12AC68A+385ys8j6BeQkOTibLyyAq9XeYXVtr89ts7h4+4dAU8lC4/DrsEn
	Gh6+1SOoStzECLl3V75G9ptC+vIgCHQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-XUKzzG_NODaYaWFa-0j95g-1; Tue, 20 May 2025 06:58:22 -0400
X-MC-Unique: XUKzzG_NODaYaWFa-0j95g-1
X-Mimecast-MFC-AGG-ID: XUKzzG_NODaYaWFa-0j95g_1747738701
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442e0e6eb84so34691725e9.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 03:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747738701; x=1748343501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D274b/Kowlx4frHiCJWZP9nEutUPctu6wUBTBcBAl+Q=;
        b=F8Clp8p+g6+BOreCfprlWJEqi+cn3M9vHBryQXUA1MSckybweQm4tSr3GN68aSV7k5
         TNB4VLf2N/ft9U6pci9Qlc4VZbrtwcHV9ZfhZd/XlUyX6j07iQCaoBHzsKu7HSs7uIVh
         8mmRzEsq/pbKZYAPNYI07Ruc5Pu3nlPEVn/EZYMTlsEhsIE9yjh5AfgxcDRsnne3W7RF
         FOO4kRPNoc/tO1Nov9k5eRhAKgsM83dJ8t9GisII9OR+ddES99QcZuCC3cDR8mvrFsxa
         HtH3KANK8BaStBPwWRXZcpKj5+Kj/v8SqDV6qFSPquQMlw99WGiZvURlO/GPKfFqPk2k
         34aw==
X-Forwarded-Encrypted: i=1; AJvYcCXO4ugGHYxdJ5f9MQqBBX6NmxdiRzGSHjKgQfADqRHH5LNLhaC9GhRCZs66E3sNZPNTYZU3uwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKYivdAHGHuDmgeyU4DpH+Sl50iMjmadH1sgNcFL5tejR6P5S
	fSmVVRX0HU5mHXdsy7T9agBux9p8CL2/yxDZQLVmyd3ZTS0y6EvLhAXxtWPjxT83l2SXgjOwWIg
	N2PHnB5Or7WEFhtc1vqcJ+cwufkafjxzrGLtS7mTIEgIhlbFakSjF77KHKw==
X-Gm-Gg: ASbGnctHElczEQ1t5tSCssa7jzA8Pfr+GVgjAUAdMgdM3WqvVLI2FOOmlnrQ70IM92v
	3woY8NDAfr3PE10iptF5kd9PwRIAJOqAXQFG0tL+2iR8a8lVsY6tN5hA7CL4s1fXtD8VzOxlKuT
	w4PSJhHwjpAmnrzFO+w9usa5cUq1V6VU5ltIMdEk9BkIiPNEr/hTP2sijcdrzDQvcbqAvzPI8yY
	ASiazyau25qf4pqfpnwj1CnBGTV7hBdiGz+U0ql0L/6xQwOT3fQS6oNGVSS0qui05+TYmYglIFd
	0JJUOnYyOJKqwKfi8VJieWWMTlSzT3scYFYyGp8kwM17fxvgeWmMMmQVuM8=
X-Received: by 2002:a05:600c:34c9:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-442fd671d12mr138378715e9.32.1747738701187;
        Tue, 20 May 2025 03:58:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvQyiml0UoaDF/88g9sn8ucNfch1PfIPLwL2A/DSRiTilof5rRlAsf3z16t0LsF6Ckj58VyA==
X-Received: by 2002:a05:600c:34c9:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-442fd671d12mr138378435e9.32.1747738700827;
        Tue, 20 May 2025 03:58:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca9417dsm15708833f8f.101.2025.05.20.03.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:58:20 -0700 (PDT)
Message-ID: <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>
Date: Tue, 20 May 2025 12:58:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
To: Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
 <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/25 10:24 AM, Stefano Garzarella wrote:
> On Thu, May 15, 2025 at 03:00:48PM -0700, Bobby Eshleman wrote:
>> This commit introduces a new vmtest.sh runner for vsock.
>>
>> It uses virtme-ng/qemu to run tests in a VM. The tests validate G2H,
>> H2G, and loopback. The testing tools from tools/testing/vsock/ are
>> reused. Currently, only vsock_test is used.
>>
>> VMCI and hyperv support is automatically built, though not used.
>>
>> Only tested on x86.
>>
>> To run:
>>
>>  $ make -C tools/testing/selftests TARGETS=vsock
>>  $ tools/testing/selftests/vsock/vmtest.sh
> 
> I am a little confused, now we have removed the kernel build step, so 
> how should I test this? (It's running my fedora kernel, but then ssh 
> fails to connect)
> 
> Would it be better to re-introduce the build phase at least in the 
> script as optional (not used by selftest, but usable if you want to use 
> the script directly)?
> 
> Or at least I think we should explain that the script launches the 
> running kernel, because the config file introduced by this patch 
> confused me. How it's supposed to be used?

This is the usual selftests schema. The user has to build and install
the kernel including the specified config before running the tests, see

make help |grep kselftest

Also this is what we do for our CI:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

@Bobby: AFAICS this now has all the ingredients to fit NIPA integration
am I correct? the last commit message sentence could possibly be dropped.

Still it could be worthy to re-introduce (behind a command line option)
the ability to build the kernel as per Stefano request, to fit his
existing workflow (sorry for the partial back and forth).

Thanks,

Paolo


