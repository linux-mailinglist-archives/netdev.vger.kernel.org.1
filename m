Return-Path: <netdev+bounces-217973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC33B3AAE0
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B7E584306
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3832356D2;
	Thu, 28 Aug 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv2nbeQ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F91DFDA1;
	Thu, 28 Aug 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409166; cv=none; b=vAiE8npLIRbXn2WwJFa5w/so5bptwTwb9ACcLboC5Nycg+v86rPPQI5kY006o2knuA6O8jKbn9BL/RLjHDwixLgSP+JOPddQSgxm6T9L1Iph9aW+q+aLqX9sug+OGtkwNC6+AK47GkvvYC+JzHGr9YGV0myjwv0WqjWKzJ+SgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409166; c=relaxed/simple;
	bh=iQDHls7dhKgBkVim32KIx+Gbn9Zo9HUnX/e0BW/lc0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4OniCHjtRwZXyqAYcXrLZjayvg26UFiXdqdcg7SrGj1nGmhREOx7Pjk8+KiiNn97PPq3STGfzi15SLNmiNFjQKj0PLFly4Kx8kUAOsbUqzlbexcCS7aenyWXndw/4YUKoimkHrJoq24XJeHWfsbkk0SJRD3wRzGkO4LiFTlXCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv2nbeQ1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea21430so75207b3a.2;
        Thu, 28 Aug 2025 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756409164; x=1757013964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNKCiEXVNimfghYWuXUmKnsDjiRGghYXpeYN/YwzGig=;
        b=Iv2nbeQ1tWesCNnKkaHR7WsuYWCvVOohr76FuMF1pezowpVHnn4uHeUaBGWMrNFPlq
         1wbKSCF57i7N40V7T2UDGApvI4LY1sQRfAis5Qi0MV6JssZ5W+QsFFXMtjdbERbg8JaT
         gV6mIFmQBu3CZhhAtkgkG9tjhnRMNYx35j++pcs4lMJ2O7XiGFKJOY1tcAHwu4acrqYQ
         BJfL2ZWfnG9MXSdvnkyFVrZJalSxOiclInmw8S8VblnmGdcbBZTE+dFAnC5p/AqwbY1K
         u9hxGmlcDPWZg5rTEVi6g2YuDlcyt6DHaGbGV9UH5zdEbXGCQ/5/K6TAC0xMA1tX9Swc
         x1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756409164; x=1757013964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNKCiEXVNimfghYWuXUmKnsDjiRGghYXpeYN/YwzGig=;
        b=v3vmqctUSoabatKpsYqhxDfg7K2FkJ1eEajCrHx0JREpqGeXJUmAtvNx2jtEvNQCFQ
         8haJ5fEZQzywdP9I1KAhjnrSAJlCvlk/kLN3xSOMP7VY2DlBvbB3ruGpaWTIQvF+9lqN
         dqQssEBKWwZTqZodJm8EZEwcSfpL8rql89lDPf1/ElV+vT9WFXNoPqL8EWRIwhLFIaCA
         I2iamG2gYad79OkcDcmlV6PSofb5etu0bgFPTQc4VC0LqY4cVFBqDer3xztmwQNUN7ks
         waPwzRh5Pf/lZSt3q5+WzfeFXUv070Mn+fzyiM6jhg64oqiubHEDz3unO5bmLIdYo+Rb
         8ZDw==
X-Forwarded-Encrypted: i=1; AJvYcCW1UuWdEO0bqyh7eNkHtP12mxS/RINa+W5UVseM1iQGKEv0HNw2fOv2vELG+1UJhB7Vy7ILdxCiJDbvsew=@vger.kernel.org, AJvYcCXXVyaT//XwtUK3GqWNGg80Fl/agmobzXcaYTM1sHmAaCluhu6/ImSFecd5wIPEHthAyrHyzZmc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2utwCD0IfV8PgK34pwzHjUOXFHH1p4TcWrlhunoZM8faq+KSX
	Pyl++4pttRmOqccgjIprPqaif72WFndpOH/FyH8YSY5un82cuWk/UIfX
X-Gm-Gg: ASbGnct790uNMzl4OKWAJM1Zxhaqw3CpNxmf7J/IcLaPzDd2ACa50pF8GLx5kmBgmdp
	wgY7WUGqGVzPz7vPinnCDgilXjQT2YmMSb6ChsQUn4kFcQ7+QsRzhJ03bYsmWHkcmPLWwWrVj0m
	wgckxxxVhM4pdeDehH25RXkyP4z9jt/r+GNVPRbVjAKenM0X+Dfc+UZEy1OUeoxLss/vzN8KEIV
	N3cpDtWIzqHWYbUPAOJNFd4bYEnwGXLwiUuxpC3FDnCYBs5L1MUX6U3cbt6U1V3C974J8leRIWQ
	v6YRoTLr28opm0Fu9qEVkMTLHEHYWNGL4MBY3A24U/6au+KkBdKMs1PriGcD6OMRHyK5bSnjAv1
	J7bh+LQ1kv1O8pvpACcFTBP4Ta8cjdA==
X-Google-Smtp-Source: AGHT+IGcyabkfIuSoXCOILkTR8xN93+W1H/AO1TgmOhp+v3ddQPFBzXanNv611WeYtUQcZLAXv1+Hw==
X-Received: by 2002:a05:6a20:729f:b0:23d:da6d:b050 with SMTP id adf61e73a8af0-24340dc88e9mr18828886637.6.1756409164421;
        Thu, 28 Aug 2025 12:26:04 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:c01d:44cd:e101:4619:945f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2aafa2sm221784b3a.22.2025.08.28.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 12:26:03 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: vadim.fedorenko@linux.dev
Cc: andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	skhan@linuxfoundation.org,
	vnranganath.20@gmail.com,
	aleksandr.loktionov@intel.com
Subject: Re: [PATCH] net: igb: expose rx_dropped via ethtool -S
Date: Fri, 29 Aug 2025 00:55:51 +0530
Message-ID: <20250828192551.13216-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <29cbde11-b7bc-4eba-a0ea-b20e4a9ecb79@linux.dev>
References: <29cbde11-b7bc-4eba-a0ea-b20e4a9ecb79@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> On 28/08/2025 12:42, Ranganath V N wrote:
>> Currently the igb driver does not reports RX dropped
>> packets in the ethtool -S statistics output, even though
>> this information is already available in struct
>> rtnl_link_stats64.
>> 
>> This patch adds rx_dropped, so users can monitor dropped
>> packet counts directly with ethtool.
>> 
>> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/igb/igb_ethtool.c | 1 +
>>   1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
>> index 92ef33459aec..3c6289e80ba0 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
>> @@ -81,6 +81,7 @@ static const struct igb_stats igb_gstrings_stats[] = {
>>   }
>>   static const struct igb_stats igb_gstrings_net_stats[] = {
>>   	IGB_NETDEV_STAT(rx_errors),
>> +	IGB_NETDEV_STAT(rx_dropped),
>>   	IGB_NETDEV_STAT(tx_errors),
>>   	IGB_NETDEV_STAT(tx_dropped),
>>   	IGB_NETDEV_STAT(rx_length_errors),

> This stat is never used in the igb driver, what's the benefit of
> constant 0 value in the output?

Hi,
I initially proposed exposing it, but after reviewing 
the driver, I realized that stats.rx_dropped is never 
updated in igb. Exposing it would always show 0.

Ixgbe behaves the same: the counter is present 
but never incremented.But this patch wouldn't provide meaningful data.

Thanks again for your guidance.

Ranganath

