Return-Path: <netdev+bounces-142826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB69C06C0
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364F9283F4C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A62170B4;
	Thu,  7 Nov 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skbpCdXw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D0216E02
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984302; cv=none; b=BhHJmLdHIAe7F6cGKPGrGBftanlvL1f7COBHHP6AEyXXOQsk3HrAAd5YIorHOKh3qNPEkfD9fLs99es+Z720A/+1Vyv10nB3456UVJWK4lhG5idDUzfdziREmJKp4DYKK/LoxnZvKqDvBN7YPkhz08FcCirPOkGT5zjijHhM64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984302; c=relaxed/simple;
	bh=rREI2uB/V7gITxR+FOWEnJEJj7Zp3xpW1kT6EnF6GGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSJpWEGxAFez5BjjGDNbzlHDcLonlb94c6Zh1TumGQjPRBa6AYT75Y2H7K+LKJi4RRFGMAccGbNL/m0nwGdQhuERKcWlDbMgZ5ORgZe7y/xeMjxqjN6o2vz0EB6Yy6moqIaBF/hQy1Oox/NSWDmVk5ZyqzTZfFNULh8ZXfgWaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skbpCdXw; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83ab694ebe5so35277039f.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 04:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730984300; x=1731589100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rREI2uB/V7gITxR+FOWEnJEJj7Zp3xpW1kT6EnF6GGg=;
        b=skbpCdXwJBG3FGC/3cRT+KVeKXU4yQTcnJqXu2BZnOFy9VhPb38QQyBv/lQMAaycKh
         5xusSgBIuE87Upwy7eU+Rh80cALiUKEWtfVJPsCQ4D0/AhoSRo91mbIm7oCVZ+zPJNl/
         rc3rnI9vlGHt7Yogq5Kmkq0KmH+OOt5JgVBaR57iZj6zksGoCqVoReRMzlnRE9AYu0z2
         ua+wcCsEtdb+ReYnRxpKlfUqpPB4YD7KMFa8fU/bgjyV19fhIOH1C71eBcxp/venA4qF
         c5/Rq0D6lzwVwo9x1DCYyDnL0vQggt8INSAnc13x3bqcyZB/nLTKSZxcNhpCGVyyYAB2
         m88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984300; x=1731589100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rREI2uB/V7gITxR+FOWEnJEJj7Zp3xpW1kT6EnF6GGg=;
        b=MBYjOPLfIBVymx4EUNhVAL1i4vhIQEYBnk04L5pmWklqGbUaGiy9k6o5Go1I0uia+9
         Tot9n1BYTnPs5xeoeTya+dlU1nmU/CYC3vvYzg/XyLOuGtqQzrWJC18I08bF2mkOzkoX
         mhuZaskslwz72sDBo9ckNwhqK1XnMtVLBUAykmJsKapjEx+kVzwSLsfs2HJOWjNGnyNr
         qgJKV7uBP5eY5+VazaoPVwOitJw4SqjcWyx+2EBm7+dAMaUG9wYaqMpMYPEJ5+SmG9ja
         wz5fl3fzIOOjnedlE7+bEFSMa+kYkWBekVKNN8jlj/huJ69vyu0OFlpwkXa6KMtP4SHU
         GLJA==
X-Gm-Message-State: AOJu0Yx2XWRMqHRAln6/1Oq/sOlwmb2d9sSBi/3bw3pxf/PNt97DvW5U
	r0jyv45yikTpwpk+03Dw5hly+qMsW620/Hu5VyFDX3A1XSSjgjd0RXRybSfjyGsu/LuKJHmHQd0
	M4FIthTJkFXkM20WfKmp6dV0hk9wTvITRz9dN3G+Er57R++T77g==
X-Google-Smtp-Source: AGHT+IHscjrM5yEnv7CrhyReHBjY7qQl+IXVp7qcac6OeEOBi7Zjcp2eWSsM0avGdTAuio9QA1rDs6cVw4QugdFls4Q=
X-Received: by 2002:a05:6602:1354:b0:82c:f85a:4dcb with SMTP id
 ca18e2360f4ac-83b1c3e7acbmr5270606939f.6.1730984299791; Thu, 07 Nov 2024
 04:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com> <20241105100647.117346-13-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241105100647.117346-13-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 13:58:06 +0100
Message-ID: <CANn89iLjhS-bTjxDH37K6NOVHU6FgD6KL3LT0nRGyZBvtADYjg@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 12/13] tcp: Pass flags to __tcp_send_ack
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, joel.granados@kernel.org, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:07=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> Accurate ECN needs to send custom flags to handle IP-ECN
> field reflection during handshake.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

