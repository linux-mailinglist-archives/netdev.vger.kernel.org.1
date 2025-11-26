Return-Path: <netdev+bounces-241803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 503EFC8861C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F993356D25
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1005A31B119;
	Wed, 26 Nov 2025 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7DH7HOr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBNTWf+F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1E031A554
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764141326; cv=none; b=ULF0Shrz+PPooxWMg96DM8syhSy2G6vUrtoqy2+z9c6u/cb4+OHsDDaYmrV4HTcxsrc3/AVvaNsDMSKRuDt52/6nhRN2/4chdDZFvQfqL2hBFSkReJkbZ5qNMrdHQfm4aDQnMA8hMNJ17yWtiRC9nMf+Mp0D1fBbhVx0t+iDf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764141326; c=relaxed/simple;
	bh=mkf/uHCKMjQSjVKT+d3VdATYkS+teAGvnv+BKYIEsOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXSHcPg0y00PUTxXHcLTbuxYiIEYSy7Pd/A1JkryiXKhdQO368gu+B7DDwXm970NhI5gzw61sudIBTTKRN3ehNCcNSJeTlVkimRvEDnu9h425XBfSg4Au/oRPyVfQ80oo6MAC6BYs77a7W6lH54RC5T0w1lggjstwIbecLsihYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7DH7HOr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBNTWf+F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764141323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCcjoQrJmDMV6tt4i7nrzjlVcToLbxZK4bwTpqKMBw4=;
	b=V7DH7HOr/VDeygDbFjG3MNWLmhYOECemDM+d8Q2yFu2axuL0wN8NYMHirk98LEtP/jFOk6
	1F8E+6H3YpC1HbKdNw0UNGbBIKcGVcHWt/v2oYuxt7lZmiu4Z3/ir4yqTjFUlwd8bhwHAM
	Jmf7olQKEgWsJVDZ/IiKKzPvFXWaBBc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-igz4T5nxMJqSeW9oFr6dzQ-1; Wed, 26 Nov 2025 02:15:22 -0500
X-MC-Unique: igz4T5nxMJqSeW9oFr6dzQ-1
X-Mimecast-MFC-AGG-ID: igz4T5nxMJqSeW9oFr6dzQ_1764141321
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3155274eso2860254f8f.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 23:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764141321; x=1764746121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCcjoQrJmDMV6tt4i7nrzjlVcToLbxZK4bwTpqKMBw4=;
        b=aBNTWf+FRh9H73ynMEQPJvV4QlzwEYW+cZkwLPE8t+Jjhz6WVAiemC8nNTesfDbKnQ
         b3vWRUNDsmsRIP5ztUGUx4Qb6FS5JOisofV4BYvVNLONmdqkntT7crOVU4VGauf6ZMNc
         NNCozMQg3Xys1W9jiXR3e9fGDJag9KA0TdtDmkWw9xnV1uxpxCp2+NKsiX8+Jq72eXAD
         KT29gGwoSGuatF4lv0fCqbY8cJqS9CECFe3jvg71sb4V3KcYDPK07/NK+FSmPCURRRko
         XG6muxEWW5kSYExyDXF2JrawtbngLdZPU15qlWAWNuEq5eoBzqqakCmUGX9zpKII/Ece
         pzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764141321; x=1764746121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCcjoQrJmDMV6tt4i7nrzjlVcToLbxZK4bwTpqKMBw4=;
        b=UJCJHjkurctR9m/SoMcvSss/7YJY9s66Is267zdg36jfLk60VFuWk5bt02aHfUpPJb
         OpSWSR+d1ZfxEZOjjyiq8JmAY1xDuiEm4NeJ3e5keVE83rJmByHCojJTmYblCHGvC+gd
         /6BflK0iHPNx2R49gLUP8mFVqa1XSZfZWCxc2/tAr/0gYFq2zECtsY+ZqdlrGrRVqFHI
         l+e7uZXp5HD+3YIEKaw1Kg+ro6qKzM/JyvO6fsI6ZyucBw/tEkJx3JvF496Tay3fJTJe
         FgyKJ+kGF6aHzJc27dv6+/NWBTDXcyohfD4xbRtw4HjdFEtxDdf4OgbInzv6pFYQQSqk
         55Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUrSA3+b5s2GV/7V6wUyG1TO5UsuZls0AlBo79sMZ8gthQMYCNKZxjwX8Kgd4Zzb8BxpoRwyQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUXuwgPV3OQUyojmVMEbq5RZ7nh74aqsptvYQXwxEz/Uj8H9F
	5PE8F3Tnyhu+zADrfd3P9XNkkb4ULkj7XgvuC9Xeoq2spaupk3Y2zfq6iyMDgTzbvVGhMARj78m
	zDWx8XtB53dSFaV/s0xuCg3EHN9p3vx9qQ6aCc7GL7fqUa2TkY2GMjtSI4Q==
X-Gm-Gg: ASbGncvCi8xsr+tT2VQigGhVM7JzQoCjteJacAtbwiQM9EnC0rO6Wgm/Ca5oapSxiv0
	fuuU/u26j0Z7dNSbaGbocgpXwyU1Vy4FwILUkolboqTgTexpblUlnln/GeUz0vj/nXPEQmJQjoX
	YTON8cisoDknqJ4FuDDOHBDDz12nV/k+jStGfzx9hOFZLRFqLoFJYA+v2NvQaNn6JQJbUFmOigT
	QIbYFLJDguB9jsquAkkEhUdcKCb1k7jaXde/33lpGMi6coVK9XftsAgjWrrI1m/qmulgggVr6EX
	IW4/rZAd5AIkti5yypdY9KyID0WwssltLlrkaLzqUotL6UPwdmktW6XrKRyJlDja0WOB7/uark4
	j6Z/UgyPtMj9/JiliIOMDvoW0MY3LxA==
X-Received: by 2002:a05:6000:40e0:b0:42b:4081:ccec with SMTP id ffacd0b85a97d-42cc1cbd1b9mr17399194f8f.18.1764141320718;
        Tue, 25 Nov 2025 23:15:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxNo/Afpg3Lg6XEk3Ct+TLvZVCI8wWmYfzMD7t72pHQNYX6jVKGgWygBu70JI/2p3ZTBPPRg==
X-Received: by 2002:a05:6000:40e0:b0:42b:4081:ccec with SMTP id ffacd0b85a97d-42cc1cbd1b9mr17399153f8f.18.1764141320200;
        Tue, 25 Nov 2025 23:15:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363c0sm39412154f8f.18.2025.11.25.23.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 23:15:19 -0800 (PST)
Date: Wed, 26 Nov 2025 02:15:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 0/8] tun/tap & vhost-net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20251126021327-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <CACGkMEuboys8sCJFUTGxHUeouPFnVqVLGQBefvmxYDe4ooLfLg@mail.gmail.com>
 <b9fff8e1-fb96-4b1f-9767-9d89adf31060@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9fff8e1-fb96-4b1f-9767-9d89adf31060@tu-dortmund.de>

On Fri, Nov 21, 2025 at 10:22:54AM +0100, Simon Schippers wrote:
> I agree, but I really would like to reduce the buffer bloat caused by the
> default 500 TUN / 1000 TAP packet queue without losing performance.

that default is part of the userspace API and can't be changed.
just change whatever userspace is creating your device.

-- 
MST


