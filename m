Return-Path: <netdev+bounces-199249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 204C4ADF8D7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A388189C5C7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C239F27B4EB;
	Wed, 18 Jun 2025 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6jNJKav"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5481C2324;
	Wed, 18 Jun 2025 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282691; cv=none; b=gqoyqQNoVK4H6+LYekkBc8SOSDaihCkqI6bh1OBUv9nyzfB0/SzYURoAqhGtYXXgG5SKF7kso5rCpDHogiTpgIF1wJRUqy38NUegWJK0jwh1IqaXYTqQxcdzyuExhOHpCtCJT2zw/PKQGzpZElxaoFT3aMkZxT7FB3kdZkkHhfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282691; c=relaxed/simple;
	bh=tptnQIOvMYZikWloAg8JV19y8q5ul7YfyV9QYWL90vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmzfUH1VYF0liFPmCLFnkglj4eD9hc6ovZeHhdkIT9S0Xq5eS7AfHSCw96N+yLlg97Dt7Jt+CLac1KKAHiIWwx3Napx5mU/akca9zkTaRTFaCjAP89Cjvfq96fs4u4ZjIX7vlQi0aeEvPhDrqPI3LblMNFdyq4bXuHhZXVRHoDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6jNJKav; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747fc7506d4so86224b3a.0;
        Wed, 18 Jun 2025 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750282689; x=1750887489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKvQDtw80vc5AVYxX0/sWoYBJcAOnr5z7g0ZsQrh91Q=;
        b=X6jNJKavgAj8MJLPhbPleoVPDfil3/BC/ZuClZkF8CjS9TH/rhoeZvHlkHtnlwnNeH
         FQQcVCsvbbb8ZeTpjLASZEG487jcfWRwU92JEKcp6SPDdLgl/XJBZvou3Tou93ivVVeO
         TOTyGDlw/2+lAgzaCsQbDR94cMnzvatL8mhH6inCDt1pNqB+JIFThCfAloV5+YLdgMhq
         +fvtpSeCgdSwyQpz8mQCYrQ+b4ro38r8YMs4cn/eLiXvO3usTk0mAtWVLNUFgXyMfIIN
         gXxeHYHio9iCp/jieGaeTESu46wvbhkUoh5ro3qzqWA5FQo1g12ZN8aGf2AJrp49G8zA
         iuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750282689; x=1750887489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKvQDtw80vc5AVYxX0/sWoYBJcAOnr5z7g0ZsQrh91Q=;
        b=iQ3OOoKVpIaghxMZmoCJRgL2y3izgfumcRN+Uv77VIEUVq76puxERrQSV6n0xCi73N
         Pn7sJ0eeILjkTrc9uv+ptJHgyzNCzD/XigHIQYqJ8Z4LFeThhvEa8GSq8/pMOhJAw3QX
         dkRSbPrt3awYmJeWJWF8V1fAvt0/4tnNFkAZdjjEkYcaubNjrytQROBKu0DgzH+A9+Ec
         XUr6CHPCCFUQgcomIlmWOZg771VMfeABaacyyE5K9B/Tq0IJcrdN3zhzxWxo7QQ/OETW
         c1/9XGebA1IDMYGrtfmZO95JbA/PfBos5iksPSPOxYY7YI+vWCgjU3ulVHGJs8d3o7G0
         0NBw==
X-Forwarded-Encrypted: i=1; AJvYcCUBprNjWST42kLC4N213dPgHBbWzvfQ3pwTnrn3GgRmkTiagc2+35Zk3F+rHXMq0caCGloMa2vg@vger.kernel.org, AJvYcCXCJXQEIF9mHtxo32EnZs8hBLnDt/MxUZp4YUeztQfeEnTT/vdkZgIM851bAoEYscBLrSAQQprWrT1oO6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIcXfCIZATi9goRwh7UAG241z1b0BTkPm+e2cZQptvPhjHMGI4
	XFhiQvZLNdF8KJd9/76t/JONgZbiJbvCoe0A+08kJz8vaTX1qsRolME0nR77
X-Gm-Gg: ASbGncvzyu1i/yQLtIgr3GYM21/B/SIwNnsUGFO4/GbUW/QfsrLCFFLMoYy2mFQMEOl
	KolD3I1Y+hDiJb3UV+p6H7Ump1GEvyBO5arPQOcGJ192kbiBGDL0MpEImcq3pLwhAp5RFZnvXpE
	7ocaZU8Fv1KFqRr3v1GEz7NXKGxckUn8BGpSgvr07V8R8pOpAU9PmvOruhEj2L++mzvuFeAf/Bb
	EIqlTEpPHbTbvw2tdTssQVWQn8Qru86sfm6lzTeFMFjM6IqO5U95WW0r7dpsmjMZKpt+Dhi4FmR
	/3sMaLa6YF9nHxz3+gLp5J3qPgoJ4t9B75MrjTvs5aCN0GiCEtk8DxyMPXaN8Uj+CGf6tk+3a3M
	W2IE2426J/7J/oyuHpQOWML4=
X-Google-Smtp-Source: AGHT+IFHMR1qCXEFbrKEi4yRHr5IWlLH6FXfncqVxfGQGIOkk0+ORHY+K4/LSuN6/LNPJV8YN+sL4w==
X-Received: by 2002:a05:6a00:4f95:b0:736:339b:8296 with SMTP id d2e1a72fcca58-7489d03aa58mr27542836b3a.18.1750282689459;
        Wed, 18 Jun 2025 14:38:09 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-748e61679c5sm2327505b3a.84.2025.06.18.14.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 14:38:09 -0700 (PDT)
Date: Wed, 18 Jun 2025 14:38:08 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, ap420073@gmail.com
Subject: Re: [PATCH net v1] netmem: fix skb_frag_address_safe with unreadable
 skbs
Message-ID: <aFMxwIB2O35yfQT6@mini-arch>
References: <20250617210950.1338107-1-almasrymina@google.com>
 <CAHS8izMWiiHbfnHY=r5uCjHmDSDbWgsOOrctyuxJF3Q3+XLxWw@mail.gmail.com>
 <aFHeYuMf_LCv6Yng@mini-arch>
 <CAHS8izOMfmj6R8OReNqvoasb_b0M=gsnrCOv3budBRXrYjO67g@mail.gmail.com>
 <20250618142740.65203c69@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250618142740.65203c69@kernel.org>

On 06/18, Jakub Kicinski wrote:
> On Tue, 17 Jun 2025 14:52:17 -0700 Mina Almasry wrote:
> > > > Sorry, I realized right after hitting send, I'm missing:
> > > >
> > > > Fixes: 9f6b619edf2e ("net: support non paged skb frags")
> > > >
> > > > I can respin after the 24hr cooldown.  
> > >
> > > The function is used in five drivers, none of which support devmem tx,
> > > does not look like there is a reason to route it via net.
> > >
> > > The change it self looks good, but not really sure it's needed.
> > > skb_frag_address_safe is used in some pass-data-via-descriptor-ring mode,
> > > I don't see 'modern' drivers (besides bnxt which added this support in 2015)
> > > use it.  
> > 
> > Meh, a judgement call could be made here.  I've generally tried to
> > make sure skb helpers are (unreadable) netmem compatible without a
> > thorough analysis of all the callers to make sure they do or will one
> > day use (unreadable) netmem. Seems better to me to fix this before
> > some code path that plumbs unreadable memory to the helper is actually
> > merged and that code starts crashing.
> 
> Fair points, tho I prefer the simple heuristic of "can it trigger on
> net", otherwise it's really easy to waste time pondering each single
> patch. I'll apply to net-next as is. Stanislav, do you want to ack?

Sure, SG!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

