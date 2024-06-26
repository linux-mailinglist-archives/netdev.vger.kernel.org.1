Return-Path: <netdev+bounces-106952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571CC918423
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1296D28880B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E252818735C;
	Wed, 26 Jun 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8YL5tRn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7BF186288
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412093; cv=none; b=Hqbb9h8N/LfR0uF6S1z9arAL4z+L9ZHVS+wg5dAxgh0Ghr85w+0Tx0ZLfysWs8BWtOHT0DWbcpNr+Ye21w5FhFm2e/we+9G4rQ6IJQXJxu7d+gf2ko/irC9d+dOPepxZ7PfBtfpjAVpa6NwrSJQuzfw8n+ygaeZn/srqP5tzC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412093; c=relaxed/simple;
	bh=c6cuNR/ypZS9cGEPNgMyok0ts7gHixlzmHbjChBa//E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrPIeK7O5+Nlfqdw9o/jPp1AdLF0CvoUw8UjeXbfoMNSCYQvim7GaO0BP3VXp6gDLna6ftwKHFG5/snsur+QtvmVbwho5Sya7OFwvLHMVmtrZXGN2eKedalJnF3xyS7IIW1BGoqJcyTmu4+chhJv4KD/GgG2Oj3mLHoiwgYxbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8YL5tRn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c6cuNR/ypZS9cGEPNgMyok0ts7gHixlzmHbjChBa//E=;
	b=e8YL5tRnubLRzRpz6RP1NzAog5cAOXAx91OoO3ChubLv6mjUm2wMQWA17gz23xgSuK3not
	RZesmTD5IaJvkg9Ps2MyVhVRpyn6IQfyLHmdUMYguOD7KvlnGJmyLnMr3Zw/cRH1tfRilY
	sA71Z0AFRsvx1Btk2Mxn4HJ4QP1DUdo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-uuf18rHiPC61UCKQM4CB0w-1; Wed, 26 Jun 2024 10:28:09 -0400
X-MC-Unique: uuf18rHiPC61UCKQM4CB0w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7169b4cfcfso190916766b.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412089; x=1720016889;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6cuNR/ypZS9cGEPNgMyok0ts7gHixlzmHbjChBa//E=;
        b=JW7OZupN+v35mHJjdmC0S0jvqr5VGDpjH0opPyTGqpl1ZEhaJ/44lFxR8eadP2bHoS
         22w8LkeBlNfrmtsuVIZAT6gkR2rkK65alnp3LiviBNJdXQeb0m7Vr2TN21ONH97RdWSu
         tA2wuyskSBZy1Xf4MJ78lM+TByXZJ7JkXzhIcjJGvFT554Aw0c4FH8MZsXeiBHueYFdE
         tuwdQICvzVUuEmQiWLWOSJEjDiXOTxGXG9g6dsV2g50uzDzmOAp4K8/wVxBq4phQwbRM
         bfXjDHh6MaHtQNIrUz/+d7gYRMNNo7QUHYySf/6IY+UUCZNjEzvgYnLanjJW7Jey7pT/
         z3DQ==
X-Gm-Message-State: AOJu0Yw5sYEhO1Ao/o4+wjvbUZB0pl6Z3ReBvHTGyHse9fpp9rsiV9tc
	dMU+8ynMJesRguxuBIvIEXUDLsdKAR8atwKoJppPwNckH5DNZqnp2yNJ6zOQw7J65cu1y5Agr7B
	ubyUxVliMm6JO6LR4aNtLvfDAf083g9Zv6Kk9Gl9Y8VOZcIi9bBK1tg==
X-Received: by 2002:a17:906:11c7:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a7245bacda1mr597295266b.37.1719412088798;
        Wed, 26 Jun 2024 07:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErnyGXF92mNUgOBZBMQOObmC5OIulbtMrV/oeymqUlbkWGwntzFEOPkPZKKgzMJuOQUL7mTA==
X-Received: by 2002:a17:906:11c7:b0:a6f:4a42:1976 with SMTP id a640c23a62f3a-a7245bacda1mr597293766b.37.1719412088405;
        Wed, 26 Jun 2024 07:28:08 -0700 (PDT)
Received: from [10.39.194.16] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724ae806dbsm383611766b.41.2024.06.26.07.28.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:28:08 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 03/10] net: psample: skip packet copy if no
 listeners
Date: Wed, 26 Jun 2024 16:28:07 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <51493A9D-9E73-4BFA-95D9-79CE1356110A@redhat.com>
In-Reply-To: <20240625205204.3199050-4-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-4-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 25 Jun 2024, at 22:51, Adrian Moreno wrote:

> If nobody is listening on the multicast group, generating the sample,
> which involves copying packet data, seems completely unnecessary.
>
> Return fast in this case.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Acked-by: Eelco Chaudron <echaudro@redhat.com>


