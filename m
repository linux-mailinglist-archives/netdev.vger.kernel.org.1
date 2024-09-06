Return-Path: <netdev+bounces-125904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF0A96F338
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70521C23CEF
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59921CB525;
	Fri,  6 Sep 2024 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNvEDg2O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6901CB325
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622725; cv=none; b=QVBUyE0m4z1szoeDf/WIQJgP2FpxBUolcSXgZX+LStztRimt4h68zEEUi02KY+x0qAN3MJ/aaeWGxilYlUxMXFUSA2FBE+ISEFPXOChpW9OfiPMIorNTgsLGU2UHy8edBwhrAY3HxSCqP9F4gjhSqi+PP0PKdKsJ8wUSeB1KPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622725; c=relaxed/simple;
	bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2qlj+T5Z2UU/8GOEE8wlim1c/gQ3oLK6JwXui3/0QEdWUWPNySdMjuLJ+zyGyCrGvqVDVKRoxF6I+MHGLz6/QMS1jDClxfCseo3iXfgEBUtIq4ZyV5Oi2dpo0cjrZSt3BUjAcEyiHGKIPb65KqWx7GuKpdKyJUBp6vXzO1qGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNvEDg2O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725622721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
	b=JNvEDg2OAKAtaRGouESzx3GBBJS5P/Fx2scwr76pPS7hFqMqBGg5t6K/uspFdmv60XTEVA
	Gyk+zIsi24NCZtkcNTZMLQ1HE70nABXUBGMy7adcTDwUn8CoY5SGD7hO0hIUPGzyZN4Rb1
	pzgRc2ZCF9+yEpGwB2ooAdi/w4JqFFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-0QMBD9GdOrqwaNZhn3ZqAQ-1; Fri, 06 Sep 2024 07:38:40 -0400
X-MC-Unique: 0QMBD9GdOrqwaNZhn3ZqAQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42c78767b90so15419025e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 04:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725622719; x=1726227519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
        b=iWLsuBtSXseKNWXJrj7TG3RsOvyNmOfbFQGkAuEFOcYu4uKrsAtzTicIihS/76lIds
         cW/KvPHXosGIWnyNL/M5U/NCWwtHGamTi9JB9se0yArgm9etir0sxnLlHWPrfqvHn8WV
         uD3a3pqsKELoE7sfkOjTfwCbx+0wDnqEUIsFlxM5V6rDgR3BGTnGzQtRhzvMifz4M6p5
         lZd+8QNNcGGC0keuDToQxnGD+ej1M6c0/6aEXw5uSjARwI31g7jbVA/ujYaL4DiJ8/S7
         zhpVi/eX+dkE1nSszWaY8z9tE2901mL3NoH8EFtUPmFV4Re8BsDsaZ3A2sJMhlUMDwTS
         /xUw==
X-Gm-Message-State: AOJu0YwgBzGEMt8ErNf/qT/yiB84b8w4NypyQpE55192lJO7Y9ZbNw70
	VP0qiIJspL16uKeQrKt3T5I+uvij7RXQNwBbCtLo5EoPKAU4J85mc9iqlKLhqMjHZ8M6YgXOY2F
	QQ+ygC9vi36a3FCZSP6PBzeevyVHkkpHMJo7bcwF/9z1WtX/pwMoICw==
X-Received: by 2002:a05:600c:1c1b:b0:426:641f:25e2 with SMTP id 5b1f17b1804b1-42c9f9d7035mr18302975e9.25.1725622719311;
        Fri, 06 Sep 2024 04:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuAsg7pwxpDVtdYJ/6+D+Ph/FNa76MdgLyOilEwQ/89LMv1D0nMU3M5+amZnhf14vF76nDJg==
X-Received: by 2002:a05:600c:1c1b:b0:426:641f:25e2 with SMTP id 5b1f17b1804b1-42c9f9d7035mr18302555e9.25.1725622718460;
        Fri, 06 Sep 2024 04:38:38 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05cc3dbsm17708455e9.20.2024.09.06.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:38:38 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:38:36 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] ipv4: netfilter: Unmask upper DSCP bits
 in ip_route_me_harder()
Message-ID: <ZtrpvGliOjZzPkyv@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-9-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-9-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:36PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


