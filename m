Return-Path: <netdev+bounces-70870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41133850E1C
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 08:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651341C20D60
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D8D7469;
	Mon, 12 Feb 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiYO5qVa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26952C13F
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707723524; cv=none; b=r7cFl+LcguTHlw96M5CEOFYHJLTPFT4KOCaBQoMdTS9sCYCQaCzXHap85xcjE1cKDlK1m60j4ztLKXW/V+uLNAd1KHEN9pdmbk7ASIo6nU++Vfmwopc0XNq9su/AZpGJpUnWqbdgeOnPpHtiZprADqkGzun8cgrA5r7T/+y72uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707723524; c=relaxed/simple;
	bh=8Nvpl4TxvcsmbLrkTxOXw8m1vfXqj/6yNLBJSWDySp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXSlQKp+WwDUQOCh2t2qNoPkuoas9dNBjGsXx3G4VP740ynpWn5tP/zbiNDEXU7oymMwO9lVB7t8yso6PwKA+1dd0Ek2D2pgtY0yGaY27EcY1l5lm2PuwL9pmWXKsAxV2IsSYUW7YzXddWUhkCsaY6JLw2e4eVOMEhipTujqFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiYO5qVa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707723522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8Nvpl4TxvcsmbLrkTxOXw8m1vfXqj/6yNLBJSWDySp8=;
	b=XiYO5qVacBrsD8ALNiv22U+pO6/vEKPy+3DgsBCfj2yqtQs61vf2G6RbMnIOieD0W8Vvcv
	aX1uzxksGS25r+9xiPGgSWL8DSaXab1KlQalApnO6814OE+TXcggJroXC0wWBrY3qF9PN0
	fqVG6lDmjVhwOkZzl8WcUMHjdsHu11A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-211-HHPkOJWdzmPhIT-5FQ-1; Mon, 12 Feb 2024 02:36:51 -0500
X-MC-Unique: 211-HHPkOJWdzmPhIT-5FQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33b244526c3so446859f8f.1
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 23:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707723410; x=1708328210;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Nvpl4TxvcsmbLrkTxOXw8m1vfXqj/6yNLBJSWDySp8=;
        b=WVbLOQAm7b13JALqE/nh17loOUlIG7mLJz2ETrovpI961ltUOozqKXEzj49h5DQDIo
         +EkzgLivEI9tYbh8bPoVingjT3cWkWT5JzhMm5XGageUagliJDSxvOkoV95xkkelys70
         h3H0qATMLmIJw/j/M1vNgFJ2y/h58JrqHocv8lwZcrxYA2g7WpupM8WUzm5GpwkrGFp3
         z4j94vQXSGIwGgvn5laCRL2MX9D9lnU/pyklsDWkVE/enDJWAU3Ue2y/44KXNFFif72w
         KBxWezoZEyFtxwg3hyVYBX1kP8hY4WRfGyjeG9CSy7EDPy94wNd+dwMYMbZfuTFs7lo2
         BGYw==
X-Forwarded-Encrypted: i=1; AJvYcCV74v8tRM48D0c31IScpXeqKyi0vqFK/M/r1WaJoNitQuXB39FlLoMaHVCiVJagmaKYlhPwTaRYqMUPlhEA0aiPXeY6LnN6
X-Gm-Message-State: AOJu0YyiAMWyz/Cb39wQNhkFEKFk7/ih/8il8/kcE5oC2TH2ms7tjNrX
	VJ1alIfb4vim9KsMCj7qAHoDHr5UDH/RJN7aCzwXkxLQsLwruJ2Qle3t2ICz5np4nZWIBaN/eDB
	lxMm1PRr4OPf4yycPU5TDInHCN1zw3z5gBc6ypICdpXj/jM7RbkOeHA==
X-Received: by 2002:a05:6000:1f98:b0:33b:4d82:a487 with SMTP id bw24-20020a0560001f9800b0033b4d82a487mr3957067wrb.1.1707723410513;
        Sun, 11 Feb 2024 23:36:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzdi2myEpIV5pSMye7lXbZ28lafw0b9MPkuCVuHqhvB0hspiilwTyb1gxA9CNHGUdhMqPjPA==
X-Received: by 2002:a05:6000:1f98:b0:33b:4d82:a487 with SMTP id bw24-20020a0560001f9800b0033b4d82a487mr3957053wrb.1.1707723410159;
        Sun, 11 Feb 2024 23:36:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZWrmzIVHG/WJVwUJzwztQBq575qgSmKM1vT1dzjWDHSTSQzkrIT8mf18flR29IrqGDIyMIrd/s0UWd6YdC1no4Y9ZKQIdrx/ZB8iaRxgEXbR9mJPEGY16MU+F+g3JA04/H/8VVh/jF15W5p2hALmuaSxcBJ8xtsV4sfg6/QE1ol4jEAFy0qdBZmu/AOu5PHBm1Bo0yKDb24e3uXHAQeZWkMofYSO8I/mwoY2uCsjcQbeeSSy9DKD8PAi1YMk=
Received: from gerbillo.redhat.com (146-241-233-147.dyn.eolo.it. [146.241.233.147])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d558e000000b0033929310ae4sm5963097wrv.73.2024.02.11.23.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 23:36:49 -0800 (PST)
Message-ID: <d9261aa8d33c2730e78bef29b2635bf7dd81bffa.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: wait for receiver startup in
 so_txtime.sh
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Shuah Khan
	 <shuah@kernel.org>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Feb 2024 08:36:48 +0100
In-Reply-To: <20240209111730.5e67d9ac@kernel.org>
References: 
	<53a7e56424756ef35434bc15a90b256bcf724651.1707407012.git.pabeni@redhat.com>
	 <5b768c89eb2992c22ca7016de9f90ff7d4eecd5f.camel@redhat.com>
	 <ee9d2e224d063dc66070b060f716219c976759cd.camel@redhat.com>
	 <20240209111730.5e67d9ac@kernel.org>
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

On Fri, 2024-02-09 at 11:17 -0800, Jakub Kicinski wrote:
> On Fri, 09 Feb 2024 17:45:28 +0100 Paolo Abeni wrote:
> > But I'm pretty sure that even with that there will be sporadic failures
> > in slow enough environments.
> >=20
> > When the host-induced jitter/delay is high enough, packets are dropped
> > and there are functional failures. I'm wondering if we should skip this
> > test entirely when KSFT_MACHINE_SLOW=3Dyes.
>=20
> By skip do you mean the same approach as to the gro test?
> Ignore errors? Because keeping the code coverage for KASAN etc.
> would still be good (stating the obvious, sorry).

I see my wording was not clear/misleading, I'm sorry. Yes, I mean
checking KSFT_MACHINE_SLOW in the caller script and ignoring errors.

Cheers,

Paolo


