Return-Path: <netdev+bounces-237958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3353C52072
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275FB4F6015
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A9230DEA7;
	Wed, 12 Nov 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NviFA56M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bs7AuGmc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133430DD04
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946965; cv=none; b=XEkhjYFE+jhpU6bbWXaLomhvTR1QMrbBOzDvwFmmSqZFle30NMy/XRyFmXh8pbL+xhs1g8cAd4LORiekcAUNwqpvr2h66046VyXKIP29EDAoYbTOiiiVi6ET5GlX2nL9wtOXFONzf7KWZt9cvs614g6D6YukT+AtsNiZFEc35dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946965; c=relaxed/simple;
	bh=yRKl92YIodipSDJpj5FM6SuTiPvUzBXwPijlqgd2Fgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVOaj32psDAY2glwp1F1gQSYNnV6uc4gnUDQoZn0V8zjrY56IE7gVvGg26J4TS1TbPGqIGA9V+Pt11EWMtTiVWh5tVM1MPEZpZ3VHiXY+Tf9ku5QtcJtKnCTsf/4M44biLp3AKxJBIBK7DZ2HmmLAgvO4pkof7mdHFhhSQMy9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NviFA56M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bs7AuGmc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+0n/gIH659cLeiKRT95CYm5fjgEisAw12N4OwZEDpM=;
	b=NviFA56MR+NxgJ+t3DyrYH9JWhLv1VHwW4lL2DTSgl50rqaY9qoxHqKVim4gl53XQ5ofhF
	IC66nUOh8TNHQV4eFfG2ozk2geHHcFFrPbO11knGLNgFD5vh2h1ul3dG30IedZK3FYNPEK
	HmUFDr29yhSMHnVUkWAKGMCG0lTQWII=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-ZL6Yz-7xNQmoDbq8EKCTBQ-1; Wed, 12 Nov 2025 06:29:21 -0500
X-MC-Unique: ZL6Yz-7xNQmoDbq8EKCTBQ-1
X-Mimecast-MFC-AGG-ID: ZL6Yz-7xNQmoDbq8EKCTBQ_1762946961
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2619f07aeso355264885a.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946960; x=1763551760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+0n/gIH659cLeiKRT95CYm5fjgEisAw12N4OwZEDpM=;
        b=Bs7AuGmc0EYmV/rdwxPhAIiv4aHBX4oPjPvVYVLVn//QhJzZsLgOr1IlWvu33IO/Re
         jq/mO/bb/l+QNylESDtj65grUiUIrhB2lAuPZtdOH10L7fk2dJ3HhBgDBqn+V6In64WA
         pJo0fJrfNSv/oxMH0CEe+LauEI9ruchQGDQsvadYOLsxdhFGXiDERZ0/2rPkevM0pk1w
         ZaNBazMPeb9mSAojr3ZfEMAbpBWeUSKpAaDAiZ7ViV1jjWUl6i3TjZBEWrgr+QqOkDi3
         mCdnt2aIhTzrxirDAfdtmR2j2fqFYJzlmeeyefhdyXu3TkrrE24h3JiVeuczxoZRdeqG
         nPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946960; x=1763551760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+0n/gIH659cLeiKRT95CYm5fjgEisAw12N4OwZEDpM=;
        b=wOZT4XxMxc/VY4NkUBvP85mff4TCyZvZ7VrKBPGb23fd65wz3lg8k0liFIjVB1cl6F
         dXCMlK7BTiVhQsjvg61u/pvN9/WlT8FJqITyGZaskowmiTE4hnRIrrux6wqlJTBxDhfX
         a2z7TCaoQES2gB5X1MMNp06ebDsr3GZ3A7Xc9IMbqWkX5WtJff++0aOYXBwOrnhDLYzL
         2THWMDMxL9Mj1DYGNeced8nszrq+DPpWsnMpis6gEQQRo2hwUEsMbdFqUP5hk9sE+vUx
         UGsVoIdN7PiZN2sqmqrSz+nVaQXdp6177ZBj4O2i2zQaBEu3Tq7az0xKRf45+EhbgYO2
         m2hA==
X-Forwarded-Encrypted: i=1; AJvYcCU+w3jBd1vfI4WwStBTeyjLnA+YIAtglxwzO4xiVc170MenvnfvhwCwXSH3SIketEU+sakrLLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0RKVLYjcOgZWOM5cu7fJpprAX31qY0f9SSGkjBGJnRRPlmw7
	uB3o6MvtNdBOnhlklot+Ja57c4osoAzEvyId4y8yDFCh/aiwIeirLB8xBnQuXKEtUF66dvagVsZ
	anLX/GKBUv3GnWX7mY2p0xgChzDKMsGbq2jyKcccpCnZ7bZRJvScN0JxF7g==
X-Gm-Gg: ASbGnctK2RrlvjQp1tAXHJzaQw4MoAGlaP+w00nux50VE8+u5WAYlJ/8qksBvDVyKSA
	jmHW+RxPpW+i/7LnKexKxypYIdYoMJ4HeHeOnJ+usAvl2sjSKaBWunq6UKCB9D5wp2zAf8krvfw
	2yrmqwYLj26x848bZ22J5J9Hn2kVR4zu9cYCYvVKXtZzscIKnm9meahlVAvXarqK4Nf0I+p6voZ
	WZDj2iwbMM1Aa7ayRFuBaRJ2FAH77tECJs0U+AKL6Dm6E2mpY8OL8eBYNNXp7PrloTUjoZTIcQr
	gciG9mfXCPMuzbwQqiwRXHh4w4iIi7qXfkjCN+9k1ciSZwhSqyKSihFMel1hzcDMSs83+y39BNM
	l3x94K+I/lnKggIzpLe6WrGhInQpwIn9E4YVcIKZcv+pM/VZfk10=
X-Received: by 2002:a05:620a:288d:b0:854:b9a1:b478 with SMTP id af79cd13be357-8b29b764a91mr352965585a.18.1762946960683;
        Wed, 12 Nov 2025 03:29:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUJFxOJbDQYyH5iAisGFENmrwrjD8S/tLmssJoauTGvGRsQ2OlHPKZyUfeC9cCLoY0kaU2QQ==
X-Received: by 2002:a05:620a:288d:b0:854:b9a1:b478 with SMTP id af79cd13be357-8b29b764a91mr352963785a.18.1762946960297;
        Wed, 12 Nov 2025 03:29:20 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e7059sm172313385a.38.2025.11.12.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:29:19 -0800 (PST)
Date: Wed, 12 Nov 2025 12:29:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
Message-ID: <3htkg6jotej6ev35jyc7edo6jtoo6tm7ciivnzvd7rd4my4nsp@47nbily4raoi>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <d19c7bea-9b4d-4f00-a6bc-35247011e788@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d19c7bea-9b4d-4f00-a6bc-35247011e788@redhat.com>

On Tue, Nov 11, 2025 at 01:33:11PM +0100, Paolo Abeni wrote:
>On 11/8/25 5:00 PM, Bobby Eshleman wrote:
>> This patch series refactors the vsock selftest VM infrastructure to
>> improve test run times, improve logging, and prepare for future tests
>> which make heavy usage of these refactored functions and have new
>> requirements such as simultaneous QEMU processes.
>>
>> These patches were broken off from this prior series:
>> https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/
>>
>> To: Stefano Garzarella <sgarzare@redhat.com>
>> To: Shuah Khan <shuah@kernel.org>
>> Cc: virtualization@lists.linux.dev
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Simon Horman <horms@kernel.org>
>>
>> Changes in v4:
>> - fix messed up rebase (wrt check_result() and shared_vm_test() patches)
>> - more consistent variable quotes style
>> - use associative array for pidfiles, remove after terminate
>> - Link to v3: https://lore.kernel.org/r/20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com
>>
>> Changes in v3:
>> - see per-patch changes
>> - Link to v2: https://lore.kernel.org/all/20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com
>>
>> Changes in v2:
>> - remove "Fixes" for some patches because they do not fix bugs in
>>   kselftest runs (some fix bugs only when using bash args that kselftest
>>   does not use or otherwise prepare functions for new usage)
>> - broke out one fixes patch for "net"
>> - per-patch changes
>> - add patch for shellcheck declaration to disable false positives
>> - Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com
>
>Series LGTM, but let's wait a little bit more for explicit ack from Stefano.

Sorry for the delay, yep it LGTM too and I should replied with my R-b to 
all patches. In any case, it can go IMO.

Thanks,
Stefano


