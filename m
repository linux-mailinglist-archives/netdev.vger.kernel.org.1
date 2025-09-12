Return-Path: <netdev+bounces-222495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D3B547BA
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867F33B76D8
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A487F2877F7;
	Fri, 12 Sep 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNNi5qfK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7B2287515
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669245; cv=none; b=VYARJI6jV/tHqmsSYNgyeWqww90G+P3FgsYFlrTesYcupgFCOGouX30pk2i/TPQ1cftlsjHpmZtdQBMEKh/AjJDC0fy3u8o1iI4nqTwQVZK6u6ezPbTbH7Kc3pH+zBLhVBT/SqOgDY+bvrJNVKwYnI09oHcLsQQCDO0pmA5NsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669245; c=relaxed/simple;
	bh=yJJv2gjhRQfuHF9Gh02OKGyHVT4ciENi2NSMHDOldJQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=p/opHBnKCRJfozQiT2AURLKaEoi6NHxPdumISy/T0ZhVRFKGJiqjxcvhJ4yKzQQnaoGWch98ekDF/WHvroO15KddZTP1X9rQd0et8yFRTtfcpSDJuL6vNpqg5NMw+raj9/DjE0TXDdTxVARd1KpSRAZOqXufY7oojxkGf1I55xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNNi5qfK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7725147ec88so1054246b3a.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757669243; x=1758274043; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZB/EENzQ9cknRI92mO2zkQd2VPyMtef2mDXzKHOG7A=;
        b=lNNi5qfKFf5sKGba01fJO9omJsse1xLX+fvDFKAdfUgfy9E0842oQIFZkTSNdTUReH
         PiJ6Bb0N9JABw9DuSLWfBYjALx4EbRHTrTFvHUO+XyrjF2XbjR+pktIrgj8Wi4+joxI9
         UJxp0R6BIbpEBxpIDoNA2gZsHSNlhFSVJkp3uvaaHJTnPUReND5ikhV3h217mOEmIB4c
         SL4IRwStmqCgdAv88WpfDP5C8yqkqnGnaOPME8ckilYezrGNa++t6hn3dWb/hGlttF4P
         QOJOnu03VVpZRI6TLBevyNDvIJQySEynQCd4Ws+djCEV8nEkmdrkVDkhyJk3RmPEJBYG
         supQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669243; x=1758274043;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ZB/EENzQ9cknRI92mO2zkQd2VPyMtef2mDXzKHOG7A=;
        b=sE0XRgerAkn/TVyWjsHTWki/0xfYIDrPA/zDDplyaEu9xv4nl6fMXV7w8YDqOu35xw
         5q1MqH8sYFbyEh1tnJqR6Mask3kpelzXlEXglWbt7JnGv54t3eN1EqKmalJDh5eSKBLE
         iZzFRqb03+rBNseP0Z2bkpHootRHsJ978/KNrd5DuJ7XNbXxT8BmDibgRALF+Hooe/eI
         W1qtNiKO2GniZ9QvUQjUaQXwcRIYl7FddB/Imz/gInWOUc5KCCvF8qKA/u1ppPHUF6Qd
         h75/04ibNXpA+weT+XOGq7XNq8G674gNn4Cz8AvQAkF4x7ZpMWHOfY4jDDfxsdgt1pU/
         /m9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqzFWU9iA5MCTw9FYSulQjU45nFVAVAWerggw76fpXtwuVnCaCeBxbXLbhp1WfK+SSKiMIBvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVvNuYXlj9vbYG/XiBc8V/KMSFS2ziShPdl3odu8RG5SgFiq3
	Fg7MYmi3woOPJ9bRESOC7GnCy8LJhJQL/J/FiGtHOahvb0arKxhzxKOJ
X-Gm-Gg: ASbGnct/m2jGBw5XHYrO9zWy2IpXD4k1YwnyX65vak9q+qFT0ICNSmxmkucWiYV8pxK
	4yzvWOoTr8bHWOLglmB1d4lQwRO6b+hegupVXhcykgqzssOHiam6HF145mqr99uvIHxhP6f8Fwn
	NVBv647js712KTwBFuR7fBaLoYMe88dIYCs16Rh9kgct0fEpkCzVcjCfawd+rekQF9xp8e2ojxl
	5wKB05IdQylSaszuPqf/GCh2PCQhAC4naNRZrgToLp1B/G2/gdmkCqEr0Wd7JVlL4bioivDOsrp
	hcIGA0TR8WWOgWHLoXkS5mx/nNJNQ9IyVgkmYfTKYrrkMVDEHHLcB2c76WbwhXdoJn6TirSW3+e
	GJR7ojUa7T5o34X6SX4QWlGqdkhVVq2qrJbj3JKaMSbf0S3BIg161zsYvZ9Nf2H8=
X-Google-Smtp-Source: AGHT+IGzZmv4BSLblDExiYIqYLLacdpezaosRNfT06DqWMAt9pAoCpyMABpeGs31Zcum/QN6x1pLbg==
X-Received: by 2002:a05:6a00:3e02:b0:76b:ecf2:7ece with SMTP id d2e1a72fcca58-77603319615mr6443572b3a.12.1757669243294;
        Fri, 12 Sep 2025 02:27:23 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b6d3sm4819370b3a.11.2025.09.12.02.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 18:27:19 +0900
Message-Id: <DCQPQTBY5SVC.1FKEWQBMY4WZS@gmail.com>
Subject: Re: [PATCH net-next] net: dlink: count dropped packets on skb
 allocation failure
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250910054836.6599-2-yyyynoom@gmail.com>
 <20250911170232.GP30363@horms.kernel.org>
In-Reply-To: <20250911170232.GP30363@horms.kernel.org>

On Fri Sep 12, 2025 at 2:02 AM KST, Simon Horman wrote:
> Although new users of dev->stats are discoraged (see ndetdevice.h).
> That is not the case here, as the driver already uses dev-stats.
> So I believe this is change is good.

Thank you for pointing that out! I also plan to rework statistics code
to rtnl-based statistics. However, that change affects a large amount
of code, so I'd like to introduce it gradually and gracefully.

>
>>  				printk (KERN_INFO
>>  					"%s: receive_packet: "
>>  					"Unable to re-allocate Rx skbuff.#%d\n",
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thank you again for reviewing my patch, Simon :)

	Yeounsu Moon


