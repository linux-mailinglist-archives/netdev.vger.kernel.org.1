Return-Path: <netdev+bounces-70761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C9B8504BF
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 15:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8E8B225D0
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF4953815;
	Sat, 10 Feb 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbwPsK2F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3D3D554
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575669; cv=none; b=gnsWMR+En3D0bI6vI9i7SM8PZB5fwYkBM4HogIXAKA+LVXsFwIBoNq1rwlKgYPhdvRY4Vg/KP9Mq8LliRncaSqH5siOWtiNEQ9DyezeqbImU76g4e+fpp0GQ93StHrcGi40MAZTfgzLdzeQ1vZYJX2mMswiCn2iuZpP3m/kfzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575669; c=relaxed/simple;
	bh=hvgLSgmK9adtF1+vNKQz8hpPKcwl1X/SG40msaFAeFo=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cc/o1/XaZQ4ouL0ZT+oXkCIctfzIQLci1tJCtieQ9hEuSfipn6EgeMR+XI+RU4S5dmHdEa7149/JM6lK7JhKQPFeeCL+cx8hTDSumSdFnsrNL73dvZb5pXRWsyZWMqfGcMFwNZ1pIhyO3X3L2k7B13jLW7s04s56HEDvxtDDDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbwPsK2F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707575666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hvgLSgmK9adtF1+vNKQz8hpPKcwl1X/SG40msaFAeFo=;
	b=JbwPsK2FpMyD/AC/1hK/o6bYt7KkyrrE1thHPFvlS0W91vIYhRLThMFWkizYWxmYdgPKA0
	8xZ8gzOEAQG9H2I7m+I9he2GavfheIK6iT86b9vcquzX5QP3jiOAIEGRhiaRXBYi/nrH6u
	XjU4GDP2Y7Cw4M+anPER+xeLXPZi0K4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-8itb-VkkPD6-hiIFyunXRw-1; Sat, 10 Feb 2024 09:34:21 -0500
X-MC-Unique: 8itb-VkkPD6-hiIFyunXRw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-560ebd9c1cfso971074a12.2
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 06:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707575660; x=1708180460;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvgLSgmK9adtF1+vNKQz8hpPKcwl1X/SG40msaFAeFo=;
        b=KrMyjelOoxP+p3p0Srq0TH7n0okSubIqjEzUBlPvh9LRomiKLyMQxmMcyLksx2wbaU
         f8sm2u74Dmo6psY64gnyo4ECP7QE/sI6ZjPFAg/MogkXBwer2ZYkY6g51WIv/Lv/unyJ
         uzuqLvQ4pdZDZz6ptU6Fq7AcJzIVPCAcmX8mznPklCwC2bjUB1zfGQnJE7ULVPx3XDgY
         sFdGsmxpHEYYxkq4Bw+uP2ahOKQGWoLtFMbctP/euU2jfTN73oSqmgJJFZF+PRRyFoNt
         uDOIAoh6+/OXQLfVrXxibOqL8lBcPa4S78TjMUMIMtdT1gu8a5rm88gUG53jBPGzEELz
         GQHA==
X-Gm-Message-State: AOJu0Yynm8o6ePPmjjgvTkxD16oDvW2+y0X4QZS/w2FcJSO2K8KRXKea
	0vmjAhxYBuXKP2QChOMNk8D/Yzoxh2UV/tnCeUNfzqQ8yWdm+8Ek/LB18WixTsO8rHwSkzP+aC4
	Tlac6OPb6AVFN7ypuWQ7Xv9rZHfJRTbLxHTJdWNC+7jlwlLwO4lg0sNBIplFXSQ4ekazXbbly00
	jGpSIcFUlw4Y+n5n0MwQlE1Lf+ehZW
X-Received: by 2002:a05:6402:31a1:b0:561:8918:9f5f with SMTP id dj1-20020a05640231a100b0056189189f5fmr81206edb.24.1707575660666;
        Sat, 10 Feb 2024 06:34:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBHOAwtKugsfYsGKKeGZrsPVvpwBB5CpbNM/FRN2T4jFDAKwBJ48tPPFnoRq9MUGR4eo08k2hq2qAT+MvcfjM=
X-Received: by 2002:a05:6402:31a1:b0:561:8918:9f5f with SMTP id
 dj1-20020a05640231a100b0056189189f5fmr81196edb.24.1707575660403; Sat, 10 Feb
 2024 06:34:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Feb 2024 06:34:19 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-11-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-11-jhs@mojatatu.com>
Date: Sat, 10 Feb 2024 06:34:19 -0800
Message-ID: <CALnP8ZY7zNyn=r8_=ut7nivWwQCeUA_X+0_NXYEWR3dCh_ymig@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 10/15] p4tc: add runtime action support
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:56PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


