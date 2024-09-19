Return-Path: <netdev+bounces-128890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B6697C558
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 09:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05BB1F234A8
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 07:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9FD1953A3;
	Thu, 19 Sep 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYnbiGkF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829EB194C62
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732248; cv=none; b=J8ZbzCp+iZFsO82c7mbqEpUwyyoLskFsMMshKsu0tzD6SHyPe8lvdfsvqB4lhmqCM7U1LsHIZ+V9Fam6bGsrAH7EGK2Pj9e85Sq1nR+v3d9pSIMzF5x36/J8gXstUwo5tTH0/SxVeh+9t4he1VVjIust11dPGTRMmP4RL9CT4eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732248; c=relaxed/simple;
	bh=1k7B0MZlQqaIZ3amiRWP7HDZnhoekxJ7NapluKs/4LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tfHzp6y25C5bErKvqZky233s3QQr6ieH02K74iTMAw7oFvCJzRcIIfMsID2jDAkMHCcCq829BBusW/mai3e4qdAz/pqwWL4X5GBvMeHGULHxqQLMM4rZejISAbFi+eKz3ImawunVqH7niGYTe+y/nZIzjN4I9CPkL41eLmiImVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYnbiGkF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726732245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFGOFm59vbhLUmhaiXekB1M60wRjsDiZ6aOfkmRUu/M=;
	b=RYnbiGkFOGawPlcOyNf1fDNhg9Uyb1I+q7VKVChlOpiE1rMILaaQ+VffJIv/dwqFGbIu5z
	gwS74gHpPIanD4mc02aW3M2WD6lUSQ1mQeNu8d20PWZYV1D9nH9GVNQ5IEMQvyc/idt6nE
	lXHaWm8F4Ui4DPEPpdKV/d7R/+exPLM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-Nm3CoFBVNx-glBc7Jp_ddQ-1; Thu, 19 Sep 2024 03:50:43 -0400
X-MC-Unique: Nm3CoFBVNx-glBc7Jp_ddQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-377a26a5684so214621f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 00:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726732242; x=1727337042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFGOFm59vbhLUmhaiXekB1M60wRjsDiZ6aOfkmRUu/M=;
        b=vEI549oMzRIlpJPv4MGp2ydpnfKkRpu9aoVrCuYAFGTG528egcQbPZCoKCD1cnRAzK
         MLfmz17pBfuBtO83lg4GpoGUdvkIFNlAaeazUaoCHht/uprTRzJZyuDB+qqXu9MSLaix
         LjsGJUmAUYXCN4itQHzAMbx6BtyGoxeKPbicsX8TH/BKw5dWJ9WP2NRHCA0+n7Ze1VB0
         ZH7Gu9YHx7bcPX6mkt7f+grmjAJBGsqzyCqx+lDi/Sta49vzhPOWsidaeItib3PK/QIS
         c0710J3isAn5d/EJL+Gjp2z39GMM+vzSnDReOiyMJWAkkJaG10nym21X+iWI3pv8vkFJ
         /ImA==
X-Forwarded-Encrypted: i=1; AJvYcCWspk4nkq8ZbvPyP39dMMItMVnJR/KVTabsFTGudonZZ5yViveO3FSxDjNiRydFhBLX216KiR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzK9c84/RaCD6XjscLdR1BEuDLYGF92iWNSG7nAM7YE6PccKn
	6yfM9yf1g5BeIUGDMOEZD2Ty7z1yzG6u/U7kMOqMre/RAA43gpbzMLk8t5fLj3GHF156pKv7H1O
	48v8OrDvxz9WYcCwaZ7agpbIldTdWFeDlyRxUECVYrLEVgMyiXHgvtA==
X-Received: by 2002:adf:ff8f:0:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-378d61f0f87mr10130927f8f.26.1726732241722;
        Thu, 19 Sep 2024 00:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfE+Dnn6PGgJBYWDY1YrLy9iOFqKnuzn7yglnTnbNp0TjZMlG20NVKbnpaSq9EM03UkAsBlQ==
X-Received: by 2002:adf:ff8f:0:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-378d61f0f87mr10130911f8f.26.1726732241240;
        Thu, 19 Sep 2024 00:50:41 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75458230sm14783775e9.38.2024.09.19.00.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 00:50:40 -0700 (PDT)
Message-ID: <bc161229-fc3c-4816-b2a7-6b762f26a232@redhat.com>
Date: Thu, 19 Sep 2024 09:50:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Submitted a patch, got error "Patch does not apply to net-next-0"
To: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <SJ0PR84MB208883688BD13CC7AA8F880ED8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <SJ0PR84MB208883688BD13CC7AA8F880ED8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/19/24 04:23, Muggeridge, Matt wrote:
> First time submitter and it seems I did something wrong, as I got the error "Patch does not apply to net-next-0". I suspected it was complaining about a missing end-of-line, so I resubmitted and get the error "Patch does not apply to net-next-1". So now I'm unsure how to correct this.
> 
> My patch is: Netlink flag for creating IPv6 Default Routes (https://patchwork.kernel.org/project/netdevbpf/patch/SJ0PR84MB2088B1B93C75A4AAC5B90490D8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM/).
> 
> I followed the instructions at https://www.kernel.org/doc/html/v5.12/networking/netdev-FAQ.html.
> 
> Here's my local repo:
> 
> $ git remote -v
> origin  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git (fetch)
> origin  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git (push)
> 
> After committing my changes, I ran:
> 
> $ git format-patch --subject-prefix='PATCH net-next' -1 95c6e5c898d3
> 
> It produced the file "0001-Netlink-flag-for-creating-IPv6-Default-Routes.patch".  I emailed the contents of that file to this list.
> 
> How do I correct this?

It looks like your email client is corrupting the patch, introducing CR 
around column 80. You should address the issue within your email client 
setting, or using directly 'git send-email'.

You can test your setup sending the patch to yourself only and trying to 
apply it to a vanilla net-next tree.

Before any future submission, please take care of all the good 
suggestions from Heiner.

Thanks,

Paolo


