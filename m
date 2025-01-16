Return-Path: <netdev+bounces-158930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4910EA13D5C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE231888040
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788822B5A4;
	Thu, 16 Jan 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRlCteGF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3391DD9AC
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040419; cv=none; b=T3conw4+ksORZWrbed/IJ1JKxXDvc2T97TD2hZVdTLdaeKmUzaEvxvkC/buXLlAYQmo2VQXTUxoSqmPL1+/5kULlY28xS/aFMpxLJlcyxY8aPZpKGq0o3n5HTtb5oogQCB4JvjCJAmz7rDZ2KIuTGr+oiLN7H0jh3kiYAqEQz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040419; c=relaxed/simple;
	bh=Rm9U+LikrwsLMBhE4urZm2lq1jTTHeP5iXYUS5+/0+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hx+M/TcWc+3yK/eHfW9R0cmaPWnBKVk5IjVVV/Q6eQsJTSKFmvYg+uvMAi22RizKSBvZB9yhq9vVDpRlwS9ktA2rJFALK7+UI8YpVrRTv+/0CeCAkNQnadb5R4bGeTU5jv85xeBSfYpAMI3E8w3gLuQ/jbJ70Uv0setbRjhw2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRlCteGF; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467896541e1so260671cf.0
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 07:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737040416; x=1737645216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yXVMjy/vsHybAFrzZeMLE1CCIXgfmMqlAdhH1pduzk=;
        b=IRlCteGFhcP8VpFdVEEzwAxcqK2HkyMz/iqWHKEh4H5a1dUeCSiJ/k+AnSfPvo02Xg
         cFoC9DsmnLm8XZImLi6Qjn3d22itUt8Zd3u4290gzsGN2eeHYJeX6fo+oIBQt4Tp6OkO
         Eb2+0ib9WEi2TM3H5XvTyLNh8o31J/1Ntf1eO7S2PmS8K92ejGJP5kWDgFCG7tyqUYV2
         Sz+fOunavNvZJPSexBIVrlEhXeDXr/+mh+d3P6fIhtygD4XcnTQnY6xtvnKl3drkVuwd
         HUCGVbZflAD60rAI1j9jvLCEc2ikoUXq6h6hMapmZdH4v55VNn1olhpoBiFJGLaYK+jj
         WyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737040416; x=1737645216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yXVMjy/vsHybAFrzZeMLE1CCIXgfmMqlAdhH1pduzk=;
        b=ju0FJMhYZ44d7j6Dr7YVsER93NmjF5udKWreHRoeET6xz+9TXQbDPiqMn+WGnt3k0v
         hHUrCD91M5rXKCclSQBtI2alyOuLIrtBIEprhEoJEsrWEDTtj96TXx7h1gojCDMZE1xQ
         9VuUUnDo8Y5JrqRdRuwFmLEyLwm/3opsdrSJcGfEi+AwIHuRfIRaQmjL2HrImvSocfiW
         QclfdHANt3/uBTO6SB9mrKEyFsQY5ekxw1zWY0CwngvIvELf3dTAenYRQyaNR4MVeyg7
         yi70EjgB52hUBVRyZRPQxmYWiqZsDebP7rOUIF4uR01WYYye1xTPWTjrUxqqIt4OOMvf
         kgcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA82zH1SkWdUifWTfk99UxgDmQvLrR3KLAAsL+YzrDdBH3P4pnn+l0aKg5G5EZoBFuAmrKFoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5BoCJtq0XRHJ6RrOka+BJj8SRv70RsLv3gGRGmWvi/qA+x9AK
	rf5Fm+DdmDEgCnE6fiNxXx36QHaXT0qqA8W7Biz/Rubzo8E6+lYsoCpHIU+gjazm5QKJ6cXnwsj
	3AoURTlzTgzXUcs/dldAg6EwpOChVc3ia3PHxKxwd2NPWSRuMDb+pq7Q=
X-Gm-Gg: ASbGnctlDkbYuqopyAwN2dXhY2JEoYET5CAP+0CkjT5QrJBfF6RDr3+2QuatX3jnRl+
	9t1yMaqoRRmP7iRoF6pq7qP2FSga862qLR5Z9HcCvyedZCDPoggErrfBmSzq6XvKbAO2uYOw=
X-Google-Smtp-Source: AGHT+IFvyZAfz36yss0sELhxfed5sH9K6Ecdgj3FyM5mtlyGuFWlBDPced7RRd4ANaUn3NDBMF9fzRwgB+QzyrKA6i4=
X-Received: by 2002:a05:622a:245:b0:467:82de:d949 with SMTP id
 d75a77b69052e-46e041641bdmr3814561cf.12.1737040416271; Thu, 16 Jan 2025
 07:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <408334417.4436448.1736139157134.ref@mail.yahoo.com>
 <408334417.4436448.1736139157134@mail.yahoo.com> <CANn89iLzo0Wk7p=dtUQ4Q2-pCAsjSxXZw71ngNTw6NZbEEvoDA@mail.gmail.com>
 <2046438615.4484034.1736328888690@mail.yahoo.com> <CADVnQymzCpJozeF-wMPbppizg0SUAUufgyQEeD7AB5DZDNBTEw@mail.gmail.com>
 <1815460239.6961054.1736660842181@mail.yahoo.com> <CADVnQy=J+mse5Zx2gfctxDa4h-JHjW885RjtfVZ7DbSr_Hy9Lw@mail.gmail.com>
 <979088118.32930.1736903937403@mail.yahoo.com>
In-Reply-To: <979088118.32930.1736903937403@mail.yahoo.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 16 Jan 2025 10:13:20 -0500
X-Gm-Features: AbW1kva6epIZEE2WI6quuEXInXwkzr_TdtYQW7-Sk7lW6GAsru5yH_gt8B1EsLM
Message-ID: <CADVnQykL-z4bzAsxtqPa2EgEkc+fbDYBiUCjym-Jf3k-bphjcw@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: Fix for bug in HyStart implementation in
 the Linux kernel
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: Eric Dumazet <edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Haibo Zhang <haibo.zhang@otago.ac.nz>, David Eyers <david.eyers@otago.ac.nz>, 
	Abbas Arghavani <abbas.arghavani@mdu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 8:19=E2=80=AFPM Mahdi Arghavani <ma.arghavani@yahoo=
.com> wrote:
>
> Hi Neal,
> I appreciate your guidance in submitting the bug fix.
>  Attached are my updated packetdrill tests.
>
> Best wishes,
> Mahdi

Hi Mahdi,

Thanks for sharing the modified/added tests! Can you please make the
following tweaks and retest:

(1) to ease git diffs, please leave the names of the files as-is when
you modify them

(2) in cubic-bulk-166k-idle-restart.pkt, where your version of the test say=
s:

-   +4 write(4, ..., 160000) =3D 160000
...
+   +0 write(4, ..., 112000) =3D 112000

...please change the write to actually still insert an idle period of
4 secs, so the test is still testing idle periods:

+   +4 write(4, ..., 112000) =3D 112000

(3) in each test, please add the following before the first injected
SYN, so we reset nstat counters:
  +0 `nstat -n`

(4) in each test, after the assertion following the "Hystart exits
slow start here" comment, please add an assertion that ssthresh has
been reduced from the TCP_INFINITE_SSTHRESH value:

+0 %{ assert tcpi_snd_ssthresh !=3D TCP_INFINITE_SSTHRESH, tcpi_snd_ssthres=
h }%

(5) in each test, after the assertion following the "Hystart exits
slow start here" comment, please add a check of the nstat counters to
verify that a Hystart exit of the expected type has happened, like:

...either:
   +0 `nstat | grep TcpExtTCPHystartTrainDetect | grep -q ' 1 '`

...or:
   +0 `nstat | grep TcpExtTCPHystartDelayDetect | grep -q ' 1 '`

Can you please test something like those changes, and re-attach the
pkt tests, so we know what the behavior is after your patch? (e.g.,
which type of Hystart heuristic is triggering in each test after your
patch...)

Thanks!
neal

