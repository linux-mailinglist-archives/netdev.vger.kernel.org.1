Return-Path: <netdev+bounces-220409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11604B45DBF
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3529D5C5E96
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4375247293;
	Fri,  5 Sep 2025 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecI0Ls1e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A5DF49;
	Fri,  5 Sep 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089007; cv=none; b=FVC4AGnHyrRucysbwsufRFyT0hGUePoQ+5EAinKAO0YMW+Fqg2m51Hxfuwq8h4PNbvILPOQgzLLZ5CJlFZEEjc9f6ZOhYhww32pw2XMhZLh0Ofda+R9gktOudBue6Ck6P0F9juWrQkVLEgbLBoa/Z2tIpYijqlCgVWcfhnUF+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089007; c=relaxed/simple;
	bh=p0I1bbhRME+hcO0abhDOLwkucn20yaU/Hn/mHdArgSM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rnMrL10C7i4R0/evg8VgbmE9EO3VTaANGw4evc/R7aRwKzinp+zbHlNZUww67AsckvkJHCv/rYfwDswITiNqv20bydfnkHKLAfp02bzJ5Jck2JjIFQCH44SYhIzraPmqbCi7mRJ2begb+IOUhuFGMmOOQywLs5WYjsAtPrwy0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecI0Ls1e; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-529f4770585so1565730137.1;
        Fri, 05 Sep 2025 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757089005; x=1757693805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0I1bbhRME+hcO0abhDOLwkucn20yaU/Hn/mHdArgSM=;
        b=ecI0Ls1e64B2MlHJ6XJyMhGmTlJ8Ecj+pQQbCiBGulQPgM/1SCrDcE5StzjNizg9kY
         YaBmh+HwgBSaiwg8LBkGFxGrz1CkSA2Pf7FoDAZqgPbQwtZ4d2HdZvjAT7RLvbJ+bQxZ
         soMo+r+AGWan/YFW08YNpbmxBh0WlprxfHljcIDviGKxKLcq2/JhIcsxIQIYhFnEsif2
         kwk2d/2Z5wprocNhkqydPaunoOIbD6M1sFGe11G2dRXKVZbWajs4KxiD24CMrtDhCFRN
         w/f8n8aaHl3QhSQn1d1Tx9fu2Wv77RLYg7cbTj1NBTRUAZuF2zriYjBRPXVvy6qB6k0O
         7liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757089005; x=1757693805;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p0I1bbhRME+hcO0abhDOLwkucn20yaU/Hn/mHdArgSM=;
        b=dmCnd57XsOMal6oL5f//LhSiXQxszAd26fvAs/HNnFsi6AtDJ3F6bkuWdgAZ2Zihdv
         Ch4/mYDdCSps/2vXb9zbcBvwh2zOpniTyKi8FlnffhlAP8ubiXUFI51lWpdEFtO1vW54
         w7URDhYV/sXhRvVIZkZkvX+qCQgy+vOzXrVtdRUrplBNooUf3ybqDW293zp2NUOgtH/J
         kiJV9UzG+KVdKU7JPgv2qEkI8XM7SZSg+dTkj9S/WOLdnFSsUuE4WL3dQgkP2KgxiFYe
         HzLT3u76JlvS6dKpb6KaY5Q69gYvN6g1rWRhJbfn61COKZ+lF3DuhSG18ZwT+soCpPyi
         Sq4g==
X-Forwarded-Encrypted: i=1; AJvYcCUC6Tj2UgegfiOMs1DfqmuWhGZ4s6WxQ3Z58kv7mllsrbL3xFZOcUQlDnrBG3T7OE32DXExRRggKO3GVSE=@vger.kernel.org, AJvYcCUVviMNoNTwV4KmAL1WUAQGHkMM4lFD5jRSYgnynuanzibvpRMGIk7zvb5Q3K/M8ICwBbYfZbKZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoO4pwmZZWfwca1PbQwX1UguYOz+1FunsPRu5l0MVSop5FOmH
	QBeGTtmxaSHSgTxNDIfCGC1X/KFjU9c8r6a/28uUl3/nxNFG7DOlTYli
X-Gm-Gg: ASbGncvF6DSWgmTrz1JGFa22Pq1xA8c40aZwyplAiPS/IFHJmnpC5xVctNYkrpc8BkH
	ByAqA5cAdPY4dZ/MbtOEYxh0PBXI24VqpN1w6vpiLX3C9Clj0EPDWvXNFIRXKEcAYTwnYrOEZRb
	6DRTTM4cixhd3mRHuDiTY9cFow7w0RTXbWxBXsPKZ9ZUPgqVbAqU5wBqHpQU7efncaFI4kNocBu
	DUW1ZeMoWliVsvJf/zsnkoV8KQ2xaKBYjKvRGfRwcat42IeEfsfuck1/CnqEEN5UEgCTUfRctP7
	T97sEtXkI+BvG2mdX+jtAbiAPnZXDaKBtSI59jMb0HzJdfGv/oMbN1obf3i4pnzorpL5uDY5yT1
	H7OHTrwXb53tlyHGEdmgk5LArNgoJ/IeFHbQRWuIFTnPth9XBXp/MxliQwShVlU3D7Kj1CDrarx
	/68A==
X-Google-Smtp-Source: AGHT+IG2TFzjlakR84Fu04eZcQzsLDKA6Otn0fB+G4jj4O0vg7fQwmkXsqpt1So5MXV/QF8zdnMbmw==
X-Received: by 2002:a05:6102:508e:b0:51c:77b:2999 with SMTP id ada2fe7eead31-52b1933ae0cmr8853197137.2.1757089005000;
        Fri, 05 Sep 2025 09:16:45 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-52aef458d14sm8152726137.2.2025.09.05.09.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:16:44 -0700 (PDT)
Date: Fri, 05 Sep 2025 12:16:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 kerneljasonxing@gmail.com, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.ebc40a51f82e@gmail.com>
In-Reply-To: <20250905144707.2271747-1-jackzxcui1989@163.com>
References: <20250905144707.2271747-1-jackzxcui1989@163.com>
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
Content-Transfer-Encoding: quoted-printable

Xin Zhao wrote:
> On Fri, Sep 5, 2025 at 14:45=E2=80=AF+0800 Jason Xing <kerneljasonxing@=
gmail.com> wrote:
> =

> > BTW, I have to emphasize that after this patch, the hrtimer will run
> > periodically and unconditionally. As far as I know, it's not possible=

> > to run hundreds and thousands packet sockets in production, so it
> > might not be a huge problem. Or else, numerous timers are likely to
> > cause spikes/jitters, especially when timeout is very small (which ca=
n
> > be 1ms timeout for HZ=3D1000 system). It would be great if you state =
the
> > possible side effects in the next version.
> =

> The original logic actually involves an unconditional restart in the ti=
mer's
> callback. You might be suggesting that if packets come in particularly =
fast,
> the original logic would reset the timeout when opening a new block in
> tpacket_rcv, so the timeout does not expire immediately. However, if pa=
ckets
> arrive very quickly, it will also lead to frequent timeout resets, whic=
h can
> waste CPU resources.
> I will emphasize in the comments that the current hrtimer expiration lo=
gic
> is unconditional and periodic.

+1 that should suffice


