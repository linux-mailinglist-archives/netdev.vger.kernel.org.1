Return-Path: <netdev+bounces-251327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2842D3BB0B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 23:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AACB30285F4
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176727AC41;
	Mon, 19 Jan 2026 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6FNo7Jk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A21500972
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863038; cv=none; b=NocUc7DRM9ByjeFUIoZlmzkZzKxYtswoxDPYLnwBktVsIrXlKIvLtPJz9rtWT3Jgu4urUnoAhykfuXucVS7zINhzucvp2jwKKTThfqiG9jQROD2lUTg80JBtNRj8pOq+Fsc81qXKUNWuEO8FOH7/wrF3lLfA3d3PYKBEeCpqteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863038; c=relaxed/simple;
	bh=9c/vFO65FtJ2jCWO5X5epWOjQy9Nm65EfqXFuA1fjBo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GDfRmu6eTzf3+j0zzsjVlnkNBGS3axafC+nZ0/8Qrk3qE79tDwcEPRIxZjFdpJwwkmAeQBWmO7tw+fVKISZlpU33AfAm265ti9aMBnXmEvTu+4dms/afUwAENjKVyLgfcfXY92XE8jD3zz76FK2FPHyYtRSgYxCY+BYm5CE56dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6FNo7Jk; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ae38f81be1so5384209eec.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768863036; x=1769467836; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9c/vFO65FtJ2jCWO5X5epWOjQy9Nm65EfqXFuA1fjBo=;
        b=C6FNo7JkV/gN9UL3L2ompNX0I611ibO8sAht9zvwGhgMNZF0vibAEuB2g835HNe2Zn
         Ifv3MCBzN3pjLBx1W9V9iH0w7ztV7zZ0aehsaHFCU9pQFjrZ1iWmG+IAh7QoyhXFWunv
         yNOMv2ggl2qU1orUySzmhWiv0Iug1vZ6ysfEXk9y/FwBZJHPwoGdkQMU09o5I9zWmhuF
         sSXUnYdov/hULMK0uQtfUCuCY/vqCiA77krm6+YJ8QI2Ao82D3CxajmuxOUkRDZLnyY/
         ik/fTIfTT8MDwzXpqfArpU78NxNuwP3iotLjMIWSNyYtQrBn/StHYsaVpt/yswdqUZYE
         Zb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768863036; x=1769467836;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9c/vFO65FtJ2jCWO5X5epWOjQy9Nm65EfqXFuA1fjBo=;
        b=agdMa1CDi857atGOl7j2BIn8y114krfupADd+XGiS0sGZHixZk3vVF9QsDrLgSuIRT
         q9CiR4Hg/psjkSp08D/jp5x75A1fRhfAfYH7H6AVLyAwec1R4ngLkPkx9mBGETO8I1bv
         M2PIURSzkCpgfUfA+XSoFuFsb7JuAV0BF6Nppq9rWf/6ZiBcF4uhZRiVQUXt3rJpkUdP
         dwWI4Kl68tN2LKBGgsM3q6UAw5ss88WLnzYglL28OhKK1sJ5YkmuZ2WZJQb7Pyw13r0y
         TZc8MGjSwvpKbDKGqpUEJ8KD69umIMeQtWNI/3dYLlpVrl59d3ywGpbvI4yBp4wPkrdk
         xFmw==
X-Forwarded-Encrypted: i=1; AJvYcCUQbbNuocg+GtpCKpc1cZfOuHXTnjyYqAZm9gGZea2qn6BdfBZRVtSD6E1B6WKR65gyDpSFmOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwunxoFWg9atONcyrgCCe5kvVd5/BxvRfcBuXhBw46mtoU0jKaS
	mHHtZf/rlMGC7GMEGrPTt5Qu9ulLRMEHw5r1wsVUCB39nQLgWpsRYob/
X-Gm-Gg: AZuq6aKPXfBkr3WKzsZE0oSmya01H+4WJRNOcdkJVyIEYW28SSgLUQEj32o59h2hTkv
	AC0N+bNlWnMsWtGFK/AyIuqgxRNmKE9sUIZsTGx75NG8dqMEMPXYn4oWKayzgc0bnb8EkVXPTgz
	Vv1/sXdcuPLDYCvpUvz8gacB5Wsvj5wNYOS/INt6pZ0UgySZa8KaptFwzDcQ5mwn7PSE0SpmM6W
	/Ubc/1kKig9d1lF6QSq75U7tHo9ZYhwKV8GubVtx3LD0A90thKGmoimcWwyCYWZkcB8I97G5XHL
	NzQX5/iXBoE1xhYA0Un6CNDW9te9wpgq32bFXHNJBkMNPPiPn2BsHEQsg3+HLJAkJuxVYuIpsFt
	ASAeyLU/gnSG6UpuWASyvCJcC9/IU4mfOPHXJm4FjY309J+BIxwiikWk8woL7/IPA4D5O8kC4Q/
	AhnhMM7nMvO+BzqNOSInvjhIXsW9oqHlSibwXPBYAbTTpMVaI+Pbgm3iyEeqk76nzQow==
X-Received: by 2002:a05:7301:1687:b0:2ae:5b32:774 with SMTP id 5a478bee46e88-2b6b46d2a6bmr12941699eec.7.1768863036298;
        Mon, 19 Jan 2026 14:50:36 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3651f39sm14825179eec.24.2026.01.19.14.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 14:50:36 -0800 (PST)
Message-ID: <b77851c851550f8b932fd2fcd85cb85d16abcbf2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: net_sched: Use direct helper calls
 instead of kfuncs in pro/epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Amery Hung
 <ameryhung@gmail.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com
Date: Mon, 19 Jan 2026 14:50:33 -0800
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-2-e8b88d6430d8@cloudflare.com>
References: 
	<20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
	 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-2-e8b88d6430d8@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-19 at 20:53 +0100, Jakub Sitnicki wrote:
> Convert bpf_qdisc prologue and epilogue to use BPF_EMIT_CALL for direct
> helper calls instead of BPF_CALL_KFUNC.
>=20
> Remove the BTF_ID_LIST entries for these functions since they are no long=
er
> registered as kfuncs.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

