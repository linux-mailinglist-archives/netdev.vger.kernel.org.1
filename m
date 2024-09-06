Return-Path: <netdev+bounces-126012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CE496F93E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED9B1C22D71
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F31D415D;
	Fri,  6 Sep 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaa1VBDq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F391D3656;
	Fri,  6 Sep 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639968; cv=none; b=sZRyuz/O+Nt62kl2Hff6MgZIVCrcZ6CmGCNRftIZ9ypvJt5J2WiCnIvGP2c0EB6p5oeC6tVNwmKdj6Kd2jmPav2x7kUvmuXysJ3UAA4F3UztL/nyGQvmnntJ8fRc03ND/La2gG6RqlCk33mF4FOMNoOXxwDZSi8V6dr/c8XF79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639968; c=relaxed/simple;
	bh=nFF73k02llJCIJJL5L70joPl6968VwhvuwceIGOxv/c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qnCraIRcz8APY6Qo05FEBbsmIOfHuGM10/AJyBPePaAg5DuklBolxbvoJZ5129xCZrVQs7SQkZrA1Ww1I4e2nbQi6rsJFdE+iAKJDP1VWaOsWGW45QyOKqNK84gzIzkikQmKeMWJBVkg9NZectbhkYPtCYiYAjoRSy0n8QLEp5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaa1VBDq; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6d6a3ab427aso18620967b3.2;
        Fri, 06 Sep 2024 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725639966; x=1726244766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9Ny6pJsax76tq4JboD/Doed2vOv3/3852gshTMYnMQ=;
        b=eaa1VBDqAi4Tx/ba34ql2Vtu/22GXsxz7wPOkQVYUTY/C1CvOvVx9ihRikp2Ja5oj/
         4rL+V79MJp6rRm2NMOCKa03il3b8EL0D/vfuExVQDm1wcTw3Flc+6KvSksmpfLvLyrys
         roQxQ53gghXMiQzWJst7oiEdQopty/RkYCw16eDewb14IHvXjJRvdEcD4Yry7BpEl1B1
         PymBYGJF+Jbf0KKaNPr086FwjxiCwQ5JOJ3+z3BavJX6e1mYnjtPJxnCPHKyJws/4zOU
         MssSAep9oNYL5FPGCz0FtcWjCVo03dczcrUbbyr+jpNh9CHusegq7DCEB+ajPnWq6LsX
         YEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725639966; x=1726244766;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9Ny6pJsax76tq4JboD/Doed2vOv3/3852gshTMYnMQ=;
        b=lv5r6CVd+JnL6sAeUKxD1GxDyZcoCPEXNeCp/PcfUvwJZJcSS8OQsoZUdzMzc8NTH/
         rjSN1HmGvVP9hySNA5SX545RauYdpEo0kiPCefJ5FPNFOloqJgYnXvhNUtprb7EVS29F
         5gCBB88WFsuwzifeRXbqiQrUdrrihTBnp3gfUQcmeiE0M6aSYuo5iDi6qpHjqiHHMzR/
         eWPqQxqUYMZ4gJVECtxhfzS1ddbhjKYZ8+WcUhk1DkaHiZ+3YSRf0FZPOUCLDoc31yKf
         y35j/4L+6JcQbmoegPWxmrG4DfsTD7hiL0Auz0e7fZ7chvxgqJtJc7IF0ce7aFSGxLJw
         WNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPdoxqr4lm+nE5Ow4iDIYCW2pUVA+7CA9rXeq0dNnbftwkm6OoshdsOr1a4qwJkt9vLbobLu69NaW84IQ=@vger.kernel.org, AJvYcCXryArau0b9rPh8LOUFEgdbD2eoQOAPplIW4w8pNzpCJKNR+2vYtVJWOYBMjs/LN1vg2fzse+5q@vger.kernel.org, AJvYcCXxxgpXhClK47dcz11thVGr65/AHci6V4drgBO5FZL1iS4u/T8KwWbwNm3otjZuj+DvciDWg3rE8kyh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5e4Xts8Fn8gSBVsNADf12pK+Qh7wW8Lr2g3Y5OcEQlLRqAkOe
	TX+cbnjcRuQeJxdDbT+5MvxId+m8zHM/o3vepqDTYCMVZXA1FwLL
X-Google-Smtp-Source: AGHT+IFH/jIN8UGDXpLiwPIButM2OHHRvVnKuE6CuEixZ4Tx9UZffvF0/9MjZwjqszw0HFLYBxTmKg==
X-Received: by 2002:a05:690c:6211:b0:6af:c39c:da99 with SMTP id 00721157ae682-6db45164c55mr37083657b3.43.1725639966273;
        Fri, 06 Sep 2024 09:26:06 -0700 (PDT)
Received: from [10.0.1.200] (c-71-56-174-87.hsd1.va.comcast.net. [71.56.174.87])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db565c2c2fsm446577b3.106.2024.09.06.09.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 09:26:05 -0700 (PDT)
Message-ID: <f110db9e-16a5-4256-b0fd-980fda8a2cb0@gmail.com>
Date: Fri, 6 Sep 2024 12:26:04 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com,
 syzkaller-bugs@googlegroups.com
References: <00000000000073383906212f236a@google.com>
Subject: Re: [syzbot] [usb?] WARNING in rtl8150_open/usb_submit_urb
Content-Language: en-US
From: Ananta Srikar Puranam <srikarananta01@gmail.com>
In-Reply-To: <00000000000073383906212f236a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
b831f83e40a24f07c8dcba5be408d93beedc820f

