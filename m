Return-Path: <netdev+bounces-165510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF97A32688
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C63188CD14
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A09320E038;
	Wed, 12 Feb 2025 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ukrkv3Gm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A520E01A
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365446; cv=none; b=SOd31wfl3fOcuRx6hSqbPARX6DsmVVi3rE3kvlqHB95PJvXtSJUqumaxoBELmzHFykOs8zb56K74MxVFgRk0Whmp4FqZUWs+E8MZAy2wxwsnkm+W39LFKgwFk5E53wJCWKyQ3VnGYODVBQXG77n9ko0axkBTrANJfGxs3g2eZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365446; c=relaxed/simple;
	bh=NudN7JR4Wq1LwIjLqH5NKmHgW3zPzUDP7fyxBk8SYR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sixdFL37tNaxsLHHI5MiFDrP/UjxnM9xsUuaj9O8Kcwuyf2R4ILeOWG8DbJ+SKczD4cc49g0UAun8e3hgDndIoZNPmLqGtic+sVjvTaQSg53UFM+sdkrZHJYOa+9F4OyMiWa7oA/5poqVr4HnepAsBJ4ZRbBJyISQAv4+cbRJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ukrkv3Gm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739365443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NudN7JR4Wq1LwIjLqH5NKmHgW3zPzUDP7fyxBk8SYR0=;
	b=Ukrkv3Gm+Kqj7GLdHSgRqkghfm6b8grQQMzDIqczKqMW25fwn4m+kTxp9ivdCoBFOV6nEs
	y/Ld9doy2PvfSDQotc7C3FruGhPhbK7e1LQTlr/6+uQfooJuHWs5Udtu5qWuiQebPbuMs9
	DVFItxqcJNel+aihbqd3lqfJrHreVvQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-NYIePkKtPPOreKV4d8WADg-1; Wed, 12 Feb 2025 08:04:02 -0500
X-MC-Unique: NYIePkKtPPOreKV4d8WADg-1
X-Mimecast-MFC-AGG-ID: NYIePkKtPPOreKV4d8WADg_1739365441
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5de3d2a3090so5817069a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739365441; x=1739970241;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NudN7JR4Wq1LwIjLqH5NKmHgW3zPzUDP7fyxBk8SYR0=;
        b=CRduheQJfs/V7SM9Tc0BtlNSfINk/2JhKBGgobE0sHQOqW9lDIGyIP7drXHUHTuGgp
         qACDRJ2lNYO/luhdgI56b6j0EL8kUqXVAKxi3GoWmFaPreTvg1LgsoI31gZq6TbmOGnp
         vVDGifbg5uKbcgzOVJxPBwl9L03u5Davi7xKiTbR7feGgxQuTkgk4++bzcrq7wYEdpTo
         5hhIWD0EKTvMmWV4gm0IwOtCFbOjZTZPa7QJ2QNByBJFQkzRwl7ATI6lDf0wH+5gSwbp
         E7Tf9XU6FU+bZyRT9zG7kRpa7PJf6zdN7N0z73NTQFaUO3iCyVEgSR/5UCt0dcvNYozk
         2YqA==
X-Forwarded-Encrypted: i=1; AJvYcCV3nS0n1b9JzgGpkn5oCLmFVIPjm6dO44oQJzqXcgty5CKTRcjxHNtSWzPAyZ+hWzOJdF5zt84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zF8dlhzxkrB50S0XisjmmosDdNhQtN5fLT8FJEso4b8oS//2
	6eL36VIuWKtZUOhvdwTFCVVQUig9XVYgmguxPInldYzGCSqyF9LBgJfqEB/A+u+fiDR05QtVOPw
	UHwd+l4Jfhem+vYn2WvWnogZCGVDo1gctpQZefzUlpqzn5dLFLW4xgA==
X-Gm-Gg: ASbGncvouiFwY6FW7KirejaLG2m6ZQpOE4cd7EpJEK7j38jN/S8Hyd2DaejybYkzyqf
	YL4WesDeH9ezHwWLT4cQb2ChSo9Z3nh8Awfp5oON+COMRLgZ/FFHTNgu1h4J4UXSYTNuoJiN17a
	IPOwnMfbHE0Oug7OV8OhRFssUskf5gMaCGDc1ROkhr2WL+t5Y0aXCyUkqnVDWn0D3qCvHoPaoi+
	lpsE8CyVCGV8NWgy1B4DAQKlIyGFk1lpSEcRwcRY1d20SuQM7s47BK+oVcAUkA/DzxZb2e0+bBg
	C+sSjFTyUFCZSNamVHPLvTB8Pu+QhA==
X-Received: by 2002:a05:6402:40d1:b0:5dc:7fbe:72ff with SMTP id 4fb4d7f45d1cf-5deadd7b87fmr2623932a12.2.1739365440624;
        Wed, 12 Feb 2025 05:04:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/y6y8dqS+DDKRdgSCgtCqa6BcY3yBhSY2BkNK6IDJjKq+bMXCcDrtFZbw+JMsWeiLibntWg==
X-Received: by 2002:a05:6402:40d1:b0:5dc:7fbe:72ff with SMTP id 4fb4d7f45d1cf-5deadd7b87fmr2623444a12.2.1739365435416;
        Wed, 12 Feb 2025 05:03:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf9f6c1d6sm11253675a12.65.2025.02.12.05.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:03:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0005A184FE69; Wed, 12 Feb 2025 14:03:53 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Chandan Kumar Rout <chandanx.rout@intel.com>,
 Yue Haibing <yuehaibing@huawei.com>, Simon Horman <horms@kernel.org>,
 Samuel Dobron <sdobron@redhat.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [ixgbe] Crash when running an XDP program
In-Reply-To: <Z6yWa3ADgWmu+2TE@boxer>
References: <87mserpcl6.fsf@toke.dk> <Z6yWa3ADgWmu+2TE@boxer>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Feb 2025 14:03:53 +0100
Message-ID: <87h64zpb5y.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Wed, Feb 12, 2025 at 01:33:09PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Hi folks,
>>=20
>> Our LNST testing team uncovered a crash in ixgbe when running an XDP
>> program, see this report:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2343204
>>=20
>> From looking at the code, it seems to me that the culprit is this commit:
>>=20
>> c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
>>=20
>> after that commit, the IS_ERR(skb) check in ixgbe_put_rx_buffer() no
>> longer triggers, and that function tries to dereference a NULL skb
>> pointer after an XDP program dropped the frame.
>>=20
>> Could you please fix this?
>
> Hi Toke,
>
> https://lore.kernel.org/netdev/20250211214343.4092496-5-anthony.l.nguyen@=
intel.com/
>
> can you see if this fixes it?

Ah! I went looking in the -net and -net-next git trees to see if you'd
already fixed this, but didn't check the list. Thanks for the pointer,
will see if we can get this tested.

> Validation in our company has always been a mystery to me, sorry for this
> inconvenience and that we were bad at reviewing :<

No worries, bugs happen; thankfully we caught it early. Also mostly
meant it as a nudge to try to give XDP testing a more prominent spot :)

-Toke


