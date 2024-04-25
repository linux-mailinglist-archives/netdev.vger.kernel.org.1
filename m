Return-Path: <netdev+bounces-91327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C948B22F7
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C67B22560
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1856149C56;
	Thu, 25 Apr 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpba6MS3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA47149C41
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052407; cv=none; b=KVqxGLFPPzNdMtizGJPu6GUp7rivVHmKektOv5kQy8TQ7jySWyUhSUF2lHsG1vjSY2vt781S2cYno4H/A6qemAmfTYB7+4M5icwfywZ7z4vkOcPQLppEYjorUAEoUY9+K9PMx8a6eOwGuFVi+VbvPGmX/e/MklUDums1+HuksLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052407; c=relaxed/simple;
	bh=jrqyPKS7Hlw8xz1o5hjpgOooQWgQAMzKu7QXs0/9e+g=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YMmzEsxkJurTHbq9sYhFaS4pkoTzrTzXZ5I2ehSVc0hu6MCuEtuLYdZKiP66y/Ch38Ubq+ead6GiAD/LFSAbUvWudCjnFki3EseF7tUWH0GK0ufExOiRtjMEXoimC2XFNx9vTqSpAHEpWtS/B2zMuPgO5K8NRLWwQMXfjG1DaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpba6MS3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ac074ba920so267087a91.1
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714052406; x=1714657206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apJH0Kcfr1yw96r7lDBX22wpYYdECb8ZVgsjTYPjMtE=;
        b=hpba6MS3pLQyMc0fmFiuvqXJ6FUdWn2JgGEj86ip7CLVGruPjLypB8mlUM9/HPAD/0
         QsnO0IQa8p+HkIh/yDzk5LJhIKY4TBRBlXkSOeS82d5I0IcPaqKOysJfwgudF3/i4rBr
         6eu51nmqFacOLieB4DcoxHIURPnzwvS2Mu1MTU8mk89LbQuuhPCu7H+8Ai4EE1l54Apq
         T1mm5BhHppgfUQUshzwgvyV+UULxCZ63ipSZMzTBhaQAUSu43QWUDmWRi3W7b65AD2AD
         3JtPd1b0YGawqXvAH4PtXOJbcyKx6Qikj5+yL21LCTxyj7MvkXzopfRyorTXHwSrnR0j
         YhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714052406; x=1714657206;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=apJH0Kcfr1yw96r7lDBX22wpYYdECb8ZVgsjTYPjMtE=;
        b=p0BIxkw/B/uLVXPomZKKLzixJedUpRKFbr7D1soaX4tAEalzmFIG5SJaKSde93twKT
         1zlNLFTBSFABgB5xeWUmRvhXwmeR6GDtrB9mC+eHbhnmYpfByKvFG8iDHGCM5Qkbb9ZC
         CR5UflND+kdaYkOPO9EJ5ZsXwcsuegMdP3LNggiBcEF3VfM+3YgSqQ9FXcYxMbY3MG6+
         h5qrB6Akqux3xsW+zGAkI/zCbYTBvXrDGCFdkoEbqOSnvfoMAmuhSUfzlo0tItcLM20g
         ShD48K/F71UJQHpq4KtBsaOa9WpQxON8uaSSy6GSmJVDFe6l6lyV12HC7Irytu4eeU+4
         kqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAewrTRGya5OMBHvprA2JJgwo/ZM2W9iBozhsPXuU6RvCUe1l+cfy8GjkkrYBg5Wu/+TIeDIvYPI+nISV8rXvWtMilFdVz
X-Gm-Message-State: AOJu0YyGpJElrwm+HOEx0JIFJEmFaxUGP5WrrZ2R6YyqI2pNDhgAB71O
	0iAOfw7DrGiVw+hX1sAt9zcd6GKaUPLqaVnm8n+XZYT2Ybe+HnMt
X-Google-Smtp-Source: AGHT+IGRcaLXdl5/UMvu12CvDVAMUF0LIKnuvw0XKhiV2au7XuVn0GTREN1t91qHocQDf+SWaEHt1A==
X-Received: by 2002:a17:902:ba88:b0:1e0:99b2:8a91 with SMTP id k8-20020a170902ba8800b001e099b28a91mr5715324pls.4.1714052405802;
        Thu, 25 Apr 2024 06:40:05 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b001e0fcf995easm13738248plg.202.2024.04.25.06.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:40:05 -0700 (PDT)
Date: Thu, 25 Apr 2024 22:40:02 +0900 (JST)
Message-Id: <20240425.224002.290103132276818797.fujita.tomonori@gmail.com>
To: jiri@resnulli.us
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org
Subject: Re: [PATCH net-next v2 0/6] add ethernet driver for Tehuti
 Networks TN40xx chips
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Zio_YgfX9SO9DHc4@nanopsycho>
References: <20240425010354.32605-1-fujita.tomonori@gmail.com>
	<Zio_YgfX9SO9DHc4@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 25 Apr 2024 13:32:50 +0200
Jiri Pirko <jiri@resnulli.us> wrote:

>>FUJITA Tomonori (6):
>>  net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
>>  net: tn40xx: add register defines
>>  net: tn40xx: add basic Tx handling
>>  net: tn40xx: add basic Rx handling
>>  net: tn40xx: add mdio bus support
>>  net: tn40xx: add PHYLIB support
> 
> In all patches, could you please maintain prefixes tn40_/TN40_ for all
> function, struct and define names?

Got it. I'll do in v3.

thanks,

