Return-Path: <netdev+bounces-167804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67749A3C672
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454ED16D793
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9101B415B;
	Wed, 19 Feb 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjIjNQ9Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D00A944
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987060; cv=none; b=hTuTJ1PXRbNSpCYaLmrWex/pF6avCDk/VVf6x0eyFPMHsENdFNSjAvScsvY69PYquck7SxybRpiX54cJhq2I6FXJ3B/TxIl55pL9wN6Ddt/7w4uKwPOmG5goHxD4FzjnO7P3Nr9V9MtgrQ8jLIvZ42y9u19q7fwgVQavkceDVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987060; c=relaxed/simple;
	bh=b5Fx0mzQ9BDMtWWWOE2f93pG+nMzXeMAFX2CJaAPvXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAYT3y5tz0do29/jkHZrnJLdOqzMcu6KowlsRq/tdA/8PYz4ZE9aO0CB8NSfMchjiOIH0BRs2MMtRDxPRJbzcnsT578LQbdmhBLhZNCiBogTD8WBj+ViXcHphrc5NYWhr9nv7mwtSa8SUzvMkLGH5cx8QDBTwxXDPJ8/sVrQUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjIjNQ9Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739987057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XRaxkta7kHsFevlky8/IQt1YZHb/G6iBZ9KGm+uX00=;
	b=DjIjNQ9ZULmzAXsX7Ghqs0qXpPOIONAQ1wQ5akKq3JNwBLdbHyz/gXZSk7W6xV+lJ7oHem
	mzPb9vzWws5dtY0mz48ibjBCu0S5dxyXxzgel21AA40zgcJGfk9E9394wabnv60PONzmWW
	jjdUQiSQPkJUR4rGtLGEv+uaTdnM/UE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-FPqa3MohMGyibrj2VkX4-g-1; Wed, 19 Feb 2025 12:44:16 -0500
X-MC-Unique: FPqa3MohMGyibrj2VkX4-g-1
X-Mimecast-MFC-AGG-ID: FPqa3MohMGyibrj2VkX4-g_1739987055
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f39352f1dso22283f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 09:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739987055; x=1740591855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XRaxkta7kHsFevlky8/IQt1YZHb/G6iBZ9KGm+uX00=;
        b=YzcfuBXpyNZ0ppPFutQD8ClUNljZeGGaF+8P4XNvSrmTDHBKk57c3ghmudXiOGvjpo
         WaJC1p6xKMYO/R6s7jHYy8KsPgMgn3mO7Xusb68TrL8y8vMNewtXOLVSHgJEEzbL2bnY
         +P50gYpeUkaKkqdUdoLymUdbFQPgSbOzxEqIAkhkB73KGATA1CCYJgAoxJz0OTLSPK/V
         kXg9o0lgIqaLjJP0RU8xTRnxMqmdW1y12enuEsducBbLSc9D97+0LAqEyhfL9bA/gA5K
         3fgTQ6nOiuJ3TZNXfiO0MGgCg9m8dxQd2yzxCs3RQSd58b589ztuG6aoZLONAgdyZda9
         frCQ==
X-Gm-Message-State: AOJu0Yx0+g85yy63mgHt1TPS0+8iFFGhnzOzV5Pzp5Wm3gizEVZtttep
	U3zUqebFFTZ8ZNm5XlEwUKS0HQRgTWwSW0B3mRO0S/Huud4Qfmhpv0Nptl7zI45VFbtZPPDGrYD
	5PtG/2jXRVA4mpcqG2qA31chdluRiGkXZZ/wgRIr1JS/uc2Fp8NzK1A==
X-Gm-Gg: ASbGncuS/gtn5EpyJ+Ge3nCMHfDQzU/AkUOxlD7JyjUlx6B8e/0Ig9PVY7qgekSFyYA
	I+DzlXGMcT2N+XxQ3dnE/NVMQHy0V8mUP8m2mhXCz+fP+TF/xwdlQR5brGUO3Q39Gl37ArFdcfJ
	VTUQz9MkFZWrRPPVB8yTb3a5VLv2Dr200LMdHTF+waDUGCR4PxHgjUyuBjNABR49ZZgC4VJte7L
	RVGDcH+jH6WXOclVSgNGWKUoVU0JU3Eubl/97mK5tS6cDwuk48RJZ0sOwf8dVu5DD5Y
X-Received: by 2002:a5d:64a7:0:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-38f33f1155fmr17181660f8f.8.1739987055340;
        Wed, 19 Feb 2025 09:44:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoiyjmmyOmuM1ferw0PvAcW4O1qPMT7i/GrblsTLnQKOn5ykHFXhT39Y1T4Ud8OGNxd+IixQ==
X-Received: by 2002:a5d:64a7:0:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-38f33f1155fmr17181637f8f.8.1739987054942;
        Wed, 19 Feb 2025 09:44:14 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399c41022csm23248835e9.40.2025.02.19.09.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:44:14 -0800 (PST)
Date: Wed, 19 Feb 2025 18:44:12 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: Re: [PATCH net 2/2] selftests: Add IPv6 link-local address
 generation tests for GRE devices.
Message-ID: <Z7YYbBvu1/QOBTSP@debian>
References: <cover.1739981312.git.gnault@redhat.com>
 <d257c7ac320aa41ac5ff867f3bed5b5a6d1ca875.1739981312.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d257c7ac320aa41ac5ff867f3bed5b5a6d1ca875.1739981312.git.gnault@redhat.com>

On Wed, Feb 19, 2025 at 05:30:15PM +0100, Guillaume Nault wrote:
> GRE devices have their special code for IPv6 link-local address
> generation that has been the source of several regressions in the past.
> 
> Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
> IPv6 link-link local address in accordance with the
> net.ipv6.conf.<dev>.addr_gen_mode sysctl.

Forgot the Makefile update.
Will resubmit tomorrow.


