Return-Path: <netdev+bounces-68326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73575846A16
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7DC28B2BE
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD017BB5;
	Fri,  2 Feb 2024 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5quuSBu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2C818622
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861006; cv=none; b=ceVXj9a114VPvc9pz5HaoYbnQnHUwwKQNudBcMdJ4RnSyrD3JdSNEGHO+Y101IEXkkPY/MC5balCqOLyfaDyj0sNzlC/Dcw56Jzd5s7wSKL9RUtMNWIhSdhyEL05zCr8+Ny4eUjVmd28jsoNSA3SrZYdv+7E4wgUI5SXztzo6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861006; c=relaxed/simple;
	bh=0oMylLbW9ZNzwTzwnz+7++Pst18Skg2vbTJYvge5Uck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8fWuzWMgY8sGXG1oyJHX1b6HTtdNkVbEIhoxjM2juYmzLnNWAZyDIhvLZbmAHSlB+lqXYjYofedKQ6ISNTbvBPCzb9GjD5py5/rOCdOH0QUIuDQrYzoEzH+gkbvcQV8VBmhvOPIdVCbluWBbiVtfNZxxU0237NIEtGWB1oJgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5quuSBu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso11465a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 00:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706861002; x=1707465802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oMylLbW9ZNzwTzwnz+7++Pst18Skg2vbTJYvge5Uck=;
        b=P5quuSBu2zQQoNZgqkrQea0Ser8H0BfKfeeCq044rog7Qg3H1WfFw6Og+Z8KWLM2CD
         lCGvxeJrkrvDBdLPBlaCqFZUghqjUVv7VcNpftyyG79f9lS83WrfNAhPF6bZioIA6u4c
         tdKsGogoX6rWFd42sAfWSivKLP0t5CevzYHUZWShinOMHgtGuxa80B8s//6qQv5YkNur
         0qVPujP3FJrS/XzedyTGxgBpN2Hm/nY5ojQNJFdxhgv56K51+PX2BEEGSdlayNq6tG/Q
         dApUZ/srIU7qhN2RxLjeM3QTgLyfTWwkwpaRVZOaEa5BYn7ukD62p+TE7h4uA6Mxo6m4
         6D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706861002; x=1707465802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oMylLbW9ZNzwTzwnz+7++Pst18Skg2vbTJYvge5Uck=;
        b=JaCmSe8VJVsxmKVE2jGxvqo8LxSCCb38f8+NRmVkw6st4Fp3m91iwiUbq/tGxJ7ZDM
         4PK1jfPq5Wm7pl6su9n+Ibp7uwJqMhp5ueYos2uYAdHONedafLai7gny8ZFUeeW1Koeg
         5jrP/owOEPqj6xnBkSbN5y5v/csOCTa0g8WrBXrIStBiinm+cUMFSyIrv8cJM9Z6t5GC
         xGQVsvKuohujTfDckCXZBEk8dqhusKxRwdw/XtD/rakLeNVmb5MFsJWXwZ2FULiXnOKr
         pUg2T71/K369WucuveJUmBd3XyzzLh3K5bwZ816ZerZx69JOJUOjHYSUuNn8AUpU3QLG
         0mtw==
X-Gm-Message-State: AOJu0YwNnye56OJywWi/EW99/+WwKmN7Jbv7Y86qTGN/5EjdCVD+xVYJ
	2qDSYXJj41jvXeyPfv09WTzp+M5Z62NpZuxem7rWZGyG6yb4bwhBb7ZxAUISp7hWxSSrcYeqWlV
	h3WrpyVVyaJIOgII1hAdvA9Zpz0OCCYDn9JKp
X-Google-Smtp-Source: AGHT+IEq8AKlbi9wI/1/P6iW/rfXtlvDdRL9SHijXbQoldby6jTh5exdKZ35PszRJShlBF0XGgF7iezV+6yIO9aRYPc=
X-Received: by 2002:a50:f689:0:b0:55f:8a86:e694 with SMTP id
 d9-20020a50f689000000b0055f8a86e694mr71013edn.3.1706861002332; Fri, 02 Feb
 2024 00:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202001154.414386-1-kuba@kernel.org>
In-Reply-To: <20240202001154.414386-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Feb 2024 09:03:11 +0100
Message-ID: <CANn89i+5Z1_t3OX8pNeVumq=QcErqnVLx9L=rU8GQqDTwfFq0g@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: netdevsim: stop using ifconfig
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, horms@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Paolo points out that ifconfig is legacy and we should not use it.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

