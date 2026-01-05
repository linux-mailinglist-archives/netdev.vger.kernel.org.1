Return-Path: <netdev+bounces-247181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53413CF54A1
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 20:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53413302D3A7
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 19:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDDD3242B8;
	Mon,  5 Jan 2026 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUHQX/eT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nRM8wwfO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FC28507B
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639871; cv=none; b=de1tp5nBz4Kjg7cJ96b6FN40NlrZb2vtCNviFxOoZIYNRqV/3HWA3sTrtivctSCt/LPBOlqLw8ksFva71qcwE3841Y8nsAXsb06ByDo/BNPHOCYycHMP0ys3B2XNnugdiUOLTOg9d4hAZJqq9uxami864zyzhJ7Iq6QgikrtE2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639871; c=relaxed/simple;
	bh=EW35fAGpc6irv6klge1pSAUT/e498MzsYzLU58+p0RM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eRw849qxvTRD2tIA6qI0kskdUs0plJ0tyneC60lME+NYLQb0ZdkWvcRi18QRdbDptZr+oSTOo692AiGkZ290nIFllX2tp8karlduYNLdlIYuMBW94h1pTnWpe0/7nM2lNOw07vW9avy4zqUJ+U81yYyFJZaqhoAAyl6S1AaFM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUHQX/eT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nRM8wwfO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767639869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PP3X6T+cAs16XCJeSGeaAouaKAUNwzGXxOOaWFTYxXk=;
	b=eUHQX/eTrr5XY4oY/EHMCrlXb0rIPuapBrcM9bm5QObRb4dZJibkHMIqHTLrnzSMiYe6Qx
	apEJXS9wo38p2VCj9pQbrTL7HaT0fe9Z5iBQZ3itP5K9qxsue7out/7HqWto0GrKTjasmn
	u5iXhHsHVsJYp2e7ZFEU7WmQjBteXUM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-UQ_2IdpvPoC-dAQSbm05aQ-1; Mon, 05 Jan 2026 14:04:28 -0500
X-MC-Unique: UQ_2IdpvPoC-dAQSbm05aQ-1
X-Mimecast-MFC-AGG-ID: UQ_2IdpvPoC-dAQSbm05aQ_1767639867
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b801784f406so32231266b.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 11:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767639867; x=1768244667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PP3X6T+cAs16XCJeSGeaAouaKAUNwzGXxOOaWFTYxXk=;
        b=nRM8wwfO00ZS831dTIXYEPEH9DCgFw/pK/7Yg7SSe2s6hBlazKLKhh3ecBZ/Osbrsa
         VVBFA8zi1EbrQiE/B0RK0XUO4fo6E7bf3z0Ek6RckbiSdc01pJ3goDC1T4W7rW0htzB8
         A2/IVlO5GKar6NGz9UmRKPTaUNEs/KhoBV4qznwiR1i/0eUF6Zqu8v62+OI7PKvHEo+w
         WMPoguBXuyMAgg/HWqns0YEzrxfm0PATN8KgN8Gc6eWat6VTTIGmqdAZt7bAURsQMa/w
         YcZM9n/R2CokDMFduViiDULlxfZhWoVXTHKnKqPCJQRxjhKvtqLbCTTQUOlMsyApp7QT
         TMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767639867; x=1768244667;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PP3X6T+cAs16XCJeSGeaAouaKAUNwzGXxOOaWFTYxXk=;
        b=I4yGroPF+AW6rt/NHrO9Y52OJLiI/pT1/jim7xnpJUKsZrnKKxMonteOVyS737NpY4
         wzWaQqHeREXMXZUCxjkjLUn/vJFOx85AqWxj5yirCDl6fknB93hHgNSAc/5tOh9KWvXo
         zFHEbG64BR3AZiFdscqB5mYaAZua2uBhb+WXSJDaVpWdQPsBZEIncTVIa3IMMqaIJqwl
         mAYa3VVIc5jXXbzrLkWG/x83GGiPzOxGdxJctmGOOsoTh+y+nhwGglSItS1S8LBbSKDz
         LHlcQmHlKqSm7BRG3Am+uHtPPJQzko504vuCwuvcea8S1ov/msVrCNGdBIyPFv3VloQm
         edLw==
X-Forwarded-Encrypted: i=1; AJvYcCXeZeh4+bQyxm4enQkhy7yJCBu2hitwZG5etvVvs4w0Cpwj361rPESdqa7K9n1CQVQRdIc5r3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7AsaKzA1u5blZ0evRE7BvXLx59qlkwNK3xEr5HIORpjCFXIHA
	aZoKHrKQUpLlKDDKGqRgtkT2PVNAi96x2yNaGtQ5CmXxpitBu4Z4p5wLdjsOBdTJMkMaSp8TYhG
	EaTqz+jZ6/NlZFso+rTQXOW1RdM2z8FYebW7F/iL2/VE4LzPLp1ImgRI0yA==
X-Gm-Gg: AY/fxX7ZyEgokLQCgS5VH4wYEWDGrG/kz3YgGc8NxXlo62UpUuBLEtsG4eDwk9jiNMK
	LfbQ0myBAgIl18rk1IxE64vFhHnfDCWWA0fknHB9x+8uD8++g8LnumfFNmdLHoaa3p5RhwDidcE
	z20cfHy4R/FP7D/NCrqASGl7IP+ehFoeWcbaBELEdX07toLuGoQcnH+rqZoDTjiQaIgEdxRgIE/
	KK/WbIwWbttmCWhigRdCmGc/aGVNF0KA6CnoA1Y8Dfk2hM7r5VVBW1A4Ybas+xV6219GGnIks4M
	aETsinSdsr79yHLSCarx+wWpOk5t5SoHqfGfl3d32h9UksT8kkMtB4pO25kOJCPEmXQbL6kJGOa
	GUVkJKuVb7EE2UwzlXMp6AyEE+VOJB+zL4502
X-Received: by 2002:a17:906:f59b:b0:b73:6f8c:6127 with SMTP id a640c23a62f3a-b8426a4b134mr86837666b.12.1767639866862;
        Mon, 05 Jan 2026 11:04:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbl0sMF7WNuNmxyY1IoonTxVITXROFrKJi6E+jKHxLhqK6WzqE7cMd2bm7JOrdaxhfHloe6g==
X-Received: by 2002:a17:906:f59b:b0:b73:6f8c:6127 with SMTP id a640c23a62f3a-b8426a4b134mr86834166b.12.1767639866393;
        Mon, 05 Jan 2026 11:04:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a234000sm6862866b.4.2026.01.05.11.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 11:04:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DCED9407F1D; Mon, 05 Jan 2026 20:04:24 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Update xdp_context_test_run test
 to check maximum metadata size
In-Reply-To: <CAMB2axPO7VENB-XUSUb5eU1ae7h0NBjbVukzxaObBDMMmkGYAw@mail.gmail.com>
References: <20260105114747.1358750-1-toke@redhat.com>
 <20260105114747.1358750-2-toke@redhat.com>
 <CAMB2axPO7VENB-XUSUb5eU1ae7h0NBjbVukzxaObBDMMmkGYAw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 05 Jan 2026 20:04:24 +0100
Message-ID: <87eco36fuv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amery Hung <ameryhung@gmail.com> writes:

> On Mon, Jan 5, 2026 at 3:48=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> Update the selftest to check that the metadata size check takes the
>> xdp_frame size into account in bpf_prog_test_run. The original
>> check (for meta size 256) was broken because the data frame supplied was
>> smaller than this, triggering a different EINVAL return. So supply a
>> larger data frame for this test to make sure we actually exercise the
>> check we think we are.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  .../bpf/prog_tests/xdp_context_test_run.c          | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run=
.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>> index ee94c281888a..24d7d6d8fea1 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
>> @@ -47,6 +47,7 @@ void test_xdp_context_test_run(void)
>>         struct test_xdp_context_test_run *skel =3D NULL;
>>         char data[sizeof(pkt_v4) + sizeof(__u32)];
>>         char bad_ctx[sizeof(struct xdp_md) + 1];
>> +       char large_data[256];
>>         struct xdp_md ctx_in, ctx_out;
>>         DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
>>                             .data_in =3D &data,
>> @@ -94,9 +95,6 @@ void test_xdp_context_test_run(void)
>>         test_xdp_context_error(prog_fd, opts, 4, sizeof(__u32), sizeof(d=
ata),
>>                                0, 0, 0);
>>
>> -       /* Meta data must be 255 bytes or smaller */
>> -       test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0=
, 0);
>> -
>>         /* Total size of data must be data_end - data_meta or larger */
>>         test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
>>                                sizeof(data) + 1, 0, 0, 0);
>> @@ -116,6 +114,16 @@ void test_xdp_context_test_run(void)
>>         test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32), sizeof(d=
ata),
>>                                0, 0, 1);
>>
>> +       /* Meta data must be 216 bytes or smaller (256 - sizeof(struct
>> +        * xdp_frame)). Test both nearest invalid size and nearest inval=
id
>> +        * 4-byte-aligned size, and make sure data_in is large enough th=
at we
>> +        * actually hit the cheeck on metadata length
>
> nit: a typo here: cheeck -> check

Oops. Will leave this for the maintainers to fix up unless there's
another reason to respin, though...

>> +        */
>> +       opts.data_in =3D large_data;
>> +       opts.data_size_in =3D sizeof(large_data);
>> +       test_xdp_context_error(prog_fd, opts, 0, 217, sizeof(large_data)=
, 0, 0, 0);
>> +       test_xdp_context_error(prog_fd, opts, 0, 220, sizeof(large_data)=
, 0, 0, 0);
>> +
>>         test_xdp_context_test_run__destroy(skel);
>>  }
>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>

Thanks!

-Toke


