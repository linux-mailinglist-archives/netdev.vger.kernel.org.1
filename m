Return-Path: <netdev+bounces-149043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B655A9E3D6C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771EA280FC6
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1D20C461;
	Wed,  4 Dec 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcJLKbdM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931420D514
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324030; cv=none; b=M4tNOXSa9RILRv0ZKqZYxwhh0rDC2dC/Z4WErEdFMYXrET+Um7f2+5ezsJUxZ50HSysIk+i67sPUw9NLaeL3JMNTh/SjVOAYXEc3nPOjoO71tbfoPDRs/VlfCjKc3+hxsliD6XQr/0RlBFyGzmH92GIJjQB67Ww0QW9SFxHT5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324030; c=relaxed/simple;
	bh=K7kBGbl/wdP2nCgoFHgNguRbgX9tLrTyha54rTPE+sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRx738t9dtflthoceQPphdlG0YoAthf5nV5Er6N3VeeOob9PIKJZaagZcEf35D8zzQ5r6B2iM02ae5tdVs5Q71WF8JAtEVW4cvu1QPXAAs3wawA37Ajg64rI7a0yZhEyWjaes2JXrROKNC+8jf2VV8Z7DU1G1//uFlhYMb/yXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OcJLKbdM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733324026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7kBGbl/wdP2nCgoFHgNguRbgX9tLrTyha54rTPE+sk=;
	b=OcJLKbdM+VguAJilLK0lv/E0CLM9YnvjqWMNHySZedzGHawMwBokNPx15XXJlAcVTcCnnk
	6TL+SuqJll7pOSqLaXoUF4f6gKUc9XKWG0e2EKPUjlx3wOmfjG+qtEg85BOPR0d7TGn/f3
	EsQR709MI6WtduHXrRj0kuB1qpMLLUM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-wV6gv0THPcKK7k96ViL00A-1; Wed, 04 Dec 2024 09:53:42 -0500
X-MC-Unique: wV6gv0THPcKK7k96ViL00A-1
X-Mimecast-MFC-AGG-ID: wV6gv0THPcKK7k96ViL00A
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-71d557437e0so4394726a34.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:53:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733324021; x=1733928821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7kBGbl/wdP2nCgoFHgNguRbgX9tLrTyha54rTPE+sk=;
        b=agfGyrbGH8zcEw03yuEbh3uoVaDx3UuPCtgyun8o5lljzaAfO7etIdXan401LkFSan
         tpPlcKkmLCBrtfm+Wxij39MsfZGebn9JqeN2V3h9G4Z6z5fpQm0HJCKnRufYwhqiUC4/
         eO76Xlj71R6M+X4b4hbqUXSzxUiDHYmrXIPoWskrN56PQnySZ58fk8dl0F+JS5nhU0m/
         Jsw4WOAGlKMw2Uy99wEKpV7+VhRWQiRYNP5zAeJqtB/50bmlKsS+ZmuQQS61XcPqSwB1
         bB+OKW0rMDFedip0xHpcKBt/KLJkFPRhh6j0jpDKfDadyV19qxbhDUB3exC3RkpgeQ4M
         xGHg==
X-Forwarded-Encrypted: i=1; AJvYcCWR6P64gUAmyc9lOj4XEMfHFWsGaxo63GvaveI76hTQXxlWwyHb5ot5wdV9dxifbRS0DSxCVUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQLvmpKvYig7SIg/jkds/LYcEhDHCtqqGdJHH3Mnlcfn945Ey
	OEWxrdXs530zDZwhB+leJXWMVwCMUi+EZ/sRGUJ4KDVuMeEsN+ZuGGmX6/UGQnKNYMGO3PQ4zaA
	U7Li/eTGSJJnHMogmExsX+pClmz76cNwbR8FFLZADxYo3GafuTRz8CW1CMyxPML4ht9KynLU+FQ
	5gvMI2hpZGEfPGhjyxOEXy4mHO7pme
X-Gm-Gg: ASbGncsPCVzPe9BYYYTcl/bdVAYAqK3YLBdGRYKzWerH6tZOGvSuFptiYrOxdpfpU/y
	10kgD6wBd1ak//GqJRGvDb6ZMOeuTmXU=
X-Received: by 2002:a05:6830:388b:b0:71d:576f:29e4 with SMTP id 46e09a7af769-71dad4adba6mr6442249a34.0.1733324020845;
        Wed, 04 Dec 2024 06:53:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFS0oFHuIGv/zbXpCZrw4VpD3aJ8iYW3+nmQO54xHnhiT/5bN8TcEUROIJsrOy9LsBSbug6MeMRE0DrorOzYI=
X-Received: by 2002:a05:6830:388b:b0:71d:576f:29e4 with SMTP id
 46e09a7af769-71dad4adba6mr6442234a34.0.1733324020668; Wed, 04 Dec 2024
 06:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733216767.git.jstancek@redhat.com> <20b2bdfe94fed5b9694e22c79c79858502f5e014.1733216767.git.jstancek@redhat.com>
 <Z083YZoAQEn9zrjM@mini-arch>
In-Reply-To: <Z083YZoAQEn9zrjM@mini-arch>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 4 Dec 2024 15:53:25 +0100
Message-ID: <CAASaF6wX1GnXd3=Ue-yuCgGWNgKLy1+ChkydvYJ0dODBtcJL4A@mail.gmail.com>
Subject: Re: [PATCH 1/5] tools: ynl: move python code to separate sub-directory
To: Stanislav Fomichev <stfomichev@gmail.com>, donald.hunter@gmail.com
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:52=E2=80=AFPM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> On 12/03, Jan Stancek wrote:
> > Move python code to a separate directory so it can be
> > packaged as a python module.
>
> There is a bunch of selftests that depend on this location:

Sorry about that, I haven't realized other places it's already used at.

> Perhaps we could have a symlink to cli.py from the original location
> for compatibility with existing in-place usage. Same for ethtool.py
> and other user-facing scripts.

I can add those, but I'd still update docs references with new path.

Thanks,
Jan


