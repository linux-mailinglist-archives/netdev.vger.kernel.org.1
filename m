Return-Path: <netdev+bounces-64688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB1B8365C9
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 15:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5059B2A076
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B293D555;
	Mon, 22 Jan 2024 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGAtINhK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F93D553
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934458; cv=none; b=sukK3eOMEYTE3nghr3R3SKmGY1pPqjhl46RPm5GySldT18hd+/zvfZiofeEx1O2qMe5Eb3QV8v6WbEaagx3QSh3oo4z1boFCSetekp2hkJjNaVt+797qatICpLbKfxoZd7T5jZ7xDATP+GlAmgWMRRzbCnoL4RyMsXWhxV5r1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934458; c=relaxed/simple;
	bh=6/bPEgSKBIMhJqi8PoJH61qyRA5qNWZ+HTR/a6+YVlU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qmZ4ugIfO0EdQswtnth5dPqk31ViSqsGR3k34vR6A4ltT/3N+5wKY4DLH3gB780A6k0fOPzSQ8o7apFglGU5Mb2XbOIYaMuAlsNYg4zthL+0qIGone7lO/arig87M6l/5hxgPqs2ymRWKlaYQeVioTRs2jyqB1rzb7tUWh1tSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGAtINhK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705934455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hTHteNIHateANxNRdip7PGZEeIgr6CGyRYutJ8M6CKU=;
	b=PGAtINhK/H60pQfl7N+J1nnP6ycuKK63EVA3v+fZOTO2KhcnA72HW9q4P2iUxWVEOo/V4W
	a2Tur6ROM8tB7aC4pcsLdozYPR0dEt3UuMW5kczeYY/k9ioS5vFYFdpwY189b2UPl9ql8Z
	WL22hoC4kiHJgkOikuKfJBOSJm6tNSE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-Jpr2p5cvMoWj6tdMQXS2GQ-1; Mon, 22 Jan 2024 09:40:52 -0500
X-MC-Unique: Jpr2p5cvMoWj6tdMQXS2GQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d5428caaeso5091785e9.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 06:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705934451; x=1706539251;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTHteNIHateANxNRdip7PGZEeIgr6CGyRYutJ8M6CKU=;
        b=Fj3NAONm4aBxBjjemE5vGjVkN4QKgXO0thpDViC/hEQ7WQo+B7/p+wJKm+liUyZEZX
         YpR06j8aLYSaC+PEl6IkPBUR5REgQQ8c/2hOYw/tMx3x9cwJUgHkrHDP8CbhZecYcWIz
         1AggI6GFJEzi2dNMxj3t7h1aKl5olx1pYJ6ZIz2zpy1fHiJgtKfHrfiZClWim5Ah5m9R
         8TFyA7ermd8hWDdvIx+DIB9NAMvnchov08vvtj6VesIHyCTXrYyW9f9tQC5s63voMEs5
         2/DhBwsaktdcrlQZMflkXoFPd/ItVuIJKW8APKaU8YvFDZq13k4yRWBUa/nq82XxIeNh
         N45w==
X-Gm-Message-State: AOJu0YxeObC6XX4OD8u3oN9BC+JRI5hny8g5IZDCJI7KwR034blR/pEs
	MQNMxGfZMg/TfZpQC8plRuOeUetNaXRTeNg7IAif3cCPopg6MqwhqzP+gyUSOZhEKGQAhrnizll
	8+TH4CJ0OoZejA06FbpeAkUJ8riOnbho7cPhA11GHNF020V7eqT6Ruw==
X-Received: by 2002:a05:600c:1d29:b0:40e:89ad:8b77 with SMTP id l41-20020a05600c1d2900b0040e89ad8b77mr6005624wms.3.1705934450957;
        Mon, 22 Jan 2024 06:40:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQpxHuAggI4Biw0Tqg0Ip3Kwpw1oPRGWT6huobiS8TKl/RI4QED/oLuTq7pfteUQBbQ4Q0OQ==
X-Received: by 2002:a05:600c:1d29:b0:40e:89ad:8b77 with SMTP id l41-20020a05600c1d2900b0040e89ad8b77mr6005612wms.3.1705934450510;
        Mon, 22 Jan 2024 06:40:50 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id g21-20020a05600c311500b0040d30af488asm43287709wmo.40.2024.01.22.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:40:49 -0800 (PST)
Message-ID: <a334775ce779be6b65928839dbc63fefc5d04086.camel@redhat.com>
Subject: Re: [PATCH v4] tcp: Add memory barrier to tcp_push()
From: Paolo Abeni <pabeni@redhat.com>
To: Salvatore Dipietro <dipiets@amazon.com>, edumazet@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org
Cc: netdev@vger.kernel.org, blakgeof@amazon.com, alisaidi@amazon.com, 
	benh@amazon.com, dipietro.salvatore@gmail.com
Date: Mon, 22 Jan 2024 15:40:48 +0100
In-Reply-To: <20240119190133.43698-1-dipiets@amazon.com>
References: <20240119190133.43698-1-dipiets@amazon.com>
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

On Fri, 2024-01-19 at 11:01 -0800, Salvatore Dipietro wrote:
> On CPUs with weak memory models, reads and updates performed by tcp_push
> to the sk variables can get reordered leaving the socket throttled when
> it should not. The tasklet running tcp_wfree() may also not observe the
> memory updates in time and will skip flushing any packets throttled by
> tcp_push(), delaying the sending. This can pathologically cause 40ms
> extra latency due to bad interactions with delayed acks.
>=20
> Adding a memory barrier in tcp_push removes the bug, similarly to the
> previous commit bf06200e732d ("tcp: tsq: fix nonagle handling").
> smp_mb__after_atomic() is used to not incur in unnecessary overhead
> on x86 since not affected.
>=20
> Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu
> 22.04 and Apache Tomcat 9.0.83 running the basic servlet below:
>=20
> import java.io.IOException;
> import java.io.OutputStreamWriter;
> import java.io.PrintWriter;
> import javax.servlet.ServletException;
> import javax.servlet.http.HttpServlet;
> import javax.servlet.http.HttpServletRequest;
> import javax.servlet.http.HttpServletResponse;
>=20
> public class HelloWorldServlet extends HttpServlet {
>     @Override
>     protected void doGet(HttpServletRequest request, HttpServletResponse =
response)
>       throws ServletException, IOException {
>         response.setContentType("text/html;charset=3Dutf-8");
>         OutputStreamWriter osw =3D new OutputStreamWriter(response.getOut=
putStream(),"UTF-8");
>         String s =3D "a".repeat(3096);
>         osw.write(s,0,s.length());
>         osw.flush();
>     }
> }
>=20
> Load was applied using wrk2 (https://github.com/kinvolk/wrk2) from an AWS
> c6i.8xlarge instance. Before the patch an additional 40ms latency from P9=
9.99+
> values is observed while, with the patch, the extra latency disappears.
>=20
> No patch and tcp_autocorking=3D1
> ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hello=
/hello
>   ...
>  50.000%    0.91ms
>  75.000%    1.13ms
>  90.000%    1.46ms
>  99.000%    1.74ms
>  99.900%    1.89ms
>  99.990%   41.95ms  <<< 40+ ms extra latency
>  99.999%   48.32ms
> 100.000%   48.96ms
>=20
> With patch and tcp_autocorking=3D1
> ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hello=
/hello
>   ...
>  50.000%    0.90ms
>  75.000%    1.13ms
>  90.000%    1.45ms
>  99.000%    1.72ms
>  99.900%    1.83ms
>  99.990%    2.11ms  <<< no 40+ ms extra latency
>  99.999%    2.53ms
> 100.000%    2.62ms
>=20
> Patch has been also tested on x86 (m7i.2xlarge instance) which it is not
> affected by this issue and the patch doesn't introduce any additional
> delay.
>=20
> Fixes: 7aa5470c2c09 ("tcp: tsq: move tsq_flags close to sk_wmem_alloc")
> Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>

Thank you for the great analysis and the extra iteration! This was
completely non trivial to me.=C2=A0

The patch LGTM=20

Acked-by: Paolo Abeni <pabeni@redhat.com>

I hope to see you both (Salvatore and Geoff) more often on the ML.

Cheers,

Paolo


