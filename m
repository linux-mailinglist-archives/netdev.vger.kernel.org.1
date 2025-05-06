Return-Path: <netdev+bounces-188339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AAFAAC4C2
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D877A188CB47
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F13527FD60;
	Tue,  6 May 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZrF03+x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1C27FD54
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536206; cv=none; b=AuNeAlmS1fXDOGxvgEC1XRpVLXhY73YRoXL+Gidj+TR1yOuoFcB+08tzNB+al4bBgV1IWzm2y9Ru/IBOWlu9yaYibmjDcNT0gQs6xtjsiKVvTJd4psTBrWLPsEOCdtedFirG9IH5+nmkPEmTnOd/OxRUaf+fBrVVrI9y13q3mx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536206; c=relaxed/simple;
	bh=RAD910ITEhqtfum1WUIiNpeNNtIJJO1Mhf2Rg6RFBqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l24XYWasLLemhmdlOkqlx/qKasxpmf1Vcj2oQe2AjT2xKzyue5fJnJKP8V4yEd/WgmczEoB1Nz0kNtHyxf1q2Ya4CDNucI6rq2lqpJ1gjQaNRX4tlTck5k4TPWpo7ck2iu2JjGhgqyaZLjArdNQ2NYS732RDNwm1Rey5nwur7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZrF03+x; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40331f302f1so3332046b6e.2
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746536204; x=1747141004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RAD910ITEhqtfum1WUIiNpeNNtIJJO1Mhf2Rg6RFBqY=;
        b=PZrF03+xUfn3W278YAA9WOk8zNE+PphInQLpro2ro+QGimT5O7UpnXVeGVbWOeoT97
         Rs7xQpgiq8RzPLttrtX/uvqoNLlfOX/LJkNWRM/h5ud/kK7DGThG7zqHNzhzVoWjixNx
         5ZXF1A1YWcB0WzSFiT+fve7OOWdldKodoIoRJG4d2/e4HFvdE9/0RLhwaAai4jTycN9S
         LA14rlI34NBS0/CXog7SHRHv3fSmiC2ueZlEeaah3wE9acZ5IRPG/3PzqZhZwm3r3lka
         OiumwcjKFwlVntPuDRz8Lp2cspQVLVasEYgJeL490waWnEAUiy2exySU6ZavX8SxDT12
         zKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746536204; x=1747141004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAD910ITEhqtfum1WUIiNpeNNtIJJO1Mhf2Rg6RFBqY=;
        b=BT/5+abH0I4utan6SlKH+IDP2GB12NUt/wW1Uiby18iZrl/Kz852Vqckwti06FSL7M
         7Ekt/bkmhFgNmiTmNRHZVvnicLiIPoWs3hwBF/6ErMajQCn1gTE4UL8JM04D445VxgNy
         mAa0xDTD2g84LJ093yAj3PBTOwGSyMMR+aKEkP82nUYxQYDZnti/jgzwHWhnhtBb+w7U
         dzUdYmDSWC1zzDUl/4N5Nt0SD9E4WsZALLKmaGDym7pG8Nb7NvJRr17n5WQS0jYUDTlH
         2+HSdHyPfvKHGqKnninleBqD2kaSFHFMc49DBMSeh1Q2476dqMmM6Ig/axY/jnf34LTH
         nySw==
X-Forwarded-Encrypted: i=1; AJvYcCU9KL/nDNqmxuOMcfs4pmBP/W8otcy/8Wj9s4XHtR+KTxH9dBbDKJzB6IzNO+QfdNKggkmRR38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2xiF2mWFnqVDZUvTCrItcX7kPqcuEoLgUc4jT3tVTYELB5MpS
	Se38zZ5ZEnwA765tR/iuqof3HTZS/50XvhNZ2VRFS+dicBvY7onapG92+kYii/4EMUmflvoZgqO
	UXBCmkjwPWqXrhF23X5LySLQcdRk=
X-Gm-Gg: ASbGncv3ZnIfpBUW/Qj4zRUBYbb6OR1exNWn8/0U0gfLLxyYR6ALWAe/XqtYPheD7yF
	rTmFH783m831bo1KnZ/2ebGatrPyIFCcc4lPqgPWoGJ1ZffxmYtYaE4v2Ke2krhQT5aHcecghkT
	IeH/asE8UjhtyOn1H3d8Srpe0daAK8sye7AAGQwqCTDeKorOfJZiU=
X-Google-Smtp-Source: AGHT+IGRboGxKqZIBU/jYtzYc4en/O6sf3KB1lrQGnC8Ipy1Z9AyUJDk2RfrachOBGEIgb+e9mjnxxNlT0NhY5NNHog=
X-Received: by 2002:a05:6808:2445:b0:401:e662:1b5f with SMTP id
 5614622812f47-4036978b43emr1546637b6e.8.1746536204026; Tue, 06 May 2025
 05:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505170215.253672-1-kuba@kernel.org> <20250505170215.253672-2-kuba@kernel.org>
In-Reply-To: <20250505170215.253672-2-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 6 May 2025 13:56:33 +0100
X-Gm-Features: ATxdqUHTj1vU2fTfK0RvFTbUX7j9pGOqk6H8V-39bcG7d3Qu_7OaMyp81YEQt3g
Message-ID: <CAD4GDZwP_=Zy2XcnDg=ijv3vh6MrLnnnw8SV1c+vrdSYJ=doLw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] netlink: specs: nl80211: drop structs which
 are not uAPI
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	johannes@sipsolutions.net, razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 May 2025 at 18:02, Jakub Kicinski <kuba@kernel.org> wrote:
>
> C codegen will soon use structs for binary types. A handful of structs
> in WiFi carry information elements from the wire, defined by the standard.
> The structs are not part of uAPI, so we can't use them in C directly.
> We could add them to the uAPI or add some annotation to tell the codegen
> to output a local version to the user header. The former seems arbitrary
> since we don't expose structs for most of the standard. The latter seems
> like a lot of work for a rare occurrence. Drop the struct info for now.
>
> Link: https://lore.kernel.org/004030652d592b379e730be2f0344bebc4a03475.camel@sipsolutions.net
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

