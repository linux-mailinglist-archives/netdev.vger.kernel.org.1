Return-Path: <netdev+bounces-185530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73956A9ACFC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E405D7B5A8E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E2E230999;
	Thu, 24 Apr 2025 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGtOZZ4p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4F22E403
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496674; cv=none; b=bhahihlmCBRi5uIjYsCg02Wd8CNlML+dv/BsyUPsOhF69KrO9S8DgMsdWnVHO999NF14lZ4nzI3zrlyVR5xc2S7DS9fWYMu/kNYpq/P8cHD/D1WEhoJHOyO8FO3MvQh5MT9Z+++oJ09JsKspTP587hoFnUwxZNJYCvqYVUuOwh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496674; c=relaxed/simple;
	bh=bz4+/X497RFI15mRxsIqRhNBIwSZjCmNalMcue3pcXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYFegglGxn5HBPS4doK3Dul2vBFq3ClMbyAGHC3YEdIKdGLpEjTY8aYjADdQE6qugdfYgK+hRin1d88fesXR8zOjIKLySicL6DS+CjM6qmEnUmVj/brKY8rurxE6kuqeeEorlwnsaIMy8wIeOTD6xl+AWEeSBg5ENZi3i7KV7EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGtOZZ4p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745496670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+iBi7KEPHVPdl78TuinUFRyNTsFrvN4I3oDOUPKzwc=;
	b=OGtOZZ4pELLlpsDfRSPosBgIxy9Yo/hTbR/mPEJbTM8qtqlkiJRQ37c6WdlwPSc6VDHoRL
	jhymIOCo0UXhIyppfSzMa1XJGOT21M1GjmfXwE7gNhvKGxu8cj4GQ/gGJIsgDLXSDM9itg
	H87XgQXbrkKmHo1nCOmKtYvt/01hrUk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-0MMo2mzPMaiAJOs5r1oxvg-1; Thu, 24 Apr 2025 08:11:09 -0400
X-MC-Unique: 0MMo2mzPMaiAJOs5r1oxvg-1
X-Mimecast-MFC-AGG-ID: 0MMo2mzPMaiAJOs5r1oxvg_1745496668
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so4730125e9.3
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 05:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745496668; x=1746101468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+iBi7KEPHVPdl78TuinUFRyNTsFrvN4I3oDOUPKzwc=;
        b=uYmacRIMhGdXx2sHfcloRum0EHohJJBWjoumfoakkN4JjBXy8ZOXCZVV2/a2jqWKkz
         wOtPUrJbQMQVqWOfQPETbpvasqNyU0f3iUGrsVtR6LnlfrUg6D9C9jmkeMWH4QR/7hc0
         mYQLecwN7xsn8yStMhcF22cWPuG70sknR2AX9AKQY/rKV4f3zIkNr1EnTd2+5qbxTpG/
         whrTk3bZHatbEOBFwdUfYU1Cb6qkgmP+aoCEeAX9CKN1b7EvbL97+rvzSHFnffcxEXsi
         PvopNr51/c4UPPYWwMkp9gfPQdX6SZlVpKQYi34vwt6iOXQa8CI/kWtIwRm0R5Xhzlh6
         25fg==
X-Forwarded-Encrypted: i=1; AJvYcCX1QQplq7xBb55Fbtav2UP1ghWiJLuLTrSEZgWJ34yGNqPRM2KqoH7Rq7K4o23PdnT6DY0M7oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuIACTITt36dERNJ0DTItcBNMJ/iz8/2qDfKsd3+7ZBYe9ZRcO
	Jdp9w3PbGkZy2zos7dPsubhdf/5zXHhNhtrCt357vdstiy2qTOXqBUe/ls47sONus+3tFOGk8eS
	XVh1OBqOrQcfA5bm+gT7qNEYVdQk22ujo39YFP4kQK8UXlxvoaK3zgw==
X-Gm-Gg: ASbGncvsqQHUm1mumWFoR+QU9CjaI2RRMtsOb4FbRXNmXMpCd+KUsPpReccuDtOw+O1
	PAMNpkw9mQHatpoAD6q1gWWzEG+JpUoxbJBbuRXZ2ecDMiV1jZhIBirgxbWVunuSKXD7S1YoidQ
	vciCkhF1tyK/+DsNptM3G3xIVdXIlzE+e8CckGEe576cL4vqnJ9VYSkBtCaSbhK5YdeJi0uhsLr
	bE/l6/AxvoAe5mKVTORQ+JAUwUs3USjQPlLc7sbTOU28Q/9UQq1kwsn9UG+44WJf1Unr15sreZt
	y8UD2Q==
X-Received: by 2002:a05:600c:1395:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-4409bd17dfdmr21734065e9.8.1745496668280;
        Thu, 24 Apr 2025 05:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9n0roJbpJf5HRR05saKucJsNpfjrLxCLOXtUJbPRGicV0Zxwyv2cOdsaG6FPN2tpgup02FQ==
X-Received: by 2002:a05:600c:1395:b0:43c:f616:f08 with SMTP id 5b1f17b1804b1-4409bd17dfdmr21733875e9.8.1745496667950;
        Thu, 24 Apr 2025 05:11:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2b77f9sm18718025e9.25.2025.04.24.05.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:11:07 -0700 (PDT)
Date: Thu, 24 Apr 2025 08:11:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] vhost/net: Defer TX queue re-enable until
 after sendmsg
Message-ID: <20250424080749-mutt-send-email-mst@kernel.org>
References: <20250420010518.2842335-1-jon@nutanix.com>
 <a0894275-6b23-4cff-9e36-a635f776c403@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0894275-6b23-4cff-9e36-a635f776c403@redhat.com>

On Thu, Apr 24, 2025 at 01:48:53PM +0200, Paolo Abeni wrote:
> On 4/20/25 3:05 AM, Jon Kohler wrote:
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index b9b9e9d40951..9b04025eea66 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -769,13 +769,17 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >  			break;
> >  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
> >  		if (head == vq->num) {
> > +			/* If interrupted while doing busy polling, requeue
> > +			 * the handler to be fair handle_rx as well as other
> > +			 * tasks waiting on cpu
> > +			 */
> >  			if (unlikely(busyloop_intr)) {
> >  				vhost_poll_queue(&vq->poll);
> > -			} else if (unlikely(vhost_enable_notify(&net->dev,
> > -								vq))) {
> > -				vhost_disable_notify(&net->dev, vq);
> > -				continue;
> >  			}
> > +			/* Kicks are disabled at this point, break loop and
> > +			 * process any remaining batched packets. Queue will
> > +			 * be re-enabled afterwards.
> > +			 */
> >  			break;
> >  		}
> 
> It's not clear to me why the zerocopy path does not need a similar change.

It can have one, it's just that Jon has a separate patch to drop
it completely. A commit log comment mentioning this would be a good
idea, yes.

> > @@ -825,7 +829,14 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> >  		++nvq->done_idx;
> >  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> >  
> > +	/* Kicks are still disabled, dispatch any remaining batched msgs. */
> >  	vhost_tx_batch(net, nvq, sock, &msg);
> > +
> > +	/* All of our work has been completed; however, before leaving the
> > +	 * TX handler, do one last check for work, and requeue handler if
> > +	 * necessary. If there is no work, queue will be reenabled.
> > +	 */
> > +	vhost_net_busy_poll_try_queue(net, vq);
> 
> This will call vhost_poll_queue() regardless of the 'busyloop_intr' flag
> value, while AFAICS prior to this patch vhost_poll_queue() is only
> performed with busyloop_intr == true. Why don't we need to take care of
> such flag here?

Hmm I agree this is worth trying, a free if possibly small performance
gain, why not. Jon want to try?


> @Michael: I assume you prefer that this patch will go through the
> net-next tree, right?
> 
> Thanks,
> 
> Paolo

I don't mind and this seems to be what Jon wants.
I could queue it too, but extra review  it gets in the net tree is good.

-- 
MST


