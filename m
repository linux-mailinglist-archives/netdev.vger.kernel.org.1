Return-Path: <netdev+bounces-230350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4889BE6E73
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D85735A73F
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE7D1EFFB2;
	Fri, 17 Oct 2025 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJzyX/Lg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1214F125
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685357; cv=none; b=OMlnbUdJhgkSOgO5P14GmPiQw0PgCKza3egsdgY4Pze5DckfqHCBtsT9ziqUpyvvcQsTTR4DxbPDW/wPvxB9cpP7fSev4D6LxUPd+VkJCd/q7BGELv6lyA5O0c7ZtNpEu1rmcBWSttLe0aYCxdJXdCK8VJEcBFb1lXI9QRydpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685357; c=relaxed/simple;
	bh=1dL9wTlycAsLzX2y4MTzrrBzSQsmTrPVywYZGm5zJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWDdHRgg/JwkAnRVoKQJSqvkMlIkHj6R5KPdhb33+VznRbDQP1t17ZousPAv/JWy7WFtttL9dWiZTBAirPbLQj0Iq9GQQpFC3cJMt/qmEeeVYTYCPOeQQg5qmR5iKxR+apK+faH1FMlTiWCYPW7hzNRAekXc6FfSrRZnS1LUE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJzyX/Lg; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1825576e87.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760685353; x=1761290153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=148Eb17gJ8RxWdKQ2rnESJNbo/VxcgJDRGCnUFv20jM=;
        b=fJzyX/LgmkDUdYEEdotiJst0i7hDjJxIE5IxWhiXN1wq9C/3xiS1hnV034AB1FL/k7
         hri77aTXsOhmQ+FsEFGoa+sonlAo9Sjvq4S3LtVL4lYpRwOGPIba8TQ/XCeMqtAjrvTg
         jSncYyDcRwYZ3OC2cKNB2IOM99zjCyJnwdNL9AtCY+Q+IQEUVXgkBnVM0DdL0kbyABmH
         YIWUQG+4Wn2bpNFnxBdLXhsYy4mibyu80rsLCfM55pc1vAB6lm5qukgtJMhJaZSfKWTI
         Q8/U7UewEYRU7ZkMGMVJCaY7Ke+XBXEzXtx3zGeYvRrCURnaUtqtcPfhtqXkXmd+5y8H
         tjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760685353; x=1761290153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=148Eb17gJ8RxWdKQ2rnESJNbo/VxcgJDRGCnUFv20jM=;
        b=qIBYpqQV8qQa+clylg9YqUy9OFvvJdtuCTtCrfKUoYbXFZLE/CQR/vU8Ognw9d9oaU
         ZVWl/tiU7dvcFahAD7iLWzFTvnv5RfglkD7UGHcYwmPSE8b2HCTLqmfTJ3zN57wiCQne
         xVJNNbCohh0Q5PoH5o4zGOJ2Mo8xRu4KM7Jmj2cVjQrg3ePylW4WibwTWBfZuU3fTYhW
         LFuWLBYpLJZSE0a+dXC5YvWahzoPDyXMcwnbFny7jcJ+XswSFX8oSSwb+rR3I2X4Z/4N
         pclsdUh4gAfwDwRtprg44uBUtGvvaoQUE+SDPBAtqDoHv2ZrW9+cGHiFDa1uMq/opYEX
         ru+w==
X-Forwarded-Encrypted: i=1; AJvYcCU+VI1/9aQHALtWEjz6+M3qw6XwGXeU83U9bcUFvLXEbRyY4l3yJ66xORDED1X8aLFL/DcQcas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9RGDIlkl3OVy1QCA8WpPLICEcMDw6la8S0uTK0PFA3YmMSQDM
	F0emFWaHrZNaA05YcAExU0tLTP8gLrECVzJFly4/e7cdhL2CjZoMIcpSfXLaLyR/LQQ=
X-Gm-Gg: ASbGncsLnmOJSFRE00F6nzmV3mKvxT8cWptvuMDW6Cq4kJgt9NPIi0kawDXaB1PE5E/
	wlVnRUbl8SFZfj6WfZEZzIWqLKIRxTyMjFYIXwdPDBPN8a/nI7WhAX3gre1NRRd+dIc4mmw9CFe
	43eQTaQY2QpVMV/cH88FEXOgFIPOzj/6wrjWDTa1iAfcDvY+n1zPZUEtcApTnlI1PjbxSpXKDDX
	n6DISuJV3j236TmMQTxX43QqNnUJLIVHaQy8Ec/69DtZRBcQ/Dr8Wm28ol5QsKguH07iE6pEa7Z
	wZlrBXzsMEK6rR+YO5SE22pOaSDCriyxCp/8gh9TYt79vojnCwVa9qgR0fAC6+JEAQQxYu6AQby
	iRmrIBlPDz1G+Pt3ZcEvuNw0yQxFuklNrbBP9DZCcTaIrxno0nAlEIGpHxg/MSo5YLwVpFjta8F
	jYlZCf4/ELR6g=
X-Google-Smtp-Source: AGHT+IFRf1ySNbsYYj5o+dwvR7Hy0y8DnWvFwza///P/Rp2kadGpW46H/2fJTcVA47GU9k2AX6PYYA==
X-Received: by 2002:a05:6512:2348:b0:585:1a9b:8b9a with SMTP id 2adb3069b0e04-591d083ec9amr2137907e87.9.1760685352985;
        Fri, 17 Oct 2025 00:15:52 -0700 (PDT)
Received: from home-server ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088563c13sm7648665e87.78.2025.10.17.00.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 00:15:52 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:15:50 +0300
From: Alexey Simakov <bigalex934@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] sctp: avoid NULL dereference when chunk data buffer
 is missing
Message-ID: <20251017071550.q7qg2a5e7xu6yvlr@home-server>
References: <20251015184510.6547-1-bigalex934@gmail.com>
 <aO_67_pJD71FBLmd@t14s.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO_67_pJD71FBLmd@t14s.localdomain>

On Wed, Oct 15, 2025 at 04:50:07PM -0300, Marcelo Ricardo Leitner wrote:
> On Wed, Oct 15, 2025 at 09:45:10PM +0300, Alexey Simakov wrote:
> > chunk->skb pointer is dereferenced in the if-block where it's supposed
> > to be NULL only.
> 
> The issue is well spotted. More below.
> 
> > 
> > Use the chunk header instead, which should be available at this point
> > in execution.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 90017accff61 ("sctp: Add GSO support")
> > Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> > ---
> >  net/sctp/inqueue.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
> > index 5c1652181805..f1830c21953f 100644
> > --- a/net/sctp/inqueue.c
> > +++ b/net/sctp/inqueue.c
> > @@ -173,7 +173,8 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
> 
> With more context here:
> 
>                if ((skb_shinfo(chunk->skb)->gso_type & SKB_GSO_SCTP) == SKB_GSO_SCTP) {
>                        /* GSO-marked skbs but without frags, handle
>                         * them normally
>                         */
> 
>                        if (skb_shinfo(chunk->skb)->frag_list)
>                                chunk->head_skb = chunk->skb;
> 
>                        /* skbs with "cover letter" */
>                        if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
> 		           ^^^^^^^^^^^^^^^^^^
> 
> chunk->head_skb would also not be guaranteed.
> 
> >  				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
> 
> But chunk->skb can only be NULL if chunk->head_skb is not, then.
> 
> Thing is, we cannot replace chunk->skb here then, because otherwise
> when freeing this chunk in sctp_chunk_free below it will not reference
> chunk->head_skb and will cause a leak.
> 
> With that, the check below should be done just before replacing
> chunk->skb right above, inside the if() block. We're sure that
> otherwise chunk->skb is non-NULL because of outer if() condition.
> 
> Thanks,
> Marcelo
> 
> >  
> >  			if (WARN_ON(!chunk->skb)) {
> > -				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
> > +				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
> > +						 SCTP_MIB_IN_PKT_DISCARDS);
> >  				sctp_chunk_free(chunk);
> >  				goto next_chunk;
> >  			}
I'm not sure, that correctly understand the new location of updated check.
There a few assumtions below.
> > -- 
> > 2.34.1
> > 
		/* Is the queue empty?  */
		entry = sctp_list_dequeue(&queue->in_chunk_list);
		if (!entry)
			return NULL;

		chunk = list_entry(entry, struct sctp_chunk, list);

		if (skb_is_gso(chunk->skb) && skb_is_gso_sctp(chunk->skb)) {
			/* GSO-marked skbs but without frags, handle
			 * them normally
			 */
			if (skb_shinfo(chunk->skb)->frag_list)
				chunk->head_skb = chunk->skb;

			/* skbs with "cover letter" */
			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
Adding this check here will not fix problem, since chunk->skb always true here because it dereferencing in
checks above.
				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
Adding here could make sense, chunk->skb changed => do something if it became null.

			if (WARN_ON(!chunk->skb)) {
				__SCTP_INC_STATS(dev_net(chunk->head_skb->dev),
						 SCTP_MIB_IN_PKT_DISCARDS);
				sctp_chunk_free(chunk);
				goto next_chunk;
			}
		}

