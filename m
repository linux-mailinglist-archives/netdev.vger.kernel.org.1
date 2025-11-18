Return-Path: <netdev+bounces-239621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FE4C6A5E0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4570B4EF6AC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32426364EA1;
	Tue, 18 Nov 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wf8vuO1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA08273805
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480326; cv=none; b=ZlmySGSnc+CgrEZFcnqfqeVosMTrXzdtdyanElP9uTvXkoaNNeflky7jZGMIJ4q78CkJ9PVBdtX1mISjRtLYQtY4UatFo2GiJ99uy+Mf1eo17DNoMGMo7cj5zvdBPvo/42yF+9E8byPugeNfNX87bvmKU+fv8YEsm5rtPrgfPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480326; c=relaxed/simple;
	bh=Ct9nY6wb02gQoCCbqnDpsffjEfxR0hNuU2Zfs4Rx2fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsPNSTxmB/8mcugMXuIgAzxkfMI3VREymTogjM1cewgQxXGDoWK2//gmOcsAvYrU+V1VhkUc2cuoAVfNqFTS4TSpwz3VMrZZONJOTY4A6Q4XLva0/fd8lz0PJqVimIxeUD8N0A3v9KSaYfL+TIAivdMnZ8lQUYKfPU/l+pqVzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wf8vuO1W; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8824ce9812cso60977966d6.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 07:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763480323; x=1764085123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct9nY6wb02gQoCCbqnDpsffjEfxR0hNuU2Zfs4Rx2fk=;
        b=wf8vuO1WfQFctmXaVBD5yfSEOlROpszvdyHeX5KdIA5vvsG/Kc11vLa37KxbU7o6og
         vdoX+O/9IDgoAw66iq+G/tJ6kxGaIGHwwii8efmd6x6+CKrP+jAKS0gNawt1GqbwCrGD
         hEcoccFAw5HZCRGXR5pAji3wdJRpUqLraBBVHKRwvA3z/ICjsWLk+o2iLzBHDL+Ha8dW
         H51M0eRIW3Yl8ci9VbrdYo5XXQ9yZ/Ea4Bf9CnoiaRn4R/nsxfDxAGbma9edxFcbHFUR
         ET0o3GQqcgA+rFxPIdn2twU0D6JlR7wUQRXBB0tYOSMbmzARWtBoQXHKYH0afOgMAW/6
         yg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480323; x=1764085123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ct9nY6wb02gQoCCbqnDpsffjEfxR0hNuU2Zfs4Rx2fk=;
        b=PeSY8TntGiA8WVtQaAcYuxODozU3N2mooJ91CxRldhiHyvfqaxYJ5JX6Q50VKjFHgc
         GUgnKy/ur8nI7uZxNIVKq8PLBpGD7F85/y8sXek/+HI1bA60xpY4LfwrxVDJHRTYkXqm
         RTBABCuRyfJ+ZFcmtM6uAT6awSy8uLVLaaAQdUlmFZA8KKGtKmYhIiAx6pKefChH9Q1c
         1Iu5kNL/XXbXbuztJtxRpSy5sym+joK6YjW9gJVDZRHWZHMcQxU9OKAHjewbsLLwUKsW
         +aTpMy8HMXOJhP4dvD/1mMxG8LNCTERT/xhV1w2c5Tvf492rPUnfFyX9Iaeho6eBMSxE
         IJTw==
X-Forwarded-Encrypted: i=1; AJvYcCWHKz4bynQXmLjPL38JkMn47jlnp1EAPAApKB97RNDYgSDrgFumWmG9AWpgk9AzfRY3E3NkW7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmNNsBlCqcr/njdD8hip+Bc0eE4t2+iMO5t7V9J9XQdxuHo66+
	vd5CTHbJPkb7t1YFlxAIopS6r4Y5rP0IIYewC92gExuPG/+Hhs1LPQ7sxH11rlAX9goL8T1Ak6M
	HXR2jwWDc4+aAGrvDTHer+5BoDy3lS1lfECeDyt9B
X-Gm-Gg: ASbGnct3areup49A26GAUqk4A8BjwbVwhfsOJKIhi+QaBEh30DYODh3sehT+HVGNs4/
	zTNviwBruFNNkrTyGRDfrlVssucjf4LGqwWe2/3dt3LCikzSw3a/nzXAiicLiuaMUFPK+Jiapia
	pp3GabqaNHofUp2R2E3dV60KtlX2WzBdOVq1iGQSwBJ71sSxtUbNIo12hBHjYqK/xbARXQ6O5I4
	87pvFq9Abempdv40f7v3jQR4diERUYqptP1EIblodOQ0WPiNUoZnHZgKX68FnS/VwyRy276Y+uL
	zuvw7w==
X-Google-Smtp-Source: AGHT+IE98Utch1JfYjlRuy6X5EDiWLbiBTimPD+pFRN1VdpYEOI8TgcD9KMbKs87or29LTK0f5GgiM0vdSOdCYDK9dY=
X-Received: by 2002:a05:6214:230f:b0:882:4c0f:9607 with SMTP id
 6a1803df08f44-882925ff803mr225278216d6.21.1763480322847; Tue, 18 Nov 2025
 07:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109161215.2574081-1-edumazet@google.com> <176291340626.3636068.18318642966807737508.git-patchwork-notify@kernel.org>
 <CAM0EoMkSBrbCxdai6Hn=aaeReqRpAcrZ4mA7J+t6dSEe8aM_dQ@mail.gmail.com>
 <CAM0EoMkw11Usx6N2JJDqCoFdBUhLcQ0FYQqMzaSKpnWo1u19Vg@mail.gmail.com>
 <CANn89iJ95S3ia=G7uJb-jGnnaJiQcMVHGEpnKMWc=QZh5tUS=w@mail.gmail.com>
 <CAM0EoMmPV8U3oNyf3D2F_RGzJgZQiMRBPq1ytokSLo6PcwFJpA@mail.gmail.com>
 <CANn89iJdK4e-5PCC3fzrC0=7NJm8yXZYcrMckS9oE1sZNmzPPw@mail.gmail.com>
 <CAM0EoMkw6mKtk-=bRQtjWsTphJHNJ0j4Dk1beYS181c5SHZv4Q@mail.gmail.com>
 <CAM0EoMm37h3Puh=vFxWqh1jFR3ByctOXiK86d=MjUMiQLB-z0Q@mail.gmail.com>
 <CANn89iKv7QcSqUjSVDSuZgn+tobBdaH8tszirY8nYm2C0Mk4UQ@mail.gmail.com>
 <CAM0EoMkD1QTJjrtZH3w4vG0Q_MFVA2Daqs5nbuT6GAbT-2XUhQ@mail.gmail.com>
 <CANn89iKD725z-AAWjUxB4F5U1nM_3fB37mLx8nNojCHEHb9B6g@mail.gmail.com>
 <CAM0EoMk6CWor=djYMCj4hV+cAA52TFb7yh7RNLMHTiQjEjwEOw@mail.gmail.com> <CAM0EoM=Z=eAMhSL44FT6jf1WMiX=nVuTyuNka8NMm+HRFPuhEg@mail.gmail.com>
In-Reply-To: <CAM0EoM=Z=eAMhSL44FT6jf1WMiX=nVuTyuNka8NMm+HRFPuhEg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Nov 2025 07:38:31 -0800
X-Gm-Features: AWmQ_bmAHY2SdTCEqtVtwap7ZprnSw-sR336S4cssDyert1XRJa5WTJXOjdADEY
Message-ID: <CANn89iJ2eEtdYoyM=i57oK+LEQpUapnD+okGroh9PzTW7uANYg@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 7:33=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>

> And the summary is: There's a very tiny regression - but it is not
> really noticeable. The test was in the 10Mpps+ and although the
> difference is consistent/repeatable it falls within margin of error of
> 1-2Kpps.
> So, it should be fine..
> Still interested in the questions i asked though ;->

If you do not care about latency spikes and want to squeeze every
possible bit from your NIC,
you can still increase /proc/sys/net/core/dev_weight as you like.

