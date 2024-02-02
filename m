Return-Path: <netdev+bounces-68476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5B6846FCE
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F7029AF0D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9554D13E227;
	Fri,  2 Feb 2024 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="L5v+v3M9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D77613DBA7
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875751; cv=none; b=O4IW0TCCDhDbWVsiZK/L05jfhHQ8/q5KbfP9a7lUGdxOgUUHs7ciUnuIAHXEFMBjm3PXN8ZMo733HkgUd9s7S8Z1d16fJ3DWTcNFKj+rbesTNP4bLblR2Wt7yjN5ovhZ6h6qDamzqW5/Q1uGX6AqBQQzEUyi5n/v/tcpA2PtToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875751; c=relaxed/simple;
	bh=JdXHnaxSlUG4lCn/hHmhxnFUyW8fLoBCfTyNCMHLlMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTfhtIQUP3dh3qvlwbvcT8ZKJcwqDREk7pQ9jrgGqFwzrsVDfVRPZ0TidHUP73cj+OIweFoUaT2U3Pp8mM67IxGYxOHm1wO0pat13ARVIVvsGRtIqrXNrdX6Zwj1/A//aLjt5TqNPkMDXdpi/1kJ2BPiPJ0OfvxdIE+s1IGjSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=L5v+v3M9; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6c3902a98so1524239276.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 04:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706875749; x=1707480549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCzYgWFLn+wJYfBQdVf8QJaNMHS5LBS3qk/jcDUWQ1Q=;
        b=L5v+v3M9oA3A7o4D84C+4qzJx7Ie8rfbk0iJFCo13kMEpLmol7Kqg+UdTiEKGaafhi
         EPYCXCbPUYCns68BL3rZbersr+MjgtmKDZ8PcPkb+uWxzzNcv6Rwo5YGCSj8ToUgKB6S
         uw/Tkiq2QflsKVWgARiXNByG6cNvzWWBpjAAVDo2U8asLHtAYq8GxtpycPx5xl+vdttn
         QSIgdizddIIFFcCjqkCQTNTscLVUN1NOc3yJsgMQ66K3bZHakp4eCSSZ8Vz4luZQ3Jy+
         luPzwY1/Hiu1KrPpsOGfHhBMzuD+52ITTBWmkTJKsgYa7oGTn88BdG8IUHrHW9EIs2Vo
         01FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875749; x=1707480549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCzYgWFLn+wJYfBQdVf8QJaNMHS5LBS3qk/jcDUWQ1Q=;
        b=W87NpSOjIw0J4Y2jkSphCaXvO3md4Jz9msSgJkbvI6HaoWCWuVT0u5dh/O6F3FkaY6
         uumUajjJTLwranBQg+4ffB3C34DoUdAoidmQSTq8ZDx9RGa/yLNWeFW4bob7uSax2Q5F
         PpUAGr7eUFcZ81yjMaYs9wbRklv1/jb+WWqwm1vCJjvoSiR7M6sbF9avrSWPwkoJAwwC
         Iq62sKWhpn0FKccMti+7Zkgr46p3yOHPIRnN8BEA0ElfEXXAPPOjD1VXUDwk/rK/V9gs
         5//7Bcc0jueh7lh7RZiIZuUbCburfOikRm3rFR5A1xeDxmeJNMgiOraGA9LkrwLQlf0L
         wkBA==
X-Gm-Message-State: AOJu0YyYbEbqvkdedMX1vlp936SlcKnP+7GHM9B7KMJUUsKuYOC0ZAMX
	M5r5ttNdk5j9R6XCleBjH26PUI8YI3cpSWKYl3wfOS2SVBvFbqYLqbVkndps/AVaHasvN9l4iJQ
	lcbWKRqgDhpwCv4mDfq8UuH+zXC0fGYdlQqj6
X-Google-Smtp-Source: AGHT+IH217StbCLCb7zizD7hEGFVa8Da616IWiWukuRHa7YUyc7tHGvpPCtVM9RcwPUfW8GFI7wghufHRypNuQbDKs8=
X-Received: by 2002:a25:8742:0:b0:dc6:3a84:2aae with SMTP id
 e2-20020a258742000000b00dc63a842aaemr4974466ybn.42.1706875749096; Fri, 02 Feb
 2024 04:09:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706805548.git.dcaratti@redhat.com>
In-Reply-To: <cover.1706805548.git.dcaratti@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 2 Feb 2024 07:08:58 -0500
Message-ID: <CAM0EoM=Fy=P_Pr=unThvFkxvOU30V-1PD1UYXQaEQvVrZVPwSA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] net: allow dissecting/matching tunnel
 control flags
To: Davide Caratti <dcaratti@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Ilya Maximets <i.maximets@ovn.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:53=E2=80=AFAM Davide Caratti <dcaratti@redhat.com=
> wrote:
>
> Ilya says: "for correct matching on decapsulated packets, we should match
> on not only tunnel id and headers, but also on tunnel configuration flags
> like TUNNEL_NO_CSUM and TUNNEL_DONT_FRAGMENT. This is done to distinguish
> similar tunnels with slightly different configs. And it is important sinc=
e
> tunnel configuration is flow based, i.e. can be different for every packe=
t,
> even though the main tunnel port is the same."
>
>  - patch 1 extends the kernel's flow dissector to extract these flags
>    from the packet's tunnel metadata.
>  - patch 2 extends TC flower to match on any combination of TUNNEL_NO_CSU=
M,
>    TUNNEL_OAM and TUNNEL_DONT_FRAGMENT.
>


For the patchset:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> v2:
>  - use NL_REQ_ATTR_CHECK() where possible (thanks Jamal)
>  - don't overwrite 'ret' in the error path of fl_set_key_flags()
>
> Davide Caratti (2):
>   flow_dissector: add support for tunnel control flags
>   net/sched: cls_flower: add support for matching tunnel control flags
>
>  include/net/flow_dissector.h | 11 ++++++++
>  include/uapi/linux/pkt_cls.h |  3 +++
>  net/core/flow_dissector.c    | 13 +++++++++-
>  net/sched/cls_flower.c       | 50 +++++++++++++++++++++++++++++++++++-
>  4 files changed, 75 insertions(+), 2 deletions(-)
>
> --
> 2.43.0
>

