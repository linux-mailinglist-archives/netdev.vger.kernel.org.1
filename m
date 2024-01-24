Return-Path: <netdev+bounces-65401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0F383A5D9
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5951C28579
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F4918027;
	Wed, 24 Jan 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKYlWNh4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653A182A1;
	Wed, 24 Jan 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089697; cv=none; b=Ch2tF5xg838TqD6H0x+C1MLw+23ZqglouTwcuJyiAefhf1n3UhtPc2u8fWXaW+NrArVQ1r79op9it6rR9/Z7fxoK0KziHv2UreDZO75C21ycFpkx60vwKPolIvr6jt/axrv13PXyflX+vocL6G2CUfhEQ/5AZbYTE7ivk9q6pWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089697; c=relaxed/simple;
	bh=jSgW+tuqwKm+CmPEln02fUD9awdM0bDg/IZUqCxn918=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=h9yJsbKXXimakkIATP8XRFNR4JjodhYrkMTwR/JYLZ4YxSc2kuZbpCZtvnlFBnGbFkHsmcmMtersQ4Z7uKdVjahmBTuw1n1Adu4BK2MAxRX8KsQ/JGX5WY34jhu5kxDZUL/JhfJDbztunSOKvw2j6UTIJ5DzuhTlntRjxlWjlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKYlWNh4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso29813025e9.1;
        Wed, 24 Jan 2024 01:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706089693; x=1706694493; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jSgW+tuqwKm+CmPEln02fUD9awdM0bDg/IZUqCxn918=;
        b=TKYlWNh4qk7cLMsBWH0CH5RLuFb3f7dWO6k7buiQj0IL/91fGuBSDwQ0SV9dFtjETd
         CmOj5Jc8Dm1yFUSzikn52D98/i/lDKMroDX0Ya3SmCE6yjYlFZo2HupsX44LN/u5ra1V
         cQ/X6/PgJMGw18RnAeZ009PF/Cj/9B9oCTmN4dL3tIm4f2JmPzIuK6D7xP/en8g7DlSu
         jfYdvc4orhmqLx+c3s7Qbw8c8at/2fPQVIQ1t+fmSfiWwhkxm3aqouPOFJxagEopnfwa
         vlzf0vwDAnJEQDR89qLAfq8bp3Z2nWB9vlWIwMLg+seWFjeLMk1KO7V3BvyJv+GVFpTe
         ox2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706089693; x=1706694493;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSgW+tuqwKm+CmPEln02fUD9awdM0bDg/IZUqCxn918=;
        b=UxH6G2l5YefE+YdvzVwOg4qbh9FnvBHBp5ZhlAt4bpGDdMFjrkksrG1qTTSJLLEpYp
         Pl5VeZqMfWL+scNCPFYeBT3NkvPr2NKz5jKkoyTApRCIiSpjty+f/naJ6nnxJi8hRjgY
         MkJMVvT6gdDiB8khfGNSFQ0CfAx3OUMdyNKd5ZCg/JJ9+0qddmLPprjyJbnW79okOI5q
         gEoEQZl0wgB/ilEfINl36Xd/BACqFDzYqCawX+URyeGRAH2OKeKitIC4FZVnP3mdsQ2p
         izyn+YJuwUpRQqSdX6K6II3PUfi94J/aHa1XCB273uullKmqpqqUPptrENh8MoeLd3Vb
         TqDg==
X-Gm-Message-State: AOJu0YwdjqPREuNYOeoQf64czzY/c4BvOiI03meSX7k1+STD8KQyOuYe
	7krtPotygxeqPq2+FJvwH466xv5YGPeNsO9fgoFq9dlNHsOT8Voj
X-Google-Smtp-Source: AGHT+IEQRfNVYg8dVc7EYSjzhqzsPjoejs2P3f/MMpYgfgQzG01oF9++jIRwVa8s6TbMqNzf6mfzZQ==
X-Received: by 2002:a7b:c303:0:b0:40e:62c5:4279 with SMTP id k3-20020a7bc303000000b0040e62c54279mr515751wmj.104.1706089693378;
        Wed, 24 Jan 2024 01:48:13 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:bd37:9ab2:c68c:dd0c])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b0040e451fd602sm48854456wmq.33.2024.01.24.01.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:48:12 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  Breno Leitao <leitao@debian.org>,  Jiri Pirko
 <jiri@resnulli.us>,  Alessandro Marcolini
 <alessandromarcolini99@gmail.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages
 in nested attribute spaces
In-Reply-To: <20240123161804.3573953d@kernel.org> (Jakub Kicinski's message of
	"Tue, 23 Jan 2024 16:18:04 -0800")
Date: Wed, 24 Jan 2024 09:37:31 +0000
Message-ID: <m2ede7xeas.fsf@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
	<20240123160538.172-3-donald.hunter@gmail.com>
	<20240123161804.3573953d@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 23 Jan 2024 16:05:28 +0000 Donald Hunter wrote:
>> Sub-message selectors could only be resolved using values from the
>> current nest level. Enable value lookup in outer scopes by using
>> collections.ChainMap to implement an ordered lookup from nested to
>> outer scopes.
>
> Meaning if the key is not found in current scope we'll silently and
> recursively try outer scopes? Did we already document that?
> I remember we discussed it, can you share a link to that discussion?

Yes, it silently tries outer scopes. The previous discussion is here:

https://patchwork.kernel.org/project/netdevbpf/patch/20231130214959.27377-7-donald.hunter@gmail.com/#25622101

This is the doc patch that describes sub-messages:

https://patchwork.kernel.org/project/netdevbpf/patch/20231215093720.18774-4-donald.hunter@gmail.com/

It doesn't mention searching outer scopes so I can add that to the docs.

