Return-Path: <netdev+bounces-120632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B3F95A0E6
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAFB9B23D01
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA50D13AD2B;
	Wed, 21 Aug 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auDlWr9w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A8130A73
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252815; cv=none; b=qq40+CCuK9FwuQ5RITLgtM4hkvPj4uQ+F0sFB91cHd5Hi3pQepie358KSql/67SWVg1PCXdJF3wwkfzd4r0uvsxv+XI6rL+t4w4CAsMsEicgqgVrS7NASKmk0NP6m6EQMHy33bihu16K3IQChmroiJBGtiRoy9AavetiSaluHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252815; c=relaxed/simple;
	bh=to97TeDicJXmAINHPIglAv1Z3AAxVgTCyxjcxwzQ+WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbUpZwCUYz1VvNS4CCUKphPL39IWqS64OIa+uFaBsoCBaEPicn+83ECqoZqu4qjVrqLH9W3952dJz63KklGJ/0H7MtyONWh+L0GEaEkaBNpONCdkXoQwOU9tfIXKVfT/5gDiG7COnGXspLpmuCy45PTCHHn4shkQrINxsRRrIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=auDlWr9w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724252813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=to97TeDicJXmAINHPIglAv1Z3AAxVgTCyxjcxwzQ+WA=;
	b=auDlWr9w9EjKPccmk/N0969yXS+4ap7TQsoJrA/x7lOIQGHL21E+fLg3muxlTg3T52ilct
	9IURHxRzesC0njiCZwVPCO6FIRBSIYUoZMYaXk6654SxCxDgybHd9A6uY9HSE8HJtjYQvo
	+vzIi+A5ozXvRBRb9jybYSWcBddY4Hw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-NtXMdqC8M5ygIY4ORHGQ6Q-1; Wed, 21 Aug 2024 11:06:51 -0400
X-MC-Unique: NtXMdqC8M5ygIY4ORHGQ6Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42816aacabcso57389485e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724252810; x=1724857610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to97TeDicJXmAINHPIglAv1Z3AAxVgTCyxjcxwzQ+WA=;
        b=mC7Z9uAB8uB4oIRqj4etuoKW/feyEFXBaLt6n4Pq/wstal2HDzwZCw65UvoXp+cpW6
         Mkoqr0baeoy37v3vnlpAN0vjabqPomFN9uiwnXl8vFkCPUKzXdlSQ/V3Hj5jB7qUcEeA
         DoU93s9ejcz2AjJ5U7OIxfuloK8erpOEikbw5Rkpv6GnBX/pfSt5Zfw51ly2A51FHL0m
         KN3NXWSHn5wDcFokhPtD19lABYhy4F/kw4YKFHkiEHxuxU44xLPUx9n55HcClOcjQenG
         3HN/eFSZ/UvmFnaqc93bvFe4fkHyhaFUOBcoEB82Mvt0ANLUF/eviwTIe/jkEOQg0BA5
         SMsg==
X-Gm-Message-State: AOJu0Yxu5I2OakQDr7ubNCt5SsZdvrAFFGVNEjcgsF12emB4hTjWbx5f
	eM4gK4OjUG3Jk0dKprtmixqzGqhvumQhIezEIMAnW3pGjII5xjTH02C1paA2hFiDVpEsEu++22h
	HrCPyW8ZqjoGIKgNGz5sJQnk3XZxhdqXB0OVcUGqtIqKJIPoatR7Peg==
X-Received: by 2002:a05:600c:3c94:b0:428:23c8:1e54 with SMTP id 5b1f17b1804b1-42abf05ba0emr18022165e9.18.1724252810624;
        Wed, 21 Aug 2024 08:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEiCsk9azLAavc2eGd1Zdp4wTY9+FLkpAEYZujUzgvcmE4b3AkL9yBV4AJjIH5CjD5eKxTqg==
X-Received: by 2002:a05:600c:3c94:b0:428:23c8:1e54 with SMTP id 5b1f17b1804b1-42abf05ba0emr18021655e9.18.1724252809808;
        Wed, 21 Aug 2024 08:06:49 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc626fsm29116605e9.31.2024.08.21.08.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 08:06:49 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:06:47 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 07/12] ipv4: Unmask upper DSCP bits in
 fib_compute_spec_dst()
Message-ID: <ZsYChzAbHQzR8bX+@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-8-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-8-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:46PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits of the DS field of the packet that triggered
> the reply so that in the future the FIB lookup could be performed
> according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


