Return-Path: <netdev+bounces-136958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762DA9A3C38
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54F1B2143F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA74202654;
	Fri, 18 Oct 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmEbsZcN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C312202642
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248744; cv=none; b=Jr2JQtx19qcLPZTTKg5ws7SQhZl+aes476mjQe4Otltrg9cdmcAEl4tH1eK3hG2wTYEHp7jKxZx+Iv2mViNXkDaVtGzb5pLlwxdCmal+rp9e9ADUbjqTGqIyHiU/9dqCUQGSG8fVKiIIRLTbmPLOVKE8fP1sfDdpdTQaKRB3UYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248744; c=relaxed/simple;
	bh=hlo66ijJb/Cdj770+zC+26WFSb2kI1W9QVwVBxx18DQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYgWGeTDBQCZaCK1phsMngog+tqTvANrUXm3CPUX+W1C5T/4gduuckievq/x1o8WsW2BBUOSm1kr1hvKmoUfG85R2UGP9z6IvL/bwwMmEH1NoKEn60HOhdytTh5t7eXssIHal99iRc0Ddy3uClpnBPX2S73V0zxoznK/M7ZQgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmEbsZcN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729248742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlo66ijJb/Cdj770+zC+26WFSb2kI1W9QVwVBxx18DQ=;
	b=bmEbsZcN86sM4xyrCE0ADC98o7Xzw/M+FWFOi8bF+fFVf4xzzCCN+nUsiO1Bpl/KwLR4y0
	ho7LupfUqO2lHOdSraGX8P+TzXiNuuBSB/3Ot3n/Zjs1pj+RuNnl6aWkwJxbX0sIrTubFs
	Nd9F7zzdPeHiapYDbRoBkDzRvFbGNRc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-rmYe0ykIN0mkOXV1X3wOMg-1; Fri, 18 Oct 2024 06:52:21 -0400
X-MC-Unique: rmYe0ykIN0mkOXV1X3wOMg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4608a1a8d3eso41581161cf.1
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 03:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248740; x=1729853540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlo66ijJb/Cdj770+zC+26WFSb2kI1W9QVwVBxx18DQ=;
        b=AILVD3ulzaDS3Gv+JwN+SaiijBMlxoKu6jUEEgm1lqjriqxBOunB8t7G/Eso5TUy37
         2BpIByzaz9bpJIrHy2aJ/dhdzS7XFSAKnfOwDzgLAVBHOMB7EJXIc48pdFc3hBm8lJpY
         iIXJSp2AWHBiFGIUZaJDICNRuglzjJYyOsFHA/37NsqvzNQE+pJxWI777zZLcb9nE/QT
         53oIWI54IUDhD00q7yk5fjGy4MzemsOOaTdTiVtZaJW7Q8ubZH7p338w2NjFuBpr6j4W
         5pQn5svJOyiz80duWpzZakob36aIv4nepuonn99adE2lVxnZG96AAK4Z27MUkqAUyP5l
         Gf9A==
X-Forwarded-Encrypted: i=1; AJvYcCUgPTmhzT9BmVG3ZPuTf6A2XQIHVn9Y+IO2oJJnf9qQ92oWIxmm2nooHJOwmrFZddF5tCMrubs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy06oR9EthTD2FavM89g7ThPLt6CK5cBl5iibsCw3dGdyen7Gxn
	DQ8nR864ajFTgps9I29DMJCpxia5aB5tE8uP8wYFMpn52TZyYFyl/0nLZvYs6RppW4I5VzcSSnR
	aaObZ5FqKGkNF+iKaglx4TJKjDwydDdQiaCO4dE206HVgO4CECDB5TA==
X-Received: by 2002:a05:622a:4c6:b0:460:927e:c245 with SMTP id d75a77b69052e-460aee14cfbmr30643831cf.4.1729248740427;
        Fri, 18 Oct 2024 03:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEItGrt1ABtCJZWw3PgN20DLJ0r2+a0t2Y2RjfBNB5gtKNiYltQvcJbpnnnEkYFE0v3Vlk5hw==
X-Received: by 2002:a05:622a:4c6:b0:460:927e:c245 with SMTP id d75a77b69052e-460aee14cfbmr30643441cf.4.1729248740071;
        Fri, 18 Oct 2024 03:52:20 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460ae971993sm6164351cf.38.2024.10.18.03.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:52:19 -0700 (PDT)
Message-ID: <0cf0ffed63a8645c49f043877c526b2ab0abf96e.camel@redhat.com>
Subject: Re: [PATCH v8 2/6] PCI: Deprecate pcim_iounmap_regions()
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, Richard
 Cochran <richardcochran@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,  Al
 Viro <viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>,
 linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,  linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 18 Oct 2024 12:52:15 +0200
In-Reply-To: <Zw-XkFcaXjlF5az0@smile.fi.intel.com>
References: <20241016094911.24818-2-pstanner@redhat.com>
	 <20241016094911.24818-4-pstanner@redhat.com>
	 <Zw-XkFcaXjlF5az0@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 13:38 +0300, Andy Shevchenko wrote:
> On Wed, Oct 16, 2024 at 11:49:05AM +0200, Philipp Stanner wrote:
> > pcim_ionumap_region() has recently been made a public function and
> > does
> > not have the disadvantage of having to deal with the legacy iomap
> > table,
> > as pcim_iounmap_regions() does.
> >=20
> > Deprecate pcim_iounmap_regions().
>=20
> ...
>=20
> > + * This function is DEPRECATED. Do not use it in new code.
>=20
> Interestingly that the syntax of the DEPRECATED is not documented
> (yet?),
> however the sphinx parser hints us about **DEPRECATED** format =E2=80=94 =
see
> Documentation/sphinx/parse-headers.pl:251. In any case the above
> seems
> like second used (in a form of the full sentence) and will be updated
> in accordance with the above mentioned script.

Can't completely follow =E2=80=93 so one should always write "**DEPRECATED*=
*",
correct?

Is that a blocker for you?

All the docstrings in pci/pci.c and pci/devres.c so far just use
"DEPRECATED".


P.


