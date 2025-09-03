Return-Path: <netdev+bounces-219648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F2B427BC
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BE63A9F2B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8846029E0ED;
	Wed,  3 Sep 2025 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmXuuKxh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1FC242925;
	Wed,  3 Sep 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919814; cv=none; b=tQyD954w44snsdQepVf9CI2jXlf05quCRQ32hRPhJXKpG/RQ6KXd+76OdZmbLZcb7UAECpaS/QH6P8QAfE/IdsunKlY3iKdLFjfDvOWfZ4m8mivnZFt6eccJQU1cwkJB84/fT7tSwx3HT6Tocf1/guwFe71IQc0N4ysbf44eG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919814; c=relaxed/simple;
	bh=ZJ6DzOKUfHZ5IofQc/gAACB4SYGhZXU7IbTqulvb4aw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=COa+wAtdiVTVmef6pXDKTjmhNGsJYhm09KJFy+qeAtrZqEJazPMrNrCARAJeqP6nICVA+V8u0F/QBX3pT00WaJ97cJKmCOmcuCjWKkxWZiiaGoC/BmIh9imdV0FvDCkoIYKgSeGx94Fv3/H+vgYNNZqD5fJ8jMXWCfLxualDFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmXuuKxh; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109c482c8so2583331cf.3;
        Wed, 03 Sep 2025 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756919812; x=1757524612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWlwFBgNWMjfUe6WnDjCIuuCR2uq0Rac7cIQSEflAow=;
        b=NmXuuKxhFkweiPk5+yXt54el5zR9EtBHlAiAxYS+JlCphP8hNLuirLG7xw6rdL0Gnk
         6UHrOcCfM2xBZhekHdDt4f3A5kD2d8cOm0kO2PE3ryUvCOeVZrqf001uuWxzEQ8mNdYU
         6Y8l9QK1qs+3+lVcnJgv8897p27TfOHWvGMmLU0aaNaxMetOi3xmmCs4rvh42H2QGM1d
         D5Dr/Fq6B+kRHwXg6C8PnEwWc8WJxMYKXjB48/WkT7CW9hLAMcsqNC6WyEvVIOLCjwGD
         Xkto36k4g3oeJntbO+TkqQikiM9sYJa1cqlPsmPAhF9jYeP3NIWphUbmywg0YIhxEgsp
         NbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919812; x=1757524612;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AWlwFBgNWMjfUe6WnDjCIuuCR2uq0Rac7cIQSEflAow=;
        b=IzMX5WmyO3FRr52oHZUfMA9XjzZInxHA8wfr1QCyuKF6V6W/Kh8DVFtcDVhgOucnvq
         USQXL6vCJiNrxLnplQNa5/Pzx3tjX6go6Bhes3Jfuiqr/LaoVa2fyyc8ztS/OoHgogic
         7Hk1zU3ADp67FCnu99LUSBJ8mSfmQVYMLhWr9Qy7ePhLOlU2Isv82J1Il4V+f0EoRvV4
         /ZRUzi4jXirqxj2okS+++wo3t9MZE2kFzhf1aetzt42gmA3GKdOJTrt0cS4cmcnt1Lb+
         CAlLel1VLP27qi4nbECkc7WreDUIG/sx6KFxVlqBPfWsPqxIkFb8xVmSP5KOuv4jIANv
         g5GA==
X-Forwarded-Encrypted: i=1; AJvYcCVld4nMEH3oniKRLqN2fdQSY5Sb5j0sMKSmP8EwZnvBonvu6fE4WdZlVErMgI69kixT9OJdygyx1CZrdKU=@vger.kernel.org, AJvYcCXawkslCsPN+yfc/E2izHk/p89/Tw71Xx5qhYaIz0q7kyhgrEvJPVc65yRUFzG9B3+SGvibEBu9@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXJoOYnynQbkY3SPkkBYLgdNL6PK8QAi9MQFIsoGIztverxT6
	DrtnWQjEeiVuoE0/YgLIDmrApDs02FEgL2MTIRCG7pw/7hO//ttCB/TZ
X-Gm-Gg: ASbGncuqm220zHd/GWhSKmS5gsF+vFNODumofI9rWYF8WAGE/Ty4ORVyvmYgXIU7Wbk
	LEGFB2pFP/wO1DzCcTrGKU//nWKvuUpiADXPhvuCHP/NlVDVkGx8Vi6pkRtDr5mQ+UJD+ySgNph
	+1NF/laInAaIhJzxGJ0ALZ6m39uBn6j8SaTIhJK0JToQRrJwRwFbweDQX6TTZKfj+jzmi247tvo
	46TPvjZIPIHVGZcrNlzTOlki8t70LmFrHII2gbttrX0U8ANPvB/J5gulyTt3MPOh+Mw3cDC05SE
	OxwflIGLktm1kANbQFV+Za7JFlqZdh2vKr5RNvM1d1WWfi4pm/dkfkinobs8hAWzYQSvwSvJig6
	HWbGfu64XRHRyRASDDV8WQH+k3h1KQjQTGDArwZUmopPEM9UW4NLyj3CizTMt7KeetZOKISeQn+
	8Tfg==
X-Google-Smtp-Source: AGHT+IHQeEGvElRE3Z4ZiEhlcG0xfeqMhZUV+xEqkDaUsSNp4u1kO2SKqlQm+fAc1bfWx9X2QI3Egw==
X-Received: by 2002:ac8:5fcb:0:b0:4b4:9773:586c with SMTP id d75a77b69052e-4b49782a0ccmr25315751cf.66.1756919811605;
        Wed, 03 Sep 2025 10:16:51 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b5d57c6cc0sm1491041cf.53.2025.09.03.10.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 10:16:51 -0700 (PDT)
Date: Wed, 03 Sep 2025 13:16:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org
Message-ID: <willemdebruijn.kernel.3093d8d8e5831@gmail.com>
In-Reply-To: <v4bz7lyzs6f6mlfhvgy3p34sihu6sojwntbev3hz2sz425j76i@wanin427lov6>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-4-51a03d6411be@debian.org>
 <willemdebruijn.kernel.9ee65133b4b7@gmail.com>
 <v4bz7lyzs6f6mlfhvgy3p34sihu6sojwntbev3hz2sz425j76i@wanin427lov6>
Subject: Re: [PATCH 4/7] netpoll: Export zap_completion_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> On Tue, Sep 02, 2025 at 06:50:25PM -0400, Willem de Bruijn wrote:
> > Breno Leitao wrote:
> > >  include/linux/netpoll.h | 1 +
> > >  net/core/netpoll.c      | 5 ++---
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> ....
> > > -static void zap_completion_queue(void)
> > > +void zap_completion_queue(void)
> > >  {
> > >  	unsigned long flags;
> > >  	struct softnet_data *sd = &get_cpu_var(softnet_data);
> > > @@ -267,6 +265,7 @@ static void zap_completion_queue(void)
> > >  
> > >  	put_cpu_var(softnet_data);
> > >  }
> > > +EXPORT_SYMBOL_GPL(zap_completion_queue);
> > 
> > consider EXPORT_SYMBOL_NS_GPL(zap_completion_queue, "NETDEV_INTERNAL");
> 
> Thanks for the suggestion. First time I've heard about the export by
> Namespace. I suppose then I need to have
> `MODULE_IMPORT_NS("NETDEV_INTERNAL");` called at the caller side, right?

That's right.

The feature is fairly new. I don't think we have clear guidelines what
is and what isn't in scope yet.

In this case, it seems clear to me that this API is not intended for
broad use, so falls well within the area. More context in
Documentation/networking/netdevices.rst


