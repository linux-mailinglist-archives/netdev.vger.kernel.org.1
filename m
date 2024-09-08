Return-Path: <netdev+bounces-126315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E093970A91
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 01:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B20281BA3
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 23:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA3D1531C3;
	Sun,  8 Sep 2024 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSK3sb6Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A04D8CE
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725837013; cv=none; b=MCMc0+XD3N1vDjd/K9WssMPhk75kLvpEP60pIzaS0xE2WKWEKtCzsz4IS4DtOKMPYch48AcuECNw1/TasM2qZOvnTZO7OstuiD83GnWWUHEO4hnxCCQDL14TRflR/WOTfMrOIGqyFYs1goUrKLR/LVC4ZJXCr0pSVJFFa6QoGq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725837013; c=relaxed/simple;
	bh=2rjGI+tb5rWOpdBAKqqZHBU4uzpmnvjDkZoD6cLQL4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tk/07fdFh7Kf8W5kxkl2yv15hZSBVx7ycRdxYG4zd/pQwIlozWPNDED6dH1tLFHOK6wc8VdrxxJ83CYRVng4Tfu9OLWIBjrPbzQQYSCT9g44zigXJx1tgmODHaG6eiihx65YjdP2PLaFJ+9AQAkhSNrOnBqZRB6vG3SHHnP3mFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSK3sb6Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725837010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2rjGI+tb5rWOpdBAKqqZHBU4uzpmnvjDkZoD6cLQL4M=;
	b=MSK3sb6Q0GcrkyCcIfK7aK31MrjOLe3yWZ4yMM051rdLvhYybqny+7iytBOadgSVJqQ0q3
	PecFq9e2d1EZK/Vnq9Ze6C8/RZZQh/Wu8pAElsXvw1r0zUzywqIoj4RudOzxNPIaKAg5Qy
	0Lpwqxo1QXmlnCICDs1OAwjroCSAer4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-5sCKgE0FNMGCEik2sH88NQ-1; Sun, 08 Sep 2024 19:10:08 -0400
X-MC-Unique: 5sCKgE0FNMGCEik2sH88NQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c3c24f2643so2971721a12.2
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 16:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725837007; x=1726441807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rjGI+tb5rWOpdBAKqqZHBU4uzpmnvjDkZoD6cLQL4M=;
        b=BAkNkI7/e27M14YG76QFOe9Bj9LcnHbSAbTFz/zm2rrOHwT2kf9BJN6jEr9or+WWs9
         u3zr/3NqkCpzlJhfHQJb2Hl5wfH1/Lu7boMyl/oQCDRoqjXGVxR8T9g8nAhQsBUoheRj
         ncmWBXZQUIM6nb889+HnsB5NpVjjPvbnlEXpcCmRH80LMtaSNFLDbBZu0i9nsYlqb0Ho
         JkKvIfNgCSxTkuSK+DVfMv9oNOmv9vkqbQvVfWayqmsnv8LAIg3WCrZNSDc5NNVtAuwQ
         pWP1Wz8W2QH8EYSD2LqIm29VkJwMja04q4JewfqdlE2pyMsN6vAjdiZqENRe0F0v7Uy+
         m5uw==
X-Gm-Message-State: AOJu0YyomWHSk0XVNnwyBef6X5bTgU/0reJj6Jkkfj2lqS/jK+pMc30z
	Qm47XS1O7kcfTaDHkmkaPyv+FygSU5FMMjveCFkS+mV9TY5VxaGjvKOPmIzPx3oaz8yY2qCl04d
	9R4IhEc1WEllck2EtWDkriUI2PV/hJs9n5CiTTSu6uLed4CiicKojGEFdKI8z+iwNjH67R+s0PV
	eCoFTE8n9TDkreFBXQa9c/vL/Fz3JW
X-Received: by 2002:a05:6402:2693:b0:5be:eeb3:b9d with SMTP id 4fb4d7f45d1cf-5c3e962dac1mr3683342a12.9.1725837007182;
        Sun, 08 Sep 2024 16:10:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgxycz3v8bTuFFRVbSC0ZESRbbsXGcm3IOJYd3l17s4cYqPvofyfpu6igbR8sX3vLlbeedvJfM2z0Chtq/4L8=
X-Received: by 2002:a05:6402:2693:b0:5be:eeb3:b9d with SMTP id
 4fb4d7f45d1cf-5c3e962dac1mr3683301a12.9.1725837005979; Sun, 08 Sep 2024
 16:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903151524.586614-1-anezbeda@redhat.com> <ZtdxW9v8oWt-Ows8@mini-arch>
In-Reply-To: <ZtdxW9v8oWt-Ows8@mini-arch>
From: Ales Nezbeda <anezbeda@redhat.com>
Date: Mon, 9 Sep 2024 01:09:55 +0200
Message-ID: <CAL_-bo0tuXSpE_kMbYUWCktfSXxMP8vx1eYq=0_RspFsbx68AA@mail.gmail.com>
Subject: Re: [PATCH net] selftests: rtnetlink: add 'ethtool' as a dependency
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:28=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
> Can we use a 'require_command ethtool' (lib.sh helper) instead?

Hi, I apologize for not responding so long, I have looked at the
function from the `lib.sh` helper you mentioned. Thanks for pointing
it out, it is a much cleaner solution and would resolve the need to
test 'ip' and 'tc' differently from the 'ethtool'. It seems that it is
currently not present in the `lib.sh` file that is used in the
`rtnetlink.sh` that is modified by the patch.

There are multiple versions of `lib.sh` file, and the
`require_command` function is defined in only two of them. It looks
like some of the tests are reusing the `lib.sh` file that does contain
the `require_command` function from other tests (like
`selftests/drivers/net/netdevsim/psample.sh`), but I feel like adding
the `require_command` function to the currently used `lib.sh` file is
a cleaner solution.

I will create a new patch that will add the `require_command` to
`lib.sh` file and rewrite the check in `rtnetlink.sh` to use that
function.


