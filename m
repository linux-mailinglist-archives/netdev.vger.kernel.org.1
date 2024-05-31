Return-Path: <netdev+bounces-99680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1538D5CF5
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E4C288D16
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78850150986;
	Fri, 31 May 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okDAFYOC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754F150989
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144816; cv=none; b=szAp8gJPNqkUPJp4q8k6sXOsi40S1VQmuJOzCpJtbhcVbV3sDeokAtfmBH3AFfgMmUVTIsgVvnhYELXTQIpWWZAqEW3oTi0hSn5LuRWN3svGoSPHJf8adZpckB6Um2tw+U0S+gG1M0AzLGKgYTpsyBjy6ZA0qvlYCVnof/1Fu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144816; c=relaxed/simple;
	bh=qoYmiDVQHGoJhDIUf17rxSBZimgTo2HvSHSaaEmvtKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvVrfXzTwMb6VcVT/ltk+DVnRRJHTAh8gqy6a9rna+dZlJKmjO6URFnBM/jR1BhaHrlt4NMHBQM3vf6oEuavlEqSA2WqeV6FBlerfVNqevBRSHS/yZc8sPAeoIUf6dPpcYS9k3Cd04VowqJnd00ihSh9q+DooINuRYQFoHN6YXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okDAFYOC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so10792a12.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717144813; x=1717749613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoYmiDVQHGoJhDIUf17rxSBZimgTo2HvSHSaaEmvtKc=;
        b=okDAFYOC3I6e58eVgQ3TPmEHdBXoAtn8jqbwv5z1nS0aWz62xVJ7ax05yMvgpxoE0x
         zTpl6Esrh6luj3iPiUe4yudQ1CYkb4VtHY55mMaoQOUnC9g9CPGIw2ULiBr3dQ4qfVY/
         jyNt4t1XAwQ/AY2MR5eBftnKQen6ykaBlDBMJdgjrzh8EalcM3S8LkEvAyf1b0SvPxMT
         c5PWSaZll5WI9xMcUQxl7QKCb00NuRyrDdvkCxXV9t6qG1UUCjtRlRQs3UFp8z/Yjoth
         K0tNBEPeg/TYZ3a/EY4O8hFw5Pj7nhC21nA2g+ZFOz5tbQ+XKy0JLJox3CPuLnp2Fdd5
         tqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144813; x=1717749613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoYmiDVQHGoJhDIUf17rxSBZimgTo2HvSHSaaEmvtKc=;
        b=pWQIHIDqx1JFE8bfnfI9mOrF5D+pLGNK+Gt99zgI1KOJbSBFnXJWFanmaw6o2IbOmw
         8MbjeiFeLwPQL0ZdnMS6KTyH9YrYnIg+ehOWaHqg4W5XZrbgsjJZoQueDhzfbN7phWJW
         yPx05lOlTeI1aJK0TicC0Wdxf8rJqwn0mLe0frNB0UdOODj3+0pCZRsXnz2N39hT8etD
         Jop5iOmzeoOKa8iBHm5meBZJyJDap0QK4YJcmpv+0jJIfnrUOXEnJtfyaa5wUzqoCAgt
         A/q6YDNTUkxpMABiNb7Fnw6gtwhxf/SzDGZSydBKzYK+urvQsV9QW0eG+bo+l9dvjm59
         T+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXhe8aWUq4irZcPw0ZNWerAsDr8Aft/i1PG9fofUnxD3QDonAC2XnVJsxRsYfCOLXxBTH5ypKwIbq6oxEMfsAQTlUOm0n4I
X-Gm-Message-State: AOJu0Yze0t/6G0KRqg95RLEL7lunL+rCvmwiw4393hk38lnrB7gRGn83
	ubzoyc7c9Xq2w5KJ5c6SMLROiS01g7/ZdQAbl9OttNU2TDuc7A6k7J1S8UTIN3klXII1mwX4hgE
	0wun+IQd2/J4o94EnOrwMa2SnCQyxfVubsOi6
X-Google-Smtp-Source: AGHT+IFGbauQlcPU+hEeKoyanfKhy4gjinVXt02F9RE1UHv+tzn11F9/2S2LUgD+Oau+MCnadvuLIZbn0Fa/zUtcMp4=
X-Received: by 2002:aa7:d04a:0:b0:57a:1a30:f5da with SMTP id
 4fb4d7f45d1cf-57a339d8ae6mr123533a12.2.1717144812810; Fri, 31 May 2024
 01:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530233616.85897-1-kuba@kernel.org> <20240530233616.85897-4-kuba@kernel.org>
In-Reply-To: <20240530233616.85897-4-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 10:40:01 +0200
Message-ID: <CANn89iLMJrnyvtT+CG635Pbv8BjLYsOEGkf1ut0nY93sUBunOg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: skb: add compatibility warnings to skb_shift()
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org, 
	borisp@nvidia.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> According to current semantics we should never try to shift data
> between skbs which differ on decrypted or pp_recycle status.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

