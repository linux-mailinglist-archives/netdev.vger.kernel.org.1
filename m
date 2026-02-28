Return-Path: <netdev+bounces-262145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA8TBKcAo2kJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:50:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B25F21C3AF3
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CC7D30636B8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A484744105F;
	Sat, 28 Feb 2026 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWlxIRmE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CDE441045
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290212; cv=pass; b=AeCMxsKKfa3ZVTo52fcPAJDa95Iv/IeSCc/3iEOs0cdlIHR5ockn6tqOGJ3/yJvrgbgr7b699+cqK82U/ZEocLsU4y75aVlOuMWV9njyP0LbP7tsbGVG9Re7CN5JYGUWkIIKXiqytMBOqbGxEaXNCISQBUGKHCkwYwH46SpdX8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290212; c=relaxed/simple;
	bh=jT/gVDmAU7mgZgNDhZa1bpN9ckZxLFWvPZeOO7fR25Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjsQirSN1G8YeXsVeHNlyJcF18ANjiN293F3017uNCpy+A+91VbrFo9kA1QBtFyapAn+UqnvS5gKO67pfsbgpVKhz7+AwryyvSjc/dIjy5ZnhL85fd8cCn83Xer5pR4lD3SK2r3M4ihFTlBuGH41RGe3xHfZoVUmYk5rJ4fDyn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWlxIRmE; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5069b3e0c66so57343821cf.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:50:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772290210; cv=none;
        d=google.com; s=arc-20240605;
        b=GVY7V2efBS9VNkekM5gd6STj4yyhKRCuOea0OpSdtVtlM3d5iQOHXtkN7zxXgBw8/1
         48FC/4s7JpuRJTdz+PWdAOxeP3ZDu+TaLmCRSxHVfXUBjtuDSYSVr6YN1w7L90gX+LFv
         9wVnG42e6WhbVRN+R+Nz8A7Zfiz9IWAaYl9WTqKu1F+PvQlJzzf2B8tm0kkRBs3UWKLg
         0Ke8S2brMoL4ruuqq2ykjCK+wfOVinRGaMLpQtb2O/1/sAD7HWTailByCv8nbM8ZDjb5
         vjBXzAGB9u9vPg/A3NrV7FjZ1nyNer+6TcJiWvQoFURwnTU9EUuUdCKXlstRg4mYLscH
         X/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jT/gVDmAU7mgZgNDhZa1bpN9ckZxLFWvPZeOO7fR25Q=;
        fh=sz9bOxuDm4H143BGfs0ifMh0ymPrfA8BRIz5he8g8HA=;
        b=PEWQykiXuyOKt/wXZ0Wz7MmL/Nc6AsawBYiML9vHrqeZsytIbNIKJdlFbgDdy890Kg
         zlHyI9GDsfnhM0REQirKTzLylb+Al+Bol2eA+KwP9ZFXhE9EyPxPQJvuGKpYrzLDtrVy
         lt+C0vpX0ggUDvMiVizcH+QLwaTMnnbL9/myE3GSlr53ATtzT/eK2ys8jrvWxAFcIp99
         nvUP7KNO0hxOCgoESUUIEYHi+cZD5P3yY1XsAY//dPvnoixLyCmG6mXM9q9mEEugw8d2
         WsdLfonnOE32syyNsvvjtZa0pLBMXuutLWWEXMHX9dW/91+9uH4z4dCIcYHN/eB/oYiI
         QRJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772290210; x=1772895010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT/gVDmAU7mgZgNDhZa1bpN9ckZxLFWvPZeOO7fR25Q=;
        b=wWlxIRmEsvx//5WTfcZI6+0BHCXy77HW55qW31L3CRpv9UxPC6UOIKly/NvSTlR8hw
         owWy6xk7cj7qr3l2s0vy6fAinOLn6Ab3HjAS8afXwPGCdNCOlmytdQLb0j/+Xv4KKTdz
         bj9NN7XKgzwx/zUf4QKH9H053aPZF3OBZzLjaGLIKY7LdKssGZNIJlhwBA9Cwp4mXW0I
         I982jtoN0RxpPr4iU65wNw+EvXJ1EXKzC2q3DRpo6/5BvFXEuYi45CRen2xpYTINAhpp
         cZn8MCNEjt6o2AxN5OItAF33r7HDCHwRPT6biBYney6QDtzqKIklmxkDZFBLlnLKb7P3
         PA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772290210; x=1772895010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jT/gVDmAU7mgZgNDhZa1bpN9ckZxLFWvPZeOO7fR25Q=;
        b=TL32AwjNofCDUZ7Uhm3uCS86hKoRtX4NOLaNf7i7Fp3QQqQLNKT0GzkKn1qVzHSlz+
         vHNq9gTSx6c4FTOZU0ypW7m6iVa7eLlQJBT2IgiUYJPWqjxCtkP4LStdC5jHN6RhvBWi
         uNM8J/13WiZ2CbDMCYK2l8+x4rVtFoEOtpKCv5OEk7ob8bsHSJeFp0IehvMx2fdCzsMe
         +oCU3wjr7paEGYg4KTtpnnu35jfiZbR/doRB06Qjy+El/xDgcYje5T/dnrzIctps0nls
         kjOW/vGF1BdINsond5MSz1pk4Xwwu6qET6HnaxyxPzcwr5N3YT7liMdtmiku85eVziz5
         3UTw==
X-Forwarded-Encrypted: i=1; AJvYcCVQzG5ICBwfz4YmYuUH3v2gTvjvVl6JRLQX0+/56pxnFrzpCVZzd5LgeYN2gY1cnTjs81mibaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCG83R+WMoTuLcrRe7p691E83GysAyX4EYoqR1RUJnhTwJS661
	oMDuUahC6jg/B4pIT67IrldCdlY/1hZEgVe+ob4PzdJCipDWiCuE/VHIzy78sdmXGMyXuG0Oagh
	qF/IFByJABJIHHFYYt5WUQHay2nzDV5W/YJoXyu/i
X-Gm-Gg: ATEYQzwyx5FSAHtW5o4og/SiocWMQJroefnjeC+5c1neAfXiBLiQj6rKomOQDXnLBQS
	dwhCwdEzNi4FZJrwkZnWptqfPUfo6NVz9mYyQxPv0I9b2kK6mGGt+jAApqz9uL2H07k8+N4upVl
	aNsD2C6BcWm3v1i1LBbZVfvESiepOOMCWFg1Yz04TsCkbbKQ9DsaZmSlzNwMggfuNJsj2y6XzSB
	V1dtIX00gSGpTdGm5FZ/wXz3jVsEaFBPZ1Bd7yIPU9oj9+n5AgzR/PC+G7r2ay1HwPiRvmxM6St
	W2+0esHy
X-Received: by 2002:a05:622a:509:b0:4f1:8bfd:bdc2 with SMTP id
 d75a77b69052e-50744461c41mr140249881cf.41.1772290209726; Sat, 28 Feb 2026
 06:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-8-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-8-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 15:49:58 +0100
X-Gm-Features: AaiRm53sfeUDKDGbL-KiLMYcDpHX20rZYKHQzZ0Gi3INpUWMp0IMcZaZJ4BQ8OY
Message-ID: <CANn89iKw2cS6_hNTbiUZPA+YB85GEPxxJVMjTckTj5mLMyTcrw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 07/15] ipmr: Move unregister_netdevice_many()
 out of mroute_clean_tables().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262145-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B25F21C3AF3
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> This is a prep commit to convert ipmr_net_exit_batch() to
> ->exit_rtnl().
>
> Let's move unregister_netdevice_many() in mroute_clean_tables()
> to its callers.
>
> As a bonus, mrtsock_destruct() can do batching for all tables.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

