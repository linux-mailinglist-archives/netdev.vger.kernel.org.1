Return-Path: <netdev+bounces-177897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C69D3A72A3F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 07:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B660F7A4939
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 06:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926751A8F60;
	Thu, 27 Mar 2025 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dk0yZ6Aa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885C8462
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743057612; cv=none; b=hfMUs82oYpUOmyDoo7rEEB8mwP/T8BWQXuXy/CoXgkw8eIXGpM0VU6+9B0GP7sFz5g4fX4CqqU32zPw5weuIjJF7hNhCqFFGTFBycflW+tA7csTY5uPySwFPW8jc5yYt9YZkPV2BItHG/rgqtcjaObuNGFkt/uNURoCPod2K0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743057612; c=relaxed/simple;
	bh=hVhB3pfbSavGJmn5ih9KdVU6u//4aoMC7TEHsPVQVmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1e5YQBYwzs8kpvNaT73eTZSTPs6GvO90LduG290yVDs+8PwpHLvri4Ga7K7xMbYFFYRYwaw5X6qjtUdIGsAyiQ+7IjOhc3A+jMTeIjpArERYVSIeXImjkqiDSTYDnORIN8ref/dE5+U2bHL6IatyjurEe0mHjTVE46kgqTXEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dk0yZ6Aa; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476ab588f32so9932661cf.2
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743057609; x=1743662409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVhB3pfbSavGJmn5ih9KdVU6u//4aoMC7TEHsPVQVmw=;
        b=dk0yZ6Aa82hg8NmF9O1fmtmCK2X6oC4v2KOK/2AVdwGNwKP8mM93iAPmD/gdWmj4UE
         zmt5KPaqr58u3nPs9e9zZVVg8pxmoKjHcgXLhs0gbTlyOJ1RMdtZad3Fon9h27XPgfME
         itrYlUpqC+ZH5uN2EtykDmhxCY+h72RuuRKaET/DfEI3BJvhI5bTlsgpnq4FIpRvAGoM
         qk521t4It5l+kreUOV4S5B4boxJczjiOOVlzUdIADyLMAHd8vVNlZVpQz0VhVXUUBrII
         ohZstWRc+iaxc9RirbL2vVhAV5V84EJY1IKi007cpk2Z5CLEvOovJi5DXz0wPRQJh4wX
         YbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743057609; x=1743662409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVhB3pfbSavGJmn5ih9KdVU6u//4aoMC7TEHsPVQVmw=;
        b=V00WVhHEwc1RrFwc2UzrsD5RWu7xTPWDpY8hE81a8/8qj73dGbqeSvOfPKGzPdasHg
         0YSQtifWqbQ0FbfN2c2eCCKqVWj3gCECtU3T7GL3guzh65ZsQ81qYkbBT/Cejvm5LVz0
         HUZ4XdqsyBQExLosgkRHMLShNQWuEflce1ZeL/cMBII4wvxLmg6v/fhsJdiXa4QeYUf0
         5f0macZN+4zci0ProaUiQWWQnmRVM2cvQgafxiHguEgDsw4sn7fjeKGcW5WP1RWgbqDk
         UCjYdFYIfUFXNcr190s6DssrwYbLT9aQqnoa06wtKx+dxg4+W9gclJxwTJ4o3+AfqJ88
         pGVA==
X-Forwarded-Encrypted: i=1; AJvYcCVNg0FAWByPQK/tsYcNVwc+kOZXczu1/dyROQbN/fD+kld2C7Zt7MEwcMFIp22OWixvFXsFuoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34dofSWJhxqcB5FjUJ7ozNcr+RAM/bZgbOiV1u77fhEiIGlwD
	BSCFSC88NO0bfiPP3kouTaDcOvZAz6OymbOCHG9msGccb7EaRvh/UudGZAO2R2d0dPSmBrUyDZa
	JEPHBCIrKmt0j62I9muQxLsg6cKJgCFw0Tpur
X-Gm-Gg: ASbGnctsiLJA0m7/+pvcONKE6zbNMdL6AqOMiKvV4C6Pu5+I6jO/cMiSe7BhUXBTXBb
	5BCiA9KAGyJYCqc1nXpVYg3teYln89O0TVpkb9/cmPMN5OnuseYKJNyBXlvAir4NI/bk2p9Xa2x
	h4OzBEAx8bNSLlNtuGJAiIBciADFs=
X-Google-Smtp-Source: AGHT+IEM0+rxaQ5zCqmBUxN4zvMYmyJ5g+nu3EDBzsma/EgV6CrhhJPxV6MT8hz+Jt9uHg2FWusC7jJC8D1fgCu1IYM=
X-Received: by 2002:a05:622a:5145:b0:476:a4eb:10a5 with SMTP id
 d75a77b69052e-4776e0abbbcmr42147561cf.12.1743057608966; Wed, 26 Mar 2025
 23:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327015827.2729554-1-wangliang74@huawei.com>
 <CANn89iJn5gARyEPHeYxZxERpERdNKMngMcP1BbKrW9ebxB-tRw@mail.gmail.com> <df2d0ac0-c80e-4511-9303-3ee773c73a22@huawei.com>
In-Reply-To: <df2d0ac0-c80e-4511-9303-3ee773c73a22@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Mar 2025 07:39:58 +0100
X-Gm-Features: AQ5f1JrtUReUuY-3assA0nRUX3KVWYXbt4WVNWESX6MNVW1HNkE5q-S8tpom3HE
Message-ID: <CANn89iJdThGoaVc3LbucK_QGe1akNzmd5YOhMqmshwh_RfOn+A@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: sit: fix skb_under_panic with overflowed needed_headroom
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 7:33=E2=80=AFAM Wang Liang <wangliang74@huawei.com>=
 wrote:
>
>
>
> You can get the report in
> https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D106b6b34880000

Well, please provide the most accurate stack trace with symbols in
your patch then ?

If you spent time reproducing the issue and providing your stack
trace, please add the symbols.

