Return-Path: <netdev+bounces-205862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940D8B0081B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7529717E209
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599072EF651;
	Thu, 10 Jul 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+PUp7IM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020B25A357
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163453; cv=none; b=tyJof861yuULaUbDTum1+08yGJe5QTc+Pk/zyxMOUqKaBSwDIl+k2fnqFN7aVmbkYBYv1pHOmYasY5D0O/JO8zwUi9++Id8SDhc3n2idile7CfVXFW8FZln+D+P53Tqw7P0R0J6prI0YbShruxGKyTeaa7RaDDcaG/r17RODvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163453; c=relaxed/simple;
	bh=45SIG5rPi31Du7cZARxkbmyB/fEEYfkUbHU85m7Yd/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AttBKhEOePIFTPvpmXLMzZEuOntlE0K2nH+fMiFrinNUXEsYtAKGMK1sQcfeUn0tbCgSjf7tVnaxmFd+21prZ8oLlqPr3MlkrKyZyNRDKuZsBcIw4vAMvVSJDKELQruzQ3TJy00ETY3bjiX0v/ZXT/L7HkXZH0GZcguvatGKj5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+PUp7IM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSCoFxZmQFbdN64FGaIzAmf+ZfaD0SDOkGG3PDCYahE=;
	b=H+PUp7IMeQqbdMbyuRzhPgUuTFM0ZTcJ2Z2AZoQrLu1BEcFaQWgLcbEBx5tXmBvtC1GD38
	9bNOac6owKXxF+fWgVr8B9OeknyTRC56aDqZjrvWZZk9RhCBNi+j+8ZCETE64QL7Pogph9
	aU1gXq6Odp5NlJtXOwhCjYfUR5GAg5I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-vhCLnF9DP5-Zxd9fDofGtg-1; Thu, 10 Jul 2025 12:04:07 -0400
X-MC-Unique: vhCLnF9DP5-Zxd9fDofGtg-1
X-Mimecast-MFC-AGG-ID: vhCLnF9DP5-Zxd9fDofGtg_1752163446
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4532514dee8so9265515e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 09:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163446; x=1752768246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSCoFxZmQFbdN64FGaIzAmf+ZfaD0SDOkGG3PDCYahE=;
        b=Ebgq4sIP0E08z5Xzjfjp+9pSagixbTTd3hg75YEGJlSl+SfhBzvWcQiHEQ21fqOnCB
         kCRGTjmqAqF0md+imAio0e3s5+4SuwKBoK4WBM9xxi2UPv4moUarjvNxwrHYk+VyZOQy
         bLUS5BRZma71ZrOSxa1n1NQmyqYDC39mA0MYAAmalXzAXF0p+/uZ0zJkE8D0pH/2DUM3
         t+XvEVMeVYjjsvSL6ycif9brZ40T3mEqN3hUENbi4bxKVRmeyDSlb4ZTB+yhB9vsAjWR
         m3Wdx6zPS+bTnyJe0XyukhNDMq/x6z/Erb6R7Q84WIptXTtD5r6wL4YnvCf6+Jd8zxc/
         Zo+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIArsYsD7OE8+coEF+y2Vqgd9/x3ICpEEJebemOCSrMsqVi+oybo90zSMHdfMPH5UvH3TEw4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmktgOf01dhtVRZ3MQcyjN0MBvJDXWsALvLbzY7ZjWwkT/iLOJ
	nnL1sM+ocSayaL94vZL10BibBo/YheAO555RSZEnYPFGpr5IOtyaTFo8M2cJWyvLg3hzPJsoJYG
	gy9rXjFDqNs0jCrJP+vAyhNCDPfkoMIdiU5k/WnD7ZqR+1OFzc2bFpEEO6Q==
X-Gm-Gg: ASbGncvC2XAR0f4CE3tPQmKtwBRwY+FKOpgv0I0hnGUhalONzBCWhGkwj58FGYEP9eQ
	UzUBWh+XqQD/U7ApdMAfqXimRf81LwI56hRpB/BpAG9Raqg7jZ2pGaRwccpgbLEOa9svn3lIf0x
	d6mvlB+36BhASOIfSmH6uYahbMBoVJER/SF5xNcgwGbyEAfCbqqubAgvYzgEBzLEu3Nl/nMZFVh
	+W4+Yz/MKV7/R7CJhmwQyEBlcxSiXCWTGmIymqzw3U+MiCRVg8+PJjtKzum05bXjovOjPmO5Pjg
	vQ/BgJRldq9YzaSlP6lGbiHjDbQMKhtIU625QDHDiWF4wpV9mXgnxJUqZNEdSdsBofppSg==
X-Received: by 2002:a05:600c:8b07:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454d5404715mr63096045e9.32.1752163446173;
        Thu, 10 Jul 2025 09:04:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwQsXap6CXeZtb932z9EyvfOv6madp5+KBeR3+NEb4XXN6+C92DcDbsyl7FzhVwLWiFi+d5w==
X-Received: by 2002:a05:600c:8b07:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454d5404715mr63092535e9.32.1752163442931;
        Thu, 10 Jul 2025 09:04:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032e9esm62029605e9.3.2025.07.10.09.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 09:04:02 -0700 (PDT)
Message-ID: <e0f9befa-d29b-4cc4-ba41-e38f398a6589@redhat.com>
Date: Thu, 10 Jul 2025 18:04:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
To: Kuniyuki Iwashima <kuniyu@google.com>,
 syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 paul@paul-moore.com, syzkaller-bugs@googlegroups.com
References: <686da18a.050a0220.1ffab7.0023.GAE@google.com>
 <20250708231926.356365-1-kuniyu@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250708231926.356365-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 1:17 AM, Kuniyuki Iwashima wrote:
> From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
> Date: Tue, 08 Jul 2025 15:54:02 -0700
>> Hello,
>>
>> syzbot tried to test the proposed patch but the build/boot failed:
>>
>> net/smc/af_smc.c:365:3: error: call to undeclared function 'inet_sock_destruct'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>>
> 
> #syz test

Please, strip down the CC list to strictly skyzaller related recipients
while sending this kind of test, as they may foul PW and the CI.

Thanks,

Paolo


