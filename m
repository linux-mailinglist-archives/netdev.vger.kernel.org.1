Return-Path: <netdev+bounces-80021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DB687C857
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 05:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3AD282F62
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 04:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C60DDB1;
	Fri, 15 Mar 2024 04:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="a7tk81tb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22FDDA9
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 04:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710478005; cv=none; b=nLaszQFfAxMfRWmkZvcloRiTtJoW3PEr4fhx4ukLzYboL5xT/dtT6l/gFT55s1V+xpKHCmSTh/BQXbl3xlJGTvnMRYWFfPrLjTZV+1MMpt6Mkx9JBlIv35HNi8uLfl5wfrebHW8vAqYUVEztcAi1rtX2uPGIr0DwyKHHWzE168I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710478005; c=relaxed/simple;
	bh=USPOvwETNygqrq8lQsfcxdTQonLApjSfO+Tu3XQAwLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6u727yn6s8D/gyBgZcX1QhDpzwOG0nZcYtJYF2ODkO1w4uDrDFo/AbWa4I2vCyL+3HUMnBr8bAiHWFur/7WH2Fv2v6UtOnCLbOEf4Wqb3dxskyRi1AeDB2S/yqt2QKBiaaDnGYIxwzF81PiVvp874J+FpPT6Dhhy1Tmi7G9tRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=a7tk81tb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so1486576b3a.2
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 21:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710478003; x=1711082803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRhcBMHrXtlXWlGZhdypOLdlC8YORx05S7E+LlUDeu8=;
        b=a7tk81tbmoGxDNK4jHJfqBcxo+86IDYNwLyu6IjuYjqSwR8AO6l8URbYQpqnAi3Fjr
         m671YTAVflEVK1//ncUo/xylmENJchNz44cqQ8czJXRMvGTbK0UD7i2tN70RsO14Vn4F
         Qwid3v/kcPIMA7omfj0bmNmDfse8spt/gtQb6BcbFTI0JTWmIMhVBX9H+XZ8PeI1gv71
         K3lZftbetbKI2DpHf8X5jbIMkmMchMSLN1yyD51PHWkPqoBwCPRG6CzGiXd5OlgAASeo
         yUU7dY2icMAWZfI1KfRaFoQ8lY2pTlmhHFe4BdHt0ryfiNDnUFu3NfH90hDlVR0vvCW2
         AZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710478003; x=1711082803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRhcBMHrXtlXWlGZhdypOLdlC8YORx05S7E+LlUDeu8=;
        b=BRRVhYIgcTAwYb9M+ZMUZ9Ve4gYkgQMAcEpq4MT+escvYGAnvgXmVmByGzjUKu7fNe
         +v8oyHvz5BuaNIqDV2xRsS/lffKYbHuxZsu0HDe7XP8jWlBDje+W97lojL0c747c4Cj2
         3ZSgQNnblWQO3+29m4RqxAuCqaCXEBgA+QaFhXmpDdaYo8NGv/c7yysXyFjT0tuDBW5n
         gs9EaWJrqpOv6YUMFQFbUq5HiScYu9Sd2gVwnoXWhZbh2iUTQvaOTuYhG9yEwZuYE0tt
         LnzhLS3/RequrR26eA385uk9+RyaV1wVn0nalaFEyqxvLn1YaGFFPYBmqurLEFO4KQ3y
         QZig==
X-Forwarded-Encrypted: i=1; AJvYcCWc0c43VoBp4ToiMcZ+/Ms3oILvzZUlm2/x4CH7+ZU6c1eky27ezkaDXU9axFxbmkx7YXuvzgyJpDTpignuy3DDha/GnDfl
X-Gm-Message-State: AOJu0Yzvs2Zh/GEdwVmcnYRR8NtdQm1gt8hZVp2L//gpGRU4kun+GkJs
	/TTFz9KDVYBk7x4OSIk7kzH7XycyRsB4khdQYcHDGpYLBLLnjCDiwuotbxa8Iok=
X-Google-Smtp-Source: AGHT+IHL1JgofBjBzOB3yP6jnjdh4gTTMUMaJCnr+uLZ9KcGga7yvrvHrNhkojVz8Uu0flr1VLKoLg==
X-Received: by 2002:a05:6a20:12d5:b0:1a1:8c2f:39d7 with SMTP id v21-20020a056a2012d500b001a18c2f39d7mr2446156pzg.34.1710478002774;
        Thu, 14 Mar 2024 21:46:42 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id hg5-20020a17090b300500b0029c13f9bd7fsm1837854pjb.34.2024.03.14.21.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 21:46:42 -0700 (PDT)
Date: Thu, 14 Mar 2024 21:46:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Denis Kirjanov <kirjanov@gmail.com>, <dsahern@kernel.org>,
 <netdev@vger.kernel.org>, Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH iproute2] ifstat: handle strdup return value
Message-ID: <20240314214640.09463821@hermes.local>
In-Reply-To: <20240315022329.GA1295449@maili.marvell.com>
References: <20240314122040.4644-1-dkirjanov@suse.de>
	<20240315022329.GA1295449@maili.marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Mar 2024 07:53:29 +0530
Ratheesh Kannoth <rkannoth@marvell.com> wrote:

> > diff --git a/misc/ifstat.c b/misc/ifstat.c
> > index 685e66c9..f94b11bc 100644
> > --- a/misc/ifstat.c
> > +++ b/misc/ifstat.c
> > @@ -140,6 +140,11 @@ static int get_nlmsg_extended(struct nlmsghdr *m, =
void *arg)
> >
> >  	n->ifindex =3D ifsm->ifindex;
> >  	n->name =3D strdup(ll_index_to_name(ifsm->ifindex));
> > +	if (!n->name) {
> > +		free(n);
> > +		errno =3D ENOMEM; =20
> strdup() will set the errno right ? why do you need to set it explicitly ?
> > +		return -1;

Man page for strdup says:

RETURN VALUE
       On success, the strdup() function returns a pointer to  the  duplica=
ted
       string.  It returns NULL if insufficient memory was available, with =
er=E2=80=90
       rno set to indicate the error.


