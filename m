Return-Path: <netdev+bounces-73974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C007985F841
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B621C22AA4
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5985184A44;
	Thu, 22 Feb 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTbk49ke"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37E8405B
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605143; cv=none; b=LKlA4NEMT7xugL/kBdAJAAMSwLKcCDLZz2eJ96q7PKWrDspj5UmSt7ZJ4f+PMiloOnX79HRIsi/XeGsPGAne8r/7j6sQoV7A4ux3fHzXKdk3PunC2pYqsyQDVd92j+9YBjyWkcjKOvUFSGw6dM7oduuqOEPRHIQOH53RmcK7HB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605143; c=relaxed/simple;
	bh=wyewSJVDGwQySmv7BqMipLUojnXCwv4DBJOnWCzRau0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRmixlfNeWgcE0NgPEp2b2CgIW5uAMPZp5xC3S6t7ka78m8/Qa8jGCLYEsQr2dSXxmiYlEH766q8Iewu7rm3i0iQmQZoRTMGhtxuKwYROfC07cSXb4Cs25gTqM47FFkAYgJzGMfS13AOaMiCgNhAj+t1cIuawux2VGo4mreQv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTbk49ke; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so9295a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 04:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708605139; x=1709209939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyewSJVDGwQySmv7BqMipLUojnXCwv4DBJOnWCzRau0=;
        b=jTbk49ke5CpaTfvoPdQ6uNCirxL9CfHEnbkPDow1U1/j5eVCZhRLraRp+V+f5Wnvvy
         nJnLrxtoACdUhvSpKTdszTOmKCGHT0I613ypZdZFHd+MEqqrxg8Q9YAaGGgXFGN6r9Vl
         Pi2oKHoacDaWxKUvWBitSY8/iVJb2zyijpexggMJO3TRd35xG82ATgAZEP3OCP5mZhgM
         9806Xfe1JG7tmmOGR3ZZeoJUerjWBVwFQK+cg/VONUtKT+iIhaBgAvkecVDQMmBjmNkV
         FL71PeCltm+y/BjpZCKmPNkTdAZmV083HeH4PON3GDTGJC4sQvNQCJdPLXa6TmFybhjM
         X9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708605139; x=1709209939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyewSJVDGwQySmv7BqMipLUojnXCwv4DBJOnWCzRau0=;
        b=C4YtXc8f8WQPqH2GPSyy013iilA/Cs4QY8nwwOER0hlVhBip1w9n6ZQquuSzUU1aXV
         h3Vnm39KAcfC30Luc9sykspCVlGQB3NYUfZ2Nbk0V4yStwBadqJ5hIIj/111MIRAHKpH
         OGHIeGEXiRCzYl3xvmvrjNzNKjlWZH9cE+THBS3KhAetgDWdhDx/cH0frbHN5GmmR/Sv
         DdTzXC4iu17SRl+3aAwFq7pfph8Efdom76XOtUxJi4eonoHSVNm6XJ7wYh478T6LnMMO
         opaTJtSfTvRn/K7ulrmnLLOk723WD7k/3NNAIRzxfU7kL38Qu7+BSFRcUIe8T66f9uTJ
         QPpw==
X-Forwarded-Encrypted: i=1; AJvYcCUBy46DeKiTvPu7gzOH3CYjeS3FQSh8nZxRXyp6TUY2chNncyVb1XU/UAl6fIqXEzcvIYhl4FxfO21gVLYlhpxEKUXQF7wQ
X-Gm-Message-State: AOJu0YyWXP2bPOuTk9R2qXKw6Z2EaKNBYT0VmAMNJPOZX7d0cxTaALwz
	zyS/1sqxHq6//EHe6HL5za9sNVSZhen0PRFUupTeFl1nw+SPUe4up9DMYrgYAzeJKKwUhMQiJG3
	QnDGV3cnCdnjO6iFskQlwC8jM4w5o/i76iZ6/
X-Google-Smtp-Source: AGHT+IHQeiMlSauiNOvzPU/wWO+lJxKZM2dRs5BOL54r+rSe2TnxyiX23MLh28Oe4jRGuMU9GiNFSyKcLryWRd1pNPg=
X-Received: by 2002:a50:8706:0:b0:563:adf3:f5f4 with SMTP id
 i6-20020a508706000000b00563adf3f5f4mr384692edb.1.1708605139119; Thu, 22 Feb
 2024 04:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222113003.67558-1-kerneljasonxing@gmail.com> <20240222113003.67558-7-kerneljasonxing@gmail.com>
In-Reply-To: <20240222113003.67558-7-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Feb 2024 13:32:08 +0100
Message-ID: <CANn89i+j55o_1B2SV56n=u=NHukmN_CoRib4VBzpUBVcKRjAMw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 06/10] tcp: introduce dropreasons in receive path
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:30=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Soon later patches can use these relatively more accurate
> reasons to recognise and find out the cause.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

