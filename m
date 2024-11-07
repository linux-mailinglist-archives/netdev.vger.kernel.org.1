Return-Path: <netdev+bounces-142767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB48F9C04D9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E923B1C23241
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B5B20F5DB;
	Thu,  7 Nov 2024 11:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A32200CA0;
	Thu,  7 Nov 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980222; cv=none; b=Hrvx6gDlOgxrFBDrDUbvregLXS306q/ooeVd7oQELFa2w5/CTrBp/tmnfDWs6HRbJYEGTX598re4oW1q9U7ng1JeIe1IfFqeVkJXwhfyao53YmJ3pfLE7LjBfRN1eyS88Y+g1dI0oB1KKP0FlIGPhU+z0N4DatCznopdvQD91vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980222; c=relaxed/simple;
	bh=LjR7RTOP3486ehrvrXHp3B5cS267t40opPrfmboYAc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs9VtwhCfaKZRUJQO799brOtRDMswf4wS+sdDS86HNmIHSM248qlCLdiun/bLjfYl4PRd3puS1oAxe0J5jgTTyM7VcGmaTq6vkWQ03nnHghl4nfxsBRLmPWmGIkiya6ufIu058X2upWk6WGLoDD+wswcqtmW/bmpGveMGQEm+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99e3b3a411so338455466b.0;
        Thu, 07 Nov 2024 03:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730980218; x=1731585018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV2XuAhWZw+2BqCqnWE0dJxK5O/efvkvyQFZddPytP4=;
        b=Pmu6ULcUcQwyuBhXqOJGYKZXub37zTl0jqic7Yqva0mb9kDbXb0vAztX+Og0iYRaS0
         sCTfMf6ueJVd2m/eG6UXzNSwqdPWAevvuigQLIxEtLPDqNQdJsQiqCX0/zWNIxCiIpPw
         R9FdfbVU7p2ZKyLaYeyM+xl/WNAwf+9H0sRgmC0jZ2M7XFH+SgX2T+EadSHRUuEXRiqj
         GjMCw+myYfPT0UBPG36R5T/fiUb5h+LCwOWgxIlH7X+nrVBvvWC98UOoA5hHvSEG+7ii
         ktv8W5edNXgsI/+uRzlHxK38bxp5dPQyEXkMn5DLN11Ohy+dZAvtnjekbAUpJUWviO2Y
         e20w==
X-Forwarded-Encrypted: i=1; AJvYcCUzstWDxXXAlaNU0IZ6/RZtypWKNsKOtqfT+yIHt+93YpzIKdpnlX+wvTRQ9ioJR7VnnS98r3SrZCFP1+A=@vger.kernel.org, AJvYcCWmGQT6WGXO3soMqx5oHsm4bPde+ewvdXCnnGvXGT53B8lK3N0tiiOPpMXkfZYNJjt4hxhWd+di@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxSsJLdApRaI98qbmkTYhTP+D4LPpPxGV74jylxByHXKrphZP
	uPUV+GupTe3cFAGbLlL3VFgqutfhVIuQlpGGDWbYscIACJm8vgWL
X-Google-Smtp-Source: AGHT+IGvD8q6JlwJ5GJ312xV1CwjVkICfx1Scc+L/B2EuwKSC6Q/H8VbT1jiSu+432bE+QpWFp2yag==
X-Received: by 2002:a17:906:7309:b0:a9a:616c:459e with SMTP id a640c23a62f3a-a9ee6c615b5mr83356866b.27.1730980218458;
        Thu, 07 Nov 2024 03:50:18 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a18854sm84646466b.29.2024.11.07.03.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:50:17 -0800 (PST)
Date: Thu, 7 Nov 2024 03:50:15 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com,
	jiri@resnulli.us, jv@jvosburgh.net, andy@greyhouse.net,
	aehkn@xenhub.one, Rik van Riel <riel@surriel.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 1/3] net: netpoll: Defer skb_pool population
 until setup success
Message-ID: <20241107-interesting-observant-manul-564fa2@leitao>
References: <20241025142025.3558051-1-leitao@debian.org>
 <20241025142025.3558051-2-leitao@debian.org>
 <20241031182647.3fbb2ac4@kernel.org>
 <20241101-cheerful-pretty-wapiti-d5f69e@leitao>
 <20241101-prompt-carrot-hare-ff2aaa@leitao>
 <20241101190101.4a2b765f@kernel.org>
 <20241104-nimble-scallop-of-justice-4ab82f@leitao>
 <20241105170029.719344e7@kernel.org>
 <20241106-gecko-of-sheer-opposition-dde586@leitao>
 <20241106154349.0ebca894@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106154349.0ebca894@kernel.org>

Hello Jakub,

On Wed, Nov 06, 2024 at 03:43:49PM -0800, Jakub Kicinski wrote:
> On Wed, 6 Nov 2024 07:06:06 -0800 Breno Leitao wrote:
> > To clarify, let me take a step back and outline what this patchset proposes:
> > 
> > The patchset enhances SKB pool management in three key ways:
> > 
> > 	a) It delays populating the skb pool until the target is active.
> > 	b) It releases the skb pool when there are no more active users.
> > 	c) It creates a separate pool for each target.
> > 
> > The third point (c) is the one that's open to discussion, as I
> > understand.
> > 
> > I proposed that having an individualized skb pool that users can control
> > would be beneficial. For example, users could define the number of skbs
> > in the pool. This could lead to additional advantages, such as allowing
> > netpoll to directly consume from the pool instead of relying on alloc()
> > in the optimal scenario, thereby speeding up the critical path.
> 
> Patch 1 is the one I'm not completely convinced by. I understand 
> the motivation but its rather unusual to activate partially initialized
> objects. Maybe let's leave it out.
> 
> The rest is fine, although I'd invert the justification for the second
> patch. We should in fact scale the number of pooled packets with the
> number of consoles. Each message gets send to every console so system
> with 2 netconsoles has effectively half the OOM cushion.

That is fair. Thanks for the guidance. I will keep patch 1 out of it and
send a v2.

Thanks
--breno

