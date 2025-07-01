Return-Path: <netdev+bounces-202922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E0AEFAE0
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83E2165850
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C27274661;
	Tue,  1 Jul 2025 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqKuCiIq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B52149C4A;
	Tue,  1 Jul 2025 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377115; cv=none; b=Gpy3YjnadEnhjBqvRgyLqE2qujXcCgQ5BkFZRaiJ79/MiSjIGFGU7gN1sJTAuX+yrMlOWTXYtGECkpd8zO2IubzkYrZzMixz02bym9IfUjbcGQTlR6x9E82FGh044T4W+X/BAoLMdnKcrB1L595a3C6d/ZnSHWB85VQOaWMjeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377115; c=relaxed/simple;
	bh=ky8QQKUkLUeo9kQ2DpMPnzJve9+QP9MZpm3w/wowHOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4BtazOB92VoPUzW4NJbWw0OwUNFLVjkkJ0VLdCmJADNOYfF11SnaWaWzbrYmFGeudqxd9NmVJA7UO5GNBMHSVRvhUoD3fv4tLPC19O0a1J2ZxW1+SHxyOw4EhufkazLvbxw7B+YIdCaZ1IEhxgq0uJgPJYXf5QbDH/a+O8FCrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqKuCiIq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453608ed113so33731395e9.0;
        Tue, 01 Jul 2025 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751377112; x=1751981912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9FP0m4sJ7CU9BSLCQyAkJvmbq4Wt41GfyUXSn+7VCA=;
        b=iqKuCiIqSNIYxiq0o02s5b6FOL/vVUsCNyCU27AKbL9b6nLvhGOcjFC2FfW9JGTXpF
         clqAW2ORkcMfuLQls0jZdtemK2lldCutPswZB02EUDKoHJbosrtQ3YX8swkIfRhz5ykc
         71+hO66W1Aw9A2phYJ4cYu8MwIsyjUe8Kwmo+UrP0NK62abaNq+TGrEeTduNJljNLjHM
         NVyHLEbMZkNYToKj4bx9NZo0+B1IcfrUdWjeYUS4ZhJjLVIT5IMnfZ5lbMKDfs22dRIB
         Z4Fy5ncxhe/AX6jzhPBP3N7Cbaszipws2ikKx9RNldzDrOGXn8myFpOxUI0zPltGgmTW
         DsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751377112; x=1751981912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9FP0m4sJ7CU9BSLCQyAkJvmbq4Wt41GfyUXSn+7VCA=;
        b=CDXHSi/DmnsglohcT1bM6hklYT2c9Ua7pAD3Z5NsrpXTGdXH5U9VyBH0+lBD51Dx+d
         bIpNONdkSVI/idCGDq1Qx0bs4MHcg4c9yamM8AvhoanTFCig4Fd5trWC2MT/nDOnx/HF
         CQgfy813vkJNVbPXT9ti7K0SUDNnhSw7u66k4RGJKcWK5TLBVgKtM7PUP9X8LyZQvmaS
         TGs1BQbZIJYcwMkH0PIxXsggC2W8c7Wy4i0vBQnoLCqhvx5a/GLn1j5W6B8pfIqgA2vt
         Vug8rDLz0RQfPbRClju19KwW1Bw+K08RSZUdhQHkk7W7GUyjhN5rdn+x5bJ4qrLp4jJo
         4Xtg==
X-Forwarded-Encrypted: i=1; AJvYcCU30BmfxjBbIiGy21sIy3PTcdhtS2FYh6Rb+2dDBNp23ftFObdMNyL1F9fFypaqFSJFntaiVVV6@vger.kernel.org, AJvYcCVHwHWZTGiEUy9yYzI5vt5DgZhLr6HooGKWxZR1dsZTvwY3Qtmzk9SFd4ARSzbHsrqqgh10e8MO8DDS3Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOU61toZhZNT+EaHg3CJk0uvfZ8cGzIYP4BCYUe9kPtCN3AIoY
	Z8581gYmYEXzI1wxaAe3XidVN8WOwhmdp2ufAYPNzkKgTHOFbdnBrrwz
X-Gm-Gg: ASbGncvXIDTOF7UU0qQAfjV0EI70v3HJ6YhBPHZrGJ+tXbY6PcuHR7hHafjaqCXMnvu
	IEUUOIu6lFA5sw7m3Zyo9adgZt98CUWrrPeuSL5T/PaCRdhp2Vro/O3ZApAqfYKfUZY00guzrwF
	J5ja7GHU67HQas7K+LcqcQ5dOR+ZkrH6gDqwUwdr7/+0l5QfRD0cn/sB0BaiVO07CCbtojZjnoM
	JoZ0Oqz6pwuHQ7XY1Rnwx7tqHTmx+yQ8HnlfDgYJHD+rRkCAmSrRicryQdel1MCTnfbla/eqeiY
	kV8hIMRhit7FaJJv5rQ84EK1Q5D7bdmJfvtdEJWuAbcL6npvCsqsgWUve7pKofgPr9CDqnP2qJF
	os7do6zLi2pLQOVzMmuejMLMVd/dnlFMhwYsvo6WjlpMJqAFHYw==
X-Google-Smtp-Source: AGHT+IHaFf0Kw7NnYflYgrVPZhks6XoL/+RtlTxnQ9ccF2rkKiyPzeCKe7KHzLRHAEAQpbzFnNfzOw==
X-Received: by 2002:a05:600c:1c94:b0:43d:1b74:e89a with SMTP id 5b1f17b1804b1-453a9171809mr33540925e9.9.1751377111387;
        Tue, 01 Jul 2025 06:38:31 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad01csm197629375e9.22.2025.07.01.06.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:38:31 -0700 (PDT)
Message-ID: <cc3dd44a-b94a-4537-b68b-49a800acc935@gmail.com>
Date: Tue, 1 Jul 2025 14:38:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] sfc: siena: eliminate xdp_rxq_info_valid
 using XDP base API
To: Larysa Zaremba <larysa.zaremba@intel.com>,
 Fushuai Wang <wangfushuai@baidu.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20250628051033.51133-1-wangfushuai@baidu.com>
 <aGPiqlNRMBsQQCgt@soc-5CG4396X81.clients.intel.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <aGPiqlNRMBsQQCgt@soc-5CG4396X81.clients.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/07/2025 14:29, Larysa Zaremba wrote:
> On Sat, Jun 28, 2025 at 01:10:33PM +0800, Fushuai Wang wrote:
>> Commit d48523cb88e0 ("sfc: Copy shared files needed for Siena (part 2)")
>> use xdp_rxq_info_valid to track failures of xdp_rxq_info_reg().
>> However, this driver-maintained state becomes redundant since the XDP
>> framework already provides xdp_rxq_info_is_reg() for checking registration
>> status.
>>
>> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> 
> You could have sent those patches in a single patchset, but the patches 
> themselves are fine.

I asked him to split it, for a few reasons (different blamed commits,
 clearer Subject: lines, Siena is EOL).
So if you don't like it, blame me ;-)

> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

