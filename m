Return-Path: <netdev+bounces-120816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FD195AD42
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004871C21E9A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B013633F;
	Thu, 22 Aug 2024 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJ20HHwm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04463136350
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307270; cv=none; b=I2MZ/ElynSLWG3cobDHAYuLe30/lPx6Sf2DeERX7atEru+t2mEbHONcJE056EN/sLObHycn0oMANNUzZcJG4Hbuzcbzc5xjSEWHE4ey5iJPY8jd1zZoIIfuSW/uStT+VskAAS6sezr7aWCVS5ejYlImgKImTVJf9a7Ok10vYsoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307270; c=relaxed/simple;
	bh=X/AcZ0iF6xFu4GrGSjyIJXtGgZILgu9A7UJpP3PiaXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+twKY4W9F+l8fC6an+CP65tq2rpVIS2QsTK/Q452tcTthPo9fQXz5NUSny2tNg/oHVmfqFhKAblt/wCSDARcudNzQZy/YdOL/bPTb1Av10ZVoQ3+FGn+ZmphGW/aSOO2nNVXxPleoDco4O65rHJ3eFXTT5QD2Ojc0F4Pt/nyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJ20HHwm; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a868d7f92feso65255566b.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724307267; x=1724912067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHVY5A23Y8dwzOpFT0v9pVJprbgTbddkPeBrxq5dkIA=;
        b=mJ20HHwmH3Wi7ktyk38Vi4OG0lYhoMeZ0X1DGlQWCNbAVZa6fNeYPplen6RQ9LuCMT
         WNk/pEZ+PZGU8m/LruwN2z6rlJOHfW1ZMcG2tjbN1AUqi9RQaZQYTG6FGsqBvhbR5iF6
         CfZs8crGHgwgkoIb2EGCcWxk0O0kq9YH8dj7uqxQIrlDyGpWUNT7/UlH7XnzFr9e/RmZ
         PisclOgYOTvc8ot8BVaHuZL430KgNuwX2Gv6M7/qcALfJI4eth8eq0mM6P7sVTOVfMlw
         fgjIZji7RWTWspubB0QgTaTt5YKr2ZhOOvqwwL+IglOKESPSD2M0tcHlO8NSasQOi9Yt
         gN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724307267; x=1724912067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHVY5A23Y8dwzOpFT0v9pVJprbgTbddkPeBrxq5dkIA=;
        b=EWLwo7p/nc0IL7L1aCoCTPEtDcofsMUj2pZLqkqY1M2wEVmiuC6HDZSm9xuOSCk3Mb
         TX9xyrINdP6K5YRQ2F0XPxnL+sk5jjZurYPSIHfblBUFOhCU/c+fpTz51rTeYGdbmtF4
         9j6cc0wzdKzR1fRwEVliRU6BMlKw4f4NW0O7MTvjNoM4jdk6HnF3+0bsJphveAKLeiP7
         JmPamz/E+zIifFbrX/1KN+M4O95baW6AZvbaj+jQhhlesY/VGcuqxUbnii7/H6zk6LTN
         RPWEX7LnfAgBDE3BUvFpWVZrsDq6ycOoEgkIiRE1cPGK4nBiu23Y5K8wqcPQEBWV5xKu
         6a2A==
X-Forwarded-Encrypted: i=1; AJvYcCVFLjsNnmTeEOUs44eeG+kpy5i13JBRQ7kXYnm8AXlPbQeSH2FtqYIOhDcg9hwT1EpdhipEtqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzquweGNcM7rt/DLLiH1xwNNZudlPe2FqtwozuI5BL434LFTceX
	macqbJEkbL6ZbRT3yFHzAzVwSAx64C5aDMzuHtVRusLwJc4sRw+vj5899Mrgh9DymcQjfjcAU3a
	rblQYWT1IExlLD5GXhClKpc0MdmvF8ettrBj1OlVtiV/MfzfN+Lss
X-Google-Smtp-Source: AGHT+IGkLdWFXeWBo7YlNuCirWCunCos803uCba1zpN6dzXrFxr17xPZiWKxAd6Tc75MZT0p4qHJOxRwWMdf0abf0H8=
X-Received: by 2002:a17:907:7d9f:b0:a72:9d25:8ad3 with SMTP id
 a640c23a62f3a-a8691abaf76mr63888666b.9.1724307266605; Wed, 21 Aug 2024
 23:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822033243.38443-1-xuiagnh@gmail.com>
In-Reply-To: <20240822033243.38443-1-xuiagnh@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Aug 2024 08:14:15 +0200
Message-ID: <CANn89iLbLv0P_cw99MiXVjZ1N2xOqzTemPxFkhBgtoWHty7otQ@mail.gmail.com>
Subject: Re: [PATCH] net: dpaa:reduce number of synchronize_net() calls
To: Xi Huang <xuiagnh@gmail.com>
Cc: madalin.bucur@nxp.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:32=E2=80=AFAM Xi Huang <xuiagnh@gmail.com> wrote:
>
> In the function dpaa_napi_del(), we execute the netif_napi_del()
> for each cpu, which is actually a high overhead operation
> because each call to netif_napi_del() contains a synchronize_net(),
> i.e. an RCU operation. In fact, it is only necessary to call
>  __netif_napi_del and use synchronize_net() once outside of the loop.
> like commit 2543a6000e,5198d545db.

Correct way of citing commits is to use 12+ chars of sha1 ("patch title") a=
s in
commit 2543a6000e59 ("gro_cells: reduce number of synchronize_net() calls")

Quoting Documentation/dev-tools/checkpatch.rst :

  **GIT_COMMIT_ID**
    The proper way to reference a commit id is:
    commit <12+ chars of sha1> ("<title line>")

    An example may be::

      Commit e21d2170f36602ae2708 ("video: remove unnecessary
      platform_set_drvdata()") removed the unnecessary
      platform_set_drvdata(), but left the variable "dev" unused,
      delete it.

    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.=
html#describe-your-changes


> here is the function definition:
>  static inline void netif_napi_del(struct napi_struct * napi)
> {
>         __netif_napi_del(napi).
>         synchronize_net();
> }

You do not need to include netif_napi_del() in this changelog.

Please send a V2 in ~24 hours and add this :

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thank you.

