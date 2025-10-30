Return-Path: <netdev+bounces-234496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EA6C21CBB
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 19:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28243A7333
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 18:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC171366FA5;
	Thu, 30 Oct 2025 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlHs1AlZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1EA363B8D
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849430; cv=none; b=HRl2IXiWK7QlRuxsQj/FISNFzKm6nHDRRHvaW/e/QAqS/WhxyOY4bGYakdoSrvSlFXZeeo2Cb8JJD5+iRWONzb80ggRuAlFmCoNdISAknsNPT//IrsWikUvjuyNdldl1FvQVMPVL9D1iVQrgXHNYF0oQB65FuhSLvwzUfSPlzaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849430; c=relaxed/simple;
	bh=sy3s7Ulw9uAy/T0F1K8BKFXott7Ch4n4OEtL4eZaQ3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js8fP8zfbDPNTINDx9i9fV4hcHjuLZpAIdUx/ZdKirswB5Q/pRW+5FERrIEhSKp9ImKwyGtrW6WaR0TdRfaBB9HnpAZK2KF/dqUMtUOus1lrCqUmEOJ4GAZXE2zOrMMWHPyP4Tlg131Wa7qBMxI4NKsCW49Mbdl9U6lMtgETt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlHs1AlZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761849426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg8g64zEcrAQ+4PM5lYnz9qvbj2CWKulWZjsNJhAjO0=;
	b=PlHs1AlZPb82iLIH1T20MTkzK5LDgyQObgjfPaqDgONwEt2fkfmPCTFuyda8TsDpWgQ69w
	g8yY160HDd5EPYUqz58zYhtOUsAWKJ1FjcaOtecO5tIBvMmPppk+1yAJClGRF0SJpDlIuN
	fMBzPCYMr3U/Y8ft6L9fqkIAFR0Anqo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-mJO7f2obOcaD0dBJUIIstw-1; Thu,
 30 Oct 2025 14:37:05 -0400
X-MC-Unique: mJO7f2obOcaD0dBJUIIstw-1
X-Mimecast-MFC-AGG-ID: mJO7f2obOcaD0dBJUIIstw_1761849424
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48BB818089A6;
	Thu, 30 Oct 2025 18:37:04 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 299221800451;
	Thu, 30 Oct 2025 18:37:02 +0000 (UTC)
Date: Thu, 30 Oct 2025 19:37:00 +0100
From: Miroslav Lichvar <mlichvar@redhat.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] wireguard: queuing: preserve napi_id on
 decapsulation
Message-ID: <aQOwTIVz9lj3lcpL@localhost>
References: <20251030104828.4192906-1-mlichvar@redhat.com>
 <CAHmME9rG1r5fJfubpcyK99g7G9YvnELq5+iW-+ms-Jb9dwPk+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rG1r5fJfubpcyK99g7G9YvnELq5+iW-+ms-Jb9dwPk+g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Oct 30, 2025 at 06:57:34PM +0100, Jason A. Donenfeld wrote:
> > +#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
> > +               skb->napi_id = napi_id;
> > +#endif
> 
> Seems incorrect. Although the union where napi_id is defined has that
> define here:
> 
> #if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
>        union {
>                unsigned int    napi_id;
>                unsigned int    sender_cpu;
>        };
> #endif
> 
> The skb_napi_id() has the narrower condition here:

> So I think all we care about is CONFIG_NET_RX_BUSY_POLL.

Ok, I'll fix that.

> > +       } else {
> 
> Why only do this in the !encapsulating case? Are get_timestamp() and
> put_ts_pktinfo() only called when !encapsulating?

Yes, I think so. The cmsg enabled by the timestamping option is added
only for received packets. Transmit timestamps are provided separately
with the packet looped back to the error queue (the timestamp is known
only after the actual transmission) and that can already provide the
index of the physical device in the IP_PKTINFO cmsg, which seems to
work correctly even with wireguard interfaces.

I'm not sure if the napi_id is actually used when sending. In my tests
it looked like it's the other field of the union, the sender cpu
index.

Thanks,

-- 
Miroslav Lichvar


