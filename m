Return-Path: <netdev+bounces-166149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B61AA34C1D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67A5164DA1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1085621D3FC;
	Thu, 13 Feb 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ECU7WBy3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502F28A2D6
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468339; cv=none; b=m3ChK3+gQDZFv4Li07hUNemmn7PGebqGWQKgjqvJYDAGK3wrHnjkhoBX3eFUD3WkcNr3p8vCTiXADlK/hKdBXY2p8Ns5h/ODuEMZP1P+QiN/VokoGgldUKpy4PtxSkGIXdpUSd7/QKdi+Xdfzl0hK3xo+nZeMM+HvlKoIzVEZb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468339; c=relaxed/simple;
	bh=b7N+8dSPQ0OnlGTOQ+2/iyi4f6259SWAIHYoRWb24J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ognIf/x0RhkXtmoCwbsv+hkYcIBDCvByxln81zraR+MzcMJRilXFuid0MvGnT6WRZBv3tN84ouzIueQW3l3WmlPucSoCuBMCUH5nDAePeS9j95mJEWBeXeVa8XhKha4ghN4V1AtHvm7RsfHvPILy+0IjwAbgvkBpz6h8nBYdJ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ECU7WBy3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c8eb195aso22067175ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 09:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739468336; x=1740073136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLC9kfYPwLBjTLU9fLAjv67CM2H+dgqHjhipB5hFLZc=;
        b=ECU7WBy3jbHPomLP0Xv0uYG7Q3Uwur/tm0kyRQqp1L0sCK3uTarWXuth+a+LOA4Umw
         brm3i/Kbk3Vk7W8H4zDLq4Q1KDeVz7TDOn6nyJ0Vyx+UXJHl1q8INHTYUENkFqDu5bgj
         SabyGG1Yp9h18+gTUcWsm7IM+4/kyExktlqaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468336; x=1740073136;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLC9kfYPwLBjTLU9fLAjv67CM2H+dgqHjhipB5hFLZc=;
        b=ovSkzA9Jjr4XQoym0WxNjzV1+TNnWs3RLQmOpEu9GmBX63EIfNdTvx78EMx9RskGd0
         KRYjcqHICdhrDqNNN4H/e1tb1p8AGFpMYYJ1MioyjMaoqqF6MxmVJFj0VNzBhXcchN6w
         V+R3dlooQ9zKCNZv1tQjfZik6AOvU1Nnkb9PVzKwfygoDtB+XroQ2HsGHQJ2Xe+9bG5u
         S94vS3dSznKLaKZ1QvuoG9hXVqfpUI7k6IWeiRTAWcU68IUc2dtFGOXWMYYOYsSdv4no
         KoxHtbX2HFlsb1Uf0AjbkU1oTmOFWEfPU52qsfdCqDtdue1ZAOEeSTTZRd37qKGcND/I
         RAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1vuoZLv9CLmJvISozSycK6ub0ON9ZjEtL5TnVgJnB6lkeKuIb2q2pRgRi0x1uC42EGh1Gyvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8g5SuOlL1XjqrIcu1ecLSHD5z62UvqjZ12kN+eIoW+8CmqGu8
	MLf0w66fHw/km/UB6esXpHBFRTJ9TcEudvfrTbTRy0lfhYlfyxl8oZ4X3VHjeUw=
X-Gm-Gg: ASbGncuLnq+R4oRbS41ZDdGZbMhNl03eO2ZyTSRn/5+q3nEJEH2DX5gxeMdVFojiOgO
	hriPgBZ/+LpDgkWmSo8KSh1+KkO3glKTS4tKTInbfbtf1XWpg2esOAx4fT+PkdTZqnuK8jygyFU
	Zz5Wgh/ag1Vzvy/dQ6VnXG6ukbDwUk3IB6vB1bFGnyzA16upqrVUPGw/sWIeFUL88rKijn6YeXu
	POxkwQLgiI0du8qyammyKkeZvHqrzcDnWnwmTS850hljrEPD62QWNaMjOWUNkVyuuIEeCzucbH0
	ytKQCCHRLBHENVoJQw7XZ1fzY4aQi9Vne/sGGvcX0c4Y4yZp7skRNs0IwQ==
X-Google-Smtp-Source: AGHT+IHKx7UoBaIYvNAKG4jbdIsvHPKTWLspdf35/yTjPBwhkv4ORzitL5INUVr5HwUTUERzhGKRNQ==
X-Received: by 2002:a05:6a00:2e1c:b0:732:1ffc:36f5 with SMTP id d2e1a72fcca58-7322c374111mr12059457b3a.5.1739468335955;
        Thu, 13 Feb 2025 09:38:55 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e4casm1588770b3a.103.2025.02.13.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:38:55 -0800 (PST)
Date: Thu, 13 Feb 2025 09:38:52 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	rdunlap@infradead.org, bagasdotme@gmail.com, ahmed.zaki@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] documentation: networking: Add NAPI config
Message-ID: <Z64uLN63gD0nNvk_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, rdunlap@infradead.org, bagasdotme@gmail.com,
	ahmed.zaki@intel.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <CALALjgz_jtONSFLAhOTYFcfL2-UwDct9AxhaT4BFGOnnt2UF8A@mail.gmail.com>
 <013921c8-1fd0-410d-9034-278fc56ff8f5@redhat.com>
 <Z633ggyM-F2pfAkG@LQ3V64L9R2>
 <20250213081418.6d3966af@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213081418.6d3966af@kernel.org>

On Thu, Feb 13, 2025 at 08:14:18AM -0800, Jakub Kicinski wrote:
> On Thu, 13 Feb 2025 05:45:38 -0800 Joe Damato wrote:
> > On Thu, Feb 13, 2025 at 12:45:01PM +0100, Paolo Abeni wrote:
> > > On 2/11/25 9:06 PM, Joe Damato wrote:  
> > > > +++ b/Documentation/networking/napi.rst
> > > > @@ -171,12 +171,43 @@ a channel as an IRQ/NAPI which services queues
> > > > of a given type. For example,  
> > > 
> > > It looks like your client mangled the patch; the above lines are
> > > corrupted (there should be no line split)
> > > 
> > > Please respin  
> > 
> > I must be missing something: I don't see the line split when looking
> > at the original email and I just tried applying the patch directly
> > from my email and it applied just fine.
> > 
> > Are you sure its not something with your client?
> > 
> > See the message on lore:
> > 
> > https://lore.kernel.org/netdev/20250211151543.645d1c57@kernel.org/T/
> 
> It's also broken on lore.
> 
> The first diff block starting with the @@ line overflows and gets
> broken into the next line. All lines within a diff block must start
> with a space, + or -. The "of a given type. For example," line breaks
> that.

I see; I think it's this oauth2 helper I've been trying to use with
my google cloud account. Arg.

I'll RESEND this and my XSK attribute thing, too, which for some
reason isn't on lore but is on other sites (like spinics).

