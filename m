Return-Path: <netdev+bounces-163861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B7DA2BCE4
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42F0165A7B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAD9233136;
	Fri,  7 Feb 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eP1Yp8ys"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20781A841E
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738914407; cv=none; b=eUyo76cRMTnEmYaaAuLocrIgVuIL0/KAIN7iyy+Im5LpDFdnD/uE1SCU79fde9DaWcvp9/b7z35GyfkVUANe2GWFA2iTrsVHqEQrBgq7D9uOm4zIOmT1BQD3OwGLBYRjTnwjsl9fkyikgYxwFbopGILlyNDoW/gDiVpRhjy9/h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738914407; c=relaxed/simple;
	bh=4WlCS3JeXkjPmLde1zn1z87+Lbmb6/6ubwT13elmIkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfgeLcUE95HY2vH8injDBbIgMPKl6U2Y11VEVW/qcVLY1Q0K2XzAzji0PMUmVFyjorID479qQ1bQBzDsNC2FvTnj/+IV0ksGzk3h75uXf4Xnmb4oMEtpNNvm9Sw/TR1SjmzLTWIngwbQ7UGufg7dsM7sfNECb3jenWss2Eln49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eP1Yp8ys; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so17257515e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 23:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738914404; x=1739519204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XfZew55UaFAS2DkPjmH09kFmgY4u4YTpbMvFSQKziTM=;
        b=eP1Yp8yskVIPa1KcM9JosOjiaLG0bBxAt31C/1Rrk7YLr1eEAAoV6ZZmJg5amKMOqe
         qW4xvYX54kM9Ea1T4/+fIWtkg8VlcfLsCVVVs4poBe7RFgg/5fm4Ia6JruTXhWwhOD6d
         kg8CE/KHeAe7Xe/KcC5A1aMT/px9Web/0Fy4idU3gwhTro6LzDXVZEn9pxp/49QXmBD1
         ILSUsqCx1gJZiWwBs885nfAlTc2tI4nDKqYOboaxjTDpAy+RqadWnyccNtpRfiAKgBjc
         7yDCWg/tSCP7Nho7/9XBH47X0nu2MfaOWS2nLknuqhoJ8eSAEtM/ITNbY26N2JkniHVa
         swqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738914404; x=1739519204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfZew55UaFAS2DkPjmH09kFmgY4u4YTpbMvFSQKziTM=;
        b=qdPgnTsLx7mfFSH1tsDXD1eFY46d1U371YEAchmtpq7XbLZ+vsf+BTr1btx2DRPTNU
         QtSyLacko8P2jP6GDcgwERvljePlpYHR1uUC3mC/ChgY8cE8szegUP3V26eWoQQ7rhCx
         e82fHnOB31hWGkTYteWg/N3mTB3f4/5uGrVFsJFEGWPAMbvW3L3gcPhOfrUSVhbp/M2m
         60nFTaGd0CfPbU5Arn8e75FpiBvjZBI/fzFhhgFlwtY4fpot22wF0Vdj1J9Fc5IKQblZ
         vyUiNkSYeeArLYIgOrUdXg26Ej0HKpNd1CrvWMk2W2UkgfrjARFXRfy8gM5RdtAT7uIJ
         oCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXQW3un6juVVHR282Qz3UyvN/RriIFXX2EZ50/+b7+Wvs8aiabk6XtJ2d0omPrCS0rASnk+Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQnZf6ZNl9xm9R8RbYRblD0ZscntH0zoytObCpLefMkZX520/M
	52TWF9RLCoE0oP6wZMrrS/RTVxpnxtZIfL94TwqXJR6/I2k7kH32sGdtxOUTqz4=
X-Gm-Gg: ASbGnctkWFXupJPS4S4B/2yBgKd2e9u8vM0d+XGypIfRXvz5rO7m8rKOgPbKICeeg1t
	3Xk23p9+eU62vNCmAF2MEg1mwgennGDkQ6DCSHDrLkbW+W0jXumwotsQl/OXcJ/JvojgL0PWZpE
	lg/Q1WZcRBAjqv2qpKywXihgNel4bzOPDCMhnDCtN2E/1yZPhkiZNR++FIV6XZPa/3ODRDP07Yt
	uluM4mrMLmewBXl/gxnjHp95FhcgfdFCNMwJxPtx54cZnEvRdXKoMMsiy7oPoXK75V7aEmaA3MO
	JPETnLs9NHukEEnf3nKO
X-Google-Smtp-Source: AGHT+IEo2yPiCgxBsxpCRN/XebBRYuQDTFrOfCTuJ4SN+z1RTMfh8ojROe+Se5jOtplASZvtuf9R5Q==
X-Received: by 2002:a05:600c:4706:b0:436:488f:4d8 with SMTP id 5b1f17b1804b1-4392498d6cemr23308885e9.11.1738914404200;
        Thu, 06 Feb 2025 23:46:44 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4390d96548bsm80885035e9.21.2025.02.06.23.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:46:43 -0800 (PST)
Date: Fri, 7 Feb 2025 10:46:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: less size_t please (was Re: [PATCH net] xfrm: fix integer
 overflow in xfrm_replay_state_esn_len())
Message-ID: <fd6b950f-4d5f-4f8f-b248-52239cbcb4bb@stanley.mountain>
References: <03997448-cd88-4b80-ab85-fe1100203339@p183>
 <1ee57015-a2c3-4dd1-99c2-53e9ff50a09f@stanley.mountain>
 <3c8d42ca-fcaf-497d-ac86-cc2fc9cf984f@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c8d42ca-fcaf-497d-ac86-cc2fc9cf984f@p183>

On Thu, Feb 06, 2025 at 08:06:55PM +0300, Alexey Dobriyan wrote:
> On Thu, Jan 30, 2025 at 07:15:15PM +0300, Dan Carpenter wrote:
> > On Thu, Jan 30, 2025 at 04:44:42PM +0300, Alexey Dobriyan wrote:
> > > > -static inline unsigned int xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
> > > > +static inline size_t xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
> > > >  {
> > > > -	return sizeof(*replay_esn) + replay_esn->bmp_len * sizeof(__u32);
> > > > +	return size_add(sizeof(*replay_esn), size_mul(replay_esn->bmp_len, sizeof(__u32)));
> > > 
> > > Please don't do this.
> > > 
> > > You can (and should!) make calculations and check for overflow at the
> > > same time. It's very efficient.
> > > 
> > > > 1) Use size_add() and size_mul().  This change is necessary for 32bit systems.
> > > 
> > > This bloats code on 32-bit.
> > > 
> > 
> > I'm not sure I understand.  On 32-bit systems a size_t and an unsigned
> > int are the same size.  Did you mean to say 64-bit?
> 
> It looks like yes.
> 
> > Declaring sizes as u32 leads to integer overflows like this one.
> 
> No, the problem is unchecked C addition and mixing types which confuses
> people (in the opposite direction too -- there were fake CVEs because
> someone thought "size_t len" in write hooks could be big enough).
> 

What was the CVE number?

regards,
dan carpenter


