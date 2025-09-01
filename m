Return-Path: <netdev+bounces-218760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18E3B3E532
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5696B1A84545
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B118B3375BD;
	Mon,  1 Sep 2025 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlOb53/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044E30DD3A;
	Mon,  1 Sep 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733735; cv=none; b=Ep7/gf8t2NVr22l9ED1qlKPQHhhPmy8yLNlS2dR+YyAKsDo0rAIpYFbcgZJ34ObX8il/RRGCg/NC1OYuo89kBoB2tzRiR3pFcOrOHD9p3UnS/Ve3P43t5paprfmz3qQ6t0ljdTtyZO+tmWnU3SimlptKyM0XMGep6cXGhOYg2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733735; c=relaxed/simple;
	bh=bf3AFvF5sz27QJHT2XY8kNQCv7L94w4eAHK5LwN6nQw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XGQ6Fw6UZLInGIFPV8bdj/0PRh595ElR5qx3VQR1ZbdaoNljYtoP6+mTa1G8epLTtBXf+grjMOkmUfYjfbqd25YeePm2T4R1W6BnEDDhEOx+CDt3mPhABJ0mumNDo9r6IR4/nJdEXjchkHulUsuprW+/zVEhsIrJVk8U/MJihVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlOb53/E; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70de9ffcfffso41998426d6.2;
        Mon, 01 Sep 2025 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756733733; x=1757338533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY5UQezc0U/pino5oFQShI/vsOTbbk5DGY5jnfRX3ME=;
        b=UlOb53/Ez0ljKRuXOv7F9V/MlaaTEmIhMw7AzQ8sDDf7y+MsSlb3AFshPBFti/Nyn2
         KtX3ppdXFLEqcCRvGNl9nPBNTrYuURdwBM5xERG3aNzyg4CKyWw6hQv702se3PVO18Vn
         gtPxmQO743r7JHUkL0oHK7TBt3qdDUyYEJpFRsb28arbETkxTOdhfRWpmRkmPmvVB01d
         ykvZYvSmO/RzvlwMHHEgZEUhYzsWpWtX15LoeoJLhgxn6hpNBUuc3DB5+18JZtQSvpWr
         cmopLK47/aL4/T4zWPF+scKoC7RGwFBy5Dmphj6AFP4ns1xzSyh1H3QWwNzrIku9M8KT
         IVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733733; x=1757338533;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UY5UQezc0U/pino5oFQShI/vsOTbbk5DGY5jnfRX3ME=;
        b=bJlydCILrEylNMZAy2E5W2NZWamTgtQTR4uJxAcio8+Hdo/ydAlJcDbZWpF0HoCYfB
         edunzRhTymfsWkxQJFfOeXUUmqRjCvqYaonCwe7NiCna8boGYTBJqTMQL7bCDFNMGG2M
         j6Kmm3vmcd5YYrpnay0cpNwLj2oLHEafcSi6bva/V/KTYsyZyCuCDROTWMNbLyGatxuz
         2+1G/7gJqJJCXcrOPxP/8DFjhLaxAd8zgJVsPnU7Ymrclz7jFRhYq407pitdkef0dQTu
         P6s1R7OWqKNv05h/fg1N34mBzgYlkIkMNdbUpdeBtfYjDAOOluBDLaR80yqx4KwjVmAb
         5ZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW5KrTF/MkSp8rkk/HAPNALcTCET3E6HZNTSclugQ1H0mFLGcw0gtXg9BLXshkMdUycJH/HlHDdrSQFug=@vger.kernel.org, AJvYcCWCixVVSNb4wfPCgeCphAVOGvQrOW9Bv5IivZka4Z0x2Nm+wZu7HaOwyR943/tAF/Whqza2LPfN@vger.kernel.org
X-Gm-Message-State: AOJu0YxKU95hgHSgLsRoAFugg9ZEQxCT391s8F1v/AcWh4nfc9ngIWKj
	ZD3l+zEMx6EisBO8cnoAW0tOcQwnfecx+GXr+eS77CXJ51AJnl+oRzdd
X-Gm-Gg: ASbGncsey2Yy46UeItletBt0jcOCHsjIwmWh6rWqJgcsJplGm4LAzn/l01yzKTcMQdW
	gdmgJ3Xsja04JNGSP6MOwrud1Dlf1Ou2j1Wg0K0azB9AxEn4/0q0cvyd2aomS6d2ZyYGMs5K8tm
	BkG/YAucin2rlcGCfAsUDTXCDPyuKRDuTLbdU69+xBBaph3Bl5ep3Z8GLbfJzfpjfcMtMblSKwM
	g/o0mWVi1Wxbj9xj/rXeSeyviN8Ly3aagu8W4l214NJbo0jb0oSzk28+eY8aR98ZFwIyL2DM3H5
	2ziZZuO79x/EXrQonc2T/NKf3KffUhLfRQFrjRSn1k30jrIo/hDvjvm5sfTcQJxkLqsjfEDv8m/
	ORwDOlPm8Uc5jb/9ZWkNQ/IBnc7oec56WsCiMHd2KRrsCCDrjAenFAIauWMLy5LcnzTBnhS8Ap7
	bX+WWmiqAtdG6P
X-Google-Smtp-Source: AGHT+IHDGEThEh5ZTaGLfAfU1v0XPtL5KH7yA2/p5m+22laCEjTbDfSwEvZ8yAM6/8nZ8OICvLKhvw==
X-Received: by 2002:a05:6214:2a8b:b0:70d:c0fa:bc20 with SMTP id 6a1803df08f44-70fac6fdcefmr85292836d6.12.1756733732849;
        Mon, 01 Sep 2025 06:35:32 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70fb283767csm40638166d6.45.2025.09.01.06.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:35:32 -0700 (PDT)
Date: Mon, 01 Sep 2025 09:35:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.38c4c9c6a77df@gmail.com>
In-Reply-To: <20250901022744.1794421-1-jackzxcui1989@163.com>
References: <20250901022744.1794421-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the
 retire operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> On Sun, 2025-08-31 at 21:21 -0400, Willem wrote:
> 
> > > -		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
> > > -						req_u->req3.tp_block_size);
> > > -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> > > +		p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(po,
> > > +						req_u->req3.tp_block_size));
> > 
> > req_u is not aligned with the line above.
> 
> I have some questions regarding the alignment here. According to the alignment requirements,
> req_u should be aligned below the po variable. However, if it is aligned below po, the line
> will become very long, which may affect readability. In this special case, can I align it to
> prb_calc_retire_blk_tmo instead, or should I continue to align it to the po variable?

The (minor) issue here is with the second req_u. Which is one space
off from the argument above. See checkpath.

In general, the line length and break rules are documented in the
kernel coding style page, which checkpatch follows.
 
> 
> What should I do next?
> Should I change the alignment, and resend PATCH with the reviewed information of version 10?

I did not think this one space was worth resending, so I added my
Reviewed-by. Others may disagree, but so far no other opinions.


