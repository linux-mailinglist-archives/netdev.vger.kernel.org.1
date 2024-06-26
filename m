Return-Path: <netdev+bounces-106736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12629175D3
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6992E1F2148A
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59A7171AD;
	Wed, 26 Jun 2024 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gttAHoTN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664BBE6C
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366337; cv=none; b=SyHMSAsBg0HJac15oHpPdvCtsbhfY7krkH9h+65LdgM3+oEKBzmgzacrlohvl7lrCzntxaexwMQWGHuYVMoNOddcj+LPp37sn7Rak5UMj+ORgKKUnGuhVa1kcQT8Y10RahGxs8yDzRgESgN8zJzeOoH9c0JRyFfDn1NcpgNBCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366337; c=relaxed/simple;
	bh=3u9DchcBWqEg+EucW73spHNC6ivrtjkXb6CPutXzAv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBHsNzQb/Aj0oRcmPZBWdUh87iVENVQYIuRt6JuZyGTy+Q2YmSnzNk/VFssU/A/7W2d4YKbKh7kLeQSyO/E+00qtCd+FFV31joLDKctLcKiZA/tQI6d6tmAOhocW4An57I2N6Rjbm4cLRxqgKQ0kXeaF8epgKEg9WXPiEwywi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gttAHoTN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719366335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zm4ZGAMAEzALYJd1NNHLmIL7EFq9IvdfBHS2qeGf/kg=;
	b=gttAHoTNbUxewVlZl99O6J67q1Vd2/B0DhFwd88i+W7iHMaU06k7bGHi+OPnUHE8R6uRIZ
	yyTF7Hl7LUl23lMKj6TshBY4jmm29R8PrWliJ3xXrTrXMhjkDzWiQFennQFBZuA5W5/ti+
	R0Z29/WRK/JhYGZaXDXn2XHE74ok2p4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-g91mBMPtPgOIXRPzvvv8Bg-1; Tue, 25 Jun 2024 21:45:32 -0400
X-MC-Unique: g91mBMPtPgOIXRPzvvv8Bg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ec4e579e76so35288151fa.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 18:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719366331; x=1719971131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm4ZGAMAEzALYJd1NNHLmIL7EFq9IvdfBHS2qeGf/kg=;
        b=NtxVUZWzd/1dqMtc/Qeyo2SqK399RkvQDDeJmKg3tsJbjI3oZ2QkvnP20Ev1NIzVb1
         xov6LXL+G7OTt7c1xqn3S/s1BYLuSR9wyf6uSj9Q3Rt6h2dOd97It66vdad6N15byfkt
         B1SSqYWTM3iwcDA0lQ94xDuG/VcRWiWo8EXrq3mJ5Jc46bGyv4F9EicBEqxpwHH61j8A
         uoWDFTMb0tJhFm2813fbHF4u9EOu8xc4MwbQPdy0BNdSY+bGcgwS98LTNrHn53X7VZVR
         NviTB3ySaAt0rxGxWaqNAGzKu7lumKWdh/hBrvdjbxsBmYvoN7tpCiVb8YYF29386yx9
         LwCA==
X-Forwarded-Encrypted: i=1; AJvYcCUfVy+Ze/IGxY00zBvuJuJimwh8LPtdCBEAmSdrQmbEQD1rzkQxhybIjN7X4++wnHFe83iDNxgXUBnd8BtYiZhLKAMb1ZJ+
X-Gm-Message-State: AOJu0YyEvOvIJt9AK/DHdAybwp1pC1FZto6fjGEsPzAsRYVvvmQQByjN
	jQVP182j30lKh1mnEbLZcRxSnqdxlbORev/uXh55fikifc2+v0HPb6LpTqZ8diS5q/bAgGx0aVA
	kIVd5oPS5Po/d9rdud/QIwgpQni0hCZpbLx6JqT3Lpsqq7yfhpa8fH9ZZIfkYpLfFUqks8fSXK+
	faWp6AsYE/zRpm03wTOYJAgG4Rf5JjkqxUky2/
X-Received: by 2002:a2e:9684:0:b0:2ec:53a8:4b3e with SMTP id 38308e7fff4ca-2ec5b387fcamr51824771fa.38.1719366330845;
        Tue, 25 Jun 2024 18:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFyfsfHjbw/eAr9nRtuFgDufzjtUAZeIkXSWW65AHErjzSV1gBpTz2ywqRAEU9I8YB/eCLbLpDjY7IGg0HhVE=
X-Received: by 2002:a2e:9684:0:b0:2ec:53a8:4b3e with SMTP id
 38308e7fff4ca-2ec5b387fcamr51824661fa.38.1719366330480; Tue, 25 Jun 2024
 18:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624141602.206398-3-Mathis.Marion@silabs.com> <20240625213859.65542-1-kuniyu@amazon.com>
In-Reply-To: <20240625213859.65542-1-kuniyu@amazon.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 25 Jun 2024 21:45:18 -0400
Message-ID: <CAK-6q+gsx15xnA5bEsj3i9hUbN_cqjFDHD0-MtZiaET6tESWmw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ipv6: always accept routing headers with 0
 segments left
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mathis.marion@silabs.com, alex.aring@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, jerome.pouiller@silabs.com, 
	kuba@kernel.org, kylian.balan@silabs.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	Michael Richardson <mcr@sandelman.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 25, 2024 at 5:39=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Mathis Marion <Mathis.Marion@silabs.com>
> Date: Mon, 24 Jun 2024 16:15:33 +0200
> > From: Mathis Marion <mathis.marion@silabs.com>
> >
> > Routing headers of type 3 and 4 would be rejected even if segments left
> > was 0, in the case that they were disabled through system configuration=
.
> >
> > RFC 8200 section 4.4 specifies:
> >
> >       If Segments Left is zero, the node must ignore the Routing header
> >       and proceed to process the next header in the packet, whose type
> >       is identified by the Next Header field in the Routing header.
>
> I think this part is only applied to an unrecognized Routing Type,
> so only applied when the network stack does not know the type.
>
>    https://www.rfc-editor.org/rfc/rfc8200.html#section-4.4
>
>    If, while processing a received packet, a node encounters a Routing
>    header with an unrecognized Routing Type value, the required behavior
>    of the node depends on the value of the Segments Left field, as
>    follows:
>
>       If Segments Left is zero, the node must ignore the Routing header
>       and proceed to process the next header in the packet, whose type
>       is identified by the Next Header field in the Routing header.
>
> That's why RPL with segment length 0 was accepted before 8610c7c6e3bd.
>
> But now the kernel recognizes RPL and it's intentionally disabled
> by default with net.ipv6.conf.$DEV.rpl_seg_enabled since introduced.
>
> And SRv6 has been rejected since 1ababeba4a21f for the same reason.

so there might be a need to have an opt-in knob to actually tell the
kernel ipv6 stack to recognize or not recognize a next header field
for users wanting to bypass certain next header fields to the user
space?

- Alex


