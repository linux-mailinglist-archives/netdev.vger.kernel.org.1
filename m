Return-Path: <netdev+bounces-106857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2925917E17
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A941C20429
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B8D1891C0;
	Wed, 26 Jun 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIraafr3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C7A1891A8
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397702; cv=none; b=D8eXgTsvbzDMDeWIbtxyU0yepne9yHKP8zqnWFdyBlDYX8ZhHDbqk7gvliMdgmDc64SFc3luiw7+pMLbsodS1fAlnFXAOjvUNOBXB+bGrL0uNE4x4O4WEssl1+kY/2ZDsM4En7kJ6kN1uhgFAzvCR32I+zC/E6U28ZRrWR4/sMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397702; c=relaxed/simple;
	bh=z6pXLYDspE7r+DXc71UxG1d+elvJ/kPF7lODVxxnrXo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ng8uLZindo32CC3dmOrnCcYC9M0OCFnpkvVu3ifeopqDjN8any2kgY6vwFKiYEO3HxeSP9p8UDP/BNw5w5E/QmPIWQZfNb7F4KAzJyuCtbMBmUD27sxUwBu/QqOBJCUWzqS4EsaX6dGrcJESPWdNNM2Dd1YZH0tD/og+x5PaKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIraafr3; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b4fec3a1a7so26975396d6.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719397699; x=1720002499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QUK6RAY4lgtTAp5j7IcY5llm3EYxXZImQ/QQ85w4KA=;
        b=fIraafr3AAzH7f6B1PK1NqT7XslhIIZoPstNOMggPolNre1B7Xs6dUyUxERswSt+Fw
         dkm/ZH7HJW3S2KZqCt9ZBO+zEEhwTfl/NnUIrnn7kKSgLNegUluk0PLO+36WmTT79Qbp
         jMwVBGAF2iCpMgVHFuj184SuOH4MQQeL4DuZKVc8H5JaRRoj6dwZ6t/MYe8dnAZ3F2NM
         ASuEc0dqxqpKllimS+mUTYdi+2pL5a6kVFu2qLbjCHBz+PQuTZq1es0ZOjzK7dPnKmCF
         sUaHBjV11Vf8xnkoAi6Ag1fkhVzuMVpvQaNKP3HyGIFKO9Z3aro/9AuF0OEEPKqxFdOj
         ujDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719397699; x=1720002499;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2QUK6RAY4lgtTAp5j7IcY5llm3EYxXZImQ/QQ85w4KA=;
        b=IjWX+WRI9GA1Sxim+HtRC39Amwk7BFIjLGZT55r/nbdw0J86lGb6yVe4Vg0efuELPs
         4y+hnFP/7SXRyO2KVnRobvb6/eIEtjMipMjTD1YTCxe9wYMAyUH4YpLgAoqKz0OuTWMB
         +a/DsfoewkIbpu88oyG0Pd2SAI2IVHVS/H3DZgVSP0PVtXkNMe64njnE4ACF9SIVtSkO
         TK2Q+TjrZ1RDriQHzuCZDnGWsLG8pveK9iph+aC7Fc/IczfIyDS9gEsYiX9EZvKmCAxL
         IzjxWy6qzrjObyaQT2YwSq94WPJ1FBAHH9x2Rg0Gon7WeODfPZXt26ZnummUsqMy1K5c
         Nedg==
X-Gm-Message-State: AOJu0YxAqdBksofSOgycHaBjZ5OlgtHDWXLkcF7KzcQUR5CD75G+8Xq7
	r/H6oWRCLirRHNIe18hrUDrd7BOeRYi2VeYl3d3lYIfDuzm6YsTT
X-Google-Smtp-Source: AGHT+IGGVvGzkMMKLBK4RwE/Tp32MnUsYjWmBQizjIuHbcqi/NxOxuNSwHiM4xOMFmbB1woPFsO97Q==
X-Received: by 2002:a0c:f103:0:b0:6b5:7e0b:eafc with SMTP id 6a1803df08f44-6b57e0bed35mr10967636d6.38.1719397699351;
        Wed, 26 Jun 2024 03:28:19 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfe5adsm53817396d6.10.2024.06.26.03.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:28:18 -0700 (PDT)
Date: Wed, 26 Jun 2024 06:28:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 dw@davidwei.uk, 
 przemyslaw.kitszel@intel.com, 
 michael.chan@broadcom.com, 
 andrew.gospodarek@broadcom.com, 
 leitao@debian.org, 
 petrm@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <667bed42a55bc_3cd03a2943f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240626012456.2326192-2-kuba@kernel.org>
References: <20240626012456.2326192-1-kuba@kernel.org>
 <20240626012456.2326192-2-kuba@kernel.org>
Subject: Re: [PATCH net-next v3 1/4] selftests: drv-net: try to check if port
 is in use
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
> We use random ports for communication. As Willem predicted
> this leads to occasional failures. Try to check if port is
> already in use by opening a socket and binding to that port.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

