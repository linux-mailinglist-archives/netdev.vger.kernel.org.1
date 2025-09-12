Return-Path: <netdev+bounces-222565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E5B54D4C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D6EA02688
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 12:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1275F32A80E;
	Fri, 12 Sep 2025 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9dImwKX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F05304BBA
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678939; cv=none; b=Tz3VEfx94h6K68IjsgIm38zFRdxz6rElvDDSF3vQqpshxmr4rd3bZLxN6GHakO29XefvfOKHyn7HfX0oXW0TgZbbtN7iIJDw3pb15kRhQBUVYfHtDXSo934SEfl1CRqVG6K7cOskuOVdrEc8KiikfSO8TZ1GXBOZGCJ4oZPTEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678939; c=relaxed/simple;
	bh=qQoEkT9yk1hood4SLEOpVCocbVX58h+NyrULhtXcu48=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=G3b0D2hIAd+p6B8qWA4PSnummFyTRNZCIdD99v/X06oraQMvFlciiLC67wW2RIvN5XkImwKvQSh2fYeuM1k4GoNzeCteV6A1L+ux5jrWofxwtal7egLmJ5yuilai1f+BgDf6o8xttth5MiL1E+h2Pr1vb+2IUokUhRBPdwl2sjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9dImwKX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso1481277f8f.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678935; x=1758283735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qQoEkT9yk1hood4SLEOpVCocbVX58h+NyrULhtXcu48=;
        b=M9dImwKXgcanwfxZsvF9sIJCNXhB2ttD4g7zrwMDyoS2icglni+By8MUnMRsKhbAI0
         EVO0xNVC4jQP9VBR53a/IUd3z3IYrNXYFkZb244n+39OtNq2r5vOhKcKivgSXlKPMcE0
         LmSYTExXTVrU4OzoRsDAAb09So/r65c9xRJuqzWcvpcF+pioKZs3UEtyWnisfpXGOpME
         vqoWo5Jbcuu867PYwrM23g6YZkXFvqRWw78xWhxXpcYOU2b3/9hlPqIOFOuLg6IzGirC
         c7Zu3bGXmt1iLKQXoZKSVmBHr4aANeEGzzUELjpq41ZJWNjKb0FSRBnOepBzy3pmxnVN
         oaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678935; x=1758283735;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQoEkT9yk1hood4SLEOpVCocbVX58h+NyrULhtXcu48=;
        b=wTSnpceIyv3o1u4Y1yEvE8ERSC5Q617IvxuRlfF7eI18D6wkTN5pmcfm2wFBmx9Oqj
         cp8e+u6YaAkEDKDNwFq2nAJCOZ5BsU2wJjqcueIEgRw1Fmb8y2eXqTw3QLYvit+2UlCm
         Ptcjq7RWMuxVK1DP2aOyww269txuYtA7pwbFZIgJr2BMjUiGVuJE8iVxRHLQXj+IXeki
         3V0fve3fV1lYis9off+4dwMBXuhpiQBq0ineWGmx8HICuJ8q8+BNR7OwD0SJUrm9k/d6
         tScvulMc6IFKG+lz0ccK310/Y1on6qLdEaQEdMbCu6gs54jUm1qGyK2PK0OS7qN1cVbd
         /AGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjn9zaXCmz3kAQkVLtpk9C6TEtC3AQ5Wk27dBLqKcVv44V1tf45XKVyHbqst3OcJYNT6yZXwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjdQBKRgm+Q0SmYOi1m8SxvVzYUfClWwqwXTbPksSjsV1hqVOD
	lY4XaZH/UjxOwetsF4W2cTqY15dHe3KmMqjuHxQZ3hsWScTiHzwcsFME
X-Gm-Gg: ASbGncv1ZINVJ+SldChb3di9qb/iTpN/pdAt+t/+z6gHg45NQ8ERgV+ODpJfWPPOxj9
	IJBb5qnPvefwNojGnfseW4Oegx6KO6Bs7Qk/xZ1DlJL4aVEqL82F9kxnQuvjqKbWhYQxqcfrYBc
	7ftGiMEDZQu1INYkLwFCzBnRevEYzRB5/xM31cQFfTla7bgQVAquRa2wRy7CXRkQMUjinBB2bG/
	cx7PKehA8UtHQEZTVQstmv6Wd0bT5F5lDX/cKF/Js6Y7iy9t7739zBKb696TtveO49yBEqxYcfq
	qTbRZUf2WWuf7mfGVSUacS1yyEwTbnPgXUfPpuD23XKgEc55kALCtAKhIEG/FbGShQdCNrhivhu
	QDbEVXTgz5DG429BHNmQ0RTyd3pkNW5QkfQ==
X-Google-Smtp-Source: AGHT+IGdPgp1eBnU7mdjQNbxPC0Ubxkk6H/dLId83PNwbuZGjICOtVkA1L5NSIQ5/V92tkMwWrjUnQ==
X-Received: by 2002:a05:6000:402b:b0:3dc:eb5:503b with SMTP id ffacd0b85a97d-3e765a1607cmr2924754f8f.56.1757678935109;
        Fri, 12 Sep 2025 05:08:55 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd43csm6153099f8f.29.2025.09.12.05.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:54 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 11/13] tools: ynl: encode indexed-arrays
In-Reply-To: <20250911200508.79341-12-ast@fiberby.net>
Date: Fri, 12 Sep 2025 13:01:21 +0100
Message-ID: <m2segrubfy.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-12-ast@fiberby.net>
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

> This patch adds support for encoding indexed-array
> attributes with sub-type nest in pyynl.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

