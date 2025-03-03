Return-Path: <netdev+bounces-171119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C10BA4BA22
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE757A32A8
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1B61F09B6;
	Mon,  3 Mar 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbXez3SQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA61F0992
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992169; cv=none; b=TDdw/4BUueKPAdx49HAeCJQShjXxWle0/GzhoRsNYbSz2GGQU3V0jEXn/DvsBtTu0MoiagX0nTgPirFfULQVlGoYzNEZc+AdnAl1F5kzMh45VarQ8az1Ka93PpZj0ZgYh6GQzlrKhySGiwl7FD61vKZS0kmPkqPXotSnjcHJZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992169; c=relaxed/simple;
	bh=orwP4tnONxacLwUNmWXwzbGa6lYQyU6GqCktPe2Q/5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNOE3dKEYAHzJa2+q81WMQAwks79n1a54xkoS5tghe3E44qZxsLbHqpLTphh0yKtOMpv825SGbZaBt91WXDXN3MdA/DDdEP8Yofh3Ur2zHb2GizuxgVLrl5bvBZg6gmdDS63NqkLYqu1CL0QpE9bFjxFHLy80c3FK8D/2nwc6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbXez3SQ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3cfcf8b7455so46020115ab.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 00:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740992165; x=1741596965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orwP4tnONxacLwUNmWXwzbGa6lYQyU6GqCktPe2Q/5I=;
        b=PbXez3SQPwgZd1lXVCpk8Zu8K6d0JbA7sEeKiYzjJscNlW1YLLc1CN+kg/jOXZJoCS
         o88Z/A0j0W3ZLvuabwArRg/aV7wr3f1Eqx0weJtqQstT94STI7VU0I1l8PUBsBAguaYT
         DohqqC8ZiJ1dzwxmKemzwqeQjVV/FdjW8SFGIq3gbRkqAjU0m0qOqLMqoeKlt1FiZk+K
         O8iyhD9NrXDnS53snXgQsiq2Ba4gsMbEx+ws/xXEd4lTSaCJTMFmH55xTegu4X/9KkWG
         9Kn8Jt4URo8xvzUq64U1QdN+xXXbcwyAbxq1XZ61lAaICBqXmcnH1V6LLA45pJKIbry9
         Jakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740992165; x=1741596965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orwP4tnONxacLwUNmWXwzbGa6lYQyU6GqCktPe2Q/5I=;
        b=j22RZtsh89I9NCKBH+fGtQMBBJVd8T97LcgOEjyJV2AV1eOqENqqWh/dI7nLYfMybK
         TVpNRhJ8xVyJvtw7AUOLPf8O//CrIQS6d75jF+tT604f7djZFVP6MPkAvPxtmWlQl/E3
         Nv6vBl45h4tjJVuWVv0W6PdIu1z3kSbWvVMe9jjQlJHxjgObkD0OiZI6rIQRGQfWdp2F
         HW5vAZz4efYsm03i7At5C6rp8aDJLi7ibf036/if2F7ppUPdZEf5/Jom/ga4z5Q8OOfL
         SXBineaCEkDHFXyXiVz0EOxjgIXPzKaoPgZIZG+qGk2bBJYh3+5gz1BCA5mi+KlBSeNk
         V9cA==
X-Forwarded-Encrypted: i=1; AJvYcCWXpNWVvppwVKqLISak0xQVLB7M6kM0Y/Rd7SfOdSX0H4CRox+Brprjxk0Xkea/DXlVT3UVvmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiY/Tg5uS1K8hUROwa6idwZEXcuwlJcG66wzduH3ND9Rtd/Po2
	ijlSg6S1uOPuHtapEcDmFF60nRRKsEmq79VHPCF2ZyG4d6hZCtaiCPv+AtFQKmWeB4wtYxhq84s
	PJT+cEnKOeqzm1w4EzXEcGEWT5qc=
X-Gm-Gg: ASbGnctEPVuEIurjz6zEeYNu4wdf4Djjlg4Vx9+okOvQRiS73TH0uZLwDd4Uq+WDmiQ
	zPm3ZlykQhJB3S9UnOOD+4yT8IbsXfR62qDS1S19iwQi2P8CHm3wQa8clT5vAE3jLOrVKByndHu
	r6sOPEQL8NS+1l2XPgaNP08wfrew==
X-Google-Smtp-Source: AGHT+IFfxP+8wp882qgkG8emRgzmHvQjZnLLr0aQ8zoUTpU3YCe8cARLBdxnMfAvYdv8Hj5gw5sIXjM86ajFrKyiXZ0=
X-Received: by 2002:a05:6e02:1847:b0:3d3:d965:62c3 with SMTP id
 e9e14a558f8ab-3d3e6f4b60emr116084635ab.15.1740992165651; Mon, 03 Mar 2025
 00:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301201424.2046477-1-edumazet@google.com> <20250301201424.2046477-3-edumazet@google.com>
In-Reply-To: <20250301201424.2046477-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Mar 2025 16:55:29 +0800
X-Gm-Features: AQ5f1JqkPshpGSKIx0z_LYKYazLec4ujrGmgFIFFongwn5gbvrrAEimaKf6KqKk
Message-ID: <CAL+tcoC7UVqc0oCEfast5r9oYr9KnMiKc7ZXEodnQYtidiNRsg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/6] tcp: add four drop reasons to tcp_check_req()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 4:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Use two existing drop reasons in tcp_check_req():
>
> - TCP_RFC7323_PAWS
>
> - TCP_OVERWINDOW
>
> Add two new ones:
>
> - TCP_RFC7323_TSECR (corresponds to LINUX_MIB_TSECRREJECTED)
>
> - TCP_LISTEN_OVERFLOW (when a listener accept queue is full)
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

