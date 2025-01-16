Return-Path: <netdev+bounces-158901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA5A13B26
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B833C165E58
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DA522A801;
	Thu, 16 Jan 2025 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLeTiPJe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493D1F37DF
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035480; cv=none; b=PbrnUriqpwgPQpXhA4I48ZWeLEzmlI7/ed+LeKDmbUK2gK9rl/3iF3l7EILONgj/b+AH9bR9Fq5pqZX6U6TY2z0pFTP4De+Is739i5LPHPseiK9us+aWRykdVuAxoO7Kq8+yfmU7g59J+F/6l8mulOYFnaGy/N2qjrG0Ah872n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035480; c=relaxed/simple;
	bh=qNLhPseTfvfnrGx3PuQePTdrPtb7dP4K1mmUh2cou+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7d+XcrHhHVt+jqCxI/ug2o0B+DZiW8w4dnUEgr2OcZMDduGpqgH8PniXD9UhdRolfkc6KFyvmy6DUcF7aOAgam1SNQjxwXUaXe3jO6fnRlDuK3LFWPGh8zb/iCQeJgSHd+yKC1xy8HGVx/AWW/7Lk6bFUL6ksWzB+CvVrPyjKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLeTiPJe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so1963851a12.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737035477; x=1737640277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNLhPseTfvfnrGx3PuQePTdrPtb7dP4K1mmUh2cou+Y=;
        b=bLeTiPJe9QCYz/l2t9zZUqkwD30asEq+wV6zD/DVVSPNiS8M6ciABb9mqBcwkv15X/
         RqADNFBbXl9BZ4ek99VnNK3Lk02XlxWkFO+eOUgNuouxsmCF1Aggyx/8GVZsvRf05bes
         rrSHRMLlJ9dBDvO5WVUT38WTKPPo//CsNjrA4GwsHIdTsvCO7Ef5pchH7oBc270M8HoG
         9nuGlT6zf3Tv1cmjbcPBdxIIRa2SedP5cvdAquj8maryr7Z8RGY72BAbp1KcHb49Miey
         zBPusiAIkfRkg9OHF0GG36cN/zcoeVR9/XjDqMjlpOKKsL8YfqcwQWsjfvpaPyHIj377
         ZKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737035477; x=1737640277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNLhPseTfvfnrGx3PuQePTdrPtb7dP4K1mmUh2cou+Y=;
        b=ktinYoA3eOW3wDtv8Op8TFncQYHHGjNQWhDrgY/gvYkj6S+/DSHAnS8cDTB0EUNu8P
         MLzmjmRvT9V+d3BNScyEGaFhuE+vyF5qTJzr2x4d7GLAikneuBky6MX2EGLB+QUoHUCp
         u/DkYAzDzys43/pnvKaY1eMr3HwLk4HImpAiRxockJbK0AWZMTtpYdTK0fT2a5uEdqS5
         FFG8tDhD2rIIP4UDTONEY4QMUIubRF38t824q8Sc5SFEF37e2O8KqWgXWu+CvPIewJRM
         3si3v5MSFcLF73DHD0rq0jOyUcS3DCPkNSOemFDePV2RsyuqTJyILtxaga1gWk3sfkMj
         NTDg==
X-Forwarded-Encrypted: i=1; AJvYcCXBvAhILxh6Xm4qH9nNUGtaMKvW3Urg/pcikgz6DVSVaTTqE9lXeeiIkWwfOnpjzFwaGxbvFJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PH/PtawKTiwswGSjAzBxeNasMvhsbZQgVC/oU7kHHr9p7eS0
	868P2INLv7/B8TC+a+XbbqOIU0pVye3V8+LRi0h16uEy9ORFZRboArvBml6K3zCF4WgOopCXKR1
	AufI/h5U7eiPZkQnaLC/XKGdif3IIQQ56dYnH
X-Gm-Gg: ASbGnctSBn5MCEEBZ7AxMBxmL4eYmMPQEbo8+ZZ0bgCYX4fpLlmsGFFHBHrtgzj70cQ
	WIot2R0llCLc6gxjB+8car9T1LhZYfzi/2oZ6
X-Google-Smtp-Source: AGHT+IEtReXnldTm1Hjssz1tb1eLK7md7tV97HcI8JfIh+WsZrFAgIQvHZEGQS8T5E/fvPkOUUVxCx8m9fgCnTRfDK0=
X-Received: by 2002:a05:6402:4306:b0:5d0:c098:69 with SMTP id
 4fb4d7f45d1cf-5d972e13643mr33435003a12.16.1737035476495; Thu, 16 Jan 2025
 05:51:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <208dc5ca28bb5595d7a545de026bba18b1d63bda.1737032802.git.gnault@redhat.com>
In-Reply-To: <208dc5ca28bb5595d7a545de026bba18b1d63bda.1737032802.git.gnault@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Jan 2025 14:51:05 +0100
X-Gm-Features: AbW1kvaSPhZoozSV3Y0s6GwVaZM1IAsIYh3kBw9yoEN9KYOTuZufMEUzzkJ06mc
Message-ID: <CANn89iKY6Gww84HphTWRj2C3TPa6hs29+SA4gfwN5+JTsf--GQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] dccp: Prepare dccp_v4_route_skb() to
 .flowi4_tos conversion.
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	dccp@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 2:10=E2=80=AFPM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> Use inet_sk_dscp() to get the socket DSCP value as dscp_t, instead of
> ip_sock_rt_tos() which returns a __u8. This will ease the conversion
> of fl4->flowi4_tos to dscp_t, which now just becomes a matter of
> dropping the inet_dscp_to_dsfield() call.
>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

