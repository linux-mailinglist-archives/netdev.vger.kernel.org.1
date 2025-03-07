Return-Path: <netdev+bounces-172851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D757A564B0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575D117537A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B014D20DD50;
	Fri,  7 Mar 2025 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5Qxf0Na"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67720D4FD
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342233; cv=none; b=fb+6+JBl5aIvyBHCzQO9PMwU18bZL1JLUJQZmE2Nz/EQiu0hbU4PPqm8WilJh/wUGjMUFB+l+bfSsvFJ9vJbvdfuXK8HZYSgtQiq3YSJ6HAoPOtuhEimBxsEHm3oTeD4eWPaIUVK+W53xtjL1HCzu3TEb6Z1ITRn7b8IPTRUkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342233; c=relaxed/simple;
	bh=FTHyswk+ziHAXqV+6SUojk3n1KfTxTDpYWi5FluEwhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6U7ZZ6O79fcvbPAOsdGTCXdX2BUt2QwOnQsZNK8nnqIN8fT+yFJUKmPCBvaEeJYyhCy+HjR1scyJF4+mKnDijNXPe+VG91GHYNSZznOJyLJ6Cx0MQmcSGej+4AvpsbGdg5gU2vDW93FVuzrYkZJi1IzW7YFR8koiTgQVGFADjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K5Qxf0Na; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47520132245so12448061cf.2
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 02:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741342231; x=1741947031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTHyswk+ziHAXqV+6SUojk3n1KfTxTDpYWi5FluEwhc=;
        b=K5Qxf0NaUyfwD5Xcdo917TUZUAaPnletWJIcjSEmJufJFp0ERGXrvB1Ahsb0ntnAHA
         /UEx7DCtqcEqPYybGXR0vuHvFqw/TqEZyz9P8XO6IXylWgpGue5PmqrrGy/XV50nweIU
         e58Wv2+EaZwuBkFzBBsKASoPB4USsxGndVlCSQZ4/8olb/KQ5qXsDyTgbO4Z8t/CBD0t
         bz1CA6SSMjnucnaasYlHmTX13dkjwP2Hkrh1mAniKcfPs5ktRawNH7veKpqZkGX5jEpz
         njmroBUKdkhXucAJnubFdWupSiFAmmeQgEJqCcRcXeG5yNdxh5/aIRzC/Q/xzkzE4R9V
         N6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741342231; x=1741947031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTHyswk+ziHAXqV+6SUojk3n1KfTxTDpYWi5FluEwhc=;
        b=N0KRoM4konCAOFGC37WDbEPzdEfvIApwaG+aI3Zffc+FZ4NgyT39K0u6IJ5bd4Pcsz
         eH2usaiX7GQLj7jQ+Gkz0NzTwoSF4L8ArHfFLJ1nZfuoZ1D/7Dm9hnMv0R8qXpY0JJp3
         HhRGCs2AMbo8ns/JU9vSDDWCfPMwVqJtQ7KW/suIoJg/kEzPWHKOjQ50pE+B/gs94JKK
         tjBriTY8KCLAjukUGyK4liStwbHDqRG8wVhz0uun4BkQEPoR3PxRG4cpFMYOhEUNfx6Y
         Eqd0Mkz8a6MPsy5WN0oo7fFIs2lprwqwIK9cRX9pd72Xt6j1u62jPl18NzPdPDZmqYWF
         H21A==
X-Gm-Message-State: AOJu0YxrAoQC6tITHl5ZPGg9fFrN4XFecvroKuNvOpamfVQHiqadFZ4U
	UvqdvZ8AhrHBFRpgvr/qTAelG9DfuK5X3IQfYx1BCl0NfKpO2+BilmNW/0d1PFhPtNKcLLZp4Et
	8EbdSq1V7PDJt4+9wWhv/ly8xMlw9Wgo4wYrx
X-Gm-Gg: ASbGnct15wizF9nmwBktKF6E4TTPCOp1HP3KThGKky2H9CWVoIaQFlxv1Ug8thi5wUx
	b1rjhaQSRfqm97QXAOFo3l2fS+8ZzUumP64ZEpBiu787V3rHS4MaJM3ez1uG0U4wpuVEjEh6jPe
	ZkJqGdmxCihF4Qn/Uw+JnCnO3YytM=
X-Google-Smtp-Source: AGHT+IEzphPDlUtXfSZuTae06SKubBjaJchxlemILfsCOfO+vKwt1GJEBcNNVw24QSW8oWb4G1f2vrx0U1qc8mEfFq0=
X-Received: by 2002:ac8:5e06:0:b0:472:1225:bda4 with SMTP id
 d75a77b69052e-47610952565mr35898291cf.1.1741342230828; Fri, 07 Mar 2025
 02:10:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com> <20250307033620.411611-4-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250307033620.411611-4-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Mar 2025 11:10:18 +0100
X-Gm-Features: AQ5f1JrIOXbk-EF7w-pw6viAIsx8QXIuCkOoTbORhy09Siqo5PALXtV68BDTepo
Message-ID: <CANn89iK2ovQh8OBf8Okkun85zsAzjXy19WgED9KTjwj+Hyw_EA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] selftests/net: expand cmsg_ip with MSG_MORE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:36=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> UDP send with MSG_MORE takes a slightly different path than the
> lockless fast path.
>
> For completeness, add coverage to this case too.
>
> Pass MSG_MORE on the initial sendmsg, then follow up with a zero byte
> write to unplug the cork.
>
> Unrelated: also add two missing endlines in usage().
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

