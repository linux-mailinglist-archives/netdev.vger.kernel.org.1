Return-Path: <netdev+bounces-93000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D5C8B9977
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E862830A7
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1085D903;
	Thu,  2 May 2024 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWA7PS0U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5456B7B
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647232; cv=none; b=iPumJIFQXbYtts0rXRFfaGcCll6UkmbdCjSl9cY7ld2AAYmI2w2VhmCY0m6ZTTY3x0oWEWusI6tzkJCzuR2VoaA+a+QpjR1fh3+f6+eYzKz0ZdktrTGnFwwno/KNfbOBAvzW0Bq7luk13r6Jf9cBfVVUb67vBNZWannrgz/uDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647232; c=relaxed/simple;
	bh=nDHVt9IQKPJBaW8pSMgfYJZVrVl3RmH3joUMtIvTxFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kr9osdF5KRDG3KzSw1OlFExKWOTn4aUpK6/ePHg5NgyXxIk8Ap7BY8lr+HHL4JYzQfi0dbdybtjV+Fl1XJ1HzrwXn6FpJM55P/fKV1XVv7Pwl4t/qKVrQcz/NfLV/1D7QU1TjbMPg+xi/rGAj+h3uyf42cPhFIN71JGw9sJLrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWA7PS0U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714647229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L8zcSt9mnLpDixX7jq6/X+jdwqpMoegAEOf41jc3tK0=;
	b=QWA7PS0UL/guKOMgxSl4lsNFOsZv4A4P3IJ3FAITe5AGXglYxLwuYdIRzpyz+aJVImpQmb
	47YYcqV9ds3iQnnMO5Dc4WvBbvVgamijn2GfxD4LGtYscHFP3B7MTlDssyk9vuEsgcJWbf
	YKiW0AVen+i3piuCV9CPGthn14MeFHU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-2YO008xWMPmiowZGjLmfGg-1; Thu, 02 May 2024 06:53:48 -0400
X-MC-Unique: 2YO008xWMPmiowZGjLmfGg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2db3e410df7so4986011fa.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 03:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714647226; x=1715252026;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8zcSt9mnLpDixX7jq6/X+jdwqpMoegAEOf41jc3tK0=;
        b=c5mzDC4Mp9zvSjiUTsj7OLEh5kJwha3TojYnTh5YQeoH7uqtv++RQDAyABRJUbpFaz
         P5yJ0Cf0mYr6Z9FDmxdR67ddq0Zmq3SNL13eODs+ScdYWK6N4hVO6xzRUNFR83T0k4cn
         9We6DiFVlBrZWI7WgnvnkBX2FF0iIgw0HqRxgxZRoKY3x9WJqg1uvIxmSXwLldzuBAFI
         7KQ3FdyW1FwP96XZ5mxXXfNI7KKOcqzPHUUAJjDtdpQLeHrbDqzFCmn4+Lr3R52R6ODZ
         Cat28uz1VPBmHFn/VpcvgpcjlOY1IFtigMy/BdoD9+ycHMIOuI0q4+JjotaHCg/bBAXg
         UVLA==
X-Forwarded-Encrypted: i=1; AJvYcCUwQAMMFeL/qBytJkVC2IPiDPBvPc3ypiI2W0ho4BjOzABR8KlvgRQNX54vrEe6pRCJnjMbPWWlsLFPgV87XP8UzBapjp4s
X-Gm-Message-State: AOJu0YyEnCoY2xhQ7Z//0W5+MzWraDmOQiJZqswGrBM8JUfyCy+Ow2iH
	XoUCW9k9fujOOfZQnow6Z1mHN25t2KijObD4TtvYSbGI+SwkLIOKEq8eWSlTvwZ7GHp+baRg2OR
	RX9U+spz5x5FC2c8GbUq+Jq8KOSy7rM3+WweZt20Lahj6NB+fCW4USSNek8v6qw==
X-Received: by 2002:a19:5e11:0:b0:51f:8ad:673f with SMTP id s17-20020a195e11000000b0051f08ad673fmr1344282lfb.5.1714647226173;
        Thu, 02 May 2024 03:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWNLyiZXN00zYlfrZBUpA8Z9/CH7+O82opOZnsY9o0G0mDFUIWL0G149oTELqkEtGbt1uNpQ==
X-Received: by 2002:a19:5e11:0:b0:51f:8ad:673f with SMTP id s17-20020a195e11000000b0051f08ad673fmr1344269lfb.5.1714647225692;
        Thu, 02 May 2024 03:53:45 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b52:6510:426c:715f:ad06:c489])
        by smtp.gmail.com with ESMTPSA id bd13-20020a05600c1f0d00b0041c012ca327sm1521922wmb.45.2024.05.02.03.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 03:53:45 -0700 (PDT)
Message-ID: <eb382c9e23b169250079ef96ec94de77918a6a0c.camel@redhat.com>
Subject: Re: [PATCH 0/3] pull request (net): ipsec 2024-05-02
From: Paolo Abeni <pabeni@redhat.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, David Miller
	 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Date: Thu, 02 May 2024 12:53:43 +0200
In-Reply-To: <20240502084838.2269355-1-steffen.klassert@secunet.com>
References: <20240502084838.2269355-1-steffen.klassert@secunet.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-02 at 10:48 +0200, Steffen Klassert wrote:
> 1) Fix an error pointer dereference in xfrm_in_fwd_icmp.
>    From Antony Antony.
>=20
> 2) Preserve vlan tags for ESP transport mode software GRO.
>    From Paul Davey.
>=20
> 3) Fix a spelling mistake in an uapi xfrm.h comment.
>    From Anotny Antony.
>=20
> Please pull or let me know if there are problems.

This landed in my inbox after I almost finalized today's net PR, so
these fixes will not enter it, they will reach Liuns' tree next week.

I hope it's not a big deal.

Cheers,

Paolo


