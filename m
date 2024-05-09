Return-Path: <netdev+bounces-94874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9348C0EB9
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49B0BB210DB
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCF7130E34;
	Thu,  9 May 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tFCQeua/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924BA130A72
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715253243; cv=none; b=nOhhaFUOV5TivqBMmbTnq8NWsjFUqvzcXnhDDfVqKWz4TEyVwxPx8ASoPajQwxwqanrvEFFkaSu7il2RuoTWLAAcxSwZO2o3RZYMiIGLb8NhMwJh5E2aoTocztcdO13obh4MiCZ670jKO3ahwIpF/BAdk9lY2OVIGxwVMU2Rn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715253243; c=relaxed/simple;
	bh=XBhNbVzR5327olKp38oRP+7QC1vGtVlA1636WRhZ8m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT6MIHIvDK0VWIssD/NJ3Qd5rYjg5iowSqZBlTs/QxiDZMw/kv7XQGjzyTNvC2cjUMPr958nJduyoNorqN+SVgxjRyhLgS0/St45q/9Te/d5JJNOnhl4Fc+n3EYyJr1X/Z5OT9jB1JfTE2xdabma08YBKJIRHifDHMAdQMKSQRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tFCQeua/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b7a26326eso5486075e9.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715253240; x=1715858040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBhNbVzR5327olKp38oRP+7QC1vGtVlA1636WRhZ8m8=;
        b=tFCQeua/kXwUZgxqeO6tR8Yiql1yrwPuTdNF3D5M0nnMENtdcnC7ahlf/TKxL8HPVd
         FEYEKpr5mggPGUAoyudPwkkvj4zhmb5gyib1ZE5BE+z6UD7t+skVCXAjAj24MiqaLnhg
         T03NdbN7OM+InQ5aQFRjlUO39BifP9iWT2zsJruVTxezFRcNxCUcblhFWzRXh6LVHIi5
         vv7h3iBmiBzMy1LMrtuqNrezisThpbOxJncKYAJUtWC/oOCNn9SLM3mfjN6+h6T7hFIV
         oLmm4f+LGdutA2tP6c5czJC1x/df1yOxSVZmTDaLWQDePn1LApEMvBL+/x4EbIsnb3Jr
         pZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715253240; x=1715858040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBhNbVzR5327olKp38oRP+7QC1vGtVlA1636WRhZ8m8=;
        b=VdkEGBPSON/SS0z8qu06etjJwnWlkZuXXXi9G7jCCGuEPdGBGKUig9argMuFLmgrOx
         ytsEMoqwYqHWOTwHbRzP3wAOvvW2cNbM3ADTM8dfgZ2XBtY+PYZiWrg44xxDSA6toAPi
         jRe2pbYbCOs8UiHo/Jaf+rvJ8aJFVFzm+OLItfj1kDrPRZZ+zL/4tszXBFclz69kU5m7
         iEHJGGBxM0y3jp1U5gzKpDkDtDA2YJl4QZGrBVzcwdgh2C4HankKJ/nFkPFQ7Muwunuk
         +zKrsK8GpZoXM+3AC+KsFE88qQQUOOA44AMw3+ymPCip/jzqdNuU9m65zLd5p6zyQtmT
         cwJg==
X-Forwarded-Encrypted: i=1; AJvYcCWHeTBmW/y9kMS/JNQlx5nEdWkNrF4VbO4JnzxtpC7W8Ye5N02lhPme84raiLGeYNy2ISYbHM5hcdZbuh7KDckqXdC5bqAU
X-Gm-Message-State: AOJu0YzsqB2Bq5O2s2rUDqU6g6GmUOEP/w4X9J+tH8emvv87yDlBtWuC
	r78m5dHwbx00uj3lMBLeuxP48fE9+5g6DFYO8oqX4OF75zPqVcg2u0SM3u38PoI=
X-Google-Smtp-Source: AGHT+IFpw4SnGTrtArDbcU2PAGbCg1ZgJFJuQgGVS0IRiH+ldNpoUZMEhV0eTxF2os1Cwsyke+rq6Q==
X-Received: by 2002:a05:600c:4688:b0:419:f630:57c2 with SMTP id 5b1f17b1804b1-41f72593be5mr47718265e9.37.1715253239723;
        Thu, 09 May 2024 04:13:59 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa90e93absm41784305e9.9.2024.05.09.04.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:13:59 -0700 (PDT)
Date: Thu, 9 May 2024 13:13:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 06/14] ice: base subfunction aux driver
Message-ID: <Zjyv8xAEDhtzXAIx@nanopsycho.orion>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-7-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507114516.9765-7-michal.swiatkowski@linux.intel.com>

Tue, May 07, 2024 at 01:45:07PM CEST, michal.swiatkowski@linux.intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Implement subfunction driver. It is probe when subfunction port is
>activated.
>
>VSI is already created. During the probe VSI is being configured.
>MAC unicast and broadcast filter is added to allow traffic to pass.
>
>Store subfunction pointer in VSI struct. The same is done for VF
>pointer. Make union of subfunction and VF pointer as only one of them
>can be set with one VSI.
>
>Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Perhaps it would make things clearer for reviewer to have all patches
related to sf auxdev/devlink/netdev at the end of the patchset, after
activation patch. Not sure why you want to mix it here.

