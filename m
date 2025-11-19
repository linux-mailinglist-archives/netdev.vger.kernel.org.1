Return-Path: <netdev+bounces-239755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF705C6C2B9
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B70F94E70A5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 00:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D4218E91;
	Wed, 19 Nov 2025 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXWJiPPF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4620298D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513398; cv=none; b=Hb3jimDKyP+7XHpb+Sh4LcLthXkGqarZHXRhslDL7oozzcUEe9Bidjy0izqaVixaltNUYuCfyr+HvTsNO9Km7QwWmCAeg4i2Idy8dJ29XmTFvSRJ/XK25e9yXMjKnUzaNqos+XvawUcNVBgBlnMUZXqm0FCPrBkRUt9c2ZW8CT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513398; c=relaxed/simple;
	bh=oKXTLH9B+kZojIKvhH48FM80MY3iGUiNLr6BAXfHHf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9Y3DE4CSEZ4MMisS6opRR8bzyQICIGD6WCBPKjGFVoToGg+qcvVxqSVayE+CURsvR1HptOwQXnfXyaHpYpppJp3WiDT/IK6OuXPOPEVVKBrg0nwt2QHfvEiTf98MK2VZUl/+nO5CKxlYa4FVH+a/VKgy0wrdqlABRQff+LL9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXWJiPPF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-343514c7854so354712a91.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763513396; x=1764118196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1JZP4mJOczUNP4pl5LS4F0RC54qpkfUlqRw4pgbJgQ=;
        b=jXWJiPPF/UyM0htAyQWXtj40Uto5qRz23YbBn/9oqGsaRuEGDnXuQ8Kd0EFJHaBELl
         TsAbquFUn+QQLSYHIcIAzij4QUoIjTjZ2DOoYzdmY2eKInS0w6FS1fFNZKO5IRz3RwmM
         NgGJ4yLsxL7rbywK3zRyPFGMYLEYerSAXw879U8rLCWj6QYkTISG8yWHgNy4EwYsjsgA
         zY+67FuqJG7aRkJzTUyIg50qC44GUGYgol2YVXkRlNp0i4iNlkwFwmDhiHOv77hNxZso
         LmXpywxxpl1QkOwDDyIS/AK5m8VnKqbc8TwrBYYM2LTt5oKz2pIOduQLk666eR9IaTM6
         3sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763513396; x=1764118196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1JZP4mJOczUNP4pl5LS4F0RC54qpkfUlqRw4pgbJgQ=;
        b=LH6m+4Imf6pYGzxh/HDiDoQDZ3vjcDW3tUnnp6T8MqFjoiTWKSZ1nvuMpJqRQh92/P
         cpspfgC+mkfPK/iyoNJBi3femdqvBQ7o/9oN0POpZ4SgYj6oORUktlD9CmaKdYlDl8HH
         LIqIv3IOrgr+GSTJ7ewpp930S/evrMXaWPX/pN0Xx6SNwmkbGUMxwFQLeSMoS/mAUNDC
         96o8jiKtr/HJArSMWGFWJTP22ZBsUa1dtdUNnWdM1igOryUnvr5H6BmsuuYGY1Wh78Bn
         lCI5Lw+64GXZs/uj6WHvdgg8mVIxE6O+0mj4CB/r984FdwlfLNpEsvFzCsegBT3+Jo5B
         Ui0g==
X-Forwarded-Encrypted: i=1; AJvYcCWOQLpbWzjsrSGcyGWGFglkgiX0Exkam71czkZqvs+CvY/GTEJ3uP4gM5PTq993nVRx/xiL1is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUfAdMQHE85SZNT/jR03XZ+ptWsPoCZBDdtlz7FWj6gT2T7Gz0
	GM8P3bvT73RJaQD0Qa77RtenqVq0tXvS8pJnYkAjD6V0A9aAuxkpbKPI
X-Gm-Gg: ASbGncth2LzQfJw0nNkYZOKCOcYjJm7HtJUhrmiWuoXVHfMX0IqjW68IZ2IQHsdfxi4
	2JY9a+AVFUkgFyYJf9XkwwTUixvdIo+ODZsyPXoCei4kjScr27+KtPQkBvEK9Qz4j+WvapQ1/n8
	VOXxX/GMRDukXSFLKmqLFR8Am1gM8wAc+O9RHElsZkzDu5pZaWjMUd1khlU9cPWZqwDw5numZyy
	/G9xGyY4DAkI9AM+M/8Cl35HXJIT7ajX38TagH5YYuwy1KlwAxw8j2rmnBXRL+ZXeL/nr9SUblu
	GRZ8opRkpRgeXMBORE6hvomGpPVQdRBDYofRgL+rF9xP07K0z6fN0J4l9YCCxDJDDnctP6S7hK9
	eUJYoA1m8EXezC2kBeghFNHNoiV99cKfB02gXFFB7+VCet2SSr0BLGag4ar1EY/4PIm/W/DIr2v
	XEF9pCmOCCBVqSt08Kgs60HZRw1BQUjfA2KWug4A==
X-Google-Smtp-Source: AGHT+IE8JxmF1L3MBeFjrjhCVliPKr3nWeWpK8dN326PMLP1SXtwFKRVIWLKhkDIZdOHuuTrc26bbg==
X-Received: by 2002:a17:90b:1345:b0:340:29a3:800f with SMTP id 98e67ed59e1d1-345bd3038cemr513343a91.15.1763513396057;
        Tue, 18 Nov 2025 16:49:56 -0800 (PST)
Received: from lima-default ([103.246.102.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bbfc8d8esm704033a91.2.2025.11.18.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 16:49:55 -0800 (PST)
Date: Wed, 19 Nov 2025 11:49:44 +1100
From: Alessandro Decina <alessandro.d@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net v4 1/1] i40e: xsk: advance
 next_to_clean on status descriptors
Message-ID: <aR0UKHeilBX5oTg9@lima-default>
References: <20251118113117.11567-1-alessandro.d@gmail.com>
 <20251118113117.11567-2-alessandro.d@gmail.com>
 <IA3PR11MB89867864D4ED892C677CA8CEE5D6A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <aRy+xA5xSErIb61j@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRy+xA5xSErIb61j@boxer>

On Tue, Nov 18, 2025 at 07:45:24PM +0100, Maciej Fijalkowski wrote:
> Repro steps would be nice to have, rest would be rather redundant to me.

Yeah unfortunately I don't really know how to _manually_ reproduce.

I don't know why I'm getting these status descriptors, but I'm getting
them reproducibly every few minutes on ubuntu 24.04 across 3 machines
where I've hit this bug/tested the fix. The machines are doing ~300Mbps
of UDP traffic, some of which is done using AF_XDP. The AF_XDP code is
TX only, so it's executing the build-skb-in-zc-path all the time as all
the ingress traffic goes to sockets. 

If you have any idea on how to reliably produce the descriptors I'm
happy to give it a try. 

