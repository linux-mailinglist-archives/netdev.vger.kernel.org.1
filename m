Return-Path: <netdev+bounces-178064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E82FA744DF
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 09:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D433BCB0D
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5272211472;
	Fri, 28 Mar 2025 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIxcRODd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197C1A2622
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743148932; cv=none; b=iUX86ihmLovtpXRKD2+I0TAf42xxcwg7oywsbWD0kPcuxK+9xLcOhJFc4C50KNiCf1il/wNHl4kQg2hdhuyP0iikFvmb4v7xdGCpb6DkMODmo3GY3zVrCCkWhOBjM9MDNFjydR0rWVgbiVRhxidnhR5CJmeAUO424Zow8BoZhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743148932; c=relaxed/simple;
	bh=z2YDe1OU3wrVgPNLV8ZOOArWU+bI010amQn+oFWZ0So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUDIyq2TdmY0HbQbh5nqjvQmGPK3hnJ5H6RFT5ZmqKBEaURosOCSKRGcKbunm+DDRSA31rjglyAJ3+KlXs/kJe+ws69IlKgNFIMPPyscozz3n9SCHl5bZyhoo07axpd635BT+WbE6Ypg8BaAz41gxFsMHQh0N8/Uvc2CAQ6LlCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VIxcRODd; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f2f391864so1008530f8f.3
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743148929; x=1743753729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSnI14BbYG44AW/1FazNe/GgOwu32Ov8br248K1Kr2c=;
        b=VIxcRODdnhJqwpyGIGtCbjqCAkR6z3CTNGO2EWhYM/vZtXyCN3G0HyIm/oMvaC3vfw
         fL1Tm6CKC4SRSWsrirQB6hCuekGGU+cZQ3iOca5P9Z2OYlfAJ7peQtLgb2Tf403Jk7N/
         3gHlYAxWlRlh6yn8lPkAHm/plMnwNbUQ3TzGQ5OfwQxMrZyLD5CKExxhJ0eE1L0IMRMh
         u4IAcEMZvlaj6qcfW1U9xt8TM/KLYguV1R9ili80ULJAehvgUVBzetTrReA910DcQpSn
         vZ0q/EfbrwcG+qUFrcxqCG+aNY+rUVfmTrkcIfS6limM/QA3rjy/hE4JdEmnI6O/SCB4
         1R9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743148929; x=1743753729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSnI14BbYG44AW/1FazNe/GgOwu32Ov8br248K1Kr2c=;
        b=ZGflO2IuJ2RPWdJz0m00ydS7eQ7GqEQ1Fn6jM5X2oR7FeDgfzP3hBRsvDwf5MQXJG6
         HyMYPgymJK5A/X0EKKiDRwlmRNpp0uOtPy7iApM0ZlWB2gGnrkgPh/bRHgKoiwU0X6AO
         fym1s5gbMGDtKM/W19RppBvHnoeFs+muBSbQYzB/WgICpd8C185FdbiIWxHsXlBBPYkP
         WdEEXXyOkMFrXv7ioj4BXz+yFWzI/HT0HSRUaZh6p+eFZDdaYtWjLfyCyuL6BaUTNc/g
         4PhKI+zyJTMTGMUJtaX3+MMLHIqk+XpAHDVlAIOBZdIWr+eW7+hiRnhNr9tMqLFtZGzQ
         97WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3+RzoPwd5LjPVNKWQ99/BIPaeC/CPmnAGnQAjBn5ZmPumZ+QZ29wOZ3Vd0TRHA24xTJjUlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQ4gEZn+5DLSdbifxLtpKc0xN5PPRMfqCYSIDCKB7zwGJIqP2
	d2Qt5Pbx3VTme8rHbHurUhtO7obwdW2PJUvQtCqDWr3rXT7k6hHI4Ik3Q7OgPpo=
X-Gm-Gg: ASbGncuVUFmRTlhoSwIuDmBsFh/PLuJ2X1ZLYOrQLusnqvHHg2hBWuPU9pHEa6D4ywC
	SoEOYINCefNSxg3oNV3dMSWeygIbDsQofvnNyBBHUSTLyENWuLZAVI1QovdXXXUAAzHyJUWdysr
	S5eGLsiLfAgzAtU7let6IhP/6igz0zgko8L8ZLfDHHkh0SvWFw8yfS8UcxhlhO6KuJKMIaT78dS
	uNoU+t1cG5mQ8L4JL/pgjCQY6cFiNvBlyzqNv2rCBrNRq8JGWOnkjemt230lBXEko9iJWl0lOxm
	AT7EQnRJLLfohEe8J6ixTyp3Xitcpd28JQiC62JCBTp6QqxlZA==
X-Google-Smtp-Source: AGHT+IFJDzuS2myCBT8Z8eorHzwkBKAKIK4T2dNn586UW/tt61K1e2XI3JFfo+oVpAzMnbvgnYtY2g==
X-Received: by 2002:a5d:5885:0:b0:391:4999:778b with SMTP id ffacd0b85a97d-39ad17505d5mr5896059f8f.28.1743148928856;
        Fri, 28 Mar 2025 01:02:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b7a4482sm1795937f8f.86.2025.03.28.01.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 01:02:08 -0700 (PDT)
Date: Fri, 28 Mar 2025 11:02:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Malladi, Meghana" <m-malladi@ti.com>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kory.maincent@bootlin.com, javier.carrasco.cruz@gmail.com,
	diogo.ivo@siemens.com, jacob.e.keller@intel.com, horms@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net-next v2 3/3] net: ti: icss-iep: Fix possible NULL
 pointer dereference for perout request
Message-ID: <326ebaa2-7b8f-455c-bf22-12e95f32b71a@stanley.mountain>
References: <20250321081313.37112-1-m-malladi@ti.com>
 <20250321081313.37112-4-m-malladi@ti.com>
 <20250325104801.632ff98d@kernel.org>
 <0799d2f6-3777-45f6-a6b6-9ca3f145d611@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0799d2f6-3777-45f6-a6b6-9ca3f145d611@ti.com>

On Fri, Mar 28, 2025 at 11:46:49AM +0530, Malladi, Meghana wrote:
> 
> 
> On 3/25/2025 11:18 PM, Jakub Kicinski wrote:
> > On Fri, 21 Mar 2025 13:43:13 +0530 Meghana Malladi wrote:
> > > Whenever there is a perout request from the user application,
> > > kernel receives req structure containing the configuration info
> > > for that req.
> > 
> > This doesn't really explain the condition under which the bug triggers.
> > Presumably when user request comes in req is never NULL?
> > 
> 
> You are right, I have looked into what would trigger this bug but seems like
> user request can never be NULL, but the contents inside the req can be
> invalid, but that is already being handled by the kernel. So this bug fix
> makes no sense and I will be dropping this patch for v3. Thanks.
> 

I don't remember bug reports for more than a few hours so I had to dig
this up on lore:

https://lore.kernel.org/all/7b1c7c36-363a-4085-b26c-4f210bee1df6@stanley.mountain/

This is definitely still a real bug on today's linux-next but yes, the
fix is bad.

drivers/net/ethernet/ti/icssg/icss_iep.c
   814  int icss_iep_exit(struct icss_iep *iep)
   815  {
   816          if (iep->ptp_clock) {
   817                  ptp_clock_unregister(iep->ptp_clock);
   818                  iep->ptp_clock = NULL;
   819          }
   820          icss_iep_disable(iep);
   821  
   822          if (iep->pps_enabled)
   823                  icss_iep_pps_enable(iep, false);
   824          else if (iep->perout_enabled)
   825                  icss_iep_perout_enable(iep, NULL, false);
                                                    ^^^^
A better fix probably to delete this function call instead of
turning it into a no-op.

   826  
   827          return 0;
   828  }

regards,
dan carpenter


