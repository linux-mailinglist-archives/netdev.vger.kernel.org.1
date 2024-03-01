Return-Path: <netdev+bounces-76543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E886E174
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 14:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0ACC281C03
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 13:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83D43EA76;
	Fri,  1 Mar 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWKMRoLG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF35A3D
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298174; cv=none; b=J7TywsWMKYPWjGYt9GWZvr783fkHKP4R4ttyLI4x4gOIlA9Ohfw8OZzeOD3s8swSA/no2atfHYSSwMmEGvVYpawgBMEliEWcXvmbA+v1pyvWAwMGCb0ZqqNynETDVBFtWJgh22MhpZi1rnwm8y3GjskntDu/Xs8RZzh4WPSx2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298174; c=relaxed/simple;
	bh=OvG24BkvEaqe8OrzbXeOdqfA7nREK6xO/wJ3GgykDvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T82s8si6VBSKRa0qKPAakQyWOsS3GVJPHNTKogdDCG4+drqjHPhpWknmCplJhmIuzUuLzY/8yETJt8uClei9FlUe60RX0VOLUbFFBHbEcMEaUelkzq+g9e2ISeYDMJzE+0zaZCFBwV29IdHSqGRpqJBYmZNfNszCTSUSuqv8hSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWKMRoLG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709298172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/riObx+6pHnsV2QvL7phojFIfjcIVe9zNsMuHpkwW4=;
	b=MWKMRoLGKe1JHTl4i+gY5H6Kzk5yy69TPjI4Ds34miK5LRnHPnVxLbjRwbCC4ZbO0w7Ouw
	ZY/85tPbq/w/dxY8c+gp2pPI2J2U1HwDM31KVFbl/xocPP9h/oE3lSPOkMfg0wJ6v9ekie
	YJO1Zau8uv3Ud10vQ28ABqdn87vGVPs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-avY1m2XiM4emvsDytep0cw-1; Fri, 01 Mar 2024 08:02:50 -0500
X-MC-Unique: avY1m2XiM4emvsDytep0cw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a431a294ebeso154220566b.0
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 05:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709298170; x=1709902970;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/riObx+6pHnsV2QvL7phojFIfjcIVe9zNsMuHpkwW4=;
        b=fT2TLpgAov1dHhd+++qSoKLexZmRxayZuYC6gEZBDvzSb3VR8khOia8vKQcGKoM1AB
         8xX7PuXFfbqWNOOezyNM2P4Y9wtsTbjYZbNE0whfPytASTDLdsadAJwXZ/VJnAkcwny7
         e2PP3RreO/U+ClmKZdKj0SGpZ72cry5NMtaX+2ENbE3GIu+g40B/AmWE7dVdGETObqkc
         mfXpvEh8esqayxEk13Uy8YV71xDfZyzKiTiqAPBLjpPgTMz0cboLJZMcp9V1yvoxWH6g
         pI9eb1oWPIAkUbFjFue79IljEAOl+ytgbyG5o8n411jq4eq3s1Jf1XUzj7gFtued4/nq
         OMJw==
X-Forwarded-Encrypted: i=1; AJvYcCVsXsijK6KHwGuWcXF5MhRMsr6O8jh1SVjodIgsbyMkUa2w0YBn2IgjsyomCyhdF091fN2PXj0VQ8gqxSII6Syl22vvSJ+f
X-Gm-Message-State: AOJu0YyGYj/PEaO2s/p4q0mR7XUzuJNOEWT22/tz3970gs2h7l628Bpj
	frVoYSzH2gqDi+nT4HFg95f8t0DJkb8HMW7C8kt3hwO/C38XBpjsTZbiGRlonXytzlzohhu5Dcl
	J7bcAZ0lpqcz+J0INQhC0ZgOwLOaTDWmDTr2VZZWFNrsTTx1owG6Ziw==
X-Received: by 2002:a17:906:b84e:b0:a44:511d:606b with SMTP id ga14-20020a170906b84e00b00a44511d606bmr1060268ejb.8.1709298169762;
        Fri, 01 Mar 2024 05:02:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYznp1w3lq4gy1tqCaCFYEfvS6l+yqp5A3bkph6XMD0U/Y7N/yG9456IKgIoYlVfBgSzV/4w==
X-Received: by 2002:a17:906:b84e:b0:a44:511d:606b with SMTP id ga14-20020a170906b84e00b00a44511d606bmr1060245ejb.8.1709298169388;
        Fri, 01 Mar 2024 05:02:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id mc18-20020a170906eb5200b00a3f28bf94f8sm1682191ejb.199.2024.03.01.05.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:02:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BF100112E96B; Fri,  1 Mar 2024 14:02:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: John Fastabend <john.fastabend@gmail.com>, John Fastabend
 <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: RE: [PATCH bpf] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
In-Reply-To: <65e0eb87a079e_322af20886@john.notmuch>
References: <20240227152740.35120-1-toke@redhat.com>
 <65dfa50679d0a_2beb3208c8@john.notmuch> <87zfvj8tiz.fsf@toke.dk>
 <65e0eb87a079e_322af20886@john.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Mar 2024 14:02:48 +0100
Message-ID: <875xy6ayvb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Fastabend <john.fastabend@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> John Fastabend <john.fastabend@gmail.com> writes:
>>=20
>> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> The devmap code allocates a number hash buckets equal to the next pow=
er of two
>> >> of the max_entries value provided when creating the map. When roundin=
g up to the
>> >> next power of two, the 32-bit variable storing the number of buckets =
can
>> >> overflow, and the code checks for overflow by checking if the truncat=
ed 32-bit value
>> >> is equal to 0. However, on 32-bit arches the rounding up itself can o=
verflow
>> >> mid-way through, because it ends up doing a left-shift of 32 bits on =
an unsigned
>> >> long value. If the size of an unsigned long is four bytes, this is un=
defined
>> >> behaviour, so there is no guarantee that we'll end up with a nice and=
 tidy
>> >> 0-value at the end.
>
> Hi Toke, dumb question where is this left-shift noted above? It looks
> like fls_long tries to account by having a check for sizeof(l) =3D=3D 4.
> I'm asking mostly because I've found a few more spots without this
> check.

That check in fls_long only switches between too different
implementations of the fls op itself (fls() vs fls64()). AFAICT this is
mostly meaningful for the generic (non-ASM) version that iterates over
the bits instead of just emitting a single instruction.

The shift is in the caller:

static inline __attribute__((const))
unsigned long __roundup_pow_of_two(unsigned long n)
{
	return 1UL << fls_long(n - 1);
}

If this is called with a value > 0x80000000, fls_long() will (correctly)
return 32, leading to the ub[0] shift when sizeof(unsigned long) =3D=3D 4.

-Toke

[0] https://wiki.sei.cmu.edu/confluence/display/c/int34-c.+do+not+shift+an+=
expression+by+a+negative+number+of+bits+or+by+greater+than+or+equal+to+the+=
number+of+bits+that+exist+in+the+operand


