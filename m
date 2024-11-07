Return-Path: <netdev+bounces-142913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ECD9C0B0A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699301C220C8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E723E216A35;
	Thu,  7 Nov 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hkvlh1P9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A1216A3C
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995838; cv=none; b=KgkGM+GpRjGnyywl3JX1w1ZT3uWnnuMoqT0U3k6cRPeLN7ZCC20CkmUEqKXQrYX4HVtrmtiKGdVRH+MqBFG50Njh5byj1upPklRICRktl7/MlymDOXJsiuKWwbwzToi7iX3cmKsphtPpDQUg0AOvQFM9mCHJzCP+niVTh/K4mGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995838; c=relaxed/simple;
	bh=XKNgcHVttsvpl1Ue9HfRV0KR8zfIGidYyouwshSm/u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isgxF77uYG3ythuGDF2KfGOrxCdJ7x6fCuu+EDUF0WT3lHS3VpA6u6yS7u7EIK2+ucFEGUziOnaA5s/i6u8+EG7IKU1hU5TXg0lQHO7nAEqH96xFm4kR8EW4Dy5o3HAcfokvAu3SWeTVe7b3e/wh2/cjkT30yIksfflt+gMAm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hkvlh1P9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so1398462a12.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 08:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730995835; x=1731600635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKNgcHVttsvpl1Ue9HfRV0KR8zfIGidYyouwshSm/u4=;
        b=Hkvlh1P9gxeMo/6AolV5yK73Iw78/Xa7Umsp7zusxnRxMddKM1bjPZIskI5GCwkMRn
         XQTKpqD57pg8VapZKyE7Ptu6F4UGkssXNQOA+KVRrX9Fp2GykoXxH9u+g6rrkd1jFcEa
         rT5jsL35aDmGvElvqpnmK2p0q8EIoRnmwdOyHrrR/bXLt67GqQ3mdDQeJaI8l/ZZLMZk
         qa7R5XJASbaHcJPuM2sPsjllioAZpUvWt5rI3mqXbYy0rFCHR8jK/WTmt/5q71yc0AyD
         7VuatN325ubsIsqQjcSQpTB84k2D3DSVNb0kNl7fYf/RCFghtLqs3EUCUmrvAwbYnzNl
         EiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995835; x=1731600635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKNgcHVttsvpl1Ue9HfRV0KR8zfIGidYyouwshSm/u4=;
        b=lMGzPT9zgimdt/4dF607fO7s/jShwR6tEmNnK7mC8ynLt8JlmoBbxyjfq05DNzG6n0
         LOBMB0FNpCcPoE+N2Weu8csvu2ujuPhLle5v9oynqOHfotUVF5TZn1x0B+ZJI8n07hgr
         1ptzzGBB+LAclsFPZ9dmFyj+52OO2JY1MNldCrIJx9pn1nGOBriAdvtZzJT2yyjtAFxE
         KKqHxRv4qhd95ZM8Kibe0Jec4jNwtFNv9kaqRrPqULJJffxeANcvQxL8iHM9JlfEnqsS
         iur8Q75it/ytsAsafOt6EHO+TvlkxFIbK2LqPcI6DA40rZaR3TqDyoK3wLv4CQuGcHuO
         wopw==
X-Gm-Message-State: AOJu0YzsdtyrHVd5qRhga2fJvoUAvtI4FJZGq459ZFCEj5vJWa/qNBzp
	dHRjeiuz4uPTolc4rw8xjLmZQnxJdKUWbw0WRb3luarGPeIhMmjFAxqPOU4Kuuf1uJhfdUBkUiK
	Xea8DKwpO/F70dNRNimU9K/CHe8wxK9Ud+i00
X-Google-Smtp-Source: AGHT+IHLqdhFXGqXqGv5zh75wClz5ygefiQb2bJpf9Rnm8K+rrpPwhADDE5qyAutUg0lojX8UsVP2jYQkgGYn197PNk=
X-Received: by 2002:a05:6402:524f:b0:5cf:505:b75a with SMTP id
 4fb4d7f45d1cf-5cf0505b83emr1828149a12.17.1730995835289; Thu, 07 Nov 2024
 08:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107160444.2913124-1-gnaaman@drivenets.com> <20241107160444.2913124-4-gnaaman@drivenets.com>
In-Reply-To: <20241107160444.2913124-4-gnaaman@drivenets.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 17:10:24 +0100
Message-ID: <CANn89i+w=K8BRWrXV0sm=q8c8Fw3=uFc8N_5vLGidb6i7frztg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/6] neighbour: Convert seq_file functions to
 use hlist
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:05=E2=80=AFPM Gilad Naaman <gnaaman@drivenets.com>=
 wrote:
>
> Convert seq_file-related neighbour functionality to use neighbour::hash
> and the related for_each macro.
>
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

