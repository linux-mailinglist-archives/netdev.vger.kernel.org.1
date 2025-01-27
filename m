Return-Path: <netdev+bounces-161071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE91A1D2A3
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D64166CA0
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B4D1FDE3D;
	Mon, 27 Jan 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZM8P/DyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2B1FCCE6
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968154; cv=none; b=Wjeh0sDYSrmYIaNGI7U3fBFd8bPjSRsQBhqca4B2TzdpiRyPT+qa3lIq9JX6RtmEjnnAo8mZiBZXniBW47p+J6BA0PGRxPe3IOHh1jg/e7i7qxX4B4+X2ELLUkvNTJuowXWr3I6t+bIGYe+Aa2z2cr4WEswf/A09ASNAvVdE8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968154; c=relaxed/simple;
	bh=CoLrIETEJM4HEmbnTNrbssSE54rz8NaYURxUGzWYAg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPaBniPx4G+CSBkKs4Hxaz+KJnnv1wR6t9N9JitHA+xNpmuTj028a0Y9mjvH/Kxm4QOjI/zqT/oQgfWzsW8GPZ1urNpP2KoX+GszfcdPbAHSxJDQ0AHW4+sS3PXwuJiBfPjKS0ysa+qlLm5QxWvYefDsRA1zz1TclAjifV+34i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZM8P/DyR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2357026f8f.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 00:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737968151; x=1738572951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoLrIETEJM4HEmbnTNrbssSE54rz8NaYURxUGzWYAg8=;
        b=ZM8P/DyR1rDSbDNPf5ZtN2NiuhDSJFGZMcL9ESrUlrZdSHHhrV4gEERC+HCUMyL3bD
         S8+lYOk1JPy/7fuv48zOArPHUohz6k3IQ96QuTu2SroDJkxALNzERP5z+OaHF8pt7Htv
         8UlNMBGkjkwXsq3Bz/yviicAvzawdOCO/6YYMLa5V5VwKD00LfIG7WX7wrggI3p0He/s
         shTqV0Vr68HJ5rURpZ0EmSvsnLgP0fhtiTBqy255IdK95FPuGNOX9l4VSlrbTo1lvTK4
         I+B7+12aqNEa0lPdd0+dbbrXUlrrpxHo32/DHD9LVIbSmJ12DUVeUBLhR1C8BBG1S+3W
         XRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737968151; x=1738572951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoLrIETEJM4HEmbnTNrbssSE54rz8NaYURxUGzWYAg8=;
        b=sHZjOcv87BXyWN+7dVvgFZkzhk06BAZ5Pm66zaX5ndyqwOTK2MjOxEWREx9X/zux3w
         I6Jg8hvU/AWwof4PJcph3eLKdAYVgl8f8CHyKzvDDZVNREPzUmZyz+qbmCiQun4qDJIX
         zQQ8+K4MJEHvFHxcssQR11TMkpOssMTHrPwbB1ZxS26xgw1VAFXvNvyE5YDXq93riZHk
         W4HBVTfsfVTmKFY4SPW49kCPKvwb8a1x3DWQSw5j/6tnrSRe4Uhh0t/NHHwCT5gYBvof
         AMlrS6xwydq6FW6OgiRjTJgf/3XDTdfyZNZtaGz4tc3D2TC3RQS6ZNILGXdS6UIbdu7p
         YLlw==
X-Forwarded-Encrypted: i=1; AJvYcCU/onMvbdPkqkg+3ZOGWiNI6G7k7sukljohyLXHfmE71DmvOcsioSSVCyAX4+2+gWLSdvWCfp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOcubj33kUHYQKx9Da+Z5FUJon9fdaaXPOrvoXnmZ6xmjg6VOa
	ru9/tgtfo/1c4absBZjSeWJL60AMi4JTLcsVBtqyG3UOODpkFF8c3ALkP2Tw/u012tFQEMm0jgn
	aC0SFIpCRFmVU/rPiuJizf4Cugu/7ZNIMl8lo
X-Gm-Gg: ASbGncvwKUUmy3rciu+DUNQS2N3cZkMuHZHKW6Kgxcei5dnsSV3FZAXAboUXcRKufsn
	XoRao6MtcqfVoSvcXl58/qHTpLLISV1CBUGmehT+h9HxZ2A9nUPj2OC9yCuiRXGikVnCsaNog5X
	mlKJBM7XupxZ3W1Vjx
X-Google-Smtp-Source: AGHT+IGtHTy0iCGSRrN9Kj5dQNGmPzGkGJu799roqkCaCiLalR8bwKrGBngZwiBtIme84jxsk2IZwE6mTYRc2VY1HO8=
X-Received: by 2002:a5d:47ac:0:b0:38b:e919:4053 with SMTP id
 ffacd0b85a97d-38bf57a993dmr38891562f8f.44.1737968150640; Mon, 27 Jan 2025
 00:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125101854.112261-1-fujita.tomonori@gmail.com> <20250125101854.112261-6-fujita.tomonori@gmail.com>
In-Reply-To: <20250125101854.112261-6-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Jan 2025 09:55:38 +0100
X-Gm-Features: AWEUYZmfsfElH64ieGr_DJ-htzAUPy4pncAoMpu-D8v1qyQyfGzT67r1wWNS1_A
Message-ID: <CAH5fLghSx0UfOc3wycR5CDeKwLGupkBGy2Edf912a=362VQggA@mail.gmail.com>
Subject: Re: [PATCH v9 5/8] rust: time: Add wrapper for fsleep() function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 11:20=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add a wrapper for fsleep(), flexible sleep functions in
> include/linux/delay.h which typically deals with hardware delays.
>
> The kernel supports several sleep functions to handle various lengths
> of delay. This adds fsleep(), automatically chooses the best sleep
> method based on a duration.
>
> sleep functions including fsleep() belongs to TIMERS, not
> TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
> abstraction for TIMEKEEPING. To make Rust abstractions match the C
> side, add rust/kernel/time/delay.rs for this wrapper.
>
> fsleep() can only be used in a nonatomic context. This requirement is
> not checked by these abstractions, but it is intended that klint [1]
> or a similar tool will be used to check it in the future.
>
> Link: https://rust-for-linux.com/klint [1]
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

