Return-Path: <netdev+bounces-90514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB998AE560
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8324D286FCD
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69F312DDA7;
	Tue, 23 Apr 2024 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDX2fZDm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBEB12D75B
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873319; cv=none; b=hgxPxLumZG+ITNUlVPwP5NTkUMuVyHCvFio3RBrBMvunUzR+Drl9mjpzqTSWhSkfZ98SBE8Smj860dktfkXTJ9oE1+l8+J9QhX2IbZcQeZ0MfO8q7QfI36f0ja8gqoRDPA6GzXXmyt4I6vsRcDzlT1XGVQI6oIFIT6yTcnIIZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873319; c=relaxed/simple;
	bh=naRCsBSPKOwXtsBWSD0Z3M0ggK9Ecnz+DijdexeNtJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeM8vv9krHyxLJHEtWuO8aeJtrdZ2pmlbZ138JDsT7aqzcI8jwH59P5bViAD/O8CXeVPo2qIz1QyidzmqDsOA8ktZ+kolY6eRTuEEOu1mpoPuUOGAMQmzXN3vLT6IrME5gmuPaqtHnCyZneFNP+6Wukxm/lyFYVuxKkC/zUYcn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDX2fZDm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a55b3d57277so275513666b.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713873316; x=1714478116; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OLs2w5Mb2TuW5IEF0yGhInk4y//qTnl8Y3J8SN796zY=;
        b=iDX2fZDmoCqJnTihACafsRkXvpGsjirWwQndLp/JCcwaB+k9v/L8SdsHsHEgren86l
         p8/Tb263UwpreD5ExLsH08JAAd9Z0RbCbtVV931cuI9R8pHMTY+7ytH5HufD13ida8nL
         n2XaKxXP9yLJmDCs1DG9ICymjay9lM3TU39DMpvOKSXMZLk8l2S/UK++mU/p9eka2QYA
         97NHG8hkw6uvxMt9/23yj2iqh13vCHBpDM4Fa4LIHK2ZMZ4iazLVTjB9P1QqFnN9/k7L
         N1cjxIWMYHR9YGZ6MDvnLrST6ifl9CHHiR5kpqWfs6N5HCwIXUnY8WYkJ1EnKuUPMSR5
         dPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713873316; x=1714478116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLs2w5Mb2TuW5IEF0yGhInk4y//qTnl8Y3J8SN796zY=;
        b=oHsejgiNnPjXIYwHyBtJGWL+IWWaM3+DYIRm6tGpVpUFx1mwBqBfnC+SlumnkBFl+S
         E3NjSSqXAj1Zz9zXFRbhzEDhAMtIZONpgv3i+Fk+OSBX9HA6T38/pwySKjWgukMG2kUU
         89htRWojM/49a3sAXkH9tQWlErtyyCoPcUwkNWI5T4qOYrnt90aed99cuDbIjgQUUkCq
         Pes4eIwi4f1JLfkhl1v1kl7u2KNs74FlxmfOWbGYpIoo/VyyerieEdNwz9U3pVV8Tswd
         t2gnxKcxb4WWQ9qN7kGVL/TOuqgQdM7K3ODA09/EqoS6wqXCCyPv78svkPP+GXFIhbwq
         auYg==
X-Forwarded-Encrypted: i=1; AJvYcCUTlyq5gY+k08xn96ljMWv1FjHOdnvj8jAvKf2ae/ocfdLtNFiY0nCDQHddEBnGC02BGAP0hKVvURxMaDnEHA4uEYvEQrz3
X-Gm-Message-State: AOJu0YzTCYjPvkMJ4J/pMPBIn4IoibsZ8z1os4+eFnsz4WDM9QziEQcE
	C5UEOR/XUS1Ih2FkiK6PQVq936fqn2C9GPKxkNg/pvYmGkKMzj1mSxvLwraSlFQ=
X-Google-Smtp-Source: AGHT+IFZ405qdGxDMkW1+5YC21CzN8lvjF3c9LLGQSea/WcHK3KI0QcB69sFb36UHpXXURv+h98QNQ==
X-Received: by 2002:a17:906:3791:b0:a55:554b:1f5d with SMTP id n17-20020a170906379100b00a55554b1f5dmr7343452ejc.41.1713873316016;
        Tue, 23 Apr 2024 04:55:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qy7-20020a170907688700b00a5887279b8dsm57534ejc.179.2024.04.23.04.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:55:15 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:55:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ibmvnic: Use -EBUSY in __ibmvnic_reset()
Message-ID: <da19d324-3c66-4bb1-8fa2-dc26dbea622b@moroto.mountain>
References: <4cff158d-b5ac-4dca-9fbb-626237c1eafe@web.de>
 <f493e39063ee52a3d263de27bfd240149d910a88.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f493e39063ee52a3d263de27bfd240149d910a88.camel@redhat.com>

On Tue, Apr 23, 2024 at 12:54:55PM +0200, Paolo Abeni wrote:
> On Fri, 2024-04-19 at 16:08 +0200, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Fri, 19 Apr 2024 15:46:17 +0200
> > 
> > Add a minus sign before the error code “EBUSY”
> > so that a negative value will be used as in other cases.
> > 
> > This issue was transformed by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> > index 5e9a93bdb518..737ae83a836a 100644
> > --- a/drivers/net/ethernet/ibm/ibmvnic.c
> > +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> > @@ -3212,7 +3212,7 @@ static void __ibmvnic_reset(struct work_struct *work)
> >  		    adapter->state == VNIC_REMOVED) {
> >  			spin_unlock_irqrestore(&adapter->state_lock, flags);
> >  			kfree(rwi);
> > -			rc = EBUSY;
> > +			rc = -EBUSY;
> >  			break;
> > 
> 
> AFAICS the error is always used as bool, so this will not change any
> behavior in practice. I tend to think we should not merge this kind of
> change outside some larger work in the same area, but I'd love a second
> opinion from the driver owners.

I missed the original patch due to my procmail filters...

You're right that it doesn't affect the behavior of the driver except
for the debug output when we do:

	netdev_dbg(adapter->netdev, "Reset failed, rc=%d\n", rc);

But the - was left off uninitentionally so I think we should apply it.

I have been trying to look for similar bugs where the - is left off.
It's a bit challenging because there places where we use positive
error codes deliberately.  But in this case a static checker could
easily detect the bug with a low false positive ratio by saying, "We're
mixing normal negative error codes with positive EBUSY".

regards,
dan carpenter

