Return-Path: <netdev+bounces-161408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 755C3A210A3
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 19:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F343A8F87
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994A1DE883;
	Tue, 28 Jan 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTFb/tRf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6119DF62
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088201; cv=none; b=PPNFY6Noi59xcwJ+4kt/li2yAhwzvVJxnKNDiEmd6B/qI+WS/8rH+vhYFdJZhLFXB4JeBOkrJdjv6GwmUK1z0l8A3Qe/sqULWfv7I52nYkmamKuPBrS5/vxK6IsB56Mn8N1qUyhueecpwC7WezTjuhV/ZGj8/UfTmvTq2WtLrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088201; c=relaxed/simple;
	bh=/gdYxyTaY8qCOH1708oQ7YymbUCsHsfxi1qZdyn1g4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIWgzghWmMutbgR/jd6zomKHsHTCNik5lp16VfuYjEWvkwKdsHrnI9U1KyNtZhh5qmsUtMxfMG7TiYgm5BTNSk+rhQ63v8aAo8Dpxy6SrTrnFSFtWsfJ9S4jTBs1pUH9UfV6nL+fuq6TgFkLu33OFRCwrOWL8T2jR6wVnUTujBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTFb/tRf; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5da135d3162so9655357a12.3
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 10:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738088198; x=1738692998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gdYxyTaY8qCOH1708oQ7YymbUCsHsfxi1qZdyn1g4A=;
        b=dTFb/tRfmfgcuSznGNhpYEB9UwB8riJ2m+y3rg6J3Fx+Ojd0uYstg98G8asIzoY3oF
         p9cqnhRK7sJOUtmywPOoSiYqhUUhhegP+RbR6AkE+/76ihTGtD9/zEKC10vfn9WBU7vE
         fFFFTl9K2fuiUctVRdhsyp3QO+Zne1qKNu35IMQNtgoLWj5gidX/xKGg1P50qA6JNiyL
         HID3emiri5/+jr8bWp9qQEYmRvHX+ySL7x5rwn3IOFf1r5QOhqeakCgk+n1zE5Ww29lz
         kQhVIYGIV3ngF9YJNvXG8mIMAH/AZk7cdyFwn2ctu2kEPWezuWZqJMmpAdq6bbnXodzM
         hNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738088198; x=1738692998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gdYxyTaY8qCOH1708oQ7YymbUCsHsfxi1qZdyn1g4A=;
        b=H+9MkebS6POurPD2/rhND0O1OcjZfZm0gN2y2CaBeYMwrtsH8FRzB1OplvwMMP0wZz
         nbP/gchiRWHai25/t7YVY3QQEITyBBc4y30NBOtU+eMCae6QgdxKhbDBF4mk2jyYKZkH
         U+ecoC5EcYmZsl3mb1DY8z/maGIhnyaaklDyCtcVKsWpJ6f27qQ8Bkm7GkppRx95ymZZ
         s2OBfvEPBMJM7I0bG8HRDd9GwEZHvybdQZswuTvZgu+WlI6ZyXSK76W/87W2g4RylYi9
         s3uZ8/NQMwvAWs9evIx9ikNCqlUQkHTsWtJSYeozqarih8ECarbSMyk4sUlHJffU2J81
         IQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/PrQX5sM48zYHAPerto8LXRoIGrmJQDvrc3iB1dqX2zS3WlsyxKx4MZQQ94Wlvom7MnXfdiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnsEyO4y/d9XefeBBCSn284+W+UHDEEcZ7sXBUFHKj26jJnxxp
	eU0KnLHJOb50jImpljJnTkL2bnS9yBSjfn05GD0Y4jZyf9V5H6M/T6BQgkMJXdIaSI0hyKthpzt
	oVlpu8PXthxj6qif/SlksKraSFnQ/7haQoZ+J
X-Gm-Gg: ASbGncs6jD0oIWgcIfaNuLSK0ND2D8HvGFLTYL1QuePTsuIYXDxM990H0jr5K2sgFLs
	jZlTtYAWcYnxYNaRqAQAP/K9nhdtmeYJ9VVgjAn57wM1C5ACkkctHo6YeMUeAsj8bEIiLMzUJ
X-Google-Smtp-Source: AGHT+IHPyj7nen7zqUYkCfQpUEFeli0xsn27CRLP/mWc7vAijDMAc5LwSGwKtfQBm9tcgaOuwxfnFvZ08xc0EKvhrF8=
X-Received: by 2002:a05:6402:218a:b0:5dc:51bd:4419 with SMTP id
 4fb4d7f45d1cf-5dc51bd44bfmr3676934a12.16.1738088198089; Tue, 28 Jan 2025
 10:16:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c1ae9e062164e101@google.com> <6789d55f.050a0220.20d369.004e.GAE@google.com>
 <CANn89iJiQeF=7g0wFVOZ=TMUnL-7U0xvw4ZQL5H5f4+ChBp__w@mail.gmail.com> <CANp29Y6MrxrKSAWx_Hqk1_mWBSWwKy39-Z_BDK09_FW3VJfF2Q@mail.gmail.com>
In-Reply-To: <CANp29Y6MrxrKSAWx_Hqk1_mWBSWwKy39-Z_BDK09_FW3VJfF2Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Jan 2025 19:16:27 +0100
X-Gm-Features: AWEUYZlupF_TGX63hSG7PsmRz41KCY_dVXk6ZEh7qUAyGy2noybsM7vvFFQMA5w
Message-ID: <CANn89iLFSb=aX1VcwfC1yPGDWRHNKVhnsdg4_rntox6ErgT2fw@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_remove_interfaces
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com>, 
	davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 7:13=E2=80=AFPM Aleksandr Nogikh <nogikh@google.com=
> wrote:
>
> Hi Eric,
>
>
> Could you please share what's the current situation with the fix?
> The bug unfortunately keeps on stalling the fuzzing on syzbot by
> causing 70+% of all daily crashes.

I think I am going to send a revert for the net tree, and revisit this
stuff for the next cycle.

