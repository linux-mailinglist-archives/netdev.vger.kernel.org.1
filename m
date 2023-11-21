Return-Path: <netdev+bounces-49573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82C67F2852
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5221C210C7
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C02FC3E;
	Tue, 21 Nov 2023 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccTOkgjX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30404E7
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 01:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700557495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8atJKDI9wJOzzTdJbmyEhmsz2WSaij3Q6QLr8q5nSo4=;
	b=ccTOkgjX8x29ZXIXixXftNLOrkyY8fLHf65pfKTpajVaEnDQy3Db7Ul8yHnVr88l3V6oat
	wgVjaiQHIso6tpKdb2ZHfzL6ZUzzSP8mk17Ti7ey6oLts5wlnJF79D98R75tQ+FDy4pbpb
	JIAkc3ilTIJr4SKaoWdQrXNmT1JtiHA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-fqmOFZiBO0mts6nuIC3j6Q-1; Tue, 21 Nov 2023 04:04:53 -0500
X-MC-Unique: fqmOFZiBO0mts6nuIC3j6Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9fe081ac4b8so17698866b.1
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 01:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700557492; x=1701162292;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8atJKDI9wJOzzTdJbmyEhmsz2WSaij3Q6QLr8q5nSo4=;
        b=NwCpSIYfhS3ah3kVXMg6nUWrBnkMfkviRGpgRzyMScpDC6LM6kZdsVVQSUtO2Hrpuw
         xW4zwaTkA1n/IRVBXUg4Y89HMtWo67FgfUQN1c+yNJvFIJ40d8gh65xkoKZ0yxeByBBE
         SMzRWbf2ezkWV6cSDbQYBiSw2TJno9qgPXN5OFpZ7fecnGqS6pbmI+6UkuAlmkKALku/
         JJWJY/4sJke9A8IZeluDSQOO31+qeX4g6OouKjMKYQuvQHJm/BOf2EwXxMoNy7QZDkWY
         zvmDlcWTR9+Js5AfJLwYOs14eIz3WY08vQUkWvaohMawYCxVGvPGH/N34IhiD32u9X2b
         3QEw==
X-Gm-Message-State: AOJu0YwQEUtQN8VPVEUWZ+FJFey73csZDtvFK1MfNBFOydx7buceurW3
	/M7GrS00lUpqdow277ze3A28ZcwkRCDjWcO4ErcBVSe1y+47KZDcYn88FBvfZFxJ1BDXQ1deq9J
	vf1OCSWnlaLXI9XMi
X-Received: by 2002:a17:907:3f8e:b0:a01:97e6:6771 with SMTP id hr14-20020a1709073f8e00b00a0197e66771mr1206357ejc.0.1700557492496;
        Tue, 21 Nov 2023 01:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeojK3fVbnGGYa7XJfXFU/Zqc88WOH++gDDDFn8Ca5DqMiM7BeiZPkPI3Y5Vz/Vhoz7E6dmg==
X-Received: by 2002:a17:907:3f8e:b0:a01:97e6:6771 with SMTP id hr14-20020a1709073f8e00b00a0197e66771mr1206326ejc.0.1700557492033;
        Tue, 21 Nov 2023 01:04:52 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-2.dyn.eolo.it. [146.241.234.2])
        by smtp.gmail.com with ESMTPSA id qu14-20020a170907110e00b009fc6e3ef4e4sm2900795ejb.42.2023.11.21.01.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 01:04:51 -0800 (PST)
Message-ID: <1aef421ad72317b0adb12fecbd705aa2d2eced75.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>, "Zhang, Xuejun" <xuejun.zhang@intel.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com, 
 intel-wired-lan@lists.osuosl.org, qi.z.zhang@intel.com, Jakub Kicinski
 <kuba@kernel.org>, Wenjun Wu <wenjun1.wu@intel.com>, maxtram95@gmail.com, 
 "Chittim, Madhu" <madhu.chittim@intel.com>, "Samudrala, Sridhar"
 <sridhar.samudrala@intel.com>
Date: Tue, 21 Nov 2023 10:04:50 +0100
In-Reply-To: <ZVdMpLz1LPfMyM8S@nanopsycho>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
	 <20230822034003.31628-1-wenjun1.wu@intel.com> <ZORRzEBcUDEjMniz@nanopsycho>
	 <20230822081255.7a36fa4d@kernel.org> <ZOTVkXWCLY88YfjV@nanopsycho>
	 <0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
	 <ZOcBEt59zHW9qHhT@nanopsycho>
	 <5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
	 <bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
	 <ZVdMpLz1LPfMyM8S@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-11-17 at 12:21 +0100, Jiri Pirko wrote:
> Fri, Nov 17, 2023 at 06:52:49AM CET, xuejun.zhang@intel.com wrote:
> > Hello Jiri & Jakub,
> >=20
> > Thanks for looking into our last patch with devlink API. Really appreci=
ate
> > your candid review.
> >=20
> > Following your suggestion, we have looked into 3 tc offload options to
> > support queue rate limiting
> >=20
> > #1 mq + matchall + police
>=20
> This looks most suitable. Why it would not work?

AFAICS, it should work, but it does not look the most suitable to me:
beyond splitting a "simple" task in separate entities, it poses a
constraint on the classification performed on the egress device.

Suppose the admin wants to limit the egress bandwidth on the given tx
queue _and_ do some application specific packet classification and
actions. That would not be possible right?

Thanks!

Paolo


