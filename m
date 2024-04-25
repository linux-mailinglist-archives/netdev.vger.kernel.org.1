Return-Path: <netdev+bounces-91326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BED8B22F2
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6DFD2842CC
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3BB84FC9;
	Thu, 25 Apr 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ/TkmY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DE3717F
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052277; cv=none; b=eFen8jaAmKVOoTgc6oFfwMcMqdzuXUiANfcgWJGTW6Lp1a8MaZAOSUbci5oDL6tGYlaI9eMtk+Vrye4f+H4EU7J79mCm7ekfFNYUYMZmRnwcDL5kO7goV316k5IJvHJPROkdl9/x8O8sDTWL3qpXg6kBNpZ1/ZDDFfvVglooF/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052277; c=relaxed/simple;
	bh=igu+g38jZzVdAsr7p+xpDq3kc478JwjhucnC+QqU0bU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c//JjwV7T1ZF4si+OvFhouc6PFINJ1eHPBNN7ZF3kL425rtS3w2QcwMTgxcV2heeoS3zAwJlyYvZC7VaOoQNAJ4fAqQkLzg0053HSzVANI4UWxZH1sytlHMsssQZgO6BIF5wKTAX1t3srCQi87ICKyw7kNyDBrF7Qe7cvFN3jFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ/TkmY5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e84787b0a8so32365ad.1
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714052276; x=1714657076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEsRFIzgSvbLYjiIDk6MS0kl9NDC9LNX4khGTDo8tpI=;
        b=QQ/TkmY5aZ/y4r496qb2WApiQ++aE/C33qwIYsNN280EOJqGelCsnlyoLXbS0vZmja
         Px6QriCAQ+9vzOlEhIP6WCsu10aS4o0iIIPvLRGVjS9+gAWn6EflEcsLamls7kWNU7sz
         Emt5C78PgIEB+zk8VaayNoa9276HD92luUaWnes8z2jCuBEHsFr2HZxNO63c37cRobf7
         m+WHnfDAHRVfowMLBMYUEQgAWynGkEkIXhOmIxTEMyJh5qlCP6O69IrlHAZXx3ibU4vn
         9M8WpI8sgmDkFbYGPvmihutl9yx6f+88eRytSRpJN+hE492oZE3ynMIoxUF/8kaLshAe
         OXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714052276; x=1714657076;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uEsRFIzgSvbLYjiIDk6MS0kl9NDC9LNX4khGTDo8tpI=;
        b=QvV+CX+6NOpL57BTYrLIGke9aonzRHEsyS56uk47rQQNb45/5jrisN7OcXnySG6WwP
         BvuzUHPbDgjojqHIjDR0J9zsF8WSl86fKvUvF4BwLbUP/pWaLb0l7J86fHtLwwbjBBOb
         qGAOp7oEcm3Pz3l4Y9Mxp/RfNizY8IwWKAppqrb7uPZd8wCRLmjlavyN1+CzGDACfcNJ
         bviK203yoRmdlRwg9binfC8LDBw1y28nNVCg2G+outHWbScSAT21v11HrSZ2C0EHBUfO
         gSdxCGwR38JWg8uJTz1YaVa/yZVmEI3uGLIMNPPSTIh1J6NvEyu4fWgrOLii9mu1dI8I
         26SQ==
X-Forwarded-Encrypted: i=1; AJvYcCX22doQCinxokVmwaVp8bSMDPGIMUsu4ukomAFfH14XUNK8jD7UEIl0AFPEsrz+wCL5txr1doap1bXtUVUYQJXhD12XmB+R
X-Gm-Message-State: AOJu0Yyk4mTggitS53b4HhtQ6c2X2wdv9igy4b9ziWSbLxE6W2nSIk3I
	egaoKIcf4YhejVmewaXQtexvOO+K7s8//OkMVhmwfrE9liezGPdIZULe1Q==
X-Google-Smtp-Source: AGHT+IFs3Ai6p4kOgD2kmRfxFSAi7rbJH73snWJVvDUUygbMQCPeFWAep0cRioM4C5QUpNyHwLbv0A==
X-Received: by 2002:a17:902:a613:b0:1dc:c28e:2236 with SMTP id u19-20020a170902a61300b001dcc28e2236mr6306599plq.2.1714052275704;
        Thu, 25 Apr 2024 06:37:55 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id a19-20020a170902ee9300b001e47972a2casm13813084pld.96.2024.04.25.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:37:55 -0700 (PDT)
Date: Thu, 25 Apr 2024 22:37:52 +0900 (JST)
Message-Id: <20240425.223752.1359016853102318865.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next v2 1/6] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <966aaf2a-a21c-4e8f-9ddd-a4541cfc94d2@lunn.ch>
References: <20240425010354.32605-1-fujita.tomonori@gmail.com>
	<20240425010354.32605-2-fujita.tomonori@gmail.com>
	<966aaf2a-a21c-4e8f-9ddd-a4541cfc94d2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 25 Apr 2024 14:54:09 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +#define TN40_DRV_VERSION "0.3.6.17.2"
> 
> A version is generally a bad idea. What does this version even mean,
> given that you are re-writting the driver? You might as well call it
> 0.0.0.0.0.

makes sense.

> We recommend that for ethtool, you leave the version field
> untouched. The core will then fill it with the kernel version. That
> version makes sense, since it gives you both the driver and the kernel
> around it.

Understood. I'll remove the driver version in v3.


thanks,

