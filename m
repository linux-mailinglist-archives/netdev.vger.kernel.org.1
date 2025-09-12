Return-Path: <netdev+bounces-222563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E9B54D4B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0573B6D4B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2003218BF;
	Fri, 12 Sep 2025 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsYaVhjQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E05324B3E
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678937; cv=none; b=GHH23SvxzHlye3Mm+B2l06AScoQEh6r0HVN8Td++DPTy3+9X5JQaHorC4TLhNNWu8UVuHY2Mz6r3Bg36Bw8A4VMa8grF09ONb1c8PXcM65F1PkuoHM2Apzzw4ZiymzBPvxCn4vg5+o48W7BnrPledOh56/d/Q6wFXD2Ff/yirBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678937; c=relaxed/simple;
	bh=Wz4E5peEWJEuLH5HpKzn2maiOPcV7d/t/JntClDMc3Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=EfJgqjEPKbVWcOn7UiFPnFoYV4BhFewNiLCGUfhMZ9z/vcQGazuYYU6cjWNDJGA7d8lhPyvFm5lpq/0+lzMIVrRfLMViaRWL6Kw7QLAJgffRbz8ta3IPdhYxhbknpjL7kWKd5/MDdH3OSXLnJFL4YCAcwwhpj4mZIOzwrVvSCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsYaVhjQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so21829145e9.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678933; x=1758283733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wz4E5peEWJEuLH5HpKzn2maiOPcV7d/t/JntClDMc3Y=;
        b=WsYaVhjQn2JqKOoWVPSN3hvIwjd0D7IZWiGO4L4yFLbMk/ocRhAfR+M1tcvbeiXIe2
         LB2VMBqAyNaKlV33VR9TlZnlKbOZGT088PYnXiLVebdx2M/khLD+oYqScZQgSq8jMOwk
         JVeOS1sf52TKhpVshHayo436Z9lo5dxkZkxw3Iip8ayWuU/xKH49sUvEbkGpwC4sflaY
         O/w0b8vAGiBImtanSV1xlRWMmvMqzmRntkYpu3AsRf0l/2JQucBPqV9sxhFuKay4eJaQ
         cav0gQEn3pUvJGtkdGuw3DkwZUY3dfMQ+bsJVAT09ssZ3vklqDGZk4RjOcDkcG/IycEf
         04Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678933; x=1758283733;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wz4E5peEWJEuLH5HpKzn2maiOPcV7d/t/JntClDMc3Y=;
        b=L15XczDa4AFa7KjW6jdP7AmMD5kW8AgQ565U9Lp7c6tHoUdD3qb3POqW2tggWeXHCR
         adccyy/6FfOfwnNt6vBsneI6gmixpi0N9kq5qq13LwaFRFpREoD3w7Ms0T2JZrOs4GYS
         Rthy0asvV5wdoZd+tOZIZ/iwt4TZLVuETaDaECmhNSOfaNtyXN6ZvIJeWQcHEaP/Urd5
         KmXr2ASIaWjLWNlUvo5TpcvM7TXkjnmNVx03VmBp42SRJ20AMA66z4EGZSM4xED9DGkJ
         9jzwLVMGVHVnCjB85q5nkOl4SA/xBfQaGW4GSSmKKy2nJGdFWdHuavB1KGxVSa5wPVDB
         SlSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEWKO1tBQlqOa0TFT+Hlc/ChHvXaY9XKZoo5riJWH7dVVG7rG6QRrLXrbLCJxv0RfkyIa74p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4qRXQABKo/pElqM0OEvFt2FBau3TTfiXPKSLC/lqy/xWRm88
	7RULLlLUcTFrjsSm4TiS39mzIl4bqpitim4A20XWq+TdFF9tyiQ2q/wt
X-Gm-Gg: ASbGncsN95kpPoBLsxsLn8nqKD4/eEQrgAC4M2oioDAAKxKHZhevOnIH/iP4lpHMjp/
	LOs8XR3V+jJYKJ4ymMA9sorS0X1i6bhT2MivHOJ7aCm0KYDTZQCMzJWRNYHBVoZh17OfZZlMri8
	KiRMPy+7Mn06G+rlkTTtuI55b90rWH0OEgv/QP3WeSVPsysg2Jak5dM7W5UrngzgYyiFrsmfndc
	kd9eT67+jms4fIFtnrdbVv/yQ4uN3Q8hpOKzRC+aILtSdWKFqUTBHaJLuxks436X0z2D90+19sx
	ThhyNl1FXvYsVO4WSuJRCub42XaBWZEjf7SEPH2veORGz0KsMS/x7zwMnj5Hpd+RhmG+3RBLrkD
	FFjHtiZfQ+o1YVgfI+5tnAeY7IgnMLHmvtLT1AI6neWku
X-Google-Smtp-Source: AGHT+IFBSzBHrD878oYYF5kKGavS67qgNolUi5Ck7EzGdSc891Ykev73AV+0ueAWDKAT71qdNTJHOA==
X-Received: by 2002:a05:600c:1d2a:b0:45b:9c93:d21d with SMTP id 5b1f17b1804b1-45f24ef20d0mr11997575e9.8.1757678932165;
        Fri, 12 Sep 2025 05:08:52 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b2722sm33750515e9.1.2025.09.12.05.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:51 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 07/13] tools: ynl-gen: avoid repetitive
 variables definitions
In-Reply-To: <20250911200508.79341-8-ast@fiberby.net>
Date: Fri, 12 Sep 2025 12:30:32 +0100
Message-ID: <m21pobvrfr.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-8-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> In the generated attribute parsing code, avoid repetitively
> defining the same variables over and over again, local to
> the conditional block for each attribute.
>
> This patch consolidates the definitions of local variables
> for attribute parsing, so that they are defined at the
> function level, and re-used across attributes, thus making
> the generated code read more natural.
>
> If attributes defines identical local_vars, then they will
> be deduplicated, attributes are assumed to only use their
> local variables transiently.
>
> ...
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

