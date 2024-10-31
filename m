Return-Path: <netdev+bounces-140678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B49B78AE
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 11:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591B4B24C0D
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27792198E83;
	Thu, 31 Oct 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqOzw8gs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1527B13A89A
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370711; cv=none; b=o4iRYstxw4VEI0FBmVAIbbjs8IcqJg9AbZ4XQMKR2fTF+TTuQmbErZnQF70S5E11LgO2/UQlzmXJbrtB+L1wMdhwjp1dGCxwEwEKtnjSBNq6MHW4hnFy3qVaPwYHVGhi6nsrpPJhDf6rHdR+5Axq2SxIISg3BBc9xVYXdusR3R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370711; c=relaxed/simple;
	bh=MAxrGkYBTB4lsgQpsbbTi320t0etIsLAZy+HTb2JCJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8ofOYLjp0fgJzqqULgeW0Bfk744p4GU94AS8Taij2caKOW9dD8nxYCzcbffg+h9YvcmRHuAmSZfbaVULKw5cW5HJETijD5o1U+4/S4PRVjYS9PnkNl6hKiitwCu3LfzlU5jjfDF/5EH2dgjAY1A8wIJYqru+xyxUlcLaDc2uvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqOzw8gs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730370707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hH1YLckJ09rnGx5FtwuGX8PiOK1vIS/MMWnvFkTaFuk=;
	b=MqOzw8gs5sDhybPGxHB1lP4ayxFn0S/t0poSPVcADLqTu+KW9CvUxSAG0mtt92IerGcNvM
	2h8FIFxWyp2vkWtRVNk0X8PJz7Sgzqv0Dxj7rvhj1khEV+N3IdhHkG0GXukzjZz6kE5Iaj
	/sU68fpyaLZSXj3mdMHSUbN/eehKOOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-Fd_LSsfLPku_DajyVv0AGQ-1; Thu, 31 Oct 2024 06:31:46 -0400
X-MC-Unique: Fd_LSsfLPku_DajyVv0AGQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso6459025e9.2
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 03:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730370705; x=1730975505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hH1YLckJ09rnGx5FtwuGX8PiOK1vIS/MMWnvFkTaFuk=;
        b=m/mZwUUbM1kzCr8bd1nB/E0yb+5a0bAA2JYvmvifsiYjZ2ohZYb/AjU+GMMy3uSBO3
         0B8+WavwKZYhC7MxeLPE8CohmZh24Lnf0aexLTdMlDxVOZ0gy++kfOdevBwmN079NsDL
         NhRYcZKBlkBrAhLPlEeaoWX8HZ2slvZILWKS7dEo5P0i8/yqH0Hq5AC6Q/+ODDhElgm+
         libqTAPi/DhIU7FowtDNFUh31hYBonu3b9+I48YXrWMDzRqygOEPYi6UMYLVkFNLO+/S
         seYC4/l/Fi/HY/7HFh6fyHkl+BAlRMBgbfT2x7/vori4fxoVSV6xoZLVeaxQUAqP/emT
         pmiw==
X-Forwarded-Encrypted: i=1; AJvYcCW7Ss5bCAJxqxxHIm8ru4moP9hx4YGWQUhWL8QlIAdVsmX72V0ch7dvgiR4h7qv/1ud+C2DtFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/FcTVdjAVZuN5bMc1K2Ngs4BZppp/3wtfr2REYKoKzff0yBdw
	OrTDnBkeMRiEUuiPBmcFLalXeFY33tFxY35e7cpe4EXxXn9uZlNSWjT9BXLM8wTMMoIthlmqhRJ
	uM7cOmW9fihejUj3BgpNMdsHtXoU8QvoeON7pepFAcAhC2AKfXZ5a/A==
X-Received: by 2002:a05:600c:35c2:b0:431:5533:8f0d with SMTP id 5b1f17b1804b1-4319ad26eafmr194075525e9.30.1730370705338;
        Thu, 31 Oct 2024 03:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRGxV0+TZbdoUeDZDodJcDv+grkJBQ1+llkypgfemEdjGygC+QAOO6D/yANc2dcoSYn5qwyg==
X-Received: by 2002:a05:600c:35c2:b0:431:5533:8f0d with SMTP id 5b1f17b1804b1-4319ad26eafmr194075165e9.30.1730370704890;
        Thu, 31 Oct 2024 03:31:44 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d69845csm20819025e9.47.2024.10.31.03.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 03:31:44 -0700 (PDT)
Message-ID: <91ce8149-718b-4c6d-929b-65b8fc4ca933@redhat.com>
Date: Thu, 31 Oct 2024 11:31:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: bluetooth 2024-10-23
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20241030185633.34818-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241030185633.34818-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 19:56, Luiz Augusto von Dentz wrote:
> The following changes since commit c05c62850a8f035a267151dd86ea3daf887e28b8:
> 
>   Merge tag 'wireless-2024-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2024-10-29 18:57:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-30
> 
> for you to fetch changes up to 1e67d8641813f1876a42eeb4f532487b8a7fb0a8:
> 
>   Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs (2024-10-30 14:49:09 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - hci: fix null-ptr-deref in hci_read_supported_codecs
> 
> ----------------------------------------------------------------
> Sungwoo Kim (1):
>       Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
> 
>  net/bluetooth/hci_sync.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Just to state the obvious and avoid some dumb error on my side, this is
superseded by:

https://lore.kernel.org/netdev/20241030192205.38298-1-luiz.dentz@gmail.com/

due to the bad subj here, right?

Thanks!

Paolo


