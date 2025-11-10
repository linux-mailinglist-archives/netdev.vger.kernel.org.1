Return-Path: <netdev+bounces-237264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF85AC47D3C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A844A1543
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E328D277C9A;
	Mon, 10 Nov 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ab8K8VWU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1BB228CA9
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790688; cv=none; b=G9HTpc0H8LyRfPNO7grN4r2JWOvBzseql58Qy1xkYyQoU3ApOSCLMXgRH+gjuvUPD7NLkY5Drug1rjnG4AkkMM/UY9qd20jZAqPZeewMzxfLfCIS9EgxZpTUAEwATRq4pA1XdaXGcMynFHoU8FzXNeQLjZA3Zjpr8m8FtBv+9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790688; c=relaxed/simple;
	bh=xsCQeyVupDZ70P10hcuA2gENJ0NgW9gpLTOfi9ZPS6I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Xg2F5/orVBrE2jyX0ix1U7mmo6PI9CCLmFJfHU6So3PS6Y4ptXigaMCWrflmM3fT5y12EfBqKtD/GCaK59n1zSbZA2vxfxSSq/Dom/rh3WBdCMI3uG/J2y/Vv2tvhoBZ1Q9AY7I6tEposN/jJl/us9h2+hOUOxnHkOnmF9IZ0j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ab8K8VWU; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-298145fe27eso14791575ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790686; x=1763395486;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsCQeyVupDZ70P10hcuA2gENJ0NgW9gpLTOfi9ZPS6I=;
        b=EoHYyWu9H5ELDFu6EwGWPTN76mVBkHhyUcQ+6dp2q9go1SocHlgA9TSy0Q55mFzBK1
         vGnmAbhXrKaI/6A/JDKSsZOrUxpCeP/lZ0W4qfabiwzSN0ifpqn4A0KatBsnhNPHNyjW
         E+CofvLnCagT5jbRr7PyfUIsGUfwaPig5Sc/poXuAjl68wGxLzOEPndc8M5QVLf5S0qv
         tQavWZhtVOzLmQaUg7P2OmQlg7IN+G79WR7XK0fYAHF3rgOgAH0+0WAZsIw2vUBDkeek
         /b5PB9OMNbuChipKwd1/h/ujReVJHIVXynaaZxcqjUfS4hbQfTUPZInqTPput9nq1/To
         do/g==
X-Forwarded-Encrypted: i=1; AJvYcCWM6sgKMAiGW4MmIdSmXwvy8ZFfXK8xSXcOwGmbGK2mrbp5NwabizTP12RQomU8aqRXSIgKFWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIPKyw0nKYcTCQsCFbwkmfA2tgTUs4S4qekeTca5g9ThysVaZK
	v7Zju4vWjvFiMqg14nWLRIPV8yJ8SDxCgE7Irdj1e/PKAkwvL4ehPPtrVYWK8SckOuvKUaHZRUI
	ANuIBD6Jo7rWLP6GqhAXXOJqHBY6eHMc6S3mDQZYBmbwkgY2QGKaRSPZDS57VgifESSfY38SRTK
	NE5B6K2jk+nniwg92o2tKbS2J1470oWZnNjiTHzYodxUY4u60TogSVd9y2kc9+Njv+Pz1SZTn3X
	hOPWQk1KPhwVOY7
X-Gm-Gg: ASbGnctkVGqO6Lc4hIDELBQTOIIIUBoBgoJVJv94RTEeOZXZZq33sg8XuoIlU/7mslX
	JUTkZ+JQD5LaXj3kXNyD6oSdf9S7rjbT8/B4utzb/bO973fpYoCBqPffuXlJK6bdP7Rfr0vPWLp
	jUCMxE8fgZGy3saIz2PUcvOlyr5Lw/tgau5tYH5qQPnL6dMGptfq6sgQdOqeEUGy77vTtHJOSrP
	MwzHEPyTROEQlWn/5NO3jvlGX9wsNRDpYY0sC5fKQ4bxtExwJraBNiM92a9xDkw+PiA0AhZ08L+
	WzizF33Qv9xt5GqNLafYCyH2ixfH3GhPcsBIeOl5yC+vEvZRPHN1DBgJhD84gkAG8OQomP+EygP
	spD9pQGtehVV8ftycjU7KketzUsIUAzCjcIXsyLdBAjS3iiPCYbALlaLP7N3tU9JtVI6/0zRANn
	VOhh1T92WCV6VI/bR0A5rd/TOiHEv5XvBLABMr9Ro=
X-Google-Smtp-Source: AGHT+IF2maxCxijobChX5udhhWHRhWV7xhkRyQwFJ9OvYqtpBX6QsZQ8IJJmXDYIXNvARkjFyaIc1N/bmHtA
X-Received: by 2002:a17:903:2311:b0:295:9e4e:4092 with SMTP id d9443c01a7336-297e571bcfdmr113815895ad.56.1762790686300;
        Mon, 10 Nov 2025 08:04:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-298009d834asm6173285ad.16.2025.11.10.08.04.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:04:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b0e73b0eadso7152350b3a.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762790684; x=1763395484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsCQeyVupDZ70P10hcuA2gENJ0NgW9gpLTOfi9ZPS6I=;
        b=Ab8K8VWUF5lFwcaG39BN5HRtuy9WBb9T70SvNmz4gmr7sHFpvzg+OKkemTCI5ZWjHr
         0/Lpm0iinaZ3b2lw29bq11wI8hJj2eRT8u0FaP0gVIbV7EHdcHoGpmGj/HVLDMleKwQY
         Z0jILx8VfyBykGbgc9/tKj8QhSZ5zRrhHbQgY=
X-Forwarded-Encrypted: i=1; AJvYcCUQNusjJTL1VwxjrfjFVVi/Jg6jmhSCWldgp3433871Ri+zu/M8q2v8K3c8FLdqhBpZVHbuaig=@vger.kernel.org
X-Received: by 2002:a05:6a00:bd83:b0:7a2:83f2:4989 with SMTP id d2e1a72fcca58-7b225aea11cmr10247674b3a.5.1762790683943;
        Mon, 10 Nov 2025 08:04:43 -0800 (PST)
X-Received: by 2002:a05:6a00:bd83:b0:7a2:83f2:4989 with SMTP id d2e1a72fcca58-7b225aea11cmr10247634b3a.5.1762790683437;
        Mon, 10 Nov 2025 08:04:43 -0800 (PST)
Received: from ehlo.thunderbird.net ([2600:8802:b00:ba1:b6a4:5eaf:bf66:49de])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ca1e718asm12233192b3a.30.2025.11.10.08.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 08:04:42 -0800 (PST)
Date: Mon, 10 Nov 2025 08:04:38 -0800
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 =?ISO-8859-1?Q?=C1lvaro_Fern=E1ndez_Rojas?= <noltari@gmail.com>,
 Vivien Didelot <vivien.didelot@gmail.com>
CC: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net=5D_net=3A_dsa=3A_tag=5Fbrcm=3A_do_?=
 =?US-ASCII?Q?not_mark_link_local_traffic_as_offloaded?=
In-Reply-To: <20251109134635.243951-1-jonas.gorski@gmail.com>
References: <20251109134635.243951-1-jonas.gorski@gmail.com>
Message-ID: <BBB3B106-E173-4098-A90A-3A75C2C545B6@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On November 9, 2025 5:46:35 AM PST, Jonas Gorski <jonas=2Egorski@gmail=2Eco=
m> wrote:
>Broadcom switches locally terminate link local traffic and do not
>forward it, so we should not mark it as offloaded=2E
>
>In some situations we still want/need to flood this traffic, e=2Eg=2E if =
STP
>is disabled, or it is explicitly enabled via the group_fwd_mask=2E But if
>the skb is marked as offloaded, the kernel will assume this was already
>done in hardware, and the packets never reach other bridge ports=2E
>
>So ensure that link local traffic is never marked as offloaded, so that
>the kernel can forward/flood these packets in software if needed=2E
>
>Since the local termination in not configurable, check the destination
>MAC, and never mark packets as offloaded if it is a link local ether
>address=2E
>
>While modern switches set the tag reason code to BRCM_EG_RC_PROT_TERM
>for trapped link local traffic, they also set it for link local traffic
>that is flooded (01:80:c2:00:00:10 to 01:80:c2:00:00:2f), so we cannot
>use it and need to look at the destination address for them as well=2E
>
>Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
>Fixes: 0e62f543bed0 ("net: dsa: Fix duplicate frames flooded by learning"=
)
>Signed-off-by: Jonas Gorski <jonas=2Egorski@gmail=2Ecom>

Reviewed-by: Florian Fainelli <florian=2Efainelli@broadcom=2Ecom>

Florian

