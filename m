Return-Path: <netdev+bounces-178042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA6A741CD
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 01:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3B816529B
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 00:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B25519F40A;
	Fri, 28 Mar 2025 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAh3lYci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8A19B5B8
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743122497; cv=none; b=rYG8tCNxyiprqZtWAxBFr48q1QNzWqFPn4phFypoIyw6jpIxnI8UI6Hre4wUmrHDYF54UHmN/FUSgzIu0lSejn88kQkf8S7+AsCPWQrjKAtzC/ZbJRpnRMn9HMGDQfb2R8ncwjawwd9Y1OApGrFE8yd6Uh+NJsx9TSBomRrjNW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743122497; c=relaxed/simple;
	bh=54jan9pRA+ZYts7Mya2f714U+KehTpsVXL6J55sypzw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RvWEi8jlyJ3U6gdHZChv+wTM3ClG3pxuP17T768pCaqx9XdjUlXAiZ4BXPWrjF3FufzoOcCJQDyMoQRaa1RBMOH/TWdz1bHdvES0GXQTZf7mFo6eI2yPrVlgYvtBceVO8lJw/5JWuPIiV2MoHw1acBGIyfL/BhVECbzE5wBx5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAh3lYci; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5e39d1db2so99971185a.3
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 17:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743122494; x=1743727294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDs/LUvvT0NuWjQd26qrIn/NNI0pO0289NzvvKVJAS4=;
        b=CAh3lYcicTormtLh77ItUA76KHzrdfC8yKba840nZmK9RNHYSOJXeNKYs+Ga5V9D8o
         qZd5Ic0rwL04ogWgfKDgwX1NaQS/MTPU+kyCfv3pB4v6OrPlOOLP+7WBbv1lq8UnlvVb
         HDBBYPNvfgneW2QTAYobvUKpFjHjTbr1tLf49SnVbhr2AnT+pnK2LaytquMuA3LVCYHU
         pzS2Xbe7P0y/rLe4REaMxcLr59dyn/Z309ipSNncOnTvAQBdeBdeWNqv2n4pYqBpFLwZ
         oXmPHq/flm1bzvBdynpcHWrRUFH42iR2+PRwifvelQqO4Xr8D1Jr9nTQJuliqOQyt4Zx
         bnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743122494; x=1743727294;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GDs/LUvvT0NuWjQd26qrIn/NNI0pO0289NzvvKVJAS4=;
        b=SFhM3vB3G9t7BBMnqwzR+g1ZBuFTbUPUxHg//G1jAJWCXKFL944BnGL94xAkYtTSbG
         dGpGJnCy42NS6TyLWowxmczkNs28GjnRBvzVAYncNORA9Cf8QJrrfgyWC6P1zsKdneAR
         pG5W13PBM04IHYaUoj4x9QyiHahtNO6vwQoBSQ4r75MyfZOSfxsf7pEorYNU2cbGjZBH
         QPn8tIJlfIrn2kwa3XLYd9zx69RTXsY5/pwZeFJJC/UTiJEWqCk8Oq0KwkIfUW/EsQYs
         hTTh7hN5J4L0guTcBqeBIV66pr6zoQ5gtGFV7t31kW4G3CtqK+iOKQ28sAK4wLibKAgL
         NN2A==
X-Gm-Message-State: AOJu0YzdDkIPp5UyW0GXpy7V6oJUPdpdp96VHYnyvak6+zvyROjhwk5p
	bzIzp/Is89aS5wF6H9ERwXdFy5Gaq7JxbPF0q+hG1GmPDbgOCIii
X-Gm-Gg: ASbGncvUxsrJrKjK7uENkhR8xOvUMCXE9E8mrpVG40oP4sA5VLRhnEeIodksWeE105R
	Xe1gZlhF5eYNt/erZ8qfgOmH/CXceexWz/RP/yNYfcnT7NwVvy35Eg63mtIBsqXnb5QRXvjdxkY
	WozmYjwRdiBwL81z0H5Wt8OxQDnf9APzbmWMuPU4HiKcqByhNBVXriIfg5smvk8hhSS0PWz4bR1
	TCwF8SKNDavMu5t7GpqlqkRyG0qS0gG9ZRVxrQAbMy+0iJOd2CrmYhVfLPYGVaNXxm1MIWQDMVo
	ZTfx/RecghuFklQwxZamiaRJJX0Mz9q3X9orWf5jsGOEdfTGCHcW5q8ptMay6VErtmZY5O4SRyO
	f/lGbPvCqILWeUCAIweSwHA==
X-Google-Smtp-Source: AGHT+IHi64hAxq/7y7kPmRvi5MV8HS3sBPbUjL1kpPkkglVbRxuOi9BVFivvKTQiN8nhD82wQZbxqA==
X-Received: by 2002:a05:6214:76c:b0:6e6:6477:de09 with SMTP id 6a1803df08f44-6ed23960f87mr68671766d6.43.1743122494204;
        Thu, 27 Mar 2025 17:41:34 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9644b08sm4827916d6.27.2025.03.27.17.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 17:41:33 -0700 (PDT)
Date: Thu, 27 Mar 2025 20:41:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 sdf@fomichev.me, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67e5f03d79288_11b3cc294c6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250327222315.1098596-4-kuba@kernel.org>
References: <20250327222315.1098596-1-kuba@kernel.org>
 <20250327222315.1098596-4-kuba@kernel.org>
Subject: Re: [PATCH net v3 3/3] selftests: net: use Path helpers in ping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Now that net and net-next have converged we can use the Path
> helpers in the ping test without conflicts.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

