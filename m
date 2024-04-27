Return-Path: <netdev+bounces-91889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460848B4546
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 11:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8AE1C210DC
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515E653;
	Sat, 27 Apr 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvX7yVpN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3E45037
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714209002; cv=none; b=iy3Ogteo0AAgMWweJfZa/MNUdSKITfL4l4FTREPqD7Kb8LI3THGdQKPcGa2s/j/I+/t+UZwnGU95H9XMwfREb6kMC97mvuXUHTuKLaMM0s0YzIK+LvY5kGAQ8n43MzLSaXjoMLN6aIBiQzb7tw8Zu/c/kRGPFnhsNwjElN7iHes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714209002; c=relaxed/simple;
	bh=mkv5TSiFqFei7ed5Ps2onRSw8Ht9T7Vkphuq6Df8DhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTsw8wG7gNKb/JT+xdqibrrzKVVy5Tx2yYfpouPWDlFYZCPWsd2Pl1uh+QrlYhbbYm8CQfxaxgdcELIfuJsfi4df5YcI/6GZB+MtwJa0f1KO/5bzwIXWe9387lDMrxzia8VeRB1TP6Xg3mBbLRxwv39stKx1RfwAU6I+GfxgYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nvX7yVpN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a524ecaf215so361507166b.2
        for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 02:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714208999; x=1714813799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWl2zz/UwDkq0Lrph/4ZEe2XWuWC4BxORiSlUOHufKU=;
        b=nvX7yVpNu04CTCW9ltrcKKRhhHwHs3/heMq1w+cSf7WPRsKqvAI+QUzhk3fE/HXJOQ
         qrln/UQTy0PRRfqRDZMjcSRjG9SIGwiiRGia2cuu/D7pf8Jp9u0egCf2w8oUU4ew/fVF
         PcyXfBGM5iGUL1iLsfYnhUDj3tR+J881fXAUB9YcdbOi4xtjzI9ClNJv+rPzQ+Cqbncs
         e54eiAiyFy8sRlVmpwvfYYuYnkh+FgvYD8RvV6svUuDDFjlNj3RkHrScrRQFiZrkKTxb
         BRMuvY8cwq6GYm7k4O7lFMk+vIe1EMKMuMZXsyFTxQKHGC6bUcTo6QFNoMSNQ8U6DKp5
         eOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714208999; x=1714813799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWl2zz/UwDkq0Lrph/4ZEe2XWuWC4BxORiSlUOHufKU=;
        b=sRoxU/K7GQa1eFjBvYXN4Y4qvoKljaF6ABJjDaqmOf54xt7I3sdllvtVk2ql+krP+D
         mHX/KTA0BI1sp4bTobqQ8X460FzvJJ1qMi9qe0KczqhW9UmhuXA1PsWhzRagtrOXq08d
         zDVfsMZeCrWq8jYsAjSir/dorDJJhh1pb5nmMftECb2rBwWvl07ROdw3rc60MugX4Hbm
         hgrGNceX/BFn2hrAts5Vgwq9i3lXfEK8N8Sb284JdSxwd9WcKEHJ0r7WnjkHpdwev4hK
         Mv3ZUcRWcTb4g7tCDXOb13YHPmMABHSn7EttBCV1Kfd9iGI6ecEjUbSz9F77LRrcv+Fm
         9+4A==
X-Forwarded-Encrypted: i=1; AJvYcCVFalw4LJAn178PTz8ioTKdHrgIdlQWfD4DA+bEHovSsbCqn1S23glBiyQ9ZIyJovDuX1DyiY52XGcXyIy2vY0C/eyIh9u1
X-Gm-Message-State: AOJu0Yzu3+tvH/2g6CkZX5upUuQoW4T344pKibHuWXNiK/UImqj5RT0+
	l1OFTT+MjOiNKeNI/3Vs6U8b/5L03GtPJ7ARqAadp6uhdaRwZJSrH1ABqj7VZu8=
X-Google-Smtp-Source: AGHT+IGIS1Rji166DipQpgAFWr/Xd+N/X5WfrRGTxnqh7MNSE8SQ8fPJ1W5nFhZEJxbirLQ0crooMQ==
X-Received: by 2002:a17:906:3811:b0:a55:99f4:549f with SMTP id v17-20020a170906381100b00a5599f4549fmr3573310ejc.48.1714208998969;
        Sat, 27 Apr 2024 02:09:58 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ak1-20020a170906888100b00a55b93c5cddsm6629177ejc.109.2024.04.27.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 02:09:58 -0700 (PDT)
Date: Sat, 27 Apr 2024 12:09:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next RFC v2] net: dsa: mv88e6xxx: Correct check for
 empty list
Message-ID: <2edecc5a-f9ad-47bc-9f1f-ce530fa75ef2@moroto.mountain>
References: <20240427-mv88e6xx-list_empty-v2-1-b7ce47c77bc7@kernel.org>
 <20240427085306.GF516117@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427085306.GF516117@kernel.org>

On Sat, Apr 27, 2024 at 09:53:06AM +0100, Simon Horman wrote:
> On Sat, Apr 27, 2024 at 09:52:03AM +0100, Simon Horman wrote:
> > Since commit a3c53be55c95 ("net: dsa: mv88e6xxx: Support multiple MDIO
> > busses") mv88e6xxx_default_mdio_bus() has checked that the
> > return value of list_first_entry() is non-NULL.
> > 
> > This appears to be intended to guard against the list chip->mdios being
> > empty.  However, it is not the correct check as the implementation of
> > list_first_entry is not designed to return NULL for empty lists.
> > 
> > Instead, use list_first_entry() which does return NULL if the list is
                 ^^^^^^^^^^^^^^^^^^
list_first_entry_or_null()

regards,
dan carpenter


