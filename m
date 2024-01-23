Return-Path: <netdev+bounces-64976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF5D838A27
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 10:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D29F1F287A6
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA095812C;
	Tue, 23 Jan 2024 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cctQuNzx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD35811C
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001568; cv=none; b=FNSltKTbi3n/Od4CHCZkKYSolAhoXu0YrcExbpym4RKiyDtiOTODizdcmCRhardFEulLKpGcmPk+j2oWOsO1FSEeR96NeZQD6MxGm7mSk7gEmLhPaEsHO7dULlzh4FaTS4vO9DLrSszS2muuCMRqKoZ//jxHFlVzRFzkgSTREEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001568; c=relaxed/simple;
	bh=Oe96ZS0GPl0X+zRqT4zGY+sZnanqBu2NiLuNscH7mA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCv+mc3ShjRyBCeJYpSPG7cYDRQcqKah2BxvmSr7nz70pgKPzZGW3jjcNxGhf+vSsu7Q5PQQ7M8nDc7A5C7Jcwn+TQdgoex9QC2lYE9v311D9JvLKRifdwZ468qGJ30w4s606LB8vh5jboIz6AcTbkpr1i75ce77TzowHpo1+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cctQuNzx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706001566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Oe96ZS0GPl0X+zRqT4zGY+sZnanqBu2NiLuNscH7mA0=;
	b=cctQuNzx3BU06u45R1QIyca4AeZ8ujR3m504UqGbAoGE3319PEpTSdrcL31dJFB68+sinL
	cKxxORBOJmUpbnRQ34OaKjo3iz3IMOg7Iqn+KwajMaiObcbeyifvrzOEKC+zpUXpHXsCUu
	xjR/W2nyWodP2XOXUPX30DtpY63LjOI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-JiFTH-2rNaOaq1ING7z1CA-1; Tue, 23 Jan 2024 04:19:24 -0500
X-MC-Unique: JiFTH-2rNaOaq1ING7z1CA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so11689715e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 01:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706001563; x=1706606363;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oe96ZS0GPl0X+zRqT4zGY+sZnanqBu2NiLuNscH7mA0=;
        b=RfUkuOX6qsBXMdpsJQmZPvYm0kaqfRNdAD9l5d9iA8rWbpcC/oM6QmMJqmUtaq1Ic+
         wQV68irOhqutCOoMbjYvx8iaCoh8zS5eB5ixkZ0WfcVgwW2vvbqV7Snj+qRP5oTk/n9u
         yUEZlTEcsG9MAeoQqX+JlB1HCqqAd+07QDsQ6KQDEZX6aqlcNBk4KGFvGWNqsXI9aMpw
         5aeZdyNU4OsG+JF5cdf+920tNc5Sg/iDrkGS2iJCZwVcOZLssasQlyNqtTM1CrfYEOuw
         ZesfrdKjofzx0wauiVsUatQYiYdqUuxiJcFxwf/Nt+CjiUYOHsnTFL9/dXTjC4h4CUu+
         4Lxg==
X-Gm-Message-State: AOJu0YynbcpUQudKhAwLkTPc/E5mbpkgiNF6QCc1jgwFQCkvmxRR6y4K
	r6jy9gOTB1egtsQVmAtvsn4Fwm/FAvWdPt5dotrbmP6dKnHNHeODP+wO6HJuVvP9BV0m7Y+fXwJ
	b8QAizONQOdsy/r+uoh98TzGMB1O25FPF+UgZWK0ks6OsIS9oEwLgdQ==
X-Received: by 2002:a5d:5247:0:b0:337:3cf6:ed4c with SMTP id k7-20020a5d5247000000b003373cf6ed4cmr6304455wrc.4.1706001563505;
        Tue, 23 Jan 2024 01:19:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC7J4/5vcMAMnaTNN+lNZtA37/6QPZwsSE9no3/79fSWNyQBHLCpJsKgRkIlzsIC6k0QYgEw==
X-Received: by 2002:a5d:5247:0:b0:337:3cf6:ed4c with SMTP id k7-20020a5d5247000000b003373cf6ed4cmr6304443wrc.4.1706001563118;
        Tue, 23 Jan 2024 01:19:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id q9-20020adfcb89000000b0033931b609ddsm5671463wrh.43.2024.01.23.01.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:19:22 -0800 (PST)
Message-ID: <5532f8bea2241004c279bc6226a0f37df2720971.camel@redhat.com>
Subject: Re: [PATCH net v2 1/2] Revert "net: macsec: use
 skb_ensure_writable_head_tail to expand the skb"
From: Paolo Abeni <pabeni@redhat.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Rahul Rameshbabu
	 <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Jakub Kicinski
	 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Radu Pirea
	 <radu-nicolae.pirea@oss.nxp.com>, "David S . Miller" <davem@davemloft.net>
Date: Tue, 23 Jan 2024 10:19:21 +0100
In-Reply-To: <ZazklN6D5oAio6J_@hog>
References: <20240118191811.50271-1-rrameshbabu@nvidia.com>
	 <ZazklN6D5oAio6J_@hog>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-01-21 at 10:32 +0100, Sabrina Dubroca wrote:
> 2024-01-18, 11:18:06 -0800, Rahul Rameshbabu wrote:
> > This reverts commit b34ab3527b9622ca4910df24ff5beed5aa66c6b5.
> >=20
> > Using skb_ensure_writable_head_tail without a call to skb_unshare cause=
s
> > the MACsec stack to operate on the original skb rather than a copy in t=
he
> > macsec_encrypt path. This causes the buffer to be exceeded in space, an=
d
> > leads to warnings generated by skb_put operations. Opting to revert thi=
s
> > change since skb_copy_expand is more efficient than
> > skb_ensure_writable_head_tail followed by a call to skb_unshare.
>=20
> Paolo, are you ok with this commit message? I agree it's a bit
> confusing but I can't think of anything clearer :(

Yes, I re-read the relevant code and now the fix is clearer to me,
thanks!

I understand the intention is to drop patch 2/2.

Could you please confirm that? If so, I can apply 1/2 without a repost.

Thanks,

Paolo


