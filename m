Return-Path: <netdev+bounces-180231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5153FA80B34
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 238037B1A9D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9127F4F3;
	Tue,  8 Apr 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cgr5BL6z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4F26B2BF
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117198; cv=none; b=EFzymW2tLRTYLDamAjq3RF/XbiUdJYPqFjzdVPdRmbdefz1BSCqJ6y0YixTJ5Aaq5B97iSZWcqR8ktwWUeNNDSiGfg2yvMD6kQ6hN76kIYH+jnZCHoOxK16xmiRbuyPtm5r5Vlc7DL1EFE+CLxHfV9wWa+srpieWMLfqSNqdx5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117198; c=relaxed/simple;
	bh=s1TP174YMK4LxiAYVrPE68x7vEjZ4WcU0UpC5MNk9No=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PccNTBQHBHOqmIf4yzxiKFr1iT8VTtmnoujKN9AzcM62IouDKm2l5sh69z6eXS0bwsxUoFWaygmJyBzUibijPlxY/ffcyIWyZfXDVL/6LoKTFEYNjpIt4kFSjJqvNG8+/rskDMkj2CCB2i/zggZ1Wv0Rpt8nJkjpWX05e9QOM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cgr5BL6z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744117195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+1rp4uauWG1vmNbq/hfPK6jZJS4M3SoZYfIuCJU2R4=;
	b=Cgr5BL6zQ6vyp2KEwzYy612KfmvXbvxV3IkLMb8FKAz3fOXyHYukio6CcbsUwmL7gOVBh6
	Ip/lGR+L+GzrSA7oaEWvRRJXk5lb30r/a8pFeLhvQOI9R6LyUgGSorpDW7xuSUz0fJQmMM
	xkBpkkRttImG/IVBrlVgWJy6YCiI2/s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-x-R-kFGpML6OmVwUoR9teA-1; Tue, 08 Apr 2025 08:59:54 -0400
X-MC-Unique: x-R-kFGpML6OmVwUoR9teA-1
X-Mimecast-MFC-AGG-ID: x-R-kFGpML6OmVwUoR9teA_1744117193
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac6ebab17d8so586258666b.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 05:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744117193; x=1744721993;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+1rp4uauWG1vmNbq/hfPK6jZJS4M3SoZYfIuCJU2R4=;
        b=H9mvBGtKWlSlhIkQxeYcN+4woIBvOqXqMuDt6Q4l08ynBFe7HSk+bUl+GvpuDg61Al
         Z2s8Kq+7pHljKsYWH7KwgWdP07YhkRicJ1jW833h/pT2gewBcTFVuCKppRDXxVcYJiLx
         9E6Fc0IT2LMb7T2IVlYX50RH/Gz5jWxt7JUxSKd3SRqilz7AKhUZqZ39Cf0Zul6lxKA/
         UNIDmmVrPOR5LHv2v9zBhZZNSFqJrgpF7hNcSttLudb8M0NDhNnPG0Xo0JC4D/PGPwNv
         2yHC6TDakB4nPa2noVKneMwC4GNggkEb45CnAnMDD2czIwODEb9+SvNT4sOrRlhHhz8D
         QcWw==
X-Forwarded-Encrypted: i=1; AJvYcCXCAEZ2UjuguBYlWDt63PXvGpPN2mCU3o4UEeyrSQgBmmWfzvxyr4Op1NDloG19L+Wi3jCPx+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNjHPLUGg7aliGiDfAeKDr9capxGc1MrGCvMI7lu5hEM6TQ4E
	ThLBbUOc7lxX6aOexckIXq/blUxRYesQhWAAgXoXjG3JBCEja5DtGHNRP0InbBIgM+DXAr/DlbX
	ECedCeHuS4NVvThyEb89Li/I5xFELbK535J3GiWg5SYF7RGzBhqc/gw==
X-Gm-Gg: ASbGncsKAsOI45nGdMBzdERMLE31T7ifNfY0lbBI5NOBdi5aq0YxJ8sSg2tSefExOgt
	T3riTM+3p1RvoX481GlkA2dq/FjgzWPPBmdOUJJsZdqeztV2XUgrR8B9Ua8BteWMJQMBPytHwxJ
	T2DW9sWDzDm0ucPTXfPZIoDjq2qs6mbQjs4+73nhjycFnYyYJTAg7lpC6M687x65FerADlxBTVl
	N3FKj3zLtefMtV5JaNTvnrStFqCU3r1X42PjbcOIkMbiObq6+ACAx+7/hKyd4J2V8PfQp7yo9Eq
	kRZmHQqZ3B56
X-Received: by 2002:a17:906:c110:b0:abf:59e1:ad88 with SMTP id a640c23a62f3a-ac7e7272f9bmr1236989666b.29.1744117192888;
        Tue, 08 Apr 2025 05:59:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4CNfuAwhmQJE7aiyr71NTAmA7Y21eSWNlFHt969eVragTZZg4eIe2Az8Xnzo40van4nv2UA==
X-Received: by 2002:a17:906:c110:b0:abf:59e1:ad88 with SMTP id a640c23a62f3a-ac7e7272f9bmr1236985566b.29.1744117192488;
        Tue, 08 Apr 2025 05:59:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c0185868sm910486466b.145.2025.04.08.05.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 05:59:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BD8B81991E15; Tue, 08 Apr 2025 14:59:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Ilya Maximets <i.maximets@redhat.com>, Frode Nordahl
 <frode.nordahl@canonical.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] tc: Ensure we have enough buffer space when sending
 filter netlink notifications
In-Reply-To: <126fa7e1-dbe0-48ff-9cb5-31c1d4dea964@redhat.com>
References: <20250407105542.16601-1-toke@redhat.com>
 <126fa7e1-dbe0-48ff-9cb5-31c1d4dea964@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 08 Apr 2025 14:59:50 +0200
Message-ID: <87zfgqvmex.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> On 4/7/25 12:55 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> To trigger this, run the following commands:
>>=20
>>  # ip link add type veth
>>  # tc qdisc replace dev veth0 root handle 1: fq_codel
>>  # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in =
$(seq 32); do echo action pedit munge ip dport set 22; done)
>>=20
>> Before this fix, tc just returns:
>>=20
>> Not a filter(cmd 2)
>>=20
>> After the fix, we get the correct echo:
>>=20
>> added filter dev veth0 parent 1: protocol all pref 49152 u32 chain 0 fh =
800::800 order 2048 key ht 800 bkt 0 terminal flowid not_in_hw
>>   match 00000000/00000000 at 0
>> 	action order 1:  pedit action pass keys 1
>>  	index 1 ref 1 bind 1
>> 	key #0  at 20: val 00000016 mask ffff0000
>> [repeated 32 times]
>
> I think it would be great if you could follow-up capturing the above in
> a self-test.

Sure, can do!

-Toke


