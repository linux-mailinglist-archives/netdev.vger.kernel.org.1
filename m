Return-Path: <netdev+bounces-82921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D112890323
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257892926B6
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF012F384;
	Thu, 28 Mar 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTc7SKP3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D85917F
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640119; cv=none; b=CpIgVx+gjZRlOEtWs2cr8mz5F9p/CiY4j9GpnxvINM5Cxnmg+Ezr4dClvRxvvWYR+AzENEmshJH86Bqa8eyD6i22mGBXdqJge1qOEqd+heNyuP3x3vCmpZz0AeyY9Tnz5Ek1RS8xrw89Rtl/x9Om3vQI+D+XWMKDPfTTkwlqjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640119; c=relaxed/simple;
	bh=lgxgdYqATTmqx4Maz+fNM/fbjmDidDF+l7fOFfZo1v8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Ak2MyUHAFxNYp/doVR5EeESUZJuW9zNKF0YchyMBEahk5RvJ86hULdJOjVsi8tPmmEjJDY1TwC0X1U1pXjZZTGcGZViY8Yx1bCb5WNkM5Ffre3CI+0o9716rIT3eSkAVRbpXEiPqOpM6fPHf28eqR8aAFgcIWkzC1BSwvTwOCCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTc7SKP3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-341808b6217so663141f8f.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711640116; x=1712244916; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L+KdH1+O3S6ienwS38m2KEffLYN6XW6D4Qvi4jXmZy4=;
        b=bTc7SKP3HNhcAplSXoZXfkhAs5r2HqENnHqC6JhuWSXusXcP7bz2H9PJLDvlByjTEH
         ZzSoozuJm20q7IBvZLZYEi3e/WBIXmPv1lVrpUjfjpGHgXv/oNof3WZQjNULhrggMASg
         AMtH+ZfKZr3gAtpZiUxfeyrFu6Ri66J/qxjxHPaZRyE332nh9Z0Ok+bLRwANF1jjdtln
         iLY1/2BVguwXjnnneme3H/GG3PmdazmxgXJaoLq9jNKgq/Rd9kb3M6fkEyocZlGc/MwC
         ijE0Onc7aFlaKnBb0NXsFfHiDy/bDbg0fiMmjp6dVqnQj2KKYl0ZfEtPuS3Ozs335UNz
         z07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711640116; x=1712244916;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+KdH1+O3S6ienwS38m2KEffLYN6XW6D4Qvi4jXmZy4=;
        b=xDgOwixQlJpXGezB/7fcB178m9ilE3BCdGGowkqzRS+Z9scf5UEjChDoO9Jwzv98vx
         hzMGUtwtgYFwLxY2n6tGiqJX0jLfsRzgZqfnH+xVsuVDJGVBNAGhpla24Qc1WkF8I1lW
         H0aiz7ZIHWm25REwrfTv+tJ2k7UvUbH+En+/uBpqMhp6nD1jBtR0cHgrcnREhjt9KB+i
         qmOFHzECtBoV73i9RMuSVSQjbDEYz64vAkY/M9+dicfR80WGbytxObo1SUBoIKpvuz60
         oW6S8y2X3mgzPkFvm014THK0CT5oYgcC6V9FFLqkJYwFvEL4rfUkYFcvPoF+bv66soY2
         NXjg==
X-Gm-Message-State: AOJu0YwN3PoxIkZW84+J50RqiLZhGwsRf+2e0vMXkDDDnnslAyum7O+I
	02uLCkZchHkB2yERZtEqn29klyYywml0GL8tMNk79hctAXgQLtPb
X-Google-Smtp-Source: AGHT+IEh77BNFZZdN7dAmRruRCLNkr2BMYozDepnCwZnzRqOvlIoJlHTBjxkOBFinbtr4ucttGNsOw==
X-Received: by 2002:a05:6000:2af:b0:341:b5ca:9e9d with SMTP id l15-20020a05600002af00b00341b5ca9e9dmr2758311wry.67.1711640116363;
        Thu, 28 Mar 2024 08:35:16 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:7530:d5b0:adf6:d5c5])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm2017686wrp.77.2024.03.28.08.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:35:15 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Jacob Keller
 <jacob.e.keller@intel.com>,  Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv3 net-next 2/2] doc/netlink/specs: Add vlan attr in
 rt_link spec
In-Reply-To: <20240327123130.1322921-3-liuhangbin@gmail.com> (Hangbin Liu's
	message of "Wed, 27 Mar 2024 20:31:29 +0800")
Date: Thu, 28 Mar 2024 15:05:57 +0000
Message-ID: <m2wmpmjt0q.fsf@gmail.com>
References: <20240327123130.1322921-1-liuhangbin@gmail.com>
	<20240327123130.1322921-3-liuhangbin@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hangbin Liu <liuhangbin@gmail.com> writes:

> With command:
>  # ./tools/net/ynl/cli.py \
>  --spec Documentation/netlink/specs/rt_link.yaml \
>  --do getlink --json '{"ifname": "eno1.2"}' --output-json | \
>  jq -C '.linkinfo'
>
> Before:
> Exception: No message format for 'vlan' in sub-message spec 'linkinfo-data-msg'
>
> After:
>  {
>    "kind": "vlan",
>    "data": {
>      "protocol": "8021q",
>      "id": 2,
>      "flag": {
>        "flags": [
>          "reorder-hdr"
>        ],
>        "mask": "0xffffffff"
>      },
>      "egress-qos": {
>        "mapping": [
>          {
>            "from": 1,
>            "to": 2
>          },
>          {
>            "from": 4,
>            "to": 4
>          }
>        ]
>      }
>    }
>  }
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

