Return-Path: <netdev+bounces-153411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CD39F7DD9
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2057916621D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B3222575;
	Thu, 19 Dec 2024 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyJYXx5/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1841C64;
	Thu, 19 Dec 2024 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621593; cv=none; b=OKrL02K4G+ts3cuumRRSb0kbVmvFWq/7p3Ol06CfbEyVo04qiRpREOLDLUquuqKzPRP20Rg7fY6hJWYJaOudhjBU4BCh7DN0CprCc+OuhJ3XMLryZRELpqUBgn/EzcQck/y1noSeX0V5viBgOrbfkatkeo1+fQoByC0B3fZq1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621593; c=relaxed/simple;
	bh=C0bDAWBXoGNafsN9GRiehHqODgEgce9zzWV2gG8D04s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDoOsvGPWSuvpapHN81Y9OLEh9Q3Ywdl5rRBr2v4E7O2ZY/e0ItPq+QcHonbLvh1NjUOd/5/NOpl2PmCiM8YvfLDQirQZzLsEEx5Hr889UL3ijjUxP5UVeGTBj9B34gidjq3jSp8QTnsz1iiObkeW4jAReNC4nq45nOcwFd635M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyJYXx5/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so1584457a12.2;
        Thu, 19 Dec 2024 07:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734621590; x=1735226390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3S3/fNv81c8qFTsLPM0DK6Q9jOIjFU++BANGyOzmQk=;
        b=fyJYXx5/oT2Hbd8bL747HLI7Cb3E/3nuHadTAegHdmWsbzzfF27YK/s1AfPki1dx9/
         vOP+EsV+bdMoZRrAQOhuwJjz6nL1XKKvwoGzOHzlux8xZhJdeTvY/0RaieKBUwB/TrIc
         rMGVPiydooiuF53jnaYtrL1JA++tS1lIYbH/dE8CAd7p7jaOiVuLrntIS3ImxzoXYkT4
         qpxzcFPRhKwe0/OauTfUEL5lBRosKJmrg37cxcr94/TmtnQ8Tc6+fEgv9rwl8eOyUH/o
         /5pujmHQJfkuNec6GuZ7nu8CNivKcHOITAyz/PvEZmYfw7KFWZOQzDxVmf76n8i7j2/K
         2bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734621590; x=1735226390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3S3/fNv81c8qFTsLPM0DK6Q9jOIjFU++BANGyOzmQk=;
        b=pIISuhffpt/tT/QmLZzbSDxDvuSKfdS1g23ttiLQZ+u99bFKDDgCq0kLcKPdPmp0Sp
         gQnu4WhXANAcEkEA+5U9NQCITCDheRviRnpAh04reI1uTjqF/4YOq4+JR7tDwdBCBSKN
         Xg7ZU9OX5BmD1+HrKUpLskyooeRjOu9ritAL5DoBt1ASzjioWJbx6HmYgFkcLDwXl4Zi
         uhwdvvZE8i/ZhC235vD+/W8FmcG6ELY2Un+tsjgBn0dxqFNaTVFRyCdXvIZzxX+lYTMn
         8iRmia0Fu9TUEXsJ6azcYtwA6gCRGAZP5S3lGRqh423yaSGRM19PBHUuCeoAiQi22Z4S
         ZToA==
X-Forwarded-Encrypted: i=1; AJvYcCVJwpda9/4SPjUNcwLKWC6QhD6pyamlK8+/W/VZCnFyOEK/6rVzU377MCqqGrIHsTJbz6L2P2FoNJ0=@vger.kernel.org, AJvYcCVgXFGYZ1KNtff5yIrqLrwvtl+rNdFRZ1Uv4HNQ28iIGp4e9WwPVdzNA/CTInmbuVVj3P7AsoeU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69f8oMY0Qp4hKHOEy6XVKt42LcXo1dFIBDiYlHMz4faVw4UGa
	wrFQoKzXvi2r4mz9ykIT8z+Hc4oq+Jwl9hpYRTtYgGputojUSJK+lY2K4hWsEaU3lMYrviHEMc6
	p2Gsb5JeOZBI1oKNskeHkYJ9Ujeo=
X-Gm-Gg: ASbGncuSkM4OcblxY2Tiee0NUw7dQhD/9U0F4cgRkHhZ9T5bQtEklQnEJHpoSffA/np
	1ZsKrHSZC7FPNvBDrnjp9g/qrg6Ry5wHmM5FWf1U=
X-Google-Smtp-Source: AGHT+IGg14VOox6jSIMjl/5h7meuSQHIL+zUKLi5KJ3zqlyKjjI6q4Pnozh6WSmZfSFR/Jobav1/HMDQqPfKRhPurlA=
X-Received: by 2002:a05:6402:34c2:b0:5d2:7199:ad4 with SMTP id
 4fb4d7f45d1cf-5d7ee3771acmr6518225a12.6.1734621590059; Thu, 19 Dec 2024
 07:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218144530.2963326-1-ap420073@gmail.com> <20241218144530.2963326-10-ap420073@gmail.com>
 <20241218184917.288f0b29@kernel.org> <CAMArcTWH=xuExBBxGjOL2OUCdkQiFm8PK4mBbyWcdrK282nS9w@mail.gmail.com>
 <20241219064532.36dc07b6@kernel.org>
In-Reply-To: <20241219064532.36dc07b6@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 20 Dec 2024 00:19:38 +0900
Message-ID: <CAMArcTW-wDThHLnNVUNGQRrTOT1Vbzc3F5R=U4PiFjvifeeQPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 9/9] netdevsim: add HDS feature
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 19 Dec 2024 23:37:45 +0900 Taehee Yoo wrote:
> > The example would be very helpful to me.
>
> Just to make sure nothing gets lost in translation, are you saying that:
>  - the examples of tests I listed are useful; or
>  - you'd appreciate examples of how to code up HDS in netdevsim; or
>  - you'd appreciate more suitable examples of the tests?
>
> :)

Ah, I appreciate example of tests you listed are useful, Thanks!

