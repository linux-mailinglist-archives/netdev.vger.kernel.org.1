Return-Path: <netdev+bounces-202172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C2AEC7D2
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAB33B7334
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15062224AE6;
	Sat, 28 Jun 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SALT3DWB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154E71747
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122163; cv=none; b=Qbvhe4ueUWoiWSH0YJt52v2q/XEpHGZQBmp83F5iMY6o1jUtgJruQZ8p5p7TmxowL0ITr6P9WSgp8ZoTIkqpno7PgnkzqP5LEsRdEU8WYRicHMlbYeF9updsCYdxU2tMtKmVqy6MYamfxGXgVybHAjPgSXT9E4Rh5w7H6zFDgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122163; c=relaxed/simple;
	bh=+GM/zHCTvliKCjVYS+eMw7M9XpAayK9kPkEW8XQAzPE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=k7h2qtGv6mortJvVLGwRG3ICKtYAx24gZJPs2WDAhOZUHsNX+KFYTnosplOaIy7OgBvI5QgJyrXrSXRF2T9+OZUbsr3QgmV4gpfahfrud5Vm5F2AffGwrwJ5s/yQJl8TBiG5+onVa+69kgn1kEtzPBwd7EvtTIKkpii6gnpo1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SALT3DWB; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e77831d68so8264307b3.2
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751122160; x=1751726960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmI1irtSPeF8p2h2T3OJuQSHXp3IA5FZkozsT7q2o/w=;
        b=SALT3DWB32QkMdLmMZ5GCEZtg5xkA1QcWlnYfpSwHGOgG4u8+wAy80rVsnxmpXeUjJ
         4gGhoy65+/kzn7bhhqlCpN3w3x4fkKZ/JGjMIz5GqQBLc0wP6CiyAj+gK0o1MTvz0QfK
         nkJaBAFn8VvmTjLcCpgdVYj/e1FSpAlVoaNQYe0ZuK0nrI6MO7vFv+WqjmcH91a/Kc52
         ifS6GUTQ3nHlSotHlgsJezIALqhhx4D/JsIIoMKM6fuTMaw6ScT+M/ZRUmyTBh64iGh+
         zpo8PVuV4FxWrrb9YcwSY65HIySM5q/cXhKyziGyaY4wtfCJIbW+FoEtul6oM8n5NiL5
         mBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751122160; x=1751726960;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tmI1irtSPeF8p2h2T3OJuQSHXp3IA5FZkozsT7q2o/w=;
        b=vP45uWmWFvMr3fO11xl8pX7Hq/4DjKJfwKrI9/2tC2JedhD3RH1nStMzGyWSdas8cq
         rVVBRGBfcKm48vbSQ0mcr0pbZf7rTx1e4zzj9VSMcWwe29KRIVpfX3dofz9Je+CeRowz
         EwA9Av/pW56dKTM2uOCcBNtfEXlL5pnypGnbp09MMbbEjuqnN16Pb8d3ZF7u7z+dMbvB
         eRaLZKT7sIOqOAgHPgk7YOchmN/Yujsx6mPd6X+r7tzmvFK9FxsMV8pdunGojFp6FjmB
         tr8pXrssWbYZr0rMmz/a6p/+l0q3SG93/vEj6LiRAf2Q/pF+M1zNCYjOWKPc0baUDPl8
         D5CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR+D8ezxyZIILMHTPTO2XO6lH7k9QRU1DfFbxViJGtwsiL0ArcecEJyOr6dIfda5uRVS+JM3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2kBx10LOU/aWFjimzU7VPyRQPSR4P3/OfD6jTLeLq37iqgHEL
	CO484GulikssIITEVLgGHo2f20kgnRskiwQMFLzHo2Ucqf6Ui/oiYnn/
X-Gm-Gg: ASbGncuEtOKYJy50T+02cy36otRF8Gyp7Druk2GLyOkhQvDnxFnNbxGtWxcn2OooTCJ
	6RyZGM6oK3W+U4KEO9IK8LTGLWIkCJth/h65PHLz0AzswDcpX2pe131ag2JnRyokQ23C/EFoSPu
	QbdW2xEY403PiISkP0Tjox7kkkpCyltDF7KlXH/N5LAhpuUYTW1wxcyvPcyAHIJ8d3geP9sqNbH
	i6spvJmtpIbJTDRKUfU9uzmvSykGT4tcI0LkFd8FpVOhfnhQ57qE5AIB8XMYvEAbE7JUj39/neW
	IJ8qAFhDzR9EW9/3WXTEKKQ/YXWdRbxZrfN1d9eH+/fNvQJdZ6+QsU1ENqlzY5GC0nHXINCCH3d
	Tt16p7ckhkpM3wEbmXLM6mQWvu7yOpxY1KxBKt9M=
X-Google-Smtp-Source: AGHT+IHVDTn8rlO0lYFA11qI5CwPHWaqYjgIfHHdi6rnKrkIzJhPjct5EM5zeeIBHj2/UJvSnj+hwQ==
X-Received: by 2002:a05:690c:a95:b0:703:b3b8:1ca1 with SMTP id 00721157ae682-715171366a9mr100641797b3.5.1751122160468;
        Sat, 28 Jun 2025 07:49:20 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515cb423esm8318937b3.95.2025.06.28.07.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 07:49:20 -0700 (PDT)
Date: Sat, 28 Jun 2025 10:49:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <686000efa97cb_a131d294c9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250627200551.348096-4-edumazet@google.com>
References: <20250627200551.348096-1-edumazet@google.com>
 <20250627200551.348096-4-edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] tcp: move tcp_memory_allocated into
 net_aligned_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> ____cacheline_aligned_in_smp attribute only makes sure to align
> a field to a cache line. It does not prevent the linker to use
> the remaining of the cache line for other variables, causing
> potential false sharing.
> 
> Move tcp_memory_allocated into a dedicated cache line.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

