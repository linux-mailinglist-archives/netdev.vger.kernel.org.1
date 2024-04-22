Return-Path: <netdev+bounces-90227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F858AD308
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 633FAB20F5C
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5D9152197;
	Mon, 22 Apr 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gVycBT1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF12153807
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805474; cv=none; b=IugXpGsJHQP+RXq0+TTZ42uuh5baq3drqevCcnq4LdeIVKoQhmT9AtVjzQbp+YbY3mdONmN0YneI/ZRg5cXYj/IApAJsIADYCPTs3os70STAZ+ypjw9/FhjjvCk26sNRf/7y9r6cwZnO8jczkxIQvzMpvEccajLTNckwfI011f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805474; c=relaxed/simple;
	bh=YnUOOWyOYOrDbvzsMkFOkrnrXjDd85XHI3eN4+0NVEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUuNq1kTF2fUGveVH/qY+//M016tL7vK7aowuHHpEuJ8Ql8wxqan9fHOUVUBqrXMLVe43AicqFimG/ervuvh6S1P2RPKsYZpVOL7RPvDJLeU08eT9vznMKubl4tdRBau4HqCxX0sQ3Aq+BHNighIpiANQuZUfw6pXZIzo28LlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gVycBT1Y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso3375665f8f.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1713805470; x=1714410270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoxNIjenWTL7GZeILQ1voC0rSl+XvfL/Q6CiSWSAIsQ=;
        b=gVycBT1YuGa2TW5bQ8SeGYnS/IEdNS0TztRvOimv0gaZMVptSCfa9si7VfOFHi/gnU
         uaCqENfljcVoRtH1Qgx1a+V4wCrQxDjn4cUSPz+4vKGReT0r2x1GnOINF1cTh5p25qAf
         vlu5ZB8ORe8jUvoqQa7s0OuYBGKqZIVn7M4xSb/OdQ6bbD27wbkvH9AAjW/Aj8x2Hytf
         FKwzCe9St+iEDw3YhBIzO+PWnZl1vEMjjfgM1TaDl7XaFpMKoKB8Ao4OEWMHrQQBgIb1
         bWeK/PM06Oj5MTDWp64KCMFCDDHWpTXc0na7SiGD/umf8Zp0L4/ZgliJE3YsFX5lrMe1
         JzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805470; x=1714410270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoxNIjenWTL7GZeILQ1voC0rSl+XvfL/Q6CiSWSAIsQ=;
        b=uvP7gpbxOYwtXicM3URE+PqaJ95J1KYZUTFLPdlRz4xJJQzXIMKW4iI7jwjV6IFSxR
         yqqCKa30bZbK4D8aUns+ZM9QRJU+9PtKb9TSw85WS2YEAAQJmIJ20BKoXgGhHy1lAHaw
         q4Jx/PuwPqnTdrYn2w9D+yetFHNwFLIWLLkBugidI+Weo7rgZAkwF+63Av+880JGw9Gc
         s/CxGLlP9sdSdB4SeosJTPf+b7to8lHOOwH7cYPkWBRmTqf8n2EJsfuvhAv3jpdIj7VL
         Jav53SL6RSh/sI4W13XqBmdwV2ygVaFqLsgQMGfrqIt6itvTK+diYFrsUS2Ww+NHCBo/
         qa0g==
X-Forwarded-Encrypted: i=1; AJvYcCUzZ8RgfyZla8tBOyIsxNtXPbRS7s0Rvnd2xTRnqygKJqUISNVBQlaOQ72Xs4AahApN6ADBCPjOL4QE5vYVyKhnQ4ZkhLOl
X-Gm-Message-State: AOJu0YwZ8B/Wnrmm9r1KDmDrK6mIHXmvDqPZy6z/+nVHsdlmVIOQZ2mc
	9zZg61uTtsL7v1XgKUQT3QsUTAMQbeJDPr8hQxSaWIAA+yf50+ac6h75CFw8XxYlwM6IyKWd5js
	5BCD/Bja+
X-Google-Smtp-Source: AGHT+IGtYDxSM9KSTSgK8ePsw3CigB0LAVMSNyuNJ18ffqpYv9SMgHcpNPS5DH+5fzupQzH6TviDDg==
X-Received: by 2002:adf:e4c6:0:b0:34b:e79:2677 with SMTP id v6-20020adfe4c6000000b0034b0e792677mr2385591wrm.63.1713805470389;
        Mon, 22 Apr 2024 10:04:30 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:3804:ed2::17a:8])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d60c8000000b0034aa0fc51f3sm7168260wrt.80.2024.04.22.10.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 10:04:30 -0700 (PDT)
From: Oxana Kharitonova <oxana@cloudflare.com>
To: dtatulea@nvidia.com
Cc: Anatoli.Chechelnickiy@m.interpipe.biz,
	davem@davemloft.net,
	edumazet@google.com,
	kernel-team@cloudflare.com,
	kuba@kernel.org,
	leon@kernel.org,
	netdev@vger.kernel.org,
	oxana@cloudflare.com,
	pabeni@redhat.com,
	rrameshbabu@nvidia.com,
	saeedm@nvidia.com
Subject: Re: mlx5 driver fails to detect NIC in 6.6.28
Date: Mon, 22 Apr 2024 18:02:46 +0100
Message-ID: <20240422170428.32576-1-oxana@cloudflare.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <5226cedc180a1126ac5cdb48ee9aa9ef8b594452.camel@nvidia.com>
References: <5226cedc180a1126ac5cdb48ee9aa9ef8b594452.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Apr 19, 2024 at 5:28 PM Oxana Kharitonova <oxana@cloudflare.com> wrote:
> 
> On Fri, 2024-04-19 at 14:06 +0000, Dragos Tatulea wrote:
> > Was tipped by Shay that the missing commit from stable is 0553e753ea9e
> > "net/mlx5: E-switch, store eswitch pointer before registering devlink_param".
> > Tested on my side and it works.
> >
> > Oxana, would it be a tall ask to get this patch tested on your end as well
> > before we ask for inclusion in 6.6.x stable?
> >
> 
> Thanks for bisecting and finding the fix!
> 
> I'll give it a try. I'll get back to you, but probably already on Monday, end of 
> the day today.  
> 

Hi Dragos,

Just checked the patch - everything works.
Thanks again for chaming in and helping here!  

