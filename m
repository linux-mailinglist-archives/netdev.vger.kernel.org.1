Return-Path: <netdev+bounces-137015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B169A4069
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4071F2B751
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEF7558BB;
	Fri, 18 Oct 2024 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPgeJAzI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D15F9E6
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259525; cv=none; b=BbOGUQLRCwRMxOEpWXD4SSIr7/jfFUgLRjGp5D6klEVWnZB7LlclBEsSuLExJDBwHph0NtulrAVvRj+gWp2XZ4llmB/UQi+HlcvbhQqUM2TOaP+aLdxVNB6vmkoNEceHyM/63bQlY4raj7YSB5AF0nqUHzVLZSaeFh9yNNhYRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259525; c=relaxed/simple;
	bh=el9EnV5tR8IyqHsDDftWMdZhXlm1uAW7qaN02V0/wzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a37TxZlzr+oXIi5Bl2UOiKAcQT0nhJ9HxoTeWrkxg54WSFO5Ec5Nx1qYtmvAUDWViWYiBQan075BwKTlzjunIgRefuULqS0quobV+BENBYWcsxLV4plVvz9Xy0wB/twOqMUThPPXvzZPUzCG9tfs/FrOEN9xUiVTpVDo+baR9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPgeJAzI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso2628112a12.1
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729259521; x=1729864321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el9EnV5tR8IyqHsDDftWMdZhXlm1uAW7qaN02V0/wzM=;
        b=hPgeJAzIPIJIlzRnTR54QoQWm+QpOrUMOHkoSOvONNsTvzyyNWB00C8xtuCwzW/HOm
         Zxgrj7fVE6kuVniidR6erYyDC30VF3eDxc8Aqaqonb4+W6iueA12bFE3p8Kxh+XOXaqN
         cu+GsgC4W5osCvYm0W5X4dubmftgxdtj8CQapQ5Yxxzit9/SNoEbBDE13Belb7b2hd8o
         JRnXm/JRjQo+htjmRRIlDtMiFk0hdixovk+laAcVsiuBabstGfqge4hHVd3y0USLQAPs
         dyzbHeFAeG67/KizCHCLROh0m03zOlZP3zR68erVsgEHxxqrexS+PkvWHF13S/8LkZEQ
         H/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259521; x=1729864321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=el9EnV5tR8IyqHsDDftWMdZhXlm1uAW7qaN02V0/wzM=;
        b=ou1vWrPfmXebrwuIqUnkn4l0gGltsolHy0T1K/0LwZ8LdZOOjwo3IoPWoxlRJuUlHU
         eKtRUR0hhfgTXI+rdUc1iDzLgYhSbeZwrNK1trzp16sizpVELkcZ2+7Kxf3txbYacSka
         6Z94JlLaqI38pQTWygd16zRDneM3vje2boX/LLXcst2EcwEgn1dHb7wmE8sJqvTC1ZJL
         CDw9ycUIEfPLj4CYvTKnlt4TOyap/sMTbXrEgl3MqctW8FFYC6fuJSYdMnvNPttm0BZj
         OKBvtawprpBO9ri40w3ol+HoiB7WdbMCgOYhA9xyFER3cnLqE8zioSffGuLrigb3KFqz
         nTAA==
X-Forwarded-Encrypted: i=1; AJvYcCXRyetTZQYzcMuXgIywoV0OlZm41jPpvBWmBTzRqkePJcTvpgTfy0ST9+T0Y/WfmETXDzLeh0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPRVHNUhcmrkVb2KImSzkdqblUjWCNMU8KrY4MThll4l5XsQQ1
	TinPPWQgFV0+r4qAAVzOAT+ZZnm7q0UCmH4qjbjJlf7JFmj8cf/RoGV2Ajt3kRCzysIa2ZSz8Jn
	xfMUtWZK7HFydDQ6+rjJvDNmze0IYniti6XOo
X-Google-Smtp-Source: AGHT+IE/36dv0Zb5ZP0wUKkbOg7CuJxGTrKajlekWGrQm1C0D3nZxIeqh5gFfCXf7Hh1u3wVkCE7R6tIH9IKdwkej2Q=
X-Received: by 2002:a05:6402:538b:b0:5c8:8ede:b6c2 with SMTP id
 4fb4d7f45d1cf-5ca0ac668bamr1646838a12.21.1729259521207; Fri, 18 Oct 2024
 06:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018012225.90409-1-kuniyu@amazon.com> <20241018012225.90409-5-kuniyu@amazon.com>
In-Reply-To: <20241018012225.90409-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 15:51:50 +0200
Message-ID: <CANn89iJrb-_xSvpoHUPut7e2r=WC64V-4wrqF5xbw4qf5e55Xw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 04/11] ipv4: Convert RTM_NEWADDR to per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:24=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> The address hash table and GC are already namespacified.
>
> Let's push down RTNL into inet_rtm_newaddr() as rtnl_net_lock().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

