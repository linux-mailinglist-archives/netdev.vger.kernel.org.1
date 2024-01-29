Return-Path: <netdev+bounces-66699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166C4840537
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73B2282058
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F41612CB;
	Mon, 29 Jan 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxX+BekT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30E627EE
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532226; cv=none; b=AW7sg7t7DtE2WGyk6U0Cb4ztlxUVMJRXp08lSI/11BB5DbDitUVLZGVfs4iCDitNECz1dGOYRbmJ2gLkSSgks+fHbOYryZhfu9vt/qPwgN25hHG/pqe0yhkiPWt3NTTARHthR1jLxblIGJHtMODdupixZEQ/9rRo6ji0lZkq/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532226; c=relaxed/simple;
	bh=9Ym5aT2J3mgJXSTrrnpDS1sEaeBlswv1NvTjbLXZ8/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZEFqsIVWKKmYMXt137wc3KC7ZN5bNsh4p465QZfmUiZVaecr8MYUudAp4jkMTjR5RwXmiUgKczFIhd1CN1ngWiM44maGtR4CmzKSUZpFUYzRcHgRqs4EAbqsPfJUNe/Boggt7bEamIkOIfOQEyGTIVF0z6je5lBK/wxXt1yMgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxX+BekT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706532224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ym5aT2J3mgJXSTrrnpDS1sEaeBlswv1NvTjbLXZ8/o=;
	b=RxX+BekTbgPoVBrV2NGN0Ha0dewQ/RSke+3wPsV/YElPSOhXLzYqjTQVbDWVq8LTv5dov/
	tz+vqTu2dGygNEs2LEJ8w779+AOcJF2H2gNnU0i4vqd/qILPOPFOH2Z5exyms3UwCuhu5M
	VKDHWYyvOK3Xom3i4jkDkCEZRMsGysg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-zKY1_8vLNE2mYWpYGKCHFw-1; Mon, 29 Jan 2024 07:43:43 -0500
X-MC-Unique: zKY1_8vLNE2mYWpYGKCHFw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a27eddc1c27so120777866b.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 04:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532222; x=1707137022;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ym5aT2J3mgJXSTrrnpDS1sEaeBlswv1NvTjbLXZ8/o=;
        b=oGnlKw9JeUgRu2vOKKeXyXYAENXv8XVslVFnHfW6s49tNACfv5oi1Xw/Kgjy6vjlDT
         dV3l2jSL3ENXdQpFlnznRCJbMeP56oEVXTbDmrMg2CBtwX/IOdENNf0ahlcIX4wxf9bJ
         DxUFlKfp3VMN5YdtN0S9cSSLlsaR2oJQSBUyzJC8FmxT/dfpowX6H+P/IBZbEp5JxxC2
         0odKkhyriBLAQLDtN2Tc9cQyub+DRHXja2gJUmlN7UXphDthJhqRUgi9D0RtGbduQakH
         In2j3uJduipbi5cxdOOHQ5FqtaHLqQIfZbCPoWSdyFKJxNVXEpRafWhM52kZ3FQb74Mu
         sSZg==
X-Gm-Message-State: AOJu0YyXaT95kT15CMUQm7vjDO2BbzrA8CPSK1dLHRDbICeiJmHCA9hN
	8t6VVA3noVAjOzP/VLQZ8wAF/vBBtmQBnq7y9hvYCuh5iiwPso1rGALmOmESgDKjDW9LnukRsYl
	kgjlz2J6l4d+XctZYu2gsxkJqWD9bPFLigfqiYz9smnlHYwoo/RLIJQ==
X-Received: by 2002:a17:906:44f:b0:a35:e63d:dcc8 with SMTP id e15-20020a170906044f00b00a35e63ddcc8mr818288eja.38.1706532222061;
        Mon, 29 Jan 2024 04:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfcfypSQI/hgBLQnqnVLTKIBuzs1pvfMvBpPtfYy57ZbtqkT6RKgdsBYEWGBZeybIwlgEUHQ==
X-Received: by 2002:a17:906:44f:b0:a35:e63d:dcc8 with SMTP id e15-20020a170906044f00b00a35e63ddcc8mr818271eja.38.1706532221752;
        Mon, 29 Jan 2024 04:43:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id cw13-20020a170907160d00b00a356e5afda0sm2106444ejd.110.2024.01.29.04.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:43:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 26456108A015; Mon, 29 Jan 2024 13:43:41 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 0/5] add multi-buff support for xdp running
 in generic mode
In-Reply-To: <cover.1706451150.git.lorenzo@kernel.org>
References: <cover.1706451150.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 29 Jan 2024 13:43:41 +0100
Message-ID: <87msso1f9e.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce multi-buffer support for xdp running in generic mode not always
> linearizing the skb in netif_receive_generic_xdp routine.
> Introduce page_pool in softnet_data structure

This last line is not accurate anymore... :)

-Toke


