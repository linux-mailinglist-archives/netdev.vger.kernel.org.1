Return-Path: <netdev+bounces-200247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E5EAE3D8A
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FD7164920
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA45323D2B7;
	Mon, 23 Jun 2025 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdWwGj7T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25523D2AE
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676328; cv=none; b=Gn24xrTVIAJVR9LExbpyAbZFD+vsTjvXlWFS47uCWRXgJxy7AbBmXib7ZHlIo3Fg7SWuLVLTa7Y7ziLoQFxXjzLkPH7LFq8TiDwrZGnTiwcByrEgDl8mB1ArKI+2hdlEVoy7c/tc+2YMz95e4W1DSourfo9TXiwxyJcVBXm0PX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676328; c=relaxed/simple;
	bh=EErLWh9XrgJNcdZGRifMKXJSqa0n2177cUJabg2LT7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra/ddAV13rqVx4QzzHSBnvrnJoBfSnHYnmF4C2onXDImbiQFFysuC2evJF2bEecsj9R+r/wQx0RjteCF80AnEHXGquvRKAhnTiJ52F6dljwU39oAtyWFZRASqfMqJMoxgGjpujBCrFkFe7Wk5NvYhGDgLK02MRkSxiZXV04zOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdWwGj7T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750676326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fco4vtRzYDDw/pHaJKec/EnFJ9SMT2p2BP0btZaM8tY=;
	b=AdWwGj7Tq81U9bqRrlDDQ/SPXPyVrESgYF29QkAegD062X37g/b0RZ7zRnAxmvxY35YejA
	icog1GmFHClxMvOKOEbhTVwP0bQAQLjDDMGL2LxNdaKGppsC/07mYZMrXVx6xN64piBt5I
	IrXkacpJ/f6eU2is6DoVuh8NdQ0BCh8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-2Y0-ZT8KPkeiFBZkoRWiKA-1; Mon, 23 Jun 2025 06:58:44 -0400
X-MC-Unique: 2Y0-ZT8KPkeiFBZkoRWiKA-1
X-Mimecast-MFC-AGG-ID: 2Y0-ZT8KPkeiFBZkoRWiKA_1750676323
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450d244bfabso31359035e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 03:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750676323; x=1751281123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fco4vtRzYDDw/pHaJKec/EnFJ9SMT2p2BP0btZaM8tY=;
        b=NQY73aYqVUWWZdcASqnYXT85eq2NRV2dF6uss2iQBwd6NzO+aXdUfPEbZMEKCRr+p+
         YTZJLnmAEt8nQvKMKR6u+iehRcZYzRSd4euIdLIGCFYbLVv2uMDKgHO+jH47/a8UvSLF
         T5gmdoJ4SedOrwc46PF+7VzW0o1ELxQyHhxc5qpmIEDou8r4ts5ULy9J/MjYtna6l1xV
         lvmYlk3pNdcIbDpcJi/n2BGwW08WbqBL3dQuUiKwyMsyJPGj4SDXBJDf2DSiY9eyjTiO
         S5dJC3T6OKrUT88Qj9grpxF0f6TtT4cz8weImlG8a6nxVg4hRMCxs+TJSd/mYc7GTQYr
         MJNw==
X-Forwarded-Encrypted: i=1; AJvYcCUoNdnS1hDEkloUEK9NgpHHgyQbLdOKsCgIrjT5Nor9oJufVDxcfhztugNupLsm02UxCP2OXBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0BKJVzKOUlGyZ41LqSepV3KqDNcBC8cG0OzU9BPqJHPkTEm/A
	a8u0HMr8ZRSMqzD4pUMXTE6+08+6QflNK04i8NozJiAMdyr76wwYHnG3CBOrfFRI/91JatzmI9G
	IzIHhQcuoetLIT35NpFTwDAW8zAtN6sYuIrp1DlB/xUnMp70QJj3dQppA1w==
X-Gm-Gg: ASbGncsWkAI/ennX7Bj22IbopGiki/9vllXsYyf/9U32zTcmTf9GBVH0x6qH+IWQcI9
	QapPVC4F/CAOwumq0j1WQjufEcjqgOwCcSmq3kHWKk+BIqvhW5FwGKY92AqAyMZ3u272KbPZTAl
	GbYm01HxJs6mpf+/zqxDu3vFKlofQT41io6GP/FAlPDrkk+M13owhtTzfVEidJCgMrWtDZTpPvR
	9bH9X/0tjqg1+6sJzE1LIUVSrV3vrupmsz2py0aKiM0KSsQBAqFlqCqDP1SVunaq+U01MFSBiA6
	Uv9uDb89wvTlCYOIaKfHsWwfewgQdoB33m+3BpaPzr8y1fiZCDEK6rcK+teIay9kgBmIOVVJSpS
	gmw==
X-Received: by 2002:a05:600c:5494:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-453657be65fmr102123505e9.8.1750676323466;
        Mon, 23 Jun 2025 03:58:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeMGWI9zXCkvZ6XaBwo/RYYoquB2fA9+J9yIDbiHxixIIBumezj2Y4ZCKG/s8zRIZRGmk29Q==
X-Received: by 2002:a05:600c:5494:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-453657be65fmr102123215e9.8.1750676323074;
        Mon, 23 Jun 2025 03:58:43 -0700 (PDT)
Received: from debian (2a01cb058d23d600538a1f8d783da59a.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:538a:1f8d:783d:a59a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45364705748sm104423235e9.28.2025.06.23.03.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 03:58:42 -0700 (PDT)
Date: Mon, 23 Jun 2025 12:58:40 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: linux-ppp@vger.kernel.org, Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] pppoe: drop PACKET_OTHERHOST before
 skb_share_check()
Message-ID: <aFkzYKBU/c8aub5Q@debian>
References: <20250623033431.408810-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623033431.408810-1-dqfext@gmail.com>

On Mon, Jun 23, 2025 at 11:34:31AM +0800, Qingfang Deng wrote:
> Align with ip_rcv() by dropping PACKET_OTHERHOST packets before
> calling skb_share_check(). This avoids unnecessary skb processing
> for packets that will be discarded anyway.
> 
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
>  drivers/net/ppp/pppoe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 68e631718ab0..410effa42ade 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -372,9 +372,6 @@ static int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
>  	 * can't change.
>  	 */
>  
> -	if (skb->pkt_type == PACKET_OTHERHOST)
> -		goto abort_kfree;
> -
>  	if (sk->sk_state & PPPOX_BOUND) {
>  		ppp_input(&po->chan, skb);
>  	} else if (sk->sk_state & PPPOX_RELAY) {
> @@ -418,6 +415,9 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>  	struct pppoe_net *pn;
>  	int len;
>  
> +	if (skb->pkt_type == PACKET_OTHERHOST)
> +		goto drop;
> +
>  	skb = skb_share_check(skb, GFP_ATOMIC);
>  	if (!skb)
>  		goto out;

Agree. You can also refine the condition and reject broadcast packets
by using "if (skb->pkt_type != PACKET_HOST)". PPPoE session packets
should always be unicast.

Acked-by: Guillaume Nault <gnault@redhat.com>


