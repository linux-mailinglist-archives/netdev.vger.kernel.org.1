Return-Path: <netdev+bounces-220663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFF5B479F3
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 11:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7843BE901
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0A721C174;
	Sun,  7 Sep 2025 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVn7ZmQY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58F63B9
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757236038; cv=none; b=FP/uUF5SQU8SFFAZvMijoeuj4ORauJOIJQG3/HYxWr7TytBtBqKtH4Ou2tM4xLn1kz1X3BDXE3X+yOsbxepTlfA2XO1tED0AmCgyyGz2WhqlxaEUgCRbALVTqnDdzyXNMSW9ap2bZnhxJHUiPSa7lpQkjqxntj+G3VsFVDPXfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757236038; c=relaxed/simple;
	bh=gw40tZl426rQ+++4pHwaYuRU0zQT9m9rSVbBkjMMcPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXljzKmv7EFu7oH6LF2BykZOg9zj1SfpclDk6nnH7LEN8eA9F9o9rX+pB5NNTGkohepYvXUQV9OSbNTYMnWGfCtlLlFVUWtpdiRYub19jQB4rEuSV5xR33bXoMHWp+/9m9VILe5Ii6aMY8Qx7XzNGhSCVDZidKq5NeR2JfvFU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVn7ZmQY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757236035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yu8rkgDTc/PosSKRpJdtQdj9FaNdWHm11nIU7Iih4yk=;
	b=bVn7ZmQY2SDFcSZptro7b/EF2z23ctlFbF24Q7+S6Xs3rdLwI+fTgslpdPPEIsvxEVD21/
	u4MJV7ia45Zu7z94oSkl0Puu2P3sGI//qFoorfrwWuRUZxFSMN9p5NkUxQ1V22jQvXVnr9
	CS4J2o6M58lq6lhZGEJdRxz2+Zw9F0Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-cZ6Kax13P1mzdn1fK8sAuA-1; Sun, 07 Sep 2025 05:07:12 -0400
X-MC-Unique: cZ6Kax13P1mzdn1fK8sAuA-1
X-Mimecast-MFC-AGG-ID: cZ6Kax13P1mzdn1fK8sAuA_1757236031
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3db4cfcc23eso1683242f8f.3
        for <netdev@vger.kernel.org>; Sun, 07 Sep 2025 02:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757236031; x=1757840831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yu8rkgDTc/PosSKRpJdtQdj9FaNdWHm11nIU7Iih4yk=;
        b=tqstMiRFiO1rIUDdFKfQA28QZUi6LsTzfzLWN6I64aha7EsvV0P3rRbFMKPNkplGsR
         lwm9Pxig1AKUiqQQoa313mgdo/330fxh8+rBUsJPOFXbP+V3SIezxE2kQeHfv0vyjHXC
         cr33wEAbjeas7CbI9IHzwbrA+mVE/KUnhfIUesYMXb+02pZlUokaU8sch/mWUw/Kx9av
         wcOjyzKVLiXmnAuzkuVQQczPSA3xi8RmG+PUxdoanIVGJpJ3IU6qkTLKhgyPCe+2Nyzf
         K1sGryZD+4vcWJKQnS8RoHs3ZVsDKi7DhSLs+W0X/exbcZG1ObRvQD91vNRHPLG+NdwU
         iTTw==
X-Forwarded-Encrypted: i=1; AJvYcCU72LfugyyRVZdwNf0mbYQQi5KnYsnHAlu2xiZC537Pe1tw1qUzgi6/Idj0x7GEpaZ2jiNrOvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD1be1bqzTwgGYV5uCdH1KWSfhMTANilNgUrckEIuPXyBHwKvM
	LB9NbXyCyLouu+w4hYC/olenw4U+wTbcTzFx2Qc8U/4R1OIQTp8Cmiq5GA0VDX7Ixr7ZiCPTv86
	McZV2nYmt9m/MghgXuUM+ohm7d6GF1jAi+pnL+QPe+ENgO5J+zz6rmHoVSw==
X-Gm-Gg: ASbGncuD3sT5jPF0eOCycpGtfI4XWxKVkvhTk0R7SQZ3xCpBGEA7mUVeOv/Bm7gt53k
	JAV0XEAMD723zFUX6o1B+ANf84uqrNQZA1XlhKWzxyr3HmdeOzhjVYoli90I7CX64KSDZ8EMVLK
	twj74M05LXgXRHfcmIlh/wYVKz3umUT5g9hhauIAfWIeafCzOqmFf7KNh/1EGk7W1+KTCuLPqO6
	p01ZcrCSWZXEC1EB+9wbrEsQd4sFTG88jU6Ddp6mbD8bNwSpJBy23Lz3trZ3DX2AJ9dHwwqAMW/
	UgyWL0NkTp55oFeWSg4qAX2oZwSp3UvD3ZmsPlVGo+M=
X-Received: by 2002:a05:6000:18a9:b0:3cb:5e64:ae8 with SMTP id ffacd0b85a97d-3e636d8fceamr3922913f8f.11.1757236030739;
        Sun, 07 Sep 2025 02:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfO68JW1NGSpUdkVAUAJ1tw+Jh6Ta/iYbBbRcoHt8MjGZV3zlBWMzK0eU//tMT6SeIWZ7awg==
X-Received: by 2002:a05:6000:18a9:b0:3cb:5e64:ae8 with SMTP id ffacd0b85a97d-3e636d8fceamr3922891f8f.11.1757236030331;
        Sun, 07 Sep 2025 02:07:10 -0700 (PDT)
Received: from [192.168.68.125] ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb687fe4esm169329195e9.23.2025.09.07.02.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 02:07:09 -0700 (PDT)
Message-ID: <adecffa2-19cd-4630-be0d-8c4b597c8181@redhat.com>
Date: Sun, 7 Sep 2025 12:07:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v3,1/2] devlink: Add new "max_mac_per_vf" generic
 device param
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, przemyslawx.patynowski@intel.com,
 jiri@resnulli.us, netdev@vger.kernel.org, jacob.e.keller@intel.com,
 aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
References: <20250903214305.57724-1-mheib@redhat.com>
 <20250905122238.GA553991@horms.kernel.org>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <20250905122238.GA553991@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Simon,

This patch set targets the iwl tree because the second patch depends on 
changes [1] that are already in the tnguy/net-queue.git tree but have 
not yet reached net/next.

[1] e08bca25bd7f ("i40e: improve VF MAC filters accounting")

Thanks,

On 9/5/25 3:22 PM, Simon Horman wrote:
> On Thu, Sep 04, 2025 at 12:43:04AM +0300, mheib@redhat.com wrote:
>> From: Mohammad Heib <mheib@redhat.com>
>>
>> Add a new device generic parameter to controls the maximum
>> number of MAC filters allowed per VF.
>>
>> For example, to limit a VF to 3 MAC addresses:
>>   $ devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
>>          value 3 \
>>          cmode runtime
>>
>> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> 
> Overall this looks good to me, thanks.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> One point: This patch-set applies cleanly to iwl but not net-next.
> If it is to be picked up by Tony and go via the iwl tree, then all good
> on my side. But if it is targeted at net-next then you'll need to
> rebase and repost.
> 
> ...
> 


