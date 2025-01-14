Return-Path: <netdev+bounces-158167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA35EA10C1B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643503A044A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77C7170A1A;
	Tue, 14 Jan 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd351PHo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B211552FC
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871667; cv=none; b=hQ7drD8bsvR3dXHh3A0YR72lq41sDqEc8lscHGuSayOt5f32Z8fr0w8md8ASuyNY5EQKGkvBbt3pKUrtVlxHUNBeWHb7iurBmTyMv0otUfZFl1amdSUBrjDyaifJvg7vso4O/2QS0Kne7d4yG/ZQskweDhF4XXMUB82b8A4Gdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871667; c=relaxed/simple;
	bh=jo7uy5756GericWGxChvJXldjNERQtsO0Y8w82Aqg/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikt7qhV40IIl1F8D1Gcv4L1HtO8LsqCWXo84CsRojbq7oKOg1fdaoSuRs2/RPar8aZs9HJN7BfDjkcrnkueVplMZ4W+HjHiBYbZGP0D0iINkA+jxFjUXRHaAeaBJd6x5RzxRp//qly2mlxYJ0UN9b7YCAePuav1swkpJxUK5LhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd351PHo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216281bc30fso121172255ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736871666; x=1737476466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9X2SSvDnLxI9c2kcCXzMVKuky5eQD6NGK+K32MV0EH4=;
        b=bd351PHozPDE8ea4fIZXLu3fdjV24jPpWsZDIPThDIH1kcGjUP/HFXgg6SLDeFIxCU
         shEtqBdVnXfGm0hHU/4Z+6wlvwcYHx9Ck/u8m6xpkVbH3EDOH/xAF+uyLgCiLVobcBxR
         EHGPlaG94EPvF80TmzmxeCtWfIMIlh4+olUPZSdazPz9pRhnLcj0Rq0h6CWFmIad8WD8
         3N6cSaL6RU33GrSCOqjxN4mgxHbdyxUWmgD686ZTHCE1Y84GJbJ063rhZ734dGrvg99a
         RzQrPGCRftGei5sg0QYQNJ4l4P4a9yiAc4tTF90RdbvmJTnUnqemz05xY9vcSwm6V+ND
         ecbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736871666; x=1737476466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X2SSvDnLxI9c2kcCXzMVKuky5eQD6NGK+K32MV0EH4=;
        b=Y9B9J0AqcBtmKGwFnPupkfffROvfWWRCKA2sp/UIWc4Nwpq6porm9axPKavrtAzTsb
         C91N4GE0ZhYilmtli96qmcTGRsj8ux5xVM+ZvivEzCpNBNTnhUaDgM3tv2PTZZ1w5RqT
         cmKNejHK9to9Ez6CpVO9dojJgGKgtVvwppIuRKAsluTMK9G3HpMMXYUBYKjCPm7g+jsZ
         /yBM4Lh6E1VOPlBwntuBllOJF2m/Ttis0assGI3mVAF/LZ2WVY/mFap8Nn2w4yf1LvZs
         W893OGlUpg6Pxw3pmNbQt3446L+IYyCSyulolTpu6osa74IAGV9w9Mdy6qBLwCGmvNxC
         ICjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrxq6gkNkXJ3UHTlXCEz2Q2DE6DpPLa+0DJEbc3CUgkdYSkiJRAzLjQ6GSdGylJB+S67x2EOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYoTDdjuzJyAQhbqjSyWzefSU0D8c0OLMABJsd7XL2mpyRMXw
	FWeU++/3duSBX0ceGdiFArqtWijFPj/B4Iq8SMh760gxdEV2b7Rl
X-Gm-Gg: ASbGnct2JwEWbXMWc7KX0eEg/ViiaaLLssETWwITELYGM+9yqYPotQoTEoKS1dbKZqB
	b8M+QqzlX7Uz+WK4BpOuLKyDng443oFz0NHyqZPVDW7sPRp7mqwOn9LDjggkeoCVX+2h/bXjXmB
	HyrivAOqVtDzhyhsoR2wrrPYwJLanpMt/VpFXhxCEeSucprEhmgBZ/NaOJoKcybbxQDeM2SoQ7Y
	/eUMiAF73/Dva4Zu32gjJ30PMcxId4fdmylzrRTKJIWbEYtGNP7QjacYIv+Y56Eg0vR6BFe+R0U
X-Google-Smtp-Source: AGHT+IFCdngPYYfyVCOpKs7OdCzhj4Iw+aeCN4r8kuk3t3wZCRpNj52Y79me9kuJaAUJFYrCe0yAMg==
X-Received: by 2002:a05:6a00:3912:b0:72a:8cc8:34aa with SMTP id d2e1a72fcca58-72d21df2fb5mr40737210b3a.0.1736871665582;
        Tue, 14 Jan 2025 08:21:05 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40548916sm7599818b3a.36.2025.01.14.08.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:21:05 -0800 (PST)
Date: Tue, 14 Jan 2025 08:21:02 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 4/4] net: ngbe: Add support for 1PPS and TOD
Message-ID: <Z4aO7v0NFe-aYaFk@hoboy.vegasvil.org>
References: <20250110031716.2120642-1-jiawenwu@trustnetic.com>
 <20250110031716.2120642-5-jiawenwu@trustnetic.com>
 <Z4KnPlCtlhHjFI6z@hoboy.vegasvil.org>
 <057b01db6584$a13a69d0$e3af3d70$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <057b01db6584$a13a69d0$e3af3d70$@trustnetic.com>

On Mon, Jan 13, 2025 at 02:30:24PM +0800, Jiawen Wu wrote:
> On Sun, Jan 12, 2025 1:16 AM, Richard Cochran wrote:
> > ... that appears to be hard coding a period of one second?
> 
> Yes. We only want to support 1pps functionality.

Ok, then you need to check the value of `perout.period`.

> > > +	wx->pps_width = rq->perout.period.nsec;
> > > +	wx->ptp_setup_sdp(wx);
> > 
> > And this ^^^ is taking the dialed period and turning into the duty
> > cycle?
> 
> We try to use "width",  which means the time from the rising edge to the falling edge.

You should use the passed duty cycle for that.

Thanks,
Richard

