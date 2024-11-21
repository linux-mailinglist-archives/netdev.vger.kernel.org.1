Return-Path: <netdev+bounces-146616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA55E9D4955
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AA31F22087
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B5A1C1AD9;
	Thu, 21 Nov 2024 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtkEgbv1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C6C1C9DC9
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179356; cv=none; b=IigBBuNhzfC/NVmlRSERwUyBloGEHFDdW9alq+GAmdhzJzGI1REsv9Gge2LBS/+WZz8p5RELEslIGq0XZi64lic/VTOiwxHwSwEh+84juHQLkoxT5ASKqFt0IB6KMlltdCfJS10g+Fv98OX72nJXTqnGo9hUgP+Qx/0TKGkEPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179356; c=relaxed/simple;
	bh=K7AkL0tto6CDdGlimdcgf6Xn1JT1cRBDjbJ0bR7LQ/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tcmr6V2MgJhVAvaY3JMmhyhvWLUCz1FbWJ7oIDRvxa3Fm1eZKZt3hqpqBFWEfBp4soAj/RpmwY7S8f6o6zaC0M7dBW7okkPQqLX2SHC1Y2bfv4Z94Nbn2RzI3vnd12RvmZGpQz6uIGWULwzAxgzm2EMq54Lk2uYotYMeRz/4nO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BtkEgbv1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732179353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlA/Dao4HWIor+ViY9VXGE+zRi2NDg4RCE9H6BNgMBg=;
	b=BtkEgbv1pkpgWk9l3nU5Rqnnkzu5Tww5JZjq/6v+qANqrZozbbZLHGfiB1AJs6G9b6W8MJ
	c8z1FzVGSEBEN8tFgQoKzxlU6lQWpk9Epfv4FwHgd3SMFmQA5JIggAnyyJ5dulg7wRK4hu
	6cKrwUQw6/h/HaZLIHolcK7JcSJ7wuo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-538zJZp7PaWfSWk2k1dwOQ-1; Thu, 21 Nov 2024 03:55:51 -0500
X-MC-Unique: 538zJZp7PaWfSWk2k1dwOQ-1
X-Mimecast-MFC-AGG-ID: 538zJZp7PaWfSWk2k1dwOQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38236ca50d5so324127f8f.0
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 00:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179350; x=1732784150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlA/Dao4HWIor+ViY9VXGE+zRi2NDg4RCE9H6BNgMBg=;
        b=rC0IUcoDw4LxP1NSsGDabiglAAVrJ/o7UlaUGh9FFq+iA0GifCKiHgg59C+qCVRFEw
         8p7O38LV0NyFlLXQG/D4TuTxuHEhm0TMCUNKxuBiktTAwgWqPTLzCdCgjvGL+dFU+gav
         7y6YxUVeOg/BquAAb/G6zep42bCvkqNtAImViXjugFs7NBWsWZDPDdz3jozxlUYk4NyM
         L5aAfUgBJTKOj2BsyOuqUifBh+BlZdoStH6kvjdV45r1MtijVKlG27dqKOxhNyFW7M4k
         aFpYm+51s3JPEJ0NuJjah3DUQHzv2Svvm3Od+D3/Yj8pgaptBlK6DAPtpafhJvurO8mz
         voZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbGFq+qfMEJkHHh1rvZoKxYpmu5RTUBO2pmMMeKIZPjGJsBPXmubF0zEJ9YSSWJDuU8oTSwqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3VKR4F6xMZVX4LOeurGLPIJ+Rg7rdNEjk2mDl3ILfpyEammjW
	+g41UOOxAkrWVXd3wYsothGJTtQG8qMTlRSLe7xFAm+APWwZaoiovd/cw1tsALD2adOPTCyJa63
	SBgy6qTe6rBfiXJyRNVhKLHBubBTT5ZrQtmt9fFCgCQD0vMQzHDDxVg==
X-Received: by 2002:a05:6000:18a2:b0:382:3cc2:537c with SMTP id ffacd0b85a97d-38254afacf3mr5058438f8f.26.1732179350511;
        Thu, 21 Nov 2024 00:55:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS5uZ0+VI315ZPetn9/2pNfe8s+g3uPtxT0kC/eI2N51ikDPk7/rCHoqVcvf29z/wcQT0Z1A==
X-Received: by 2002:a05:6000:18a2:b0:382:3cc2:537c with SMTP id ffacd0b85a97d-38254afacf3mr5058426f8f.26.1732179350210;
        Thu, 21 Nov 2024 00:55:50 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254933d1asm4348786f8f.71.2024.11.21.00.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:55:49 -0800 (PST)
Message-ID: <a292cdfe-e319-4bbd-bcc0-a74c16db9053@redhat.com>
Date: Thu, 21 Nov 2024 09:55:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA
 before any reads
To: dullfire@yahoo.com, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mostafa Saleh <smostafa@google.com>,
 Marc Zyngier <maz@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241117234843.19236-1-dullfire@yahoo.com>
 <20241117234843.19236-2-dullfire@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241117234843.19236-2-dullfire@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 00:48, dullfire@yahoo.com wrote:
> From: Jonathan Currier <dullfire@yahoo.com>
> 
> Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
> introduces a readl() from ENTRY_VECTOR_CTRL before the writel() to
> ENTRY_DATA. This is correct, however some hardware, like the Sun Neptune
> chips, the niu module, will cause an error and/or fatal trap if any MSIX
> table entry is read before the corresponding ENTRY_DATA field is written
> to. This patch adds an optional early writel() in msix_prepare_msi_desc().

Why the issue can't be addressed into the relevant device driver? It
looks like an H/W bug, a driver specific fix looks IMHO more fitting.

A cross subsystem series, like this one, gives some extra complication
to maintainers.

Thanks,

Paolo


