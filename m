Return-Path: <netdev+bounces-79407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3AE879153
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 10:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3671C22009
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0A7828B;
	Tue, 12 Mar 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J77wBx3w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4C7AE4A
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236818; cv=none; b=U+U79WOFsxhY8H2ZAY9txSPkBVtURE7+YCkp9yuylhL7TP74wqaG3bJUmRf7FFnPzL/h6ThK6IoYCvPz0vRN3wqk3SDilnYBQw4FgG82hHIYTQIGnHNolWDl/Y+WQdFk6xHD6iVRRn+ZIGIZKB9HEdyeBz17sVimszqH87qTbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236818; c=relaxed/simple;
	bh=5otCRl5pErtbppJebFHlL8MKqzjYD6gnhXrZ3/9m+hw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zi9jch9cAQAgS6AkMFObv7LJEeiAeicRFGPZggGvN08q2W87SKCJxVpIBseB9lSkcnmewlohg5hYm75mmCtccmWP+AtoeQKZXn3o24DgqzeC3Hyuy3038fQ6JmoQ3gfq0va7vvt3HHAFVj6MmfsVwrDBLrADHCOEX+rPAI6spIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J77wBx3w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710236816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qc7FUh+n3XyKdyc0ndX7maRU9MEDJXiP0LuYvtKNTVk=;
	b=J77wBx3w/YtZWXdPvKQ7v3A8qLm19Caq7+c/WSazTcsxZaTDAOsJVYFi71Nods66Ic0UuI
	wtwrvqNqd4bXMIOcfbesteO0iSCpKPcCiISXMpWbvE3XsuIQtvW0y1eatMiGllU24uTDEy
	VG/PoAd6Hx5aB25erbhNpoK1sN7bkUw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-8ikI2YjQOACo2DAZfxUnow-1; Tue, 12 Mar 2024 05:46:54 -0400
X-MC-Unique: 8ikI2YjQOACo2DAZfxUnow-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a463175feb6so1819466b.1
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 02:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236813; x=1710841613;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qc7FUh+n3XyKdyc0ndX7maRU9MEDJXiP0LuYvtKNTVk=;
        b=mK4g/4D1bX7ZzNmVhLBU43wDxXWYMR4Z7T0BCZnDaRKikgz+TZofb4B5T0eUkcfs6N
         u3s9UPwcAP3bzvAI4al4/K4a4tiWQ0BDTehNjCW1Lt6aRzM8yPVqsfZTaz6+Tg6L1doE
         3xKW78GGpLMlH1uIfc2qU9oXfCtUz64fR3srTRfNkEiOG1vg/TFNP9jjDraxnQ94ghE6
         90AYyL20CY68QkH5uL0sjS2uKjM2VZneggLJT1Z8198wOpNlM8UMA0qPqKoqX83HKr4W
         tHAOTJhdtcLz2UP2+CdLTB4rmbzS9GBZxuhfZxRQqdFA9TyfvrdBHgiLi7LdtPv4/rhp
         ywDA==
X-Forwarded-Encrypted: i=1; AJvYcCV7CFwSMzAmThXQflJIz9krNHw/+GhmMq7HylcvLspJhF/anXiSVf9QUrgP8i6B46DwQh9sM9vLPTNGnjNOaCC27fmsW8wD
X-Gm-Message-State: AOJu0YyupKjrfLoci6CxYbMBIB/7DSQJenB2QdNyLqIGVeds2jP8uuim
	G/2TsblGK8uggzeBppQ1qjlKLZboc/oEVCVvjF8rrXExIYUobRPzlfYOB8P7pH82M4RqwIQdcuX
	FYX8Gf6Pq3RyR2fpfjs0dKLHbjJx1Z0Cp7zgXg5clDqGJmE81rB+owA==
X-Received: by 2002:a17:907:7814:b0:a45:da3d:dc5e with SMTP id la20-20020a170907781400b00a45da3ddc5emr6527399ejc.3.1710236813594;
        Tue, 12 Mar 2024 02:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRHJP6id7Gi76itlDwyNKS39wtESQR4v/UTUkzJNWlLMaCvEiK7xP+LDQSKZeeKCfaJky6JQ==
X-Received: by 2002:a17:907:7814:b0:a45:da3d:dc5e with SMTP id la20-20020a170907781400b00a45da3ddc5emr6527377ejc.3.1710236813199;
        Tue, 12 Mar 2024 02:46:53 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-128.dyn.eolo.it. [146.241.226.128])
        by smtp.gmail.com with ESMTPSA id n18-20020a1709061d1200b00a46478fbbbesm295133ejh.153.2024.03.12.02.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:46:52 -0700 (PDT)
Message-ID: <f856e5cde69b2f99b8d4c6afac32ab82245d8130.camel@redhat.com>
Subject: Re: [PATCH net-next v3 1/1] net: bridge: switchdev: Improve error
 message clarity for switchdev_port_obj_add/del_deffered operations
From: Paolo Abeni <pabeni@redhat.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Jiri Pirko <jiri@resnulli.us>,
  Ivan Vecera <ivecera@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>,  Eric Dumazet <edumazet@google.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: Simon Horman <horms@kernel.org>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 12 Mar 2024 10:46:51 +0100
In-Reply-To: <9fb980b65b8b4bc7c994cdfa1bac72e3f7c5677e.camel@redhat.com>
References: <20240309063238.884067-1-o.rempel@pengutronix.de>
	 <9fb980b65b8b4bc7c994cdfa1bac72e3f7c5677e.camel@redhat.com>
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

On Tue, 2024-03-12 at 10:43 +0100, Paolo Abeni wrote:
> On Sat, 2024-03-09 at 07:32 +0100, Oleksij Rempel wrote:
> > Enhance the error reporting mechanism in the switchdev framework to
> > provide more informative and user-friendly error messages.
> >=20
> > Following feedback from users struggling to understand the implications
> > of error messages like "failed (err=3D-28) to add object (id=3D2)", thi=
s
> > update aims to clarify what operation failed and how this might impact
> > the system or network.
> >=20
> > With this change, error messages now include a description of the faile=
d
> > operation, the specific object involved, and a brief explanation of the
> > potential impact on the system. This approach helps administrators and
> > developers better understand the context and severity of errors,
> > facilitating quicker and more effective troubleshooting.
> >=20
> > Example of the improved logging:
> >=20
> > [   70.516446] ksz-switch spi0.0 uplink: Failed to add Port Multicast
> >                Database entry (object id=3D2) with error: -ENOSPC (-28)=
.
> > [   70.516446] Failure in updating the port's Multicast Database could
> >                lead to multicast forwarding issues.
> > [   70.516446] Current HW/SW setup lacks sufficient resources.
> >=20
> > This comprehensive update includes handling for a range of switchdev
> > object IDs, ensuring that most operations within the switchdev framewor=
k
> > benefit from clearer error reporting.
> >=20
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> Very minor nit: the reviewed-by tag should come first it that has been
> collected before posting the given revision.

Oops, I almost forgot another very minor nit: a shorter patch title
would be better, ideally fitting 72 chars.

Cheers,

Paolo


