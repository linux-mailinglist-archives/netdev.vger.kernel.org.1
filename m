Return-Path: <netdev+bounces-90479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95198AE3B2
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687141F24DC1
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91647E573;
	Tue, 23 Apr 2024 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsKNioUf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC25D903
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871148; cv=none; b=LTdS146rmgDaD2pRQLF56N12pawjOFk19jbrcNLTb3AVXiS1QyC+BEdJtetviZSUmvnnk+kWOR2LGe1rd5bM+8Pv3EL1GjMPIIrkBgp33FCi63lhLLcrGscrzdN1LbuqNvfIkGZl9MnA5HUyJ6iNjM3bmgC7lKQhb2vRWJmHL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871148; c=relaxed/simple;
	bh=KZP9VCw1/Uo3VBFKKbE8e0yd9jVZbtVuTAHNJpHQ5Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nup0RnXh/VvR8QiMMVsAYS+5wPuMhQ9+Osf6gfGgfkiagRUrVkoA9D091FJRXw+T+ElQTo2lMU2r3dM1LnXK3AhaOtt/jckQeFhJ1D5DxHszOI7EsYApCLQx7XqtAWdCMod4pbGdlmR09ak4uy8Flo1YSQYJtAL/jwxUrqBQ5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsKNioUf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713871146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KZP9VCw1/Uo3VBFKKbE8e0yd9jVZbtVuTAHNJpHQ5Jc=;
	b=BsKNioUfbDVheG1ifg+yp4O8H2F4QsPEFXc0kbwromeFo/sgx571BaD+KwYfV0JlCWSIbP
	zcQRA3PN4WoBLyuCx7G3G9xB7WlBGzXRuxVNgfHCNF5IZHlubaWhThRLD+1986+Mbz6YFI
	PZ3gT/s725QNkOweJsno5UzqLKhIS4Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-idvCz6lBNniVrWeDjEyEOg-1; Tue, 23 Apr 2024 07:19:04 -0400
X-MC-Unique: idvCz6lBNniVrWeDjEyEOg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a5874093a21so77557566b.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871144; x=1714475944;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZP9VCw1/Uo3VBFKKbE8e0yd9jVZbtVuTAHNJpHQ5Jc=;
        b=azC7i+q9dUoQdOqSwy2up0XB6LempeB5yQFU/2/s6Wu0jjohtxNAQKlDZDsNyaouMv
         wH4LGTlhz909kWJog3aeLs/nOH7SobcM2Zwj+tGCqn+GeUabrcWsYbklTy1XjyzhFMch
         go8OOuJ/yRXKPAy6m7YxLUr/cjnoDqSXn/uKoKGeFDGr1yicfJZp5CvjtUlV/qTelrQW
         YjtJYn8FsfMilZQfHWWIcI1YJAzp93s9wzx5arrEB37QoMFx87Jx3d9keDK+LXzFjEt8
         UQKlEiMHP5vmD84pUbH3qBLUwG+pFvQkfWbfHEZ4Ot85ymO0bgShbvrl47gjOgO+P//8
         kh/A==
X-Forwarded-Encrypted: i=1; AJvYcCXse1tAUXYfg6gDBtHeDxTE1xaC4o3hGIrBwM0KzJqz63czhjxH4Ar54R9uonILIavrt08h/RPHE5jggqF9u0e9YOd7QDjE
X-Gm-Message-State: AOJu0YyAogQa98Fonrkuuh6FaRL1D3UcTAhfT74HYkqHK3MCGeAKXOXz
	Ly40DWaGcydp/G3fbCrmHqakzCciyTxJh8jwZjsIJFqTVBoJEfNShfTv/ObciCig35/BU+oOhGa
	B/blF6OVTWHjlTUvRqyhA6a6j7nrUv0/V4A6n5M+2rTFpNIsb8wB6cQ==
X-Received: by 2002:a17:906:3b59:b0:a56:4c83:fcb9 with SMTP id h25-20020a1709063b5900b00a564c83fcb9mr3406821ejf.55.1713871143836;
        Tue, 23 Apr 2024 04:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaCMQYjFIyeyYbxA/+uCn7lL6cZiX8H3MkJhY2sRHk6IUsyj3HEaxdCPeuK8Ec7M09N3WXDw==
X-Received: by 2002:a17:906:3b59:b0:a56:4c83:fcb9 with SMTP id h25-20020a1709063b5900b00a564c83fcb9mr3406799ejf.55.1713871143460;
        Tue, 23 Apr 2024 04:19:03 -0700 (PDT)
Received: from [169.254.21.156] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id ot15-20020a170906cccf00b00a5239720044sm6912925ejb.8.2024.04.23.04.19.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2024 04:19:02 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Jun Gu <jun.gu@easystack.cn>
Cc: pshelar@ovn.org, dev@openvswitch.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [ovs-dev] [PATCH net-next] net: openvswitch: Release reference to
 netdev
Date: Tue, 23 Apr 2024 13:19:01 +0200
X-Mailer: MailMate (1.14r6029)
Message-ID: <77015793-E8E4-4AD0-A032-9E0A7F7F0865@redhat.com>
In-Reply-To: <20240423073751.52706-1-jun.gu@easystack.cn>
References: <20240423073751.52706-1-jun.gu@easystack.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 23 Apr 2024, at 9:37, Jun Gu wrote:

> dev_get_by_name will provide a reference on the netdev. So ensure that
> the reference of netdev is released after completed.
>
> Fixes: 2540088b836f ("net: openvswitch: Check vport netdev name")
> Signed-off-by: Jun Gu <jun.gu@easystack.cn>

Thanks Jun for the follow-up! The change looks good to me!

Acked-by: Eelco Chaudron <echaudro@redhat.com>


