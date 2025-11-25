Return-Path: <netdev+bounces-241537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A5EC8568A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977C73A8269
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392F83254AC;
	Tue, 25 Nov 2025 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0ilBhc+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lZSpnCes"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0D32548C
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080742; cv=none; b=pJk8hsya07FVro9y3Li5FWQyvDrpC2hc1r61Pnrq1A0vX+1Wo1EVkIFASjE+Y8koqO58XyyEb5kR9jjKTwaFdB7ebfUYRVhJxvKiThKjInbgVlDA35hU0kGblGKTyAHYIWKbXzVqlPr7cMtXudylqYYom+SXzMW6EiY3UX6jeXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080742; c=relaxed/simple;
	bh=qVH4EgDap5qTz2I7vTky5yddvl4rhwAfwva1oxLfzPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKauEPW8WQoKBj/Wu/JNgqqR7TX0PJrKJUl6W9gBJcS884ChZLfdOsFnYZKtLIkg4txB6+wYjgxEqq9eQnBdJeJQIeRNytltVwaVYzGTCY54uemRO6tOJJ/lzB3VVyEsCDTBpv0Htq89nj6JlaRzOafDwBMTj29iySlT+ee8qSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0ilBhc+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lZSpnCes; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764080739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr0i1Bnz9J7tkbwtcawYQEZH/SpsaGOcMG1YHu/LOuk=;
	b=d0ilBhc+guYx11fJTXH/XA7hkZ1oT+HVaf2ssoxo+iB3F+mfqOWjC1ueYVgm7PXFLhUz8b
	BGACnewmmkikJ7Sx5TNzj7Nr18k89z7iaM1TEcUVz6+YQ/+ewTyg3YsDD+W1HCAJHX6rTj
	9JmtEvLOCkrZtnlWZ4ZaY2zBvcavPUI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-fp6g-O10POOG5JOZPtGosQ-1; Tue, 25 Nov 2025 09:25:38 -0500
X-MC-Unique: fp6g-O10POOG5JOZPtGosQ-1
X-Mimecast-MFC-AGG-ID: fp6g-O10POOG5JOZPtGosQ_1764080737
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2ad29140so3170096f8f.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 06:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764080737; x=1764685537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr0i1Bnz9J7tkbwtcawYQEZH/SpsaGOcMG1YHu/LOuk=;
        b=lZSpnCes+51fxt4Q9Ikd6RiFKJ3O9ooFzfGY2mgdbH02TPiRfDAe30dueJmlKy83G/
         wxq9HZum93R30w2oBhxxJuDXK1khWo2/+qwFxUyCUn1EfClGAYmWgeucwknhQIOuNlHv
         CiOcuAlwUVJBwwu3bfoCBPSrTqgD/XLdK68sGZ9tVOkm9XGkgUFSNjuaKx6Nw5DKX4+y
         FERYZo4iErBC+lcYqqfLZMd2z3mL8IAAK6Bb9P1RMX0SRJNgXgDwFWxGOQ9QIrR0UFSk
         B6qLqodvnBlTY+uPhVWQtT+MyMt+Hb9PL/y4XGrKLYTB4WpvdGlWfYppYg2H7qCwxM2S
         OeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080737; x=1764685537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr0i1Bnz9J7tkbwtcawYQEZH/SpsaGOcMG1YHu/LOuk=;
        b=B8gnzhrQigcTtZ8OPHlGYFtH4zeZD0o7qNzbts0hQZMS8c53DNZn7sPqGIzhEKrSHI
         NIFQjkzF+Md0I1QSq6lpYAW8g8c50M4RaoJgUQ1eWlqkWgF7lUMknzVf1zh9ZKQdG4A2
         uuwKuCuErf14IekSSYrhOoMiPfFxLPbRtWByrz1A2wCxQIpTeHiX1AH221VpLKGz7ibX
         EcB7Jv5tiX3ZQUZ2G90BNcXN7hVEXID++A/za1kDxpJOEaqrBtzE/ziPoWydUkWTiLk2
         cKq5m0+H+xMYpA3cbZMAT7gwMm/4QMB6RHLxubrk2LXCPFaKi78n7Xczb7V22w5Ki4vt
         X+pA==
X-Gm-Message-State: AOJu0Yx1jUsDPYAwWVuux4dXS+XOywylWwOuMasgU74k37MpckeKoarn
	5yY2Y8yvv+krRvYg5c8LuSVLPpvzfjfKpyuJ6Hq86Okn3Hpjk67OM9vNIbyS63mBqI1wsCUAxiJ
	v8zJrT6dQLSI6yQDVoFcW5LZbDsLvTMIT+Gy8YFzXfclQLeCPfX5/bHJm2F/70R+hPA==
X-Gm-Gg: ASbGnctEhGQXeRMybcgMOUk2TS3bmWvDMbzNrzhDqevPtL0Wl+azi7dv0ZtPTBx2mdP
	2bbq7pJcsh70D4Dw07nbemfrwVGtnQPhNcYMbBR7vqmY+9pQUQbF9fW43K1x14X47E08XOWBnVp
	rcBin+2JK/2kTZCZZQzxaOXarWjT6Rcjthdup9xW3Ej25HmGxSPZQBzwKo757wi5hRIese52Lvs
	VK+4HHzqrSweuoWVrSfH33tNStPDxOLUYoETABXfR2LvCSXS1lj23a89DD65vYZvAFfhjcN32q0
	eiHCJBmDBD3IKEXh4IfL8/7KwCxSfnCyq/0xVd9oKdzoyadqC9oS+sEHK/u1JqniOxXq0He2x4c
	N3BmtAdnvdjLBCJd5wAlcGdvCQ1eVMQ==
X-Received: by 2002:a05:600c:548b:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-477c01c4c03mr159629705e9.23.1764080736778;
        Tue, 25 Nov 2025 06:25:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGWUY3ORBZQM8nQhsClHy4gnQBeQmJgXaZyttfwnGynYrZLxOGj2nr3DxzGuetAdDy9u3GgQ==
X-Received: by 2002:a05:600c:548b:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-477c01c4c03mr159629425e9.23.1764080736339;
        Tue, 25 Nov 2025 06:25:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf355933sm262722995e9.2.2025.11.25.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:25:35 -0800 (PST)
Date: Tue, 25 Nov 2025 09:25:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20251125092418-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119191524.4572-8-danielj@nvidia.com>

On Wed, Nov 19, 2025 at 01:15:18PM -0600, Daniel Jurgens wrote:
> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
> +				       struct ethtool_rx_flow_spec *fs,
> +				       u16 curr_queue_pairs)
> +{
> +	struct virtnet_ethtool_rule *eth_rule;
> +	int err;
> +
> +	if (!ff->ff_supported)
> +		return -EOPNOTSUPP;
> +
> +	err = validate_flow_input(ff, fs, curr_queue_pairs);
> +	if (err)
> +		return err;
> +
> +	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
> +	if (!eth_rule)
> +		return -ENOMEM;
> +
> +	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
> +		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
> +		       GFP_KERNEL);
> +	if (err)
> +		goto err_rule;
> +
> +	eth_rule->flow_spec = *fs;
> +
> +	err = build_and_insert(ff, eth_rule);
> +	if (err)
> +		goto err_xa;


btw kind of inelegant that we change fs->location if build_and_insert fails.
restore it?

> +	return err;
> +
> +err_xa:
> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
> +
> +err_rule:
> +	fs->location = RX_CLS_LOC_ANY;
> +	kfree(eth_rule);
> +
> +	return err;
> +}


