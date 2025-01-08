Return-Path: <netdev+bounces-156496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E459A0698E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 00:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7261675C6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902DC204C1A;
	Wed,  8 Jan 2025 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F0oTw53F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E020469D
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736379614; cv=none; b=MKxzwg33MOI8ZTHHGAnQRMHPa3j4wIeQHbgqbkBDcVeHs2OxoYM9+KQ2PME4l6FgGLga/3YpIEQYWHHSSd/1H5qoHMNQCzy+YjjH0ko5Xu98Gc6NJoEv7rLJgpIGCnHu3FwfLNUpbw/s0WXm6IGeztwsLMWKDVXGOCUiyapKsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736379614; c=relaxed/simple;
	bh=6MdkO+ANHM9A60tsmkecbfdrjtmSsD6weQX4DUCJNuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/kytDHkfBu2P/LRnGgh3/3Y165pQikDtCLyWykcGzk6+bX4d9Wgbu5KtgD3naHSbzob8/iWbFxdY3vdrfiN8o2GbRRtq1pAisHpFPArim9btw7V63l4AHDb+8uaY+P+azosR7XL2owDpwpno9cIQCbFTkkX1BmLfULeqZaIIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F0oTw53F; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844ef6275c5so10660339f.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 15:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736379612; x=1736984412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ri8mtVirUvyyZ6nmOnC/LZjhObjSlPKVdDOjjMdr2c=;
        b=F0oTw53Fn6BhcYe32Cl26yv7NTB+xwr/Tn6Wlw+dXXw4Yu1XtShmOVs5v5YnD1KQPU
         /Zw5xKnTC8jpEEbG2OItlLvTVeRICjHKktPXPsNkS4sDAHJ33DpYeGwEl0epNYEk/u01
         N1sJ55oLZg9Xshm+OZN5JgGfVfP940fBQWcXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736379612; x=1736984412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ri8mtVirUvyyZ6nmOnC/LZjhObjSlPKVdDOjjMdr2c=;
        b=JN0H6knWzNlv4uJWbwGx8DTgp+ksN+UAK9RuFJw2AzJt2iASwgQ9hdJxgMWFQ8N91Y
         MWG8d0idg6bQ5H+4YsfIIw6ZjooqRlq7H1qo4O/q0Q2fAqBv5YEBwn4jNFq3ShpD76CZ
         fS4isbjjAnx1MiUuYQLOoa0FiiBqnZ122T+C6H5LXVny8YcpNx9RyKcNosFkMMmTTFwA
         Xx+is1GWXV54vq2TUONxrbZW++oRLKeLjNWSSYtiAiU64X5oYv9U3e2B3+tl8R2kyotP
         qARBNFqqZ453yDHILACZhC61SsbAVmwt2rX8upnKQgYiKFBagilev3Rxe7SW6Y97iyGo
         QpzA==
X-Gm-Message-State: AOJu0Ywh10tPAHW1QWvYbSJzvw3mDnua0lI1yuhFcdLgZliOjSMEtg/w
	QE47h7nvg+PBdifPY8I0TinotfaJZrB2P2f/bDV8Vua3Srgjh56692km8ZdoND8=
X-Gm-Gg: ASbGncsSnRfvw0UORRyuporwjuFQn1Mw6YDXj/qzEjoZAz4CInWC24Dcv9aZRSNxB9O
	hI70gUxttarULfWoL+o+0hFYcgGFTaTFnxM6Fnh6hXsAw0jgcZiFXt53CW+JrJ9ep+tVLZoqQ8I
	yMl+fCzbjP63Ada85jsk9uGed6/1LZLu/Ewxcc4npO8VZaeV7wiMeSmqEbPxz41KLOkRPIu0dNB
	RBL/nRnQBM4DO+Mrl575GsW2PD5/xB6mVv1hWe2JkvzTHRzkyY+rbliFvtTQJdgmJdj
X-Google-Smtp-Source: AGHT+IF6eYSuISgD+RCYfI+Ara0n1whGJDeBklXH6p//wxMXgzwItnvsMB1eg/4jHGvsuHgbZqdB3A==
X-Received: by 2002:a05:6e02:152d:b0:3a7:fe8c:b014 with SMTP id e9e14a558f8ab-3ce3aa763a6mr36286005ab.21.1736379611869;
        Wed, 08 Jan 2025 15:40:11 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce4af56167sm398725ab.58.2025.01.08.15.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 15:40:11 -0800 (PST)
Message-ID: <057fdf09-ef2b-42fa-9300-dd7bf348362c@linuxfoundation.org>
Date: Wed, 8 Jan 2025 16:40:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the kselftest tree with the net-next
 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Shuah Khan <shuah@kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Laura Nao <laura.nao@collabora.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Willem de Bruijn <willemb@google.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250108144003.67532649@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250108144003.67532649@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 20:40, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kselftest tree got a conflict in:
> 
>    tools/testing/selftests/kselftest/ktap_helpers.sh
> 
> between commit:
> 
>    912d6f669725 ("selftests/net: packetdrill: report benign debug flakes as xfail")
> 
> from the net-next tree and commit:
> 
>    279e9403c5bd ("selftests: Warn about skipped tests in result summary")
> 
> from the kselftest tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Thank you for finding this. I will mention this when I send pr to Linus.

thanks,
-- Shuah

