Return-Path: <netdev+bounces-113225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1C993D3F8
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC451C20CCD
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19617B510;
	Fri, 26 Jul 2024 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UldgrY9h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661717838C
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999786; cv=none; b=aWc20BWY3NR4k8wNNigNyR1iDRla9OD3nNdVfe9VW2RhfnoBO3ZWoc116pAn4l8i2wzY+8ADzpb4pa/75sNutshEsg175LXZ2aCtUh20pQT49YP+BeaHG8W439h9bHpxccCx3tHX7wzkf9E9x3w7QZuJ7IU4EwG+7lMuLDsVNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999786; c=relaxed/simple;
	bh=xmKf9omwUxucT1oeRkAGbgWNHALpXShtwR2JSwaiBgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=G8kjMJLZFFAQHRd0KESXgIjvtu6QSPwmkV1bQLUjbqu9CpuNanp2YVsDPqOVjG+TQYMrCxKTYn0TCgB1fCPUNxNU6LZO8Hdlf8t/T5NbjohNVG6H+rIVdVTKVAKT+nEcAicpsFU72cdI9gpVeDFJHYiog2tUW2UwWvJ1CGveynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UldgrY9h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721999783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+Xb2FoYdB0d76xIYmgmvNy/BmZ9+wOzI/YfNgYKqlo=;
	b=UldgrY9h4raN3oKBJQ1WArLmBAH9YOgPrXETU15x6/S0SvEzStRrMT2zqxvR4xCzPwkyfb
	WzDupIqjHXzhqr5oC0ZsLKl9lPspwVB0JFgtuTPHf4nMy8gckp7WLWZ/NENWZ652zT7jRz
	bZxoqv8pd5aJl6NmE7q2dRJfjNCdBDs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-CXR08z37OjCmPQYyVPPSHg-1; Fri, 26 Jul 2024 09:16:22 -0400
X-MC-Unique: CXR08z37OjCmPQYyVPPSHg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef244cdd30so12967631fa.0
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 06:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999781; x=1722604581;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+Xb2FoYdB0d76xIYmgmvNy/BmZ9+wOzI/YfNgYKqlo=;
        b=so1lIG6x7cPwmI7hZoZ0YRb0Mnbw3cV7f6sjRUptRX9vbL8xkMT+z2NeW3ashdUKnA
         /nJTBtOoJma0k3dG/lckYoCNDAj/HCQRCXE7yckcvUdrxqKsPevcjRrC8GOeTORsiVEp
         /Rr/PkF/mJsnbBlN97Fl3nZ0kC4vmmIRXxPb+Yk/wlon0rZX30/ZSvLZq+QUAN4LEjOj
         UvKM0U6LEJSjJfOBPJxGKQt1X4EssSTLPBgZOpQchtqhfd+kVlWipAfgdqOPozvBTpBo
         XzbmILj2cHHl+t0jVOZiPfHbuUUTBhozoXEbb2uyczCBkqWPWLXLC51BCT9nRUtuMvaF
         a1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb+WERrnnlctVem6lpPgatXYHoc8J9EHiFWHfrpeCUbxRWO5RtPtOeWFrjqyZQ1eAs+B+2UcErIL3fISgFiPTvbVCDvfdr
X-Gm-Message-State: AOJu0YzpwDkmNCYObZokCk8iuvxB0l82K41TmUX4yTrg2EdKcOnq2Lf9
	ya0MZ3TPnQUrtT5/T3DQFBdcmDNQ704So11pIserwijRwMoE6oBaEAWA1+DH0lcRuZbeVREH+72
	QG0NeTnBwEqMfK85blLw1p9G9vAOeM5ww/ewL3Z1Cd3c08/uCS/yrEimUzgDFBpcNtWWtENKf1x
	37X2iHULsk/mWBp7yWTLUluF2Re9Tr
X-Received: by 2002:a2e:8ec5:0:b0:2ef:22e6:233f with SMTP id 38308e7fff4ca-2f039c9862amr40567651fa.21.1721999780755;
        Fri, 26 Jul 2024 06:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENkd152LdcVGYZFsu1bzI6uLueRTD0erDZebrYWI+gUvt514koc5pNhArM6ncFt9ikhIn1ddo0wjWm/mrfZK0=
X-Received: by 2002:a2e:8ec5:0:b0:2ef:22e6:233f with SMTP id
 38308e7fff4ca-2f039c9862amr40567411fa.21.1721999780306; Fri, 26 Jul 2024
 06:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725013217.1124704-1-lulu@redhat.com> <ZqKKaLdn3DBr7WrK@LQ3V64L9R2>
In-Reply-To: <ZqKKaLdn3DBr7WrK@LQ3V64L9R2>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 26 Jul 2024 21:15:41 +0800
Message-ID: <CACLfguUORsgxmya8v2shsS5mJ3iZpxu6zv-fGsw9ZS2uwFFPWw@mail.gmail.com>
Subject: Re: [PATH v6 0/3] vdpa: support set mac address from vdpa tool
To: Joe Damato <jdamato@fastly.com>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:25, Joe Damato <jdamato@fastly.com> wrote:
>
> On Thu, Jul 25, 2024 at 09:31:01AM +0800, Cindy Lu wrote:
> > Add support for setting the MAC address using the VDPA tool.
> > This feature will allow setting the MAC address using the VDPA tool.
> > For example, in vdpa_sim_net, the implementation sets the MAC address
> > to the config space. However, for other drivers, they can implement their
> > own function, not limited to the config space.
>
> [...]
>
> Nit: the subject line has misspelled PATCH as PATH
>
> I believe net-next is still closed so this code needs to be resent
> when net-next is open again in a few days.
>
sure,will fix  this
thanks
cindy


