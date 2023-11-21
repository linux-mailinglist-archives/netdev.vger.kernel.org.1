Return-Path: <netdev+bounces-49555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5967F2674
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 08:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F7F281A3B
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340A828695;
	Tue, 21 Nov 2023 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="sp+DTxGt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E87B9
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 23:36:25 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so185043166b.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 23:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700552183; x=1701156983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cm6AG2rpCOk29tse/lLv1n7EffKTT3hrnwLqWaSs8SA=;
        b=sp+DTxGtQoQOM+fangyFAfeVb93t7ucG7DKtxTpUdtf7cyKLnuHIxqiWRW1kwRlGGX
         wtGU8j4ySPxfjljJ7i7LOn91jCBauCK4hXj5E5HKRGkuw9yTUdrTCcWq22Vgp+QyliYF
         NNIwjtJRKK2luS6DD9Sd7LMSBLoFGJ4SMJLDkiY2avvdEiVRFRQpWu+3kYRhORdH7jjd
         9/3oszhs+x1C7yPkYdQxmqu5GaVcRQKZS6MBFSguJX5QrfcX/ZFGC/DonP56utRrPSj/
         QWhH37Mjzd439GyDc8CGALUNy+JdvPDdWWXbvNuRe70Y01fTlJYTqu4ekKVcPPhTuC9y
         FhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700552183; x=1701156983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm6AG2rpCOk29tse/lLv1n7EffKTT3hrnwLqWaSs8SA=;
        b=U8WKx4kPp85PJhgJX+hw7Tbbh7IKBcglkiAaQfWtR5JK3MiF0m41/ya+uVeWFOf8X7
         2K52Dsn3DxUak5OsgWdF9Egz4vNmnp0eJSQJj+U0Y14Z8GsDsxWjTrr2TZLfyQ0qYh4z
         1IzjpnTSlghC+dQj+radT4ujVr0hlVb+wYETWRzehUdkfb5dLA3Wz3boGPfbcbFSRQJM
         ngtOJ9dgG5G2KFcm2PaeRamwzCsCOF4MtWp9ExWFt2Fjlz88E+XkvXLxHPmj6OKg8ttF
         Nf5+HjuzkknqEc9HplyBdpNM9NTAx/V286nvJpQaI3Geb4RN09I45M3IXBxfYFo1MqbE
         qr2Q==
X-Gm-Message-State: AOJu0Yz6QZnDFzPUOv5aujM9O3VjvcFRj0/LdED4vpRmtLhY4wNWuB3/
	1hov/7L8WXfGNrcJqAEvvB2Xtg==
X-Google-Smtp-Source: AGHT+IFnCaxS8IEljq5mylEhWd67zLLzfjT+acrA5wZitGH41XIJhQ2ZiU2i1QBPYZ6xJ1crD+Y6ew==
X-Received: by 2002:a17:906:257:b0:9fa:ca0c:ac42 with SMTP id 23-20020a170906025700b009faca0cac42mr7116932ejl.64.1700552183619;
        Mon, 20 Nov 2023 23:36:23 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b9-20020a170906194900b009c3828fec06sm4782577eje.81.2023.11.20.23.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 23:36:23 -0800 (PST)
Date: Tue, 21 Nov 2023 08:36:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <ZVxd9sysZsHw4e4j@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
 <20231120084657.458076-6-jiri@resnulli.us>
 <20231120185022.78f10188@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120185022.78f10188@kernel.org>

Tue, Nov 21, 2023 at 03:50:22AM CET, kuba@kernel.org wrote:
>On Mon, 20 Nov 2023 09:46:53 +0100 Jiri Pirko wrote:
>> If any generic netlink family would like to allocate data store the
>> pointer to sk_user_data, there is no way to do cleanup in the family
>> code.
>
>How is this supposed to work?
>
>genetlink sockets are not bound to a family. User can use a single
>socket to subscribe to notifications from all families and presumably
>each one of the would interpret sk->sk_user_data as their own state?
>
>You need to store the state locally in the family, keyed
>on pid, and free it using the NETLINK_URELEASE notifier...

Ah, correct. Will fix.

