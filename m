Return-Path: <netdev+bounces-206420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8756B030E2
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 13:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBEE7A53AC
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424CB23AB9F;
	Sun, 13 Jul 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQPEyFo0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04154A3C
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752407086; cv=none; b=p636rmifwNK+CwwQKNhLKnlT5gA0wmzc8XfeCwIkRRsbWwqnKnbyJ0O/V83g4QJE0g6jtdlyI07Pk1ZpWAnMTzkSa14YehR3jvm+zcdwOUhsTMVm146pnwsund5lFTUMD8AVKZa0Qf8IKw++m+XCxf19Hk2i1GnbqQH/5tD/VOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752407086; c=relaxed/simple;
	bh=kScHAdyH8HudPWWQYr2z6PxLcoog49Qc7KdrLE7zqLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drJVzEOMMqaNW12QZXfXEalRuifisiptIMNiFRENe/kcFgZeJxCBFZ3Lb0eF+Qc+wnPkto1M/Yoec7A6ZvVq2d1CCZmBopjXUhuMNlCYDijJ86Jm/2Fkjc8giIwvSLVDBoVokpcAxI9oGwYRfryyqkec2ZmxMrERn0X+xJlfiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQPEyFo0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313cde344d4so3658913a91.0
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752407084; x=1753011884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kScHAdyH8HudPWWQYr2z6PxLcoog49Qc7KdrLE7zqLE=;
        b=hQPEyFo01BN9TVy/YR3fprHdcuZAEOkRiBVhZe0C4nn9sJhDRxlksRAvOWz/oF7yoJ
         uYNfel3eN0FkRFQ8TwDkc0zQDr2NHh5jqFb2WHTFbChV9XosWdM0gQ43v7AWu8wsMftP
         Npx+aBCsvEaFz+BKK+dYLDH7AXq0NNMRyKPt/qdjc/XIAkIGwBB/Sa9NWIv6BeU1iInT
         mtSurnmZaFqA5iRdCMeXuKyX26n7EqLyN4JRQPi3SOFfceABfuH9Y85W6pNfoeePdwvu
         1wUSQ/KicIek6v3GKM/9dEeUaNtsnF0J9XkCVxLE70ZjpmLy9fxAxNBH1aYAmO6Ll4RU
         sr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752407084; x=1753011884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kScHAdyH8HudPWWQYr2z6PxLcoog49Qc7KdrLE7zqLE=;
        b=ZMZkRVYXE/gWuqncsEod5zmXC9+egM/166Gltlml8+3ieQSDGyuHBzym79mnteboAu
         LjKEFkU3CiojfdgBBuyHaFbdiW6Sc59Hpyfw8VE2OvUwmc/sMZccqan8C9isCrf4PoHV
         vEr4wHv5aep+KkcMam3jqsSPzSgEgeXDLe5v0jeR/a6cflgyQihvA5reV4xuSUi5uIRO
         QUTYvhzgDCY0uI1vgnzaz0H54K3WTd0dka1v9GurQiouOZ8NI5kt+AraAVAh1JI0fB0C
         qsgXjz0eM/xLvV3MvybwxsjFyDUVEy5jXsZKYBB2txkgTqeLCeT8qJqooZJEXX4fvuuI
         rGEg==
X-Gm-Message-State: AOJu0YzxH0oYtuoed/yAMIGEGrp5og7Y8dNivpQWRHJvX2eOFd52cNvf
	Tc90a77zsRl95ZG8aNX3zn+s1YTHyXtOR9iERCP8AWwX+xLsVaBMc7T1zVIcOhcfpJlE9qj15Iz
	8Km4lrtPzZEJm+f+2+7rWT5jkWfM81gY=
X-Gm-Gg: ASbGnctbV23TN6KoiHMqIcElrhsu6gJfdUPz/Mz8z+Z6Y+2lziceXkccquZUMvrhwNN
	gdxnJNxcEW4YG37puM+VmOcwlk2cuc8jSSOHrhSVKldW+xE6BWXQcbpL/Xc8cwMUkQMGaKqSjbJ
	CP34+u8Fq1BeK9eO4mn9jHv84G/niv0XAH4IctyXtm122DbuqueD229JMA3GVCUdwvlbY3rgBr2
	u9mS6k=
X-Google-Smtp-Source: AGHT+IHnnPy7LEtahnUCVeNpfF5v5OPct1g1H1kPJlVdf5P7PTRw4oj9ChKnIkYdCWYYcKzu+8hc0RIoGKkOVnhNZdo=
X-Received: by 2002:a17:90b:4b83:b0:311:e8cc:4248 with SMTP id
 98e67ed59e1d1-31c4f5d782fmr16072635a91.33.1752407083953; Sun, 13 Jul 2025
 04:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708081516.53048-1-krikku@gmail.com> <38cb3493-1b13-4b8a-b84c-81a6845d876f@redhat.com>
In-Reply-To: <38cb3493-1b13-4b8a-b84c-81a6845d876f@redhat.com>
From: Krishna Kumar <krikku@gmail.com>
Date: Sun, 13 Jul 2025 17:14:07 +0530
X-Gm-Features: Ac12FXyU_p7iZEfBvItr9xk2f7RpmYXiyrm3ZXmKRUVQXdPm3djDuy-fvxfs5_E
Message-ID: <CACLgkEah6FthfCg0CX3GrJxE2Tpuqiwdfw7gHvyQKECfOYKE3g@mail.gmail.com>
Subject: Re: [PATCH] net: Fix RPS table slot collision overwriting flow
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	tom@herbertland.com, bhutchings@solarflare.com, kuba@kernel.org, 
	horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, atenart@kernel.org, jdamato@fastly.com, 
	krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Thu, Jul 10, 2025 at 3:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
> The patch subject is slightly misleading, as this is a control plane
> improvement more than a fix. Also please specify the target tree
> ('net-next' in this case) in the subj prefix.

Thanks for your review comments. I felt the patch was preventing an
unintended behavior (repeated reprogramming, early flow expiration)
that disrupts aRFS functionality, and is more appropriate for the 'net'
tree? If that is not the case, I will test and recreate against net-next.

Ack, on your other comments.

Kindly let me know.

Thanks,
- Krishna

