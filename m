Return-Path: <netdev+bounces-89511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC048AA81E
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 07:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56369282A75
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 05:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC92B666;
	Fri, 19 Apr 2024 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SddP78V9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A179F9
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506264; cv=none; b=DYbo9EaDJMTrg/kHo9Fv6MEG4ZhaaTQ6zF0VNuX/T79mH0L+wzBWke92EOZQ3J19Lu94GBVAqla9NYmFsLLJRuI+fLFCAPtwWNEbXOATXFhADJhYSQIZV3Evn3O0KktHI3JlUzaNdwOOEh/+/mZVbMCFFyZyahKuiP29VVv6x20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506264; c=relaxed/simple;
	bh=dlTAgZT96WzE7WnsVXl4qw5or+/+Qxdzc/ANdbehW8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1+SNc4k5Hs54AmWvJ+hDzQCm3lXfuqdp4xUmWbGPmXMTWFAo8831Z2xjaGFl0gvSF78QtcGrxKEBhhTIyvCpS/6re65KihDN85tfnxmpINs2XzywVupgu+R7A7kbQ/+6TCeJCP1tN4BtQ1+aLfRCfwwzTlU820Q3kPv90VlqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SddP78V9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-418426e446bso30805e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 22:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713506261; x=1714111061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlTAgZT96WzE7WnsVXl4qw5or+/+Qxdzc/ANdbehW8E=;
        b=SddP78V9TcBqxDsilyZpfzcLmCpxuG4espYfeQvrK3BnveIaJR/92lvHePW/5NTaJw
         fECm3z+jBblf0851WQHhKoLRld3WgEBqjUbiK5g8YV4biWhOasS9vcosbvFNOF4akgig
         iveFGnXagFjY2DJ506AxYJHhcp+ErF3r0U2OZEmHgF3xJfJw4cwsWB+9uKDIF2F+/8Zs
         Nl2Cbei+JKzvX5vKwiLnsF3rWkyuvIjR66CaKWerK/27Eof3PMvzkK2eXfmgRg1tR1Do
         vNThM6GSQG3wugptf3q3hJvk35JMmRpeaR4tGpn1C6sSy/NMHNuRKdMjm3r2U3Y4dczp
         gvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713506261; x=1714111061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlTAgZT96WzE7WnsVXl4qw5or+/+Qxdzc/ANdbehW8E=;
        b=IvzZWDAKC1OtKODo2PcAZiCpQHbrV8jjUepZqdrfx9vkTgxmg5VPYGtTgacbs5BxpD
         0mfK+ULB/7PpOfgchCoN+HFajurFPpxKzlN967kv6zvQvNlljdbXIJpWarTE157cLhBb
         S8NaIAe01T3wEeUuJ9YSZaPFgL9hRoNxMgBAXv5W8y4mq5ZfbYpUdAB/STRqezCs+kXG
         /O9FBqPsle9RHvygIRbTO7mLsnFKum+saDqosBHfO6mv/T6f8U65GpOVbW0YuwEMAaPH
         5mvyXpiyzfqQnB72Cma+BuZmZygvGava+63fsWf7oypbPum9vQZzAkIVzzPOWo9+DtdT
         OZIw==
X-Forwarded-Encrypted: i=1; AJvYcCWS7bClEOgPFzKn1H2luAsOWoR68YZQfv9++QBEYUPWtIDv/gxWRqUqj7mDt4GVu54Opl51n/B+wFhpijXQudyJZnDuW4b0
X-Gm-Message-State: AOJu0YzkTXr33xXlZK0WvOZWWuwEgBKL8Nl5VxYl7SZSyol3rtTHiZLs
	p3HQlM4bF71sNTnmcIKHcaRW9QceMgAe6aCDkKhH/G8y5jiIygVQLp+TDcgJyaMPKAoJB+wk4H7
	9SvldLZOwLBLUiRCO7T8FeY1tBje1LfbljjxT
X-Google-Smtp-Source: AGHT+IFxuQ+YE5BU3ogNCeglAUQgip/y4/zUnbuVO+BUR09kO84zH2IHQ+6Yn6cuQ8upXMbmxagWMNbjEgv6IkiHxdA=
X-Received: by 2002:a05:600c:3b8a:b0:419:b16:9c14 with SMTP id
 n10-20020a05600c3b8a00b004190b169c14mr53756wms.1.1713506260596; Thu, 18 Apr
 2024 22:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418073603.99336-1-kerneljasonxing@gmail.com> <20240418073603.99336-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240418073603.99336-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 07:57:26 +0200
Message-ID: <CANn89i+m=mt1w=ooOzh71sfTjTaTDZqB2eff_ki5DGwrFU3kGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: rps: protect last_qtail with
 rps_input_queue_tail_save() helper
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:36=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Removing one unnecessary reader protection and add another writer
> protection to finish the locklessly proctection job.
>
> Note: the removed READ_ONCE() is not needed because we only have to prote=
ct
> the locklessly reader in the different context (rps_may_expire_flow()).
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

