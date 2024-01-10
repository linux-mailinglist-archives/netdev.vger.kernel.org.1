Return-Path: <netdev+bounces-62948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBA782A07B
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 19:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108591C22752
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 18:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97E14E1BA;
	Wed, 10 Jan 2024 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="agndYZKA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6D4D596
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55822753823so2208078a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 10:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704912766; x=1705517566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3UJsqaOgk5eE2VQnILkdg8C0bn7x8fx0mLavVcEL4o=;
        b=agndYZKA9aFBjYetBEHyOJEqNC4/ZqYEI+sXSPBEd24W5OwAzQdjFOazoQYnOa3DB5
         vgwD1MymR8H0L6YH8nUM2w5wpulEc7r8PIfGAT8aPisaKdb53fW159Lw1pCP9qnq+amp
         eFYhZJC1b+pYtSW3lbzz70xYostfTE7A9ncA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912766; x=1705517566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3UJsqaOgk5eE2VQnILkdg8C0bn7x8fx0mLavVcEL4o=;
        b=rd72/Arkd3pufb7ZdrqGS+5AOlKkkGhkBw9ZMaOL2EGHYDy785ABwsLz27aYgJQJdH
         E1GBligch4t9zakuZP32HNytqeK5L6ah0OUD/WaszmZiiw0GsqhceBaLFiADWQ6hWh0C
         +tQJin1+B2SZnYH8gW80IGZTLWqG+F1PIGfYuCW/+2OKAaiRDym4j3Okn45bWq42EN3h
         R0cBHbsQ8KLgKPeSIqnJS7BV0v1zHt4cUQ3Edwx7QDKA8yorQ6h5+Ir+NUKq21hZEEcB
         W6kEGjoAjmDEGN5+SwzNiWvXdO1uk5eNIgy0zs8tSnEITv6cKJLftItyhYaiWA0MAgv0
         WDeg==
X-Gm-Message-State: AOJu0YzYWPncqSGEYhzV3d60PNFoS7tJ7DOK+v3FCrbUwKyl0LnS31cT
	OgFsOqtgxh/gIaW6D3jsEtf3+oHFZ26AXsNNm6pewk6MHQTN5lUQ
X-Google-Smtp-Source: AGHT+IFkUYLkpK4MYP1jJ9eygAgnxtEPDv87RixusTSa6BlQYsN79UtiklOxzQhl8LUqNtAOAf5GGQ==
X-Received: by 2002:a17:907:1b14:b0:a2b:1e7c:ee43 with SMTP id mp20-20020a1709071b1400b00a2b1e7cee43mr684148ejc.146.1704912765764;
        Wed, 10 Jan 2024 10:52:45 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id f11-20020a170906560b00b00a27984bd831sm2322955ejq.163.2024.01.10.10.52.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 10:52:45 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-557ad92cabbso3987869a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 10:52:45 -0800 (PST)
X-Received: by 2002:a7b:cb45:0:b0:40e:4ada:b377 with SMTP id
 v5-20020a7bcb45000000b0040e4adab377mr402184wmj.62.1704912744493; Wed, 10 Jan
 2024 10:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com> <CAHk-=wgJz36ZE66_8gXjP_TofkkugXBZEpTr_Dtc_JANsH1SEw@mail.gmail.com>
 <1843374.1703172614@warthog.procyon.org.uk> <20231223172858.GI201037@kernel.org>
 <2592945.1703376169@warthog.procyon.org.uk> <1694631.1704881668@warthog.procyon.org.uk>
 <ZZ56MMinZLrmF9Z+@xpf.sh.intel.com> <1784441.1704907412@warthog.procyon.org.uk>
In-Reply-To: <1784441.1704907412@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 10:52:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyG8BKKZmU7CDHC8+rmvBndrqNSgLV6LtuqN8W_gL3hA@mail.gmail.com>
Message-ID: <CAHk-=wiyG8BKKZmU7CDHC8+rmvBndrqNSgLV6LtuqN8W_gL3hA@mail.gmail.com>
Subject: Re: [PATCH] keys, dns: Fix missing size check of V1 server-list header
To: David Howells <dhowells@redhat.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>, eadavis@qq.com, Simon Horman <horms@kernel.org>, 
	Markus Suvanto <markus.suvanto@gmail.com>, Jeffrey E Altman <jaltman@auristor.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Wang Lei <wang840925@gmail.com>, 
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-afs@lists.infradead.org, keyrings@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	heng.su@intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 09:23, David Howells <dhowells@redhat.com> wrote:
>
> Meh.  Does the attached fix it for you?

Bah. Obvious fix is obvious.

Mind sending it as a proper patch with sign-off etc, and we'll get
this fixed and marked for stable.

           Linus

