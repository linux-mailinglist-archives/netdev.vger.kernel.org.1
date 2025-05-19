Return-Path: <netdev+bounces-191573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C80ABC2AF
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467FA17DC22
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16532857E4;
	Mon, 19 May 2025 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zuo2xE3i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C302284667;
	Mon, 19 May 2025 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669164; cv=none; b=aC+ylGJUaJ64oDF6kuJ4fJ4s7QKcdtqrQVAWFDV3a1bAbhVdRX6DLIA5KcR71lAmyKnenmsvJJgHyB9gl2DFOwAaEJbUXtYzfSTUt2AT5GezYbOqBfUHBIfvCS67f+cq+2tjVvnijEnCXdd6YB7YA2+c63tphDBUH/5NUybcxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669164; c=relaxed/simple;
	bh=yisF4/ZaG2aKyL8oy44jbRcTwJqvD3QTXjIWJP5t+1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfsLR/3gL4Wqqu/QdMXOM8DQCGaV11VhQz5Sn6O7MEhCys+UqXKEeYCQF2YidNmpHM2SE063Mk4OwT9IR/QROv3ZDQQT3nmCgj1sj13VB+HvE5BQ2bdKTDbFW+dQZYXKTrAp1GTtbQkGH8tkRJb02zgc/PDiXUWbCobZCWBKIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zuo2xE3i; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso4159575b3a.2;
        Mon, 19 May 2025 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747669162; x=1748273962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CuMNzltIPIYPP2KT2k8psLqUU3G8daSumuRYfumtKY0=;
        b=Zuo2xE3iCRJ2pogtq4+dYUbHBKDkFurcKjVDC5rSEJN9hH5IrINiiZP1umwcWBPqeV
         sBFLcor6/nkBWCGY6mXfMwK7uwIH3/2c+yJw+LlW1yG3r29vq9E9FFspob0T3UTY9r5j
         6K+4oCSvE3paE91EOvdrVNFffZQRWJHo7K1Sa6zYBXbasAYfHw97vxuuHYOVIdp5lVuc
         TWb2hWGf03elUS7JoE/TORELgLU97bAdnvQCs34KwksJoaMDNcRmzBvGXUWLhaPwvuIZ
         vcjC2DiZiYJFW8fL1sYUp+lFmZrzEEUJhRpkBc7xyGL6Au3A2Phwvm+Wf36kwRPiQcol
         S2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747669162; x=1748273962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuMNzltIPIYPP2KT2k8psLqUU3G8daSumuRYfumtKY0=;
        b=rmp3uj5Rof2OYbRiTmgRbk5wdVOJADmRkJK2zvqWsxL57VhsjZ5PBIphZ9TbkUCAp8
         7r8ePQtBCzb0b9Rg7XWpdgWhKy+jk+C7PlT19y/7WxxBikvvPLKSMTS9JSR/yMhtuDpU
         AJylGnOa6kxlQcWHmOILMAwheJyPbfJpCLWOIFZW599t1aLkDEtcJ+ynwHDlJURaar8o
         bq91L1ITHk0Etnjv+30q/mLvdsnv40HQqgwahHo76Hj+EHYgo/1c33yS38tWL2AO2A4Z
         nFnW9iqZGgg2b4D2rgg7q1Y6STXOvHx3v/ZYuqAjbmspLibPxIlSp53SPjSgTzIezVns
         ZRnA==
X-Forwarded-Encrypted: i=1; AJvYcCUoika+AXdgbbVGPGx9xnfamKhY0E9rnaTcI435btuQUlGi7Fwm//cDJzg20i1E+wzlAb+ND+zQTfKFIUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YypbpedmzzECj9x+dSF240Zu9JHYjk2iiWJlAM/lqzboDN2VEMK
	+81VaMw+OH87hvdUlLha3776Dfa4nOOkstuk0Mm39JPGNnS3AWrKqdE=
X-Gm-Gg: ASbGnct1d8i6KVxoegUIQtl55ZeWTsQPDC0IQAGzIVNsJuOW6NGCKbUIMYbQQKhvo1M
	C9iFGmMIa32Y7jZFJjcJ1QI/bwRB8X89qX0ZrbAJyPaJRkr5YVKv1jMYJmPp8S0Z5jBoUH0Owuy
	0zEpehjSD4XnOZbjw/Ri2npqsKMFbmNIbOslHPcIEEKLybvY/L0Z8QLs+VvoabbjHLS5funi+AB
	bZNRfcX8QHE1tBufnD5IBqTmlfH6SYkyMno+X6c6GBxtW1hiLf63pT8LBOhx71ey3+7TCBenu4P
	Ii29fY5rLwj8NvzMrE4K3eYU+SRgZs0pPsyrGaxYc8fCWbMkZ76EKXvqv0h5plarFjUsp0xz1FH
	4WvPG1449TqkmOReQ4S/SVvs=
X-Google-Smtp-Source: AGHT+IFAvBtcLCJ1nDyg8HFYOfju2Duf9SHaBHXAqTVpThVm86vnectbWC6sjLwRVnoXB3EYvUY54Q==
X-Received: by 2002:a05:6a20:76a9:b0:216:5fa9:55ad with SMTP id adf61e73a8af0-2165fb897f8mr13730867637.39.1747669162460;
        Mon, 19 May 2025 08:39:22 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b26eaf8de24sm6448004a12.36.2025.05.19.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 08:39:22 -0700 (PDT)
Date: Mon, 19 May 2025 08:39:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	sagi@grimberg.me, willemb@google.com, almasrymina@google.com,
	kaiyuanz@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: drop iterator type check
Message-ID: <aCtQqQGJJbdO-bqh@mini-arch>
References: <20250516225441.527020-1-stfomichev@gmail.com>
 <ab1959f9-1b94-4e7f-ba33-12453cb50027@gmail.com>
 <aCtDMJDtP0DxUBqj@mini-arch>
 <0665ead7-56b4-4066-a21e-9a759d9af38f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0665ead7-56b4-4066-a21e-9a759d9af38f@gmail.com>

On 05/19, Pavel Begunkov wrote:
> On 5/19/25 15:41, Stanislav Fomichev wrote:
> > On 05/19, Pavel Begunkov wrote:
> > > On 5/16/25 23:54, Stanislav Fomichev wrote:
> > > > sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
> > > > iovs becomes ITER_IOVEC. Instead of adjusting the check to include
> > > > ITER_UBUF, drop the check completely. The callers are guaranteed
> > > > to happen from system call side and we don't need to pay runtime
> > > > cost to verify it.
> > > 
> > > I asked for this because io_uring can pass bvecs. Only sendzc can
> > > pass that with cmsg, so probably you won't be able to hit any
> > > real issue, but io_uring needs and soon will have bvec support for
> > > normal sends as well. One can argue we should care as it isn't
> > > merged yet, but there is something very very wrong if an unrelated
> > > and legal io_uring change is able to open a vulnerability in the
> > > devmem path.
> > 
> > Any reason not to filter these out on the io_uring side? Or you'll
> > have to interpret sendmsg flags again which is not nice?
> 
> Right, io_uring would need to walk cmsg for all sends, which is not
> great for layering. And then it's really a devmem quirk that it uses
> iterators in a non orthodox way, it'd be awkward to check a random
> devmem restriction in io_uring, when otherwise they know nothing
> about each other. And it's safer to keep local to devmem, because
> try to remember if something changes, and what if there is someone
> new passing non-iovec iter + cmsg in the future.

SG, will change this to filter both IOVEC and UBUF, thanks!
(pending discussion with Al about what to do with UBUF in
https://lore.kernel.org/netdev/20250517000907.GW2023217@ZenIV/)

