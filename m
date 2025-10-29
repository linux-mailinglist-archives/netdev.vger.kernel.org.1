Return-Path: <netdev+bounces-234009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5743DC1B4F5
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 997DB5018E1
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2782263F44;
	Wed, 29 Oct 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e4qAsRXa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC28325A2A2
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747649; cv=none; b=Ij8yjGYSzoFWNrAoHQFUhik3E3av/WQTMIh7veT7dsD4TNvNsPl/pTp+DtKPhPKwiphPTKZ37NowLv3+dbmtWL1jWoaInJFO7bkB+LarCSv2ujncmqcp5B055Mo2vK35ng1YokbFzL6A21aovaHc8PtLO0RSPxQCCDe1UW2lLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747649; c=relaxed/simple;
	bh=am0/YbY3X+EDDZcjCgeLwrDMLb2LpBxcjmr3MpjYeF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie5tA0DIXgyHJ8T+ZCglMYg1MtYqu8ZEEnVSoMSSUjsCZGjC0er9UUGVKneKeVz2tkVz9CP5WlKmK+V1Y/LRZcZgPYqKmU6skakJ7/PpGK2dITNlAIB7tX006vG1E3e3Cgg+vDv5FyblcPYJ8FdO6OcW8iSFFp3PHWeAZwSA32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e4qAsRXa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-427091cd4fdso4263254f8f.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 07:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1761747645; x=1762352445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxBr6UEJhfUdxptPH87yDMGfOKWl61gBXcrB5pzrHm8=;
        b=e4qAsRXaZCN0Ac957vNDchZDWjuVxpaJLnRYPl+nNoiy10L0woLP3nsMf2HqatRMTf
         4yxKeUg/oDlk++HNyvAw3tDqui8UMe7vm/yLSUA5RPhm3XIs+TJ8WJ9LhrN6NSoGVA4B
         uBYyiaNFqnCYFmgIzqu0+kW+gS0HXQvrO+Oj5hLJb5n+8GPeyuzFsQkcAfWYd2N9zioF
         Bn5Cf38/ITDlzCB+teSgsbPIEu4lAhRjkHzcCqa+bWPFfVRvvomfoL2Ztj6bc+uFkzmG
         Ttt//U3awXwdxpFkE6JliMARy8fAnEf3AW7BywgR+D7FNYhTotOaUu6eKcv0RE1BCL+2
         3VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747645; x=1762352445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxBr6UEJhfUdxptPH87yDMGfOKWl61gBXcrB5pzrHm8=;
        b=c2AKK/Y+xZGzEjFnSI6t4CH1+xzOXu98TCEA18TxaR7neAa3knhEmEOJjHvXE5BWUD
         O1N/Hvp+MagTwBNRAC9vYeIusDHTnVHQ2jVVKgoDITcgKZgbomPk80nTSFWSXz4rb/s3
         W9181TCXMiCpEB7AGuDLwOeAF93EB7bXHPcBM2mM8LrJeeBo73WDecwnKWiwAFQBvqFj
         62tekcQC0DVZgK7tULapcivMPeIf/Q9b7DsdX/1f3IM1WFe6tp7aVmLwBGWW7xNDY1UD
         juPDQzDpMeVocp4Hy8YKpkjWsFQa4RFjxLo2R/7rbHWrMR+cRS3fkLSJwaUkcbrsuVNB
         PLSw==
X-Forwarded-Encrypted: i=1; AJvYcCX/Y3CB3nQhfkjH4WmpT1iBUw3xh/avJl51K80XKGMadxYOoUCkSh6yTQ2A1bTiUuUN1P+JBWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOePowQc8dik4iPKkmcsHvIPTa0iqb/bQaqKsrU88wFmulFNUq
	HW743QqLVRoFWCLzZ2JrYqmMyS+0x6eXp0FqyCJ5wRvMVkps0I2YaexrpvaaOFhpZSU=
X-Gm-Gg: ASbGnctHRGg2lkWq+W6LDadcPoZK7P2aD4fh8J+WWWfOJ2o6EGh0iUS0/SHPFeJsp2d
	G5vsqYJAswHkSqdio7SAc5BIlzYH4Lt/TXa2XgZCbvBaJuE8RZ1DrFlvVmyZvILdSFudJrVZ/7X
	0Ct6ZCtGfbMsTXBWuWBQm0AQ2fJnjTTml+K5vRu3RwVZWWFmy/ZDOiu90fla6oJVn5lvNqKIVc6
	DDsY7JZ+l2RTnjsTPXU9WDlcqu3yJER58UY/HP4yi9fwenBvTIEZnp7A+PNc20ucC9DjLVEF3C7
	Bvr8ZVb8ET459BRD8rjArW/bU9hMAJpsyX5SEB5OxKbOjVh+H+vtU6wKO59MF8jrLMlyQdAIik3
	uxgPXf3DxeMtl9sNQKng7SyBsbV9hQK7mogCOkpamA+yJdZ+pJJsd6vnWdD2D1Equt72oDTCKEH
	GoN7gnSxSAliBepw5fKpI913ZTT90=
X-Google-Smtp-Source: AGHT+IHoQJVW3GVryEUbRFPGpnxQkJbTH7OhYAuA7LrZ0+OT2N5eQIcCT1zPMqYvJ4arflxQltQRlg==
X-Received: by 2002:a05:6000:2001:b0:428:55c3:ced6 with SMTP id ffacd0b85a97d-429aef82eadmr2390550f8f.18.1761747644972;
        Wed, 29 Oct 2025 07:20:44 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbb20sm26388404f8f.18.2025.10.29.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:20:44 -0700 (PDT)
Date: Wed, 29 Oct 2025 15:20:41 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dpll: add phase-adjust-gran pin attribute
Message-ID: <jgebk37r4xs6w4526hjc5u6r7oudanb5ce7v4xlaw2tcswtycx@cvmxkwxvkpek>
References: <20251024144927.587097-1-ivecera@redhat.com>
 <20251024144927.587097-2-ivecera@redhat.com>
 <20251028183919.785258a9@kernel.org>
 <b3f45ab3-348b-4e3e-95af-5dc16bb1be96@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3f45ab3-348b-4e3e-95af-5dc16bb1be96@redhat.com>

Wed, Oct 29, 2025 at 08:44:52AM +0100, ivecera@redhat.com wrote:
>Hi Kuba,
>
>On 10/29/25 2:39 AM, Jakub Kicinski wrote:
>> On Fri, 24 Oct 2025 16:49:26 +0200 Ivan Vecera wrote:
>> > +      -
>> > +        name: phase-adjust-gran
>> > +        type: s32
>> > +        doc: |
>> > +          Granularity of phase adjustment, in picoseconds. The value of
>> > +          phase adjustment must be a multiple of this granularity.
>> 
>> Do we need this to be signed?
>> 
>To have it unsigned brings a need to use explicit type casting in the core
>and driver's code. The phase adjustment can be both positive and
>negative it has to be signed. The granularity specifies that adjustment
>has to be multiple of granularity value so the core checks for zero
>remainder (this patch) and the driver converts the given adjustment
>value using division by the granularity.
>
>If we would have phase-adjust-gran and corresponding structure fields
>defined as u32 then we have to explicitly cast the granularity to s32
>because for:

I prefer cast. The uapi should be clear. There is not point of having
negative granularity.


>
><snip>
>s32 phase_adjust, remainder;
>u32 phase_gran = 1000;
>
>phase_adjust = 5000;
>remainder = phase_adjust % phase_gran;
>/* remainder = 0 -> OK for positive adjust */
>
>phase_adjust = -5000;
>remainder = phase_adjust % phase_gran;
>/* remainder = 296
> * Wrong for negative adjustment because phase_adjust is casted to u32
> * prior division -> 2^32 - 5000 = 4294962296.
> * 4294962296 % 1000 = 296
> */
>
> remainder = phase_adjust % (s32)phase_gran;
> /* remainder = 0
>  * Now OK because phase_adjust remains to be s32
>  */
></snip>
>
>Similarly for division in the driver code if the granularity would be
>u32.
>
>So I have proposed phase adjustment granularity to be s32 to avoid these
>explicit type castings and potential bugs in drivers.

Cast in dpll core, no?


>
>Thanks,
>Ivan
>

