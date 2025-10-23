Return-Path: <netdev+bounces-232091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08846C00B6D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2D764E8EAE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DFD30DEAC;
	Thu, 23 Oct 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6h2AZl0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A152DECB1
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218845; cv=none; b=SgQsAAHs2jpjsvfzt/bi/VD1PdbRSNxX6pLFWbW8KD72ksjtqEza+NdYoIV0VeAdbF0id7XTcTcNhPOhYd7W26A+QzyRL1PQ3vBTo3IahkIbFxML2pSvOMOwv8JgbZniLrbpoNaIP1oGVWENg0LATXxS03VKN+CfmT0DJT8u1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218845; c=relaxed/simple;
	bh=omXtqGdVwaLttMqdnLj+e50P9l/qbdlv1wXvTweGH/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+HOuIFS8OflFQTLyR0jNa+Avcz0hUufkXFnHfF60nDSOVq0yAQGvIhPI5NkRITXQ2nMMtcGod4XwcpSpWjHSkLo/1nz3i0UwQrufwikBXiyksBxIcdougY9aP/5PafuCVp/2DAs1ESnN3Ywl4mrQbBFmyRK0j18EBOeu3+WpTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6h2AZl0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so574842f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218842; x=1761823642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5A/JaBnPQddwxFBHkEH+pN3tR6CjA0uTWCxQ0JnFwY=;
        b=A6h2AZl0uTC2GseDEA2suZ/jOBvgIMvIBE6rNRpTxVH6jkWpt9B2nBQOkplD2/sy6x
         J+wDlS5hj20v3ZpTJWmL1H8VyhPY2FfK2umYGOEzSdfkTNf5xbGI4w/kAOsykCkJWR+s
         YI1VUIf7dqOMQl2h2I6StV7MhVAN7wd1gsVXVaDLaTdGCXMwz/gNKu1umjOoaAlm1lOs
         ps61AAacxyXiRqSnel3htnGoiQ8ZLMIhVHyiOyKdFWfiSm2C0MZDIK0WLZXQKtHtJR8J
         mlfvxis6exuotn4n4lcDzr5mH/RNzv15Rs0vdiKha1LhQckYrvwkhIwSPd0v/QcKY30b
         vDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218842; x=1761823642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5A/JaBnPQddwxFBHkEH+pN3tR6CjA0uTWCxQ0JnFwY=;
        b=Sj85Xchr7gZYnwe0BqiY87/YT278rmrYplL0xNZx/KqUsIBT1uTqbU611CKc6IkRuR
         zG4qWsZ/ZPW7eOn5MdXzTHeEiLhgkBzhY9s1dI1yeH9I3rtUgVcL4HNqC6HeEt3/ecp9
         90aoyXZ6eEsthUwPszP2d9Y7qV55umEXMLrwpDQ9u1vwQz7ejDgWe+02CacYgeIPaPjk
         Phy6e9KIjedwHfnRNvABDUY54KlXuZ5Vgv1h936sENQA6bg+swwYzR0x0gpToV9RT8K/
         T6nhdLicakgC7QAPErMS7CPreliVj3H6Au++QQhg7aH5fwMBqYOda62Ntxn9s0H/hPaT
         LDOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqWsVKNGRvDd272QIgAI+uCGpaOjrPoOahmhlcTBoHwJZGhHtc6QIrzg0uxYvSzgLrpvZbPr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKuXoCnnBQegw70UWx7ZRX4Dm0lHPh764crskbJkaEhuIrj/ar
	p17tf4tVX2f8vGP1z+529Y6ZjOXKiOD9HnJREYrHV8am1J5ZyKk3ZJCr
X-Gm-Gg: ASbGncuNSJ3+T8sHNcPGvjETaMGHIQ1m5nMmJILDuMok2pAqtkCZFDLVMSPDv+zGzw1
	jGiyc1m+FdbPiKj4R6ZE2/wB7KJvsQv69N5XSiS5qTC/mBwXHmbDbZ9mk9C2K/sLFtGqMzt+/uk
	QVfnCmuWm2RhTAo7xLwGLiEwwuSpuK7+JgjIaUvtNPVlugnQXkAuhHExN+G7qgrzQgB9nDpFH5D
	2r7/2/xoaWswk9dAbX1a6K5/daHGDZoy8QioAKGnTE/mxQbtLzJvbUFKrkfA5lN7Ne0tDJJnZ0r
	FYDirdut2GY8MyedLcvk3jejIhYHpZ29vEarMk9dYHgjADskie+7crlf6wRmEq46sjGMQpTPxuc
	CJc5RZn3m1Ab7TNEV0zLdVQnfuG4rUwCtRcASSa221KhPVeuLmMzwXiOF0WrL+I+QfWWR0fwGfT
	PD7BC7rvM3BphBOaGR+gjiJ0C+gb7n52LqWKxpqXUJLQ0GVX307yE0GQ3QZEbOd6U=
X-Google-Smtp-Source: AGHT+IFWosB3kP1cunqsyc3Wf0i3HHGXOo97SMwmCET8H8ejn6hdK+I4Wg/ThmA0FKOUA8GfgazJig==
X-Received: by 2002:a05:6000:1a8a:b0:428:3f7c:bcf8 with SMTP id ffacd0b85a97d-4283f7cbeefmr13605166f8f.29.1761218841399;
        Thu, 23 Oct 2025 04:27:21 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f53bcsm3516370f8f.11.2025.10.23.04.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:27:21 -0700 (PDT)
Message-ID: <bf3d9390-f1f6-428d-b47f-81d2ed1707e9@gmail.com>
Date: Thu, 23 Oct 2025 12:27:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] sfc: fix potential memory leak in
 efx_mae_process_mport()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alejandro.lucero-palau@amd.com,
 habetsm.xilinx@gmail.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20251022163525.86362-1-nihaal@cse.iitm.ac.in>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20251022163525.86362-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2025 17:35, Abdun Nihaal wrote:
> In efx_mae_enumerate_mports(), memory allocated for mae_mport_desc is
> passed as a argument to efx_mae_process_mport(), but when the error path
> in efx_mae_process_mport() gets executed, the memory allocated for desc
> gets leaked.
> 
> Fix that by freeing the memory allocation before returning error.
> 
> Fixes: a6a15aca4207 ("sfc: enumerate mports in ef100")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

It might be nice to also add a comment on top of efx_mae_process_mport()
 stating that it takes ownership of @desc from the caller.

