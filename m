Return-Path: <netdev+bounces-70343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7765484E727
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F791C21DA6
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA717EF19;
	Thu,  8 Feb 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFVFVW9d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4CB823D3
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414859; cv=none; b=QLVoxYp64fay7NWXGXK7XtyTYD4n7gXShfrqS9lUOe4kBy9NQhXq9egqds1yMQpimDEtX+aSzlkn2MKNuHH+bd02T4VHd1YVHv1BSuRQVmyfiaRv/0e1nXK4iQ5wyxe30tL2cWkOfhFrTRBu+mUIliiw2Oj2RhiPqYeTdGUyKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414859; c=relaxed/simple;
	bh=kWkqOCfLupjsvj2jVaTbTVgG0CLCH7yF7AVm3NqnfmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqqyY92YlyA0RUE8hOwYGo2If+GVWygFs20IotdFVG2At279OVWMLdZeFnxVX4w+7eZv9kk4aGPKFpUD1boyv0UH9Uu5RT8Rhl5hNTWUziYyeP6NyLhuHsuFyZyDqz2KsurWcimQNcqED2EIQGYyNsFLYuk350fvOfkvslKbCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFVFVW9d; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so15755a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 09:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707414856; x=1708019656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWkqOCfLupjsvj2jVaTbTVgG0CLCH7yF7AVm3NqnfmY=;
        b=XFVFVW9dMzYN0NJ+BUG/x6M54Aip4Yz14WxpPeLfV3JmxB2zZPGt92Sl2FKiW7QAka
         Rw8DfeJTw7CJz1SWhKmn2MpCyjUQx66S4VZkC6LgkssKe3i/nk268Tk+cjN7w8aq6OWb
         ldLUHdtrlUZf7cih0ZO8LhdgG8gXIAHoquUCqeynNZmPasNQsXbXmwfuTKhLzqFgwJC4
         tW6hgT0SWjA8gl2hXQpX39oxwvxWR8fgaiNpzUw6D4VUgYOMIf6grmOx7JXjKbkKQ9hV
         B+dIBKnt7HqUVY2gWcYzEpkXF267czBJSjvs/CRBkK0AWUC/Wh9qN6Cjn4yUAhdIsrXf
         RehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414856; x=1708019656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWkqOCfLupjsvj2jVaTbTVgG0CLCH7yF7AVm3NqnfmY=;
        b=TPGBloxdDRQebqZ4Alc72VbNVPwv0Zf+ME8yafgfGBBYjDryJ9cOzXlntJjyTFE74I
         3hQyJ9dmIESBAht2QPJp6soKVlsglUxTeUWu/DanbrTfrR16i42WqQ8xciXX9dwkpWUl
         FokdKOxGg1meHaRyhWo8LySu5e1yX0oJDeKQDORqqo0cnQrsFhp0cHOgbefvZri2zO3S
         wZfJwOQHMEmLWnyNRlF7axwxIA2YMhmn12Pj8pER1B8q8ay6qBXqNAWu6xG/8lVmSzBR
         8kwf/Z1jRadbmeYV5oe3Y1w3TjiHJXPxzeJRUcnXc5B5Npuf1HQdaV0XwRAW2x6z80U3
         TzpA==
X-Forwarded-Encrypted: i=1; AJvYcCXJWe255Mfe+oq3EbRlSdFYSE5uvSA4I6Dcg2hAde7e+eaeFzTsHzpnaD4HqkXyAg9k7WwDiLkLG86lJHfcYDg8JvHDaEEZ
X-Gm-Message-State: AOJu0YxMzaYeWdTibADZs/hh+IOC8KoV3EVcHPzWUjpqm04eUpAmyU/b
	ftUOvS8GPOyRE2NserOVyJAXKeKiay+LRGIlD15RsKo08qMNv2AaEPHHm3hmNvOSkIshs7gslnF
	8lvB1VUMGB5w4xqje+xyJEI9U2ro1ZirpxVF4
X-Google-Smtp-Source: AGHT+IFcJZFvtyDrf0HU7aC3jYSPfBWtVCzdIZEdDY+XmXK8juT0pR7X+HO5Cw+PATYpuelsI4DtMIiQUBsk9nORn1U=
X-Received: by 2002:a50:9fcf:0:b0:560:e397:6e79 with SMTP id
 c73-20020a509fcf000000b00560e3976e79mr3222edf.2.1707414855923; Thu, 08 Feb
 2024 09:54:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208111646.535705-1-edumazet@google.com>
In-Reply-To: <20240208111646.535705-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Feb 2024 18:54:02 +0100
Message-ID: <CANn89i+_mFcGJ_zyzM=K-NpPA=hObu-+Cic9L42o+rsdtqEDPw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] inet: convert to exit_batch_rtnl
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 12:16=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Even if these four modules exit_batch methods do not unregister
> devices, it is worth converting them to exit_batch_rtnl
> to save rtnl_lock()/rtnl_unlock() pairs in netns dismantles.
>

Please ignore the whole series, more work is needed.

