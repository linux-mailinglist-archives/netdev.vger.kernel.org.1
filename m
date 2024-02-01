Return-Path: <netdev+bounces-68026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C25845A74
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9919D1F2A00F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F9E5D497;
	Thu,  1 Feb 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YNLXKDkP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4E5F470
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798617; cv=none; b=LW5Svmw4l0F01gE1FAc4ZC3JtfBDInID4OScmD2YOo8azVr+toGjYqes46xoTS55+soXaAOvr79NWaNmJ7Q42wyccnKpfzSghdwsuHw63MF4drckiHbLabc1FHCiCo3u8hLZfuFQyI3kYMavB33az5vZuWsQFFL9M3WOX2qCKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798617; c=relaxed/simple;
	bh=LMmXEXjre2/iGvw1iKk547lgHHliHlwLOLSwpsYtPLg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=GV/JWRbfpwFRkPd/aGcyd1/hyoWy2VPBDrQwjqdeBze7T8BgfVS2v64NQJalTVKlevTQ/jCLsvTEF7d+C5sKnzmx922ajV2P3YZ5g5i87yhNTbK7httDBg2cqbijS1TRYZQbttvOvKnhcS66YRwtiEtEq/ylQOQHPUsKdzmleiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YNLXKDkP; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E41DB40C71
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706798607;
	bh=1OypoDLTCeqhHTjTBtuB8gkBgBKZCfgLJtgtDYgi63s=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=YNLXKDkPYPxIxSVztAt5I2B+TBvCeUrlx+vs1yg0tgUlnWbpshvCl+ytGa9XHg1gS
	 QuhOzdQTZwc9kFUL0YHU8kZFE8kG94rtrEIOBv57Wx/Bv7dyWSxzEwectapwi4cqHz
	 yIqvoXmz5ZJjpg/uPFm4PIgMmP9IzTo+NepRlfZNhtj3bafW9QGiiRXFef9qvaEgN7
	 zMc7P8jfxE74FVeZzTHzsYpmflvqoZfZ22ONwU5e8lAzp2xs1aqOk2iKk9Ltnzer7Q
	 KT72NATZ0IjJfzwicSHv/xiPSJx19S+7ZR8LA70Dn37d1nUVYSxJ0531HkTCqftTKs
	 vnmYL5k3V+FyQ==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5ce97b87716so906234a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 06:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798606; x=1707403406;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OypoDLTCeqhHTjTBtuB8gkBgBKZCfgLJtgtDYgi63s=;
        b=gFJtsZboPZYcHSBlq5S480Utda61XkajN1S8m/YHa1J8k+D+xlOLZV/mtVwzSxMt4e
         7SakSQUmCi0wcwIFQaRnoIbzbICYNYTMPy60E/VKj9E9M0d0mLdO46XCGGdHS/Xsct4M
         A/S77BGOifwVJ4pVk+LboXZVwVSorFeB03Gkub3mSK5YtsbD1Cm094WKjvQW+naO5bDi
         gdjANjIXKrumvQeILaD7e1mV8I2i2NTcJO3OpdGKBDksKDDojpEGP6OfLbOWhuSTBI6b
         l1Wqkeel6/dUielOGbNFokkPrXSa2PigVanqp6Tk0eWXSEMEDN1/m7piEFuZ3Y9OHAZf
         0qsw==
X-Gm-Message-State: AOJu0YwiEg0QSBXt2IQU6S/U6+i7GBGVQB5euEI8rQidHom7BTuSwWI2
	lbEoEaXzMLvGy3fXuLT0LWChqBvwAIkpI/GPp02NF38A7CHdG3CuBJG6xGZiwuUFrHukpJAzgEk
	6DifS4m6RwqScQDdU6LNy6WrHvTTRHNQyYDYI5AHZ3AY9A3T9WncCXWJSA6AKqI/tSSVPbw==
X-Received: by 2002:a17:902:ce92:b0:1d9:4544:ed37 with SMTP id f18-20020a170902ce9200b001d94544ed37mr4105692plg.17.1706798606629;
        Thu, 01 Feb 2024 06:43:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpy4TEPVPmqROCvKm63XB0+LwNUI/U6Orro7bqbYxr13caUcPj1evnQ0OegqRfN3azkrleaA==
X-Received: by 2002:a17:902:ce92:b0:1d9:4544:ed37 with SMTP id f18-20020a170902ce9200b001d94544ed37mr4105672plg.17.1706798606343;
        Thu, 01 Feb 2024 06:43:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVw+pYoH0wmJ8MC4sML/8pFkGHrVLIq3wgZbBaZsrMU7XGYQQ17YCtLEMUROO+qBdcVRE0QKYvzpw3D0cCSwxTkPwprC74nCCtOU1RKNHhNFNMQTQMwIA/BdUpiH3o6y9KA+Mbkv7PROxVGpPDOwAPTw+BEgURhkBBmlawNkb3wBj4h87puae5tU8jEaXnN9actXFBTA8F5Fm3aHcR5kFeUXJw1gm2GPvAj0zgzqHMzQ7rJMncC6r8TjoRvEEnJaneY9A4GscsCxCcOk3JPjLMDOMAw3QEgGJHPd8WM6WvMlWfJpW9EVcZJpe/etms2BL3EJKrIY1fT8RzfeoEEx8uijr2hqtvfr4xlvDXaepXY9dXvYFH8qflpcgTCXVZ8s5hxQdktOICy61rqQb1Te/E02uUpVkK2dgv1htvp
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id mm12-20020a1709030a0c00b001d948adc19fsm1579796plb.46.2024.02.01.06.43.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:43:26 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 885825FF14; Thu,  1 Feb 2024 06:43:25 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 822509FB50;
	Thu,  1 Feb 2024 06:43:25 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Aahil Awatramani <aahila@google.com>,
    David Dillow <dave@thedillows.org>,
    Mahesh Bandewar <maheshb@google.com>,
    Hangbin Liu <liuhangbin@gmail.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Martin KaFai Lau <martin.lau@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] bonding: Add independent control state machine
In-reply-to: <15d7f2941394e04d45f98aa6d095b1e07262655c.camel@redhat.com>
References: <20240129202741.3424902-1-aahila@google.com> <15d7f2941394e04d45f98aa6d095b1e07262655c.camel@redhat.com>
Comments: In-reply-to Paolo Abeni <pabeni@redhat.com>
   message dated "Thu, 01 Feb 2024 11:15:40 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32423.1706798605.1@famine>
Date: Thu, 01 Feb 2024 06:43:25 -0800
Message-ID: <32424.1706798605@famine>

Paolo Abeni <pabeni@redhat.com> wrote:

>On Mon, 2024-01-29 at 20:27 +0000, Aahil Awatramani wrote:
>> Add support for the independent control state machine per IEEE
>> 802.1AX-2008 5.4.15 in addition to the existing implementation of the
>> coupled control state machine.
>> 
>> Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
>> the LACP MUX state machine for separated handling of an initial
>> Collecting state before the Collecting and Distributing state. This
>> enables a port to be in a state where it can receive incoming packets
>> while not still distributing. This is useful for reducing packet loss when
>> a port begins distributing before its partner is able to collect.
>
>If I read the code correctly, the transition
>AD_MUX_COLLECTING_DISTRIBUTING -> AD_MUX_DISTRIBUTING is not possible,
>am I correct?

	That's correct.  There are two completely separate state
machines in the 2008 standard, one for coupled control and one for
independent control.  The state machines utilize the same states other
than COLLECTING_DISTRIBUTING in the coupled control mode, and COLLECTING
and DISTRIBUTING in the independent control mode.

	Essentially, the two machines differ in the transition out from
ATTACHED state; coupled control moves to COLLECTING_DISTRIBUTING,
whereas independent control moves to COLLECTING then DISTRIBUTING.  

	The 2020 edition of the standard combines the two state machines
into one, and changes the set of states.  Bonding does not implement
this version of the standard.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

