Return-Path: <netdev+bounces-164380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB5AA2D9DC
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 00:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B6D7A33C8
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 23:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BD624338B;
	Sat,  8 Feb 2025 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qy00nkOV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE297243360
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739058408; cv=none; b=coy2OwfGa1I5bIp3TCYQ53kjjj41x0hE7r6la0Is++JNpKGnEiW6nAmM/a6+2pLxiPDY4SJmUtSKUXdS4SfNw1gJG7miA4aJUwIsakUESGCwZHStpUsmUuZGUKszOoSAOjKxKKWa2EKxW5mXrua0/HG9fVoaUlE5Drkn2nkOxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739058408; c=relaxed/simple;
	bh=9a+5LjfOErI60yWYIPDcOWisChpbGfm+PaE/gnC+buY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrIuPil49BAqEFUIpiB0zDXpknF74NDlE3Mw4068F/VfiPbOCa4bFKnXw9OI32jJlPDtgnStHX0B5d5SV0EVOS2G3S8Us+GTWB/sxVMV5UcZtp5pPPoDtRc/ywTK/cJWwbrz3/cwI7/ROSikp+2WF18x700ybK5wpYcV9sbkZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qy00nkOV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4679b5c66d0so196881cf.1
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 15:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739058405; x=1739663205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a+5LjfOErI60yWYIPDcOWisChpbGfm+PaE/gnC+buY=;
        b=Qy00nkOVlRUQlHp3Yv+La950MDj0A5UW4VLhcC5FpIHVmyUPv+6vPggk842GAQglDr
         r+9HPnh0WDa6VlXjKK88g6PP/MQNyo8HZSyTuHbtiXdT+lyqwsiVF1e7RBgCQVCPqLeW
         tsbdjEs64FCFj6LfONlBbQujCppnifpHdj0vsYlhXBSv1gewnDlh4EvGPsdkqhvKIh/I
         +sAbvCYTB6YH5WNS3vnx3t27ReZ/MUOx4O/M0PhJKA/Z66lvDXz4zIrEKi2TfCRa9Nhd
         SNGZqPKuLZ7/xnvNGR8ZWHwhQe2DDO1I5zHLsp6DXE7Q810mmsn9e47povxpYggFB9S1
         gMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739058405; x=1739663205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9a+5LjfOErI60yWYIPDcOWisChpbGfm+PaE/gnC+buY=;
        b=JLgiwQsXashRvGcP24Gin0uDrmvuOT+71jWdwVz/v7aMtKD8NhNJU4PDTIXOu83vrY
         UEdspe1ajY4gpHVYZyUxFPdZg2iFshRcS72/I6q4OubZY9co+sry1SNKYD6kW5eplmGE
         cijmYId9RBH7M9icvWnkpfa9bkQDVknwhV0FZ5I05130QL5fpkJ6OMyaCYaYcBJ4a7hc
         vkjmns6upffnZ5PxUe/AMgjhIvCJ08CQ2EuqxTQDxL4/So9uilEoIL+DbJsAtENBB3Pl
         exQGnCrIsGHqNkgNxkhHitAzeHRyeYvpJ5Zl8K3TiClt6ZKMeQjzysPxW+t/HqCPCQTb
         q99w==
X-Forwarded-Encrypted: i=1; AJvYcCXaazyn0jbuAhQKc5ZCp5nQpfuzgNPOuIrMtbL0mWXXIACJExHD+icWIVy6JRckbFEh04Vm0/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/dTGasyPtiIvpUkFDHDgpkKVKLjY8Ws0dX7Pfd73NzKda5iuG
	mmHe0J4I9ciCM4vu/LgGp0T1CIlUe7htjr0yyY9wFiHOk78nCh5sLW8aDzgIA0L2lMXin2082bs
	uog360KQURRZkHff6XYdLlZZ5pZKqkKuTykuf
X-Gm-Gg: ASbGncsdKcG5kqYrZmP/WGaRnbMykfxTrsA43n2kkkgJFYjc6BYky75LqOBpSxn+T9A
	HT+K79qic7hvR25YQcBQ5aBu/N47YYUzwE2D0jj3Cts6CVwGNL9gPVB4TjxavDkMefnxkkR4=
X-Google-Smtp-Source: AGHT+IGiTMH+12gfvDVvQrCDRiZzebJPmALHn3jW+qJXcNkL89cewf8T+KIYPjZeUWPSX9nvZ4RhgsiiU0zM9a6n15Q=
X-Received: by 2002:ac8:71da:0:b0:471:8b2d:c155 with SMTP id
 d75a77b69052e-4718b2dce37mr163741cf.1.1739058405392; Sat, 08 Feb 2025
 15:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-2-edumazet@google.com>
 <CAL+tcoAf528b9LKUtP_SKYLsFOANGZYpwnPQNGb8k+uRs+qxWA@mail.gmail.com>
In-Reply-To: <CAL+tcoAf528b9LKUtP_SKYLsFOANGZYpwnPQNGb8k+uRs+qxWA@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 8 Feb 2025 17:46:29 -0600
X-Gm-Features: AWEUYZnqYMsZLR00AFcz51I8Feja2OUvWS4WeCOAZyYtadJoiO2Onf-EyYcx0S4
Message-ID: <CADVnQymiMvDFFF_SWk-ehBZCfznwBXNcmdvckPG_XwG2texWcQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] tcp: remove tcp_reset_xmit_timer() @max_when argument
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:30=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Feb 7, 2025 at 11:29=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > All callers use TCP_RTO_MAX, we can factorize this constant,
> > becoming a variable soon.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

