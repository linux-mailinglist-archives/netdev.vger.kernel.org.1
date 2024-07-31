Return-Path: <netdev+bounces-114426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955499428DA
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B61284B9E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51AF1A7F64;
	Wed, 31 Jul 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRzbZWUc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245CA1A7F77
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413316; cv=none; b=DlKJL5G+4AQGO6RvwtF0XJvpOlEbu95o+urH38aryDuz72+8mHZjdSFDFHBT5wHI1s3rDE9gY9gGAOu40DbvUp7ODCS6bEJqrFTnyDyKVKH0SuBV/fk5RX/C0R7lUkzvcFJyUKqj9iySaPuCy9TGmTe+NvJWxMXdUWsF2bFfXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413316; c=relaxed/simple;
	bh=LqAFlpQG7DL/VCz4nVGCpA2ZAvLWGEtA8R1EfT1NeCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PWL/5VazcEbSB3cD+AohcxJkgqQbx4hic5MwooruG0WnI5E8Oou0l/ff9MHS/FJ10hHVjIaKAVnYPK4AndHWIgg/TvN+sRyDz0MdD01BUy3go3AQ4BLc3wlxEyCxS/hHjySNjyUHAQAINFOwCZclWdv6RdEcXrD1VvM2vps+jWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRzbZWUc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722413313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2feCtBp2GCT6MSRAzg85wuI83od8RB1k66cPoECLx0=;
	b=GRzbZWUcUofCbnj5AJVnIYVxCin4KtaIztMZPVl6aFZ5huDbkNIvKREB9I9277XKkD7dib
	846CDOt52+yDpIbTheORaNfGF4lkBU5iUp+cmmY4kiwPocHgeBBqP+tbxN7h1QU4nGMqbc
	L5KrpeEMaM2q4ipxV9Tfy6GXzrHJr6Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-eixdqmzJPzuF2ttfmJOPuA-1; Wed, 31 Jul 2024 04:08:32 -0400
X-MC-Unique: eixdqmzJPzuF2ttfmJOPuA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4267378f538so6620685e9.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 01:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722413311; x=1723018111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2feCtBp2GCT6MSRAzg85wuI83od8RB1k66cPoECLx0=;
        b=JruWs+d2NJY6ziTSAyNnk4yGfzWcW6sdwGxedaz/9p0V/QgxfynB456rvDXcKfNzhU
         4TsUHRWlFESpH+GVm2n9CPMYNEmeGnpBbqvG1nm6ACv/fLI+XJJt15zFKx57J9rrO37b
         rYmAkt6O0hoYh3filN02pb2zGHkL4u7LUIUI8VaEQ7j377O5ctC5yxwnmmbrhCPZ7obL
         VNQQnONVvaiqd3/N5WUIlEBLNzsaPXt8KKwQhU0J1LUUZN/KQ2wOnRMShKxFhvoKRb38
         3P0mcIbdDEWQ6n5aluZovtbpPvBOaYE7GM6mbxFNAC5VaUD9DQxBTq9Tq5AVhRAu/P17
         vPNg==
X-Forwarded-Encrypted: i=1; AJvYcCURIamyBTtporgiBjcP7Eu8fLv38P5x/J//ipMhL6o6wgJ6yJG1Oj7YM7MkdQhDRGbWI6XafvXxWcqNypWQ1rVAZFWdXY09
X-Gm-Message-State: AOJu0Yzm1aa3i9L6+i7SWkgcHBsH9VGunN1jlHdS7zYB0hxE0Tzgo58E
	DqtXyE/Jsdbzd0SwQ3YKWHVA+Uw/V09qTCUR7w0japE5RzvIkl2D3hv/BT5ITJKzckGW9CazC4C
	qrQm1P6jqhysBEJ6ooQgd8DL5D5AIMjL/myRoF6L3YBIwVXMaDg2vmVcX55+Di8zf
X-Received: by 2002:a05:600c:3c89:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-4280543f1c8mr84004135e9.2.1722413310650;
        Wed, 31 Jul 2024 01:08:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpynrGr6tOV/A0mJmKdN/VwO7HVYMRhKkjI2I2x5a/C+kwYohsjmux379UjO8SRTYMIyeTkQ==
X-Received: by 2002:a05:600c:3c89:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-4280543f1c8mr84003945e9.2.1722413310064;
        Wed, 31 Jul 2024 01:08:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282babaab3sm11854615e9.28.2024.07.31.01.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 01:08:29 -0700 (PDT)
Message-ID: <61cb1468-d1e1-4a47-9c04-71d00d0c59f5@redhat.com>
Date: Wed, 31 Jul 2024 10:08:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IPv6 max_addresses?
To: Kyle Rose <krose@krose.org>, netdev@vger.kernel.org
References: <CAJU8_nUFQShNSeT52nkdKmMDx6hodgFBSN3rCVXTQ_VgqugE8w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAJU8_nUFQShNSeT52nkdKmMDx6hodgFBSN3rCVXTQ_VgqugE8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 02:05, Kyle Rose wrote:
> max_addresses, how does it work?
> 
> $ ip -6 addr show scope global temporary dev sfp0 | grep inet6 | wc -l
> 21
> $ sysctl -ar 'sfp0.*max_add'
> net.ipv6.conf.sfp0.max_addresses = 16
> 
> They seem to be growing without bound. What's supposed to be happening here?

 From the related sysctl documentation:

max_addresses - INTEGER
         Maximum number of autoconfigured addresses per interface.


'max_address' only applies to the ipv6 assigned via prefix delegation, 
not to address explicitly assigned from the user-space via the `ip` tool.

Cheers,

Paolo


