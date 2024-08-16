Return-Path: <netdev+bounces-119210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649E954C0D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7293287DC3
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA00A1BE87D;
	Fri, 16 Aug 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGRDwOv9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507D1BE858
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817594; cv=none; b=COhI1Nxsp0JO30S88+ibKGAnIaP/aqIM+ba0oBNtUnPn5TBX6f/YbYfZhYAOpDr+3iIUQq/I0Koyd6IOnZdOsKg35ol1HkucgAveyEXID6+nZGw722QC16MThGnM4M/5u42sn4O1Wyv0va3P69YYWdaS368ebYS8Dp2fNDCgNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817594; c=relaxed/simple;
	bh=CKUzvbgxVZvhVjlMKS2CsSvWNqox0m2T4c5UJjvy5mw=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HNVvgvbHz/FGqwdVYRF9yqQ1LWrQIL1uAPAgO+Xn64YJeYp3mHXXWPE3yxQNAWokTQKWt9D9A4Kbjy0j9ysD1rwDYWdH4NOQL4DX1fYKe4/t3S+0Scs/BIQskV4hY6XVT2OwjMFftQbxc0LMO4l4wPFUtfePbPHo5agxfl6aeIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGRDwOv9; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-709485aca4bso1078625a34.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723817592; x=1724422392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQJrS8vaahok5nfktsFdZVCbOSJ894kW5wT4Dp3b4+M=;
        b=RGRDwOv9TjfP2WWlfV3WlV3WraRdwk2gjvDxnO8Flbme/MPXJpPcL2iteQcId7x2bW
         rm5EgwU45b4adqMNzw45rMcGhpAhyqhT4px2WTBHeHXEddRAW0BBe4nBgToSWDd0xGzZ
         oqZ9w2lVoM4NkyZRE/LXLw5gp04MvgSWQ4LAoUSrkarfjmJXwejo06qU/4uFrkFcdg6i
         LUi4dWEdx1ScVJ3Lhg9woYFeHhYK+QLl6J/uwk6++WJq4JMNANnkaR8dmslyDfOs8dzo
         Ye+R5OK1kdOsZMha+PS5uoBfMx+6dDh+I/cXsaEGFdNV9lgi8kRToGptKio03/7AHBjv
         p0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723817592; x=1724422392;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQJrS8vaahok5nfktsFdZVCbOSJ894kW5wT4Dp3b4+M=;
        b=XBc+aYvpzOUyThKJQhm5z52TNz4jF0aFfMXvul7ZsV18HMaB7owlflyf/o+jwtGnqP
         VSZybRIEaRlAhx5X9tEk8UAEJaPlbEg6O90XxCBQ6a+cpqhmvc8XFgeD2CORO60UwyF+
         Ld87dX08v0TsL078FxLVv2LjCT/K+62PC+X4OBej+79Y+YxWNETvk9CzUtJ6FytoivtG
         CDbaAX932VqSeQom0EwmZ378v6HcFMugv5RGFSAw2olHXUf4jIYTtiabvWf3sxhGEyUX
         EmA+CouznMMr6xwBO6yEUlC/mrepWNKGSlFXxr8HCU/OK0g+60BYsKiG1KBJfFjUrAaj
         YJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVSnDmijxNY3zJ/xNtHs2QZ7mvatbS/c31+w5hrDhllAsZGBue36zPkRb+O6FVHPNrpDrZ515L8YeazOWObhHSBHOPmUPU
X-Gm-Message-State: AOJu0Yzx0fkCbdd0pyY7q/TdWUana8vrxuwfgsE8RjGVQ2kJTTUvfXAs
	2OEsA05l0OYiGlVCHjszcu/l3YdWec2CPZxb1njITCHJFIaQAO4kEEH9zA==
X-Google-Smtp-Source: AGHT+IFLANY/wms251fSDuDnzBlx6MdHlJPsqSh5dvCqVz3zqrX2IDbvoCUan0oqh6Vj6/cFyJWwMw==
X-Received: by 2002:a05:6830:2807:b0:70a:9876:b781 with SMTP id 46e09a7af769-70cac8bdedamr3646197a34.34.1723817591982;
        Fri, 16 Aug 2024 07:13:11 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe0d77fsm17875486d6.46.2024.08.16.07.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:13:11 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:13:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 netdev@vger.kernel.org
Message-ID: <66bf5e76d36cf_1341d52942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240816075915.6245-1-nbd@nbd.name>
References: <20240816075915.6245-1-nbd@nbd.name>
Subject: Re: [RFC] net: remove NETIF_F_GSO_FRAGLIST from NETIF_F_GSO_SOFTWARE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> Several drivers set NETIF_F_GSO_SOFTWARE, but mangle fraglist GRO packets
> in a way that they can't be properly segmented anymore.

Can you share a bit more concrete detail: which driver, for instance, and
how does it mangle the packet?

I assume something with inserting or deleting tunnel headers. But the
fraglist skbs should be able to reproduce the modified header in
skb_segment_list?

> In order to properly deal with this, remove fraglist GSO from
> NETIF_F_GSO_SOFTWARE and switch to NETIF_F_GSO_SOFTWARE_ALL (which includes
> fraglist GSO) in places where it's safe to add.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>


