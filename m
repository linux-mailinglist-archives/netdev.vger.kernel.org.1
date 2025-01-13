Return-Path: <netdev+bounces-157767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFD5A0B97E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B00F16552F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682481CAA80;
	Mon, 13 Jan 2025 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNQPUZkl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1CB1CAA6A
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778526; cv=none; b=Nx9pYsIkJuTfNGqzPIsiFVdY3BauJ9E25yT7a1CXP0FIHVkxa3aj4LWQMDxol85HpNkuNt8OEa0XLStV9pK1xePfjkDnIsHa8CImJlXcJ/5YV891bHmqAeQoqvkYnxRJqx/HX9NdcMHT7qgUREFwzHen5LZSgVYZQdfWHITR1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778526; c=relaxed/simple;
	bh=Xp+YmDOmSEzEhnHEoAFH818CsXl2jKuhJTXE73WjxS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2Oo/r+J5i45iqVCoqR7eWRYRW62OewngidXIUISYL/8DLMUJBCerF5EVTd7MHaRc8sIhv05JxIfKSiSuj5tLNXL39rZiIUt2g4N0c29e+ig361iWnbIZZ8OuUaepfBSnJhr/SF2ciygXb3dgzP8uqQ8DyIzrRGwfzyV0LqXJl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNQPUZkl; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4679b5c66d0so358091cf.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736778524; x=1737383324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO4dBte9u4r7bDixeqUcIM4zxUz16pnmJVaZ6AlUxls=;
        b=kNQPUZklRRNkwDFTBHLxr+RdmZOGisj8ffTQSaohhscLFWGvD6oXiOKN3PXxG8l0c4
         NoH9/6wDbawEQfRPtwu96O+BuQM0e88WO5C4QEfLL40iMvSuUBwroNNvlEJqAAY09yzQ
         RBM+g25ExpzUdNA4r0LpRjbBhWt43EMdLQxAvmzVFb2etejY89QEspelTS2wlU/XnGro
         ohZLXeuT4FWPpklVyf3qY9fPKd+LpOmfLqh3Di05uR7nOfZ6NorM46JewlCCHQZFHVnH
         ED4Jujf7Ewh1EtMxms3m5jaZelSLkhMVL8kTTfWnJEBvW5TsmtsKUMnlpRVs6y1L6rKU
         WCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778524; x=1737383324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qO4dBte9u4r7bDixeqUcIM4zxUz16pnmJVaZ6AlUxls=;
        b=edQ5cZINYYwV623/rIjt1GaSp7ZjjPgmlwc1XTjd4ougBjKUXqVgbpF/w08bTdCF9C
         g182PeYoiuKUjmm+k/8miYRQGcxuASyRigc+aukRL9K0CEu5iCyQlxpUNheCPU3k279N
         PjOWVPR2g6DmoKbJJ5806jivGGtN29EoNjfM09D23NAbvho/iDiY/HeU4KsJvFrtPUlr
         nYBQEZO4cTArNvSrK5k9Jt527TGMA2CTxPhtYE76icQ2YYK71zudU5EA2jaARtfTuY/S
         NrIiBRttAC3yM3utKKrJ02A1medv58IVlcN2imrgwn6jlBPHU3/fWJWEriSG5UAcZRVY
         NAig==
X-Forwarded-Encrypted: i=1; AJvYcCWrwzPIGbPFW6vl3tLWDPXyak9chGPHCwnWDGd4vluXsuDNRHpOuaN9o7tzg05+4wB5V2I6RhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKHZlwxMmRms4zKxfZaPexcvl/KJjbi9PBoYZi8LK+CiO8S8t
	jcN2NyPBEH2Tv4GMyW0UT2kNqbKPDomD50aed/nji6spwIk80aCS6NA1KOsx/nvKyY7DoTvi/HE
	dWdKzF6OilFxDr9jLk+fczIGtS9mmL8T+XUOzB2SPBn5r6y2SLjw7tgw=
X-Gm-Gg: ASbGnctzNfe+4cpSAtmFXsUATcfCxMhzBOWfrwM114ill8KZRtsOorriH8XMf0PiJt8
	HRfFiVmImnIPm8nxZs45LiaV+d1jH97vAXl3pae3TJOjmdu2PqhGSYATK4fS++3LrmcA4q34=
X-Google-Smtp-Source: AGHT+IEFlHLRJCNnCV4L/Sv/B031JHWMSrC2GUZAJAv/KuN1owqSuHOXS3RHkK7Km3rNB8pNu3wSmVjk2p0EbgQ1yCA=
X-Received: by 2002:ac8:5841:0:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-46c87f3c822mr10655291cf.26.1736778523555; Mon, 13 Jan 2025
 06:28:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113135558.3180360-1-edumazet@google.com> <20250113135558.3180360-4-edumazet@google.com>
In-Reply-To: <20250113135558.3180360-4-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 13 Jan 2025 09:28:27 -0500
X-Gm-Features: AbW1kvbBkQE0-1GY759IHN0iNjVwTQ-RoMq0uUGJB3O4qL6UtqfG3W4meGYujvo
Message-ID: <CADVnQynzjcW4gCf+=O=gn0HBV40m8jBwmeVBTqMbswSmcuON4w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/3] tcp: add LINUX_MIB_PAWS_OLD_ACK SNMP counter
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kerneljasonxing@gmail.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 8:56=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Prior patch in the series added TCP_RFC7323_PAWS_ACK drop reason.
>
> This patch adds the corresponding SNMP counter, for folks
> using nstat instead of tracing for TCP diagnostics.
>
> nstat -az | grep PAWSOldAck
>
> Suggested-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/dropreason-core.h | 1 +
>  include/uapi/linux/snmp.h     | 1 +
>  net/ipv4/proc.c               | 1 +
>  net/ipv4/tcp_input.c          | 7 ++++---
>  4 files changed, 7 insertions(+), 3 deletions(-)

Looks great to me. Thanks, Eric!

Reviewed-by: Neal Cardwell <ncardwell@google.com>

neal

