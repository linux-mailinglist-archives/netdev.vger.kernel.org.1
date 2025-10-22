Return-Path: <netdev+bounces-231705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF8ABFCE44
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF201A05E25
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA80247293;
	Wed, 22 Oct 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ+Yo4e0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7230C231832
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147074; cv=none; b=AUCjNDbIXGV1OVh+jNZrK8MsDpN8pNDIkShUVZvOOPbcUHBGkCii06GyaO914doqcABnA0fNHaQYubTxTwbcQGGZYYN8lyEOuE8deaInuDIx9GP1B5fqd9PksjTvsR2nFMK9RvvhVU4eh/24g46syLZwRTb2Eyp5emQDRiGk5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147074; c=relaxed/simple;
	bh=bRcLD9cxvp6AbFFd8VLs9r/lqSIYtWbZ97Gmd9tAA/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YODZuyRIA1H6C/zNbV+D/B37k3JED03ZKdjwGbtxTAQxGEUWW2vrmA4VNGKamPB+qJ8KYSUjsMeNyIFCUBjxT78+XGL+FAxMoeStLVdDQozi7qlMIGLTILbxIMO+F7RXL49+Jcfi/ipwKBy+dvid0Su+Sp7Vg72jkN0a2YBPH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJ+Yo4e0; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78368c63d5fso2324207b3.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761147072; x=1761751872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xJuoCga2qS1/JaA1xmqdBDidVeSNx7M/fKO2tstQfM=;
        b=HJ+Yo4e0npxFNOp2bDhpnbHHOcBp8yCTxZY9qqfXXW5mTPKp9hI25+ssBhvvYQh0UT
         JIl5cO3UJ1isCa1ktG3yNgmSMIM+Vnx9bXXqa/1EqxpuS6v/OHmzB6CuilTYT85rNcbj
         ozXoHgaLajluD0Z1XvOEFMtILTK/Ds2wdPLsoAJejGgs0d0meeEw2RK5Et20KUpouoTc
         MroWqqhJmoGb/qmeg6sF+FUlkhSxplS2LvAxVJqA069tUowAZZeAG+YpW6RqSRHdcbjm
         q3uOZSGwQBJcCBu/kSaKdCRIdyMOTRTkDh6b2lvp7GYF/ktflZAhxMIMMa8a3oHh0c94
         dIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147072; x=1761751872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xJuoCga2qS1/JaA1xmqdBDidVeSNx7M/fKO2tstQfM=;
        b=TGCVcDYBNMydwoOTEepmPBOagyaMzK/k28vosJoeoMPqMs62XoEuGphTR6pq5gNkpc
         EzZy7oPt6jmb8gzGGkJnRl7ymD/Jy+gcImSZPStGcjXimrLo6Ux4YsK0crQNeynafEf5
         nHVGXQRf9h/+ZMmqOlqKcytwZmkvrQNThIaGZfOaof98KLDPjyxuHH4aq5ASZmcv8wRb
         sXMH/UxoOwAH0g2a2MhE+4Ed5Dg5BxYUTHdb+7s1a4xghwCC5hF5oq7w7JyBYfCbvgtl
         rjn8aW5e2XSuKauFSh2ckCMCw9yqIBzEcG4aJ08JxMmizDgEs0MDw1xxm+QZgMb8LGVQ
         BSYg==
X-Forwarded-Encrypted: i=1; AJvYcCUrPXtQp1IO9HDnBRe8bx7UUA8tGeCLY5uC3IHPMEl0DVVDETr84aZxeQjzoUL8e5oGG5ezI0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKiydIxa9R7OKXlKGy+V5RsjVsz3EryY5tu6Nc+G4Hl7Vr/L2B
	l1HmvDcXeSzp/RlJRbpkLoxkpQuqOFYHcpEDrkqyLqjzAjFL3B/F3wLxOvY0cz6q0/5lDh+mjrR
	8QEm6IQ2DhzlDTTSgw6VozwvfkFox4vY=
X-Gm-Gg: ASbGncv+CIn5WEnTXUSf+JyO8dqQMuVfYsmYrBGB4kYaQ9tA2/KAuuGYqH2njCRHXvX
	DN+5TcPSRHoE6aqrHyyxRA1zf8hqpSOMf8XiDrEbYQA6ywoLs2+N2VMUcL08kLLAAR2MABO0+lw
	PcPeDu2T7Q9vLD+2VgKcWLtPgpu0nvlQCBfIWmgVvumR5/GHib6ytLCS/oD3LjyvFC5Yad9rMHV
	UKFFXKgAhRTjWSuMM0+2UfBFOjk0r1loESDiH99YTuNkGym9/CJTxxTtN9Zbihqizh3lw==
X-Google-Smtp-Source: AGHT+IGUbnBJYGey/KPlhF0ILUMb+ChEZPFDcxuQ0cUZpZa56x6W16tKmaq5bq3hykYj3YJfbS7ovrvf2zubyB6kY/k=
X-Received: by 2002:a05:690e:1915:b0:63e:22b1:21af with SMTP id
 956f58d0204a3-63e9ae40e3amr3285054d50.0.1761147072117; Wed, 22 Oct 2025
 08:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-netconsole-fix-race-v1-0-b775be30ee8a@gmail.com>
 <20251020-netconsole-fix-race-v1-1-b775be30ee8a@gmail.com> <uaxu3wlt5jqhzibmhjy44sb5mlekdezqbt5b3p2e5zza25jcpu@uqxdynirj3lp>
In-Reply-To: <uaxu3wlt5jqhzibmhjy44sb5mlekdezqbt5b3p2e5zza25jcpu@uqxdynirj3lp>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 22 Oct 2025 12:31:00 -0300
X-Gm-Features: AS18NWBA2wxs7GEJVzMm3TivqvdbyTpstIdOmgV7cCUDz9rZ6P9UdXcmkB-Iy60
Message-ID: <CAGSyskXJXQ0DgyaX6XGxk8PF974CoM_0tA2o_MJ5WzfLhEBwpg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] selftests: netconsole: Add race condition test
 for userdata corruption
To: Andre Carvalho <asantostc@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Matthew Wood <thepacketgeek@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 8:14=E2=80=AFPM Andre Carvalho <asantostc@gmail.com=
> wrote:
>
> Hi Gustavo,
>
> On Mon, Oct 20, 2025 at 02:22:34PM -0700, Gustavo Luiz Duarte wrote:
> > This test validates the fix for potential race conditions in the
> > netconsole userdata path and serves as a regression test to prevent
> > similar issues in the future.
>
> I noticed the test was not added to the TEST_PROGS in the Makefile like o=
ther
> selftests. Is that intentional?
>
> You might also need to change the order of the patches in the series to
> make sure the test passes in CI.
>
> > +cleanup_children() {
> > +     pkill_socat
> > +     # Remove the namespace, interfaces and netconsole target
> > +     cleanup
> > +     kill $child1 $child2 2> /dev/null || true
> > +     wait $child1 $child2 2> /dev/null || true
> > +}
>
> Calling cleanup before stopping loop_set_userdata causes writing the user=
data to
> fail. You might want to move the kill and wait lines to before call to cl=
eanup.
> Additionally, shellcheck also suggests wrapping $child1 and $child2 with =
double
> quotes.

Thanks for reviewing, Andre! I'm sending v2 with your suggestions.

