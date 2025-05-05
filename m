Return-Path: <netdev+bounces-187734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC5DAA9409
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 15:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED331887D1E
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEDA22A4E7;
	Mon,  5 May 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq5iKNY/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDE1F417E
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450527; cv=none; b=Vdmi6iKE6zKEYJIiYY/7gPYeh4S6HbYbx7i14nJC7vOfVkJe9GDyKe2W/6G2D0v/OZ9a9lTe5JGYJt9T5QHfSKIijtrvVmRzehLOXYbjTtowGJnXuWgTQwB13B3WUlKTjw/S5MutOYq4Rnlepz98ekFgnzLW/bATczmY1RhWWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450527; c=relaxed/simple;
	bh=CcTxzgBbzI90f+wN0JcENM4jZ4hoxOhLzv6DnmnMc4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLPS90sl//+5VI4wZTTxLK37bbJF7K7oFrcPn/ow0xIutkTzOIFsExT/1tYYHSrOpAxpmSjmPi5QFPLghZX9qTufnow22Cix9rXA0qcZ4jZvo10vhzMSDMxpIyB5taTtUTlekX1WCQ7nzsd49nXYOcA7RTI4lB287V1DHIQ1Ba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kq5iKNY/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso11784a12.1
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746450524; x=1747055324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTxzgBbzI90f+wN0JcENM4jZ4hoxOhLzv6DnmnMc4A=;
        b=kq5iKNY/AnIUtVknlPT/tz98zm4MSOGfJnLvMZH5/eXGakKynlE9gEdHx8ZEJHpvbm
         nRNIruInVpmfJt2my0CZFwVH/9hrFAqp6vxR+vbgNQT6OAvKXDurcpbFdiiKUQBbHOlm
         6lgK9imDnlBKKa7RsE6DswQyetBWo6MVlxy7HcwAnk01VUsGIB263xLRt7tcAIJbYFMT
         A9uNi7TdPvRYxw87Epu9uRGBL7Zae4geyq10K8jiAl7x5nKvVYc3yDklB/jssV2IxZoN
         YO/llfhEmc1//+pu4h5h1iSRwW0DBsdkTJo/+p3/lUBVfdwY0rRM3CvCcHcF9hquimbZ
         YvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746450524; x=1747055324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcTxzgBbzI90f+wN0JcENM4jZ4hoxOhLzv6DnmnMc4A=;
        b=SoHuSgjwXCQICXLOthPFU2wg1mGWNVo6JPxzlpBmD3M3pUjn1qF2pykn+r4IpTfrtj
         /c9GPjB5t4/F41aDbX4r0SuhqQiGOYf0Fb2GwfrgkYaIZLjx1z3Ic8QfOH0GVZgsCuo4
         lf3dao2txD9oWzCuViBr4g0t+/blRSGB7UeATaMSyK/7hM7mbZVZ/aNmrCJAOEnJKiHK
         Oup9rBduaQn9AB+bIGSTsIjkuv3vpUn1zc6BGTeRMOafQr449ltIJXX3QVenO7lcqNIc
         mpdurjajE6sLEYrw0yzZjHxA9iUhXwc9i73PcHWZiks2JYMeuxhPYr7XN6qz651IoFuG
         +rJA==
X-Forwarded-Encrypted: i=1; AJvYcCVoku5FlBL7Kbzxf54D1fSeep+jDHJqfbfGBM5Px2QvZjSN9NFn6rCI5aK69koC2KfZVnne/oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFoDc5S6Gw2oOGbx6h/lyPMarM1AhoriDqBYqs7v1UGz/5HiUa
	O6ixhbPPtA0/VLO4c0R76zt4GMaGFEOdWoF4uHN7HWJPIgsVB9dpdsz5cJYfHvqS+E3bSVpyawB
	ip807SnBQelo+rmvqugtleY2MbwRStcTDWBap
X-Gm-Gg: ASbGncvSmd1J1EQcD25IlLU9zmbARCC/QJlW9zf5uiCq9Ghy5jugcf/dxGevlxIXPfy
	YD1fEEBp07HSnwL5k7/FaIVcnrQCls4HrBWNZHzkOtPw3O9+10BWag/qJNicejCPPuMj1trWiTF
	z7h5NVWiLypm/HAtjWxcWAMws9KgAcYV3oshTviSAX8eG9ZyJ5mw==
X-Google-Smtp-Source: AGHT+IFX1jZnIEUIqKHTcho7yIpvOOHBKxzhoHPTnmaDdVP2OafarV7bS2cZO9snYNbMzLKCcMCds3n+Ecp9RGACrAw=
X-Received: by 2002:a50:ab11:0:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5faaa1f2701mr123881a12.3.1746450523693; Mon, 05 May 2025
 06:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org> <20250505-work-coredump-socket-v3-8-e1832f0e1eae@kernel.org>
In-Reply-To: <20250505-work-coredump-socket-v3-8-e1832f0e1eae@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 5 May 2025 15:08:07 +0200
X-Gm-Features: ATxdqUHIxwIoIqV0etAlWQHM7DrrKMZU_RnaVc88wfMW5gzzGzHJfNE1OpkPS5Y
Message-ID: <CAG48ez3UKBf0bGJY_xh1MHwHgDh1bwhbzMdxS64=gHNZDnNuMQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping
 tasks to connect to coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 1:14=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> Make sure that only tasks that actually coredumped may connect to the
> coredump socket. This restriction may be loosened later in case
> userspace processes would like to use it to generate their own
> coredumps. Though it'd be wiser if userspace just exposed a separate
> socket for that.

This implementation kinda feels a bit fragile to me... I wonder if we
could instead have a flag inside the af_unix client socket that says
"this is a special client socket for coredumping".

