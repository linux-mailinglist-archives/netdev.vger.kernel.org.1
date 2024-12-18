Return-Path: <netdev+bounces-152973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8CD9F6774
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B7D188C985
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057681B4237;
	Wed, 18 Dec 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGCXsZj/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F919B5B1;
	Wed, 18 Dec 2024 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528900; cv=none; b=YsvTH/2FTxAHqdYEHSuSgS7H2tktvStqs38tDFKQQYnJbAPKGk0qtwqLgb79DGIIPwZm/BNeeCYms30GWTbycuvck4SU7M2Lk91t0s4sZOXIr5cjQiFP8TEO9U2dYt5PBennqW8MFkEvKlmhWyzbwAfLqNG9HOA7dCwcursq/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528900; c=relaxed/simple;
	bh=Ke2T8ECN3W8kaX1iceKh7MreB2yxBEQvypHBfi3O0FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrvZ/jpG1MaVGUKK0JmTl6qjDaBgdyvH4GXD+HL7sn4fIWTyt/t2zXiAe5FcHx7pHXbpvQf/glmzC65S/TtSeuTjV3UngkM7r/H36ZFXaRNenAxKPJE7MCbU/lxIsyyilJpn0EDqD7WXVY5rSbLgBBmWHHEIObttv7l63j087tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGCXsZj/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so3853684a12.1;
        Wed, 18 Dec 2024 05:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734528897; x=1735133697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke2T8ECN3W8kaX1iceKh7MreB2yxBEQvypHBfi3O0FU=;
        b=VGCXsZj/o6IDI0Nh8aexYp1WAs3iieCJHhuxanOXc6ETp3QPGj7Ns6BXnfa4gc6Xkn
         evoaTqbGV93KC3quDQmxLlA32CZf9uI+jThj5+iaX3Kzg2TGIPLUXQ/O8oJpC7N0XdQS
         Faqx/CkwQx1Evn5Nb6peAyFIQyjBBUM4cPf9QMpJSONS7RqpINZnqGaJyn7vTrCROKou
         0fpbUExhktlTRB8dAMKDy0njNWb2P+NDXXsu8zpRC7KrUhq7MalYxonq+H4c6yDVerzl
         h9amESMEdpMKnvaHAQBaEGZeZi5dc9B1k8imPf734qJYcGux9RH4mMkxi7vLyks6B2xl
         j/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528897; x=1735133697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke2T8ECN3W8kaX1iceKh7MreB2yxBEQvypHBfi3O0FU=;
        b=QLmTTZ/piNW2Vg7t5WLS2vGQA9f2wYbna3Ejf2AuWXptKzMc/c7oQoM9E4Ho3pKoL9
         YGs3qVjeGGyPHbkbqC/1xlRorSwYQ0W82iDMPzugtwfcJaUbRvQNy9Y2D/eGN1w3nbV/
         DvjB5lnZZ1URse2lFU58UT/eKjloMOFfuqnT1nA8P27HT9G3j7KkE6UYOtfs5uz0OQnr
         Ow2b3g54G8H3rHyPlc2o5LOVijeYAv4loO2OZBQZHmXndGrcSBgPlFiAjsmM9sghSAwN
         ILlGpiNqLWslwvVV4V+yO/FAQq3SZZqC6AvG4ZcYZV0S9tXcrBn4BQVROSQtc55rwrUh
         710A==
X-Forwarded-Encrypted: i=1; AJvYcCVXGpBN7ieTI1IT7s7szBaAOfvYqsa2s3JvZp+xXV7d9noSMhFHkuAmYaQmEG88W9ve1wFX58Co@vger.kernel.org, AJvYcCVqqtqpmC0RdEq0QJ+SdzOxMXnkwPI4r3bh/5jceguRHMQ/vwV87F9bagGDyenpgi8j2lTidsTw95k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQktyR4vn5x+mzjKuNEx3fZT00fBYXTCv8ybiwnsdlgJUyyYg
	B8RihMquOmkV5NrpteRr29R8kE7kOa3L3IuJvYxUcxTE2kIckNwNUCFTivwqCHEbKe1GYI2BkJ9
	/vO+HIl70IGVogoPM7e2NwP9SF5Q=
X-Gm-Gg: ASbGnct/1jRMMS6eQRPA4SFu876IluaN3Q7F2/NuczQa9L9K/N3opzJOmbqDPxKNpNd
	4dSdvhNuvQFNTb4juDWzjEB5Vlc+fgqWV6ZKvCCI=
X-Google-Smtp-Source: AGHT+IExixo8sS8whkM9TAmM0xZZ0D7GWSHwX+2NSnPsYhH+M/4TEEnHkWwrgtcGhtivnBUioB4+7GAGM3e7SX0N4XU=
X-Received: by 2002:a05:6402:350d:b0:5d0:ceec:deec with SMTP id
 4fb4d7f45d1cf-5d7ee390bdbmr2533246a12.13.1734528897323; Wed, 18 Dec 2024
 05:34:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113173222.372128-1-ap420073@gmail.com> <20241217083024.6b743b74@kernel.org>
In-Reply-To: <20241217083024.6b743b74@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 18 Dec 2024 22:34:45 +0900
Message-ID: <CAMArcTXN2nSY+zRcyoc+Rmy1HWmkEPJ==7LojeX2cTrNoXaORw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/7] bnxt_en: implement tcp-data-split and
 thresh option
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

On Wed, Dec 18, 2024 at 1:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 13 Nov 2024 17:32:14 +0000 Taehee Yoo wrote:
> > This series implements header-data-split-thresh ethtool command.
> > This series also implements backend of tcp-data-split and
> > header-data-split-thresh ethtool command for bnxt_en driver.
> > These ethtool commands are mandatory options for device memory TCP.
>
> Hi Taehee! Any progress on this series?
> Being able to increase HDS threshold is highly beneficial for workloads
> sending small RPCs, it'd be great if the changes were part of v6.14.

Hi Jakub,
Sorry for the late response.
I'm going to send v6 patch today :)

Thanks a lot!
Taehee Yoo

