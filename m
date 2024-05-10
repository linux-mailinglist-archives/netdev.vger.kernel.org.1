Return-Path: <netdev+bounces-95403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5DC8C22C6
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC95A1C20D29
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E24516D320;
	Fri, 10 May 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MgIxWLtS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597D16ABC3
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339195; cv=none; b=VJpqkuzZvKkySkBx58jDSlP9XrWtivXu/EeVgq4dJDdWtysGZgfpX3zMV9FNdj8iDJJ51FTmoFSiuCDEq+PoVKSkwEWKuGjG+esb9xpOqXPSX8+VT9PlMhOlAm1kbF7+sWqoU5kR5Rptd/qykt1zI/yoUeFsn/LRnRmmv8tQ8JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339195; c=relaxed/simple;
	bh=/Itff6mbcEDfc5kdzcL5eMOjrucEuOoK53QWSWmqLMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBpOAn5+qvLnKXwTf4gXgYkcIqjuN2KrHd84iUgr8hD6LJNN/8OWKd4zxklGCjGdjeJG0nnD8hY6UAC/CzzGnHMu77ZbeYu8thcCtUvAHmSJD8y4TWNxrpfJ3+el8G059FXxXR4bE2A4oBvqnTv7GeA+YiEZFBVSbp5PEFDSzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MgIxWLtS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34d8f6cfe5bso1421837f8f.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 04:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715339191; x=1715943991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNv3h2hPAcC4VeJUM9WPf+YFoITQA3YIHDEMNhnkbuU=;
        b=MgIxWLtSJ9+/5+t2jElhLESrxGXfdT3u0MQL6x7CWTu90fE+brJ4ZIK6nBOHLvlw06
         0JDxlvo+keVVSeyyyZGjuFt8oKGezU+0NvDCSlsWnw5LYD87pfGrWLioNBZ4Kgu+jVbT
         oFhv+JnMwawInET+ncLx/fA5XgzxdZ1LMA0QnsZwo6YVx1tWVrUL4HZfNJ+Vi4OmTl8O
         P01ObIEPw5fcLj8YZ4GPSQDCDl7w6yteGxcZw/gd4OgEeqRGzAVxWtEoBrG0p3xZDOUZ
         VoZJyIVekel1YpjciwBrxPaEYmcrUEizXlZrywVNef6m6Ni7Pf7JZfxII2PRh4nGMSX5
         yO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339191; x=1715943991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNv3h2hPAcC4VeJUM9WPf+YFoITQA3YIHDEMNhnkbuU=;
        b=PYlLUiCEUFkfC6JneCPcvtGaRO6+chbpVRq4FLXMGn2M2mxbbLxs1uBoKYMQ1zozbm
         +Jn+FJgUx4kM1WLUNFGG1cYOSFG4BQtLDuptbpy73R5pY6crS+kEYq8ExCw0tiMxeMRR
         22uDmbAGXvs6NeUG5rMZIG7PHTJDzVi28pHaOp2mzfZlJQYsaKZeHxHRIiETJZUZFmL3
         wc0zA1hYNRo1GwzCCSlwoStD8JhUhjT0WbBEOrQL/BGb5GT9EcifwNBLVaKOXEkrJ93s
         Ylr25BCkqBqHU0rsqpBSIpYwwiWe3rCwVNk5h+1JvpF86vLpiQsUlavVDTxmx0/L/64r
         HC+g==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/cVPn9yMm8VM5VY0llnAfaTI05W9GV6zjfzUhCZSV1oUz52Tgig3yvhgUKtbwdLoFqvkG4GjgKCca2R1W6EayjquEwdt
X-Gm-Message-State: AOJu0YxhOXifARmJq+QYb6I8Ip2R0NVzYTLwMjpgxlkH3zJ5m9kauC8V
	IEmqVdM3FvVc7Z7ZsEZpP7rqTKhvtIlYNmPrY5Iop968pg53M7dOuDvSRGLCRHk=
X-Google-Smtp-Source: AGHT+IErsx9K72qykBumWEujWyAufY8IZ1byl3WQ4ZzxercswAzMR2gbGDdw18CLAFN+3oRp5/TKqw==
X-Received: by 2002:a5d:5cc5:0:b0:34d:96ca:8c24 with SMTP id ffacd0b85a97d-3504a73c028mr1372977f8f.37.1715339191092;
        Fri, 10 May 2024 04:06:31 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bd4fsm4331410f8f.7.2024.05.10.04.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:06:30 -0700 (PDT)
Date: Fri, 10 May 2024 13:06:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 06/14] ice: base subfunction aux driver
Message-ID: <Zj3_sxDq5R0ZsYBa@nanopsycho.orion>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-7-michal.swiatkowski@linux.intel.com>
 <Zjyv8xAEDhtzXAIx@nanopsycho.orion>
 <Zj3K0+JB55UFZYXF@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj3K0+JB55UFZYXF@mev-dev>

Fri, May 10, 2024 at 09:20:51AM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Thu, May 09, 2024 at 01:13:55PM +0200, Jiri Pirko wrote:
>> Tue, May 07, 2024 at 01:45:07PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> >
>> >Implement subfunction driver. It is probe when subfunction port is
>> >activated.
>> >
>> >VSI is already created. During the probe VSI is being configured.
>> >MAC unicast and broadcast filter is added to allow traffic to pass.
>> >
>> >Store subfunction pointer in VSI struct. The same is done for VF
>> >pointer. Make union of subfunction and VF pointer as only one of them
>> >can be set with one VSI.
>> >
>> >Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> >Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> 
>> Perhaps it would make things clearer for reviewer to have all patches
>> related to sf auxdev/devlink/netdev at the end of the patchset, after
>> activation patch. Not sure why you want to mix it here.
>
>I need this code to use it in port representor implementation. You
>suggested in previous review to move activation at the end [1].

Yeah, I just thought that sfdev patches could be separate. Nevermind
then.

>
>[1] https://lore.kernel.org/netdev/Zhje0mQgQTMXwICb@nanopsycho/

