Return-Path: <netdev+bounces-228813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD202BD4123
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AF61890A6F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23830B536;
	Mon, 13 Oct 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km/+C7xs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12130B525
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367750; cv=none; b=eeEgdheVv+2ttaRyimbELVhuoZGsCeYra5meF9IPzDxFhtv5vWDTmUJxMe1rpnuEjrc7ts/UaGPvSRXR56CbkBOBmIsH8Wm+vclUtuH0J59vjdjTwgF6wZ1MAIFqmQt/uTj8DI2ASvEdZC0QzadBvTih1DwF/ppLYPHy8SYfxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367750; c=relaxed/simple;
	bh=XZ4lzHryEJQS9jgidvbUbN7osxHnfwhUvb5lDvX5gJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2Ss/EZ+XSofcKZoMX/TdcicQhlpgOR5HsDlM/JZ3p9Vl/dR9jkcLUwvv3o8+SWklCgo4+G48xn68Z0wXTLX1GKzAr2CFlh2eSV93xXcJQD7Q0TFVc976PjAwYd2u8m2l1F79YfaGsxPKDgaVdpiWiDuZxdpOTZ+a2c3MxVKi2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km/+C7xs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so2017064f8f.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367746; x=1760972546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yh3tjmmjbgFKGhBWocvc5VFMFhZLywRMRFtzLSkbw0s=;
        b=Km/+C7xsfZItqUK1cRI41oQudCJQXawtSlxm2Y90QzKe9b1CH9Lue/2I7UhiV9ElL/
         QbsSPdkyMDOFYhdArM/WwUk4HrRd78V3RT1IKtSrA3tojPLDyJJgw1uFNjhsOatstdjf
         awHA8HXlg+4SOEZ9oEI0WYufnhqiDxH7H1pDa2kElbVfVK/isv9w6THHMeFYOFdsTzrT
         4XPM6rT28Dtw7BCO5UlxgNQd6gurCk9yoS6p4GVG3DiwKS/kZXmT1g4FH0o84SKujCvj
         NNq3v1ken4Lh0yVIZ4HeRdWXMC3yki6pD6VwCI9gK9RKdT3vhvmYDl93+WFdT69sWhcP
         DVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367746; x=1760972546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh3tjmmjbgFKGhBWocvc5VFMFhZLywRMRFtzLSkbw0s=;
        b=HBIzApXkwOOC02NolXpQRIcmSyLx1cwrZXHKbK9IgFNIH9COedjT1o5f0WVcCm6t9l
         DSx8a+vTQYelm8tWyUAViP98gtumjcLmWIZUUYCY3jSCpi8oFbZXB5bSjg9d+nsCpP3X
         YlDTpo2AHh+J6folve12GOdnW9hYIBnfGa9xfuqtw1FoejdbiOV3vt929y5Q987W7nL6
         iTn1ocPobRtj558GxRNP5nx3IQ92RpOYvbquC4HH2ISdQXgLQVXstXVx5PFwVDBFu+Ij
         ZLvZmuXVqEp7w6+WkMfDp4fPKUHToFK2dw36rNDTJiBmR4TrE4ESCus5PuN1qjmadkrT
         UDxg==
X-Gm-Message-State: AOJu0YwwGU6ik0wDHCHJgtDeHLBDhBx1rdRJfT0hNjahDHZLAPEQ/wwC
	95NsT3IYIuVXQzxwbwZwMVgqzp5VjOr/GPgUkLi6Pyyr/pzrZX03SdBkItyWqUJc
X-Gm-Gg: ASbGncsSpjcpuwk7ikw8fQ0eQJimDSQVI2CMlmaJs+8t8cNWxu2xFAZ3Q6Q8VzdCo38
	aALJEumPRRWoeheKmjnEx1TUkYwYOYtfnFfhuRtMdco3ORhp9v8Rb9EBMLNtgx2xsFZzbzLpiUQ
	3ctVRCPn6gK8rmBsT7tnz2gQwOEtgnaM8/NtkKg3AfJZ06KXkqqKj+MN23GCF91cteSncDdD/7L
	ZvB7m70ChOYr5vlc71IPPXRTWu+Jm7L9XLcqvJ7Co5eB8X1ZhYrhqhAriVIW4MYNmBqj0yqHFDr
	DgBiL2XROx+iNldRcb6xoS5T/hmvJZG3krQwkNZK0EPKULoV7ZfoYBk1c/TxmRKkpG0pagIZPsz
	JvRJKzVXSktWdg+dyWosvBUQjWJJqYAByf3gUgmqiD5sLGSU4qvw1n2DiBy1uFdAUfSOBs20UXr
	uNNKcHI5Kv
X-Google-Smtp-Source: AGHT+IGNkJ4QbgL7tRzgvPN+I8L7UO5FdEYBSf53xVmGqianIIUKzVvqoD7JkSPO2wQpbIF5bLMK1Q==
X-Received: by 2002:a05:6000:491e:b0:426:d549:5861 with SMTP id ffacd0b85a97d-426d5495947mr6222761f8f.42.1760367745998;
        Mon, 13 Oct 2025 08:02:25 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583664sm18651180f8f.22.2025.10.13.08.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:02:24 -0700 (PDT)
Message-ID: <f0e40a00-ab13-42dc-b9ca-010fd4b115b8@gmail.com>
Date: Mon, 13 Oct 2025 16:03:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/24][pull request] Queue configs and large
 buffer providers
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Joshua Washington
 <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Damato <joe@dama.to>, David Wei <dw@davidwei.uk>,
 Willem de Bruijn <willemb@google.com>, Mina Almasry
 <almasrymina@google.com>, Breno Leitao <leitao@debian.org>,
 Dragos Tatulea <dtatulea@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, io-uring <io-uring@vger.kernel.org>
References: <cover.1760364551.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 15:54, Pavel Begunkov wrote:

Forgot to CC io_uring

> Add support for per-queue rx buffer length configuration based on [2]
> and basic infrastructure for using it in memory providers like
> io_uring/zcrx. Note, it only includes net/ patches and leaves out
> zcrx to be merged separately. Large rx buffers can be beneficial with
> hw-gro enabled cards that can coalesce traffic, which reduces the
> number of frags traversing the network stack and resuling in larger
> contiguous chunks of data given to the userspace.

Same note as the last time, not great that it's over the 15 patches,
but I don't see a good way to shrink it considering that the original
series [2] is 22 patches long, and I'll somehow need to pull it it
into the io_uring tree after. Please let me know if there is a strong
feeling about that, and/or what would the preferred way be.

-- 
Pavel Begunkov


