Return-Path: <netdev+bounces-251340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894DD3BD3B
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 02:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41B6430BE114
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 01:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239727E05F;
	Tue, 20 Jan 2026 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inzCxRFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82D265620
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873750; cv=pass; b=gK9mDDAnCcPIvaZiVd287GwXS9j8nhoqIL8j0TgC4BXB+5k/0cvgVeCCoeQXC5HgvMCjG3I813YmdBfdY5eegRRVquTNU2j4wSeM3pZtY8WAJOkFpFwLIX+nTSL+W5N9DNHFF7uE1XFJRDQS5o+5uzGCpNq1bw7W/CzY78TJ85I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873750; c=relaxed/simple;
	bh=s2zV66xoEIievi3uFaOFms2VIMaL9Lf0J5Lw95n7Sek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6N96ZVWzWjIbajfMIjeJrdpW/rIHidTjDJm26rSUEuV7coqOdl/Qb37PIUxwPEXn3q5P0li+GPRUMr5ETvJ5MSWuL+50nSQ9RlTXT8Emrt/PWdJDqwgNVt6mLqTXk2hIz7vxjvApJ1qpJ+ukBKB2qbqmYOS2uSN8mcAL3t3V8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inzCxRFb; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38305f05717so43288471fa.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 17:49:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768873739; cv=none;
        d=google.com; s=arc-20240605;
        b=hcwtLFBicznmmogyTZf5sGX+5ymrMZdnxipavknuurLo9gdvA5yz24F5nHZDUSY3r0
         xeC08KtPwi4Hdce6gdu7I3HvsCMToa/q3qrGniv5xegCtgYHwarGezys3cXDpEjmAlac
         38KAdPgYMGUp6SngF/0tiM8FPXzwi0w94Z3UdYUM0w9b/GHNpQJ9WqxrKM1p4of1Bw7I
         bvsUrQkqN21UgOP72zbTy5X+FiQVdwevkhAEKmdizsNxu0NIES/bdFz9JDLwHWXZAqaS
         xr5/DHzXQvhfS0N67e1Ms3YHHOS0gD8poExiusIl9wRv31uGehjl/xvDmxNQHk0Bddn9
         KZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s2zV66xoEIievi3uFaOFms2VIMaL9Lf0J5Lw95n7Sek=;
        fh=kNLzFUunWJrgYi+hWTMqqMrw5N4vXsMXAAfxCxIRvuM=;
        b=QavOciWzoIQKbnY9spAGetN4cV2qfAvTLBIZ+0VFxecwV8CIJ/zg5gYDxLtoQQRWyF
         yyoe0dKBbserArzO5ONxHf5kDL5ieWwV2OIgKZzVPaiLqxXLaV0n3FebRAlgBSAkEWFb
         Y61WeSEtL9HTSKG7WUu0hCwnnIn3bqstATalp6VajsLa1P6oQ8ICEPWqhdsDOTeAFPAM
         DpD7RugQV1HYBp7UvqIC5C6FH8h3A8ZIxiK0oglvns2LVfhMy6aeh84UwejOx+Ulupfk
         ktl5zGAFGj7NVAvTcvSzA0TERho4IJfW8mx47pMQ353rlPzU/yTG9hPtUZ59C4MnyuXK
         cxVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873739; x=1769478539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2zV66xoEIievi3uFaOFms2VIMaL9Lf0J5Lw95n7Sek=;
        b=inzCxRFbxs1UfberwVhRNBznzUedIO4PIzKISYK6mWsj2oUcNPaOYrj3f9kq8lwvQL
         IpJVjnmPE2eiATfwlNTiWZCzuBN4vdPPqdsygWJdlVykMhEgGaw7+JevGjynpW28Pztu
         g/9622fWYUBgNz4z3nQmR1Zy/00hBAiKKM0kJgrAkUIDCj7KUkIc86LRTlyS537EhKnd
         AXLF+xlAJAVCjXlWQTVGGPMNFzHBJF8gbxsS1R0dGEY9LzhUrk0wjP51Z7p7m9lqmHRz
         ZWUyWUhSyWmX4UiW+m41rw5wKJ4S/2Cltx4iaDGYpu3MxVfJW2ZMSJ8GmuK3Lhtm5V+M
         sp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873739; x=1769478539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2zV66xoEIievi3uFaOFms2VIMaL9Lf0J5Lw95n7Sek=;
        b=mRF35tNdyW7DFJ5viivNYlPN6MK813dN5uV29NKEGG2GWq5B13hlGa4cGkaF/eVUSH
         JLLos5RMv3uHiJLgW/Fji7yM+KLWOfeVJchH2fnFFNCdvZaAbt1l2mGmgm8uSCuAm4V/
         UZTyuZk2M6jkRhCKUGMP31wuuUYQ2ogsvn3Vz3CfCOZwzsfrKZJnIiqDq0HfgkTYXxuP
         hf3lUgti678bUo9uuAT81daS+2Xn0c6F31G2aTl/8iovApjNqqibfySrw7LQ4TPvxB8M
         6c7wNTd9AUmnS1lzlbvbDfaJnbAn3xFFaEEYsq1E+FLvqO70wS6UjutkNH2evckj+Hmt
         HMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVECf56EKnNKLpvoCdIBhVMZBk3jtSdTzYcZfV0kqBKSyUpBb2997SZglqiWsnu/ly1IgpqkaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gNc5S47eMEwsLGa0n9zIoavosJmWGF4f/lJcbePTjWZy3775
	/dPZR65YGJ58b/MXAc+Clo+kvtsrrA0reU4kJdl6LHmgKtswlTAIcpXcNhdpaHmcqaXjUWMUhTB
	vph7DWBj/xflfgX1zYQ6krWFXxRQxOJc=
X-Gm-Gg: AZuq6aIOHj6bxsaaIwAp1F0wLBJnlTHLZNXqdf4cDagAhjjTTfY/YF/AAQuMXKlCEDl
	+V/4P+d8wgJv3O0Yx+xoHdhfzqimscuSGAr5gi/NI1ACWZwqFeMXQItF3OvQPHTpgm33pd3CjYX
	vmyrgjCq/JxiUCv1Gk18CYkkbM7T9UAoz7U5LWhfZdQVNFP/YIOOwEreXuuWKbrR/vKJkRk8t0D
	k+Dpvsl3fKb1b0Mig4gKl32hRT0aYiLS2K5fw4bQD5mdFNIsE5D4xDne9wOnZcqXKVI4Lx7
X-Received: by 2002:a05:651c:154a:b0:37a:5990:2ba8 with SMTP id
 38308e7fff4ca-383842694b2mr51246771fa.23.1768873738981; Mon, 19 Jan 2026
 17:48:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119224140.1362729-1-kuba@kernel.org>
In-Reply-To: <20260119224140.1362729-1-kuba@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 20 Jan 2026 09:48:21 +0800
X-Gm-Features: AZwV_QgP1DEk1mGj9j08p70HjNTmf-5GX2yuWUG0boUTQkn9jLlIsgz14SDWD-E
Message-ID: <CAL+tcoBqx0=PeUKCN=XHxVbvrHfG7gSbScW3jCavQMoMnf0Sjg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add kdoc for napi_consume_skb()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	kernelxing@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 6:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Looks like AI reviewers miss that napi_consume_skb() must have
> a real budget passed to it. Let's see if adding a real kdoc will
> help them figure this out.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

It does make sense if we add more useful comments like this to help AI
review examine the patches on the mailing list.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

