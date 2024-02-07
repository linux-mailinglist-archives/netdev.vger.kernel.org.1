Return-Path: <netdev+bounces-69980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055AA84D2A3
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9191F22546
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B585947;
	Wed,  7 Feb 2024 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TpFusNdp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998651EA72
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336684; cv=none; b=g3ZTD2PzsO5JV/7vLH9x5HZ4vloGUdOWgyNaTzQFjFH2iR5CnttbLY5JtVUIH82sdN0WU5GFedYN5JSm1Yi9Nb39FUDlRVz4I5zOCIPTYRH3dFnT5HpWmcSys1qGuc0GOrWmCxRIB6432zm4gbVC5EmBXDs+PVTM9ztc5yanZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336684; c=relaxed/simple;
	bh=NQ+Q8H/U4ZfuC8lHL254K99StUSvVBudm4xIyBVMXrY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=DNPNBFkT+qY6JC/HaLhJupv7Swn3IFCYnAMIOL29V7VGABrpzm+iVS5Rp12YfHRAyuoeL95FN8JjbkEPIzSmXBcMwVRID/Pudb+pyxP/vxFfYJ/hCtUp54Tg4J3sxgeT7zj6eVU5bgzmsD9Xg8kOuv/nklFkDZArrQOjgS7wxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TpFusNdp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3122b70439so144850166b.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 12:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1707336681; x=1707941481; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=iU2dtQa1wZUe6n5r6nZoKzZeNqaRVQQ9jjKRwmP1JiI=;
        b=TpFusNdp5rZfzNGGhXyxmmpNOuLeT+HyZZS2xPdIFnQJGNnOoLu+I0jabtIC7e8J4E
         CDKfLhduZdV9RnxxNMpA3JwhWOR0d3lRnAxKS/YI1iKGzNfhj4ZEKhBOBtnINumvSa24
         1jmkXs6ZAovwA6C6DUW+WLgXyukPLEsCQ5KqJN9oraLb5D/AiwI78MIVoPa5VjhfdOfn
         kUIzPpHGYjb4IJ5/HfMZaVPYE4CRJNqQMMsH9geW7sEbS9gatHoeNqMANss3RmyzKar7
         FLNOtQSs4cJgu8+p1fomzm4MGC8dALbl9YCH44bjGsh2xaM1FyjU16nGOPPlI9H1yG4Q
         /DEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707336681; x=1707941481;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU2dtQa1wZUe6n5r6nZoKzZeNqaRVQQ9jjKRwmP1JiI=;
        b=rNHsn5FzHqpNsnisAnM6au5hFV2iqBvJl+UKQcukiGn0bX209Cvu/GtoB3Y0NYwgmC
         Q3NmcBbvbDLCvol7nYiA+hbCybGhnC0EsIFY0z1D+gftKGKKlK0bqz+NXZ1W88FkOdh1
         Wd8AkcTz+eAR+R2j5Etd5Tp16Itsf89ayaujW2DVjbVJvnbcdhMfqVy7R8jSC/rxPgRq
         z2pVOqQXUBgFKc7cOLQNc3dqKyv4ufty2yd8dkazgdajJqCzIDn9ghHpltkbmCg0lCRg
         X9WodREG6GhBaysWrxOBAmdtKvvYFf1pm7Eftih4YGx2qmJ9sktf/s94sOQEFQYuPDG5
         Nolg==
X-Gm-Message-State: AOJu0YxXZ2W/cdcw2Gv1zj7RI0rVul9xagtDXR3FIg8tYrbhmQskl3II
	NApTbLQsFum1n2KPIG6XxJvlDNMz16MkYuPFRUOSvOn/GmEZ7eSCEO0BO3m2lww=
X-Google-Smtp-Source: AGHT+IHd/o1KTzCJanFRhATo8F0Y2+BIPFr03c1L+fExxdaxLR1/g0AZoyG8v9LXPqirc100nXCIMQ==
X-Received: by 2002:a17:906:a14c:b0:a37:ff6a:744e with SMTP id bu12-20020a170906a14c00b00a37ff6a744emr5201946ejb.25.1707336680727;
        Wed, 07 Feb 2024 12:11:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUU0c4aHV/h27UMfou4JrSdiWEDAEMVDBN4LyqUg/onTIyVx5bJ3cbx4+nrHgtwKWNntf15uSpNRWnMMd9b06DhDTsIu9gKmuAvxLZ+uy/89qlYRflM+1Ju/nM90/NXeHAFDOyssyPU5kKlUHH28qOHK9z9Hlv5aY7wkZ6fOUfcBpIJV+sxiSquNto9v3BVZGUHm4ImjNvsrQw7QEeq9Cc8nQb4J1b2tIU=
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:83])
        by smtp.gmail.com with ESMTPSA id mm13-20020a170906cc4d00b00a37b795348fsm1094483ejb.127.2024.02.07.12.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:11:20 -0800 (PST)
References: <20240206-jakub-krn-635-v2-1-81c7967b0624@cloudflare.com>
 <20240207102410.7062dcb0@kernel.org>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v2] selftests: udpgso: Pull up network setup
 into shell script
Date: Wed, 07 Feb 2024 21:09:55 +0100
In-reply-to: <20240207102410.7062dcb0@kernel.org>
Message-ID: <87sf24qbkp.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 07, 2024 at 10:24 AM -08, Jakub Kicinski wrote:
> On Tue, 06 Feb 2024 19:58:31 +0100 Jakub Sitnicki wrote:
>> +setup_loopback() {
>> +  ip addr add dev lo 10.0.0.1/32
>> +  ip addr add dev lo fd00::1/128 nodad noprefixroute
>> +}
>
> Can I nit pick on stupid stuff?
> Quick look at other udpg*s*.sh scripts indicates we use tabs
> for indent. IDK what the rules should be but I have an uneducated
> feeling that 2 spaces are quite rare.

My oversight. ~/.editorconfig kicked in and I didn't notice.

Let me respin.

