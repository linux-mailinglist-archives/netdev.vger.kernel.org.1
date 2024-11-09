Return-Path: <netdev+bounces-143519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029D59C2D6C
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 13:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E81280E87
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEFD172767;
	Sat,  9 Nov 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0mafFrYG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA446145B03
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731156862; cv=none; b=jNmjA+TORMv5H42EudnGfmSdQlOrVAFxSys38GjiBP08QxG9eIq47irqxFJgWU3tNpzCTyk5BJA9Ji2vz/eosbe4jc5k9miVoCE8xCAuGXAfAjrJPue86GVmukcIjFCn0sBpx9uInArF/NNljzJ9AubTtc+qCzj5cHomE29XJUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731156862; c=relaxed/simple;
	bh=riNaBshRzsiEhTc6TxzlZtwNVOz2+HvsC3y5SEaJV7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdlSaEeIwZLiIm82dHIAS5H6I3US4+QEWVOX1FwOwScIxJ+vDIThAjlqxnjHgmfrao1mh0MLvwvzCysgRJJj0LY8uobNnRAM+FTKgiGU9tGnhHHaE9FpuTcFSjoiNnVk5SJw/i0OvpcuYivby//OXb9sfakGXebeWvaFRlZLr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0mafFrYG; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso2154648a12.1
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 04:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1731156859; x=1731761659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYaLtYTT4J5qwnVglfvE9xSmn+p7MZNnrwIPzK+ebh4=;
        b=0mafFrYGmyinJ+ABN8/Gb2x4LOnIURi+mM6NCdgk7xiXQdULV+630PLs8zZRTQsQ5C
         OmFEYBAAR4yJecrrI4zQHp2sFauBQFigWX9/6j+dZLSagPILzQ7TEzzwNkLdGZ2J2Kfz
         5XGySw95VBY6ijUgkC52OgkiqtQ8araeISSgGvWxGSgQRgh8cfSualpncXj2ucZs4MtP
         F2kjQr1f3ASF2XVOuzaD/cnNca7CElTDWnOeqx5Zu2otzqN+r0l/kbCnNxBUAmzxCzAz
         or+1eqRKZVeWipTW7IilCKgwe8Ya17yMFhejoQaCH63sO2SfJoPxm1RatY1GCRzyQrMt
         gHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731156859; x=1731761659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYaLtYTT4J5qwnVglfvE9xSmn+p7MZNnrwIPzK+ebh4=;
        b=rSS5ZbwoJr/BNTtos9NMP3XibunfNyGcNwioqWGpBxdERQdNTUJwfketNwU75hJ7oB
         UC7IB3Z69G7dZpeTQQNHi8nerlHllJsjU4S9apLnKhhEJinq0kjm0v4q9aP8bNThqybz
         FKTRkDK/rrVy+by0XQdvNHQUb+4qyW49LG3KGakbCjlY9NWR4qgTd84615tpHFdKKEOc
         LMTLwVcw0GKTsg1oEvVhgsigkBDgZ5gmNLCdA52MKXwgtgTEUDVNOGqpNfJ9IJ2YxL+C
         2BxudZ9VtlVrQWzj+QPivzPeDCaq/yHbGTzqL5w0T9Etbyruu5YgSODL8KLndII+AbdT
         gE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMn/vhjWg7MrEl40nig6HwNETaWeGZYjoofim8ijBVLChw3OHk/qYXqYx+FS9Gb6hZkPOkjVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuvZnLvlvjeW3WO+DNDhoUqtDp9m6ZedtkFJNpEk7NZYRVNgfU
	6jfuKIJHCha2Qm1piXld2QheRBs93Y6uIWvVBh+vLmB3aNBXQD+RUQy1/WWHObbM+U+++gk3d68
	mSAZRhdC/Je5f7W/E3uU6uRR6ev3Lvg8gqRYP
X-Google-Smtp-Source: AGHT+IHMIUJxoUAmD9IGbWlrwdzkxOjIAIPZahQ5vh3HEhmmhK5GRS6UWr5tC/oKuWqGsF1S1mWq5U4WlEzYpCK8hwQ=
X-Received: by 2002:a17:90b:1a92:b0:2e2:c15f:1ffd with SMTP id
 98e67ed59e1d1-2e9b171f18amr8454212a91.14.1731156859007; Sat, 09 Nov 2024
 04:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108010254.2995438-1-kuba@kernel.org>
In-Reply-To: <20241108010254.2995438-1-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 9 Nov 2024 07:54:08 -0500
Message-ID: <CAM0EoMnnt98Go3px0YD3-WyX7gdkY17bcG8jpTYbjPMRtK7tCg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: sched: cls_api: improve the error
 message for ID allocation failure
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, Simon Horman <horms@kernel.org>, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 8:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> We run into an exhaustion problem with the kernel-allocated filter IDs.
> Our allocation problem can be fixed on the user space side,
> but the error message in this case was quite misleading:
>
>   "Filter with specified priority/protocol not found" (EINVAL)
>
> Specifically when we can't allocate a _new_ ID because filter with
> lowest ID already _exists_, saying "filter not found", is confusing.
>
> Kernel allocates IDs in range of 0xc0000 -> 0x8000, giving out ID one
> lower than lowest existing in that range. The error message makes sense
> when tcf_chain_tp_find() gets called for GET and DEL but for NEW we
> need to provide more specific error messages for all three cases:
>
>  - user wants the ID to be auto-allocated but filter with ID 0x8000
>    already exists
>
>  - filter already exists and can be replaced, but user asked
>    for a protocol change
>
>  - filter doesn't exist
>
> Caller of tcf_chain_tp_insert_unique() doesn't set extack today,
> so don't bother plumbing it in.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

