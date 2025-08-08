Return-Path: <netdev+bounces-212155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C229B1E776
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEF018C6613
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E57A263F5B;
	Fri,  8 Aug 2025 11:39:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87596242D6E;
	Fri,  8 Aug 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653192; cv=none; b=u/2EP+iT+JEPLWljXFUwFucRTe5CYEzWGB4zAnX6J+Bx9TGrfMttxudWcRiBoDA++Wml+k4PSuuMaOw1hCe3SbpCKr6nf7FBPaJuIvGKm2lX2eQkXAvPvmODYjQ287ZdzCKFgheseqmms0KwaihO9JMxUVoSdbxwd22nVrp0keA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653192; c=relaxed/simple;
	bh=8U7Rq+79VyYIyRvBj8UCQYpShhRysbjsER21wd3w7FU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzHxAyR3tnNlku48XRSEAwji6d9UnG9Wa76ZgZoqtZJwnEzi5zKWViVPZnqbFR17unmdFaLHkQoBg46KQdzF1bR/gGZbDmJso1rOntznliAHAmsCTsvDu23mW7cVeZ5J8ySQNdVEwcE5wRG1Ybwn2Zs/vcjmvOBFQS39KjJdTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so1217778f8f.2;
        Fri, 08 Aug 2025 04:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754653189; x=1755257989;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8U7Rq+79VyYIyRvBj8UCQYpShhRysbjsER21wd3w7FU=;
        b=pQL2PLQBtjQRy8AWseXkFPaKxu02QauIV/YC8iFWnHsG/9wL/65S3Al0dlSBvxXxmQ
         AyOvmnCpfwZgJQTnrhuRMntZrm4D6no0guTWZMgoOh/b/JhgnFz415w9oV7/lMWk3orK
         o1mMobrP8ljjfmZJGYCmXwvKByAV50PWV6fQrmwRd2WTpHvVRK226YsOXnUwcAt7mYnX
         /INi0BbfDt/hyO/1Ljb9YHl9u2fvMZOL7Uren17TLGaIw+93B+9B5IBBPWc/8VnlQEus
         35TfNGBzRPct82jL2wAI8L8FWDNG0OpvtWkmo2WI6N1F/rLMXVoL8giEkJk+Ir6XovPm
         ES2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWl8OVdzS4IjXzGRhImSfWK9sMv+np+w0NrfSB7a+T4oKjrXPhJcu86NxDpP/fHPIkFhdrxPaov@vger.kernel.org, AJvYcCXWzTkzJV+lWX8pN2RcnZGCX/PyqRAltZpIM6YCw/kL9nqh8pLkExFSgLUrXgIlS2daXa7S/CIov9ZwEqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUI04yZiMTeFVnj04HjdHt0NSwX0wG/JDfC9Xnsut6BCEHl5F
	1bgutDuhWwoHThtPFm6aawote1/RbAUGTRogY26C2qNIaUGn/IwkHdJK
X-Gm-Gg: ASbGncvIAIFZMpw5ZOGDiy3ZLdQZ2we7sjJtPD7whxmorvkjCBTQc3VtIznS6dKDiGf
	/iStn+ZYEPfI308kWac/mHduVhnfCXIJZAby/LHRDarfQRunFt+3931mHdtZLzZcGhjn5z8N/Ps
	jZpBTGZ1/0bGe1V9YeZDJGcA1IkP7Isi5mZ/9UsEwBPjvByyy80VPoymIGCNxAzeWCG1efr/D8q
	ii0LbW4sjULFfqDXv0pNFRpJtt6hfq9OsoYSBmMrECAsJMitl/RJvbxt+/unfocRsZLebulx74o
	jag0nTy8bsSIj9+h98B8bWR5auBlRQJhS0bMlZjE9ehNHz3BoVJck3PNyIGICKIEQqLVApD+43U
	z64iixooYV3umpzcdmI/pkxO5kVSrosN0ew==
X-Google-Smtp-Source: AGHT+IFW45pbrGmrqdS1Yypd0Sjqwryko9pvYKppxo5mTPeRni3AgLDtUXec+hATuTe3Y1YA23abVw==
X-Received: by 2002:a05:6000:178a:b0:3b8:f8fd:af5d with SMTP id ffacd0b85a97d-3b90092957cmr2249716f8f.11.1754653188608;
        Fri, 08 Aug 2025 04:39:48 -0700 (PDT)
Received: from [10.148.80.226] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5843021sm148099015e9.3.2025.08.08.04.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:39:47 -0700 (PDT)
Message-ID: <6183a3b8884fa1ba006174d63ffb1a6924735740.camel@fejes.dev>
Subject: Re: [PATCH] net: af_packet: add af_packet hrtimer mode
From: Ferenc Fejes <ferenc@fejes.dev>
To: Xin Zhao <jackzxcui1989@163.com>, willemdebruijn.kernel@gmail.com, 
	edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, 	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 08 Aug 2025 13:39:46 +0200
In-Reply-To: <20250808043300.77995-1-jackzxcui1989@163.com>
References: <20250808043300.77995-1-jackzxcui1989@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Dear Xin,

On Fri, 2025-08-08 at 12:33 +0800, Xin Zhao wrote:
> On Wed, 2025-08-06 at 15:25 +0800, Ferenc wrote:
>=20
> > Do you have performance numbers? It would be nice to see the test
> > environment,
> > measurements carried out and some latency/jitter numbers.
>=20
> Dear Ferenc,
>=20
> We test it on 6.1.134 rt-linux version, we set 2ms as the retire timeout,=
 the
> following test result describe the packet details including cur_ts_us(tim=
e
> when
> the sample code handle the packet) and cur_pk_ts_us(time when the packet =
send)
> and delay(time unit is us, the gap between cur_ts_us and cur_pk_ts_us).

Thanks for the additional details. Out of curiosity, how do your setup look=
s
like? The packet received from the LIDAR device are
A) processed on the system
B) processed on the system and transmitted elsewhere
C) only transmitted elsewhere

From the details provided so far I'm unable to understand the setup you hav=
e.
Both 2ms and 8ms looks pretty high for me. For example on a loaded system, =
I
have seen ~200-300us latencies with AF_PACKET software switch P95 with soma=
 rare
outliers over 1ms. But that system might be faster than a embedded device y=
ou
have.

> Test result before change to hrtimer:
> --------num_pkts:54--------
> pack_size_:902, atx_udp_seq:86152515, cur_ts_us:[1749707679501254],
> cur_pkg_ts_us:[1749707679492443], delay:8811
> pack_size_:902, atx_udp_seq:86152516, cur_ts_us:[1749707679501260],
> cur_pkg_ts_us:[1749707679492590], delay:8670
> pack_size_:902, atx_udp_seq:86152517, cur_ts_us:[1749707679501266],
> cur_pkg_ts_us:[1749707679492737], delay:8529
> pack_size_:902, atx_udp_seq:86152518, cur_ts_us:[1749707679501274],
> cur_pkg_ts_us:[1749707679492884], delay:8391
> ...
> Test result after change to hrtimer:
> --------num_pkts:14--------
> pack_size_:902, atx_udp_seq:42679600, cur_ts_us:[1750220805104634],
> cur_pkg_ts_us:[1750220805101776], delay:2858
> pack_size_:902, atx_udp_seq:42679601, cur_ts_us:[1750220805104635],
> cur_pkg_ts_us:[1750220805101923], delay:2712
> pack_size_:902, atx_udp_seq:42679602, cur_ts_us:[1750220805104636],
> cur_pkg_ts_us:[1750220805102074], delay:2562
> pack_size_:902, atx_udp_seq:42679603, cur_ts_us:[1750220805104638],
> cur_pkg_ts_us:[1750220805102223], delay:2415

These timestamps calculated like this for example?:

sk =3D socket(AF_PACKET, ...)
cur_ts_us =3D now();
send(pkt, sk)
cur_pkg_ts_us =3D now()

> ...
> In our system, we care about the delay value, cpu usage and context switc=
hes.
> Use af_packet the cpu usage of the lidar process change from about 16.91%=
 to=20
> 12.92%, the context switches change from about 900+ per second to 400+ pe=
r
> second. The benefits of using AF_PACKET are significant enough that we ne=
ed
> to adopt it. After using hrtimer instead of timer, the impact of the dela=
y
> has also been controlled, which is what we hoped for.
>=20
> Thanks
> Xin Zhao
>=20

Thanks,
Ferenc

