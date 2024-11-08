Return-Path: <netdev+bounces-143241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD689C18C1
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 10:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74041F25847
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747471E0DAC;
	Fri,  8 Nov 2024 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="MlPkkLpg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2B1E00AC
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056827; cv=none; b=HMrDXO+4ZqwoWu7OSsKic5oi77CdIAXyl7k/glFqqG44sVyg9oBuoxgrdy8XpfRxjuf6q0crGjlux/21DVyFXjV4Gg+Zmw8vK/bjGKpU6vVTHkbsLrglGPD1yi13qEmBAWnxYesHleH14gvXFBEFflocIZGqFw/cy7OUIxux/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056827; c=relaxed/simple;
	bh=tCRTECuS56PuG0XEhbPkWcB/4w7m3WsRYVRHywqp/mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOMRRFubacb95jtNYLWrJlZJwIJj2gAsmgIrICsRjNHLcDvlp0QkRmEP7k/qEcVB6uYNEiHXy1H4mIFvHLrULNQgk8DFIgNnED+OzSbdJjreXl7eewZQkJfk0uyU58ALP9SVB/BmhQuU3mMludlce6urhhG8D7uRBoox1M+YuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=MlPkkLpg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e4e481692so1753322b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 01:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1731056825; x=1731661625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=44W+od+4Yj44lPCffhrCXmOWnGyYVQpu4XgVvCES24c=;
        b=MlPkkLpgSosJb6IgmfmHVjZzGWpWDjipU3ZqOkQNMKaboMaZQYfEUVKBGcZLY972/V
         ox5J5mxyjAV8AdD49lOkGaW7YaCz+UGcGvaAb+mUG75k42vZygRFF2r1GwdKSm0Ju45/
         Two6B1eGRrFtzZJUkuwKYrSyp2CaPcnawHHq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056825; x=1731661625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44W+od+4Yj44lPCffhrCXmOWnGyYVQpu4XgVvCES24c=;
        b=lrRR9eL8KCCpwCL/6FjYZG/IDViTPm/2y9umge4KVm+cZVor5R1gHGN5l52hZbJEHg
         l0nnbkuyGymA5D2Hsk/vISUF7XMRyWBkYlIhgK4dK8TMZsFIfZmoX8d6BoccjO4fmKhs
         5EMjhD01uKL2Nvo0ZQXJXI5zGUMTlwlxANlyI1Ky0YaB15q4TCeHIUmp+jUOvDDGrYfG
         Ib+0mbv/wgpoGXZwffvqevcqfmHlwYbXcx+JNINpMEu7zvkdIBZRNfS34Jo30Od8I/27
         G504m2toh/jCv7LsDOWjgMAgEvzGKGb7icRaF/4gbsgSIoAxLXspTVxU5kk4ZAIIhcMY
         w3DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUzM7Phbbg2Dxr0jt1yklb/f/BOaeWSeGRyl0rvYvlJQy/bumia+NN0MAvs6+GV/bUGI/76ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFu/asGsBbjndSkvpcM++xv7EhNJj/hhRWwRdeYqjoZYItzGDA
	VDDVR38XP9Lh/rXGrR51oTSrUWl5MQDxlF3VTLVkZZUJ8GQAZCAn0efgLbwk1IU=
X-Google-Smtp-Source: AGHT+IGs2h9aoaNLPBgS2eNHAD6WOasiHa5cVuBEaFX3KEKt97iNL+blz8xVKFhfPMU3uRT2FvPq3Q==
X-Received: by 2002:a05:6a20:9146:b0:1db:eb82:b22f with SMTP id adf61e73a8af0-1dc2289cf20mr2498608637.5.1731056825165;
        Fri, 08 Nov 2024 01:07:05 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a151ddsm3224445b3a.146.2024.11.08.01.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:07:04 -0800 (PST)
Date: Fri, 8 Nov 2024 04:06:59 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <Zy3Us4AV9DsgWAQO@v4bel-B760M-AORUS-ELITE-AX>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
 <20241107112942.0921eb65@kernel.org>
 <20241107163942-mutt-send-email-mst@kernel.org>
 <20241107135233.225de6d6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107135233.225de6d6@kernel.org>

Dear,

On Thu, Nov 07, 2024 at 01:52:33PM -0800, Jakub Kicinski wrote:
> On Thu, 7 Nov 2024 16:41:02 -0500 Michael S. Tsirkin wrote:
> > On Thu, Nov 07, 2024 at 11:29:42AM -0800, Jakub Kicinski wrote:
> > > On Wed, 6 Nov 2024 04:36:04 -0500 Hyunwoo Kim wrote:  
> > > > When hvs is released, there is a possibility that vsk->trans may not
> > > > be initialized to NULL, which could lead to a dangling pointer.
> > > > This issue is resolved by initializing vsk->trans to NULL.
> > > > 
> > > > Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
> > > > Cc: stable@vger.kernel.org  
> > > 
> > > I don't see the v1 on netdev@, nor a link to it in the change log
> > > so I may be missing the context, but the commit message is a bit
> > > sparse.
> > > 
> > > The stable and Fixes tags indicate this is a fix. But the commit
> > > message reads like currently no such crash is observed, quote:
> > > 
> > >                           which could lead to a dangling pointer.
> > >                                 ^^^^^
> > >                                      ?
> > > 
> > > Could someone clarify?  
> > 
> > I think it's just an accent, in certain languages/cultures expressing
> > uncertainty is considered polite. Should be "can".
> 
> You're probably right, the issue perhaps isn't the phrasing as much 
> as the lack of pointing out the code path in which the dangling pointer
> would be deferenced.  Hyunwoo Kim, can you provide one?

This is a potential issue.

Initially, I reported a patch for a dangling pointer in 
virtio_transport_destruct() within virtio_transport_common.c to the security team.
The vulnerability in virtio_transport_destruct() was actually exploited for 
root privilege escalation, and its exploitability was confirmed (Google kernelCTF). 
Afterward, the maintainers recommended patching the hvs_destruct() function, which 
has a similar form to virtio_transport_destruct(), so I created and submitted this patch. 
Unlike virtio_transport_destruct(), this has not been actually triggered, so there 
is no call stack available.

However, I still believe it’s good to patch it since it is a potential issue.
Additionally, the v1 patch only exists in the security mailing list, which is why it might not be visible.

Best Regards,
Hyunwoo Kim

