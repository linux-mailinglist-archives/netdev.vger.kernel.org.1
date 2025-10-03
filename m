Return-Path: <netdev+bounces-227805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E8EBB7C7D
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 19:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE6C24E17AA
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100E82DAFCA;
	Fri,  3 Oct 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2XyMt33"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA12DA77F
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513186; cv=none; b=BVdmz6V7Me7vUKjjKYfzBr04PuwV+4gx7nJWO5AL4TvfqoP7n9PbNVDiQfS9W6Ksn6h/e+55A85OKnH8IlfSLmxgOIv9aJ60RQqX16dWB2k3fsOmHE9JbszpZ6bI9QylPaydAdcyzNV0/ZODrBjJeTpXxpYLHkxIInUjgVXyzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513186; c=relaxed/simple;
	bh=rkmZOyEGwokVeWZxBu8CGNqvK5sClSggQ4njXh3MKtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oq5xTNyZUtKCG6pGRb96sEklaiU5hldtYNanXTxfiuhX/l2wT+Ay4g6ar/MV57HDt+IS2AFdpzFFuE2fzV5UNwwgr0fEluH+2hOc5ETaV5e5/kIMxKdW+3a2v4NTb59IAtGSe5yDiOVwZEfoci2HzqJ0trJNiio2iedSevQ6Irs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2XyMt33; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so15403965e9.1
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 10:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759513183; x=1760117983; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rkmZOyEGwokVeWZxBu8CGNqvK5sClSggQ4njXh3MKtk=;
        b=N2XyMt33M46tWcY4JYRV1NuK7tDXDeg99poy+1sm/KwJTcVHT7hTddNFeH4eua8VAl
         MnObc4x2EleFi8x//Pv2X12T0rYNebJj7OP3BTqt2IKlDmyio21kIJ/F/ee4SMt+aL31
         SL+pwP6FcyG1kt3fYOnnuphQXrqy29y+L2SresV5YEzjslbg0GyV8XOAbKdWgUkl4e3z
         Y0er0uWqOxz5P2cP8WT+zq4ghSqFB3SV6dXhjWd2IEpmFiZlah8VEb+PmZniD6RcUkaa
         zgIGVWgGy7cM9sbG/EgAXK8+Qgm09nUIW4q1bNCEFRNEvhXp+Q5Qd1QRCfhPIqXxXNsj
         pC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513183; x=1760117983;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkmZOyEGwokVeWZxBu8CGNqvK5sClSggQ4njXh3MKtk=;
        b=FKu3Y+kKbZ3/F4qCvd1bZxVWmTAEhMMxRBIIB6uNFDYxe1qOnScYXTeZ+HtMhVe1ft
         9Jv0oNHqIQBqZmHmndCksLXgityUPbxKMBpTmzY8c4yMYzjaZJjobLkIHv/ljmF2pfCr
         LKYiN6YpCa+H6jQ2+2hJ/AEb4ZZ+00XJ6Ha+yxOcoAsohoy9vO1Ef4hF5hEeZ/QfkVOz
         gsIH6wg7GegFRQ/kNUaqiNikdFxAz+RS/TvN2/XoIRIkN4aTje6ke1UIbSKhnJufaFKM
         PeNV3wCrmEh1yshgCdcfndZ0AWXxvLbYYYnP+zJiPbHCzbPx+P848+8fQHmO3RgRrUzv
         626Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx0psLP2dvRDXNdGE7VkckQ2LIxzfYj3Cye6tMbTMER5KxPbJNKiNFqKYo+SEHKBbpScQV5aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBEOXhq0mEtfoDyyuo3S2ta3rt1XoaNAob4ik6o8VEa0y4m74E
	Y+Qp+QFcgVnyBh8WtB8slPQ535fTnp9fPu87/LXAECfh11SoMM/lca31
X-Gm-Gg: ASbGncvRGxkJHH1Pdg7hbTGDgmfpjxDiHOvAXfaVhppSYXEmbxoHUHCCligC+YxX+rf
	on9nK7c2HAyaJlJIoIUHx5dMMHdcrC1pBh+CYqZGf6ecGceHqM+7WvsAYXKgTUW2DdkIQYslCaP
	9aZSna5oDIzUzUJ/P9rNgUH0i0zxDBYqWSmW3TePSqed59Ud5TiQsNIqD/8HbIOK8dA7n0b6giP
	q6ox8PeJiJeVMIj/V86GJVH3pbMFgs4S/P3GCuKom8k+tt0o+cI4ktmCSvBqyOuf0gXH+wbglUj
	xDmISddo6YCbKvMQIoyS3Nn1Q1xKEJbEhxjsAnzxz9/r4w9mww1G39bh2wC5mkvSlra7IdkPBe/
	nH/X17vHcYF37VEnhS0JH2YFjjzHZd+ZNd7GGZ9J7EPjvrTEQ49+J0ggp13gbLrnltig=
X-Google-Smtp-Source: AGHT+IEuSki/XoM4rCKcaotfXJjqysypOd52m6IgtN6NTBsDMyUc4KvPqkIPo5OYOt/kydDekftJNg==
X-Received: by 2002:a5d:588a:0:b0:3f1:2d30:cb5c with SMTP id ffacd0b85a97d-42567154011mr2824129f8f.23.1759513183310;
        Fri, 03 Oct 2025 10:39:43 -0700 (PDT)
Received: from [192.168.100.3] ([105.163.1.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9890sm8871298f8f.32.2025.10.03.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:39:41 -0700 (PDT)
Message-ID: <b109dcf89e3e1314224e5a29706154c2e612e079.camel@gmail.com>
Subject: Re: [PATCH] net: fsl_pq_mdio: Fix device node reference leak in
 fsl_pq_mdio_probe
From: Erick Karanja <karanja99erick@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  David Hunter <david.hunter.linux@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
 <horms@kernel.org>
Date: Fri, 03 Oct 2025 20:39:27 +0300
In-Reply-To: <77f2a45b-1693-4106-8adb-304e0e818d82@web.de>
References: <20251002174617.960521-1-karanja99erick@gmail.com>
	 <77f2a45b-1693-4106-8adb-304e0e818d82@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 18:32 +0200, Markus Elfring wrote:
> > Add missing of_node_put call to release device node tbi obtained
> > via for_each_child_of_node.
>=20
> Will it become helpful to append parentheses to function names?
Yes, it is necessary.
>=20
> Regards,
> Markus


