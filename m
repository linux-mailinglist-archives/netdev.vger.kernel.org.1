Return-Path: <netdev+bounces-136061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BC79A02C1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD3F288E1C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 07:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAE71C07EA;
	Wed, 16 Oct 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="B/7yx0pZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5701C1738
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064296; cv=none; b=MJEdnDZlwk0zoIpon1AL/PRlbJOoZDFXSVWErMvyiPbKhkVeRgDECre9vzmea/NiSOid+eYMq5Yd44ktJdX+wVB/lc1ejQ4bAI7GHBOntPJS2BQJGRAA7hHZVV4O9gT6x3EKnk6Su6vk7juMDB4i4auPn+bkmv7+6DwUn0KIK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064296; c=relaxed/simple;
	bh=mpY4WNBJdwr0rbv/zBkoBWXD2Yhr/UefAopc/FUGOdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkidNVqEWWwUl0MpYXbpaWLygBL1wc3uJxjw/K4s9hlqn2Ripx9Hh5Hd+ildAcNDA6G1btKUGjEVern3+da1wwUpESNwpHIZj9iix/QalR7m9JesqPWudSe6iyVpNSocIcwvckCfW5SsFTW16jOCgF47iA5scLv1G9TMipTUHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=B/7yx0pZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e1543ab8so7658153e87.2
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 00:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1729064293; x=1729669093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJSjeLHtZE626TM7lIiJxnxd8+otXTytv2mtD/tkcos=;
        b=B/7yx0pZ0eClvZg7Ed7qYAz5aiMGJtqZtHUghIWPFfj20E5XBD6AVGuETsP19nJNQ+
         8Ia20cuNWLV8XbzZuePj7pQ+xu4Y+biGdX2yPmm2PfhvVyCuK7Mr4aCaO8UEw/HSlus8
         GPLp+/sDrD30yjUJ6H6wm7F7syE2V7m5iBXVvkEov6vGZ2BfVRwWQ+hZG+MgQxWMBpwo
         f0+Z6TKXxpXflfyWxkQgHRxEOgKkTVFaZy8+y4xyRQ+ZkFrIgoRuRkvxv6ihfO5WviqY
         SRCW1vKl6B5oXwRx/xl8rsibwZLbs4crwuXvsl+NR+tAHMjOCf47kL2IabXyr4VWp+YU
         DWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064293; x=1729669093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJSjeLHtZE626TM7lIiJxnxd8+otXTytv2mtD/tkcos=;
        b=lpCY063c69grWEyR1obSln0rp6XxYGNtxlsylIFzclgCrFAhsxPUvFFyZ5dyGpp7IG
         n7i8f8tvDqp7cOEyQ0bzva406hrvwlU8G9g3vqazMoJcBlwBRIZfFJLZpS9LcLy0Y4af
         VkYvCTKVHl01YoMy8x9t0lpVO+N1pxcQa2vojssVFbKjA1NMQm3tMx0AoBtaA6TRUpKf
         FDvYmzzwuk6IpMLxqsjn0UqQ81T3JuGlh46g7ypDNhOFUpWYxZxCY5PWYjBj9zPHQUz9
         g8ITfTzRiaa3JLbta99WyIj5wjqJJUAtlwony3WvXS+ijl917AOrTXQYX7FI5KiCAbL7
         bkjA==
X-Forwarded-Encrypted: i=1; AJvYcCXlrYRzux5qkNcp5kp7hW3/TISZA73RHJdCyilQXnkebx1buezmbD+gsOklj4NEL0d7EQFStGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLsGofS1b9vLESBYnx80Jf2NDA6GSHRU03ZZv3rrsjHrbhNZE
	4mzAp2s+k23MSDrqdYrlHvlWolY1dnblT1T7r94wsiFCvoCIMTAnmmZVqrgAWAk=
X-Google-Smtp-Source: AGHT+IGCME5bXQdd/nD2M5Nvzzk42p7bqXT/x7isn5M/JA6Mx4W4hpR+wBn+KqEPTJVK6wGHonihpw==
X-Received: by 2002:ac2:5684:0:b0:53a:64:6818 with SMTP id 2adb3069b0e04-53a00646940mr4607931e87.47.1729064287257;
        Wed, 16 Oct 2024 00:38:07 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29819afbsm148221566b.104.2024.10.16.00.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 00:38:06 -0700 (PDT)
Message-ID: <1e489737-fdd8-43a7-9abc-65599e1cfae1@blackwall.org>
Date: Wed, 16 Oct 2024 10:38:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] Documentation: bonding: add XDP support
 explanation
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241016031649.880-1-liuhangbin@gmail.com>
 <20241016031649.880-4-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241016031649.880-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2024 06:16, Hangbin Liu wrote:
> Add document about which modes have native XDP support.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/networking/bonding.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> index e774b48de9f5..6a1a6293dd3a 100644
> --- a/Documentation/networking/bonding.rst
> +++ b/Documentation/networking/bonding.rst
> @@ -2916,6 +2916,18 @@ from the bond (``ifenslave -d bond0 eth0``). The bonding driver will
>  then restore the MAC addresses that the slaves had before they were
>  enslaved.
>  
> +9.  What modes does bonding have native XDP support?
TBH this sounds strange and to be correct it probably needs
to end with "for" (What modes does bonding have native XDP support for), but
how about something straight-forward like:

 What bonding modes have native XDP support?

or

 What bonding modes support native XDP?

> +----------------------------------------------------
> +
> +Currently, native XDP is supported only in the following bonding modes:
> +  * balance-rr (0)
> +  * active-backup (1)
> +  * balance-xor (2)
> +  * 802.3ad (4)
> +
> +Note that the vlan+srcmac hash policy is not supported with native XDP.
> +For other bonding modes, the XDP program must be loaded in generic mode.
> +
>  16. Resources and Links
>  =======================
>  


