Return-Path: <netdev+bounces-101811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B295900267
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD312B24244
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB1218F2CD;
	Fri,  7 Jun 2024 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtAN/qcn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0216F291
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760374; cv=none; b=EMx4254pTqCEGt55IDze1NF5b+akHP5C5t9pmLZL+Sxopxo/0WKhZX7wHWtotolYuYFoPYvJRwtoJ0JL01zWUrP3+pMZEW1mvdCEeIV7dO2AtqeoD01eN5D/ieG/3m2EHneB5LuIOOfBsY5Yp/sv/glQzU8c8QCp0gM4mESBQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760374; c=relaxed/simple;
	bh=6IcFBeGOmMU0mlJLVRdfi1IeUB4kOr6g9k2vecqqnzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzlqvAxhBAKM/Y9npygv0Ai/HZtYJKfQHPaY6bxda1+LlfbkSXKGn08tmgx2vJTXKi47vFx8yZPNhCTxZTo3OiLLhYqqVXi67oPTm2v20NDaMRhMArtVcDLB2aicdiJ/EMA9il2kxnvfU2XnH3AvokMM1ACWR4a/hIap9lE5T5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtAN/qcn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717760372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dgCqQiZrPgEbTsv1Zj+TQ2nCf5rtre8ULR4hCF5D6v4=;
	b=HtAN/qcnEWEf3Rskt/FaMMQ/3LIeitkgnsqOSBn/F3+2VBlpaGzocj7Cd2T69sVPjGTCh4
	jftxFDDxi4cvGw9OGqwFoCWOK82kOsFu/k5vH9YKGOQAmemLKyn65jAjFOELvi7t6zleyO
	Rk22+IgH1kEwAvtccE1i+jUHN+LasVw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-8N2MCtKxPLulaVH6kaeNWA-1; Fri, 07 Jun 2024 07:39:30 -0400
X-MC-Unique: 8N2MCtKxPLulaVH6kaeNWA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42158087ac3so12355545e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 04:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760369; x=1718365169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgCqQiZrPgEbTsv1Zj+TQ2nCf5rtre8ULR4hCF5D6v4=;
        b=Y3ohnRThDTy8iSCg0dMYcTtzkX1KAP9eDIL7QphcQgPHJAJFN07KYy8MXpn8tMPAQn
         BCs1pDT0ALaz9f8BosIoImDngmuvhmySSA1CPqbxJkr+8ShO2bmbZEWl4OMKCbelJe/y
         qhLHhfGlRAOyTHc3Qkhjk71rJq2SOfe6YUn68Mmh99QMYOTQdOvqxp4Jdsyi3ufNJwJB
         Gr2qUEt48GfgqqNyoRsx7tKlpY09BSkYyoTwbPvSiBZ//Pa/8yt8qRZ2oX7Y0u0CavUJ
         WCA3CzzytvLO60fOj9Bh8Hnzsx0TNA45czPtAoWBkSj/93AWKl9vmTOKxT9fmjIlFZcP
         dpcg==
X-Gm-Message-State: AOJu0Yw5Qjk89pOU5YLI2jEW2ROeGp59puiPXJ84tBo1ppGeQ0xjP7rb
	pjjlflJ0VRge4FwWPXG7NFt3/Fu9DNV/nKzJYInPvQIWOJyTBx+tdLdAXuonu36snfapZacg+8w
	BTdpTpjZhGJzJnzrydNcCrGyjuLfN0a9NlcKFG0sEF1eGdIFhJVYJIw==
X-Received: by 2002:a05:600c:354e:b0:421:585b:8322 with SMTP id 5b1f17b1804b1-42164a033f0mr20916175e9.23.1717760369595;
        Fri, 07 Jun 2024 04:39:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWGZ2Kso5ljNBXpmJjqCrnvji9O0i+xuGCDvP2I5qwGgac7E4O6v7DbYKVUc1Cyxn2hpx2VQ==
X-Received: by 2002:a05:600c:354e:b0:421:585b:8322 with SMTP id 5b1f17b1804b1-42164a033f0mr20916045e9.23.1717760369252;
        Fri, 07 Jun 2024 04:39:29 -0700 (PDT)
Received: from debian (2a01cb058d23d600f69755a50586e491.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f697:55a5:586:e491])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e567sm50824615e9.1.2024.06.07.04.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:39:28 -0700 (PDT)
Date: Fri, 7 Jun 2024 13:39:27 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stephen hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH net v2] vxlan: Pull inner IP header in vxlan_xmit_one().
Message-ID: <ZmLxb0EdIIm2+DOe@debian>
References: <a5a118807f06bded3feea4ba35168e9240c31a3b.1717690115.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a118807f06bded3feea4ba35168e9240c31a3b.1717690115.git.gnault@redhat.com>

On Thu, Jun 06, 2024 at 06:13:59PM +0200, Guillaume Nault wrote:
> +	if (!(flags & VXLAN_F_GPE) || skb->protocol == ETH_P_TEB) {
> +		if (!skb_vlan_inet_prepare(skb))
> +			goto drop;

Obviously wrong. Need to rest, sorry.
I'll post v3 later.


