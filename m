Return-Path: <netdev+bounces-217264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A35B381E9
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBD3685637
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B22F83B1;
	Wed, 27 Aug 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC/vr1Am"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936F26CE0A
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296343; cv=none; b=rJqHc8bN68Gt3YE9nT2NZe5kRovSwewws3y1m23sy+lAHEVpzHyUSVGUH3gQUBQ6+w/AOzksKNke3STRyn/I541zoCYl6xkSfGXj0sexUWPb8LyE500OFkDoHIs9y3FUpZdnLOV9+Yqz8wWxg2ohXuCs8ceXUwIJJRx/WtSVdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296343; c=relaxed/simple;
	bh=em5i91KgCO7lQitRY5dCUJGGI65XF+bYlUrpaiHDZeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1Wxg9i/5z4MB9S2VvUsXOLENSEbJduFjyG74FvipdheDw0Uw2au5dSNJZ//Pe8xGhxIIFmcXmw7kUrN13B8VNvfp6p1b/ZZHpyRfhibxIsW5JGV59gBdDBTbMIKAqIS2see3DSrl17roeZ+5bTfug10deC1UtGneKoudsRw4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LC/vr1Am; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756296341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sgmik2BNlB+QkqOoR6kAjXzpUieoTAYBcBeh4XW4gQk=;
	b=LC/vr1AmkC7E3gNQWskDy2eBVNwtniZswSvZ+LtfL56HjkZxuSlG4Dm3d75kEWeNflADEX
	tJBf3cvgXfI/ZjSA6os+TiiQtI4I4qnUaAlPmqaRfsDRyH+0eT/JosWIvWnQZ/4GRZZy0J
	k68jqGDjOExe8uiS2B2aps2yQGyW17w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-R_cZmLwgPCuSjRFUb96FEA-1; Wed, 27 Aug 2025 08:05:39 -0400
X-MC-Unique: R_cZmLwgPCuSjRFUb96FEA-1
X-Mimecast-MFC-AGG-ID: R_cZmLwgPCuSjRFUb96FEA_1756296339
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e870623cdaso1420870885a.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296339; x=1756901139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sgmik2BNlB+QkqOoR6kAjXzpUieoTAYBcBeh4XW4gQk=;
        b=JywvKlP8FIw88tnOBHB0RTcbmISLkurJhJYpjMHn7AJ4HZ33MRkgQZ+KGtQqiVV5g5
         xW1QzV2j0KSGzGam5bT7Ud1kgIsDn0oRKA6JvHY9ySqOnoxfmLhu04kwK4q4xsS7D0tM
         zvp8FMM6aIEenCaSDX0jtEKg1AGJHyk9qGfpHTJ1jcSf856WOpXCzwkZE5t0HICDMAsk
         8Tx6GpRS18jdZDfUs2cCc0L1TrJEgc0E4CH7hpDTAeVfIqHmPneGDzo89gcb+HBt4J0B
         DijrY+yXn4MwcUsmKA8UXfP92L/bXFHVVo66zFghx1IJ2X/NGTqO/xmbUuhzGZp+wLsr
         yggQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4APE5HF/oAORPiBwt1PZQQ9UJHBS+3Hiv3sbjUxgEJ8tzlZN73bw7nv5Ah6ZUbjuR61NGo1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlujAlEIsfVaH1Na5FaW3zmefKvGr+JtZCdPvzfUZlhTpDkiUt
	7S1Tl9WzPll9LM6htogaxHuyzSDFGFvDePyAuwm1AAsu9Ut1HEBWnFUudXadeBbbX5KDPx71F/D
	r22qOs1vA9ukLhO6sIZF2WVvp/t+a4hOMaInpLS6TNiZvr5VKtrwz5456cw==
X-Gm-Gg: ASbGnctix6+zxQqe/+CkEP+YP82WgThikD5yzE5a3UCXfr3EUhYOkTyxUSWb+hVt7aC
	BLz6AGfIlA/ajUTCFRuO3lmSG5JY0ax3KKx963NqxFER12VhPaeN2eRXfkpe528e9VgzP3IOkg7
	Lj+2t9v1Bu64mN9SRmBspar0+QUlzk6yqaM0D91yp0QMiFBZ7dg7Q8D9GyH0RXEK8V4tbgknysX
	67mB18vpl/uT7xSnOYpTBxLUiPtBmlMSQaYOw4Xwrn5YBcAC8XzZgZV6tHMXyL5ozYzbJ+92cpc
	NrlUaMGJmKEfsKq5k96NGtaV3fxALhZbyhrn+2OVxdU83qiUg6LGaQsx7RJmmTNtxVMmeDOpbRv
	hu5jo8bpwPtHn0EGRFZs=
X-Received: by 2002:a05:620a:4725:b0:7e8:bf8:abf7 with SMTP id af79cd13be357-7ea10f72270mr2001619785a.20.1756296338901;
        Wed, 27 Aug 2025 05:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd4Yf7TbX/lq4sxxu+oMhohpG2VbEYaYVHKDLHcYCPPYVPY046nCaO+k5FWrVhyIPWO7ojug==
X-Received: by 2002:a05:620a:4725:b0:7e8:bf8:abf7 with SMTP id af79cd13be357-7ea10f72270mr2001613585a.20.1756296338282;
        Wed, 27 Aug 2025 05:05:38 -0700 (PDT)
Received: from debian (2a01cb058d23d6004bc439a6bf91869d.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:4bc4:39a6:bf91:869d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf43617b9sm846861385a.68.2025.08.27.05.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:05:37 -0700 (PDT)
Date: Wed, 27 Aug 2025 14:05:34 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH net] l2tp: do not use sock_hold() in
 pppol2tp_session_get_sock()
Message-ID: <aK70jgXUtSHIdrOW@debian>
References: <20250826134435.1683435-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826134435.1683435-1-edumazet@google.com>

On Tue, Aug 26, 2025 at 01:44:35PM +0000, Eric Dumazet wrote:
> pppol2tp_session_get_sock() is using RCU, it must be ready
> for sk_refcnt being zero.
> 
> Commit ee40fb2e1eb5 ("l2tp: protect sock pointer of
> struct pppol2tp_session with RCU") was correct because it
> had a call_rcu(..., pppol2tp_put_sk) which was later removed in blamed commit.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

Thank!


