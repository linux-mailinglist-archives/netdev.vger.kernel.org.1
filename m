Return-Path: <netdev+bounces-138782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0BA9AEDEF
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 19:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7310E1F2155B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C081F80CB;
	Thu, 24 Oct 2024 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="La4GjTBU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83918991B
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790750; cv=none; b=KTbZBqmF6IwGXM50n6w+ejRVfk4ls+qIfclU6DuBvzwO+2AxEvjdhcv798cGPZALsmJ29hILHvD4E4viyBjyFHMIdh43tu4h8hXPpJhIJbMfqyavUj25ZEl5nfREnOYZbga0ih7sMZOeAcEVpwg8JT1r3+rJoOyjYeyKtmy9rcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790750; c=relaxed/simple;
	bh=tr+Qm5f12B2SPCCFaFP2Nj8I8ueUgelJy0p6OTXIe9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGghI5Fvw7EdYjoxnIPjkAB+aL+K1zzDUqVBVeXlcepJX7Zqpd8QWw2T3XGJMRbPb4IOEs2R0lW3tPyDXWn8/phwmCz1Wi6Iz7Kye4BE1YGLpaFSEllRXmrRPheyfO7HwT+VEQSEQJrRYLYo4oi2lggAltBd/TrhtQwTglUIJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=La4GjTBU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e983487a1so867933b3a.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1729790747; x=1730395547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSPd+Y4Io8/rh2KrV0oYhpz1P/mGyw3qNXCsxXIo8xk=;
        b=La4GjTBUaa74SemtvYdg3BjFyAuen802EG69neHNMsHCqXF3jHHuKDDH8Am74afzCS
         stThooKL5MtysYEgzggcBttX+DC+/q7lmC8SOnC3ePaxgi9V1S/CBWuesb6/9RgPzecR
         IturCogCLQGr0a6m+LgxPNw/6QdxrGBubj61dn+lPtDOVY8JJ/mh91tRjoJbzu5x+Vx6
         0aFqPCouzsdXOx7RW4D00qCN5yagDasuU9LHY22sg83TSuTdgXzhSrT+vHerPgRN21rs
         cR0lMZYrXlapfhg/jKJjPvC6UNt14S97+6P5S7n389G3K61C0FeX2qcSxC+b6rbDkqeu
         VaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790747; x=1730395547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSPd+Y4Io8/rh2KrV0oYhpz1P/mGyw3qNXCsxXIo8xk=;
        b=N3ycpqRq6/cgRmjRgk1Dm7lMN6fbvkW6+yI7kBhtOFzQrtvI1bRZSdK4u9YG0hycUI
         UYoNVdEwyyMiriZq5YlG81RPKliAFZ6q5Zm7Rrky1wBAlpZJGjoZeTyCf6PHOtynG7hI
         DXzSoe+X4lDdOkdMcNWA/mVbrUyyu/YpJB8YX28AFcv/JEy/Ul2bihACgJgo5rxIjef5
         RiJw2vwBj39rjUjlMP5dVy/pizs/00osb7ezh61VJvGyItvtTaO0FFICoLyvNHYDB8ju
         ZgW7XXpbKZC98hzmFI2F7HKGsw6hIqAA0HngKYwi+g4YxOaDtwv2d33sp18NPiq6cr3q
         So9A==
X-Gm-Message-State: AOJu0Yze7ept601WqUc1CnSThr/CVo5nUM7xfQ6IGdpi9cCTUXBwgYsj
	R6rtuJNaJUfSvjVxHEnlylsHOu+ATUZQJBaifMCg6aDjmCJby9kpCkQvrf2OyOoUere/9VPJNyV
	82peKBQGyy7x2y55+kvFiJQE9G9CBuiyqLSUC
X-Google-Smtp-Source: AGHT+IGew298ys0/OvLoRriNgXdYmMv/0T9VfbwE9bIOiPsMviFvE5ZuybtogPB/MnXkyiq57FiddxEZ6DbuPfUV89Y=
X-Received: by 2002:a05:6a00:390a:b0:71e:51ae:d765 with SMTP id
 d2e1a72fcca58-72030b9af5emr8932161b3a.27.1729790747307; Thu, 24 Oct 2024
 10:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 24 Oct 2024 13:25:35 -0400
Message-ID: <CAM0EoMk6EGGWAbYiumPZOxdNV93_zt2ycNQETGXGK4Y5RG60RQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 0/1] DualPI2 patch
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, stephen@networkplumber.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 21, 2024 at 6:13=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Hello,
>
> Specific changes in this version
> - Make succinct stateent in Kconfig for DualPI2
> - Put a blank line after each #define
> - Fix line length warning
>

Thanks for tracking the changes. Also please if you can attribute who
asked for which specific change. Are you able to retrieve the previous
versions changes/history and put them there? I am asking because I
sent feedback to which i received no response. Then i started looking
at this version and noticed you addressed some of the comments but not
all. It's just more work to review since you never responded to any of
the email comments i made.
Could you also please include all the stakeholders like i asked last
time? This is just common practise. For example i see zero tc
maintainers cc-ed yet you are adding code to that subsystem etc. It
would help to read the patch submission howto.

cheers,
jamal


> Please find the updated patch for DualPI2
> (IETF RFC9332 https://datatracker.ietf.org/doc/html/rfc9332).
>
> --
> Chia-Yu
>
> Koen De Schepper (1):
>   sched: Add dualpi2 qdisc
>
>  Documentation/netlink/specs/tc.yaml |  124 ++++
>  include/linux/netdevice.h           |    1 +
>  include/uapi/linux/pkt_sched.h      |   34 +
>  net/sched/Kconfig                   |   12 +
>  net/sched/Makefile                  |    1 +
>  net/sched/sch_dualpi2.c             | 1052 +++++++++++++++++++++++++++
>  6 files changed, 1224 insertions(+)
>  create mode 100644 net/sched/sch_dualpi2.c
>
> --
> 2.34.1
>

