Return-Path: <netdev+bounces-159290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3C8A14FAD
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6368168B3C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B41FECC1;
	Fri, 17 Jan 2025 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ais6Urze"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666071F7917
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118390; cv=none; b=N45LjVZyPcnqfNgwsUkfKxqioYY345im1r6tvRFUutIgP+eh2Y5k62NRv5+i54ocg6H/LIzlIV6kAbPSe6WSExGM7U+VZSNRDOwaq0FVi5ub0eT1kWO/yguCQKSywhXTQbHBgo/Wzpb4W6FC2gxmGdIF/dZyugGzOzmVm+GpMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118390; c=relaxed/simple;
	bh=qN6oQdM0gmq9bZuCu0hFeMmKij2Q4XKghqJIhff84jU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b0eFiJdoAjb+Egp7IDSu63f/I+NHREE7tNasfSGyAUzoI1GuwmFQ90vHUTkB0cnsXzPntM9U+bhyBbsDS2OWCq7wJKkw8K4q3DJzN2it28JPbOoen949TFmabYHFcWDWblviDpC7VMl+EDjGpBvJ1zrjx/xjLRQtpzz5RY38MgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ais6Urze; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737118387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qN6oQdM0gmq9bZuCu0hFeMmKij2Q4XKghqJIhff84jU=;
	b=ais6Urze9Hz61k47VIL93sPL3uGdTbsrTIfI7DZobbHIpiVnYr+thJmcj+d7SsIySvYoWt
	zwZmcjytQ70EQi8j56t3agoylIkv2YYEk7sIBUmJ3ufJk6SOrr/ZgTP5HRQXC7nlqnHPX0
	6JBMieRBQyJV3I5uS1EXRTiuRBW+JMQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-tydmje8_MNGgsAQ5FEk3bw-1; Fri, 17 Jan 2025 07:53:06 -0500
X-MC-Unique: tydmje8_MNGgsAQ5FEk3bw-1
X-Mimecast-MFC-AGG-ID: tydmje8_MNGgsAQ5FEk3bw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa66bc3b46dso173810366b.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 04:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118385; x=1737723185;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qN6oQdM0gmq9bZuCu0hFeMmKij2Q4XKghqJIhff84jU=;
        b=quG19wZFiQs0vYRwO97JOpp5ZzCEtN9sKDUsGFncR2kHR5t7Ia/Q8agjm55/p6EOUo
         /Cjh1uv7eHfDexYj8/pSS4LpLheEUcVzo++x0k4trUWcOSsleYxVoj7iRvav2Q3e5Ix/
         q1SAx1mq3wXO5vADTLMhiVApZnta2AKku0idrnqBlKvsyZ2nc81Rl0LnCD+0qDiPRDo9
         asaE/J8sW0J09740/zueJFlX+mZJuL1qnz+BTp3ChHOfoxuw0x4MYiYjlUOmAAfosWp8
         Njb/s7bCSisd1WeHZ08wskB/7p8Goa+IHW7gQopcViJde8Guvsqbcuo3NaO3QBZt14da
         A98A==
X-Forwarded-Encrypted: i=1; AJvYcCVexxBR7U1Nc5GvnbVx9Cn6KL2tjfYNjL9WNH4CRtDrYL30BB/VC4uhXdyod0WfxIHHvum3epo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4e8xRegYo3cwWRpTp+40adcjXioGCmEbMbVRONWqVpf+QJKkM
	Gx1CGIv3I9rWwenpnv9+fOvSUfbD0Yctss/O94wMKTeiup6VeHwlagAk+FlecqpXHpc1wo8VqFb
	vMIZk1ep8cVqbVcLCkhlrML92B71/oV34Da9nNINf5pAs51usTnwoXw==
X-Gm-Gg: ASbGncuA/EnVlUfRD5338yIWKqST3kAWcgQk9n5x3TeSPR5yx7p4Wb2tv7v16yfjPhq
	q1bNMzRkOvCrn2zoCeAmaYoNVrAMgxWisOPhayZY7+SgjVBOofDbzDsz0OP7Y9yvJI7WrgSxmQx
	0tSKzZBEwcx+Kp0IkUfKYlORh9fL13PVB1oOqSZWvxuNYLLmcodMdICwFickh/LTGCgwt5lzc14
	Gaanhio3rNOTyuRMFWhpb4b8bth0vswc8bUDWeLE3mAdt861klmgQ==
X-Received: by 2002:a05:6402:518d:b0:5d0:ed92:cdf6 with SMTP id 4fb4d7f45d1cf-5db7d30114amr5261873a12.19.1737118384727;
        Fri, 17 Jan 2025 04:53:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECEDgqEa9N1u7Nf9uT2ewMSMFMEzvISL0C0K2RPIRXP5iZTwga5ZJuTpP90f83OYACuxDQZQ==
X-Received: by 2002:a05:6402:518d:b0:5d0:ed92:cdf6 with SMTP id 4fb4d7f45d1cf-5db7d30114amr5261800a12.19.1737118384305;
        Fri, 17 Jan 2025 04:53:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670d52sm1471453a12.24.2025.01.17.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:53:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4674017E786F; Fri, 17 Jan 2025 13:53:02 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] bpf: cpumap: reuse skb array instead of
 a linked list to chain skbs
In-Reply-To: <20250115151901.2063909-5-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-5-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:53:02 +0100
Message-ID: <87a5bpob4h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> cpumap still uses linked lists to store a list of skbs to pass to the
> stack. Now that we don't use listified Rx in favor of
> napi_gro_receive(), linked list is now an unneeded overhead.
> Inside the polling loop, we already have an array of skbs. Let's reuse
> it for skbs passed to cpumap (generic XDP) and keep there in case of
> XDP_PASS when a program is installed to the map itself. Don't list
> regular xdp_frames after converting them to skbs as well; store them
> in the mentioned array (but *before* generic skbs as the latters have
> lower priority) and call gro_receive_skb() for each array element after
> they're done.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Clever approach. A little hard to follow all the memmoves, but I think
it checks out given the description above :)

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


