Return-Path: <netdev+bounces-144257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944539C6667
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7AFBB2F059
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 00:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C89F5680;
	Wed, 13 Nov 2024 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIoxmILW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A21BC5C
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459420; cv=none; b=UN2oV06QDmX29x8HSD7WbwgEJ6bTSfcwWDt9Jp0fKtlqAcynqxT//nD6Cp82H7JZhhBZY9csOscznrjqufTDxnmhlt2Ri8RO4hxFrvVx9vRLmZ0FzYLKJpN8212izvF6/XjfmqO6ycNG856WPR7bw7t8z29HKpf3a9m3H2BkifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459420; c=relaxed/simple;
	bh=S/ZIIvHV4gDhxmZupsbdYnIIAA0H4KXqa3pcV4+Ru2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKL6ITdss+PQRCxbUseGiL71iBHUHeSugPvV7sdub1pFDCmsLSqSE/biqZGL64gZjaKGBRVRipz8p19VAaRXY2rzSlxv2jedcyEBIrC82Tzcg8V70hr51JqJMoqd0vVTNk3h7IJpAs86es4/H8D8nnWXVoYmIwDJ5gKFG6npoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIoxmILW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e64ed090so2e87.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 16:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731459417; x=1732064217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jx0hYhXWq4MHDr1staZ1xRj0crb2pojg8SADc+LPOAQ=;
        b=uIoxmILW8Q3PMchD6AAO50udFsTXsRCSlz6xYK4YBJoUVWpSPN0QkcDrWpll9cC5Ry
         4QmqOxUanljkXuTcf5cQjrPF/r6O3XTU8y2GveFqTDNY1EK64WSGjer97ykQm1yTIm1G
         xM4dgnhaLGa5Id0Q/lL7bDnGeAXfO8IQcfipn0fgLhvMmPHsRt3m/ojFKbVW8OA0/MMw
         aQKv89/cewdw3N8sGvD7SqfWZ25E95coZNzc0a1/s3esbQKIm4g3+JQ47qHk+1YePWhE
         LQAX24ZhhYNEhdqgXOIWJpspdOGZICGBPnq73oiDq9ncrJC1bfxyECual66ixsC8c+vt
         wa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459417; x=1732064217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jx0hYhXWq4MHDr1staZ1xRj0crb2pojg8SADc+LPOAQ=;
        b=NC72KxQ5ZP/NVwyBTuFp07XwuPyQJlcI/dS1THmrhDOcTmJU79dqk3zMbXa7JAA1ra
         GF75cD3kl6CM4DM2iut9MhoB9NL3bgObcAWugd5Kryd/D65Ud27yUiTR2QQl6bl1lz0D
         M8rFo1TIUx9tSRZMSMq3jcz235ZqGefjDshNCBpHYIE0BNLT28gFkaTWC4qXLmKrY8RJ
         TQuK+awqRJFsFIog+RKk0v/3HMkucjsGCjedIPZJuyIc83MHApA5sknC+XWCW1dep0Jd
         aCocnnNNgsi0TJtNKnP4F2sZx9bizO5nT70BZaFq8OhQsb2/3f8OOHfRc6U2/aI06/mu
         gAZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW+D4dLFqXtd6s/yTHkeJkY5o4vrKshQk3PuEC/Fxp4woRQWl9dE0RjXUcs3ghx1tUzDrMseY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh3+50jv7aDk/MyzYHSQXVNqo7DZtqJ0G286iq0+9WL4TN/Dqh
	dqCvYSs80oYbBe1JdROwPfbmrWsPHDg+j01d73uUvN2XMAzJOssNvX4A3qRCxpwKIJUv6f7UMW5
	fH3FSarx3uoVtzsU44ms/s8WlU3C9IxGLjCa4
X-Gm-Gg: ASbGncsiD6yr6bnr6w6KP2hN3TCheDtAVW2fQDQq+UkT7Qeef9bCrket0W50UdY6UDr
	GcUZunIcedOiQuh08dDuqGURKZw+mINi+BVoObAQLxCM+tJw2zz0rW6a7jwMpaW8L
X-Google-Smtp-Source: AGHT+IFyo2CCWf1+kCiFRkYJgDWrUegjzUeNU4t/8JMPYaG9xjbFRAq2D0v8rFeFfjFkrHSgn2SrxQyw3Q/oyOrrmio=
X-Received: by 2002:a05:6512:1599:b0:53d:a034:e563 with SMTP id
 2adb3069b0e04-53da0726006mr2816e87.1.1731459416103; Tue, 12 Nov 2024 16:56:56
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110081953.121682-1-yuyanghuang@google.com>
 <ZzMlvCA4e3YhYTPn@fedora> <b47b1895-76b9-42bc-af29-e54a20d71a52@lunn.ch>
In-Reply-To: <b47b1895-76b9-42bc-af29-e54a20d71a52@lunn.ch>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Wed, 13 Nov 2024 09:56:17 +0900
Message-ID: <CADXeF1HMvDnKNSNCh1ULsspC+gR+S0eTE40MRhA+OH16zJKM6A@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: add igmp join/leave notifications
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, 
	jiri@resnulli.us, stephen@networkplumber.org, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please could you say more about programming hardware offload filters?
> How is this done?

Sure,  please let me explain a little bit further on how Android
Packet Filter (APF) works here.

The Android Packet Filter (APF) has two parts:
* APF Interpreter: Runs on the Wi-Fi chipset and executes APF
programs(bytecodes) to decide whether to accept, drop, or reply to
incoming packets.
* APF program generator: Resides in the Android Framework within the
Network Stack process. It creates and updates APF programs based on
network conditions and device state, allowing for dynamic adjustments
to the filtering rules.
APF program generator is part of the Network Stack module, which can
be updated with monthly mainline releases.

Feel free to let me know if the above explanation is still unclear.

I will include a more detailed explanation in the commit message in patch v=
2.

Thanks,
Yuyang

On Wed, Nov 13, 2024 at 4:34=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > This enhancement allows user-space components to efficiently track
> > > multicast group memberships and program hardware offload filters
> > > accordingly.
>
> Sorry, i missed the original posting.
>
> Please could you say more about programming hardware offload filters?
> How is this done?
>
>         Andrew

