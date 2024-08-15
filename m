Return-Path: <netdev+bounces-118712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB13952878
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE72B21936
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 04:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D272A8E5;
	Thu, 15 Aug 2024 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDl1YIi2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CFD28DD1
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 04:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723695430; cv=none; b=Iwt+ZNlarKzd7p0Z99W0wTqp3jjjp7hsOQDQRBEsXcX4Sf8EiMjgRAzPedFfdAUioO4f4X/QhSbncYLByQJMMPq6hDv92IbH2vpnebUklWBiFeVBRVbdTxxk/Duzwp3l4g5o2yXuakA2ioIGSOu6xvcC3e3cekQk/W5XxwpKJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723695430; c=relaxed/simple;
	bh=EtD6i8y9cGJOrj/8z8iIeU/EWbE/sRbeA2yDaAa6Xqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIEnGReYDeK5/fcYPjS4RZBmxsmQ9XClwBTbF9DpCgzteoImbLBPnZA56eNvs33SFc1fWnl9u2HNkLAsayflRQSGxG/j9mnJ73cBPvrVnMzwphJUkj+UPL/XYeT/u/a6Jfyy2t02URXc79orQGUYn7jltRG9GfETB15p8WRIh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDl1YIi2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ff496707beso335745ad.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 21:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723695428; x=1724300228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtD6i8y9cGJOrj/8z8iIeU/EWbE/sRbeA2yDaAa6Xqw=;
        b=ZDl1YIi2zk9g+DLBhAuRN1o+nms1JQyorTNhuCoYc5XS5A6SQhzjSrQnCONaLGb7IP
         ZJRuOWq5ebFsDoD0RhcmeAUw7YPqKjQVFWujEQPUH0rQkBg7DhrL5KM+U0id23mJx6Fu
         Ds4AFOnGLN2kZqRdasKsUPz70gbO3Q+EsmgMxg4uYDZPrwWnTxIbYiDer5YxHwb+cH29
         leZMnxxvYJFRQCi3ahRNOA2a29Zj+OZepU09F7ilusXQ97Kyr+MBkkKhZ96NxRGIxBhp
         vhDM/Xo6T2Qv7w5rAGzByjeKYARrvSnKn2ryfXn52WqHK1hOB6HK9CNu6NIWFV4H04yd
         3OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723695428; x=1724300228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtD6i8y9cGJOrj/8z8iIeU/EWbE/sRbeA2yDaAa6Xqw=;
        b=dRTi4p+stBXjwWNC8tCixSiiWQMP1VR7It9Dl1XOctIWX6ouv3hsqRM8/FnDHL9FGE
         LqZQmjVIlMq5GwoJf5J86hKRjGJDtxu/04VvNNhtqXxNgq5pWQlxY46BNsLKKqZusx1p
         2OLfDyhEqxobsqCls2n9vSJoiQGP7JLJrpnLSEwcNQ7xv6ppem+NDO1foQRz6Pm2BDkJ
         n3djnhoZ3CN8WEb+S5J7xAGv7QLReoIjlx+uiF1eQSeTX/x/eEBblw0ft1b3i2Z21hXJ
         diIjJEsfB0o7iu4QqMrmQgP2meuWUA0/6el/RCpfyxAUAU5MtV8d792KjV8JJ6vSAd1d
         eoog==
X-Forwarded-Encrypted: i=1; AJvYcCWZSq3yw5LkK7d+H5Fmkd+vhY43fBNu2B1bQ+Jkf1k0WRWGYbWeCzIzm3aEH0WQ+EATUfkVfGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jo7fBpniCfq2FxH2txIKUMbqJie7EqxBFlinwVUGTwTKsJ5V
	2URbW+z4KQ0gfh0ycUUwbxHcb7TkJpgHnnZxT9Eh/nMatRgzUyeA
X-Google-Smtp-Source: AGHT+IHdhJ0+AiFLACYSTcoYzZHkJynDDbHnMzl28AMo2SdVKoRh6ghClZgyspEdiX0URJqN3s802A==
X-Received: by 2002:a17:903:41ce:b0:1fd:d4c4:3627 with SMTP id d9443c01a7336-201ef921feamr9739145ad.6.1723695428497;
        Wed, 14 Aug 2024 21:17:08 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03a43b9sm3661325ad.262.2024.08.14.21.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 21:17:08 -0700 (PDT)
Date: Wed, 14 Aug 2024 21:17:06 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maciek Machnikowski <maciek@machnikowski.net>, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, vadfed@meta.com, darinzon@amazon.com
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <Zr2BQm04NeJT2Ypj@hoboy.vegasvil.org>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240814174147.761e1ea7@kernel.org>
 <Zr15QcwE9rboS9Zf@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr15QcwE9rboS9Zf@hoboy.vegasvil.org>

On Wed, Aug 14, 2024 at 08:42:57PM -0700, Richard Cochran wrote:
> and CC John Stultz please

and Miroslav.

Thanks,
Richard

