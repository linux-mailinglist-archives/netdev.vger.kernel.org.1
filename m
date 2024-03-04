Return-Path: <netdev+bounces-77072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21328700C1
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88857280D1E
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F383B189;
	Mon,  4 Mar 2024 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zo+HMnDd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24239AE1
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553016; cv=none; b=p0E1/djNRrNj6zGGo2Y2mG4AvpQqYIC7LNYnzOKF+eXMBo/ITOEV29z+Vq/JSit+Mlh7P/vzvOhi8pMX60VXW4jwbN/V7+IdjnQIeys0yxM35Uc9Rj/mHd9GcCnSdS5ZxOFk+mzH96p/ikB09if0s8xtgGUY83GD7STUYTZWPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553016; c=relaxed/simple;
	bh=mJU5nUSzPa150Y2o3/O+RbOgbwdMmW8u0PeQCQN0sos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFK0mJAyUhXxo26Yta62UAiGtmrGIt9FXXbCSqz7Px06J0+mpBDNOGJ5H48q0YgVKCISwrfrSckNw5H7wJYDjS8OkIPa+fKkXlkTz+bciPUte/YmNHfRGJRytZIu7maXtz3e+j1VEapRBbCEUanOPFLV4oKSOgpziprTZm7YAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zo+HMnDd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso26205a12.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 03:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709553013; x=1710157813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJU5nUSzPa150Y2o3/O+RbOgbwdMmW8u0PeQCQN0sos=;
        b=Zo+HMnDdQAgAtgSmcp62dOO9G29r+sj41JzHz0Vx5ppgJT2yDp6MvDidxa8rg7i1wl
         SbEd3CMNywvstlOfKHFXE8ytSwFuRPjvZ6r07rT/P5kiTN6v2GFKZgfeRyxPzKNg8Fap
         5AqgTx8Jv+Bb2AAv+6yRG5ZiKsN/fkygWpK9dy4NkqraPIzKTnoxK+JwaUQAvzlbidFo
         ghEtDulVJKTuTpeVMX6oq+ZIYiNwNNAOdPaB/aWHmvHaIhIRDxq9WsSbMEtNZ0n44jyK
         O/E7W3GY1Jmc54e63RQDLUtHAJ+qzpqD7vMf4/bycUqtG1/FgS5Pfaq0Grvy++IOw4Ec
         7otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709553013; x=1710157813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJU5nUSzPa150Y2o3/O+RbOgbwdMmW8u0PeQCQN0sos=;
        b=ITyD86iQoRlYhbSrTOEKx80gAMH0DesfrppDe18k2+OaZmiaLjQOCkFzfNF3+jNPW8
         NQyn8YKA2wx0AF1hx0ypHWu89GfnrD1FrkVgPCvaVpsMQNhdpl/idfJS7+sRhlWna95Z
         PeqDGjXA7Trg3cSpaoB7PruDmpmFKTZB5Dg1ta5+0tqPQaXeVg8n78enTB3IwVgU5CuU
         Ku+k3Am5s4kYgxWPfpdhak7a25OCN8zkHlFtpFzdi5x9clU0L7B99uf9Je1Zx45v58bg
         gPBtHES8dwoZz/gNLNoQbOd9vgyapVqVwYXhDalKziluonxaOOplq1l5zo8qek/Yc3kw
         A8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCU7D7tW0ZhZz8YxeWOIsOGcVNOJdQ4EpQazXjSB+oYX/QU3UUdobb2k8FbVYDG+ny2URlG+1iXv5VY1xC8BaqbSWNFgHxdP
X-Gm-Message-State: AOJu0YyE9NTHOpCmJGcAnM0dpe66yZeGjVXpOACA62ciFLwSJTZwoowx
	1h4ZkhmOOBxsuynbDwu2/wgiIXXQClAP1sechmls8WoUT6kbx29VVAiGNV0k8pxXtQsRFyLvOC6
	1fs/MPaiecMOC5nE5eRc8cKeF4UHctMe+63Xk
X-Google-Smtp-Source: AGHT+IHGikDpAWPtkW1MHcYlpXQ+/3kLXkjdpmD5O5eEOjwLCn0HuYfwKgVPhe/cSnxiX0bo1EootWnAzHK3mn0uyYQ=
X-Received: by 2002:aa7:dcd6:0:b0:55f:8851:d03b with SMTP id
 w22-20020aa7dcd6000000b0055f8851d03bmr368842edu.5.1709553012918; Mon, 04 Mar
 2024 03:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5848BD89913195FF68DC625599232@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848BD89913195FF68DC625599232@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Mar 2024 12:49:59 +0100
Message-ID: <CANn89iKzGS39jLrRszBLh6BMyYykX-d_n3egdDU77z_fcXbiXQ@mail.gmail.com>
Subject: Re: [PATCH] inet: Add getsockopt support for IP_ROUTER_ALERT and IPV6_ROUTER_ALERT
To: Juntong Deng <juntong.deng@outlook.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 12:33=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> Currently getsockopt does not support IP_ROUTER_ALERT and
> IPV6_ROUTER_ALERT, and we are unable to get the values of these two
> socket options through getsockopt.
>
> This patch adds getsockopt support for IP_ROUTER_ALERT and
> IPV6_ROUTER_ALERT.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>

This looks good to me, thanks, assuming this is net-next material.

Make sure next time to include the target tree (net or net-next)

Reviewed-by: Eric Dumazet <edumazet@google.com>

