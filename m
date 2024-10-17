Return-Path: <netdev+bounces-136698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ACE9A2B2C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B74428386D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495C91DF990;
	Thu, 17 Oct 2024 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSvmDm56"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376F1DF989
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186888; cv=none; b=SedJLC9Se0/En7vE79tHJzllL0Rj65tV6spx134jKLpzKcMzEcNgYITS6PXTxDDUBoYYKz8UCg97p4hjTyCI/DSZTlOh98C/IJB443/e1PtCPkMFNWS2L499+0pDPxewTu88fo3XgWW/lKh7hK0d9hh356mmJ7ZsrNGDkUUUPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186888; c=relaxed/simple;
	bh=XE4lXdVhbv/iRKBeo5QrR+3fLVSAoqEZLGuBVRc7d7c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=TJH4YPmeU8j5qa0jHLmJU6Y70KESdfXrKK2wp+c5AXb4VNoOGTorf2ysTBLt4SJHPnMV2mmmQxNKGPzP8321jaHX5WsZGQJo58VRAIz67u885dU5/vDKPs2qg08/qJv5mrFtFFbiN9ZdQ4TeEbFJHvxEwt5RDizDpH0h+/qmx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSvmDm56; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729186886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T0Ev4DfcanUOXfEvzo72JAnEY9msCyt6xa/zeEEo60E=;
	b=SSvmDm5683lZJzWKchSJ4ej8V26CLlSOyZgJi6UB7KifPzL0hIN0sy60REijwr9nn1vWIF
	tmGKLixWSzFr3v5/wWFzLBlyI1UTXC55oBdCkAQSTS4S3LR9HN6wbuiVcHWQvch/jQjPx0
	+iQUoPNamJuWhTDh389kGF8UNJvqkAc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-vna2TggtN_mFdJKiuywntg-1; Thu, 17 Oct 2024 13:41:24 -0400
X-MC-Unique: vna2TggtN_mFdJKiuywntg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4311cf79381so9040755e9.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 10:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729186883; x=1729791683;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0Ev4DfcanUOXfEvzo72JAnEY9msCyt6xa/zeEEo60E=;
        b=VMlUX6XWFmWNpxbRTJctU18cnI6WRyyt3D3/FE0paIXJFQyKenbUpEy5sb5U9XwwlQ
         pBKdPzWzpbl0BnKB/JP/KlbRLFuJBlc8jjzMVpjVqDT/UDAhaq8YfQX9Lu1n7raJ1n9P
         NTJA+f1LnUAhui9ZRszxvzgww6mDuvrT12BqXP3qeP1D4+ncSNSCQ8skbu9RLwpwGDDh
         iGrqMmpwGpb6k3PnxdSyQhZWQFSaRmlOHhZehVynrgKJyJj3aLEVcjEGur4pvd3TiSb+
         NvQEkp3yMYRuUKvIB4uCe9eo4UE8E7SIMY9qVPE+fR5UB3vu63Yb5LcKnvoIBMEIbrKy
         Z3uA==
X-Forwarded-Encrypted: i=1; AJvYcCUyJNz5MPiI1/USjGq9My6oPx7uU8yTgmyDCepIMLpfifgFEp9Ve4gRTVBm/urIZ+b0KAgkAxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqt9eZxG0qlyX1GQqBH+LQVF7R+Xj5QWAjjyQygnngeHUxOmho
	n/RGRzrFnN/oiq3hsT2EvotBity6WLbdMhjpup+H2xEcggepQlpNcOWriXCX7ab4AmcJMLcEOwV
	b4GLpoF/lT5qIutQUWz+4hzApbl2tffixBtuZsUgmXoebTcRTNy26K+UbyRVB0TeC
X-Received: by 2002:a05:600c:470e:b0:430:57f2:bae2 with SMTP id 5b1f17b1804b1-4311df42cf0mr195906915e9.23.1729186883228;
        Thu, 17 Oct 2024 10:41:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEu71iN0qvF8nV440aHzgS//63avQGsgKYTQDIPTIRnCiGQ264Zx0S3vXRRi0bGaKhZoBkNw==
X-Received: by 2002:a05:600c:470e:b0:430:57f2:bae2 with SMTP id 5b1f17b1804b1-4311df42cf0mr195906765e9.23.1729186882844;
        Thu, 17 Oct 2024 10:41:22 -0700 (PDT)
Received: from [192.168.88.248] (146-241-14-107.dyn.eolo.it. [146.241.14.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc11ff7sm7877463f8f.92.2024.10.17.10.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 10:41:22 -0700 (PDT)
Message-ID: <ce719001-3b87-4556-938d-17b4271e1530@redhat.com>
Date: Thu, 17 Oct 2024 19:41:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Abeni <pabeni@redhat.com>
Subject: yaml gen NL families support in iproute2?
To: David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

please allow me to [re?]start this conversation.

I think it would be very useful to bring yaml gennl families support in 
iproute2, so that end-users/admins could consolidated 
administration/setup in a single tool - as opposed to current status 
where something is only doable with iproute2 and something with the 
yml-cli tool bundled in the kernel sources.

Code wise it could be implemented extending a bit the auto-generated 
code generation to provide even text/argument to NL parsing, so that the 
iproute-specific glue (and maintenance effort) could be minimal.

WDYT?

Thanks,

Paolo



