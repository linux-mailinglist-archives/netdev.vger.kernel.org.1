Return-Path: <netdev+bounces-64726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8893C836D5E
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40ED128C1AD
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C224E6DD1E;
	Mon, 22 Jan 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa07L659"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72D55C2B
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940988; cv=none; b=A1++bmfWatMTBmUiooyTsMjsucPzhh0BGuqaFg6+GFwos92FlecZ9k/BC0Cj/deZKTRbiuHh49mtm0zuI9OABOlA6gWbT0R0px+Z2YyM5BjTWMB6F63sfpJT+I7DiQpCJqUCjR3DCOJtbNbVX+QevHAqp3CJfGG0twDPc70j374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940988; c=relaxed/simple;
	bh=4tD82MR0O5ANI9O9COhj/jEVDKaq51UmMmrCFKznVN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5OyalRfizzF6cvfD8hHc9+BBANvMvbhHxy6x197l36TD6ueyR5+GpNydgwxYdHqlzNsLsA2COe8JVPopXMeiQTDV1ECD+/qdCZxYzQq/wLuoiJisB9G26CRf1CUN1CiyDHmkbUAddZ7rPh1iY+hR82mjd5OLwI5Ew+DeDDZsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xa07L659; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705940986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5r+uz9jCLaEFEHOihBvqW2L1PNlFliY06t9u6MNTyik=;
	b=Xa07L659tEq16jVKqiCPCg2C0egNJ7OSSAKTEkRiRmKNZRiIoMm1JmDjbduYQS/F5MiKIj
	6hVCOFCnuCBR2l/NA0QGDKV6h9ia6s/6dqbgKgsXloDsnL95R2k9m/H62r+3A12n4MXDm2
	loYkFmOp5PXJGnrO8FaCPbkoMkKRyvw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-FslUcxX7PUGx6ygCjpQFsg-1; Mon, 22 Jan 2024 11:29:44 -0500
X-MC-Unique: FslUcxX7PUGx6ygCjpQFsg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6818a6e784fso42118266d6.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 08:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705940983; x=1706545783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r+uz9jCLaEFEHOihBvqW2L1PNlFliY06t9u6MNTyik=;
        b=jJakodzIFZrl/1yXfUJoOrEXYR4SaOeQQCo/f/DcItZQ3bnanVYnGbTN9lk8sk5Q1U
         G+BsRVenm6zL3yOksCI/9QwzbQ9cV8R4M71L/tDVqHEq/vERjb6kXWyZtDo6uAjmxtMJ
         pBQxf4BH1HPAYOyeYj8M3BnGWk1Pj/TR4cBLEpfgl/yy6uGK44BSvg+XlSE62Y/6nT97
         CIOmUJ/7CqBqXARzxFAfmu0UUJsH3acSiBRkAV34mKaMKUDuYQ//1YYK0wvqyNsiFBxB
         0zq2VtbVvAnzNGVghUjMyDzNG0EPCqBLJkp5rdcILNdMjlvb0YEqr8DNEUGszlYI5GDq
         xtiw==
X-Gm-Message-State: AOJu0YzG7NqjFCW5Iky6rTWMCI3tSkzBqeRaK6g55jEdQAoUp/2TMgqH
	wfgeROoUb5EfpdDSNNoFreElAsH7rLc2W3JeoyxMj7r9Yne5tCXFJjBVOsxPdHsJeDv+Tpj/lx3
	iJmfxB3kduhDFLnxdf9hlNv5+qL1Sok/M9SmXu3qLEhlCjPWZ+F/RMQ==
X-Received: by 2002:a05:6214:230e:b0:686:3fe8:2797 with SMTP id gc14-20020a056214230e00b006863fe82797mr3611840qvb.128.1705940983823;
        Mon, 22 Jan 2024 08:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEknOAMP4/x/ZwT/bbmdWhjLkp5eTwl4p0RxJ3caefrXD+TdKG+OrTf5ytW7sLXbllrObeEJA==
X-Received: by 2002:a05:6214:230e:b0:686:3fe8:2797 with SMTP id gc14-20020a056214230e00b006863fe82797mr3611831qvb.128.1705940983579;
        Mon, 22 Jan 2024 08:29:43 -0800 (PST)
Received: from debian (2a01cb058d23d60079fd8eadf0dd7f4f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:79fd:8ead:f0dd:7f4f])
        by smtp.gmail.com with ESMTPSA id l14-20020ad44bce000000b00681776be156sm2514932qvw.110.2024.01.22.08.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:29:43 -0800 (PST)
Date: Mon, 22 Jan 2024 17:29:39 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/9] inet_diag: annotate data-races around
 inet_diag_table[]
Message-ID: <Za6X81m239G8drAI@debian>
References: <20240122112603.3270097-1-edumazet@google.com>
 <20240122112603.3270097-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122112603.3270097-3-edumazet@google.com>

On Mon, Jan 22, 2024 at 11:25:56AM +0000, Eric Dumazet wrote:
> inet_diag_lock_handler() reads inet_diag_table[proto] locklessly.
> 
> Use READ_ONCE()/WRITE_ONCE() annotations to avoid potential issues.
> 
> Fixes: d523a328fb02 ("[INET]: Fix inet_diag dead-lock regression")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Guillaume Nault <gnault@redhat.com>


