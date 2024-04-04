Return-Path: <netdev+bounces-84674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E02897D87
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 03:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2CE28754A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 01:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93581862F;
	Thu,  4 Apr 2024 01:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EH1qFMI1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9217C74;
	Thu,  4 Apr 2024 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712195910; cv=none; b=I+0GE/beq70TMRn89tbD8u20KVfv87L6q/0/ggwKVyK21yzrQsHHUl3ACSAeM6ryENlTc3AJg1TaWz6wUAAqW+W6YSqfr/2GI6ZjvgeVG/b7KPrvCZgWRSQdnhq3QkGmzGEgdhWSTs4tqaKIOA5RnD+rUUj0+UwQdzkkyNKr82Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712195910; c=relaxed/simple;
	bh=ymv1KcCN3gYzCfq9KbAxjhU2YrRREjNMUnRC1R1ab18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gad+ebpvJoxgWwwq2yDC+AkKrLNQhbPGLlltCq9B7tDQFD3+XcWFVXUA1B7VwTQwZSa1xGODS1IBu59+GULPDKW3bb0Gmr0ZWJ/IUHlEoU527A6/Ds5zC/BmIls17ie0hrIw59ZxnHSuY+uw1qBRoAMz8sFUmsJUbM98CCmfEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EH1qFMI1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso15041a12.3;
        Wed, 03 Apr 2024 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712195907; x=1712800707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edjm4j6Dw4ZOSSQICjoznYKS8GYUsUxh5ZnKOQjsVhI=;
        b=EH1qFMI1wQKcweTmzYbB4sciBGtm3/pqRqiCEjkcAdjIrLwFTFWwSUj4kWSV3lQYyT
         C2Quoq6pl/3e2JlLpT/clRXxTBdn1i4C4G1B/QZeih6ECuLuxR9JtakPHHTbNEpBbU6X
         i9xLD1ABx8RHGeZojAMMDMhnuQI0QLbK3dY3eCs358jPmczVlsaPRy/7N10B3sGUgsk9
         qz2kF5VyK4ypdfhGLwGaZPXPoqyDjBTSyyCNwcd1ejXZuySc4UOYzmeSr2HvJ1Ku/QV+
         PUdjtyN3hkz2yCC3WToPWUQOtHGiT348hvRZ2Fl6t/N+Na8dd01k7grk8G6r4Up0VoE6
         OQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712195907; x=1712800707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Edjm4j6Dw4ZOSSQICjoznYKS8GYUsUxh5ZnKOQjsVhI=;
        b=DrCGARDaGVY3BlpomqcKdYn4e8PCsXYwavwjCfDwttEYjI4Xj8fDnYO7P+c1mimPsI
         9Fmcaq6QdTOVhJN5Ji+vV9cc3l66GfGWgIkQTSZChVkW8WclZaOaPwEAaTJ3TCNCvzA1
         ZNXdaSipY9YCOaU0vspE4Qe8zIPnn7CYE2AMr7mSt1+sqkmdBjJsiksDS7p1O6CXziT6
         y/k2cP1Gxu/979qMQYYfrDbEmV0E9gZ3LiZtV/BfHHhGlICxIG2QpIScuOPL92NsX8S/
         4tjDXm58wZio9FtIcdsHafkLXUKFFkAPq4419K4Rz1mj1RcnUgKkrUioMdNKOA0/Hvxg
         KN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6vimNVVv0ptszLFawp1/W7mXnzGj3emrTbVnKhoMIHxZS7HiWnhtaPZjWYLcfcf8p8kvpcecIFZlPYnGKHm6XhY0XRzMvHZozwDMPsZNoiua4YIaGtnM3GWp27niKX6GBV2cSIbwt2YUo
X-Gm-Message-State: AOJu0YxtEKfXTRkrzlgm56fBU2n4rj+RhBvu2njPGWlXH763Pm0CoCxi
	OEuxXxZc43n11Vmgreeg4nyFk1QjGNsahiPKfGNPy4/RBWuii4ZkkuW8b1yysm4dLnenIrLSCTa
	eIChHAoYpJeriROPu0dlqcTKyWsQ=
X-Google-Smtp-Source: AGHT+IEK5qJlWZay2FL+Z0BWOTGdPJfiELN0iLN53ebkDnls5+3I2K0ffBrE8bSeLef9zcTtpKkqgoH9v2+TUwuLqdM=
X-Received: by 2002:a17:906:f58d:b0:a51:8b96:2931 with SMTP id
 cm13-20020a170906f58d00b00a518b962931mr41427ejd.54.1712195907242; Wed, 03 Apr
 2024 18:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403073144.35036-1-kerneljasonxing@gmail.com> <20240403185033.47ebc6a9@kernel.org>
In-Reply-To: <20240403185033.47ebc6a9@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Apr 2024 09:57:50 +0800
Message-ID: <CAL+tcoDd=ueHVqBpe8r9R4R1vW6k0RiSfCn=vzHAaLNycb4xBA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] Implement reset reason mechanism to detect
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	rostedt@goodmis.org, pabeni@redhat.com, davem@davemloft.net, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 9:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  3 Apr 2024 15:31:38 +0800 Jason Xing wrote:
> > It's based on top of https://patchwork.kernel.org/project/netdevbpf/lis=
t/?series=3D840182
>
> Please post as RFC if there's a dependency.
> We don't maintain patch queues for people.

Got it. Thanks.

I'll wait for that patch series to get merged. I believe it will not
take too long:)

> --
> pw-bot: cr

