Return-Path: <netdev+bounces-70762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E28504C0
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 15:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CDEB20D1B
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49AA55785;
	Sat, 10 Feb 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwcTQOmx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B93F36AF0
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575750; cv=none; b=I74Ce65Nkop0uXg45pXfiWvfJbL8pn6NxeL6wNnqmScmhDC2LE4qcuQCMfacJ8P1OCqqFpne7bfFgygirLRyFO/qhJuBe8zZiA72eG43D/m62o/kO7gpwGvJH81TtmZn9UHF4a1zg+gYR5gqs2ZrcMQiSubMPygDtVo5FiTAE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575750; c=relaxed/simple;
	bh=065mOA8gk1fr4YoBODRGT+71mMfL81JgnvEfwqK7iVc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGPdTyzhzE1WSXOOw6+vQSx+j72sHzeCBuUmyi2sE0DSIfEW2GMxODB7Ylv90zVrl8X7rFsVfcXEW4dzoZnbVTRr70TCy7xxOostmTgbasLegUARnEeDwIvAgjgmrIB+od59cWvy+D+A2kO9QIvNorgbD1LMwgTaq0WUAkdaGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwcTQOmx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707575748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=065mOA8gk1fr4YoBODRGT+71mMfL81JgnvEfwqK7iVc=;
	b=AwcTQOmxPXz5eOJ2FFrEA8UuJTN2wXDgggCi0cF7kNosCW+ZIfrNaPO7Ev51+k+5GCFIqm
	Tz1L/993QMXObTS/2fVgUNRi5ctBK6oMXE1zZX6tFDT8dsA4dEL4613spSZZ6n7OdE27TU
	kpF39C26zw33wLIxuk70PmNACvD6VrA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-6id91aYFO_6d2b9OcwR1Xg-1; Sat, 10 Feb 2024 09:35:46 -0500
X-MC-Unique: 6id91aYFO_6d2b9OcwR1Xg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5611f358194so990929a12.1
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 06:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707575746; x=1708180546;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=065mOA8gk1fr4YoBODRGT+71mMfL81JgnvEfwqK7iVc=;
        b=OKUOhrcKeppweDX8nJf1bgCIPky8PA27ITJdBddktXQliyIISpWXmaUWcirrqHXK0g
         jLi/oDNEDF/l4yGkEp4Jrwj4o64rJe8A85snzVZfhwBt7ySf9dTSC2bPhV08bfcX0/Bg
         2WydhFjIZzOe2w8wfcdz1dxfOGDvRe9qXrqYRkYbz6J4OPyWxuI2jcHPyNMiU92L95cS
         bv3pa+JeqPq44jgchUu5pHAFoAiPS/ih7IAfCBhAlavobOq4oG2y32NT15nwPokHk6xX
         2wycEls6wL8sljVmnk/dCsJ2TIKmBOPvvQ9JqmoO1IYO394+CibJLP5qbRjiAMg53MhB
         NS/w==
X-Gm-Message-State: AOJu0YzMLuJq9Lp+SGevcT3hFtbjsSSUcfj9bC3EYlBVy2Fg3UBgZwwY
	4FKp+3OVrfM0utNy/R5/hSDBalr62DTBKvNPKZWdXBsmEX9duy+2+RB2u+vpuCClwR0P2aScbfE
	hmopYHCaWJ/D1Ponczk0ZFmkR8jXTuQppwIYT6iQa8STNn/SroiP0KkElAY4ku5u29vWY6wCehx
	Qee4ZqqwhQjp4MxNJvarIzO7wAkrsJ
X-Received: by 2002:a05:6402:1a45:b0:560:79a:11d5 with SMTP id bf5-20020a0564021a4500b00560079a11d5mr1284540edb.9.1707575745848;
        Sat, 10 Feb 2024 06:35:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES8vikUfOPkS22sVebWCSm8Tn9Nv2RDKgS2EBKWU4t4rbMniayUavbKOBe2+VhAVGc3fm/s3abpDFuVQYxT1s=
X-Received: by 2002:a05:6402:1a45:b0:560:79a:11d5 with SMTP id
 bf5-20020a0564021a4500b00560079a11d5mr1284526edb.9.1707575745561; Sat, 10 Feb
 2024 06:35:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Feb 2024 06:35:44 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-12-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-12-jhs@mojatatu.com>
Date: Sat, 10 Feb 2024 06:35:44 -0800
Message-ID: <CALnP8ZZiBh8w6yoiNPx-Oyj9+zosRVpOKzH8DaVpQC=xr3itFQ@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 11/15] p4tc: add template table create,
 update, delete, get, flush and dump
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:57PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


