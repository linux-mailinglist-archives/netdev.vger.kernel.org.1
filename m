Return-Path: <netdev+bounces-128018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE897779F
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F83A286F42
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADDC1B1D5F;
	Fri, 13 Sep 2024 03:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK8Xr+1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF081B9829
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199780; cv=none; b=SGzkXFvwzCgF3Fw4D2KTMLx1yEY3xGFhvmlpHJuhrh2g3OCdqmsZqdO055Ws/RD9KgyOWKzYLfpilM9nWjnWCR3N+SovWdlzJuK218vErivwBGA+PEEFaXOwpfYleXRkiayokcJA2Y/+yGm3nwOrEcmjG18BmTx9B+OAPv87huw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199780; c=relaxed/simple;
	bh=ATXdjrnglcg5+NKHWpj8PbWEWAqJR7uhnMaZmJ+0nQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXfXC9DeOwCI8Nl6qwAUhCS3T6Mwma6YG1ftrgyrW0/AXaZK5YQEx5nXDszCfSFWyRsXkvIGDkXOTboR1EqMj03Q/ux7RShdXoJLr/rYOpF2pjXrzcU94pAkqtWetzyju4AWjt4aAbLW1zQvEkPnQQsVGHF/4xB+tiU2VMJYDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK8Xr+1X; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39d4a4e4931so5580565ab.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726199778; x=1726804578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATXdjrnglcg5+NKHWpj8PbWEWAqJR7uhnMaZmJ+0nQA=;
        b=RK8Xr+1XB8kJKiKtfXMKUapUuavike2oQeMPG+MFIRI9CPiQhzE7mPBm0UE52jo6bc
         WJHbpIAdyiGximGXRuXIq1IpQRGnmmIekZQXHQIP2i3I8Sygk7CU3CqLn23IAWgMA0us
         5Sz3VGs7qZUtP2nvw2V8fkyyL5Vk/F0Yg5K4mwx8CqqGHNIsyc06SLmuhqsKy2GsQf3v
         xNfT4yT6f6+Q5/CoPgtFV/20p5TDTEOJMbBaAGKwoIeJRdfGzzAC2EyJHLjQ90ci2zXe
         w0sdv8rVuywCDB73YMXsH/i2wnzCd6XxhjBWoTXTWZJ0ReJIEj7FY7A5ncXSeICPeoTo
         qRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726199778; x=1726804578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATXdjrnglcg5+NKHWpj8PbWEWAqJR7uhnMaZmJ+0nQA=;
        b=BP3X/2VfqmzyW4bkrQjkeYF7AyIQ0is2ZBh4goN5CXW3wQpSg3mdvfHslrJ69ltaH5
         YcWth8eOzPWMqR+ffBfVWGTDp1YvpmgWONyCEAZl3Lv915IIEMQMc4zVfa0C3luNjPYv
         Kij+uR+8CLEpzyrvbKEWujAL/y/KzGxLygHr3GB/Aq5dkBHtya693FNo3rGF0MsvFyIQ
         G4xjD4PUYTW+t2Tox9kge70/H6Kx8hdXzkWgKj5jm/onRP9aZgBKhjdOvv6auyndCof0
         5ROH9xUDLJTPU40k+IQXag4EEXQF25VRYvMRUxKANd1FfAgdoskfeWsYuJNONKWHlVMg
         bcxg==
X-Forwarded-Encrypted: i=1; AJvYcCWeCvX2OUHY19AXppm87zY1U54UZFENNCCGZiBQeFbvn2CsSmuBxJr7NQBwIjDrKzIbWyCMWFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQVQaN1NfgQq3VtRpJzMyd4unj4KaZkJhR38kj2TV/tC26n6r
	Br+v0KGCEgKT3RBjkRmaM3gV3/hsxZ5iMmEpBqnvIzBGzWH9DL1sO1BEJuFGVaDvIZ6ZkWgSqA8
	JWgIbmadKL4sDHESDd1fH536JmWg=
X-Google-Smtp-Source: AGHT+IH/hEeYDgFw65FS8G36xxN9GK/qRGwt/xVB/5Py7l0zfB1Qy8QrJPXs5qBO7ThtfFicPV/UtuDK1St5VdvvBos=
X-Received: by 2002:a05:6e02:154f:b0:397:a41d:aa8e with SMTP id
 e9e14a558f8ab-3a0847cea2dmr50556355ab.0.1726199777746; Thu, 12 Sep 2024
 20:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911091333.1870071-1-vadfed@meta.com> <20240911091333.1870071-2-vadfed@meta.com>
In-Reply-To: <20240911091333.1870071-2-vadfed@meta.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 13 Sep 2024 11:55:41 +0800
Message-ID: <CAL+tcoBGHkuv8RKTtJVjyJT-8V329CrfLHafdOv3irK04sZukw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/3] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 5:13=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> timestamps and packets sent via socket. Unfortunately, there is no way
> to reliably predict socket timestamp ID value in case of error returned
> by sendmsg. For UDP sockets it's impossible because of lockless
> nature of UDP transmit, several threads may send packets in parallel. In
> case of RAW sockets MSG_MORE option makes things complicated. More
> details are in the conversation [1].
> This patch adds new control message type to give user-space
> software an opportunity to control the mapping between packets and
> values by providing ID with each sendmsg for UDP sockets.
> The documentation is also added in this patch.
>
> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9=
Eaa9aDPfgHdtA@mail.gmail.com/
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

