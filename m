Return-Path: <netdev+bounces-105156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA690FE61
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818F31C22593
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56849172BAB;
	Thu, 20 Jun 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B04LW5PG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088B17109F
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871095; cv=none; b=h1w9MshMksZsw/if7h1o756XLNQBBFq+z7N43JDqiXh1X/fVERsUDJv3gVNbcA2Pv0tq36xiAyJTWg71nkZ97Pvu0irLPhQk7v3bE/2fejJvkBSRZkHADp51/kjM94nFW/9NKcyauRPc77l4cfg59/dSGXJB525r0bR87lqtdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871095; c=relaxed/simple;
	bh=nkQ7gtmDXqC+tb5FPDsHBsceHRMcNng98BGyS80PcMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eaPR4dDFS+FU1NruFo4uF+FjC1hABGZoyFtP5w/8e/3cMDk/Qwu6K9qUPRglXNeLNVOpG/sA18JtP8bDqMDkd0gHvv/uLmI4cJ4aKJSx2yP4yrqGGHqNvg8m1DlmN5r03SO2kQTYhSAV+DV9WaPoQgHt6JpLkTwjZuvSSaOfqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B04LW5PG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-422f7c7af49so135225e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718871092; x=1719475892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icwhTlmqewMfriTKSk9UemtNjHdNfz3zVniYSN/LKQs=;
        b=B04LW5PG1vYGy9SJ3+3ayU1qrPRLaDzuXLD6VlDJC1ZRyqN8GJT1v0tm3Xia7ymzuB
         58LkMzfr+gVddqfXAhbO6VIg5tIK37SSjtpwHjhFgUJhE+d/n6JbmlHYuyICGwmuuLor
         F0spW6R+ux62L9yA6+ky5yuYTkV6yzoHzOieoF+gzrJeLZL5q4guuEShd5dFLTEUr9CV
         CZ6wjHEBAIT8cvhjtxLGIA0DKZmsH0MxZRXRJp/wY06Xzf8dEdPxlG/6iw8jyUJNrIuN
         2XRr+nRJga/F4IpW6EWNWoab5zoVm8Bg6za2xOnlk//2nmcTzv/RipYjHt0/U9gqKkYx
         mb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871092; x=1719475892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icwhTlmqewMfriTKSk9UemtNjHdNfz3zVniYSN/LKQs=;
        b=kDYJ8ZuswKzr0tTVdS1JdW8P79Fh25b9F+eLQY+ABXdSfOmU/SQATJOUMHXYqj73kE
         6N8Nv2uD4xvIU7D3iny/mODtxhANqBfgcht2SRkxuiN7bv5ZcYIs8FtC+T5q10lHLWgU
         zZM7qepKXwjIrKy5HBuaSze0KtGXzvm+1YJ8wpALGIY/YFRcE7VgjXWamNQlzk+anTi/
         BlySiGL8qDCaxyu4aRnT6WixS8YQvrPoFLoYEHNkxRsdePmp1y9GWSVBegWyTqNlzhMP
         SxvwSBRzbrqU4C+D2lHNboKJd9AVCEkCSWIMnM9ZPPYe6NgF9sQSoqbH6p3nWrETPRiM
         XDPw==
X-Forwarded-Encrypted: i=1; AJvYcCWBGJ4mApM9H9qAXOJvCLC5VJ2TWQbkbcQOgSpD45ExtB/Xpit6rIhokTezZovKy/Y1hiA5M1z0sGwPuacOq6wQTdQRwYFz
X-Gm-Message-State: AOJu0Yz62NU0AR5zwRK+MsYSi1onBEn9kjS8+joAiTM6Z0IhtAfQcjy3
	EkNUpLlnfoIaE70QCSRTNDlgH22VhIep2br5bJ/K7SGYg4jiBuhqGjO7Y2zOeL/CklGjNR54rmR
	5ZGKpV3Ua4ET5xYgQFVU1xeFeR79CsDt8Z4cd
X-Google-Smtp-Source: AGHT+IGZ0CZ4SxmeACPkWHCN+VwcMJt6V+5VQ4ov5E7/TmnG7pnoVfGftx12IHholKiEs22h4tmuQzch5JO7xwUQ0MM=
X-Received: by 2002:a05:600c:6990:b0:41a:444b:e1d9 with SMTP id
 5b1f17b1804b1-424758fd363mr3162855e9.4.1718871091558; Thu, 20 Jun 2024
 01:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618215313.29631-1-michael.chan@broadcom.com>
 <20240618215313.29631-3-michael.chan@broadcom.com> <20240619171301.6fefef59@kernel.org>
In-Reply-To: <20240619171301.6fefef59@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jun 2024 10:11:17 +0200
Message-ID: <CANn89iJNF76m675MVz0f1eOjkGwGohj7jPBds6X061wz3dkO4w@mail.gmail.com>
Subject: Re: [PATCH net 2/3] bnxt_en: Set TSO max segs on devices with limits
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, 
	Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 18 Jun 2024 14:53:12 -0700 Michael Chan wrote:
> > Firmware will now advertise a non-zero TSO max segments if the
> > device has a limit.  0 means no limit.  The latest 5760X chip
> > (early revs) has a limit of 2047 that cannot be exceeded.  If
> > exceeded, the chip will send out just a small number of segments.
>
> If we're only going to see 0 or 2047 pulling in the FW interface update
> and depending on newer FW version isn't a great way to fix this, IMHO.
>
> TCP has min MSS of 500+ bytes, so 2k segments gives us 1MB LSO at min
> legitimate segment size, right? So this is really just a protection
> against bugs in the TCP stack, letting MSS slide below 100.
>

TCP default MSS is 536 (if no MSS attribute  is present in SYN or
SYNACK packets)

But the minimal payload size per segment is 8

#define TCP_MIN_SND_MSS                48
#define TCP_MIN_GSO_SIZE       (TCP_MIN_SND_MSS - MAX_TCP_OPTION_SPACE)


> For a fix I'd just hardcode this to 2047 or even just 1k, and pull in
> the new FW interface to make it configurable in net-next.
> --
> pw-bot: cr

