Return-Path: <netdev+bounces-67268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B84842872
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD9A1F21649
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688885C5C;
	Tue, 30 Jan 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GR9WAink"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C781AB9
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630009; cv=none; b=AHFDS8I2xm7tjnK15SvWls9P0Xj7JGQiu7rE1RJirekYzi1SVGh4M4StrRnATBZQXzYmo8DpiwN+5fgIZrsrDeH4nrIQM2WSpfH48DxaHS1hvhi52UwABSIcjc9XKYcBsGznD+qFuyqsPlkbL1fCtteNkRmXDlMhjCC1TUiIIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630009; c=relaxed/simple;
	bh=5gq9bk2CACo+T8MhwqInhSIy3rOGWTcRWK1IgBCsVxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5TtIhOWq29yDgeSYenMrd4JyEl2LDDraQrPexMN1krbaF3BGUcMYGKmASezSvJwB7pJb79C9OuJtyqM879LGYL4eZOyTzJzNL9y0U5RQfxTqwSzaT5XYOFPAaOP0vUQxmDRppWl5QSIcsfZegjWEgUgrxdvqFRAkGok90PQmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GR9WAink; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706630007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSj1lyNclmh9b1DFiLfFnvUIxkzThYLUPlpLm9/wz/A=;
	b=GR9WAinkFlc1Al3y3wDJjnzJCzkBrKqJh6NUE2gPN7SoL7G2v9PhSE66RnTgoATvarwRiU
	VCnECWLACEvc+ONqb00FhAKeXIVpxFOx99FMiwKseCPVx8KSslBpHEDFJNHWLFBk7k2/CL
	0HSUGSlm9KtBupuAH2U2Z8AnFy7qtSk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-gYrHTOZyPEuf0DuRZKXEyA-1; Tue, 30 Jan 2024 10:53:25 -0500
X-MC-Unique: gYrHTOZyPEuf0DuRZKXEyA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42aaaba1bdbso23444541cf.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 07:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630005; x=1707234805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSj1lyNclmh9b1DFiLfFnvUIxkzThYLUPlpLm9/wz/A=;
        b=uu2R6kPbCa38t2xRdOLdiZ2KYsrRvU8vTtSXO+igm+nBJi3nSg5SxSrXKj1Ck2pUKW
         KWRzYFokrwqr7oV+yGWHptWpROpUUg/FH0phZJYrhRM7Cy67lzw5w2sZEIxB5U3Hg0sb
         ovO1UgxeIf2erQSQY6m24RpfPFR8oAyVDuZ3SwUYKGfTu40Nt0Qy8jcyFNGQSn8fqeR2
         VQilbY/SreSuKcxs8huaNmfFZQMk90PLKE35hag4TO3DDXzTFwIL1gtXmMVW2Ija8KsR
         jB2c12aedyUOu3nLGJc+PfqrhFzEyPO8uOGVf0ZyQacqhGpPf6drPu15bQsjuZdSmCNh
         2Dsg==
X-Gm-Message-State: AOJu0YzA295ty8oQY8t4pv3olemZ6Nc0JOX5tgAG9sLtNs0A+2ohO/xb
	QWZIXIVdjoql3mudQAWqSAN7IsHLJ8VhQK9qwARH+9AQZyoQYgUfN1vpubG/xRn+oDGyO+IVw6f
	fE6AyLL4q0swZ6nFGbpGg5A/dxCxJB6YoFVbK+2/ZJAxSqjiqSbYeQQ==
X-Received: by 2002:ac8:5950:0:b0:42a:6df3:1f1d with SMTP id 16-20020ac85950000000b0042a6df31f1dmr12272884qtz.74.1706630005307;
        Tue, 30 Jan 2024 07:53:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVEawnHTN95Z6HJiyigSQy1AJjcgY3k8TnIlbRXYXuot4rDh5Z3hGCkiEuIFI9fTvFfvDK0Q==
X-Received: by 2002:ac8:5950:0:b0:42a:6df3:1f1d with SMTP id 16-20020ac85950000000b0042a6df31f1dmr12272860qtz.74.1706630005018;
        Tue, 30 Jan 2024 07:53:25 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id z12-20020ac87cac000000b0042a1223cb9bsm3313663qtv.70.2024.01.30.07.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:53:24 -0800 (PST)
Date: Tue, 30 Jan 2024 09:53:22 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: bhupesh.linux@gmail.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: Re: [PATCH] MAINTAINERS: Drop unreachable reviewer for Qualcomm
 ETHQOS ethernet driver
Message-ID: <ual3c4fuuz5trgn2ekklsfeslwvswfjg5nij5epbnuf5mihfay@pp32fs6btwxk>
References: <20240129-remove-dwmac-qcom-ethqos-reviewer-v1-1-2645eab61451@redhat.com>
 <ZbkWwn-oN5wqoPfJ@matsya>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbkWwn-oN5wqoPfJ@matsya>

On Tue, Jan 30, 2024 at 09:03:22PM +0530, Vinod Koul wrote:
> On 29-01-24, 11:12, Andrew Halaney wrote:
> > Bhupesh's email responds indicating they've changed employers and with
> > no new contact information. Let's drop the line from MAINTAINERS to
> > avoid getting the same response over and over.
> 
> Looks like Bhupesh sent the patch changing but never followed up with a
> v2 for this:
> lore.kernel.org/r/20230915191600.3410862-1-bhupesh.linux@gmail.com
> 
> Would prefer if this is changed to his email (copied him as well)
> 

Thanks for finding that! Bhupesh, do you plan on spinning a v2 soon? If
so I will not send a v2, otherwise I can respin this with your email and
no .mailmap change.

> 
> > 
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> > If anyone knows how to contact Bhupesh / if they're willing to continue
> > being a reviewer feel free to suggest an alternative, but for the moment
> > this is better than nothing.
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 939f6dd0ef6a..b285d9a123ce 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18080,7 +18080,6 @@ F:	drivers/net/ethernet/qualcomm/emac/
> >  
> >  QUALCOMM ETHQOS ETHERNET DRIVER
> >  M:	Vinod Koul <vkoul@kernel.org>
> > -R:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >  L:	netdev@vger.kernel.org
> >  L:	linux-arm-msm@vger.kernel.org
> >  S:	Maintained
> > 
> > ---
> > base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
> > change-id: 20240129-remove-dwmac-qcom-ethqos-reviewer-1a37d8c71383
> > 
> > Best regards,
> > -- 
> > Andrew Halaney <ahalaney@redhat.com>
> 
> -- 
> ~Vinod
> 


