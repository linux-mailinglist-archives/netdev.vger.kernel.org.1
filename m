Return-Path: <netdev+bounces-147788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF9A9DBCB7
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 20:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC7C16467C
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16D1487C1;
	Thu, 28 Nov 2024 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2kRFp9l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1FD7A13A
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732823952; cv=none; b=Jxl4x/Yia0iA8bIV8HpHNvE+PD9npDNdu2jz5Qj9gn1syz1iz3drCecyEUjg8CDOhFGChqbH12D59j/gV1vWKqFQOsUZyoGd+gFgy9/x3P1y210TK41i1d8EWAPYEt3rqhQ7eEEEm4PsXC6EP2YaPTM/lxt+D4J7LEu324l4ivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732823952; c=relaxed/simple;
	bh=WojhLmvNYdvGz1lXH4yB9jUW012CA0hTwl5wJZAods8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feSr+K0MYmsW19LfMJ0FcIVWbyIehNl3SLXiXQGo4Z+ffOFo2HQo3fGIaUdigPN0tQhB6OZiOE8sLZTMVAgTEMO4kX4myKeQeUeH9B3LAyDWR9dApNUyFkK/ZWOXI0HwE8G5z4Lmf9knNKjlO3/DmoLBPp7X5NYz8vDuLBcWYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2kRFp9l; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f1e573f365so479036eaf.1
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732823950; x=1733428750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQoJvwwRV2WuKH22MOuMgnTVVA7Jtg/d2Ctxd5KIy5A=;
        b=e2kRFp9l8XyY125I2ozMcLXI+JK5ycWWeJZyes0BsginN7ziXDRFYnFtlvm6DgH2Ca
         Kc9zm79RhrRf+EJPUlfOONz9vQ+rEjvNmPLVBDlTru9nkDUfG8BlPv6VdzPrS0GW9jo3
         cXdf1gi6yZvulpXx1zdfXj0xBXeL0QoNq+dkmB8eLM/zpF2yn2ZEbDnTp3Bs1woYNkAK
         CRqyZ69hxCQWbB1xwL23MI+Ma+vNJKNUkt6f1EnGMQPQ3oyVSb/XEYDvN1YSjtWtomad
         BVnxra5vhohC1NJar88UyaHyE+6et0sGDVMEJx/SBYVPGQjAmOH5QQG16mv6Yut8s1b2
         zKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732823950; x=1733428750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQoJvwwRV2WuKH22MOuMgnTVVA7Jtg/d2Ctxd5KIy5A=;
        b=gs/NgUyK4uqx17zJPS86VfSDiv/Mpu3k9zJ0irMF761eLV4mbqnRMi+ZVfVNhh4ZXz
         UGxIR+TtZJpaYaTmxpL/E2IuXq+3M5ccnIQvEw/OC9jzZSXD0axVmdPx5qPs5OrGuBtO
         GsJMEj6flOb9NYBdM4YZtnwJEWFht63r7huEblqFtIZLGK3GumlPXLgoEUTu6aPv8K88
         D9WN8SWQ/8MSo9xiXcjMp0SeWWoXMFdkCXIQ2B0WBVbdeglgU1cnN8Og6/LpK1Yujzy/
         Ja3BrOZ4RwLNt9KUPWZhbu1qr/DJWDUnW6CyOCm0ta4x01pS1Nvo2mSDZyaN9v4qn9lM
         DG0A==
X-Forwarded-Encrypted: i=1; AJvYcCXIccR/Z6fbBAS+46qu4P52RaO6gl1hFKctKuAlDpnzewoGeTIXOcCC/+H9kv8Iio9SQ7KGVjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8R92xU09t6Y7pR6Vh+R86f4kt4XChl6RaVwyl4cJK3AmJe2/g
	vrnKS4c31yARyAJRvRtCn3ksYzgy7s5hhtBM/qB4phSDVy964nBf
X-Gm-Gg: ASbGnctNYmO38cQeA7z3Ff6bHzqE8agPgIqs4MriZdLjKcQSdQ6K+DDLCfk90+H9Rjj
	p7VKgbEuGCU3VPh2VxAIw2elvQKmuU7EnPF6URDhdL9qp8V6ZGBzQWIO/ZrL7H2JijOfeUBNgHF
	EESAlxsY/QVQbcBAwOhr8r4F5qkyMVHIokA8yzahleGMS+hHb6F+bipwpPtKdrFg8L5jrZude/M
	BCtbbHZPAWQ6GwB4awnfHWvDABwqu2dTiIeks1DhcuzEXKgkkSVtpgUk3QtVKbSgph6nQ==
X-Google-Smtp-Source: AGHT+IHFkbPlipMnHbPl0yjwyi6QLmWlxz6kS5RUQqGeJVF42MyMeYrGcOOJbrV3b4mnMkEG8c5EtA==
X-Received: by 2002:a05:6820:1620:b0:5f1:e8fd:5da2 with SMTP id 006d021491bc7-5f20a1e71a6mr6974410eaf.7.1732823949941;
        Thu, 28 Nov 2024 11:59:09 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f21a4cc99dsm451475eaf.33.2024.11.28.11.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 11:59:09 -0800 (PST)
Date: Thu, 28 Nov 2024 11:59:06 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH iwl-net] ice: fix incorrect PHY settings for 100 GB/s
Message-ID: <Z0jLiisnLOTSvbaW@hoboy.vegasvil.org>
References: <20241126102311.344972-1-przemyslaw.korba@intel.com>
 <946b6621-fd35-46b9-84ee-37de14195610@lunn.ch>
 <PH0PR11MB4904824FA658713F78CA404D94282@PH0PR11MB4904.namprd11.prod.outlook.com>
 <6cca6089-ed72-407a-8f23-70bb67b42e63@intel.com>
 <1c95b010-cb57-4864-aa0b-82b7093f44d1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c95b010-cb57-4864-aa0b-82b7093f44d1@lunn.ch>

On Thu, Nov 28, 2024 at 05:20:44PM +0100, Andrew Lunn wrote:

> "only Intel's driver" is a bit of a worry. Part of being a Maintainer
> is to ensure that all drivers behave the same. There should not be any
> difference between an Intel PTP device, a Marvell PTP devices, a
> Microchip PTP device etc. They should all implement the API in a
> uniform way.

Yes, and I appreciate it being on CC even for driver changes.

> What i have also seen is that if one driver gets something wrong,
> other drivers might as well.

Yeah, unfortunately there are many device drivers (not just
PTP/network drivers) that get things wrong.  These are then copied by
the authors of new drivers, and so on.

Thanks,
Richard

