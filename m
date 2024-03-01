Return-Path: <netdev+bounces-76519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5586E06A
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 12:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF661F22733
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E566CDAD;
	Fri,  1 Mar 2024 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="r3T5v+pD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397E6CDA1
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292881; cv=none; b=V+83ckYb4TYVs2JTvN/VBpMqHM9mzPdjy7/Zjlga6a8cdPyW63C2/D8naBFSlTaYen3O2zdSBRMSYuYQ17PRgsvmSyhbQWFmo1ERWyEKDXtlw+bZW7P8/o4Ak4TZv6otckxioVAixxLjdovYuRstHOMB+1774wrDiLYRiq5gVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292881; c=relaxed/simple;
	bh=dczqIuC1lr5J5XVWyyVLCZr+6ArPWk0wXrl2GBAp3tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1oDl3+xOtkrMUkW4hQwmBRZunhyOE+9ndedFcmModSiOnp/fj/yOLx57JAfcUu7/gNtDulLRJJuNqfvRvCicdcGQHS3OQuSkFujdb3rzjpEPJBq4iAFkp2jICpAIoK3VhiF0TstQv5otHmi3uzaLEc5WddmpcxSQx1KsG99mu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=r3T5v+pD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so296103666b.3
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 03:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709292877; x=1709897677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tOw7LNKd+3LBu/B0HUissiMYh1fiL0Lh/tlvPvRNaQ=;
        b=r3T5v+pD7GHcO9rbSZ3akZYmvyUBLs5oOlXi4QAdJ3lEskAkZs1BmIOJcayHK9/gr8
         0O3+QvoRRsHn1TRnxoJ2cXI6oxKS6EggQ45hwqxnsbxsCMhphsssh8rUj6K7WtAH/xLo
         wgk3iBY2KwcGVzdPF9xkbVGDUXz06GPLPcydfbytihXF5HZ8TlfGWrLTKubM4Uj6bhb9
         lt/sLe4q4tADGhn4mW/T7B0aGWdhRaC7O4vlNFRFfq3GlNRZNU8LTofV+qgxsXlToTRq
         hcgaFX4bGDF4XDvcGEerSqvJoPZgW0iTx1l2QF0jlIh9oV7rKC8NwMYsS3Aqxl+IwtZH
         4dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292877; x=1709897677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tOw7LNKd+3LBu/B0HUissiMYh1fiL0Lh/tlvPvRNaQ=;
        b=LduNFnjcBtzawW6TzgFaw3GAYOP+bj717xB/HEBCnRV/yWpVUY4v+DjD9x1Vh8zgBa
         xr+ewynpIaMV+bJJh4d0rPGpewgIGcr26A6J0qC7hMYs06J/QeeITVC3SHDs/rrlPCUr
         plfM1a2kwLbgoJ6x+JAt4XwaRHezLAeAgwHP5paXwtdSPxLTeBq760WciM8RDJkKr131
         S3anupEvnHGjq8eWmbdWLMOo4oH9bP5VvOzuO2tsBYZPS6kNUt9lOjY0X6+RIY0nNSfE
         RduY3b7vRxoFxkIcFCGVfqnktCCCHwVNQKjUav2sg7jdkz06ZP9wQOleZQY3rNUZKMK/
         Khhw==
X-Forwarded-Encrypted: i=1; AJvYcCWARz+eaynyf9DHOZG7HLAuNW5yaBPaSYoee20MbjHunnEn/g0m01fcgJTExjtGJlS+zGYaE1FzhFVd/T2PV8I9sa1kKzeg
X-Gm-Message-State: AOJu0YzA9pXo6W3lSQTXjcnYGN0iH2JsfOgU0q3jhS4K00SQMwxcG+vP
	ebJdHPZiVCg3b4K+IrsurgdG35I37lwVzOGGAYWKIf7aoQ2y33QhwxTvX76BLV2IBNnbiYkUAtX
	fZ00=
X-Google-Smtp-Source: AGHT+IEdbiSV13fbTeAD7VcGtPG9OBE56NR/8f+vlqN5p5a6RUIh1Uq0WqNkU9KTBVdmK/i/+ZmsUg==
X-Received: by 2002:a17:906:b214:b0:a3f:9629:d305 with SMTP id p20-20020a170906b21400b00a3f9629d305mr1114645ejz.28.1709292876495;
        Fri, 01 Mar 2024 03:34:36 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v15-20020a1709063bcf00b00a43e75ad75fsm1611267ejf.219.2024.03.01.03.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:34:35 -0800 (PST)
Date: Fri, 1 Mar 2024 12:34:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	richardcochran@gmail.com
Subject: Re: [PATCH net-next 1/2] bnxt_en: Introduce devlink runtime driver
 param to set ptp tx timeout
Message-ID: <ZeG9SH_RlZZzNi5Z@nanopsycho>
References: <20240229070202.107488-1-michael.chan@broadcom.com>
 <20240229070202.107488-2-michael.chan@broadcom.com>
 <ZeC61UannrX8sWDk@nanopsycho>
 <20240229093054.0bd96a27@kernel.org>
 <f1d31561-f5b5-486f-98e4-75ccc2723131@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d31561-f5b5-486f-98e4-75ccc2723131@linux.dev>

Thu, Feb 29, 2024 at 10:22:19PM CET, vadim.fedorenko@linux.dev wrote:
>On 29/02/2024 17:30, Jakub Kicinski wrote:
>> On Thu, 29 Feb 2024 18:11:49 +0100 Jiri Pirko wrote:
>> > Idk. This does not look sane to me at all. Will we have custom knobs to
>> > change timeout for arbitrary FW commands as this as a common thing?
>> > Driver is the one to take care of timeouts of FW gracefully, he should
>> > know the FW, not the user. Therefore exposing user knobs like this
>> > sounds pure wrong to me.
>> > 
>> > nack for adding this to devlink.
>> 
>> +1
>> 
>> BTW why is the documentation in a different patch that the param :(
>> 
>> > If this is some maybe-to-be-common ptp thing, can that be done as part
>> > of ptp api perhaps?
>
>Jiri, do you mean extend current ioctl used to enable/disable HW
>timestamps?

Maybe.

