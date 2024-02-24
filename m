Return-Path: <netdev+bounces-74678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCBA86237D
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 09:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B18282F22
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AAF17581;
	Sat, 24 Feb 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7NeOTox"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D32563
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708764648; cv=none; b=sltYhqf7uIJi+tXqpOoVK9kxe6Ad4BgK6cKUmm1AJDSVn3YkrCp28jR7/p/w91cN8HLuvdGBtZdOBtza79B+cvjxG44rPSCCS5bnmJMOaT7onprN4WqmOCKEnv3XglBAxoNQIuePqEzmQ7ibDQ2EQqgLTM7PriBuCiJ7rw4Mrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708764648; c=relaxed/simple;
	bh=Iap2q8t/MSU0pOkZPu4lwheCFl2VV/XzeN4A4b/4yG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqBBkxsqCEWsNxo7E1kVBmVbVa46TftjdFBy9phW7BxfM6u/4p+I2ViZ6nuhCYX2rhcGXQ99zAKkyNfBbXoa5LZ6oT2f3x0wbRORYOHC6nCNFTNu1bZ7qkGb+r1LZGmrTXk+1zCLgRBHlMTGxx7RHWKZs+CSrBOS6LGdiVJ9ydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H7NeOTox; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4120933b710so33515e9.0
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708764645; x=1709369445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iap2q8t/MSU0pOkZPu4lwheCFl2VV/XzeN4A4b/4yG8=;
        b=H7NeOToxdtAjAhV4M+enRE2EkkJDH8FCdngP/Cthiiwwk00MHSdutDiMvGEFKDVEee
         Rkw0owmy7NN427jBB0O4YYPE8b7ZYTos3VUB/uZ03CDc8r8UJvsdxMn3xAoUV6YaR5eH
         +EY6L8WgRxOV0PaLotCV6en42nze1nZBRRq0gcE/7+WpibnmCFiYDHZ4mLQH1OchE/Uf
         96kOZ8Qs4AhMbr4S2uSOHCVGP8/VZcWkOTkmAb0t5xMkhU0oix64tDfnQsmB0jDt1/Rh
         JQ98TeMQYt2T0Lnnwt54HUwbgOhUkMXKFEocaBZAnoA12gQe2bEAWIlIjdA3HLXishCT
         QGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708764645; x=1709369445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iap2q8t/MSU0pOkZPu4lwheCFl2VV/XzeN4A4b/4yG8=;
        b=BodkcDys+3vijUpk0QZR0T430SI9TA6F9PT/OTmrhv4OP6n1gKzOIKdaxeQDKcoSWO
         dzAY8rXc4OgKCy3wYSyNFocsCAImYTtVfMWG399aPBAv+qO2ytXEoDCODkxRC+H/7tiH
         z0YvIm7hQXMD/WuFZZEc3qyCkk1p94NhWcJcWca3FcmT8JQM5DICAxCqg6sSDqtwTS2q
         B1dB3+ivNSn3KFceFXo1MlwpHUoJkLclN8Jx4seiVhdW5kXH0kcOaK7S2wZGLTqFlnHJ
         /IqMDhNDiyACgHfW9yhMsZijaVIC3gzrP/4Ygpq8JFK3h84AEVofjJgHncXrKgHjFIDt
         N9Fg==
X-Gm-Message-State: AOJu0YwAM2HqAt8/5oLzwRluW0x/M52Xw0zMdCW5COZUGjCbNKqSJ6qj
	2UccuyQ1IFkV6i8ob1TNnTLR1WfVTYa4H1S0syJWw/QTty0AhnAnwUVt8nJF1x/Zsz6ZcuOdrqM
	OymFSZJqJTwN7Pv7r8t/+b0gJ/zqaM9+cTf+s
X-Google-Smtp-Source: AGHT+IGQjpXcHos60PIPHlgd2PsOeHkgP0LRD/LSAxwdfTuyyKPOAYUabKXdvfD7+Af7pMA1wuRw1knnJHRYg1xdGfg=
X-Received: by 2002:a05:600c:1f12:b0:412:985b:a1e1 with SMTP id
 bd18-20020a05600c1f1200b00412985ba1e1mr112207wmb.4.1708764644940; Sat, 24 Feb
 2024 00:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224084121.2479603-1-shaozhengchao@huawei.com>
In-Reply-To: <20240224084121.2479603-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Feb 2024 09:50:31 +0100
Message-ID: <CANn89iLSkPeE4OkCWcAhd1ji_BcVijyTiNATJouiG-yfPYc8fA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: raw: remove useless input parameter in rawv6_err
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com, 
	yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 9:33=E2=80=AFAM Zhengchao Shao <shaozhengchao@huawe=
i.com> wrote:
>
> The input parameter 'opt' in rawv6_err() is not used. Therefore, remove i=
t.
>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

