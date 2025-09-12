Return-Path: <netdev+bounces-222561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C876B54D44
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87648189DAE7
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B8322550;
	Fri, 12 Sep 2025 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USFRPLME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8F301474
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678933; cv=none; b=Pv3DQrd/uvaZcqmW8lx5jnCWUH3u6BnT6WxfUwgk45yYD1CRrp6SqOAg+6xYxBsPbnAGDCKe9qF3f1DagxKpun1G7N365DsLKJ5OHQ+pplJdeJRVTqGdwLVNS9NBGvuoerlRSjh5fiykq4Kd/0XJ9wrmgcY0h3KwQ9hWaAAf7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678933; c=relaxed/simple;
	bh=V8fbqWQOTCOVVu7/P1rim4+IvcAYfNiZG/w2GK6cab4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=k+l/9a2KRjMdE/uaYD11ENEQk05E677vVN3S/azuZTntdJilyQ3cPL7Wg+8pOIUj7FyiRhfp7TO1ZAihvarvn9q0hbvOA/peZ205yYf+VujmSuWXwTpjbY8QpxRFcCbzrS8XVOLRVPVmZl5VlwMku0dM2TbuClcF4PGFSrfUzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USFRPLME; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3dae49b117bso1450562f8f.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678930; x=1758283730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eyXwEntkUq/1IvyuiiJejzbrGCs0SwPC/bonUwQtC/g=;
        b=USFRPLMET8iMeq4zcZ8E8+nwdjL3RtSi1H1/nHgsrDXabFKMpGZKBVLsQ71tvWuSyE
         FL17fUmbMAA+/wOyy+fAV1pYhYDM0QqWraHBLcDA1iXEzNTzdblYIBtzMpn+HUCw7qjK
         wFK/gwa9ORNJ2KJGBhAn7qX2N04p14IzJu1cNz1thEbDs1n+IuYXqCbRKC6jFK2ChiMd
         qzt2XGJprlrSLEaWE2hReK7Pc2fGc3HQPgWCHN/oM6J2FF5SuHy5MZgnKPZW7/fRTgOC
         cvDxNEbCOp8JQQJMrSUVuGWyqYeg59NGZwGRrzBp67w7raL3aIxPJMNPCg9wyA6gJaPG
         46+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678930; x=1758283730;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eyXwEntkUq/1IvyuiiJejzbrGCs0SwPC/bonUwQtC/g=;
        b=v54A4guLX9+yWQIUZDSzRH20xKdmY0xn45cSovNePAl3FBW0rNBEv02ZzOkLAiC/0R
         s1b2pgyZ93wOIgJWkPZnBNEygWdCDj/G3hjFp+7qBQ/Lq7s4FMEWq9WVYKJPA/Axdtba
         IwMFLAZKJBmxVMAVTD7StTxC0Ez3cFeq/Et9ZIKHueT+HikmQza9RsJCF/i9kVB9XgsB
         f2Z5w99IWA1mNwxndEGFpY6rydfqjwXnrOjk7ob0Npt5UmEWgwRRZHS9oyHe7MPw4okM
         AYItW4cBn9OKmFB5G0VIp9xTIhYR5NkzECy7ladsX7Mfg9Io73KWRBcyyl+h2lCR3h40
         9sHw==
X-Forwarded-Encrypted: i=1; AJvYcCUqeJXfRUbeQjfotJRgBMHm8HC3pEJ4uhCLhVYrRsAbltDj071VLsUeXegaJIysPYkshKa6o8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCtpUbXjalsWINsQcorpXayjg05g91Hrg4cUcWYZPGzer7fBZO
	bNfAk6gTugwOf3t8wOn8wwrXvvMINWAUCVi9Zydu/AsvxdgzuI5KsAOC
X-Gm-Gg: ASbGncv0MjBQbVb9DMbJp1hblkgQ4E/Zo8GsBZv+TR8j5P1D/vJMSzzqoOfxgHQooFe
	ISOpMiATbHP9/oqpNYNbPqteagrbVaS8Zszq4q3dvO5g/BLvgoPxkhL8+0ENJ7716ddfJgUh1B2
	mx6+qb3cnJrUjosUnwxgmDDNbnjFYyyN96vIQHgS0JNZ0vcc6lJrAYkcfSRc8Y/QxTVGYX7ByWb
	MZj7pNSxGT9N3osum8Wjh2oIb13aBywomZYaCmzyEVBl/GrxnOCb6Jiffp/npeIYcxlLVywkyN3
	/TcmL6q/fV+ATwtkWdAaj1o1imDc9nkcItIpn2070VlM3R5RkXQwS3t7BrbZEmJOY7CaCseJ/JW
	zIrRIkPMnpwslnjX5wt3ypxUm2NZdg86Z2w==
X-Google-Smtp-Source: AGHT+IGrPhMBp6GuaPq0wxjpFhNWXqcAEvg0ats210AmO2YrMj5yxfhfipC1GHiYP5KrwliKQotJCg==
X-Received: by 2002:a5d:5d86:0:b0:3d6:1610:1b6a with SMTP id ffacd0b85a97d-3e765798581mr2392936f8f.22.1757678929127;
        Fri, 12 Sep 2025 05:08:49 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e2d43sm6364880f8f.59.2025.09.12.05.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:48 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/13] tools: ynl-gen: refactor local vars
 for .attr_put() callers
In-Reply-To: <20250911200508.79341-5-ast@fiberby.net>
Date: Fri, 12 Sep 2025 12:23:37 +0100
Message-ID: <m2a52zvrra.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-5-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> Refactor the generation of local variables needed when building
> requests, by moving the logic into the Type classes, and use the
> same helper in all places where .attr_put() is called.
>
> If any attributes requests identical local_vars, then they will
> be deduplicated, attributes are assumed to only use their local
> variables transiently.
>
> This patch fixes the build errors below:
> $ make -C tools/net/ynl/generated/
> [...]
> -e      GEN wireguard-user.c
> -e      GEN wireguard-user.h
> -e      CC wireguard-user.o
> wireguard-user.c: In function =E2=80=98wireguard_get_device_dump=E2=80=99:
> wireguard-user.c:480:9: error: =E2=80=98array=E2=80=99 undeclared (first =
use in func)
>   480 |         array =3D ynl_attr_nest_start(nlh, WGDEVICE_A_PEERS);
>       |         ^~~~~
> wireguard-user.c:480:9: note: each undeclared identifier is reported
>                         only once for each function it appears in
> wireguard-user.c:481:14: error: =E2=80=98i=E2=80=99 undeclared (first use=
 in func)
>   481 |         for (i =3D 0; i < req->_count.peers; i++)
>       |              ^
> wireguard-user.c: In function =E2=80=98wireguard_set_device=E2=80=99:
> wireguard-user.c:533:9: error: =E2=80=98array=E2=80=99 undeclared (first =
use in func)
>   533 |         array =3D ynl_attr_nest_start(nlh, WGDEVICE_A_PEERS);
>       |         ^~~~~
> make: *** [Makefile:52: wireguard-user.o] Error 1
> make: Leaving directory '/usr/src/linux/tools/net/ynl/generated'
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

